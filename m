Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0AF6984F2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 20:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjBOTtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 14:49:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjBOTs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 14:48:59 -0500
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD64143449;
        Wed, 15 Feb 2023 11:48:26 -0800 (PST)
Received: by mail-oi1-f175.google.com with SMTP id r28so16804650oiw.3;
        Wed, 15 Feb 2023 11:48:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ES8N8Hh2D7hQsUypK+gMa+ocupch+L82j/qPG7r9WpE=;
        b=0gl5Giw90vrk7/S53y8Cm/YB8M9ujioWr316HitdHA4XgLAioYxVLv6h9PLnUOuh/a
         v0JbM3D0InuxvlQREZADFpk5DI4BgMWQJkCFEJ5Fl9HJvjtFIRlOgh/naGDVTgzw0vD+
         4RkZDCC06CvEQ02hv5BuuHF+6X+yUg60inGd+Y/lBe12kWnQ+kZ9Ed3vvvNOaCYpxola
         76C8nZOfcDPWZi6vIgpkf5NGJ41KB678VBk8EzHZFEKFOwKabxvtohrxRtfXngNkRsbj
         z+4cC1cVu3e5u860pbdpPW4K67DPWq54w4i1iAgwSFVPVpQusmW4W3p0E8e+sPxSgDc/
         cbLQ==
X-Gm-Message-State: AO0yUKXJRPV6+Ub4f1sHn6ZMsIekWy1lMEWsqFS6lrgFCCv3rmgXGHpn
        KAwIlza4qe5HtB3v037ctw==
X-Google-Smtp-Source: AK7set8ruhe6908E1A45EySWkYOia5CVpYGuR38kcmC2APgjfq0ejeqyOBjiYT28fJdXwmCjaOc3zw==
X-Received: by 2002:a05:6808:1314:b0:377:f784:3332 with SMTP id y20-20020a056808131400b00377f7843332mr258161oiv.24.1676490415555;
        Wed, 15 Feb 2023 11:46:55 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i126-20020acaea84000000b0037887ca2150sm7612534oih.22.2023.02.15.11.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 11:46:55 -0800 (PST)
Received: (nullmailer pid 458210 invoked by uid 1000);
        Wed, 15 Feb 2023 19:46:54 -0000
Date:   Wed, 15 Feb 2023 13:46:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Rob Clark <robdclark@gmail.com>, David Airlie <airlied@gmail.com>,
        krzysztof.kozlowski@linaro.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        marijn.suijten@somainline.org, andersson@kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>, Sean Paul <sean@poorly.run>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        agross@kernel.org, freedreno@lists.freedesktop.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 1/9] dt-bindings: display/msm: dsi-controller-main:
 Fix deprecated QCM2290 compatible
Message-ID: <167649041349.458158.6164203599398852315.robh@kernel.org>
References: <20230213121012.1768296-1-konrad.dybcio@linaro.org>
 <20230213121012.1768296-2-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213121012.1768296-2-konrad.dybcio@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 13 Feb 2023 13:10:04 +0100, Konrad Dybcio wrote:
> The qcom, prefix was missed previously. Fix it.
> 
> Fixes: 0c0f65c6dd44 ("dt-bindings: msm: dsi-controller-main: Add compatible strings for every current SoC")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../devicetree/bindings/display/msm/dsi-controller-main.yaml    | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

