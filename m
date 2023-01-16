Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876C866D0C5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 22:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233550AbjAPVO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 16:14:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbjAPVOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 16:14:24 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7104821A3B
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 13:14:22 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-4d4303c9de6so245984497b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 13:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Jwm6WO7QnPNEhy4JvZi2wxkyAD3RRMBe1FVE+2vZ5sA=;
        b=aXpkbUjL0kDFvTMkVim1GagooD1opDikVVx1RL7hUyJFfhKyLDACnWABKytVIEmA/l
         ufPr01muhEm19QVeOus6n6Q3gqLxEZ8gLXkUOhSLltujFDGWF/BDVy7fsNe0qHbBAtFF
         39Xlrmuys6/gTXXe7s1DP3rM41lmkKU6Sk+vweWaBd3OfNZo4TgHQvChYVt35+bKJJ8B
         dnKcZwMP/K/tdria3W1OcnnTWgWCwtpy1J+HSjkY8pjMYwJXbmnUCcTwIFp+iCZYf6bH
         PQxzrbEiJ9ZK3TpBdUZ7PA2e50RV4wctF+6/8Ce51ftuNYKJq4wttrtu3IRUrd1BX7sa
         jBVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jwm6WO7QnPNEhy4JvZi2wxkyAD3RRMBe1FVE+2vZ5sA=;
        b=AN77/VuhirYaFbLIYSlp3AMM1iBTja0CV0ZXrRQq8Wo3yvohaeaGLgPQb7BUpf3kDR
         2x1nZoGLEk96A0UQq3BSzWnRZR9MaThDxTf/LP+2MtDOZCK1PWXw2XV1fIoRVVeQVCAv
         hq3OQKciVU4e/g2DP2yIMmiJsQf1t0JrkK3/GybHDfCGo8rlVn8wDPxb4mrS2iBBBqqg
         GTPS55DGTXAMzUJhwNB2OUtKLqav5n35NL7Dx3aE2+ka3K6EjfOVAhkyAtc5WmLfGwyl
         ko/xlIytm3Z8+wlP1zt94D5B0s7keXkX9bzD+zIY2FELEFF+dU63/VPqXoKA1MmefCJd
         1Mbg==
X-Gm-Message-State: AFqh2koxc3loBdPzqNUiIq7nuKCcznPcgRuSFT/YocO6Htwy87Hy/iYq
        ljrEtgZbnxTDcveAlm5X+MtaLKzLfEKX5XxZxJLjJA==
X-Google-Smtp-Source: AMrXdXvEbRCJ6WnLKKWGRezrhVD86gzZ1ps7Npqh8eCYrpaQI1JQdsTAl0zrDXMtI/vwF+AI1YYNNBrPYoqqxsxo3k4=
X-Received: by 2002:a0d:d5c6:0:b0:4ef:ce3a:a54 with SMTP id
 x189-20020a0dd5c6000000b004efce3a0a54mr96174ywd.485.1673903661649; Mon, 16
 Jan 2023 13:14:21 -0800 (PST)
MIME-Version: 1.0
References: <20230116204751.23045-1-ansuelsmth@gmail.com> <20230116204751.23045-2-ansuelsmth@gmail.com>
In-Reply-To: <20230116204751.23045-2-ansuelsmth@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 16 Jan 2023 23:14:10 +0200
Message-ID: <CAA8EJppdYqwM6n+6BdKtjO+TTerqeodLO7CEpBVNW45yduFV0g@mail.gmail.com>
Subject: Re: [PATCH v7 1/7] dt-bindings: clock: Convert qcom,krait-cc to yaml
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh@kernel.org>
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

On Mon, 16 Jan 2023 at 22:48, Christian Marangi <ansuelsmth@gmail.com> wrote:
>
> Convert qcom,krait-cc to yaml Documentation.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> Acked-by: Rob Herring <robh@kernel.org>

