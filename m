Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F1C6D9F80
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 20:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239767AbjDFSHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 14:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjDFSHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 14:07:48 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6A82D43
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 11:07:47 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id j22so3433200ejv.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 11:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680804465;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1weO9qyyCQy8+b4IcRBkB70UCGhmywO6NJQrtwS0SGI=;
        b=Q39KSHVK0vW4i5Ni8OS1x1qezXczm35jO/kx/LP48M/yhIJzxCsjlEkGkpPsBZrkdu
         6KzuKgQrC6cGI46YZBIvBAz05m7Byijj31TWFGRrOGmJZg6AS/nfYc8j5wRnkZB+ixHT
         lFFMw0oOfjoYDKfQEkE3xHvbtU5dqfFqKLULKu4HhJ4Y1SJJBemueE8xAzsPtrAliZuW
         jkl0cYlfZSsnFzcXtZlOKWEkGOFlToS+hK+aVsnF/4Xv9xceCGGPgIPHlvMy0gTdqZih
         VZqacRRlgRvOeOeMTeCDyD/H4o9AHH2XYkdqqmn72aS0I5JxZWlPt/G67JdARodtQVq6
         uVIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680804465;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1weO9qyyCQy8+b4IcRBkB70UCGhmywO6NJQrtwS0SGI=;
        b=YDrTk7mo14wlsh23mViJbtkr9ima1K5jmdeTg5BTFLbLM3T57KmL4/1BBW1VlEIIOs
         scUZaaap4h703H1y2w7wA6rm790mjZIktPExL1JsJAXBAH5ytdLno4cJt0PCq4zJYJHm
         fIAcFD5YpYJDQBXR8j1a30hMbD8SFmpp+fy+HyaBLw5z3L9ISepbTXKZXkefq8WMjYE+
         49khwj5aWMNlwjiDAEvijOy1KqhmZMacJd5JmFLo3XAzTDQtQ/jlHmRCS277uuMfmuih
         UQDf+RcsZ38MxolETUh+zhheDMtMUGvrVk9ZMzqBI235XhoXioL69TTcmEaMLDpbVLKp
         YJwg==
X-Gm-Message-State: AAQBX9f2v/rgypvD4uTKxxIOep72o85alIf7UyE2QUT6tygsm/+hpM6j
        dTxD/Mbt/aiptEJpfItVfkx4GkvOqhkFZoZeD/E=
X-Google-Smtp-Source: AKy350aHt9yU8Ez/wQQLBkXXBqBOR8IO147QPcgI9LDFf7/LZvdMbuHrlfbxBzBf2DPp21fb0ciawA==
X-Received: by 2002:a17:906:f897:b0:8b1:7eba:de5 with SMTP id lg23-20020a170906f89700b008b17eba0de5mr6211680ejb.10.1680804465711;
        Thu, 06 Apr 2023 11:07:45 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed? ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id r7-20020a50c007000000b005021d210899sm1022641edb.23.2023.04.06.11.07.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 11:07:45 -0700 (PDT)
Message-ID: <cc5ee0e5-5cc7-bf80-68cc-2d38b1118c6d@linaro.org>
Date:   Thu, 6 Apr 2023 20:07:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2] dt-bindings: iommu: Convert QCOM IOMMU to YAML
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230406-topic-qciommu-v2-1-b8547622b2a4@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230406-topic-qciommu-v2-1-b8547622b2a4@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2023 13:58, Konrad Dybcio wrote:
> Convert the Qualcomm IOMMU bindings to YAML.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> v1 -> v2:

Thank you for your patch. There is something to discuss/improve.

> +
> +patternProperties:
> +  "^iommu-ctx@[0-9a-f]+$":
> +    type: object

On this level:
additionalProperties: false

> +    properties:
> +      compatible:
> +        enum:
> +          - qcom,msm-iommu-v1-ns
> +          - qcom,msm-iommu-v1-sec
> +
> +      interrupts:
> +        maxItems: 1
> +
> +      reg:
> +        maxItems: 1

On this level:
    required:
      - compatible
      - interrupts
      - reg

> +
> +required:
> +  - compatible
> +  - clocks
> +  - clock-names
> +  - ranges
> +  - '#address-cells'
> +  - '#size-cells'
> +  - '#iommu-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,gcc-msm8916.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    apps_iommu: iommu@1e20000 {
> +      compatible = "qcom,msm8916-iommu", "qcom,msm-iommu-v1";
> +      reg = <0x01ef0000 0x3000>;
> +      clocks = <&gcc GCC_SMMU_CFG_CLK>,
> +               <&gcc GCC_APSS_TCU_CLK>;
> +      clock-names = "iface", "bus";
> +      qcom,iommu-secure-id = <17>;
> +      #address-cells = <1>;
> +      #size-cells = <1>;
> +      #iommu-cells = <1>;
> +      ranges = <0 0x01e20000 0x40000>;
> +
> +      /* mdp_0: */
> +      iommu-ctx@4000 {
> +        compatible = "qcom,msm-iommu-v1-ns";
> +        reg = <0x4000 0x1000>;
> +        interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
> +      };
> +    };
> +
> +    mdp: mdp@1a01000 {
> +      reg = <0x01a01000 0x1000>;
> +      iommus = <&apps_iommu 4>;

Drop mdp node. Consumers should not be in provider bindings.



Best regards,
Krzysztof

