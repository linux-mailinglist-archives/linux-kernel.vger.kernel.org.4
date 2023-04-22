Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21C56EB9AB
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 16:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjDVOct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 10:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjDVOcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 10:32:47 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477E71726;
        Sat, 22 Apr 2023 07:32:44 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-506bdf29712so20268491a12.0;
        Sat, 22 Apr 2023 07:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682173962; x=1684765962;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=99YDX/7qK2W322RAkYIogsdvoiSZC6dcO4nnOgE0Yyo=;
        b=ZB2yO7V+VviFFwaU4aBE/vpz5FwYoSa+h0HUBE0qU/AShZGYTQpE+4lZmOgds1alHW
         afhiqm6haQpQInYGWCAYvlM5H9b7/KSHLfJiUct5BZlzyT4WxO4aLg/VSXIwur5t9E7u
         klogQQINI1oU57+YgfubJiMoZun+SKchav/ORXFAKX0esBEXS3azxI95JpsSA+wvPte0
         uYbSNuOV4tqcavR1UXD/2RVyj+nd4/5YqRsG//nEvKGEFLpmoNgry7XrCDgfDbxE/wox
         YmXepcrKiVDI2Vp4TJGDclcFZhqKt3Es1+HbXNFgfqP1WXz6KrO0o1iuQjGaNESUhcRP
         L/mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682173962; x=1684765962;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=99YDX/7qK2W322RAkYIogsdvoiSZC6dcO4nnOgE0Yyo=;
        b=lODNRu5YrYKDwk6Eqwkag2RUfnUHB7tV9EwX+sfdD4WZy4b6htRNq5ty/Es4GOm7H3
         taLBMW8NJTfzKft1Fp2Ikst6GorbsOtLYP6ejgM7hdl/zSI9Hnzl7/oZpXha10zFE4vP
         PZiavhh2AuPTABbHMrDiZU8/gds5NegmaaXIFJRjBra5Ui2ppDysjWKaGzKxlMq4ag6Q
         cqO4gs8O6HVv+pXm2UCWvD9PPMelIyFqizennQEmXMyyIqoKHxe9P4KsJWZ7ge7Z1N09
         2EIWErnqfv8bgHE69GDvv4zUE3fFdXjKF3dKxmA16YxFv9+9GEIsigw2rQ9kvyE//XJm
         syBA==
X-Gm-Message-State: AAQBX9c3PXZn6qPASZSU/HDDYisPz27PLFGKvPjcHreV+88mvNqOJB37
        VgTvo6v/koef6OqwRzVGdsI=
X-Google-Smtp-Source: AKy350ag+YkaszQoLJF85uoBsRlfKgZMpqx2xUlrkmBej+tzYfEcbXlftSXKRerq6HGjS1CWb+PkyQ==
X-Received: by 2002:a17:906:cc52:b0:953:4bec:f350 with SMTP id mm18-20020a170906cc5200b009534becf350mr5336322ejb.23.1682173962546;
        Sat, 22 Apr 2023 07:32:42 -0700 (PDT)
Received: from [192.168.50.244] (83.11.224.11.ipv4.supernova.orange.pl. [83.11.224.11])
        by smtp.gmail.com with ESMTPSA id z4-20020a170906434400b0094f2dca017fsm3300437ejm.50.2023.04.22.07.32.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Apr 2023 07:32:41 -0700 (PDT)
Message-ID: <6803ab6e-d7ed-cce1-013f-221878b4be2c@gmail.com>
Date:   Sat, 22 Apr 2023 16:32:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From:   Artur Weber <aweber.kernel@gmail.com>
Subject: Re: [PATCH v3 2/3] drm/panel: Add Samsung S6D7AA0 panel controller
 driver
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20230416131632.31673-1-aweber.kernel@gmail.com>
 <20230416131632.31673-3-aweber.kernel@gmail.com>
 <CACRpkdaTmHASz25uzDoeZBG2=e7XRLK67DENfAtCbaFp+AYnYA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CACRpkdaTmHASz25uzDoeZBG2=e7XRLK67DENfAtCbaFp+AYnYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

thank you for the review.

On 20/04/2023 09:35, Linus Walleij wrote:
>> +static int s6d7aa0_on(struct s6d7aa0 *ctx)
>> +{
>> +       struct mipi_dsi_device *dsi = ctx->dsi;
>> +       struct device *dev = &dsi->dev;
>> +       int ret;
>> +
>> +       dsi->mode_flags |= MIPI_DSI_MODE_LPM;
> 
> (...)
> 
>> +static int s6d7aa0_off(struct s6d7aa0 *ctx)
>> +{
>> +       struct mipi_dsi_device *dsi = ctx->dsi;
>> +       struct device *dev = &dsi->dev;
>> +       int ret;
>> +
>> +       dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
> 
> I haven't seen this mode flag MIPI_DSI_MODE_LPM set and
> masked in other DSI panel drivers! Is this something we should
> fix everywhere then? Or even something the core should be
> doing?

These bits were included in a driver for a similar panel with the same
controller in an MSM8916 close-to-mainline kernel fork[1]; that driver
was generated with lmdpdg[2], which adds the LPM mode flag automatically
based on some downstream DTS property. In this case, I left it in, since
it didn't seem to break anything... but I just re-tested without it and
it seems that it might've fixed some odd issues I'd get sometimes when
going out of sleep mode. I'll get rid of it in the next version.

(I based my panel driver off that driver; now that I think about it, it
might be worth mentioning somewhere in the copyright notice...?)

Best regards
Artur Weber

[1]
https://github.com/msm8916-mainline/linux/blob/msm8916/6.3-rc7/drivers/gpu/drm/panel/msm8916-generated/panel-samsung-s6d7aa0-lsl080al03.c
[2]
https://github.com/msm8916-mainline/linux-mdss-dsi-panel-driver-generator
