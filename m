Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE8265CAD3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 01:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234322AbjADA3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 19:29:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjADA3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 19:29:08 -0500
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48835E8;
        Tue,  3 Jan 2023 16:29:08 -0800 (PST)
Received: by mail-il1-f180.google.com with SMTP id a9so6550429ilk.6;
        Tue, 03 Jan 2023 16:29:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7oFl9C+pdV8o+KMF9oxiGndE/yHy/VbU0fKzAvJ4LrQ=;
        b=cuPl1wJcat5HyvXofY/GK/lTevwwFf4uSauWSWPT7SM3diyATbnu2AH/N4qf878HUZ
         GJnUZKjczm/DNqercjrQwRvmLY7sqvEmpVZkYgzljf+CTIqqfgIIOX7ENd2wtXoKo55i
         Sxo3/oJ9VIRKchRv/VjmuTcFQmUA5R8iUKM2LSTuVCTDqtyINVN5aJG2ZGDKauX5NtE+
         gegVY4cedA62uUNtIw3jYzVEl8ztPvfbPTTt6oN87mrxzvjjjadPkKDgsdZhQBYG3ATg
         7v0eyBqSJkDgFcAFwWu+US23Y2kwraB0JrNOLtN1+Eyxtla+w+DF47aCVcMTP2WHl0Ln
         AvWA==
X-Gm-Message-State: AFqh2kqZWsz+IQYRP2xwbFCf1+4XJFwbf562lMQ5UWALRiluOHX32VKc
        w4mHXU1pdcDb6/pEYUllfQ==
X-Google-Smtp-Source: AMrXdXtT403stngUA7JGfIW3gdVGtgW+fbAfI4N20y5CYBCxGtOZUKCUGWgIkSQqAkYQIE8JGXUwnw==
X-Received: by 2002:a92:c085:0:b0:30c:f88:e807 with SMTP id h5-20020a92c085000000b0030c0f88e807mr17877427ile.6.1672792147532;
        Tue, 03 Jan 2023 16:29:07 -0800 (PST)
Received: from robh_at_kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id d5-20020a92ddc5000000b002faf6559e90sm10184711ilr.51.2023.01.03.16.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 16:29:07 -0800 (PST)
Received: (nullmailer pid 143313 invoked by uid 1000);
        Wed, 04 Jan 2023 00:29:05 -0000
Date:   Tue, 3 Jan 2023 18:29:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, robdclark@gmail.com,
        quic_abhinavk@quicinc.com, dmitry.baryshkov@linaro.org,
        sean@poorly.run, airlied@gmail.com, daniel@ffwll.ch,
        dianders@chromium.org, david@ixit.cz,
        krzysztof.kozlowski+dt@linaro.org, swboyd@chromium.org,
        konrad.dybcio@somainline.org, agross@kernel.org,
        andersson@kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 07/18] dt-bindings: display/msm: Add list of
 mdss-dsi-ctrl compats
Message-ID: <20230104002905.GA134092-robh@kernel.org>
References: <20221223021025.1646636-1-bryan.odonoghue@linaro.org>
 <20221223021025.1646636-8-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221223021025.1646636-8-bryan.odonoghue@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2022 at 02:10:14AM +0000, Bryan O'Donoghue wrote:
> Add the list of current compats absent the deprecated qcm2290 to the list
> of dsi compats listed here.
> 
> Several MDSS yaml files exist which document the dsi sub-node.
> For each existing SoC MDSS yaml, provide the right dsi compat string.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  .../bindings/display/msm/qcom,mdss.yaml          | 16 +++++++++++++++-
>  .../bindings/display/msm/qcom,msm8998-mdss.yaml  |  8 +++++---
>  .../bindings/display/msm/qcom,sc7180-mdss.yaml   |  6 ++++--
>  .../bindings/display/msm/qcom,sc7280-mdss.yaml   |  6 ++++--
>  .../bindings/display/msm/qcom,sdm845-mdss.yaml   |  8 +++++---
>  .../bindings/display/msm/qcom,sm8250-mdss.yaml   |  8 +++++---
>  6 files changed, 38 insertions(+), 14 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,mdss.yaml
> index ba0460268731b..86bb43489bf4a 100644
> --- a/Documentation/devicetree/bindings/display/msm/qcom,mdss.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/qcom,mdss.yaml
> @@ -94,7 +94,21 @@ patternProperties:
>      type: object
>      properties:
>        compatible:
> -        const: qcom,mdss-dsi-ctrl
> +        items:
> +          - enum:
> +              - qcom,apq8064-dsi-ctrl
> +              - qcom,msm8916-dsi-ctrl
> +              - qcom,msm8953-dsi-ctrl
> +              - qcom,msm8974-dsi-ctrl
> +              - qcom,msm8996-dsi-ctrl
> +              - qcom,msm8998-dsi-ctrl
> +              - qcom,qcm2290-dsi-ctrl
> +              - qcom,sc7180-dsi-ctrl
> +              - qcom,sc7280-dsi-ctrl
> +              - qcom,sdm660-dsi-ctrl
> +              - qcom,sdm845-dsi-ctrl
> +              - qcom,sm8250-dsi-ctrl
> +          - const: qcom,mdss-dsi-ctrl

No need to have an exact match here. Just this is enough:

compatible:
  contains:
    const: qcom,mdss-dsi-ctrl

Then the DSI schema will check the rest.

Same for the rest.

Rob
