Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2703E6BDD46
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 01:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjCQAAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 20:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbjCQAAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 20:00:36 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB4CE276D;
        Thu, 16 Mar 2023 17:00:31 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id n2so3831131qtp.0;
        Thu, 16 Mar 2023 17:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679011230;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=syeoa/fsbGNoanZ01ukJADs+k1OdVVkscUemGY6a3X0=;
        b=Jsc7BJZo9VsMrVMKa5DNMM1ylWEje84DA4Xdor0DUtgAELbU6hiFlV3j5h8PymfyhK
         KxNCiFTRcJxrBTtqwHK31NM0NqevMnom4+d0mcswfWZfVC3McLy0oT9e6TWRkGCxZ8x4
         lp1/zEWy0K2TQQJIyhxKxeZq7YJB9Kroy4NpPvA4EbkqAHxUQUf2eFdmArlqdpk2+wFX
         ks06GxJH+Vm4ppHh6KzwZw7ZYCECdOlQJagriY1pyd3wed5UELne7rY1Cyft6/2CH+Hj
         cTr0FZ4QfBRWAecrB6jmewvKxHQRHNHPG0fCa7J3b1DYRjvDlYP82Sh6VN9WVh/gFwJI
         pqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679011230;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=syeoa/fsbGNoanZ01ukJADs+k1OdVVkscUemGY6a3X0=;
        b=7TALSEQ8vpI24j4f7H2JnpjKbZ99V2lCcx0VBAweEFwm1yL6Wq+NUYZbWKpHyHrfn+
         2EUCkzRN/XM8D0OY1RZdpWq16JB1tfmxLdeBnaWQ7upWoGQylzG5fRHsfrvxb2MPitcL
         QlZkNrg+dCoOFV+tJB+7SbiI1rHpIHyEt4hFoVjR6wPo5y2SbFNSa1UbQyVmtSzV5Nb8
         nSVrAqlBcc7KxIrS3Z5ANOnMnlxBA+LAGYClWq4eSi1ReNzo9AArpwr97E3I+qJusJ2r
         wxg2dnhpa5m9p/SXy1wIXb0mt8NrePZ/q5axfhvUqWlaCPuw6yFB3EwbQfbGRXPMDAmw
         0LGQ==
X-Gm-Message-State: AO0yUKUquphnQtY5iYh5NWGLXu2/r+lssHK2l4n6sZCduVuVC+zNCGQ7
        pVSqxYQolhUDium9HGfPUz4=
X-Google-Smtp-Source: AK7set+ozaWfhsfoNavMhPFpkMw0Sy9TT06gwaj9/1EisXeyuBqKenn8b+YkIU+XNTS5BJlUIZIk+w==
X-Received: by 2002:ac8:5b0d:0:b0:3d7:ba40:81c with SMTP id m13-20020ac85b0d000000b003d7ba40081cmr7613708qtw.30.1679011230322;
        Thu, 16 Mar 2023 17:00:30 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id l14-20020ac84a8e000000b003d4ee7879d0sm338558qtq.56.2023.03.16.17.00.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 17:00:29 -0700 (PDT)
Message-ID: <4b8e71e8-a465-88aa-6257-948e9238f05b@gmail.com>
Date:   Thu, 16 Mar 2023 17:00:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2] mips: bmips: BCM6358: disable
 arch_sync_dma_for_cpu_all() for TP1
Content-Language: en-US
To:     =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>,
        jonas.gorski@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        tsbogend@alpha.franken.de, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230310121306.4632-1-noltari@gmail.com>
 <20230316180518.783613-1-noltari@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230316180518.783613-1-noltari@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,LOTS_OF_MONEY,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/16/23 11:05, Álvaro Fernández Rojas wrote:
