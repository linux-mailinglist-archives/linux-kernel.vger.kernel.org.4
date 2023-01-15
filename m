Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88CA66AF6B
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 05:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbjAOEiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 23:38:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbjAOEiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 23:38:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD734EFA;
        Sat, 14 Jan 2023 20:38:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 94F8CB80907;
        Sun, 15 Jan 2023 04:38:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7566C433EF;
        Sun, 15 Jan 2023 04:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673757484;
        bh=xVy20V4MsKJXcMDA0aTh2GPvfQ08g3NbJWqm0fGicV8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b+YztryrLyI9Gn3NNHwGBL/YS9+2lAL/MOPX4agcz7fi9mtCrBnsXyUBnl40wDT6X
         mqsB5Mcla6S/onANhXFH14r3x8WgiyL7CJYXLn1lheoKvuDZPGRWDzWGuleoyqamqA
         JVQEzfoZHczLKFTegDXqnVQrQSkECht8L1XXu4EVMu3QA+8LCIDxVgH5q4A/8wA+1+
         K56YVqsldVy5LMA79jEOQ+PDL3Jvb6Lap1obP4McvH7Pn9P1+d6txjyFimJjNCXhMV
         e9OXOaoMMeElW7AB3jA9BgNkHmznqEENdHq7mrrki6BOjqYiBDZHPkGKlpsZAlhSQD
         qvlHx/OF3V7uQ==
Date:   Sun, 15 Jan 2023 10:07:57 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org,
        marijn.suijten@somainline.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: cpufreq: Make reg-names a required
 property
Message-ID: <20230115043757.GN6568@thinkpad>
References: <20230111205125.1860858-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230111205125.1860858-1-konrad.dybcio@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 09:51:24PM +0100, Konrad Dybcio wrote:
> In preparation for determining the number of frequency domains based
> on reg-names entries, rather than performing calculations based on
> reg entries and parent #{address,size}-cells, make reg-names a
> required property.
> 

As Bjorn mentioned in the driver patch, this would break backwards
compatibility.

Thanks,
Mani

> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> index 99e159bc5fb1..460a7ab7b87c 100644
> --- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> @@ -74,6 +74,7 @@ properties:
>  required:
>    - compatible
>    - reg
> +  - reg-names
>    - clocks
>    - clock-names
>    - '#freq-domain-cells'
> -- 
> 2.39.0
> 

-- 
மணிவண்ணன் சதாசிவம்
