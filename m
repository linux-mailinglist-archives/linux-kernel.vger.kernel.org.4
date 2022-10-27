Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECF860FC74
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 17:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236209AbiJ0PzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 11:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235721AbiJ0Py4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 11:54:56 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CE789CF7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 08:54:54 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id ay12so782667qtb.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 08:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HturbGbwp3GvmoZ/FiRE5yoA3qBUo4vXn8C99Hxcd48=;
        b=gJX1rB+iwcgnRVFxhnz2/zyOpU5YqFhoZJx5jMsfZKExTWRBLUzchNPG5nu9KvK1DJ
         DMNIUY0ya8yNoL5vtNSkI/67mqt5Y1oxrCg52QKDo3rGpSBAsLbByEmy7hRVtZ58HQO2
         qAEm3e+6RzskboNsvD8tmugITSVUVdVvshLpnc9gP07KyUR9mhystSvfN5gTNRu6QQdD
         tx33Bsv10xEdnNdvzGmw4N7muXvGnY0bAolXb+blfi8XI+sU/TOU7HXOShK0YVlc8k+h
         9kGImrBycJWjuFQkTx82MjuduDnWXid+atTKBk+02BPQITl0SPpLKRO37Nv7kdDwMyXf
         o8MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HturbGbwp3GvmoZ/FiRE5yoA3qBUo4vXn8C99Hxcd48=;
        b=gNEIXLkwPvpZtNErKauSLl3S/xWM2VMh45bAHtdJpomKs6Vpel2GUPLeFbpUI9/93e
         aPLDgfgCANAvvJlY10/uE3uXiXqFOXevpKQ+XCe4RwJwxLHqdfgG30f2+k9NGzWvh3n0
         u7KmNuL/N6Lsmw8jJZxMq7yHBQBtvEiG7abeVewPsqUir9UmNM4XUAgkP76QQzJhHCyO
         w3Ql8Y6iiKc4K2P6Rmvo1YtAFLCbwo5ImU5B7UIwn1O4B3mblkg3sE6YYDVxpjNfaHQ9
         WTcTwv6EksylYFRmx5OukNEF5Z78OJor77R4V8x8SiKSCk4JaZWHYbTuPocnSRpBWJwR
         WEBg==
X-Gm-Message-State: ACrzQf2qHLyuIlZcE6ZRHbreR5hyDmMvYZYl1XIs7qfUOdFeNss0J2No
        02u/c8wdYrsK6w7il/IwxwRbyoiksMvg8w==
X-Google-Smtp-Source: AMsMyM4Igr3MpGoZUSH0BGc8qDbbpQ0Ayv+zh3D21NMx0D0Pvf2I/bu9qQND43lee8lFRI9LdwkmNw==
X-Received: by 2002:ac8:7f44:0:b0:39c:e770:27fd with SMTP id g4-20020ac87f44000000b0039ce77027fdmr42495373qtk.478.1666886093840;
        Thu, 27 Oct 2022 08:54:53 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id x2-20020ac87ec2000000b00398a7c860c2sm1070851qtj.4.2022.10.27.08.54.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 08:54:53 -0700 (PDT)
Message-ID: <e5009a33-1f71-1fe3-3a06-98bba031fdf0@linaro.org>
Date:   Thu, 27 Oct 2022 11:54:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v3 1/5] dt-bindings: clock: Add QDU1000 and QRU1000 GCC
 clock bindings
Content-Language: en-US
To:     Melody Olvera <quic_molvera@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Cc:     Taniya Das <quic_tdas@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221026190441.4002212-1-quic_molvera@quicinc.com>
 <20221026190441.4002212-2-quic_molvera@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221026190441.4002212-2-quic_molvera@quicinc.com>
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

On 26/10/2022 15:04, Melody Olvera wrote:
> Add device tree bindings for global clock controller on QDU1000 and
> QRU1000 SoCs.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  .../bindings/clock/qcom,gcc-qdu1000.yaml      |  77 ++++++++
>  include/dt-bindings/clock/qcom,gcc-qdu1000.h  | 170 ++++++++++++++++++
>  2 files changed, 247 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-qdu1000.yaml
>  create mode 100644 include/dt-bindings/clock/qcom,gcc-qdu1000.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-qdu1000.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-qdu1000.yaml
> new file mode 100644
> index 000000000000..ad460d628ffc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc-qdu1000.yaml
> @@ -0,0 +1,77 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/qcom,gcc-qdu1000.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Global Clock & Reset Controller for QDU1000 and QRU1000
> +
> +allOf:
> +  - $ref: qcom,gcc.yaml#
> +
> +maintainers:
> +  - Melody Olvera <quic_molvera@quicinc.com>
> +
> +description: |
> +  Qualcomm global clock control module which supports the clocks, resets and
> +  power domains on QDU1000 and QRU1000
> +
> +  See also:
> +  - include/dt-bindings/clock/qcom,gcc-qdu1000.h
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: qcom,gcc-qdu1000
> +      - const: syscon
> +
> +  clocks:
> +    items:
> +      - description: Board XO source
> +      - description: Sleep clock source
> +      - description: PCIE 0 Pipe clock source
> +      - description: PCIE 0 Phy Auxiliary clock source
> +      - description: USB3 Phy wrapper pipe clock source
> +    minItems: 2

Why the clocks are optional?

> +
> +  clock-names:
> +    items:
> +      - const: bi_tcxo
> +      - const: sleep_clk
> +      - const: pcie_0_pipe_clk
> +    minItems: 2

This is a friendly reminder during the review process.

It seems my previous comments were not fully addressed. Maybe my
feedback got lost between the quotes, maybe you just forgot to apply it.
Please go back to the previous discussion and either implement all
requested changes or keep discussing them.

Thank you.


Best regards,
Krzysztof