> arch_sync_dma_for_cpu_all() causes kernel panics on BCM6358 with EHCI/OHCI:
> [    3.881739] usb 1-1: new high-speed USB device number 2 using ehci-platform
> [    3.895011] Reserved instruction in kernel code[#1]:
> [    3.900113] CPU: 0 PID: 1 Comm: init Not tainted 5.10.16 #0
> [    3.905829] $ 0   : 00000000 10008700 00000000 77d94060
> [    3.911238] $ 4   : 7fd1f088 00000000 81431cac 81431ca0
> [    3.916641] $ 8   : 00000000 ffffefff 8075cd34 00000000
> [    3.922043] $12   : 806f8d40 f3e812b7 00000000 000d9aaa
> [    3.927446] $16   : 7fd1f068 7fd1f080 7ff559b8 81428470
> [    3.932848] $20   : 00000000 00000000 55590000 77d70000
> [    3.938251] $24   : 00000018 00000010
> [    3.943655] $28   : 81430000 81431e60 81431f28 800157fc
> [    3.949058] Hi    : 00000000
> [    3.952013] Lo    : 00000000
> [    3.955019] epc   : 80015808 setup_sigcontext+0x54/0x24c
> [    3.960464] ra    : 800157fc setup_sigcontext+0x48/0x24c
> [    3.965913] Status: 10008703	KERNEL EXL IE
> [    3.970216] Cause : 00800028 (ExcCode 0a)
> [    3.974340] PrId  : 0002a010 (Broadcom BMIPS4350)
> [    3.979170] Modules linked in: ohci_platform ohci_hcd fsl_mph_dr_of ehci_platform ehci_fsl ehci_hcd gpio_button_hotplug usbcore nls_base usb_common
> [    3.992907] Process init (pid: 1, threadinfo=(ptrval), task=(ptrval), tls=77e22ec8)
> [    4.000776] Stack : 81431ef4 7fd1f080 81431f28 81428470 7fd1f068 81431edc 7ff559b8 81428470
> [    4.009467]         81431f28 7fd1f080 55590000 77d70000 77d5498c 80015c70 806f0000 8063ae74
> [    4.018149]         08100002 81431f28 0000000a 08100002 81431f28 0000000a 77d6b418 00000003
> [    4.026831]         ffffffff 80016414 80080734 81431ecc 81431ecc 00000001 00000000 04000000
> [    4.035512]         77d54874 00000000 00000000 00000000 00000000 00000012 00000002 00000000
> [    4.044196]         ...
> [    4.046706] Call Trace:
> [    4.049238] [<80015808>] setup_sigcontext+0x54/0x24c
> [    4.054356] [<80015c70>] setup_frame+0xdc/0x124
> [    4.059015] [<80016414>] do_notify_resume+0x1dc/0x288
> [    4.064207] [<80011b50>] work_notifysig+0x10/0x18
> [    4.069036]
> [    4.070538] Code: 8fc300b4  00001025  26240008 <ac820000> ac830004  3c048063  0c0228aa  24846a00  26240010
> [    4.080686]
> [    4.082517] ---[ end trace 22a8edb41f5f983b ]---
> [    4.087374] Kernel panic - not syncing: Fatal exception
> [    4.092753] Rebooting in 1 seconds..
> 
> This only happens when booting from TP1 instead of TP0.

Because the bootloader (CFE) is not initializing the Read-ahead cache 
properly on the second thread (TP1). Since the RAC was not initialized 
properly, we should avoid flushing it at the risk of corrupting the 
instruction stream as seen in the trace above.

> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
> ---
>   v2: check if we're running on TP1 and invert logic.
> 
>   arch/mips/bmips/dma.c   | 5 +++++
>   arch/mips/bmips/setup.c | 9 +++++++++
>   2 files changed, 14 insertions(+)
> 
> diff --git a/arch/mips/bmips/dma.c b/arch/mips/bmips/dma.c
> index 33788668cbdb..2e470ef8d30f 100644
> --- a/arch/mips/bmips/dma.c
> +++ b/arch/mips/bmips/dma.c
> @@ -5,11 +5,16 @@
>   #include <asm/bmips.h>
>   #include <asm/io.h>
>   
> +int bmips_dma_sync_disable = 0;

bool bmips_rac_flush_disable;

No need for the false, it is initialized to 0 by default.

> +
>   void arch_sync_dma_for_cpu_all(void)
>   {
>   	void __iomem *cbr = BMIPS_GET_CBR();
>   	u32 cfg;
>   
> +	if (bmips_dma_sync_disable)
> +		return;

if (unlikely(bmips_rac_flush_disable))

and move it after the check on the boot_cpu_type() so we do not impact 
other BMIPS CPUs.

> +
>   	if (boot_cpu_type() != CPU_BMIPS3300 &&
>   	    boot_cpu_type() != CPU_BMIPS4350 &&
>   	    boot_cpu_type() != CPU_BMIPS4380)
> diff --git a/arch/mips/bmips/setup.c b/arch/mips/bmips/setup.c
> index e95b3f78e7cd..15543e8d5b0c 100644
> --- a/arch/mips/bmips/setup.c
> +++ b/arch/mips/bmips/setup.c
> @@ -35,6 +35,8 @@
>   #define REG_BCM6328_OTP		((void __iomem *)CKSEG1ADDR(0x1000062c))
>   #define BCM6328_TP1_DISABLED	BIT(9)
>   
> +extern int bmips_dma_sync_disable;

extern bool bmips_rac_flush_disable;

> +
>   static const unsigned long kbase = VMLINUX_LOAD_ADDRESS & 0xfff00000;
>   
>   struct bmips_quirk {
> @@ -104,6 +106,13 @@ static void bcm6358_quirks(void)
>   	 * disable SMP for now
>   	 */
>   	bmips_smp_enabled = 0;
> +
> +	/*
> +	 * ARCH_HAS_SYNC_DMA_FOR_CPU_ALL causes kernel panics on BCM6358 when
> +	 * booting from TP1
> +	 */
> +	if (read_c0_brcm_cmt_local() & (1 << 31))
> +		bmips_dma_sync_disable = 1;

	bmips_rac_flush_disable = !!(read_c0_brcm_cmt_local() & (1 << 31));

	is more compact, but what you have works too.

Sorry for being so insisting about the name, but signaling what this 
does is fairly important.
-- 
Florian

