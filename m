Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 715DE65AF47
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 11:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbjABKGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 05:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbjABKGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 05:06:16 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F754C23
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 02:06:15 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id m3so11165340wmq.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 02:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=F1RL6LflIG8Mw7UlknL1u+EpOcbFN6xIFh4jzQAsTkA=;
        b=nxyBhliPiMemarZoDV3u8Mwu+5EB4RlTq20rm2hG34ycFDjLE/LzFRAfg4xxCcK/qi
         995TJhcNh9A+kioKUMJMkg2wAQQ1GbQQy2w10Uucncx7gVrcJ1beY+QkpGNg0/90P+Zd
         L4a6olXJ7D7O5Sh4LTg72EE+dPTkd1umQDSqE6Hi4/j9hWTuAtqlb+u0gVRX4e13yONp
         m9trj97VWd70g2NeMOhx3r7DnqR1tlX1QHpZfZtRRYxiTlDJl3jDPPdbU1ZQlubiboU5
         StUq4gZyYQpo0D/882+2uK5izZ/sICUiEZ/sOYmN4h6rs16jnZgR68++1wzkfrUVBMhH
         H58A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F1RL6LflIG8Mw7UlknL1u+EpOcbFN6xIFh4jzQAsTkA=;
        b=xyr5kryPXqpwwbkN+GEEnmXcko91aD9UHaiF0UX1H6qe2y6hTKFOANxe3V4j3klqGv
         2Enr0bBJNVSF7y+dAqdiCPhwacWyV/x26AK+9EIHIT4KInnZUPYQ1bgMVvmlQn5Tuy6I
         QNqB76OEDAOjfYUxdLOJ8V4OUeXM+Cvj8Mavn7c3JC1wAblpXR7lhBeKTnK3bJroSOrS
         WnFfcRisu0fyzq02mbIGxvABvD6nM667zbXEUQ3/7QLZ+SvONOoK+RHf7+mGd2BTfSzW
         FC92vL9M6lISdC6SS1pTOvsoti2LKs2Wgt7o5LFbwrcUU1JInOt3P7aoTEz7g/VPjXtU
         PS8g==
X-Gm-Message-State: AFqh2koAtoWxEIdOUpPVptlkxU6ITQTfA6M2woX4KYzvCOkJafMnaRf4
        0KXdHq/1RgFuRfgSbvBFLBHs7A==
X-Google-Smtp-Source: AMrXdXv4JA4tlRg9gobOljg3u3b3xyCoqMnyrpZqgffOFiHxr55dZw9X/PXLh6neNwbEAaaR4q2SZg==
X-Received: by 2002:a1c:2bc1:0:b0:3d2:fbab:3609 with SMTP id r184-20020a1c2bc1000000b003d2fbab3609mr28458725wmr.27.1672653974222;
        Mon, 02 Jan 2023 02:06:14 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:4f32:f70:35be:acf9? ([2a01:e0a:982:cbb0:4f32:f70:35be:acf9])
        by smtp.gmail.com with ESMTPSA id n36-20020a05600c3ba400b003b49bd61b19sm44890446wms.15.2023.01.02.02.06.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 02:06:13 -0800 (PST)
Message-ID: <3f40e58a-dcd2-7c9a-1a9d-cae36719352f@linaro.org>
Date:   Mon, 2 Jan 2023 11:06:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] mfd: rk808: re-add rk808-clkout to RK818
Content-Language: en-US
To:     Tom Fitzhenry <tom@tom-fitzhenry.me.uk>, Lee Jones <lee@kernel.org>
Cc:     Ondrej Jirman <megi@xff.cz>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Martijn Braam <martijn@brixit.nl>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221228140708.26431-1-tom@tom-fitzhenry.me.uk>
Organization: Linaro Developer Services
In-Reply-To: <20221228140708.26431-1-tom@tom-fitzhenry.me.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/12/2022 15:07, Tom Fitzhenry wrote:
> Fixes RK818 (e.g. on Pinephone Pro) to register its clock, without which
> dependent devices (e.g. wifi/BT, via sdio-wifi-pwrseq) fail to probe.
> 
> This line was removed in commit 3633daacea2e
> ("mfd: rk808: Permit having multiple PMIC instances"), but only from RK818.
> 
> Signed-off-by: Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
> ---
>   drivers/mfd/rk808.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
> index f44fc3f080a8..0f22ef61e817 100644
> --- a/drivers/mfd/rk808.c
> +++ b/drivers/mfd/rk808.c
> @@ -189,6 +189,7 @@ static const struct mfd_cell rk817s[] = {
>   };
>   
>   static const struct mfd_cell rk818s[] = {
> +	{ .name = "rk808-clkout", .id = PLATFORM_DEVID_NONE, },
>   	{ .name = "rk808-regulator", .id = PLATFORM_DEVID_NONE, },
>   	{
>   		.name = "rk808-rtc",
> 
> base-commit: c76083fac3bae1a87ae3d005b5cb1cbc761e31d5

Sorry, my bad...


Acked-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
