Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A02A6F2EAD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 08:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbjEAG0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 02:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjEAG0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 02:26:49 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1C210D9;
        Sun, 30 Apr 2023 23:26:47 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f19afc4fbfso21138285e9.2;
        Sun, 30 Apr 2023 23:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1682922406; x=1685514406;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fMjQIb6+uLwKPWwm0sSo/zviYfpIa7R+0tWxt+Jgprw=;
        b=liCwSB6pbMcvC77mCBXoKj/1nUWI/mG6yfFIqhvQ399TzJJpCLg0LaTIN5+y7b2QoC
         vYWO0hgXpX2F0RFHPH7TP1GkQ0yYgrgTuSpMiZXBUC9dPvePeLP1hNKULtwN37eMSfut
         s1AICAo/nPw6gxXlJY1x1ESDxchP/kGaUJE23W8V2q+liD7sPDSp2sBcl6qxljIGu84Z
         FV8pS0FxvMnYVLOqT79BuRMUw6b0mEyTndPbj/VWvUEgdBu9j8c/cNVv/QSvfz9cTkVv
         soK/2Fdo/hO3Ry2N6lpbmSADRoJyN7jb/xbJvQNpPWVUiT17PMZSKhqkT/DbUtT3UEvi
         yV2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682922406; x=1685514406;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fMjQIb6+uLwKPWwm0sSo/zviYfpIa7R+0tWxt+Jgprw=;
        b=d0/MxCvhvchNiQnW1K5nDWdVfKLJbCqagECsPmpSP+OdFkGnGlMA8qeUiTXsoz9Ha0
         0fx92AVvjpHDDZYF8nIA3hmQl7SEBC5Svn6YkA2HvuyCYYZNyEhcpYGbf/x+rq+d8Giy
         wCEEk2OcHXeCQwCCupHX+4ZvAxeK6WRgsBGd4R0r7iQFQWksQGyOdY15wfEeu/dVsQp/
         cKxvu3P2umdpBXjGiQxN7lQjHRWN8B/R0kuRJ/l2KuwXM4hOvwDGM4UoIHvxMavGEHI4
         iw2HpBqxoHUGj0A8Pp63ucedsHuim1m5gMuxcAf7wyKL8UAcROMUYJtnkJ2P1J6MEyc+
         2GrQ==
X-Gm-Message-State: AC+VfDyfETX0ZmOhrCpFm1ShseR5p16+vYRmkozNBvJ5TMP2pE/eyuJh
        dmvF8RE4EUMF/ofQOUB7NB82XGTOPvwF2A==
X-Google-Smtp-Source: ACHHUZ49iRb6eGmy2HQiPkxVbok4tCHgaEfLUv8MxP2muMeDxk2vpjj24c9oULYljcApSdXFt9ljxA==
X-Received: by 2002:adf:db46:0:b0:2f5:aadb:4642 with SMTP id f6-20020adfdb46000000b002f5aadb4642mr9671416wrj.41.1682922405447;
        Sun, 30 Apr 2023 23:26:45 -0700 (PDT)
Received: from [192.168.1.10] (95f1f744.skybroadband.com. [149.241.247.68])
        by smtp.googlemail.com with ESMTPSA id q9-20020a05600000c900b002c8476dde7asm27292260wrx.114.2023.04.30.23.26.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Apr 2023 23:26:45 -0700 (PDT)
Message-ID: <7bba3de2-e685-016c-92b8-1efa735aeb1c@googlemail.com>
Date:   Mon, 1 May 2023 07:26:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: Linux 6.3.1
Content-Language: en-GB
From:   Chris Clayton <chris2553@googlemail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz
References: <2023050123-resubmit-silica-ac32@gregkh>
 <c2ac55a4-aaf5-2f49-be08-d326fe0c17f8@googlemail.com>
In-Reply-To: <c2ac55a4-aaf5-2f49-be08-d326fe0c17f8@googlemail.com>
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

Sorry, should have more coffee before upgrading kernels...

This FTBFS is actually on 6.1.27. I'll concentrate hard and send a reply to the correct announcement email.

Once again. sorry for the noise.

Chris

On 01/05/2023 07:22, Chris Clayton wrote:
> Hi Greg
> 
> On 01/05/2023 00:55, Greg Kroah-Hartman wrote:
>> I'm announcing the release of the 6.3.1 kernel.
>>
>> All users of the 6.3 kernel series must upgrade.
>>
>> The updated 6.3.y git tree can be found at:
>> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.3.y
>> and can be browsed at the normal kernel.org git web browser:
>> 	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary
>>
>> thanks,
>>
>> greg k-h
>>
>> ------------
>>
>>  Makefile                                                    |    2 -
>>  drivers/base/dd.c                                           |    7 ++++
>>  drivers/gpio/gpiolib-acpi.c                                 |   13 +++++++++
>>  drivers/gpu/drm/drm_fb_helper.c                             |    3 ++
>>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c   |    9 +++++-
>>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c |    5 +++
>>  drivers/usb/serial/option.c                                 |    6 ++++
>>  fs/btrfs/send.c                                             |    2 -
>>  fs/btrfs/volumes.c                                          |    2 -
>>  fs/verity/enable.c                                          |   17 ++++++++++++
>>  include/linux/mmc/sdio_ids.h                                |    5 ++-
>>  mm/mmap.c                                                   |    2 -
>>  net/bluetooth/hci_sock.c                                    |    9 +++++-
>>  13 files changed, 74 insertions(+), 8 deletions(-)
>>
>> Arınç ÜNAL (1):
>>       USB: serial: option: add UNISOC vendor and TOZED LT70C product
>>
>> Daniel Vetter (1):
>>       drm/fb-helper: set x/yres_virtual in drm_fb_helper_check_var
>>
>> Eric Biggers (2):
>>       fsverity: reject FS_IOC_ENABLE_VERITY on mode 3 fds
>>       fsverity: explicitly check for buffer overflow in build_merkle_tree()
>>
>> Genjian Zhang (1):
>>       btrfs: fix uninitialized variable warnings
>>
>> Greg Kroah-Hartman (1):
>>       Linux 6.3.1
>>
>> Jisoo Jang (1):
>>       wifi: brcmfmac: slab-out-of-bounds read in brcmf_get_assoc_ies()
>>
>> Marek Vasut (1):
>>       wifi: brcmfmac: add Cypress 43439 SDIO ids
>>
>> Ruihan Li (1):
>>       bluetooth: Perform careful capability checks in hci_sock_ioctl()
>>
>> Stephen Boyd (1):
>>       driver core: Don't require dynamic_debug for initcall_debug probe timing
>>
>> Vlastimil Babka (1):
>>       mm/mremap: fix vm_pgoff in vma_merge() case 3
>>
>> Werner Sembach (1):
>>       gpiolib: acpi: Add a ignore wakeup quirk for Clevo NL5xNU
>>
>>
>>
> 
> 6.3.1 FTBFS thusly:
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
> I don't kow if it's necessary. but guess I can say:
> 
> Tested-by: Chris Clayton <chris2553@googlemail.com>
