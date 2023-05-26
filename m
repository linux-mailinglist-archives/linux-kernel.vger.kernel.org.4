Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB7F27120D8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 09:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242267AbjEZHXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 03:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjEZHXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 03:23:47 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BC89B
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 00:23:45 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-30adc51b65cso26624f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 00:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685085824; x=1687677824;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MoMJb/3ygAHemeTwFhWl9bC1M2IUgInMEPVYub1aWm8=;
        b=SfLOA8Gjh5Flmffs3QiDjo/F8EmfVx9Z9MGwFnle6dbg4VUP0nHgRscw0YvpvJpCSd
         M2gdSh4lkP8HLmNPWNrluaf76o2tSdjHJeFCR6ffap1XlpQcKw6uOVPKXuo14Need9IT
         BGntp7JKIsF+C7a2XUkb4uyD76zFLXZTcSqhobCdiQbOKFoGvR+KiUPV5CaKtc4klFlN
         KrVwmfIMszJAYHJXxtmjorEwCCWU/y8rjMqgUofVVyqCVqzrzQYa3sXtJ1bee5ia1Z7X
         XoVrkob6+mGMUFD+bovAtAoAntD/NxVbsCiRyoVCRQdGdW6RR4QlQmoU7oe07XSTWcZJ
         RD4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685085824; x=1687677824;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MoMJb/3ygAHemeTwFhWl9bC1M2IUgInMEPVYub1aWm8=;
        b=IcnFjC8OLHZoJimhdXoNpwaoByXOUX7b3pJ+2nvXEJndvcbgNzoquTC2iDIs3oq564
         MWbdXZxhme8eYwiNr6kO/IlzJll43xQ1Zrk9AiFsVJmjtW28j50P9eFB0F+qcFr5W1wQ
         lMeC8tKXH3ucxDsmWH5bBMdAkwgdjG9Y20T9/SdfAeFdrR1/sIL5tWxM8CkYTNa+0UgI
         hI9Uf3q+D5FV1ybwUzAkKxkSp2Av4hPTrwd/aPuxfn6F0SZbwX4u7HcCmjc5GlDlB4OW
         deOIhw7ChCoHanq23kAuRleS3d5NyF/ZHzjWyO40mzaU5aQpMRaAQNDQ+0fC+57Jp7bQ
         E+AQ==
X-Gm-Message-State: AC+VfDwm42gppGeTN2+z04Y9Vo0bTtxMD/GLov7b3U1B0+0lnT5+ggiu
        K/i4JlWY0B103zaD8P0x8tAB3A==
X-Google-Smtp-Source: ACHHUZ6nBfmoGOfFj1UiNhrpHsCNORjebjfenmWMYeDuCJb1qiiOw9Oyg/V2gEttx8ZGFMRChNnwCA==
X-Received: by 2002:adf:f187:0:b0:306:3b08:6da3 with SMTP id h7-20020adff187000000b003063b086da3mr727330wro.61.1685085824052;
        Fri, 26 May 2023 00:23:44 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:15d9:4dfb:95d6:f5a0? ([2a01:e0a:982:cbb0:15d9:4dfb:95d6:f5a0])
        by smtp.gmail.com with ESMTPSA id y9-20020a5d4709000000b00307d58b3da9sm4146547wrq.25.2023.05.26.00.23.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 May 2023 00:23:43 -0700 (PDT)
Message-ID: <a481109f-17f5-3a95-46aa-c7254201cd5c@linaro.org>
Date:   Fri, 26 May 2023 09:23:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH V7 0/6] drm: bridge: samsung-dsim: Support variable
 clocking
Content-Language: en-US
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     dri-devel@lists.freedesktop.org, Adam Ford <aford173@gmail.com>
Cc:     aford@beaconembedded.com, Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Inki Dae <inki.dae@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-kernel@vger.kernel.org
References: <20230518230626.404068-1-aford173@gmail.com>
 <168508573242.1449766.4668062755722232780.b4-ty@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <168508573242.1449766.4668062755722232780.b4-ty@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 26/05/2023 09:22, Neil Armstrong wrote:
> Hi,
> 
> On Thu, 18 May 2023 18:06:20 -0500, Adam Ford wrote:
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
> [1/6] drm: bridge: samsung-dsim: fix blanking packet size calculation
>        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=a617b33f7e513f25becf843bc97f8f1658c16337
> [2/6] drm: bridge: samsung-dsim: Fix PMS Calculator on imx8m[mnp]
>        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=54f1a83c72250b182fa7722b0c5f6eb5e769598d
> [3/6] drm: bridge: samsung-dsim: Fetch pll-clock-frequency automatically
>        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=33d8d14c83bf67aa0d262961a6fda9c40f3c1052
> [4/6] drm: bridge: samsung-dsim: Select GENERIC_PHY_MIPI_DPHY
>        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=171b3b1e0f8b8c894f2388e1cf765a56f831ee5e
> [5/6] drm: bridge: samsung-dsim: Dynamically configure DPHY timing
>        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=89691775f5735fca9dc40e119edcbb52a25b9612
> [6/6] drm: bridge: samsung-dsim: Support non-burst mode
>        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=bb0e13b9e223b218c9f242f8d340a332b4381042
> 

Unlike what b4 determined, I applied v8 patches 1-6, I'll wait for comments on the bindings patch.

Thanks,
Neil
