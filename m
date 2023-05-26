Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241C57120DE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 09:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242305AbjEZHZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 03:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242281AbjEZHZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 03:25:01 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7752DE7
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 00:24:59 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3095b1b6e02so178146f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 00:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685085898; x=1687677898;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kMA0q0+orF3dwWefUl5BaOVFBflGo6mcE1xBc9h+qAw=;
        b=s3h+nLTL18ptvO3FGp02QqI4CWOqQlb4rt1Rp1Moln8gEdPq8E4JX5cvEsAWcCQjVe
         noYIp0WOJoyMXQCyTzd9J67Ye3JF2zszLyjQzCGwOqyEueMUCxx9wDO8r3lAjqDN1lye
         0K8ChzfN9qzsv23hstWu/mIhMso2GI8DRiIPWvU1jZCF5+5AYo86tqyYaEfvMpbpPbyT
         d/gHPjhnQoxl7RZX5oKeMKeqmY9YtNE+6mPZz/ISru6bK5BGXLC+qFprpMrceXCWuADt
         MvI+lbk2KxqEOGKkui5xT/kWXJJsjww3+dTjTN1wu8tx+4Pu89WB6Se/FHENND10+008
         DwrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685085898; x=1687677898;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kMA0q0+orF3dwWefUl5BaOVFBflGo6mcE1xBc9h+qAw=;
        b=hEQPt0A9nw158KeXECzKD6LQxuEDmBexs+vJ/ga4tAMaGciYGZZemrlNBok53GjNre
         wIcAj80OtZn/HGUC74MAK/kNmFipA6GgjTjk07GJAZG5WubP9Dw+gO48cGtn+0YNgxA9
         1r12QoCGbcOAkpuXAU6MGp7g9/cCUeZL02YoEJYxsz1kqox/ACdn0gOR++Bo0/zsDTKe
         O1P2SNi48k0E9xSptt7xMy4hHlpczrP0J4E0XtWjJn6cokFae/Ez+VraSbzIhDkBi2vz
         xdQnDHwqBeWGQPlviLy+SsLvC5+wiprc/soY47PUIcYoOcLA8au92pvBK4SV85mHpuY5
         Nedw==
X-Gm-Message-State: AC+VfDzpVQ6zUo4NV/dbeI6ED04wzPQDwoSqVoMcMfM2hfDtzSkZN6l+
        XppA/5ncEVXuTtcRYNKU3Ohr4A==
X-Google-Smtp-Source: ACHHUZ4i6+Ev8Xo3WXWSge2iHDb34BDFGq9Aqn+jmz4LirYDZaHB8nKbRQDH2HDjY9lGUCjUd+5q4g==
X-Received: by 2002:adf:fc4e:0:b0:306:3da7:f33c with SMTP id e14-20020adffc4e000000b003063da7f33cmr576474wrs.63.1685085897848;
        Fri, 26 May 2023 00:24:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:15d9:4dfb:95d6:f5a0? ([2a01:e0a:982:cbb0:15d9:4dfb:95d6:f5a0])
        by smtp.gmail.com with ESMTPSA id n5-20020a5d51c5000000b003064088a94fsm4112766wrv.16.2023.05.26.00.24.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 May 2023 00:24:57 -0700 (PDT)
Message-ID: <cd3c7cca-9edd-ca16-8376-e3ba924eaa30@linaro.org>
Date:   Fri, 26 May 2023 09:24:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH V8 0/7] drm: bridge: samsung-dsim: Support variable
 clocking
Content-Language: en-US
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     dri-devel@lists.freedesktop.org, Adam Ford <aford173@gmail.com>
Cc:     aford@beaconembedded.com, Inki Dae <inki.dae@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marek Vasut <marex@denx.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230526030559.326566-1-aford173@gmail.com>
 <168508573345.1449766.11809947722851001124.b4-ty@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <168508573345.1449766.11809947722851001124.b4-ty@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/05/2023 09:22, Neil Armstrong wrote:
> Hi,
> 
> On Thu, 25 May 2023 22:05:52 -0500, Adam Ford wrote:
>> This series fixes the blanking pack size and the PMS calculation.  It then
>> adds support to allows the DSIM to dynamically DPHY clocks, and support
>> non-burst mode while allowing the removal of the hard-coded clock values
>> for the PLL for imx8m mini/nano/plus, and it allows the removal of the
>> burst-clock device tree entry when burst-mode isn't supported by connected
>> devices like an HDMI brige.  In that event, the HS clock is set to the
>> value requested by the bridge chip.
>>
>> [...]
> 
> Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)
> 
> [1/7] drm: bridge: samsung-dsim: fix blanking packet size calculation
>        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=a617b33f7e513f25becf843bc97f8f1658c16337
> [2/7] drm: bridge: samsung-dsim: Fix PMS Calculator on imx8m[mnp]
>        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=54f1a83c72250b182fa7722b0c5f6eb5e769598d
> [3/7] drm: bridge: samsung-dsim: Fetch pll-clock-frequency automatically
>        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=33d8d14c83bf67aa0d262961a6fda9c40f3c1052
> [4/7] drm: bridge: samsung-dsim: Select GENERIC_PHY_MIPI_DPHY
>        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=171b3b1e0f8b8c894f2388e1cf765a56f831ee5e
> [5/7] drm: bridge: samsung-dsim: Dynamically configure DPHY timing
>        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=89691775f5735fca9dc40e119edcbb52a25b9612
> [6/7] drm: bridge: samsung-dsim: Support non-burst mode
>        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=bb0e13b9e223b218c9f242f8d340a332b4381042
> [7/7] dt-bindings: bridge: samsung-dsim: Make some flags optional
>        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=cfaf76d349837f695c8aa6d7077847fec4231fe5
> 

OK I made a bad manipulation, I applied patch 7 without review... I'll send a revert patch.

Neil
