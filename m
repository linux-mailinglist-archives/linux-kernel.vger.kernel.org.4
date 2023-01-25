Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F95967B0A2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 12:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235720AbjAYLIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 06:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235531AbjAYLIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 06:08:10 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5714B744
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 03:08:04 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so969726wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 03:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tgNd6pdprwR64P3gTI1USNLkbTKHZW562SWliCwEACM=;
        b=ADO6TqbweMkdaSb2eI1zg9+zyiYl+laiAa083zdMlJDzys8Pf2H6WOla5OukORSZeo
         qQd3U9cLObqdPg4kvHCN8gkLJMsRbMBGs3k+6IznwRBEDwR/gjZTZ5A7hF9w82nwVdCT
         RedDxB9/P2okicTBIOud0z319G2b+A8QZo+C5w4tjPRm1us3gDknrA9THTS+N9qvlek2
         IMuWpuLGH1QyqJmEGZYJ99izXbJuT009pX6TxtGhLnLrGbrzHDytRSy+D5F/EKF5MuWc
         uwEvTVsgwUdzzu7D/VcoM+l/INLsrvkbf3OEDuRNoDsQqtZ6kenhhqImeTyHgc9SK+cg
         P61Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tgNd6pdprwR64P3gTI1USNLkbTKHZW562SWliCwEACM=;
        b=EuXgYvmOyaJHLqOld3VRDnF6HfwnygKHSfbz/saF/ErzW/jnfA3TSdfTfxpNook2/f
         BWkk0yN4kRK6GIIs4MeY5A3VVUQATqyjS6768Ph9lgnQeKIHp/EdXJWhDiScOzybcA/o
         wVxD4MahSbRYd8OaMr8IphJDQmEzuQvN1HUpcV48TcfM0ixuzIpEBihjGINGqx3jxaqs
         WWQNllnjfLShlR7CcqVIRUbKaeMQ6+JNoYCN8puJCJ1ZFxHR8IESjxFmLodXUiSyfLBq
         akZw5yddTkth/idM+lIKvzuXrWD7ides/sXn7mOKurwvzKSzG306Coz2f7kJjae2k0n6
         zv3A==
X-Gm-Message-State: AFqh2kqg2CLTwG0bHNI46Ypihjs49CLGaNX4TDBSypLlwVgvsoqbvWR0
        WYBo3fLofIUIfOFkPfX/bbFN4A==
X-Google-Smtp-Source: AMrXdXsPehuhP8/0wsrKQRHY7pty6KTDfGXFEaq+5JL6AFSYRRELry8uhLX7C+8zyV2XA47766i/fQ==
X-Received: by 2002:a05:600c:46cb:b0:3db:1afd:ac45 with SMTP id q11-20020a05600c46cb00b003db1afdac45mr26226470wmo.7.1674644882380;
        Wed, 25 Jan 2023 03:08:02 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id b5-20020a05600c150500b003dafb0c8dfbsm1760931wmg.14.2023.01.25.03.07.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 03:08:01 -0800 (PST)
Message-ID: <36c9c3ce-1ae0-6619-d74d-142ed34b2f3f@linaro.org>
Date:   Wed, 25 Jan 2023 12:07:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH V1 3/8] dt-bindings: pinctrl: qcom: Document IPQ9574
 pinctrl driver
Content-Language: en-US
To:     devi priya <quic_devipriy@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, ulf.hansson@linaro.org, linus.walleij@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, p.zabel@pengutronix.de,
        shawnguo@kernel.org, arnd@arndb.de, marcel.ziswiler@toradex.com,
        dmitry.baryshkov@linaro.org, nfraprado@collabora.com,
        broonie@kernel.org, tdas@codeaurora.org, bhupesh.sharma@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_poovendh@quicinc.com
References: <20230124141541.8290-1-quic_devipriy@quicinc.com>
 <20230124141541.8290-4-quic_devipriy@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230124141541.8290-4-quic_devipriy@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/01/2023 15:15, devi priya wrote:
> Document the pinctrl driver for IPQ9574
> 
> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
> Signed-off-by: devi priya <quic_devipriy@quicinc.com>
> ---
>  .../bindings/pinctrl/qcom,ipq9574-tlmm.yaml   | 135 ++++++++++++++++++
>  1 file changed, 135 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,ipq9574-tlmm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,ipq9574-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,ipq9574-tlmm.yaml
> new file mode 100644
> index 000000000000..d736f0fb7835
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,ipq9574-tlmm.yaml
> @@ -0,0 +1,135 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/qcom,ipq9574-tlmm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Technologies, Inc. IPQ9574 TLMM block
> +
> +maintainers:
> +  - Bjorn Andersson <andersson@kernel.org>
> +  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> +
> +description:
> +  Top Level Mode Multiplexer pin controller in Qualcomm IPQ9574 SoC.
> +
> +properties:
> +  compatible:
> +    const: qcom,ipq9574-tlmm
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts: true

Also - missing maxItems.

I think you based your patches on some older version, so you might miss
here changes we did recently.

Best regards,
Krzysztof

