Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97D062C1A9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 15:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234566AbiKPO67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 09:58:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233302AbiKPO4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 09:56:53 -0500
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDAF5FA7;
        Wed, 16 Nov 2022 06:56:52 -0800 (PST)
Received: by mail-oi1-f176.google.com with SMTP id r76so18712368oie.13;
        Wed, 16 Nov 2022 06:56:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QPW1fGxE1mhRMx/p6Fsr3+j14CdHWrLtpScHYKSbOqE=;
        b=btHAHKiA4byDWR5L41tHNZPi/pKRRFCGqgNeb6bcb1CDzKG5xpSCyPtgzdpFNw7p+S
         L5L2o4yw/WMtT/NwLgYYXfYP3jXYq+9Ljhyo66QmTrCtCfG9HkAlg0n4WT0Nwgc1e5YE
         BlRaLIsrY02LUvEgyVh5hsHdVAJX/R9j22NrB2eDA/QqFW4aQ78SOUsf5jl+CKgHdjn5
         zh4AvFIul2mUwPElFkCy9SLIB9a+IzMLju4zJ0GGRlHpDE8jnn4UrlRQ1H19TXAg90/z
         C/J5q+6ftW47TJ5HtcNZDqKl1mE75bBivyXCowOsdPq5zqgGmkwdN7TBV4saU/TcmWS/
         HtKQ==
X-Gm-Message-State: ANoB5pkOeEx6FgMPZr2uCX56hJSsCqpPbsffvNP1yORY1AbfwEuvRspd
        bYwbHp4Hhcy6j0oBBju7INqwOdgroA==
X-Google-Smtp-Source: AA0mqf7hwfyHvwdhrQp7v01ewBy/80KQA26D36WEUxDucx6nZ98MA0kdQwWAaK9ODXAheGNU1PSQ1Q==
X-Received: by 2002:a05:6808:905:b0:359:d97b:3f6f with SMTP id w5-20020a056808090500b00359d97b3f6fmr1809120oih.298.1668610611848;
        Wed, 16 Nov 2022 06:56:51 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b9-20020aca1b09000000b0035a64076e0bsm6120137oib.37.2022.11.16.06.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 06:56:51 -0800 (PST)
Received: (nullmailer pid 3839104 invoked by uid 1000);
        Wed, 16 Nov 2022 14:56:53 -0000
Date:   Wed, 16 Nov 2022 08:56:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        quic_srivasam@quicinc.com, quic_plai@quicinc.com,
        Banajit Goswami <bgoswami@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 11/11] ASoC: dt-bindings: qcom,q6apm: Add SM8450
 bedais node
Message-ID: <166861061277.3839048.4506198289493413753.robh@kernel.org>
References: <20221115120235.167812-1-krzysztof.kozlowski@linaro.org>
 <20221115120235.167812-12-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115120235.167812-12-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 15 Nov 2022 13:02:35 +0100, Krzysztof Kozlowski wrote:
> On SM8450 and SC8280XP, the Q6APM is a bit different:
> 1. It is used as a platform DAI link, so it needs #sound-dai-cells.
> 2. It has two DAI children, so add new "bedais" node.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Cc: quic_srivasam@quicinc.com
> Cc: quic_plai@quicinc.com
> ---
>  .../devicetree/bindings/sound/qcom,q6apm.yaml    | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
