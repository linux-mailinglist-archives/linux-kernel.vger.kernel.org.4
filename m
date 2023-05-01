Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24AF96F2EAB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 08:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbjEAGXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 02:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjEAGXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 02:23:03 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229D410D9;
        Sun, 30 Apr 2023 23:23:01 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-2f833bda191so1180083f8f.1;
        Sun, 30 Apr 2023 23:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1682922179; x=1685514179;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qZPrd5dE4h5ji+qgrAdyIqtp5WS4gZcvEahgtQj7BmU=;
        b=mKfgZV9lmRDqa1IWj46kEucOgSPfRURvl1UJhOXFAl7sV52mw1xJ5v2frq+sLLuulv
         qdDsUOwo9tGtKxf8j26Q2XVeHih44DbsGBA85XjkvDioE11YfkTv6iI0grGyGrgUg28I
         GwF+Zc4cthUnH3wS8kQu4Vx5vlz2jUfFTiVndjBcVMSlO2XyQPqPw9XLtAHar/KYGwIP
         nTOOUyADl/ZtcYHJypARw4XFCxPaiE9PrNMqVw3UltNTEjEyf2XFzc2riRifxlgH7j77
         0BIWhGAMzsnCu0QcYJLFfAYDVxvX6xhJCaQ/Op4ns3WsWLGmwx1d64i49VpHeQvYoQCK
         2p3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682922179; x=1685514179;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qZPrd5dE4h5ji+qgrAdyIqtp5WS4gZcvEahgtQj7BmU=;
        b=A9qYZNoW880Rkyr8scFYY18kk1QkXTunh8PLwlyear32eiQbdfIbqP0iRPPyJxqSSI
         D0L3P9CcrXMk28bTuxq8ihfO4J51RbMZT6ZrCQocGV6eDUrTwoqmqjR9GE9XkP3JZ3Wj
         obc2Z/46rKehjGNjHKy89HFb/7+RF2yzEVF6OUxBX7P3HK5sm63TD7Npd/XiV34RfSl8
         M+nd6x8SV+3a1plSBc16brr/wd01PlFy1X56Xc2NfBZCaCEMmDRe0HzDpNCKgroYCER0
         5eV6D26Rw4MTjzuECZ/6AJMBSEw7LVymYmDCuqfhzrShPy7mQ+uKvv/XDa26FsTis5Uk
         F9eQ==
X-Gm-Message-State: AC+VfDyYUmBlfhyRfaAMNuuapwyEw77pWYkyjBCqfEOInkZyT6dSaayH
        +jt6Hvd6gS55bPT7g8wLthQ=
X-Google-Smtp-Source: ACHHUZ5fhaXUpjkgZDa76qFx6x9M90rvx2pBFix8vJi4fj2U9Sdlg8BqmeohdEW8Xvml1ubdwZyfLw==
X-Received: by 2002:a5d:4b82:0:b0:2f5:fbe5:bb1c with SMTP id b2-20020a5d4b82000000b002f5fbe5bb1cmr8511341wrt.63.1682922179352;
        Sun, 30 Apr 2023 23:22:59 -0700 (PDT)
Received: from [192.168.1.10] (95f1f744.skybroadband.com. [149.241.247.68])
        by smtp.googlemail.com with ESMTPSA id r17-20020adfdc91000000b002ff2c39d072sm27387166wrj.104.2023.04.30.23.22.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Apr 2023 23:22:58 -0700 (PDT)
Message-ID: <c2ac55a4-aaf5-2f49-be08-d326fe0c17f8@googlemail.com>
Date:   Mon, 1 May 2023 07:22:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: Linux 6.3.1
Content-Language: en-GB
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz
References: <2023050123-resubmit-silica-ac32@gregkh>
From:   Chris Clayton <chris2553@googlemail.com>
In-Reply-To: <2023050123-resubmit-silica-ac32@gregkh>
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

Hi Greg

