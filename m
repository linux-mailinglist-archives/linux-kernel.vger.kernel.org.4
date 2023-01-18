Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23AE8672C5A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 00:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjARXQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 18:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjARXQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 18:16:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E914D613E1;
        Wed, 18 Jan 2023 15:16:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53BB061AAF;
        Wed, 18 Jan 2023 23:16:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D28F8C433D2;
        Wed, 18 Jan 2023 23:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674083791;
        bh=PADYnbxw1Adyx4/MtjFPesFEFnaHJzS21f+PmiHCisU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NFgUS7N44OHhZE0vDJTWjMX9cb7uPqdDx1Uj7CwH7ddy/o95bBdnw8lQH4Z1vTwgV
         /3KPI4/fW9DfK8PER/GyMaVKLjm4YF7tAYTzOZIs0996Yguyyv8pBw4QhNuY/XHE9G
         HmQ+Z1P+aQsvJ/O9/MsJcD5nqCBJpLQQS3c+pq3OSMKbag0ZpvXMkf/3Isd9wxrwO9
         6ZSVQ3Btf5wC5mYKr5cg0zMTnhC4f/spex2Zk02+q77t4+UGbAeYQjOB15i6ugx3R/
         dJKpyO/TaQJzxZqKb1Lurm4KGFumewNYC89IdvDknYey7BSQGSej9zgdaC2LV7EAfr
         vPPgI50cgj0YQ==
Date:   Wed, 18 Jan 2023 17:16:28 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, agross@kernel.org,
        krzysztof.kozlowski@linaro.org, marijn.suijten@somainline.org,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sibi Sankar <quic_sibis@quicinc.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: interconnect: OSM L3: Add SM6350 OSM
 L3 compatible
Message-ID: <20230118231628.vwstxkqa73wphie2@builder.lan>
References: <20230104171643.1004054-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104171643.1004054-1-konrad.dybcio@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 06:16:40PM +0100, Konrad Dybcio wrote:
> SM6350, similarly to SDM845, uses OSM hardware for L3 scaling.
> Document it.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

> ---
> v1 -> v2:
> No changes
> 
>  Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
> index 00afbbca9038..9d0a98d77ae9 100644
> --- a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
> @@ -22,6 +22,7 @@ properties:
>                - qcom,sc7180-osm-l3
>                - qcom,sc8180x-osm-l3
>                - qcom,sdm845-osm-l3
> +              - qcom,sm6350-osm-l3
>                - qcom,sm8150-osm-l3
>            - const: qcom,osm-l3
>        - items:
> -- 
> 2.39.0
> 
