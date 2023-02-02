Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD67D68857D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 18:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbjBBRe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 12:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbjBBReX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 12:34:23 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DF2712DF;
        Thu,  2 Feb 2023 09:34:15 -0800 (PST)
Received: from g550jk.localnet (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id C6C5ECD52C;
        Thu,  2 Feb 2023 17:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1675359224; bh=89NIZqClh0XOO29LJCvpiqXNMG5Y6aeTmCeKVbe3aFc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=fuq84wTkhk0BH39og3UfbLA2soir4P5R2HP2TmqVAYe2ySPBahuj5kSAIFeKGRYp4
         J2tEDFygpWRkyk7adRqIhaPnZDHfnURyfuqUMl+OTLbtJgLYgpMYlnI76aOAJm9W3U
         9MmJzw88fcsb+YmOjFPdbRL8txpj6/efwZ8/Z4cU=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Vinod Koul <vkoul@kernel.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Iskren Chernev <me@iskren.info>, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 04/10] dt-bindings: pinctrl: qcom,msm8953: correct GPIO name
 pattern
Date:   Thu, 02 Feb 2023 18:33:43 +0100
Message-ID: <3205321.oiGErgHkdL@z3ntu.xyz>
In-Reply-To: <20230202104452.299048-5-krzysztof.kozlowski@linaro.org>
References: <20230202104452.299048-1-krzysztof.kozlowski@linaro.org>
 <20230202104452.299048-5-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Donnerstag, 2. Februar 2023 11:44:46 CET Krzysztof Kozlowski wrote:
> The MSM8953 TLMM pin controller has GPIOs 0-141, so narrow the pattern.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Luca Weiss <luca@z3ntu.xyz>

> ---
>  .../devicetree/bindings/pinctrl/qcom,msm8953-pinctrl.yaml       | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git
> a/Documentation/devicetree/bindings/pinctrl/qcom,msm8953-pinctrl.yaml
> b/Documentation/devicetree/bindings/pinctrl/qcom,msm8953-pinctrl.yaml index
> 6bcd52080801..ce219827ccc8 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8953-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8953-pinctrl.yaml
> @@ -53,7 +53,7 @@ $defs:
>            subnode.
>          items:
>            oneOf:
> -            - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-7][0-9])$"
> +            - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-3][0-9]|14[01])$"
>              - enum: [ sdc1_clk, sdc1_cmd, sdc1_data, sdc1_rclk, sdc2_clk,
>                        sdc2_cmd, sdc2_data, qdsd_clk, qdsd_cmd, qdsd_data0,
>                        qdsd_data1, qdsd_data2, qdsd_data3 ]




