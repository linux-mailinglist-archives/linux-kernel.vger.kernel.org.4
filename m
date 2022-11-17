Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8E862DC0B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 13:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239197AbiKQMyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 07:54:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234267AbiKQMx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 07:53:56 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F23121E28
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 04:53:53 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-382f0906929so17476057b3.10
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 04:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i0aKSDaWcYW6hMmyc8hWGL5Uyj/IWG6poNjC3f6EB3A=;
        b=hEdRACyXB+6w8aiU+xAKiRiQiD1Hyzqr7rczZF3N3B00TYGnwBiBYsQYLrj5d4Chs7
         IPA+Boia8MXA3YGucKS6IJ7YzgHySlx6GU1njGQDD8rudMJGwuipJvub9dDAiSUUaYLp
         kA/eU1pI6AHB2EhARR4KOgB2fIieMIoGupOwEFex+v+y1bK8bJjduc4ExOLmP2/ZEUxk
         S1vFpco3h8/MMGUu3cE+1Wj3B720t9SEV9UF5Nt8tW3XIVu0l2FFCi8RWMQwlaHsfsWM
         jIQKzDYhivoRCT+hulp+f/K578gImWYZeP/RgeCLrsNRRZkDM9amQNXMh4FCDCOiNzku
         wl0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i0aKSDaWcYW6hMmyc8hWGL5Uyj/IWG6poNjC3f6EB3A=;
        b=Z94JVW7mTDCOxNScbDKEHp4foquyoIuzsBu2OC+xUkbAAf6Pv4QOKoX76KxV6mIfYz
         5jIkQZYPPqEWhLArQKcW/2TQsy0giVzYPVWy6EdchFOszgrbS5ogLOy60typ+WLO7MEq
         xDhuEhQSL3Pyl60I3frLg2eKdzkvJNL6zTd2vwniz41sixsI9ULIcwp571bvdTeWi7fp
         jyAuFCIIY9165VQ+9Se0PkXAjeWZAFqPJ8Ly7EoXKfL8x2R7S0gTS77RwQu8qWz1fwhe
         uI7575mwz9FL2X+vjx9+xBWXBgRAkfwk2LtHbQX8rcra4UJt6yLxnLFBM671ZEn6nU6h
         o+pg==
X-Gm-Message-State: ANoB5pnqpbkeBLa23rf2qWvh38E54Nnc2bI/QWy5Cwm0SHZbGcWS/rTI
        a4RJaUctLEoReXc5k7q7jHNbATRfEZMHM9T6va88+Q==
X-Google-Smtp-Source: AA0mqf5JJTNpWDh51ZJ7OJUqoMD1Pilkoiy26iYG0Pg9IMJS6t07N3CPuHkFD4a4WUK7gN89kdj7Nw/X7+STXSfRfjg=
X-Received: by 2002:a0d:f846:0:b0:37b:e3ae:decc with SMTP id
 i67-20020a0df846000000b0037be3aedeccmr1797224ywf.418.1668689632225; Thu, 17
 Nov 2022 04:53:52 -0800 (PST)
