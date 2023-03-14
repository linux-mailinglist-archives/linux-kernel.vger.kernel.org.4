Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4686B95CA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 14:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbjCNNQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 09:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbjCNNQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 09:16:36 -0400
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [IPv6:2001:4b7a:2000:18::164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359A1A0F08;
        Tue, 14 Mar 2023 06:13:14 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 6B2F4203B0;
        Tue, 14 Mar 2023 14:13:11 +0100 (CET)
Date:   Tue, 14 Mar 2023 14:13:10 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 09/10] dt-bindings: display/msm: dsi-controller-main:
 Add SM6115
Message-ID: <20230314131310.2yjzxfe4bqfuku3m@SoMainline.org>
References: <20230307-topic-dsi_qcm-v4-0-54b4898189cb@linaro.org>
 <20230307-topic-dsi_qcm-v4-9-54b4898189cb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307-topic-dsi_qcm-v4-9-54b4898189cb@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-14 13:13:47, Konrad Dybcio wrote:
> Add a compatible for the DSI on SM6115.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Example is nice and tidy now, thanks!

Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>

> ---
>  .../devicetree/bindings/display/msm/dsi-controller-main.yaml   |  2 ++
>  .../devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml      | 10 ++++++++--
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> index 94f4cdf88c95..d534451c8f7f 100644
> --- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> @@ -25,6 +25,7 @@ properties:
>                - qcom,sc7280-dsi-ctrl
>                - qcom,sdm660-dsi-ctrl
>                - qcom,sdm845-dsi-ctrl
> +              - qcom,sm6115-dsi-ctrl
>                - qcom,sm8150-dsi-ctrl
>                - qcom,sm8250-dsi-ctrl
>                - qcom,sm8350-dsi-ctrl
> @@ -351,6 +352,7 @@ allOf:
>            contains:
>              enum:
>                - qcom,sdm845-dsi-ctrl
> +              - qcom,sm6115-dsi-ctrl
>      then:
>        properties:
>          clocks:
> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml
> index 2491cb100b33..b9f83088f370 100644
> --- a/Documentation/devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml
> @@ -40,7 +40,13 @@ patternProperties:
>      type: object
>      properties:
>        compatible:
> -        const: qcom,dsi-ctrl-6g-qcm2290
> +        oneOf:
> +          - items:
> +              - const: qcom,sm6115-dsi-ctrl
> +              - const: qcom,mdss-dsi-ctrl
> +          - description: Old binding, please don't use
> +            deprecated: true
> +            const: qcom,dsi-ctrl-6g-qcm2290
>  
>    "^phy@[0-9a-f]+$":
>      type: object
> @@ -114,7 +120,7 @@ examples:
>          };
>  
>          dsi@5e94000 {
> -            compatible = "qcom,dsi-ctrl-6g-qcm2290";
> +            compatible = "qcom,sm6115-dsi-ctrl", "qcom,mdss-dsi-ctrl";
>              reg = <0x05e94000 0x400>;
>              reg-names = "dsi_ctrl";
>  
> 
> -- 
> 2.39.2
> 
