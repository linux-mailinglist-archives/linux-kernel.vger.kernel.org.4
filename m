Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B1A6735AC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 11:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjASKg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 05:36:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjASKge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 05:36:34 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA9F5FD47
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 02:35:40 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id b5so1443630wrn.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 02:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VtMyXO+XFAd7bhjLH/6eN7IyGN6nezPLZZSqRmEiMMs=;
        b=Zq5fEPrYoJ5p66SaptrWOmIBuVV3Ru3K6GuVs5q+LWxwE4Odxsdf+D0Olxhm9ERWlU
         rE+ArNSWDYZkQT0zjlN+gS0exZ5D4BAj7rJgAJ1jcIv5FMMea2jp070lyySIE8ZniMwp
         8fryby50Vd5FIzLrYDQhJygsbYXNs4E22MQWOV8/a0g1vcpVlfJ7zSBNq1QJHb1i5gG8
         oTbr9WNcxQpeTNpw7MfJma5R3QXMguN1ArLvuLY3NIn4jd7v92J3AA3BQljhVhYHqabF
         1QjIzRyAjoZogl/RuCvc2iyWofZIb/VjsViHg71g5MpXAKulKsbFEDPp9am8+c3CJR4v
         tdzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VtMyXO+XFAd7bhjLH/6eN7IyGN6nezPLZZSqRmEiMMs=;
        b=ap2IYOIMvMjBriyGaSbStY+zWFZkFrT8SqOcGBcOHFo8uk+MHeqFW64QxACERlqZaZ
         Kxm4I222JxSJAAhN4w2R4Jl3QMHulZnvNi+MJXYwky4lkoz59xPKS+CwU91o5xLCPi4r
         THW+LNFf9/vjjazuTMLkrWUGkx3zYzQJHs241lG4qYF0HAC7HlZiCixzRQYjiQq2OsN8
         H5OwTeXnfKnCU7XU+SItJdvyAqdw1pNl91G+FakpnVq15G/zwKsuecSjqKZocW/9T84m
         Ltr1xjAvHOyts8idZIE+oYEPZARmMzVdhY21nzo8DWzlimPrhGRruYuWrh9OO1cS/hGQ
         23fQ==
X-Gm-Message-State: AFqh2korGnetopen02haxocLe1Mn1YKCBL0Y+WQGYKbmKD9UsUKnwe0s
        leaFBw4bAO23IcoaDHTuWDFfkw==
X-Google-Smtp-Source: AMrXdXvx+FBmmoMdPtes6WLfL4U/PKZM2tRc6m6sgE2QM3WyiD511MetmxVKIvnYStyWu5TeGl5PJQ==
X-Received: by 2002:a5d:5224:0:b0:2ba:a771:5812 with SMTP id i4-20020a5d5224000000b002baa7715812mr8496539wra.24.1674124537156;
        Thu, 19 Jan 2023 02:35:37 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id e20-20020a5d5954000000b002be099f78c0sm9198986wri.69.2023.01.19.02.35.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 02:35:36 -0800 (PST)
Message-ID: <aee03688-54b6-ed9f-e32c-b46e31d72198@linaro.org>
Date:   Thu, 19 Jan 2023 11:35:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v6 09/10] arm64: dts: qcom: sc7180: Add support for HDCP
 in dp-controller
Content-Language: en-US
To:     Mark Yacoub <markyacoub@chromium.org>, quic_khsieh@quicinc.com,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org
Cc:     robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@somainline.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        tzimmermann@suse.de, ville.syrjala@linux.intel.com,
        stanislav.lisovskiy@intel.com, matthew.d.roper@intel.com,
        imre.deak@intel.com, lucas.demarchi@intel.com,
        manasi.d.navare@intel.com, swati2.sharma@intel.com,
        bhanuprakash.modem@intel.com, javierm@redhat.com,
        jose.souza@intel.com, lyude@redhat.com, hbh25y@gmail.com,
        arun.r.murthy@intel.com, ashutosh.dixit@intel.com,
        ankit.k.nautiyal@intel.com, maxime@cerno.tech, swboyd@chromium.org,
        christophe.jaillet@wanadoo.fr, quic_sbillaka@quicinc.com,
        johan+linaro@kernel.org, dianders@chromium.org, marex@denx.de,
        quic_jesszhan@quicinc.com, bjorn.andersson@linaro.org,
        abhinavk@codeaurora.org, seanpaul@chromium.org
References: <20230118193015.911074-1-markyacoub@google.com>
 <20230118193015.911074-10-markyacoub@google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230118193015.911074-10-markyacoub@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/01/2023 20:30, Mark Yacoub wrote:
> From: Sean Paul <seanpaul@chromium.org>
> 
> This patch adds the register ranges required for HDCP key injection and

Do not use "This commit/patch".
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

This applies to all your patches. Fix it everywhere.

> HDCP TrustZone interaction as described in the dt-bindings for the
> sc7180 dp controller. Now that these are supported, change the
> compatible string to "dp-hdcp".

What does it mean? Where do you do it?

> 
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: Mark Yacoub <markyacoub@chromium.org>
> Link: https://patchwork.freedesktop.org/patch/msgid/20210913175747.47456-15-sean@poorly.run #v1
> Link: https://patchwork.freedesktop.org/patch/msgid/20210915203834.1439-14-sean@poorly.run #v2
> Link: https://patchwork.freedesktop.org/patch/msgid/20211001151145.55916-14-sean@poorly.run #v3
> Link: https://patchwork.freedesktop.org/patch/msgid/20211105030434.2828845-14-sean@poorly.run #v4
> Link: https://patchwork.freedesktop.org/patch/msgid/20220411204741.1074308-10-sean@poorly.run #v5

Drop the links.

> 
> Changes in v3:
> -Split off into a new patch containing just the dts change (Stephen)
> -Add hdcp compatible string (Stephen)
> Changes in v4:
> -Rebase on Bjorn's multi-dp patchset
> Changes in v5:
> -Put the tz register offsets in trogdor dtsi (Rob C)
> Changes in v6:
> -Rebased: Removed modifications in sc7180.dtsi as it's already upstream
> 
> ---

Changelog after --- .

>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Best regards,
Krzysztof