I know this has been reviewed already. I checked again my apq8064
branch and noticed that the bindings are not compatible with the
apq8064. The SoC in question is a 4-core device, so this is what I had
in mind:

       kraitcc: clock-controller {
               compatible = "qcom,krait-cc-v1";
               clocks = <&gcc PLL9>, /* hfpll0 */
                        <&gcc PLL10>, /* hfpll1 */
                        <&gcc PLL16>, /* hfpll2 */
                        <&gcc PLL17>, /* hfpll3 */
                        <&gcc PLL12>, /* hfpll_l2 */
                        <&acc0>,
                        <&acc1>,
                        <&acc2>,
                        <&acc3>,
                        <&l2cc>;
               clock-names = "hfpll0",
                             "hfpll1",
                             "hfpll2",
                             "hfpll3",
                             "hfpll_l2",
                             "acpu0_aux",
                             "acpu1_aux",
                             "acpu2_aux",
                             "acpu3_aux",
                             "acpu_l2_aux";
               #clock-cells = <1>;
       };

> ---
>  .../bindings/clock/qcom,krait-cc.txt          | 34 -----------
>  .../bindings/clock/qcom,krait-cc.yaml         | 59 +++++++++++++++++++
>  2 files changed, 59 insertions(+), 34 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/qcom,krait-cc.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,krait-cc.yaml
>
> diff --git a/Documentation/devicetree/bindings/clock/qcom,krait-cc.txt b/Documentation/devicetree/bindings/clock/qcom,krait-cc.txt
> deleted file mode 100644
> index 030ba60dab08..000000000000
> --- a/Documentation/devicetree/bindings/clock/qcom,krait-cc.txt
> +++ /dev/null
> @@ -1,34 +0,0 @@
> -Krait Clock Controller
> -
> -PROPERTIES
> -
> -- compatible:
> -       Usage: required
> -       Value type: <string>
> -       Definition: must be one of:
> -                       "qcom,krait-cc-v1"
> -                       "qcom,krait-cc-v2"
> -
> -- #clock-cells:
> -       Usage: required
> -       Value type: <u32>
> -       Definition: must be 1
> -
> -- clocks:
> -       Usage: required
> -       Value type: <prop-encoded-array>
> -       Definition: reference to the clock parents of hfpll, secondary muxes.
> -
> -- clock-names:
> -       Usage: required
> -       Value type: <stringlist>
> -       Definition: must be "hfpll0", "hfpll1", "acpu0_aux", "acpu1_aux", "qsb".
> -
> -Example:
> -
> -       kraitcc: clock-controller {
> -               compatible = "qcom,krait-cc-v1";
> -               clocks = <&hfpll0>, <&hfpll1>, <&acpu0_aux>, <&acpu1_aux>, <qsb>;
> -               clock-names = "hfpll0", "hfpll1", "acpu0_aux", "acpu1_aux", "qsb";
> -               #clock-cells = <1>;
> -       };
> diff --git a/Documentation/devicetree/bindings/clock/qcom,krait-cc.yaml b/Documentation/devicetree/bindings/clock/qcom,krait-cc.yaml
> new file mode 100644
> index 000000000000..8caa5a677394
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qcom,krait-cc.yaml
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/qcom,krait-cc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Krait Clock Controller
> +
> +maintainers:
> +  - Christian Marangi <ansuelsmth@gmail.com>
> +
> +description: |
> +  Qualcomm Krait Clock Controller used to correctly scale the CPU and the L2
> +  rates.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,krait-cc-v1
> +      - qcom,krait-cc-v2
> +
> +  clocks:
> +    items:
> +      - description: phandle to hfpll for CPU0 mux
> +      - description: phandle to hfpll for CPU1 mux
> +      - description: phandle to CPU0 aux clock
> +      - description: phandle to CPU1 aux clock
> +      - description: phandle to QSB fixed clk
> +
> +  clock-names:
> +    items:
> +      - const: hfpll0
> +      - const: hfpll1
> +      - const: acpu0_aux
> +      - const: acpu1_aux
> +      - const: qsb
> +
> +  '#clock-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - clocks
> +  - clock-names
> +  - '#clock-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    clock-controller {
> +      compatible = "qcom,krait-cc-v1";
> +      clocks = <&hfpll0>, <&hfpll1>,
> +               <&acpu0_aux>, <&acpu1_aux>, <&qsb>;
> +      clock-names = "hfpll0", "hfpll1",
> +                    "acpu0_aux", "acpu1_aux", "qsb";
> +      #clock-cells = <1>;
> +    };
> +...
> --
> 2.37.2
>


-- 
With best wishes
Dmitry
