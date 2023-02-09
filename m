Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C8968FE02
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 04:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbjBIDdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 22:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbjBIDdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 22:33:33 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6810A8;
        Wed,  8 Feb 2023 19:33:30 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id y11-20020a05683009cb00b0068dbf908574so194443ott.8;
        Wed, 08 Feb 2023 19:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=OaaMmw3PAi+pi0tWEgA6WtRfrUnFX1OCuwDrc+Vf7fQ=;
        b=K3w6+uKAhBI4KktI+N9J0HK+96JSPzEWuzf2PGUmoKNpzqtXCOOFYfxnNqJXG43EJK
         MB4ENeC89yh0WVTvZ7QsguKEMDJUSOQ02E03D/K+hONi5xQkHWjhKg9CPp2/oCGVBGPN
         rgLALpKK0Y9dxaaO4zqn6re2pSRYrT5PSJvuQ6WfJP3X7TBXXiuPHSV9//wteYeYv9Zv
         53eWFczOiFpotVSJ891ufi8E2XTkYiF3Rz8KFsRfKpEaDQfvjxvCuDrevskIqvhnlqZU
         gvYU9rUjJFDfU7HCPdsrjRMk3vGgMBsDlywAVSFMvDI/JmnxPAUlz+Gk9sRMYnNPHaRT
         rDyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OaaMmw3PAi+pi0tWEgA6WtRfrUnFX1OCuwDrc+Vf7fQ=;
        b=L+6RVP6FhnFV6cHAcrM6AtU2SaA/Qj1c3JEA16CbcAX657QZaIaOc8LbiIY2U+wjQp
         8XFQfcxJPsuAflYSgNwC/p8QOdGFnuV1mwmGF5/Xdebq/NZg0A28Xesb7vEIUcEWoIt1
         ecAJ5XCujL9xE76xoLYo2X9onbYlWOR9s2ld/6rX/+aNkld29ewOJjJazU+lBpbfGwuD
         Zx2oEhEhNvICFiLOksb0Y9SE8BSXgv+njuZmqImlvOpBJfG7e1sfVwf/bU/OfPYeri/u
         zI2gDG+R80a4Fgr3NGyxTfSGITNQJnHbXK1tWqTaA8uvU2lRtC7+WgGPO79KmdQFW9ga
         xkbA==
X-Gm-Message-State: AO0yUKUOV0o7DEok1/7whSrM1AXsvBBMQAsim+MaLBM0NIIh4Wkoa/71
        jz2kCFrwb4S8CsnF9VcFIUgvQ81BChs=
X-Google-Smtp-Source: AK7set8UuwCG1RVoAQYZsOHDmBml2TyyIcPs70abON0BvM9w0Vu57+LvCGNOYrObjRnf4XAclnD5HQ==
X-Received: by 2002:a9d:6458:0:b0:68d:57af:2678 with SMTP id m24-20020a9d6458000000b0068d57af2678mr4387581otl.38.1675913610176;
        Wed, 08 Feb 2023 19:33:30 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u4-20020a9d4d84000000b0068d752f1870sm130284otk.5.2023.02.08.19.33.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 19:33:29 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <0106b656-9e86-271b-eda6-20ac7cb1792c@roeck-us.net>
Date:   Wed, 8 Feb 2023 19:33:28 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3] watchdog: sbsa_wdog: Make sure the timeout programming
 is within the limits
Content-Language: en-US
To:     George Cherian <george.cherian@marvell.com>,
        wim@linux-watchdog.org, zhangshaokun@hisilicon.com
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230209021117.1512097-1-george.cherian@marvell.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230209021117.1512097-1-george.cherian@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/23 18:11, George Cherian wrote:
> Make sure to honour the max_hw_heartbeat_ms while programming the timeout
> value to WOR. Clamp the timeout passed to sbsa_gwdt_set_timeout() to
> make sure the programmed value is within the permissible range.
> 
> Fixes: abd3ac7902fb ("watchdog: sbsa: Support architecture version 1")
> 
> Signed-off-by: George Cherian <george.cherian@marvell.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/sbsa_gwdt.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/watchdog/sbsa_gwdt.c b/drivers/watchdog/sbsa_gwdt.c
> index 9791c74aebd4..63862803421f 100644
> --- a/drivers/watchdog/sbsa_gwdt.c
> +++ b/drivers/watchdog/sbsa_gwdt.c
> @@ -150,6 +150,7 @@ static int sbsa_gwdt_set_timeout(struct watchdog_device *wdd,
>   	struct sbsa_gwdt *gwdt = watchdog_get_drvdata(wdd);
>   
>   	wdd->timeout = timeout;
> +	timeout = clamp_t(unsigned int, timeout, 1, wdd->max_hw_heartbeat_ms / 1000);
>   
>   	if (action)
>   		sbsa_gwdt_reg_write(gwdt->clk * timeout, gwdt);

