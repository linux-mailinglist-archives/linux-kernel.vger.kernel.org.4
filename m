Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68AD563B93D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 05:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235449AbiK2Exq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 23:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235422AbiK2Exc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 23:53:32 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9AAB1BE8D;
        Mon, 28 Nov 2022 20:53:30 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id v81so13998397oie.5;
        Mon, 28 Nov 2022 20:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=whHpAD3OgAxM38NTZimfOlDm36mCTHAk+45ttz3B/SI=;
        b=Zrf741GO1zpehoZPfJoNmwgz5emwxbE1uw8lS+3OT4eq45gLAsLY0KHJYuNasHevwh
         DebzFcveNQ92gbguplGe6oLahRWKBB3wcQBwo9AbzpaIS+COrUnnJaExeiw90lpp8a+D
         /kcLkTdTSPPUlqJm0JukSM+SoX4s8nmMqvJAoQKIDD/zltKJfFnDdsdJl4vrLhERTBOJ
         Fhgcnrs6U7WNbwLVeh1XVmvr718E5UZYS97miStBl47l2YJoZiTFlRLZMViR4c4HJBZq
         UEczDIMGcFsLEghwl4k0gAdwxxeEx9n2bTdvkQdg1zbKiXgO3Z75TIhQljCkFwlMTzBC
         qnLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=whHpAD3OgAxM38NTZimfOlDm36mCTHAk+45ttz3B/SI=;
        b=034bsmLwcZXc2yVBI82XKHO4NQ6LetAuQZuyNMjURlE5X7fl7ehG5LAD0CC6176CwY
         6fqCnohsKnduA0hNSwq+ikzyH76GG76QWeKjTxj9vNVLG1Lpm8PVabtdg4U+u8BM20gw
         gRU8KOFOQeIoA/yEhE9H61utq/o8I8elFwqqlXFKjokHF4ui5QscLb49QALNXgCISvuP
         9umVWp5MBPc4gyWnINGXNHiXWgC/leTI8P0D/mUoa0hsJ518BSqoMc4TMkgmNCtQzgQW
         9a8eG3ATjwOiplz7q5SH/vQ5tXF8qsv935jFu7sp4lNQHhOdCcclzDW3D+yG1ZrANAAY
         k5gA==
X-Gm-Message-State: ANoB5pnQXMY2J4ywzkI3Gvn+Nj6DhK4RhBExxVQ7jUFSFSQr4TfpLjIc
        WffywaAkH4ZCCQWWDrSHSxgs33zKR/o=
X-Google-Smtp-Source: AA0mqf6g9n5aR+1CN5N311LT6YEZQVNDGGvqzGRo4/FGOfszpDHKoXSfOk6JsDgcQftZANMbV5LZTw==
X-Received: by 2002:a05:6808:2012:b0:35b:bcb3:46f with SMTP id q18-20020a056808201200b0035bbcb3046fmr2697894oiw.86.1669697610292;
        Mon, 28 Nov 2022 20:53:30 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t15-20020a9d774f000000b0066c495a651dsm5473516otl.38.2022.11.28.20.53.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 20:53:29 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <88eb9941-7bf4-3220-ff8a-7e9b3f4bb01b@roeck-us.net>
Date:   Mon, 28 Nov 2022 20:53:27 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/2] watchdog: rzg2l_wdt: Issue a reset before we put the
 PM clocks
Content-Language: en-US
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
References: <20221117114907.138583-1-fabrizio.castro.jz@renesas.com>
 <20221117114907.138583-2-fabrizio.castro.jz@renesas.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20221117114907.138583-2-fabrizio.castro.jz@renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/17/22 03:49, Fabrizio Castro wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> On RZ/Five SoC it was observed that setting timeout (to say 1 sec) wouldn't
> reset the system.
> 
> The procedure described in the HW manual (Procedure for Activating Modules)
> for activating the target module states we need to start supply of the
> clock module before applying the reset signal. This patch makes sure we
> follow the same procedure to clear the registers of the WDT module, fixing
> the issues seen on RZ/Five SoC.
> 
> While at it re-used rzg2l_wdt_stop() in rzg2l_wdt_set_timeout() as it has
> the same function calls.
> 
> Fixes: 4055ee81009e ("watchdog: rzg2l_wdt: Add set_timeout callback")
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/rzg2l_wdt.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/watchdog/rzg2l_wdt.c b/drivers/watchdog/rzg2l_wdt.c
> index 974a4194a8fd..ceca42db0837 100644
> --- a/drivers/watchdog/rzg2l_wdt.c
> +++ b/drivers/watchdog/rzg2l_wdt.c
> @@ -115,25 +115,23 @@ static int rzg2l_wdt_stop(struct watchdog_device *wdev)
>   {
>   	struct rzg2l_wdt_priv *priv = watchdog_get_drvdata(wdev);
>   
> -	pm_runtime_put(wdev->parent);
>   	reset_control_reset(priv->rstc);
> +	pm_runtime_put(wdev->parent);
>   
>   	return 0;
>   }
>   
>   static int rzg2l_wdt_set_timeout(struct watchdog_device *wdev, unsigned int timeout)
>   {
> -	struct rzg2l_wdt_priv *priv = watchdog_get_drvdata(wdev);
> -
>   	wdev->timeout = timeout;
>   
>   	/*
>   	 * If the watchdog is active, reset the module for updating the WDTSET
> -	 * register so that it is updated with new timeout values.
> +	 * register by calling rzg2l_wdt_stop() (which internally calls reset_control_reset()
> +	 * to reset the module) so that it is updated with new timeout values.
>   	 */
>   	if (watchdog_active(wdev)) {
> -		pm_runtime_put(wdev->parent);
> -		reset_control_reset(priv->rstc);
> +		rzg2l_wdt_stop(wdev);
>   		rzg2l_wdt_start(wdev);
>   	}
>   

