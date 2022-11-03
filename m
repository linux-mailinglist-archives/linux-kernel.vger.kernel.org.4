Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEDDA617B04
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 11:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiKCKqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 06:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiKCKp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 06:45:59 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1CE101F0;
        Thu,  3 Nov 2022 03:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667472358; x=1699008358;
  h=references:from:to:cc:subject:date:in-reply-to:
   message-id:mime-version:content-transfer-encoding;
  bh=w6pEypdeJ3grYuCDsIFmRS82SL3lEIiU7C9z4AK7pS8=;
  b=NWEnrAMFSDPNlq4swzzC9Jazxq31miyplpf0RUvCeOR3IGUkx8jtR0vs
   jrqb5nu6ciTlhmUg8k+VkCdoZCJgKS96SdS0A/RKO30FH+NqQHN6nAKpB
   7jbKx65mMsMQcXkyQEeVByIydnnq7AYXRAXedXm39UW95i+4ja1NHZANa
   45WUF9cFygzA6FXLHVvAECEXsMAidb+z260iln/4e37hkUNuWiIv9W76Y
   Zu1TMktU4RGojEwnlNlqMvmdtkhZk/x5uXvSKyudY84tLmAmJVtdM+03r
   an/ySF++BNiFsXBae/g17GHpkC6zCE0cEgBOomtwZxeIyZ/O3/UWfgBfy
   A==;
X-IronPort-AV: E=Sophos;i="5.95,235,1661788800"; 
   d="scan'208";a="319729550"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2022 18:45:57 +0800
IronPort-SDR: wFKRUiw+AY556E+TFIIwZH3a6hlE+W1U060FfDjT6UVPiC1eTN39iw+mhYaQJGDfC0BnyuzXap
 gNi8PqThFIKhqdCwwO6aIhAJnnD1+/SshVp4NFfKd2CZDzzPq4zdJWMVbEEwrRAcaTG9l7eF0z
 N4neps4W0jA2awFzbjUod97ituWp8tDAcvAiAxep4FUf0PrFLUMVyYIrDNEaEmiOlAkE7IfJPw
 EX8kDWjU2qZFgkc4QsQRJBBpQ3Swspd1+oeBJ6i4I4b0CmUQfTCHoq7y+tR8BoD7bpTEVZ6zKW
 Sso=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Nov 2022 03:05:09 -0700
IronPort-SDR: d6wjXHsxoTXXfCzCRNnxpiRHdvZ96lX+5AeLlQRbzXxWn6FC7ySGSFxD5Bgb/Oa1X22P5WtGY7
 XZaPFqVPFBlTLJrcoM9r1gghhB3uK5oSJO8kJ7JBRptY4GIl0gZPyAIbe+PLu1hzVRAhbfmuso
 okxzzNtqD3XWi9ksTL3E3ZYy+XR89YUANgWtleeR8gw5gvd8Rjkj+kXkSG8XjyUrd1+cZiSe/1
 xnqr5VdcI1BKpEYnuC7yGKA/4CCOf3Ps+JxHwarbNMRV3OB6+OEDA0kPLM58qYgj4PD6A3LFId
 yqo=
WDCIronportException: Internal
Received: from dellx5.wdc.com (HELO localhost) ([10.200.210.81])
  by uls-op-cesaip01.wdc.com with ESMTP; 03 Nov 2022 03:45:56 -0700
References: <CACMswuMVERF_+R3Qxb0xGHCBQUCuxtBLA+eDo__Coed3BoVC3A@mail.gmail.com>
 <nyfz0H8A-5nGCgsAynqZyYtFlEcvPHDecY6c8MC840zNNdEWz2NSPPuZgE_VS7RnrTwFhd6aCDi2TXWh6YtqfUeUEWZvFCT7HjpO-Z_UPCk=@protonmail.com>
User-agent: mu4e 1.8.11; emacs 28.2.50
From:   Andreas Hindborg <andreas.hindborg@wdc.com>
To:     =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>
Cc:     Dennis Dai <dzy.0424thu@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: rust nvme driver: potential sleep-in-atomic-context
Date:   Thu, 03 Nov 2022 11:38:42 +0100
In-reply-to: <nyfz0H8A-5nGCgsAynqZyYtFlEcvPHDecY6c8MC840zNNdEWz2NSPPuZgE_VS7RnrTwFhd6aCDi2TXWh6YtqfUeUEWZvFCT7HjpO-Z_UPCk=@protonmail.com>
Message-ID: <87mt98nwny.fsf@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,WEIRD_PORT autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Bj=C3=B6rn Roy Baron <bjorn3_gh@protonmail.com> writes:

> On Thursday, November 3rd, 2022 at 07:12, Dennis Dai <dzy.0424thu@gmail.c=
om> wrote:
>
>
>> The rust nvme driver [1] (which is still pending to be merged into
>> mainline [2]) has a potential sleep-in-atomic-context bug.
>>
>> The potential buggy code is below
>>
>> // drivers/block/nvme.rs:192
>> dev.queues.lock().io.try_reserve(nr_io_queues as _)?;
>> // drivers/block/nvme.rs:227
>> dev.queues.lock().io.try_push(io_queue.clone())?;
>>
>> The queues field is wrapped in SpinLock, which means that we cannot
>> sleep (or indirectly call any function that may sleep) when the lock
>> is held.
>> However try_reserve function may indirectly call krealloc with a
>> sleepable flag GFP_KERNEL (that's default behaviour of the global rust
>> allocator).
>> The the case is similar for try_push.
>>
>> I wonder if the bug could be confirmed.
>>
>>
>> [1] https://github.com/metaspace/rust-linux/commit/d88c3744d6cbdf11767e0=
8bad56cbfb67c4c96d0
>> [2] https://lore.kernel.org/lkml/202210010816.1317F2C@keescook/
>
> setup_io_queues is only called by dev_add which in turn is only called
> NvmeDevice::probe. This last function is responsible for creating the
> &Ref<DeviceData> that ends up being passed to setup_io_queues. It doesn't=
 seem
> like any reference is passed to another thread between &Ref<DeviceData>. =
As such
> no other thread can block on the current thread due to holding the lock. =
As far
> as I understand this means that sleeping while the lock is held is harmle=
ss. I
> think it would be possible to replace the &Ref<DeviceData> argument with =
an
> Pin<&mut DeviceData> argument by moving the add_dev call to before
> Ref::<DeviceData>::from(data). This would make it clear that only the cur=
rent
> thread holds a reference and would also allow using a method like get_mut=
 [1] to
> get a reference to the protected data without actually locking the spinlo=
ck as
> it is statically enforced that nobody can else can hold the lock.=20

I think you are right. The lock is just there to allow interior
mutability of the queue arrays. I could try to shuffle stuff around and
move queue setup before converting `data` to a Ref. That should be fine
as far as I can tell.

BR Andreas
