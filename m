Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2A464CD12
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 16:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238620AbiLNP3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 10:29:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238362AbiLNP3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 10:29:23 -0500
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [5.144.164.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BDBDF2C;
        Wed, 14 Dec 2022 07:29:20 -0800 (PST)
Received: from SoMainline.org (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 9415D3EBD2;
        Wed, 14 Dec 2022 16:29:17 +0100 (CET)
Date:   Wed, 14 Dec 2022 16:29:15 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: arm: qcom: add board-id/msm-id for MSM8956,
 SDM636 and SM4250
Message-ID: <20221214152915.wshz4odyqcupo6xw@SoMainline.org>
References: <20221214150605.173346-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221214150605.173346-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-14 16:06:05, Krzysztof Kozlowski wrote:
> Allow qcom,board-id and qcom,msm-id leagcy properties on these older
> platforms: MSM8956, SDM636 and SM4250.  Also mention more OnePlus
> devices using modified qcom,board-id field.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>

> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> index d45e2129fce3..cfb7f5caf606 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -925,15 +925,18 @@ allOf:
>                - qcom,apq8026
>                - qcom,apq8094
>                - qcom,apq8096
> +              - qcom,msm8956

I am certain this (and msm8976) were added in [1] but it somehow got
lost when that was merged as 05c0c38dc752 ("dt-bindings: arm: qcom:
Document msm8956 and msm8976 SoC and devices")?

Should we also add qcom,msm8976 or only when a user for that board is
added?

[1]: https://lore.kernel.org/linux-arm-msm/20221111120156.48040-9-angelogioacchino.delregno@collabora.com/

>                - qcom,msm8992
>                - qcom,msm8994
>                - qcom,msm8996
>                - qcom,msm8998
>                - qcom,sdm630
>                - qcom,sdm632
> +              - qcom,sdm636
>                - qcom,sdm845
>                - qcom,sdx55
>                - qcom,sdx65
> +              - qcom,sm4250

qcom,sm6115 could be added as well unless you rather leave that to the
person(s) adding the board compatible later on.

- Marijn

>                - qcom,sm6125
>                - qcom,sm6350
>                - qcom,sm7225
> @@ -957,6 +960,8 @@ allOf:
>                - oneplus,dumpling
>                - oneplus,enchilada
>                - oneplus,fajita
> +              - oneplus,oneplus3
> +              - oneplus,oneplus3t
>      then:
>        properties:
>          qcom,board-id:
> -- 
> 2.34.1
> 
