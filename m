Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD49F6B1E0F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 09:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjCII3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 03:29:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbjCII2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 03:28:51 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC5CEB89D
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 00:26:41 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id cy23so3708998edb.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 00:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678350395;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wu8DwsqsqfKPKGEkJB9iRAr5gDSdJd+ozW53J8HXH2k=;
        b=mjXLqCtz5Wx9vHDpCtORqHRtbK7NBTn8AF25cuWdHPh6ZSUioLBtES4qfnst0aHZam
         xAzcwxm2JlmhdPZ+oTY8Bsj2CzJh+j3WeIjQ9lP7I8fNNA30V0WFIYt/o9LWOJtftFn/
         rpBptk46k8qfjNKhT81s/BMsqUVZy6jgNxClSgb8fXAVGsczXkyCSpU9TF0OtVHY32BJ
         DBpwZ6ZEFi4fX8rY4k4/5uv/jxXhgr7CV+Rb5BDqKOnn8lH+ndPXaSph88C1bDQ4sq4l
         6wRzbTxAWF0LTjEAReNvHSmq3tlzRl/b84prTms5fOCSw06U2TsiSd+eS3kXNiOP6sWu
         V4Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678350395;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wu8DwsqsqfKPKGEkJB9iRAr5gDSdJd+ozW53J8HXH2k=;
        b=EsDqEyTne2x4laU1BKdWKXpjqSHochsT/78h8ffTUoP2DHdT+Q/LXc+VuJalWuHMNK
         PaO1I1SQ4usbhUIYHuGczECdva2zmnlPBw283TQGUCT7GWud+9gfKupm1aRcgv2t/MoC
         YbuZOG/Z3OuYJ5McSNdxiSQumrkbLWyhxoCFlIEy/XXQ0c6GxLX1PUFsa7uKWYyvrIf0
         LxR3/AkCpltjVNq+ABwJqHKiSXRIlOKuICjkmuozkaB77hW22hWloDSRpp5xiR+usKcN
         AfUtaa3K98O6USogyKSRb2vhEYkWEAPDJBD3PBVn7emlK4nxwnCEt/LFtonBylV6SWt4
         0PWA==
X-Gm-Message-State: AO0yUKUQ2HxFgS+J9UU+2CQxcz+vD/+gv/l5MoviqrtqsKmqsWH7fm52
        BSAUvE/A+QPsarwHxzwkIF60Cw==
X-Google-Smtp-Source: AK7set/JVbDVD2QiBnl1Ztxd5l85KNjzT5jJF+Dn+W2fce5O8vrQOWLCaKJi9mG1tcKxWTsQY6REyw==
X-Received: by 2002:a17:907:2ce1:b0:8b1:32dd:3af with SMTP id hz1-20020a1709072ce100b008b132dd03afmr28905926ejc.28.1678350394825;
        Thu, 09 Mar 2023 00:26:34 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:7ee2:e73e:802e:45c1? ([2a02:810d:15c0:828:7ee2:e73e:802e:45c1])
        by smtp.gmail.com with ESMTPSA id ca5-20020a170906a3c500b008bc2c2134c5sm8528879ejb.216.2023.03.09.00.26.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 00:26:34 -0800 (PST)
Message-ID: <7cbd882d-c71c-ad92-6dbe-0f178043fdfd@linaro.org>
Date:   Thu, 9 Mar 2023 09:26:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/2] dt-bindings: remoteproc: qcom: Add sm6115 pas yaml
 file
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org
Cc:     mani@kernel.org, mathieu.poirier@linaro.org, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhupesh.linux@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
References: <20230128053504.2099620-1-bhupesh.sharma@linaro.org>
 <20230128053504.2099620-2-bhupesh.sharma@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230128053504.2099620-2-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/01/2023 06:35, Bhupesh Sharma wrote:
> This documents the aDSP, cDSP and MPSS DSPs present
> on the SM6115 SoC.
> 
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  .../bindings/remoteproc/qcom,sm6115-pas.yaml  | 143 ++++++++++++++++++
>  1 file changed, 143 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sm6115-pas.yaml
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sm6115-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sm6115-pas.yaml
> new file mode 100644
> index 000000000000..f5d1fa9f45f1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,sm6115-pas.yaml
> @@ -0,0 +1,143 @@
> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/remoteproc/qcom,sm6115-pas.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm SM6115 Peripheral Authentication Service
> +
> +maintainers:
> +  - Bhupesh Sharma <bhupesh.sharma@linaro.org>
> +
> +description:
> +  Qualcomm SM6115 SoC Peripheral Authentication Service loads and boots
> +  firmware on the Qualcomm DSP Hexagon cores.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,sm6115-adsp-pas
> +      - qcom,sm6115-cdsp-pas
> +      - qcom,sm6115-mpss-pas
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: XO clock
> +
> +  clock-names:
> +    items:
> +      - const: xo
> +
> +  memory-region:
> +    minItems: 1

maxItems instead

> +    description: Reference to the reserved-memory for the Hexagon core
> +
> +  smd-edge: false
> +
> +  firmware-name:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description: Firmware name for the Hexagon core
> +
> +required:
> +  - compatible
> +  - reg

also memory-region


Best regards,
Krzysztof