On 01/05/2023 00:55, Greg Kroah-Hartman wrote:
> I'm announcing the release of the 6.3.1 kernel.
> 
> All users of the 6.3 kernel series must upgrade.
> 
> The updated 6.3.y git tree can be found at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.3.y
> and can be browsed at the normal kernel.org git web browser:
> 	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary
> 
> thanks,
> 
> greg k-h
> 
> ------------
> 
>  Makefile                                                    |    2 -
>  drivers/base/dd.c                                           |    7 ++++
>  drivers/gpio/gpiolib-acpi.c                                 |   13 +++++++++
>  drivers/gpu/drm/drm_fb_helper.c                             |    3 ++
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c   |    9 +++++-
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c |    5 +++
>  drivers/usb/serial/option.c                                 |    6 ++++
>  fs/btrfs/send.c                                             |    2 -
>  fs/btrfs/volumes.c                                          |    2 -
>  fs/verity/enable.c                                          |   17 ++++++++++++
>  include/linux/mmc/sdio_ids.h                                |    5 ++-
>  mm/mmap.c                                                   |    2 -
>  net/bluetooth/hci_sock.c                                    |    9 +++++-
>  13 files changed, 74 insertions(+), 8 deletions(-)
> 
> Arınç ÜNAL (1):
>       USB: serial: option: add UNISOC vendor and TOZED LT70C product
> 
> Daniel Vetter (1):
>       drm/fb-helper: set x/yres_virtual in drm_fb_helper_check_var
> 
> Eric Biggers (2):
>       fsverity: reject FS_IOC_ENABLE_VERITY on mode 3 fds
>       fsverity: explicitly check for buffer overflow in build_merkle_tree()
> 
> Genjian Zhang (1):
>       btrfs: fix uninitialized variable warnings
> 
> Greg Kroah-Hartman (1):
>       Linux 6.3.1
> 
> Jisoo Jang (1):
>       wifi: brcmfmac: slab-out-of-bounds read in brcmf_get_assoc_ies()
> 
> Marek Vasut (1):
>       wifi: brcmfmac: add Cypress 43439 SDIO ids
> 
> Ruihan Li (1):
>       bluetooth: Perform careful capability checks in hci_sock_ioctl()
> 
> Stephen Boyd (1):
>       driver core: Don't require dynamic_debug for initcall_debug probe timing
> 
> Vlastimil Babka (1):
>       mm/mremap: fix vm_pgoff in vma_merge() case 3
> 
> Werner Sembach (1):
>       gpiolib: acpi: Add a ignore wakeup quirk for Clevo NL5xNU
> 
> 
> 

6.3.1 FTBFS thusly:

