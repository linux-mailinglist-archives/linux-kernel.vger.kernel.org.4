Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7626638C5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 06:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjAJFta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 00:49:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbjAJFsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 00:48:39 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC39431AA
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 21:47:32 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id bp15so16610706lfb.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 21:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sjlcbVEgS5pgrAjtiDRiz81od9MScN0SBmwZV8y/lIs=;
        b=SrXc9fMrzGJBPKtaDr9H/2PtiGIoWp7vzGiZa3QXIVOzdnPNHj+Gg3cJhcKmPhWPGk
         zFF5piQbTPqBRWYVrybTXvmOygaq6XMEUqck6aapxH45bbqyIEoN15UpW4iyFXs1fJe9
         juKrr+tPimFaqDGwJmbMHXl/vMM6U8WwtkI/iO+tsqtoYPuFKE7dvrfIZyGL6Ds9cr1T
         WLCdsk1LfMuAZQNXx7QO315gx6CHEvWsILN9xy7iy3f4eH78fjmIjx2jVvZSQar7BF9l
         deIcihzYmhuV+Q8My/N/kxKeCBKV84kSTuLWUIykCl8DR42FimSk8U/R/z28AhyJt5MP
         MZQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sjlcbVEgS5pgrAjtiDRiz81od9MScN0SBmwZV8y/lIs=;
        b=bFSRzWll/QGf/rtVmspY2VVDSx5wbozq403x32988nnguT2aloNIeFIAt7MyTl05on
         UYR+VgnE1dBrWpuoezw1V5oJcTb7p5KhKf0NML1ubPmxfO6USLXDRd3IZG9fBq9N4fn8
         2+TwSdOkjueyipq8pHY8xeKYVJmMZ54h9OttcLAK/SaWQQsZ92hBZenbSu5FxJzynS9x
         MoALuKF0j2EZ/aaolRzI3RTxac2n8ei4f09B53wuS68wIGtD9poMHkwyMccH41C5wuH5
         xnOtRNJTX+3eW/yCaSGWbD9fbnpm/qdRaCDn59yXfr3VBNdKC+l37HKgEROEL7AzfA9t
         3wDg==
X-Gm-Message-State: AFqh2krB3a9+wS/115fVUs5+3SgiYAs0+3BqlLOftIhcrXQ4crYPcSFM
        pGNkEt3jjM0IznSayNVOr0Dsaw==
X-Google-Smtp-Source: AMrXdXuwuTdxaEcEUK1aqTKbAxOoMfEtFDgOViKB9zqN6QGZvAv1BcY7LatZ/ouCEGtzFXpln7UQBw==
X-Received: by 2002:a05:6512:6d6:b0:4a4:68b9:609b with SMTP id u22-20020a05651206d600b004a468b9609bmr22353836lff.38.1673329650416;
        Mon, 09 Jan 2023 21:47:30 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id cf33-20020a056512282100b004a05767bc07sm2006201lfb.28.2023.01.09.21.47.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 21:47:29 -0800 (PST)
Message-ID: <fc525e85-c271-3912-f19b-25a9e90dc2a9@linaro.org>
Date:   Tue, 10 Jan 2023 07:47:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v6 05/18] dt-bindings: msm: dsi-controller-main: Document
 clocks on a per compatible basis
Content-Language: en-GB
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org
Cc:     robdclark@gmail.com, quic_abhinavk@quicinc.com, sean@poorly.run,
        airlied@gmail.com, daniel@ffwll.ch, robh+dt@kernel.org,
        dianders@chromium.org, david@ixit.cz,
        krzysztof.kozlowski+dt@linaro.org, swboyd@chromium.org,
        konrad.dybcio@somainline.org, agross@kernel.org,
        andersson@kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20221223021025.1646636-1-bryan.odonoghue@linaro.org>
 <20221223021025.1646636-6-bryan.odonoghue@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221223021025.1646636-6-bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/12/2022 04:10, Bryan O'Donoghue wrote:
