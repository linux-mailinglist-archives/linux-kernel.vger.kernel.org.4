Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C435FFAA9
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 17:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiJOPCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 11:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiJOPCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 11:02:18 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28A952DC2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 08:02:16 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id g16so590422qtu.2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 08:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6Ur3jsO+Ea30Hw7rO/35aci3iOoKWMoNPKYsW0lUBM0=;
        b=yeD64SW78+M0+NSoS4kDlBmjtklL7UKAUOpb+fFHtEyCBYg6evtBICocG8OuJqatui
         9ZKGf1LBBD9aEXlI2HjCWnDtSh4GgRlZxmbCGB1T1hfhGKrvuWLoFioC2maXtgtFq1WC
         bymHNHA82cdf0/X+ZM8Y6WrauOZI4kXxPZ4BWIPX+fzQdkFe9CwM0lJy/Vn/EU3/xk5y
         ACuG9cGReaIUsgDfvXg2l6ZuR4xQSCMz+eSsAa1K80qQr8n6ONyGm2FbAFkyLDQjerTN
         htpXUO2d24SaQ41HzfalrtIdGli4xloRT/MxjCjw77psFAwmw1M+pS+iGGs6fl58e18Z
         Qo+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Ur3jsO+Ea30Hw7rO/35aci3iOoKWMoNPKYsW0lUBM0=;
        b=HVBDMrB0EGDBFDriVH1uHR0QgAOQzJRQy4/tYn3QG2A3ATjH77xV1uFPCXqrY9Acgu
         jWt/iETQw1bZJEMl2uex7XnHIOlZetenzBg7KhjaGaJC1wsots1UIzUCSf5+YMZ0XuNE
         L3AL6ZIugi70K0QTfAhPAGpAJ07ui/gVdHXYiLKPnjGIZfvt1TVS4tzubwGm4Gu2r9nW
         VcyVTe+Lnqn9JoZyvbPD0HjkymnG4yVxKG6pNq3rncItrGj4dh0TuCM+X00orBr56cwv
         uLF6v4sSOP2RdDE0PLh0UvFasypLgGqQKtURuP7sy4ur91HY04f+Cl4OyIk8LEAV0rC1
         y79Q==
X-Gm-Message-State: ACrzQf0vp+j2vYX/UESgtjikXCdQokRPqN0S4yw5Y1tyn/wtqbUSCgu9
        uHWfgbv7Y3yi6f6W2Uvp3LOytg==
X-Google-Smtp-Source: AMsMyM6hPLoLcMAjPo2jkgKKjksiug8abEIOWvkuO4YgmYwanp5zrth37zq7NoHU7zsaaNPyNnSgXA==
X-Received: by 2002:ac8:57c2:0:b0:39c:dbec:9488 with SMTP id w2-20020ac857c2000000b0039cdbec9488mr2258374qta.580.1665846136024;
        Sat, 15 Oct 2022 08:02:16 -0700 (PDT)
Received: from ?IPV6:2601:42:0:3450:9477:c2f0:ddea:ea08? ([2601:42:0:3450:9477:c2f0:ddea:ea08])
        by smtp.gmail.com with ESMTPSA id y11-20020ac8524b000000b0039bde72b14asm3955078qtn.92.2022.10.15.08.02.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Oct 2022 08:02:15 -0700 (PDT)
Message-ID: <432a24ba-5472-20c8-397f-387e5a1ad9d2@linaro.org>
Date:   Sat, 15 Oct 2022 11:02:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v2 1/6] dt-bindings: clock: Add QDU1000 and QRU1000 GCC
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
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221014221011.7360-1-quic_molvera@quicinc.com>
 <20221014221011.7360-2-quic_molvera@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221014221011.7360-2-quic_molvera@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/10/2022 18:10, Melody Olvera wrote:
> Add device tree bindings for global clock controller on QDU1000 and
> QRU1000 SoCs.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  .../bindings/clock/qcom,gcc-qdu1000.yaml      |  70 ++++++++
>  include/dt-bindings/clock/qcom,gcc-qdu1000.h  | 170 ++++++++++++++++++
>  2 files changed, 240 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-qdu1000.yaml
>  create mode 100644 include/dt-bindings/clock/qcom,gcc-qdu1000.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-qdu1000.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-qdu1000.yaml
> new file mode 100644
> index 000000000000..b0746669e2ad
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc-qdu1000.yaml
> @@ -0,0 +1,70 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/qcom,gcc-qdu1000.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Global Clock & Reset Controller for QDU1000 and QRU1000
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
> +    enum:
> +      - qcom,gcc-qdu1000
> +      - qcom,gcc-qru1000
> +
> +  clocks:
> +    items:
> +      - description: Board XO source
> +      - description: Sleep clock source
> +      - description: PCIE 0 Pipe clock source
> +      - description: PCIE 0 Phy Auxiliary clock source
> +      - description: USB3 Phy wrapper pipe clock source
> +    minItems: 2
> +
> +  clock-names:
> +    items:
> +      - const: bi_tcxo
> +      - const: sleep_clk
> +      - const: pcie_0_pipe_clk

This does not match your clocks, please test your bindings. I thought
you understood my comment when you confirmed misunderstanding...


Best regards,
Krzysztof

