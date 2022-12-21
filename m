Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5FA652D8E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 08:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234426AbiLUH7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 02:59:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234274AbiLUH66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 02:58:58 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D44B0A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 23:58:57 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id p36so22244692lfa.12
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 23:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e8GCz1b2VF0mWtOR9yf+Rv0xFFyTsr8iL68eBnffHjs=;
        b=apfpV+nJVVyEcEi53k7XYGHX6obMy/OGRT/sqx9uDTR8RjttQLEYj2EWlyGwjiiQPr
         TvjT0T8ilKqeJHJ6NZdMa9c6feO6j+yj6X5b+iDMN/okmU+RTsu+iI7hRPcqkJoC537D
         aQhCkqWNyUuhzNTZJ9SlwBKlqTf26FxfuCgThbKJm66orwKWVgkpHoHKtteJoAAJsvxU
         HrJ2IDOq2C1G3FsNOqt/SUyZxYJUaZJFuu7G54XWpfbwbVdcEwFUQfxskbrfAUp/D8oN
         lkzMzy2WJnTEN17WsbItT02ABlv6jo1shl274PHCYADQivqTUUnM5nI+SWYqC20+pC4l
         +MsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e8GCz1b2VF0mWtOR9yf+Rv0xFFyTsr8iL68eBnffHjs=;
        b=E28tQwOnNoeqcxQPTvuk8g6sS+viUfqk3hq++BQ/1tLtC93szHoKVD+v4uLxkxfYLx
         HjwgIs96v3eoYMNxBoKfQuuIl+UzNMZ+z1dClsepkx2F2dIE8xjUKqjMymQDE4BEdRUF
         edWf5O9OC3ypzz0moqoe+mZextwCd+OWaHyYvKWIewSQCywovfYhfOK4IB3Ez06Ggtmo
         2Z+M4KophaIUVPcoLvBPukv1R1A8DlqJ68XRizgpHX6R7jEwstXURpF+3PcZZKwtfnKg
         lDQ35xPxWd+QxBDhybz1wySusymbJWl3ob5oMG+nghe/xl9E7J0Ey2+EkOlKx346ZYpb
         Jd5A==
X-Gm-Message-State: AFqh2koVizfUnGXBmC23NF5GTtUAwDBjauOQnoqBm0WbRr7xZNRhPuj1
        5M9FQTQIVTFL3mJesa7VCaTbLA==
X-Google-Smtp-Source: AMrXdXurygVZlWFJZ4zMTAx9l7uSZkERAfz5c7Tp/Hu16TGbWU2otQiv8T2qGY77GmvohtJgNW+aPQ==
X-Received: by 2002:a05:6512:2508:b0:4b5:9b8f:cc82 with SMTP id be8-20020a056512250800b004b59b8fcc82mr391385lfb.0.1671609535445;
        Tue, 20 Dec 2022 23:58:55 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id f9-20020ac251a9000000b004b587e37265sm1767256lfk.58.2022.12.20.23.58.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 23:58:54 -0800 (PST)
Message-ID: <86592f50-b1d9-b633-4ec8-904a7fd97806@linaro.org>
Date:   Wed, 21 Dec 2022 08:58:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v5 1/2] dt-bindings: interconnect: Add QDU1000/QRU1000
 devices
Content-Language: en-US
To:     Melody Olvera <quic_molvera@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Odelu Kukatla <quic_okukatla@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221216230914.21771-1-quic_molvera@quicinc.com>
 <20221216230914.21771-2-quic_molvera@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221216230914.21771-2-quic_molvera@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/12/2022 00:09, Melody Olvera wrote:
> Add separate schema for QDU1000 and QRU1000 interconnect devices
> to document the different NoCs on these platforms.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  .../interconnect/qcom,qdu1000-rpmh.yaml       | 70 +++++++++++++
>  .../interconnect/qcom,qdu1000-rpmh.h          | 98 +++++++++++++++++++
>  2 files changed, 168 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,qdu1000-rpmh.yaml
>  create mode 100644 include/dt-bindings/interconnect/qcom,qdu1000-rpmh.h
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,qdu1000-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,qdu1000-rpmh.yaml
> new file mode 100644
> index 000000000000..dad93b8e4895
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,qdu1000-rpmh.yaml
> @@ -0,0 +1,70 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interconnect/qcom,qdu1000-rpmh.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm RPMh Network-On-Chip Interconnect on QDU1000
> +
> +maintainers:
> +  - Georgi Djakov <djakov@kernel.org>
> +  - Odelu Kukatla <quic_okukatla@quicinc.com>
> +
> +description: |
> +   RPMh interconnect providers support system bandwidth requirements through
> +   RPMh hardware accelerators known as Bus Clock Manager (BCM). The provider is
> +   able to communicate with the BCM through the Resource State Coordinator (RSC)
> +   associated with each execution environment. Provider nodes must point to at
> +   least one RPMh device child node pertaining to their RSC and each provider
> +   can map to multiple RPMh resources.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,qdu1000-clk-virt
> +      - qcom,qdu1000-gem-noc
> +      - qcom,qdu1000-mc-virt
> +      - qcom,qdu1000-system-noc
> +
> +  '#interconnect-cells': true
> +
> +  reg:
> +    maxItems: 1
> +
> +allOf:
> +  - $ref: qcom,rpmh-common.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,qdu1000-clk-virt
> +              - qcom,qdu1000-mc-virt
> +    then:
> +      properties:
> +        reg: false
> +    else:
> +      required:
> +        - reg
> +
> +required:
> +  - compatible
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +      #include <dt-bindings/interconnect/qcom,qdu1000-rpmh.h>
> +
> +      system_noc: interconnect@1640000 {
> +             compatible = "qcom,qdu1000-system-noc";

Messed indentation.

Best regards,
Krzysztof

