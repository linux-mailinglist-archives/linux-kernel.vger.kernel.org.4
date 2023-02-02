Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB3D688568
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 18:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbjBBRbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 12:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbjBBRbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 12:31:07 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982BF6E424;
        Thu,  2 Feb 2023 09:31:03 -0800 (PST)
Received: from g550jk.localnet (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 9589FCD5C6;
        Thu,  2 Feb 2023 17:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1675359061; bh=0eZaB2Z6pp9+ZJxkb/c8fWlD+Xrf4XZo1SLRMLsglys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ebC0Zzh1lLyL079pX/RhFRSVn2M5hRnBTUav4w7mThX21GdtLr08DDxkwPGX12CsH
         DSdn71JLhkXMCWCbXPIyiFodbdh9X8B+c4RtYwPnrly/hyCxG9Lpgo2TMWC2GUlozw
         C449PAl9K1b9rsKoEXS4CMCnd8KLsbhATupRGvFU=
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
Subject: Re: [PATCH v2 01/10] dt-bindings: pinctrl: qcom,msm8226: correct GPIO name
 pattern
Date:   Thu, 02 Feb 2023 18:31:00 +0100
Message-ID: <1772950.3VsfAaAtOV@z3ntu.xyz>
In-Reply-To: <20230202104452.299048-2-krzysztof.kozlowski@linaro.org>
References: <20230202104452.299048-1-krzysztof.kozlowski@linaro.org>
 <20230202104452.299048-2-krzysztof.kozlowski@linaro.org>
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

On Donnerstag, 2. Februar 2023 11:44:43 CET Krzysztof Kozlowski wrote:
> The MSM8226 TLMM pin controller has GPIOs 0-116, so correct the pattern
> to bring back missing 107-109.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Luca Weiss <luca@z3ntu.xyz>

> ---
>  .../devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml       | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git
> a/Documentation/devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml
> b/Documentation/devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml index
> a29b8a9e1f31..6cb667fa8665 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml
> @@ -56,7 +56,7 @@ $defs:
>            subnode.
>          items:
>            oneOf:
> -            - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-1][0-6])$"
> +            - pattern: "^gpio([0-9]|[1-9][0-9]|10[0-9]|11[0-6])$"
>              - enum: [ sdc1_clk, sdc1_cmd, sdc1_data, sdc2_clk, sdc2_cmd,
> sdc2_data ] minItems: 1
>          maxItems: 36




