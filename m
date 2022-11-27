Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A943639CF1
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 21:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiK0Un4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 15:43:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiK0Uny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 15:43:54 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23960B8C
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 12:43:53 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id be13so14572543lfb.4
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 12:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WU620aZn5AL/waGo/b9AZT3G8pG+gupJvw4MWpZ4moc=;
        b=O08/eujaW85+C0IWwQZNyo+5jCluWgzwgCv1bic2nSoyedz+35AiWulKdyqmvSY5XD
         dwyhcrsmrBFWHvFzAzxv5/9qbg5ewkeZO/KZkt8XXDZMuYXJwLTSIvgECOMMeSRUhsst
         Des1PU/FKyv2TaZrC3sJoDJCHXk8jE/Y9JN+u7BZZ1P9W0SD40I0KjQ/8FhmBC+HdKOb
         hBiPkGiFOs9iGPEslHHBZ7MVE0/UsC0hHPTkkN8tPTdqC8OwaVux/tDjVFKA9vzaQqvF
         vwMv+fZv7j9ZoSRtr7eod2/NnLWFX3OJ+G4aAaNX+jD0siCVHHHACJFsn9/PPf4cchvQ
         ID1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WU620aZn5AL/waGo/b9AZT3G8pG+gupJvw4MWpZ4moc=;
        b=RWNd7LO8SVCMbSHqLU7s8xAg13Z6U2Q1tnD4G8yRhjv2/oEs5DQx7UVbwsxnyNymDq
         T9D8OpuX2x2Ah9+63t/qukkvOo/JwPUsiI9Z2iREUrE65VyQu9U/2F5GWjUDkD/qFEyM
         5nuvWQXS0186QI7gbX6OLFfWGJz9xOpqghnnTYQztKEaRXomUGr2p8bjkup5GIKelwss
         PxDmGV0C32c3teQe46xV6HN57FIEvev4QWMH8Lhxfnyaq3qSvzOwpu/c3ooF4U8c3KfS
         9DMiVCCnqHAONjYRUFv7uhX3A3VNEnbf6+QYd4ILsqZU8Gez+R4M6AlioGeUx1NqDBV2
         e6Sg==
X-Gm-Message-State: ANoB5pkgolXC8V+n23ccSQEW8k/tJnMa53pWsYYz9XBh0ELkb1FA/sLY
        KFL09sfuaEKkLbr6K7IO0ApAIw==
X-Google-Smtp-Source: AA0mqf740r5rtGE153p6xDrYfBPt+Z+fKCo/6jqO6P/zfAXOEUsysF06L2sUe7TSKt4FGHwULSyUEw==
X-Received: by 2002:a19:4352:0:b0:4b5:1334:a1f8 with SMTP id m18-20020a194352000000b004b51334a1f8mr956057lfj.401.1669581831481;
        Sun, 27 Nov 2022 12:43:51 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id z8-20020a2e8848000000b0026b2094f6fcsm1049350ljj.73.2022.11.27.12.43.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Nov 2022 12:43:51 -0800 (PST)
Message-ID: <a71312e4-e8c8-ec35-6d90-5c363cc99ca1@linaro.org>
Date:   Sun, 27 Nov 2022 21:43:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 0/4] drm/tiny: panel-mipi-dbi: Support separate I/O
 voltage supply
Content-Language: en-US
To:     =?UTF-8?Q?Otto_Pfl=c3=bcger?= <otto.pflueger@abscue.de>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221127185948.1361083-1-otto.pflueger@abscue.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221127185948.1361083-1-otto.pflueger@abscue.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/11/2022 19:59, Otto Pflüger wrote:
> As stated in Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-spi.yml,
> the MIPI DBI specification defines two power supplies, one for powering
> the panel and one for the I/O voltage. The panel-mipi-dbi driver
> currently only supports specifying a single "power-supply" in the
> device tree.
> 
> Add support for a second power supply defined in a new "io-supply"
> device tree property to make the driver properly configure the voltage
> regulators on platforms where separate supplies are used.
> 
> (Resent from a new email address with proper formatting)

I just got only this cover letter, no rest of them/thread. Mark resents
as RESEND:

git format-patch --subject-prefix="RESEND PATCH" -4
scripts/get_maintainer.pl 00*
git send-email ... 00*

Best regards,
Krzysztof

