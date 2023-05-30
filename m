Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F707157D8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 10:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjE3ICC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 04:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjE3IBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 04:01:55 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8718BC9
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 01:01:51 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f6094cb2d2so42995255e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 01:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685433710; x=1688025710;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=j1K+SN90yu6GVNFzY/ynyoEBrXtMpQCEy39+3j7Gsoo=;
        b=j6dw88xQf9k7F1V+LU60cf/re3KpD6D+fW+DuVMLwRgTmhtgvGBkxbQlIeTmZKtmmr
         zCM3GqaerO/6z26xHJaQYLx+BGboERMLqQD6jCUU/eCovKr0uMeaComrQU5hNjbXthEg
         ZmN+iasm1ETNVdligfCV3KxuBLgHxcv/DfDaSD0Iy2SCptARZQGpZGo3myQ8ifjWCREO
         U5CrEpbdpYipdluUtg/bLcVvJy7CLTIwnt7KGo6u8uju/z/WM5lUfbRLeE7M0ryQPM5N
         +LsYGB8b/r2Grt/yuYFDDvwqXLH0CadCh5FxvSm5GqDLKJQ+oiYzzMO1x0VzuhiM8417
         VpCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685433710; x=1688025710;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j1K+SN90yu6GVNFzY/ynyoEBrXtMpQCEy39+3j7Gsoo=;
        b=AKPJjx4Ks+6TvSTlGFVfnB7khGNsKpzcGR/bKYKg0BvGR3XnZMqh5QDmjhUuHW9aKp
         EVFPQkBUAFLYxtIN/gmCvymtPVsL9+7nhHlabKZST9mgdc9/GfjOANqPv8Hr7L7iCkHN
         4Kugka6V/EM7NZd7pOXZP5KfnoxMx5x11RAkba0GcSNaR/z1oAc2krX4v2TDobBFsIhI
         d97414q9JBQyhocpd9v4nQ3WuxnA2ljTapaXEZOyfgkZK4Hr8+Dav2oSc/ptJhYrXiSD
         cmjCy30NJ8HcBFfeHMjRflKor80HKnizPTOO1x5gjKlZsd9Fe7UQ3DJkFsq1lsexvAkI
         6GkA==
X-Gm-Message-State: AC+VfDyYHTLxnPfqi046zKeYuxxm+bkO/FupDK6y2m1w2clVLp9y8ThR
        ESC+XjQULWIbLJ8WJwBYFo3aDQ==
X-Google-Smtp-Source: ACHHUZ5M8En45/6tBUvjo3i971gc63XBq54RnLe8ykSVS26PwEsEHPaJ1bHuRb+HD8LOEkdWqYHFFg==
X-Received: by 2002:a7b:cbc8:0:b0:3f6:1a9:b9db with SMTP id n8-20020a7bcbc8000000b003f601a9b9dbmr820957wmi.21.1685433709934;
        Tue, 30 May 2023 01:01:49 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:4294:2221:d2df:9e87? ([2a01:e0a:982:cbb0:4294:2221:d2df:9e87])
        by smtp.gmail.com with ESMTPSA id p23-20020a05600c205700b003f42314832fsm16526895wmg.18.2023.05.30.01.01.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 01:01:49 -0700 (PDT)
Message-ID: <ba2c5887-a046-c5c6-4bc0-98549003c244@linaro.org>
Date:   Tue, 30 May 2023 10:01:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH V8 0/7] drm: bridge: samsung-dsim: Support variable
 clocking
Content-Language: en-US
To:     Adam Ford <aford173@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, aford@beaconembedded.com,
        Inki Dae <inki.dae@samsung.com>,
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
 <cd3c7cca-9edd-ca16-8376-e3ba924eaa30@linaro.org>
 <CAHCN7xK8R72eTTenp4UeuOKT7NojKDC9_ReWa0HLexzqo9E6UQ@mail.gmail.com>
Organization: Linaro Developer Services
In-Reply-To: <CAHCN7xK8R72eTTenp4UeuOKT7NojKDC9_ReWa0HLexzqo9E6UQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/05/2023 16:04, Adam Ford wrote:
> On Fri, May 26, 2023 at 2:24 AM Neil Armstrong
> <neil.armstrong@linaro.org> wrote:
>>
>> On 26/05/2023 09:22, Neil Armstrong wrote:
>>> Hi,
>>>
>>> On Thu, 25 May 2023 22:05:52 -0500, Adam Ford wrote:
>>>> This series fixes the blanking pack size and the PMS calculation.  It then
>>>> adds support to allows the DSIM to dynamically DPHY clocks, and support
>>>> non-burst mode while allowing the removal of the hard-coded clock values
>>>> for the PLL for imx8m mini/nano/plus, and it allows the removal of the
>>>> burst-clock device tree entry when burst-mode isn't supported by connected
>>>> devices like an HDMI brige.  In that event, the HS clock is set to the
>>>> value requested by the bridge chip.
>>>>
>>>> [...]
>>>
>>> Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)
>>>
>>> [1/7] drm: bridge: samsung-dsim: fix blanking packet size calculation
>>>         https://cgit.freedesktop.org/drm/drm-misc/commit/?id=a617b33f7e513f25becf843bc97f8f1658c16337
>>> [2/7] drm: bridge: samsung-dsim: Fix PMS Calculator on imx8m[mnp]
>>>         https://cgit.freedesktop.org/drm/drm-misc/commit/?id=54f1a83c72250b182fa7722b0c5f6eb5e769598d
>>> [3/7] drm: bridge: samsung-dsim: Fetch pll-clock-frequency automatically
>>>         https://cgit.freedesktop.org/drm/drm-misc/commit/?id=33d8d14c83bf67aa0d262961a6fda9c40f3c1052
>>> [4/7] drm: bridge: samsung-dsim: Select GENERIC_PHY_MIPI_DPHY
>>>         https://cgit.freedesktop.org/drm/drm-misc/commit/?id=171b3b1e0f8b8c894f2388e1cf765a56f831ee5e
>>> [5/7] drm: bridge: samsung-dsim: Dynamically configure DPHY timing
>>>         https://cgit.freedesktop.org/drm/drm-misc/commit/?id=89691775f5735fca9dc40e119edcbb52a25b9612
>>> [6/7] drm: bridge: samsung-dsim: Support non-burst mode
>>>         https://cgit.freedesktop.org/drm/drm-misc/commit/?id=bb0e13b9e223b218c9f242f8d340a332b4381042
>>> [7/7] dt-bindings: bridge: samsung-dsim: Make some flags optional
>>>         https://cgit.freedesktop.org/drm/drm-misc/commit/?id=cfaf76d349837f695c8aa6d7077847fec4231fe5
>>>
>>
>> OK I made a bad manipulation, I applied patch 7 without review... I'll send a revert patch.
> 
> Sorry, I didn't mean to complicate things by adding the binding patch.
> I added a note in the cover letter to indicate it, but I also
> recognize that it contradicted my earlier email.

No problem :-)

Neil

> 
> adam
>>
>> Neil

