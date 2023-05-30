Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E58507166E4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 17:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbjE3PWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 11:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjE3PWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 11:22:03 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67D7B0;
        Tue, 30 May 2023 08:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1685460105; i=deller@gmx.de;
        bh=vTIHiQonw99HwoGqxwwqwXaUuoEBzUMMXLvJyYETUjw=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=qXtWwxea1BNr1sWzLPP19hX6sXKn10d0d/FCP8BHD/aYrz9g5XYV5clElO7zt7aP9
         mS4jeoUA7/KKpJpfjhbATBU0yEltR1vSu8boyJ2NfwYvM2e4Myskb9Kippl/pNgd0p
         Z8xAeLeVebLcIO0Hh+/WTMTy9GMpxWpeVRJK5ft7k6kSNGQHLfZb6IdhoMtSp4sWJ/
         SJI7720vAfr1a4x+nNpaLrkXs+qN/G2TiVyVwcBNI7/3oaJC4uAnv3gtyPXjFU2kM/
         lollBfsYSCfGlBsPRReJd+IX2ujFfGmABd/BGuflpQ8POQ69f4Re6iyoR+mjgaAacV
         /TeiGIJ+fwDqA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.145.122]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MStCe-1peHO3085O-00UH8w; Tue, 30
 May 2023 17:21:45 +0200
Message-ID: <35c48a28-db5d-731f-b2c3-fb63e5274c3e@gmx.de>
Date:   Tue, 30 May 2023 17:21:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] parisc: Enable LOCKDEP support
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org
References: <1e406b76-77c2-4ffd-ba51-943f36416a6b@roeck-us.net>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <1e406b76-77c2-4ffd-ba51-943f36416a6b@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cWCnI6OTSQI8LLk/nvjCwjwL3FcAM3drSFBthvX2ti3FRxAtO8P
 yws30pCYetS4pPPqOEatT5Q8oWH05nMuQVA+hzK6kqBjr0WfszKw2WbdYE+19F6UL391NFN
 PRHBo11AQfsW9TrWFF6ymo420fhld4zGty9GrsTS9kscREcFr2CPIYQA60c5+njVuXIB0XT
 DowoH5XqFWrUWqv/B/9Qg==
UI-OutboundReport: notjunk:1;M01:P0:pGF1PEqkgIw=;IL53ncp8LsIIKIL2Tj7RUXyyE5E
 f0cho/9yxoNiLhWcWne/Vn+UWuDtRJYMY//8gjIKnLa30I6eEcCPSRfkZaDZW171X3QeCJ4ZL
 7yudV3wRWSAhZ2KDTW4orM27L58JYN7piIe3XDgd4UXJpsczvPdKhigKxSrK9Poykh7KjOgrK
 W+8q8q96Od6c/gS4xD3ZK9e15a+Ve4QzzFuSd2d2SOLX4XmcKGcWcr4E13xPeviJQPygJSV2d
 K3+Ok4ttYjvOJwbaBZ6TWBf/UaVwD62xSXBNaqKjHb4oSipmjdbtDQ+Fd4GeXnYVkct3DIpCz
 gFGDDkHmxzXCoJe31To4xUVmJv4WMhUsFsdBIUo74jD9LpfTE0+jQyAHLKYWWc8VeVZUjyaO+
 qGoFYt/3cDePEIL+KFBBU4ZDycvUV0YQjjrdn5QkHDuByINfXTi9LAv1Yg6BFR0K8Tn60ukQe
 pgM5F7nm/S3mn3fTaOG4MN3OAfOlXEKnIwINiVg0Ap4PFu1Nm9yvB9TQ+blPJMM2jm9EH4KIm
 Yv5UMZOl+je6icFDf9r9FiWnlduXrSJapFkDOs5pFFa5uOSx3/u/v+DLL8XA0rEk6IogDVPoY
 Qrs2RIR/MMWIRo2hNyRtIAbepK81MQWRHKYj6Jqmc7QIZLGH7O9ou0uqRDciQZJXhznroviMw
 odzQ1cg92S55DWlLnDHsaYSfSKfq281EgvMPGmJy5uCqHoSitm/NwZ/nKaQO5K7o+BIOToLgM
 E5y/7HxGFHkSITLatgKg89v3ACbVF2TpKiCc5q7ica89fD/9yKIeYVv5HkXwieYFahjlNWOXW
 mr+x7wyYlZhb/DSw20tHjO79pv+UDVWJdzAaKY045ToiVrB5/Sfw/Bhp/BJLUxhiZpxz+f8rr
 Z/vva+guFNR0KTqQ0jTZJ65moNNgyawN6KluAg3uApyzjnr/yNpQiQpxhzOVV6B1qemuGWFWG
 ysq3dA==
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/23 16:19, Guenter Roeck wrote:
> Helge,
>
> On Tue, May 23, 2023 at 09:06:40AM +0200, Helge Deller wrote:
>> Cc: <stable@vger.kernel.org> # v6.0+
>> Signed-off-by: Helge Deller <deller@gmx.de>
>> ---
>>   arch/parisc/Kconfig | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
>> index 466a25525364..967bde65dd0e 100644
>> --- a/arch/parisc/Kconfig
>> +++ b/arch/parisc/Kconfig
>> @@ -130,6 +130,10 @@ config PM
>>   config STACKTRACE_SUPPORT
>>   	def_bool y
>>
>> +config LOCKDEP_SUPPORT
>> +	bool
>> +	default y
>> +
>>   config ISA_DMA_API
>>   	bool
>>
>
> This patch results in a bunch of WARNING message with each parisc boot i=
f
> CONFIG_PROVE_LOCKING and CONFIG_DEBUG_LOCKDEP are enabled.
>
> WARNING: CPU: 0 PID: 0 at kernel/locking/lockdep.c:5545 check_flags+0x24=
c/0x274
> Backtrace:
>   [<1026d44c>] lock_acquire+0xdc/0x388
>   [<10e8c66c>] _raw_spin_lock_irqsave+0x64/0x98
>   [<10e922dc>] down_trylock+0x20/0x58
>   [<102768c8>] __down_trylock_console_sem+0x44/0x114
>   [<1027b768>] vprintk_emit+0xa8/0x3dc
>   [<1027bac4>] vprintk_default+0x28/0x38
>   [<1027c574>] vprintk+0xa4/0xb4
>   [<10e6c62c>] _printk+0x30/0x40
>   [<10e37700>] report_bug+0x338/0x35c
>   [<101c19fc>] handle_interruption+0x654/0x768
>   [<101bb070>] intr_check_sig+0x0/0x38
>
> WARNING: CPU: 0 PID: 0 at kernel/context_tracking.c:367 ct_irq_enter+0x9=
4/0xb0
> Backtrace:
>   [<101f0c1c>] irq_enter+0x18/0x30
>   [<101c2dec>] do_cpu_irq_mask+0x7c/0x388
>   [<101bb064>] intr_return+0x0/0xc
>
> Is that going to be fixed, or should I disable CONFIG_PROVE_LOCKING
> for parisc in my testing ?

They should be looked at and fixed over time. Right now please disable
for now, as I personally won't have time to check as I'm leaving
for vacation. You may send me your .config in private mail though, in
case I find time.

Helge
