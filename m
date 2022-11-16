Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC33362C03A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 14:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233537AbiKPN6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 08:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbiKPN43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 08:56:29 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB4A450B7;
        Wed, 16 Nov 2022 05:52:59 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id p21so16473212plr.7;
        Wed, 16 Nov 2022 05:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F2v0reJ03oQ3N+WnL3S2soD9eTu9KQZuxthHEtmAPEQ=;
        b=jWenCqonb1DW2SKwL0/8E7iBjB4hzBEJdgxj5MtXETzo8amTO60Ocw0LxgCgf2OePX
         RhePBphEpAdXhadVe6QtpdsR2ZrQnBohklAy0oNFQzDgLaBCRvpsF3XRR1shadid64s5
         Fd9oFfRI7AUgF+FBNNMxrMnoFr1CrncDnUCsOdPSdiytoMgiUBel+d1tGtPgIpH6RPPW
         WGPTJMXAYAO6xnRWaPvHIwAp4Z8O+cmANFxKq5yHJqfLTDy1LKGH7/J8WObHlMWLeQYU
         bDFrFGXrp4DrhSBdzl00dRWcQ8RsAeUE1Fmzv42bT8ljYR0dZhoTyUgorP9t6rA2+Gyw
         0S2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F2v0reJ03oQ3N+WnL3S2soD9eTu9KQZuxthHEtmAPEQ=;
        b=UpriC3MbS8fZLOkcPnJTMp757w4l6DyvjJp93JeceW075j8UYvluZXlXtVmGfXOpIq
         qoNEBmmQZGY+F9LivheCxTnx74RH1oLzqG2XIT/NbGYh1PvIwNueaWSJRmx5hCp/I8Jv
         ey8smqOQ91cSTBg8+02D0pmNLRkHdksKTvJCrpmaYYhsqcTGSeoxigLDye97wEQpfWK0
         iYFLI7b+5wMROZwDmUJvMuFW7SGyCnLNkMnFPeecSmqAu+fNy/IjyGYsHFTxkMX9FdVW
         cCZxw4kUBNZMTQrqLbeKF9UCc68Z8IkwK0MXIozmqh5LlwpZSKtE4qhUHveejoRI92OT
         uHrg==
X-Gm-Message-State: ANoB5pkDBW2CDmLO95ndMDbZNEO1ire+KUtWs8FyCbD/hmiPR8vaxt0b
        olXB6zZWqMT1JL5xunAV6gkohrFFicc=
X-Google-Smtp-Source: AA0mqf4f4kNUjCNP5yGSE0B8eQN0tfzdvPY1oYJA/egrBYdB+uVY7ScvCLgYKTFVH0MPcrXSkWsAvg==
X-Received: by 2002:a17:902:f787:b0:186:971b:b7e5 with SMTP id q7-20020a170902f78700b00186971bb7e5mr9379282pln.54.1668606778974;
        Wed, 16 Nov 2022 05:52:58 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b4-20020a170902d50400b00186ad73e2d5sm12351879plg.208.2022.11.16.05.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 05:52:58 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 16 Nov 2022 05:52:57 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Li Hua <hucool.lihua@huawei.com>
Cc:     wim@linux-watchdog.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, weiyongjun1@huawei.com,
        yusongping@huawei.com
Subject: Re: [PATCH v2] watchdog: pcwd_usb: Fix attempting to access
 uninitialized memory
Message-ID: <20221116135257.GB3498904@roeck-us.net>
References: <20221115134213.GD4189373@roeck-us.net>
 <20221116020706.70847-1-hucool.lihua@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221116020706.70847-1-hucool.lihua@huawei.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 10:07:06AM +0800, Li Hua wrote:
> The stack variable msb and lsb may be used uninitialized in function
> usb_pcwd_get_temperature and usb_pcwd_get_timeleft when usb card no response.
> 
> The build waring is:
> drivers/watchdog/pcwd_usb.c:336:22: error: ‘lsb’ is used uninitialized in this function [-Werror=uninitialized]
>   *temperature = (lsb * 9 / 5) + 32;
>                   ~~~~^~~
> drivers/watchdog/pcwd_usb.c:328:21: note: ‘lsb’ was declared here
>   unsigned char msb, lsb;
>                      ^~~
> cc1: all warnings being treated as errors
> scripts/Makefile.build:250: recipe for target 'drivers/watchdog/pcwd_usb.o' failed
> make[3]: *** [drivers/watchdog/pcwd_usb.o] Error 1
> 
> Fixes: b7e04f8c61a4 ("mv watchdog tree under drivers")
> Signed-off-by: Li Hua <hucool.lihua@huawei.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> v1 -> v2: just initialize lsb and msb with 0, but returning -EFAULT
> ---
>  drivers/watchdog/pcwd_usb.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/pcwd_usb.c b/drivers/watchdog/pcwd_usb.c
> index 1bdaf17c1d38..8202f0a6b093 100644
> --- a/drivers/watchdog/pcwd_usb.c
> +++ b/drivers/watchdog/pcwd_usb.c
> @@ -325,7 +325,8 @@ static int usb_pcwd_set_heartbeat(struct usb_pcwd_private *usb_pcwd, int t)
>  static int usb_pcwd_get_temperature(struct usb_pcwd_private *usb_pcwd,
>  							int *temperature)
>  {
> -	unsigned char msb, lsb;
> +	unsigned char msb = 0x00;
> +	unsigned char lsb = 0x00;
>  
>  	usb_pcwd_send_command(usb_pcwd, CMD_READ_TEMP, &msb, &lsb);
>  
> @@ -341,7 +342,8 @@ static int usb_pcwd_get_temperature(struct usb_pcwd_private *usb_pcwd,
>  static int usb_pcwd_get_timeleft(struct usb_pcwd_private *usb_pcwd,
>  								int *time_left)
>  {
> -	unsigned char msb, lsb;
> +	unsigned char msb = 0x00;
> +	unsigned char lsb = 0x00;
>  
>  	/* Read the time that's left before rebooting */
>  	/* Note: if the board is not yet armed then we will read 0xFFFF */
> -- 
> 2.17.1
> 
