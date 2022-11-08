Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5C6621D57
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 20:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiKHT6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 14:58:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiKHT6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 14:58:51 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181EF61778;
        Tue,  8 Nov 2022 11:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667937529; x=1699473529;
  h=references:from:to:cc:subject:date:in-reply-to:
   message-id:mime-version;
  bh=QgCdfssJui03L08ul3DqCU8jgqdjYTj3Cy31BtbCjs4=;
  b=SueWZaHfnBSKUC9tLDPmWyzs0oBVCGlOx/01/OGrPPKMs6ZljW/EQ1Ip
   exoI8VZgGk95WAUgKi2bzobOIkfQqvmYWKWgWW3b0sNyfKJwtfGgWkSXO
   nEolJ2GDVpZ64iMvT14SCHkUsCzGaOHXKdAfKP4+v7W42rdpcYlNjT7+e
   hZfWDbx6beEFndm2YDysSI922HrEoWXqJJHzWI9CTRdo7eL1Rprfizxj9
   AvNXXqRIZzZxNnHwBksQ+Mvlg0PqGxXdmWvE+qXHnfqIT/tljMzn1oxkx
   7MhZf+vm3tcPYYsstW/OJcN18B4It+EReyOlC1KlvkfaCHphz0Olx/sOF
   A==;
X-IronPort-AV: E=Sophos;i="5.96,148,1665417600"; 
   d="scan'208";a="216129083"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Nov 2022 03:58:49 +0800
IronPort-SDR: N7S6kNy54eOf8KT1RlpQVYzBSv0piBa0mjnRf/zjHZZf7jl7vSEV0UU9ro16phsa5ksLhOuoGJ
 te2KsAlPCrLxACeSVZbq+SiQBnWxNHx5/ubxvalkG49HvnWUctf9PbszChcDgvFgA9rFSU6Z6N
 zjFxqB9NN0oJsf+DAyOMVmZ+7JS9MJL7yhyfMUOiUROaAvekD6Ub7OLOXsCCaxC0G8hEIFGIVe
 BjnF8+5tEDhDDNIHdyio+UEtCvf79fAzrRyxS+xgqqe9rvYiC2mmZ9xryQOTuhBU5f9Gce7Nqz
 t3I=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Nov 2022 11:17:54 -0800
IronPort-SDR: BH3/7vYoconA2sJzfIBqJjrFc0PRJ1Q49x8vm+7i5Q2grIZAZhB66v9QBkg9YBdwAtU7IVrt6X
 g/lVs6UBD+R4c67dbz8y3vJCpnmvQrpDqSKR2VLinNVSNnrjHWeavUQJSSCEclsuWzvFSxxyvp
 jhDXcrRfBK30MAuuCU3tZjEnrl32mdItWCWjWjm8WOP+v8AKIU6upnb9gueiOMZQP45gMDoA2q
 UBFc+8iAHlBZa4SKquvplhu9xkiJFYnXzuruerJZ1x66iBSrBoOXn8dmS/4pXwFP5+fHBIvUbP
 Pww=
WDCIronportException: Internal
Received: from dellx5.wdc.com (HELO localhost) ([10.200.210.81])
  by uls-op-cesaip01.wdc.com with ESMTP; 08 Nov 2022 11:58:48 -0800
References: <CACMswuMd18=nhvLK2Tw3H84GnDPnhuS_YRNFEDZ5T4B5DJQtBQ@mail.gmail.com>
User-agent: mu4e 1.8.11; emacs 28.2.50
From:   Andreas Hindborg <andreas.hindborg@wdc.com>
To:     Dennis Dai <dzy.0424thu@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        "baijiaju1990@gmail.com" <baijiaju1990@gmail.com>
Subject: Re: nvme driver: possible missing `unregister_irq`
Date:   Tue, 08 Nov 2022 20:30:52 +0100
In-reply-to: <CACMswuMd18=nhvLK2Tw3H84GnDPnhuS_YRNFEDZ5T4B5DJQtBQ@mail.gmail.com>
Message-ID: <87wn858bgp.fsf@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Dennis Dai <dzy.0424thu@gmail.com> writes:

> I was inspecting the rust nvme driver [1] and would like know if the following
> code contains a missing unregister or I missed anything
>
> // nvme.rs:180, in NvmeDevice::setup_io_queues
>         admin_queue.register_irq(pci_dev)?;
> // nvme.rs:186, in NvmeDevice::setup_io_queues
>         let q_depth = core::cmp::min(...).try_into()?;
> // nvme.rs:190, in NvmeDevice::setup_io_queues
>         let tagset = mq::TagSet::try_new(...)?; //TODO: 1 or 3 on
> demand, depending on polling enabled
>
> Line 186 and 190 could abort the execution of
> NvmeDevice::setup_io_queues without calling `unregister_irq`.
> In the end this could result in an `request_threaded_irq` without a
> pairing `free_irq` on failure.
> Or is the job done by Rust by auto dropping?

In line with my reply to the other potential sleep bug you reported,
teardown is not properly implemented yet, and I did not review the
teardown code that is already in place.

But, if you look at the `register_irq()` and `unregister_irq()`
functions of `NvmeQueue` you can see that the registrations are stored
in an `Option` within the `NvmeQueue` structure. So when the `NvmeQueue`
struct is dropped, the registration will be dropped. Also, if we call
`register_irq()` twice and forget to unregister the first one, it will
be unregistered when we register the second one (because we call
Option::replace()).

So as long as the `NvmeQueue` structs are dropped, we will not leak
IRQs. In case of one of the lines you point to return an `Err`, the ref
count of the `kernel::device::Data` allocated in `probe()` would go to
zero and it would be dropped and thus the IRQs would be unregistered.

So yes, it is handled by destructors that run on drop.

Best regards,
Andreas