> Each compatible has a different set of clocks which are associated with it.
> Add in the list of clocks for each compatible.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>   .../display/msm/dsi-controller-main.yaml      | 209 ++++++++++++++++--
>   1 file changed, 192 insertions(+), 17 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> index 98d54a7ee28d4..4b79b31123515 100644
> --- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> @@ -9,9 +9,6 @@ title: Qualcomm Display DSI controller
>   maintainers:
>     - Krishna Manikandan <quic_mkrishn@quicinc.com>
>   
> -allOf:
> -  - $ref: "../dsi-controller.yaml#"
> -
>   properties:
>     compatible:
>       oneOf:
> @@ -46,22 +43,23 @@ properties:
>       maxItems: 1
>   
>     clocks:
> -    items:
> -      - description: Display byte clock
> -      - description: Display byte interface clock
> -      - description: Display pixel clock
> -      - description: Display core clock
> -      - description: Display AHB clock
> -      - description: Display AXI clock
> +    description: |
> +      Several clocks are used, depending on the variant. Typical ones are::
> +       - bus:: Display AHB clock.
> +       - byte:: Display byte clock.
> +       - byte_intf:: Display byte interface clock.
> +       - core:: Display core clock.
> +       - core_mss:: Core MultiMedia SubSystem clock.
> +       - iface:: Display AXI clock.
> +       - mdp_core:: MDP Core clock.
> +       - mnoc:: MNOC clock
> +       - pixel:: Display pixel clock.
> +    minItems: 3
> +    maxItems: 9
>   
>     clock-names:
> -    items:
> -      - const: byte
> -      - const: byte_intf
> -      - const: pixel
> -      - const: core
> -      - const: iface
> -      - const: bus
> +    minItems: 3
> +    maxItems: 9
>   
>     phys:
>       maxItems: 1
> @@ -157,6 +155,183 @@ required:
>     - assigned-clock-parents
>     - ports
>   
> +allOf:
> +  - $ref: ../dsi-controller.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,apq8064-dsi-ctrl
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 7
> +        clock-names:
> +          items:
> +            - const: iface
> +            - const: bus
> +            - const: core_mmss
> +            - const: src
> +            - const: byte
> +            - const: pixel
> +            - const: core
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,msm8916-dsi-ctrl
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 6
> +        clock-names:
> +          items:
> +            - const: mdp_core
> +            - const: iface
> +            - const: bus
> +            - const: byte
> +            - const: pixel
> +            - const: core
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,msm8953-dsi-ctrl
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 6
> +        clock-names:
> +          items:
> +            - const: mdp_core
> +            - const: iface
> +            - const: bus
> +            - const: byte
> +            - const: pixel
> +            - const: core
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,msm8974-dsi-ctrl
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 3
> +        clock-names:
> +          items:
> +            - const: iface
> +            - const: bus
> +            - const: vsync

8974 has broader clocks list:

@@ -244,12 +248,16 @@ allOf:
      then:
        properties:
          clocks:
-          maxItems: 3
+          maxItems: 7
          clock-names:
            items:
+            - const: mdp_core
              - const: iface
              - const: bus
-            - const: vsync
+            - const: byte
+            - const: pixel
+            - const: core
+            - const: core_mmss


> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,msm8996-dsi-ctrl
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 7
> +        clock-names:
> +          items:
> +            - const: mdp_core
> +            - const: byte
> +            - const: iface
> +            - const: bus
> +            - const: core_mmss
> +            - const: pixel
> +            - const: core
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,msm8998-dsi-ctrl
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 6
> +        clock-names:
> +          items:
> +            - const: byte
> +            - const: byte_intf
> +            - const: pixel
> +            - const: core
> +            - const: iface
> +            - const: bus
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,sc7180-dsi-ctrl
> +              - qcom,sc7280-dsi-ctrl
> +              - qcom,sm8250-dsi-ctrl

Could you please also add sm8150 and sm8[345]50?

> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 6
> +        clock-names:
> +          items:
> +            - const: byte
> +            - const: byte_intf
> +            - const: pixel
> +            - const: core
> +            - const: iface
> +            - const: bus
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,sdm660-dsi-ctrl
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 9
> +        clock-names:
> +          items:
> +            - const: mdp_core
> +            - const: byte
> +            - const: byte_intf
> +            - const: mnoc
> +            - const: iface
> +            - const: bus
> +            - const: core_mmss
> +            - const: pixel
> +            - const: core
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,sdm845-dsi-ctrl
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 6
> +        clock-names:
> +          items:
> +            - const: byte
> +            - const: byte_intf
> +            - const: pixel
> +            - const: core
> +            - const: iface
> +            - const: bus
> +
>   additionalProperties: false
>   
>   examples:

-- 
With best wishes
Dmitry

