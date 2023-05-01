Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3546F30CF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 14:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbjEAMSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 08:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbjEAMSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 08:18:15 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFAB7110;
        Mon,  1 May 2023 05:18:10 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f19afc4f60so13415155e9.1;
        Mon, 01 May 2023 05:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1682943489; x=1685535489;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TKOi6LM1kKTQWb9QHMseRnSD81FNpSSz9n8no1TsPoA=;
        b=DStuGwhgf+XAmaZdL/VuSRnWfrUZ931RbcB7X1gU2ja9CoPF/PsQ4gMhJAa1ZJav/7
         orXQY0MXIIH/n0veyQWBimU9Ifs5yKqZ/Ifk2T7BBq0EwCXd/awydK+qnd3PgxsTipKF
         dQVsxzwAjKIvhq5xy4LdHvGbhzd32fVLlrEIX14rFPJ45ZbEhInfPPCX5694oFs0FlmN
         r1NbKTRFDiZueO+5xOWApL5I1CymmRdiDH8ln3PGi/JaIfdnyLw4xJbO6L60GW0/HeXr
         dBfEOFck1FSCuh4jjmDFhLZR3e2f2RRKzXFVfGenmSfHoQFdMopeOYJ59XFm89jToVxk
         lK9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682943489; x=1685535489;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TKOi6LM1kKTQWb9QHMseRnSD81FNpSSz9n8no1TsPoA=;
        b=g4TsHTXltUA/Sd0Jij3fpSoFzq20zh6nfWOcDKEf4UBGQ/WUZucu/7FkUYlRlcT++4
         VfrKpinseTSQz5OLy/RkPFAU/1zTv+iHXz5JbjUHOKO5GekBL1lJkTgi4S5CPwQK+9G0
         E+BdpPDyy85VYkfzojVAaB4BgGu46X87l4p3hVQ3PDvbpXrOFOOCqNE7NloaBNiue5Oy
         TQK9lZF/C0tn9YzJQfSc8Ii1EMdZCBOXI+6YdUq7xdjkSZwPNZlXZSDmtv2nBKoJ3s8S
         oM/jcbByWd3mYbYAr+ZUpcVJye+naIZ8+RnbbOYkBm5G9Z2uQsgSiwb1zwHWEgkXg3EO
         BhHQ==
X-Gm-Message-State: AC+VfDz348uVuSI7KphQmhTtRWL9xgT+YRAqeRSOk32/XBaTyhIJ507A
        0GZyYv52Z/HpiqiaVw4Bfyc=
X-Google-Smtp-Source: ACHHUZ7lRvCpoNF3LXFIFi9pPlvPIbD+GdBTfomXiiYOAeNs+o1ObDpDBxXDUP8YMYYxrkoxjYM9dA==
X-Received: by 2002:a7b:cbd5:0:b0:3f0:8108:406 with SMTP id n21-20020a7bcbd5000000b003f081080406mr9927202wmi.28.1682943489120;
        Mon, 01 May 2023 05:18:09 -0700 (PDT)
Received: from [192.168.1.10] (95f1f744.skybroadband.com. [149.241.247.68])
        by smtp.googlemail.com with ESMTPSA id l9-20020a05600c1d0900b003f17eded97bsm36408414wms.19.2023.05.01.05.18.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 May 2023 05:18:08 -0700 (PDT)
Message-ID: <f5d78c30-7410-ef8e-74fc-51fccb6fd066@googlemail.com>
Date:   Mon, 1 May 2023 13:18:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: Linux 6.1.27
From:   Chris Clayton <chris2553@googlemail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz, Jason@zx2c4.com
References: <2023050145-jacket-oversleep-bf26@gregkh>
 <177ba955-e71b-d962-6adf-328b7936a979@googlemail.com>
Content-Language: en-GB
In-Reply-To: <177ba955-e71b-d962-6adf-328b7936a979@googlemail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again.


