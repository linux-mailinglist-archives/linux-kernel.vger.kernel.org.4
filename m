Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8629364367B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 22:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbiLEVId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 16:08:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232501AbiLEVII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 16:08:08 -0500
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC2B9594;
        Mon,  5 Dec 2022 13:08:04 -0800 (PST)
Received: by mail-oi1-f169.google.com with SMTP id v70so6148367oie.3;
        Mon, 05 Dec 2022 13:08:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h7D2s6NnE8vYMQ/1od1mZ431L8A1FEXOo9mtdMb467A=;
        b=E0HugYwOYGyGS7q0pHLqRKdKlki6jBpe3ficsDYyzh4FCnjL1NhhGi/q8EGTW2tfZJ
         a1hWpPbfEw6oE+NdnDPVR/uskdCHFesVgLZXe4Bil+56OMU9rGoRdyc4rj8eVal2WQj+
         tckb9qdcyI4hKOrZUQH7qSMdxOxdZF5xW4FvWNTuOe6aFCIA58mV/n9N6+s300YUUesQ
         fRajpwSenrQdP8iyGEcNDqZtCYOHyOZicbvNNJiW3Adr63hFXiVUbaUYjHi5oxTG65Ej
         mfDMt5Z5FyQ2nGV8FCZB88GU1H/dbSz+7OKX+TtdHW14dEcWJQN68TDtVt3AHqLCOHoy
         6HaQ==
X-Gm-Message-State: ANoB5pnlAzJ9/VR1cEXs3qjloFdkULna9yi7H06SK0EfQlL6Y4QXEZg8
        zTjXdxXl3ekXUsxLRtZ0Sw==
X-Google-Smtp-Source: AA0mqf7kB79NxvQBbpUMIQzxzhMvhuENJ0k1IumtXLM2ePDNaBA7cCNBU9POc3JkyXDrBtrsmYCj2w==
X-Received: by 2002:a05:6808:1902:b0:35d:d646:3d00 with SMTP id bf2-20020a056808190200b0035dd6463d00mr1388934oib.194.1670274483639;
        Mon, 05 Dec 2022 13:08:03 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j8-20020aca3c08000000b0035c21f1a570sm3252935oia.6.2022.12.05.13.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 13:08:03 -0800 (PST)
Received: (nullmailer pid 2623860 invoked by uid 1000);
        Mon, 05 Dec 2022 21:08:02 -0000
Date:   Mon, 5 Dec 2022 15:08:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Robert Foss <robert.foss@linaro.org>
Cc:     freedreno@lists.freedesktop.org, robdclark@gmail.com,
        devicetree@vger.kernel.org, sean@poorly.run,
        quic_jesszhan@quicinc.com, loic.poulain@linaro.org,
        konrad.dybcio@somainline.org, airlied@linux.ie, agross@kernel.org,
        angelogioacchino.delregno@somainline.org,
        dmitry.baryshkov@linaro.org, andersson@kernel.org,
        bjorn.andersson@linaro.org, vinod.koul@linaro.org,
        vkoul@kernel.org, dianders@chromium.org, daniel@ffwll.ch,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        robh+dt@kernel.org, quic_abhinavk@quicinc.com,
        quic_vpolimer@quicinc.com, krzysztof.kozlowski+dt@linaro.org,
        quic_kalyant@quicinc.com, Jonathan Marek <jonathan@marek.ca>
Subject: Re: [PATCH v3 02/11] dt-bindings: display: msm: Add qcom,sm8350-mdss
 binding
Message-ID: <167027448138.2623801.7062789699923957275.robh@kernel.org>
References: <20221205163754.221139-1-robert.foss@linaro.org>
 <20221205163754.221139-3-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221205163754.221139-3-robert.foss@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 05 Dec 2022 17:37:45 +0100, Robert Foss wrote:
> Mobile Display Subsystem (MDSS) encapsulates sub-blocks
> like DPU display controller, DSI etc. Add YAML schema for MDSS device
> tree bindings
> 
> Signed-off-by: Robert Foss <robert.foss@linaro.org>
> ---
>  .../display/msm/qcom,sm8350-mdss.yaml         | 221 ++++++++++++++++++
>  1 file changed, 221 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,sm8350-mdss.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
