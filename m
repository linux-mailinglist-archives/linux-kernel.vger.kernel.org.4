Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC006266A6
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 04:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbiKLDhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 22:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiKLDhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 22:37:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA19FD0E;
        Fri, 11 Nov 2022 19:37:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 49E08B827C2;
        Sat, 12 Nov 2022 03:37:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BCBAC433D6;
        Sat, 12 Nov 2022 03:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668224219;
        bh=0g9ekpEMPYtzFy/uKZprRmu5kNFykXkilAU6zhq/3r4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UEVV3k2Xi7W11yIpy3t3IGCsvIJT9ei3M9MGJOa/5rURByn0W5xFrXSHW9yJumv5p
         +Qj+odO5tV1W14H5TvfjDHuEe/xxRRG7lmRlPyz9Y/LxdYuLefZ63+OWTn4Lvsg5Lq
         qe03XC0VYl1p+t49SN/YGyE5/hLxwIzsu/KJUY7EOh9EHoNd9IHrPuooRx5g/OZClm
         ugDPyiNxauGAlT8DVV+rsDBAyhREVbQ5yeBI4Aj+nnHumjInDc5kZw75dPczuIZZGw
         Qk3MS3NbxKF0yI19KCdUNNszCPv18sUnOxDxjRUtcnfcNWO2/L4dQcRQpJd53GeNUk
         UgGto057UVvIw==
Date:   Fri, 11 Nov 2022 21:36:57 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, agross@kernel.org,
        krzysztof.kozlowski@linaro.org, patches@linaro.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: regulator: qcom,smd: Document PMR735a
Message-ID: <20221112033657.bo7a5ghl747qa7xk@builder.lan>
References: <20221110091736.3344-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110091736.3344-1-konrad.dybcio@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 10:17:35AM +0100, Konrad Dybcio wrote:
> PMR735a also appears to be bundled with some SMD RPM SoCs.
> Document it.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

> ---
> Changes since v1:
> - pick up rb
> 
>  .../devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml  | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml
> index 961eed51912c..8c45f53212b1 100644
> --- a/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml
> +++ b/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml
> @@ -71,6 +71,8 @@ description:
>  
>    For pmi8998, bob
>  
> +  For pmr735a, s1, s2, s3, l1, l2, l3, l4, l5, l6, l7
> +
>    For pms405, s1, s2, s3, s4, s5, l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, l11,
>    l12, l13
>  
> @@ -98,6 +100,7 @@ properties:
>        - qcom,rpm-pma8084-regulators
>        - qcom,rpm-pmi8994-regulators
>        - qcom,rpm-pmi8998-regulators
> +      - qcom,rpm-pmr735a-regulators
>        - qcom,rpm-pms405-regulators
>  
>  patternProperties:
> -- 
> 2.38.1
> 