MIME-Version: 1.0
References: <20221116123505.2760397-1-abel.vesa@linaro.org>
In-Reply-To: <20221116123505.2760397-1-abel.vesa@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 17 Nov 2022 14:53:41 +0200
Message-ID: <CAA8EJpqMixLnZdv0eyhaMysFW98qAbFeKXG0i_ZYLHEFOQC-vQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: PCI: qcom: Add SM8550 to binding
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, kw@linux.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Nov 2022 at 14:36, Abel Vesa <abel.vesa@linaro.org> wrote:
>
> Add the SM8550 platform to the binding.
>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  .../devicetree/bindings/pci/qcom,pcie.yaml    | 96 +++++++++++++++++++
>  1 file changed, 96 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index 54f07852d279..efa01a8411c4 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -34,6 +34,8 @@ properties:
>        - qcom,pcie-sm8250
>        - qcom,pcie-sm8450-pcie0
>        - qcom,pcie-sm8450-pcie1
> +      - qcom,pcie-sm8550-pcie0
> +      - qcom,pcie-sm8550-pcie1
>        - qcom,pcie-ipq6018
>
>    reg:
> @@ -92,6 +94,10 @@ properties:
>    power-domains:
>      maxItems: 1
>
> +  enable-gpios:
> +    description: GPIO controlled connection to ENABLE# signal
> +    maxItems: 1
> +
>    perst-gpios:
>      description: GPIO controlled connection to PERST# signal
>      maxItems: 1
> @@ -187,6 +193,8 @@ allOf:
>                - qcom,pcie-sm8250
>                - qcom,pcie-sm8450-pcie0
>                - qcom,pcie-sm8450-pcie1
> +              - qcom,pcie-sm8550-pcie0
> +              - qcom,pcie-sm8550-pcie1
>      then:
>        properties:
>          reg:
> @@ -601,6 +609,92 @@ allOf:
>            items:
>              - const: pci # PCIe core reset
>
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,pcie-sm8550-pcie0
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 11
> +          maxItems: 11
> +        clock-names:
> +          items:
> +            - const: pipe # PIPE clock
> +            - const: pipe_mux # PIPE MUX
> +            - const: phy_pipe # PIPE output clock
> +            - const: ref # REFERENCE clock
> +            - const: aux # Auxiliary clock
> +            - const: cfg # Configuration clock
> +            - const: bus_master # Master AXI clock
> +            - const: bus_slave # Slave AXI clock
> +            - const: slave_q2a # Slave Q2A clock
> +            - const: ddrss_sf_tbu # PCIe SF TBU clock
> +            - const: aggre0 # Aggre NoC PCIe0 AXI clock
> +        interconnects:
> +          maxItems: 1
> +        interconnect-names:
> +          const: icc_path
> +        iommus:
> +          maxItems: 1
> +        iommu-map:
> +          maxItems: 2
> +        power-domains:
> +          maxItems: 1
> +        power-domain-names:
> +          const: gdsc
> +        resets:
> +          maxItems: 1
> +        reset-names:
> +          items:
> +            - const: pci # PCIe core reset
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,pcie-sm8550-pcie1
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 12
> +          maxItems: 12
> +        clock-names:
> +          items:
> +            - const: pipe # PIPE clock
> +            - const: pipe_mux # PIPE MUX
> +            - const: phy_pipe # PIPE output clock
> +            - const: ref # REFERENCE clock

You should not need these four clocks. They are unused by the driver.
Same applies to pcie0 too.

> +            - const: aux # Auxiliary clock
> +            - const: cfg # Configuration clock
> +            - const: bus_master # Master AXI clock
> +            - const: bus_slave # Slave AXI clock
> +            - const: slave_q2a # Slave Q2A clock
> +            - const: ddrss_sf_tbu # PCIe SF TBU clock
> +            - const: aggre1 # Aggre NoC PCIe1 AXI clock
> +            - const: cnoc_pcie_sf_axi # Config NoC PCIe1 AXI clock
> +        interconnects:
> +          maxItems: 1
> +        interconnect-names:
> +          const: icc_path
> +        iommus:
> +          maxItems: 1
> +        iommu-map:
> +          maxItems: 2
> +        power-domains:
> +          maxItems: 1
> +        power-domain-names:
> +          const: gdsc
> +        resets:
> +          maxItems: 2
> +        reset-names:
> +          items:
> +            - const: pci # PCIe core reset
> +            - const: pcie_1_link_down_reset # PCIe link down reset
> +
>    - if:
>        properties:
>          compatible:
> @@ -672,6 +766,8 @@ allOf:
>                - qcom,pcie-sm8250
>                - qcom,pcie-sm8450-pcie0
>                - qcom,pcie-sm8450-pcie1
> +              - qcom,pcie-sm8550-pcie0
> +              - qcom,pcie-sm8550-pcie1
>      then:
>        oneOf:
>          - properties:
> --
> 2.34.1
>


-- 
With best wishes
Dmitry