On 01/05/2023 07:34, Chris Clayton wrote:
> Hi Greg,
> 
> On 01/05/2023 00:38, Greg Kroah-Hartman wrote:
>> I'm announcing the release of the 6.1.27 kernel.
>>
>> All users of the 6.1 kernel series must upgrade.
>>
>> The updated 6.1.y git tree can be found at:
>> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
>> and can be browsed at the normal kernel.org git web browser:
>> 	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary
>>
>> thanks,
>>
>> greg k-h
>>
>> ------------
>>
>>  Documentation/riscv/vm-layout.rst                           |    4 
>>  Makefile                                                    |    2 
>>  arch/arm64/kvm/mmu.c                                        |   47 ++--
>>  arch/riscv/include/asm/fixmap.h                             |    8 
>>  arch/riscv/include/asm/pgtable.h                            |    8 
>>  arch/riscv/kernel/setup.c                                   |    6 
>>  arch/riscv/mm/init.c                                        |   82 +++-----
>>  arch/x86/Makefile.um                                        |    5 
>>  drivers/base/dd.c                                           |    7 
>>  drivers/gpio/gpiolib-acpi.c                                 |   13 +
>>  drivers/gpu/drm/drm_fb_helper.c                             |    3 
>>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c |    5 
>>  drivers/phy/broadcom/phy-brcm-usb.c                         |    4 
>>  drivers/usb/serial/option.c                                 |    6 
>>  fs/btrfs/send.c                                             |    2 
>>  fs/btrfs/volumes.c                                          |    2 
>>  mm/mempolicy.c                                              |  115 +++++-------
>>  net/bluetooth/hci_sock.c                                    |    9 
>>  net/mptcp/protocol.c                                        |   74 +++++--
>>  net/mptcp/protocol.h                                        |    2 
>>  net/mptcp/subflow.c                                         |   80 ++++++++
>>  21 files changed, 308 insertions(+), 176 deletions(-)
>>
>> Alexandre Ghiti (3):
>>       riscv: Move early dtb mapping into the fixmap region
>>       riscv: Do not set initial_boot_params to the linear address of the dtb
>>       riscv: No need to relocate the dtb as it lies in the fixmap region
>>
>> Arınç ÜNAL (1):
>>       USB: serial: option: add UNISOC vendor and TOZED LT70C product
>>
>> Daniel Vetter (1):
>>       drm/fb-helper: set x/yres_virtual in drm_fb_helper_check_var
>>
>> David Gow (1):
>>       um: Only disable SSE on clang to work around old GCC bugs
>>
>> David Matlack (1):
>>       KVM: arm64: Retry fault if vma_lookup() results become invalid
>>
>> Florian Fainelli (1):
>>       phy: phy-brcm-usb: Utilize platform_get_irq_byname_optional()
>>
>> Genjian Zhang (1):
>>       btrfs: fix uninitialized variable warnings
>>
>> Greg Kroah-Hartman (1):
>>       Linux 6.1.27
>>
>> Jisoo Jang (1):
>>       wifi: brcmfmac: slab-out-of-bounds read in brcmf_get_assoc_ies()
>>
>> Liam R. Howlett (1):
>>       mm/mempolicy: fix use-after-free of VMA iterator
>>
>> Paolo Abeni (2):
>>       mptcp: stops worker on unaccepted sockets at listener close
>>       mptcp: fix accept vs worker race
>>
>> Ruihan Li (1):
>>       bluetooth: Perform careful capability checks in hci_sock_ioctl()
>>
>> Stephen Boyd (1):
>>       driver core: Don't require dynamic_debug for initcall_debug probe timing
>>
>> Werner Sembach (1):
>>       gpiolib: acpi: Add a ignore wakeup quirk for Clevo NL5xNU
>>
>>
>>
> 
> 6.1.27 FTBFS thusly:
> 
> drivers/net/wireguard/timers.c: In function 'wg_expired_retransmit_handshake':
> <command-line>: error: format '%d' expects argument of type 'int', but argument 6 has type 'long unsigned int'
> [-Werror=format=]
> <command-line>: note: in expansion of macro 'KBUILD_MODNAME'
> ./include/linux/dynamic_debug.h:223:29: note: in expansion of macro 'pr_fmt'
>   223 |                 func(&id, ##__VA_ARGS__);                       \
>       |                             ^~~~~~~~~~~
> ./include/linux/dynamic_debug.h:247:9: note: in expansion of macro '__dynamic_func_call_cls'
>   247 |         __dynamic_func_call_cls(__UNIQUE_ID(ddebug), cls, fmt, func, ##__VA_ARGS__)
>       |         ^~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/dynamic_debug.h:249:9: note: in expansion of macro '_dynamic_func_call_cls'
>   249 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
>       |         ^~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/dynamic_debug.h:268:9: note: in expansion of macro '_dynamic_func_call'
>   268 |         _dynamic_func_call(fmt, __dynamic_pr_debug,             \
>       |         ^~~~~~~~~~~~~~~~~~
> ./include/linux/printk.h:581:9: note: in expansion of macro 'dynamic_pr_debug'
>   581 |         dynamic_pr_debug(fmt, ##__VA_ARGS__)
>       |         ^~~~~~~~~~~~~~~~
> drivers/net/wireguard/timers.c:47:17: note: in expansion of macro 'pr_debug'
>    47 |                 pr_debug("%s: Handshake for peer %llu (%pISpfsc) did not complete after %d attempts, giving up\n",
>       |                 ^~~~~~~~
> <command-line>: error: format '%d' expects argument of type 'int', but argument 6 has type 'long unsigned int'
> [-Werror=format=]
> <command-line>: note: in expansion of macro 'KBUILD_MODNAME'
> ./include/linux/dynamic_debug.h:223:29: note: in expansion of macro 'pr_fmt'
>   223 |                 func(&id, ##__VA_ARGS__);                       \
>       |                             ^~~~~~~~~~~
> ./include/linux/dynamic_debug.h:247:9: note: in expansion of macro '__dynamic_func_call_cls'
>   247 |         __dynamic_func_call_cls(__UNIQUE_ID(ddebug), cls, fmt, func, ##__VA_ARGS__)
>       |         ^~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/dynamic_debug.h:249:9: note: in expansion of macro '_dynamic_func_call_cls'
>   249 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
>       |         ^~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/dynamic_debug.h:268:9: note: in expansion of macro '_dynamic_func_call'
>   268 |         _dynamic_func_call(fmt, __dynamic_pr_debug,             \
>       |         ^~~~~~~~~~~~~~~~~~
> ./include/linux/printk.h:581:9: note: in expansion of macro 'dynamic_pr_debug'
>   581 |         dynamic_pr_debug(fmt, ##__VA_ARGS__)
>       |         ^~~~~~~~~~~~~~~~
> drivers/net/wireguard/timers.c:65:17: note: in expansion of macro 'pr_debug'
>    65 |                 pr_debug("%s: Handshake for peer %llu (%pISpfsc) did not complete after %d seconds, retrying
> (try %d)\n",
>       |                 ^~~~~~~~
> drivers/net/wireguard/timers.c: In function 'wg_expired_new_handshake':
> <command-line>: error: format '%d' expects argument of type 'int', but argument 6 has type 'long unsigned int'
> [-Werror=format=]
> <command-line>: note: in expansion of macro 'KBUILD_MODNAME'
> ./include/linux/dynamic_debug.h:223:29: note: in expansion of macro 'pr_fmt'
>   223 |                 func(&id, ##__VA_ARGS__);                       \
>       |                             ^~~~~~~~~~~
> ./include/linux/dynamic_debug.h:247:9: note: in expansion of macro '__dynamic_func_call_cls'
>   247 |         __dynamic_func_call_cls(__UNIQUE_ID(ddebug), cls, fmt, func, ##__VA_ARGS__)
>       |         ^~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/dynamic_debug.h:249:9: note: in expansion of macro '_dynamic_func_call_cls'
>   249 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
>       |         ^~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/dynamic_debug.h:268:9: note: in expansion of macro '_dynamic_func_call'
>   268 |         _dynamic_func_call(fmt, __dynamic_pr_debug,             \
>       |         ^~~~~~~~~~~~~~~~~~
> ./include/linux/printk.h:581:9: note: in expansion of macro 'dynamic_pr_debug'
>   581 |         dynamic_pr_debug(fmt, ##__VA_ARGS__)
>       |         ^~~~~~~~~~~~~~~~
> drivers/net/wireguard/timers.c:95:9: note: in expansion of macro 'pr_debug'
>    95 |         pr_debug("%s: Retrying handshake with peer %llu (%pISpfsc) because we stopped hearing back after %d
> seconds\n",
>       |         ^~~~~~~~
> drivers/net/wireguard/timers.c: In function 'wg_queued_expired_zero_key_material':
> <command-line>: error: format '%d' expects argument of type 'int', but argument 6 has type 'long unsigned int'
> [-Werror=format=]
> <command-line>: note: in expansion of macro 'KBUILD_MODNAME'
> ./include/linux/dynamic_debug.h:223:29: note: in expansion of macro 'pr_fmt'
>   223 |                 func(&id, ##__VA_ARGS__);                       \
>       |                             ^~~~~~~~~~~
> ./include/linux/dynamic_debug.h:247:9: note: in expansion of macro '__dynamic_func_call_cls'
>   247 |         __dynamic_func_call_cls(__UNIQUE_ID(ddebug), cls, fmt, func, ##__VA_ARGS__)
>       |         ^~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/dynamic_debug.h:249:9: note: in expansion of macro '_dynamic_func_call_cls'
>   249 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
>       |         ^~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/dynamic_debug.h:268:9: note: in expansion of macro '_dynamic_func_call'
>   268 |         _dynamic_func_call(fmt, __dynamic_pr_debug,             \
>       |         ^~~~~~~~~~~~~~~~~~
> ./include/linux/printk.h:581:9: note: in expansion of macro 'dynamic_pr_debug'
>   581 |         dynamic_pr_debug(fmt, ##__VA_ARGS__)
>       |         ^~~~~~~~~~~~~~~~
> drivers/net/wireguard/timers.c:127:9: note: in expansion of macro 'pr_debug'
>   127 |         pr_debug("%s: Zeroing out all keys for peer %llu (%pISpfsc), since we haven't received a new one in %d
> seconds\n",
>       |         ^~~~~~~~
> 
> 
> There's a patch to drivers/net/wireguard/timers.c that fixes these errors and you can find it at
> 2d4ee16d969c97996e80e4c9cb6de0acaff22c9f in Linus' tree.
> 
> I don't know if it's necessary. but I guess I can say:
> 
> Tested-by: Chris Clayton <chris2553@googlemail.com>
> 

The patch is needed in 5.15.110 too.

Chris
