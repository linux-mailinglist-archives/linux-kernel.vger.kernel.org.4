Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F2C670B74
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 23:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjAQWMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 17:12:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjAQWKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 17:10:32 -0500
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C487627D66;
        Tue, 17 Jan 2023 12:21:24 -0800 (PST)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-1322d768ba7so33226730fac.5;
        Tue, 17 Jan 2023 12:21:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DK6EUVXiVoF71ZLpplwDGzXo79prqUrJw7XBoWZcTs8=;
        b=gtU9I15LhrJLiT6znHlVTBaLzLWRkg0TEbexumLUE/BibJMAfpQKZ6ZqTeDK7CTNe7
         Wk4DxzLQrc3gDJXMjVS6v/mwBcNz5215Qw8klrRpTvNBpaRIAPzhS1fjlpQ5bJgc4DJJ
         wovpMmD7pF5eDjJMNRCE2S3KViETUzOIppC7Rgw5csWIgbjrKRcaa2YAqludTAGSjBFV
         pvyFJZKC0onr0yaRItc/F+1WVvSkI4d+8MbAHWnUpt+EZah0EqoJu+gu/F58hIabBrWE
         S7h2gNM6aQ/M8lrzo1rao+vHLjH1n3VsrbiljoPDgG/3Ict5Dj+a2+1aML/naSgYYfWT
         +mqg==
X-Gm-Message-State: AFqh2kr7tD5KJwAHAcLFog+XAIQjGp9694IzWSQhnBlj/umfOtrrRteb
        M0KW8wXIqmC4gElAg1EuUQ==
X-Google-Smtp-Source: AMrXdXuCptqQO49Wnk2iCANx4q2uWgP0CeAClw4Io8/MCaW/ZeiGmADjQhFwlr2Yvix9oRBsSVtN6g==
X-Received: by 2002:a05:6870:be90:b0:144:d065:578e with SMTP id nx16-20020a056870be9000b00144d065578emr2778298oab.15.1673986883967;
        Tue, 17 Jan 2023 12:21:23 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l15-20020a4ad9cf000000b004fa6789a085sm722442oou.45.2023.01.17.12.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 12:21:23 -0800 (PST)
Received: (nullmailer pid 3643082 invoked by uid 1000);
        Tue, 17 Jan 2023 20:21:22 -0000
Date:   Tue, 17 Jan 2023 14:21:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     robh+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        quic_abhinavk@quicinc.com, freedreno@lists.freedesktop.org,
        dmitry.baryshkov@linaro.org, swboyd@chromium.org, daniel@ffwll.ch,
        david@ixit.cz, konrad.dybcio@somainline.org, robdclark@gmail.com,
        airlied@gmail.com, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, andersson@kernel.org,
        dianders@chromium.org, agross@kernel.org, sean@poorly.run
Subject: Re: [PATCH v8 1/3] dt-bindings: msm: dsi-controller-main: Add
 compatible strings for every current SoC
Message-ID: <167398688215.3643022.13982729074970285092.robh@kernel.org>
References: <20230116225217.1056258-1-bryan.odonoghue@linaro.org>
 <20230116225217.1056258-2-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230116225217.1056258-2-bryan.odonoghue@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 16 Jan 2023 22:52:15 +0000, Bryan O'Donoghue wrote:
> Currently we do not differentiate between the various users of the
> qcom,mdss-dsi-ctrl. The driver is flexible enough to operate from one
> compatible string but, the hardware does have some significant differences
> in the number of clocks.
> 
> To facilitate documenting the clocks add the following compatible strings
> 
> - qcom,apq8064-dsi-ctrl
> - qcom,msm8916-dsi-ctrl
> - qcom,msm8953-dsi-ctrl
> - qcom,msm8974-dsi-ctrl
> - qcom,msm8996-dsi-ctrl
> - qcom,msm8998-dsi-ctrl
> - qcom,sc7180-dsi-ctrl
> - qcom,sc7280-dsi-ctrl
> - qcom,sdm660-dsi-ctrl
> - qcom,sdm845-dsi-ctrl
> - qcom,sm8150-dsi-ctrl
> - qcom,sm8250-dsi-ctrl
> - qcom,sm8350-dsi-ctrl
> - qcom,sm8450-dsi-ctrl
> - qcom,sm8550-dsi-ctrl
> - qcom,qcm2290-dsi-ctrl
> 
> Deprecate qcom,dsi-ctrl-6g-qcm2290 in favour of the desired format while we
> do so.
> 
> Several MDSS yaml files exist which document the dsi sub-node.
> For each existing SoC MDSS yaml, provide the right dsi compat string.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  .../display/msm/dsi-controller-main.yaml      | 30 ++++++++++++++++---
>  .../bindings/display/msm/qcom,mdss.yaml       |  3 +-
>  .../display/msm/qcom,msm8998-mdss.yaml        |  8 +++--
>  .../display/msm/qcom,sc7180-mdss.yaml         |  6 ++--
>  .../display/msm/qcom,sc7280-mdss.yaml         |  6 ++--
>  .../display/msm/qcom,sdm845-mdss.yaml         |  8 +++--
>  .../display/msm/qcom,sm8150-mdss.yaml         |  8 +++--
>  .../display/msm/qcom,sm8250-mdss.yaml         |  8 +++--
>  .../display/msm/qcom,sm8350-mdss.yaml         |  6 ++--
>  .../display/msm/qcom,sm8450-mdss.yaml         |  4 ++-
>  10 files changed, 63 insertions(+), 24 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