drivers/net/wireguard/timers.c: In function 'wg_expired_retransmit_handshake':
<command-line>: error: format '%d' expects argument of type 'int', but argument 6 has type 'long unsigned int'
[-Werror=format=]
<command-line>: note: in expansion of macro 'KBUILD_MODNAME'
./include/linux/dynamic_debug.h:223:29: note: in expansion of macro 'pr_fmt'
  223 |                 func(&id, ##__VA_ARGS__);                       \
      |                             ^~~~~~~~~~~
./include/linux/dynamic_debug.h:247:9: note: in expansion of macro '__dynamic_func_call_cls'
  247 |         __dynamic_func_call_cls(__UNIQUE_ID(ddebug), cls, fmt, func, ##__VA_ARGS__)
      |         ^~~~~~~~~~~~~~~~~~~~~~~
./include/linux/dynamic_debug.h:249:9: note: in expansion of macro '_dynamic_func_call_cls'
  249 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
      |         ^~~~~~~~~~~~~~~~~~~~~~
./include/linux/dynamic_debug.h:268:9: note: in expansion of macro '_dynamic_func_call'
  268 |         _dynamic_func_call(fmt, __dynamic_pr_debug,             \
      |         ^~~~~~~~~~~~~~~~~~
./include/linux/printk.h:581:9: note: in expansion of macro 'dynamic_pr_debug'
  581 |         dynamic_pr_debug(fmt, ##__VA_ARGS__)
      |         ^~~~~~~~~~~~~~~~
drivers/net/wireguard/timers.c:47:17: note: in expansion of macro 'pr_debug'
   47 |                 pr_debug("%s: Handshake for peer %llu (%pISpfsc) did not complete after %d attempts, giving up\n",
      |                 ^~~~~~~~
<command-line>: error: format '%d' expects argument of type 'int', but argument 6 has type 'long unsigned int'
[-Werror=format=]
<command-line>: note: in expansion of macro 'KBUILD_MODNAME'
./include/linux/dynamic_debug.h:223:29: note: in expansion of macro 'pr_fmt'
  223 |                 func(&id, ##__VA_ARGS__);                       \
      |                             ^~~~~~~~~~~
./include/linux/dynamic_debug.h:247:9: note: in expansion of macro '__dynamic_func_call_cls'
  247 |         __dynamic_func_call_cls(__UNIQUE_ID(ddebug), cls, fmt, func, ##__VA_ARGS__)
      |         ^~~~~~~~~~~~~~~~~~~~~~~
./include/linux/dynamic_debug.h:249:9: note: in expansion of macro '_dynamic_func_call_cls'
  249 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
      |         ^~~~~~~~~~~~~~~~~~~~~~
./include/linux/dynamic_debug.h:268:9: note: in expansion of macro '_dynamic_func_call'
  268 |         _dynamic_func_call(fmt, __dynamic_pr_debug,             \
      |         ^~~~~~~~~~~~~~~~~~
./include/linux/printk.h:581:9: note: in expansion of macro 'dynamic_pr_debug'
  581 |         dynamic_pr_debug(fmt, ##__VA_ARGS__)
      |         ^~~~~~~~~~~~~~~~
drivers/net/wireguard/timers.c:65:17: note: in expansion of macro 'pr_debug'
   65 |                 pr_debug("%s: Handshake for peer %llu (%pISpfsc) did not complete after %d seconds, retrying
(try %d)\n",
      |                 ^~~~~~~~
drivers/net/wireguard/timers.c: In function 'wg_expired_new_handshake':
<command-line>: error: format '%d' expects argument of type 'int', but argument 6 has type 'long unsigned int'
[-Werror=format=]
<command-line>: note: in expansion of macro 'KBUILD_MODNAME'
./include/linux/dynamic_debug.h:223:29: note: in expansion of macro 'pr_fmt'
  223 |                 func(&id, ##__VA_ARGS__);                       \
      |                             ^~~~~~~~~~~
./include/linux/dynamic_debug.h:247:9: note: in expansion of macro '__dynamic_func_call_cls'
  247 |         __dynamic_func_call_cls(__UNIQUE_ID(ddebug), cls, fmt, func, ##__VA_ARGS__)
      |         ^~~~~~~~~~~~~~~~~~~~~~~
./include/linux/dynamic_debug.h:249:9: note: in expansion of macro '_dynamic_func_call_cls'
  249 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
      |         ^~~~~~~~~~~~~~~~~~~~~~
./include/linux/dynamic_debug.h:268:9: note: in expansion of macro '_dynamic_func_call'
  268 |         _dynamic_func_call(fmt, __dynamic_pr_debug,             \
      |         ^~~~~~~~~~~~~~~~~~
./include/linux/printk.h:581:9: note: in expansion of macro 'dynamic_pr_debug'
  581 |         dynamic_pr_debug(fmt, ##__VA_ARGS__)
      |         ^~~~~~~~~~~~~~~~
drivers/net/wireguard/timers.c:95:9: note: in expansion of macro 'pr_debug'
   95 |         pr_debug("%s: Retrying handshake with peer %llu (%pISpfsc) because we stopped hearing back after %d
seconds\n",
      |         ^~~~~~~~
drivers/net/wireguard/timers.c: In function 'wg_queued_expired_zero_key_material':
<command-line>: error: format '%d' expects argument of type 'int', but argument 6 has type 'long unsigned int'
[-Werror=format=]
<command-line>: note: in expansion of macro 'KBUILD_MODNAME'
./include/linux/dynamic_debug.h:223:29: note: in expansion of macro 'pr_fmt'
  223 |                 func(&id, ##__VA_ARGS__);                       \
      |                             ^~~~~~~~~~~
./include/linux/dynamic_debug.h:247:9: note: in expansion of macro '__dynamic_func_call_cls'
  247 |         __dynamic_func_call_cls(__UNIQUE_ID(ddebug), cls, fmt, func, ##__VA_ARGS__)
      |         ^~~~~~~~~~~~~~~~~~~~~~~
./include/linux/dynamic_debug.h:249:9: note: in expansion of macro '_dynamic_func_call_cls'
  249 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
      |         ^~~~~~~~~~~~~~~~~~~~~~
./include/linux/dynamic_debug.h:268:9: note: in expansion of macro '_dynamic_func_call'
  268 |         _dynamic_func_call(fmt, __dynamic_pr_debug,             \
      |         ^~~~~~~~~~~~~~~~~~
./include/linux/printk.h:581:9: note: in expansion of macro 'dynamic_pr_debug'
  581 |         dynamic_pr_debug(fmt, ##__VA_ARGS__)
      |         ^~~~~~~~~~~~~~~~
drivers/net/wireguard/timers.c:127:9: note: in expansion of macro 'pr_debug'
  127 |         pr_debug("%s: Zeroing out all keys for peer %llu (%pISpfsc), since we haven't received a new one in %d
seconds\n",
      |         ^~~~~~~~


There's a patch to drivers/net/wireguard/timers.c that fixes these errors and you can find it at
2d4ee16d969c97996e80e4c9cb6de0acaff22c9f in Linus' tree.

I don't kow if it's necessary. but guess I can say:

Tested-by: Chris Clayton <chris2553@googlemail.com>
