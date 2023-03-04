Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C786AAB52
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 17:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjCDQ70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 11:59:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCDQ7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 11:59:24 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BFC1422F
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 08:59:23 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id ay29-20020a05600c1e1d00b003e9f4c2b623so5701924wmb.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 Mar 2023 08:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677949161;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3hZJhaTdSbx5SAhlYomj5DCnJLkk+FlTPENqwit04iA=;
        b=Ob9YQEeDG9Lk1DPv8btDYIE1+l7NEf98lMpzM/BO4BvhE4XH9Y89bn6qyWd8JvqF9B
         972C5kQZwBeBlSrzfQDUE3EYOc0SE6XzEFy1UqRw1XTVo2UysqVYu+q78ws2jrCShla4
         d9neSojbjmt9sjZFtXtphO/TqQ79g/5ha5DQQ4LL1lMKTATOi3Ej+236zd7MB6+qt4BC
         u7O1dvYiOYXIyLcQrunWfHmIdonwdGKHed4CISK5u9KqUyzfMCBycIdIk8rPvYSp90P0
         GtDXiEJGmGYAgsMwucGldlmNVSHRzzKwAWeTJdWJuE3FmyoHx9SNvO0E/362glqRvW7P
         fXbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677949161;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3hZJhaTdSbx5SAhlYomj5DCnJLkk+FlTPENqwit04iA=;
        b=3L3Gj8jXuCUot4y7uR9EKvwcPZTl2DLkgrrThr49MAmn8xDo2hUPfzwNDa9fyYtLtQ
         Hj1yXFk6hW5weh4vsF8jt33JKKWXZWaRWIYngidiEuxlxoWHITcLSZpj4GT0UyFhhMFp
         UW/U3tRDbF7LZxuPvzAma2gXTL/cE4zQRbIVVgSp2qraN9ehCcb7BW7k3LYsOXGCoVMh
         pw0823bpOgq+GdDru2+tUsnKmbebuHUWIuV7qL1x357z/7ffy7DEN17AL9E8VQ9lWwXU
         9ljBKFYe5zhko5jhe/7D4Cz0WhK3CLsrZD6aieIr2KjAITPoYj5Zc4YUI8rbg1ISEiYP
         QeDQ==
X-Gm-Message-State: AO0yUKV7PrccT1COGJBmpII61SmzqxhQy5jTY5Gi+MssTAtMZGxbRw3D
        Tx3fEMOJlBg9KQGvsO7b//0R9Ts7Cm6JH8b7lck=
X-Google-Smtp-Source: AK7set/VhU5XG+hFSJa255qEqLLewO2xktt/9Ut9f03wFAXIAXZFmNkbR/mXXoQwXvv1qPzbJ+c2og==
X-Received: by 2002:a05:600c:190b:b0:3ea:e7f6:f8f9 with SMTP id j11-20020a05600c190b00b003eae7f6f8f9mr4939505wmq.19.1677949161497;
        Sat, 04 Mar 2023 08:59:21 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id j6-20020a05600c42c600b003eb192787bfsm5555843wme.25.2023.03.04.08.59.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Mar 2023 08:59:21 -0800 (PST)
Message-ID: <c1a2ba5b-4cd9-362b-5a4e-e95a6bf27b3e@linaro.org>
Date:   Sat, 4 Mar 2023 16:59:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 1/2] dt-bindings: display/msm: dsi-controller-main: Fix
 deprecated compatible
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>
Cc:     Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230304-topic-dsi_fixup-v3-0-b8565944d0e6@linaro.org>
 <20230304-topic-dsi_fixup-v3-1-b8565944d0e6@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230304-topic-dsi_fixup-v3-1-b8565944d0e6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/03/2023 15:55, Konrad Dybcio wrote:
> The point of the previous cleanup was to disallow "qcom,mdss-dsi-ctrl"
> alone. This however didn't quite work out and the property became
> undocumented instead of deprecated. Fix that.
> 
> Fixes: 0c0f65c6dd44 ("dt-bindings: msm: dsi-controller-main: Add compatible strings for every current SoC")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> index f195530ae964..d534451c8f7f 100644
> --- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> @@ -35,7 +35,7 @@ properties:
>         - items:
>             - enum:
>                 - qcom,dsi-ctrl-6g-qcm2290
> -          - const: qcom,mdss-dsi-ctrl
> +              - qcom,mdss-dsi-ctrl # This should always come with an SoC-specific compatible
>           deprecated: true
>   
>     reg:
> 

This change would make compatible = "qcom,dsi-ctrl-6g-qcm2290", 
"qcom,mdss-dsi-ctrl"; break though

Take this example, I'm going to use 8916 because its easy.

If we apply your change to dsi-controller-main.yaml

