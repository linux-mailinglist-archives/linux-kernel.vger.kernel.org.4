Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1266A9491
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 10:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjCCJzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 04:55:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjCCJza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 04:55:30 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C793230B2B
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 01:55:26 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id cw28so8033550edb.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 01:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677837325;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vcI9TwKeql7BEK1sJIRMqGKUdiKBhH06Xafoh6GvtOY=;
        b=nV3ygc6++KEALlPvrCi/LzP/zqVtODcKrm2ci3aPLG7xZhFB701k2yIDEhfjZcEhE4
         AAhPxw1QOuIa8o3cVU4jU1ajdZd7+9PPVYYH0fTK6WzPz8lWJfDfDgRrcMuAaIaJEoQI
         94+us00zm4xpazZjUaX/Y0Khzztzh2y/fduLKZPC6UW7GX19w451IqC451Ehw2lB/Wtd
         YKG9A+iY5IVJbrvt9r8pUsBd2eGVimX9PgEap/eYWqcoshRD7MlkLmQjg52ERd9lad9U
         A5tk/bN1PJ8TrSB2oZpiUCqN0h/UPbx64HQvV3myN+kSefGrJ2P+cMwB8NUagZ5YlmUe
         OFSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677837325;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vcI9TwKeql7BEK1sJIRMqGKUdiKBhH06Xafoh6GvtOY=;
        b=I3vtO5udZ9KQ98bzmrWdxO9XZmEQN0D/2kH7f4qTRXovxR0Nuot9/mNvc5pHFRK5jN
         /PY0BdHLmKnsHdz11UummLFUnm0vlgvtHn2+D6jcl/osBPzVIKIG69wNZFU3FzVRPFyO
         PSe3kOECvdfJxScxXE4h15G/03hpoFunNEIKc/wjm/MjISODJA9K+CRFJ0/bpP0gNHp4
         IKtNUk8gD998fxghJ8WzouYqDzC5uo9Z13cknqFzoVHb63xfOJDxHmRzlnUWDxl7C20w
         g7fJHtc3/fV3WZOgM07sCHFtLyOV1KMEetHGwpVFFzlzzKIIDX+eCVbRD1iJcuGjIo/i
         fjyA==
X-Gm-Message-State: AO0yUKV/1kaIDatgh5a6NtLqyqXzh1Wb23SpJcP59LrTSdKsPqr0bjNE
        i7+KSwXDI9Msq4uqFFVg36QhxQ==
X-Google-Smtp-Source: AK7set/ny4L1u0FncdnBsIrArL6/bdtnybsH8zYJlQ/du/6yDCErh0hTkh1Nsd2BHS3zVK4BhOKRpA==
X-Received: by 2002:aa7:d347:0:b0:4ae:e51e:9e3e with SMTP id m7-20020aa7d347000000b004aee51e9e3emr1147431edr.24.1677837325252;
        Fri, 03 Mar 2023 01:55:25 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id l3-20020aa7cac3000000b004af6f37d25bsm932016edt.76.2023.03.03.01.55.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 01:55:24 -0800 (PST)
Message-ID: <89cb8fb1-4e0f-4b5e-26ab-702c0fda8760@linaro.org>
Date:   Fri, 3 Mar 2023 10:55:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 3/9] dt-bindings: crypto: fsl-sec4: support sec5.4/0 and
 i.MX6UL
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        horia.geanta@nxp.com, pankaj.gupta@nxp.com, gaurav.jain@nxp.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, stefan@agner.ch,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
References: <20230301015702.3388458-1-peng.fan@oss.nxp.com>
 <20230301015702.3388458-4-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230301015702.3388458-4-peng.fan@oss.nxp.com>
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

On 01/03/2023 02:56, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add i.MX6UL, SEC 5.0 and SEC 5.4 support.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../devicetree/bindings/crypto/fsl-sec4.yaml  | 58 ++++++++++++++++---
>  1 file changed, 50 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/crypto/fsl-sec4.yaml b/Documentation/devicetree/bindings/crypto/fsl-sec4.yaml
> index 678c8389ef49..1b801ae5ab51 100644
> --- a/Documentation/devicetree/bindings/crypto/fsl-sec4.yaml
> +++ b/Documentation/devicetree/bindings/crypto/fsl-sec4.yaml
> @@ -45,8 +45,18 @@ maintainers:
>  
>  properties:
>    compatible:
> -    enum:
> -      - fsl,sec-v4.0
> +    oneOf:
> +      - enum:
> +          - fsl,sec-v4.0
> +      - items:
> +          - enum:
> +              - fsl,imx6ul-caam
> +              - fsl,sec-v5.0
> +          - const: fsl,sec-v4.0
> +      - items:
> +          - const: fsl,sec-v5.4
> +          - const: fsl,sec-v5.0

What's the point of having all these versions? Better to use
SoC-compatibles.

> +          - const: fsl,sec-v4.0
>  
>    "#address-cells":
>      const: 1
> @@ -77,6 +87,8 @@ properties:
>  
>    clock-names:
>      oneOf:
> +      - items:
> +          - const: ipg
>        - items:
>            - const: mem
>            - const: aclk
> @@ -85,11 +97,17 @@ properties:
>        - items:
>            - const: aclk
>            - const: ipg
> +      - items:
> +          - const: ipg
> +          - const: aclk
>        - items:
>            - const: ipg
>            - const: aclk
>            - const: mem
>  
> +  dma-coherent:
> +    type: boolean
> +
>    fsl,sec-era:
>      description:
>        Optional. A standard property. Define the 'ERA' of the SEC device.
> @@ -108,8 +126,16 @@ patternProperties:
>  
>      properties:
>        compatible:
> -        enum:
> -          - fsl,sec-v4.0-job-ring
> +        oneOf:
> +          - enum:
> +              - fsl,sec-v4.0-job-ring
> +          - items:
> +              - const: fsl,sec-v5.0-job-ring
> +              - const: fsl,sec-v4.0-job-ring
> +          - items:
> +              - const: fsl,sec-v5.4-job-ring
> +              - const: fsl,sec-v5.0-job-ring
> +              - const: fsl,sec-v4.0-job-ring
>  
>        reg:
>          maxItems: 1
> @@ -148,8 +174,16 @@ patternProperties:
>  
>      properties:
>        compatible:
> -        enum:
> -          - fsl,sec-v4.0-rtic
> +        oneOf:
> +          - enum:
> +              - fsl,sec-v4.0-rtic
> +          - items:
> +              - const: fsl,sec-v5.0-rtic
> +              - const: fsl,sec-v4.0-rtic
> +          - items:
> +              - const: fsl,sec-v5.4-rtic
> +              - const: fsl,sec-v5.0-rtic
> +              - const: fsl,sec-v4.0-rtic

This is also a bit odd... why do you version children?

Best regards,
Krzysztof