diff --git 
a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml 
b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
index e75a3efe4dace..e93c16431f0a1 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
@@ -34,7 +34,7 @@ properties:
        - items:
            - enum:
                - dsi-ctrl-6g-qcm2290
-          - const: qcom,mdss-dsi-ctrl
+              - qcom,mdss-dsi-ctrl
          deprecated: true

    reg:

and then make 8916 == compatible = "qcom,dsi-ctrl-6g-qcm2290", 
"qcom,mdss-dsi-ctrl";

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi 
b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 0733c2f4f3798..7332b5f66a09d 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -1094,7 +1094,7 @@ mdp5_intf1_out: endpoint {
                         };

                         dsi0: dsi@1a98000 {
-                               compatible = "qcom,msm8916-dsi-ctrl",
+                               compatible = "dsi-ctrl-6g-qcm2290",
                                              "qcom,mdss-dsi-ctrl";
                                 reg = <0x01a98000 0x25c>;
                                 reg-names = "dsi_ctrl";

arch/arm64/boot/dts/qcom/apq8016-sbc.dtb: dsi@1a98000: compatible: 
'oneOf' conditional failed, one must be fixed:
	['dsi-ctrl-6g-qcm2290', 'qcom,mdss-dsi-ctrl'] is too long


so compatible = "qcom,dsi-ctrl-6g-qcm2290", "qcom,mdss-dsi-ctrl"; is now 
invalid, not deprecated.

This change also makes compatible = "qcom,dsi-ctrl-6g-qcm2290" or 
compatible = "qcom,mdss-dsi-ctrl" standalone valid compatible which is 
again not what we want.

- enum:
     - qcom,dsi-ctrl-6g-qcm2290
     - qcom,mdss-dsi-ctrl

means either "qcom,dsi-ctrl-6g-qcm2290" or "qcom,mdss-dsi-ctrl" are 
valid compat strings...

As an example if you apply your change and then change the msm8916.dtsi 
to the below

diff --git 
a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml 
b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
index e75a3efe4dace..e93c16431f0a1 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
@@ -34,7 +34,7 @@ properties:
        - items:
            - enum:
                - dsi-ctrl-6g-qcm2290
-          - const: qcom,mdss-dsi-ctrl
+              - qcom,mdss-dsi-ctrl
          deprecated: true

    reg:
diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi 
b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 0733c2f4f3798..829fbe05b5713 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -1094,8 +1094,7 @@ mdp5_intf1_out: endpoint {
                         };

                         dsi0: dsi@1a98000 {
-                               compatible = "qcom,msm8916-dsi-ctrl",
-                                            "qcom,mdss-dsi-ctrl";
+                               compatible = "qcom,mdss-dsi-ctrl";
                                 reg = <0x01a98000 0x25c>;
                                 reg-names = "dsi_ctrl";

Then test it with

make O=$BUILDDIR DT_DOC_CHECKER=$DT_DOC_CHECKER 
DT_EXTRACT_EX=$DT_EXTRACT_EX DT_MK_SCHEMA=$DT_MK_SCHEMA 
DT_CHECKER=$DT_CHECKER CHECKER_FLAGS=-W=1 CHECK_DTBS=y qcom/apq8016-sbc.dtb

you'll see no error. However if you just do this

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi 
b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 0733c2f4f3798..829fbe05b5713 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -1094,8 +1094,7 @@ mdp5_intf1_out: endpoint {
                         };

                         dsi0: dsi@1a98000 {
-                               compatible = "qcom,msm8916-dsi-ctrl",
-                                            "qcom,mdss-dsi-ctrl";
+                               compatible = "qcom,mdss-dsi-ctrl";
                                 reg = <0x01a98000 0x25c>;
                                 reg-names = "dsi_ctrl";


and run the same test you get

apq8016-sbc.dtb: dsi@1a98000: compatible: 'oneOf' conditional failed, 
one must be fixed:
	['qcom,mdss-dsi-ctrl'] is too short
	'qcom,mdss-dsi-ctrl' is not one of ['qcom,apq8064-dsi-ctrl', 
'qcom,msm8916-dsi-ctrl', 'qcom,msm8953-dsi-ctrl', 
'qcom,msm8974-dsi-ctrl', 'qcom,msm8996-dsi-ctrl', 
'qcom,msm8998-dsi-ctrl', 'qcom,qcm2290-dsi-ctrl', 
'qcom,sc7180-dsi-ctrl', 'qcom,sc7280-dsi-ctrl', 'qcom,sdm660-dsi-ctrl', 
'qcom,sdm845-dsi-ctrl', 'qcom,sm8150-dsi-ctrl', 'qcom,sm8250-dsi-ctrl', 
'qcom,sm8350-dsi-ctrl', 'qcom,sm8450-dsi-ctrl', 'qcom,sm8550-dsi-ctrl']

---
bod
