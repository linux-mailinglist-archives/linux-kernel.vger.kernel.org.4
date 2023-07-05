Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABDA748AEA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 19:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbjGERqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 13:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbjGERqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 13:46:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC91173F;
        Wed,  5 Jul 2023 10:46:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CA7461631;
        Wed,  5 Jul 2023 17:46:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4D66C433C8;
        Wed,  5 Jul 2023 17:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688579170;
        bh=G3kTeTX8laaFf0hfRRCZcXhWR2amOKlU73GvQ4qcxb4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t7XZYnxGaHQrTEoa3uUWqI6cfBF5z93iJcs6rr3+teBc40jn6VlNfjSCu8r1wHPde
         ibHC4IVqgi2LAPpncEkOlcYqpsFopEVi6Cap+Lc0RmUUPCBNLEjUWhUiSPWKNMia/B
         zsmZVQdHjg0vFdlyOLIop1dTx7F7uzs7/NtB/+Og/nNbkHeFUxxw0HsqGjYFjshwho
         rZ1QiDZOTKuHVdayMZxKpb7Wa6xNePF2DevIlUCV+fECgG2JknmF6ZN9Y6ea/ys7wy
         2t6yuE9MPit18brQOiJH+J17m1cEdgi3AnTvT+IV4XkvHY6OgCFa8aoOQocvZGY56E
         Ijt6YtTVjPzEQ==
Date:   Wed, 5 Jul 2023 10:49:52 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc8180x: Fix cluster PSCI suspend param
Message-ID: <4rc27noldhojif23o3wtl622skdwwntaklua6gk3u3jkphclgf@5g4ujstyc6mh>
References: <20230705-topic-8180_sleep-v1-1-c5dce117364e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705-topic-8180_sleep-v1-1-c5dce117364e@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 05:00:05PM +0200, Konrad Dybcio wrote:
> The value was copypasted from 8150, but 8180 expects a different one.
> Confirmed with both downstream device tree and Windows DSDT, not tested
> on hardware (sorry, I don't have any).
> 
> Fix it.
> 
> Fixes: 8575f197b077 ("arm64: dts: qcom: Introduce the SC8180x platform")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn


> ---
>  arch/arm64/boot/dts/qcom/sc8180x.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8180x.dtsi b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
> index be78a933d8eb..e58f931c2e45 100644
> --- a/arch/arm64/boot/dts/qcom/sc8180x.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
> @@ -298,7 +298,7 @@ BIG_CPU_SLEEP_0: cpu-sleep-1-0 {
>  		domain-idle-states {
>  			CLUSTER_SLEEP_0: cluster-sleep-0 {
>  				compatible = "domain-idle-state";
> -				arm,psci-suspend-param = <0x4100c244>;
> +				arm,psci-suspend-param = <0x4100a344>;
>  				entry-latency-us = <3263>;
>  				exit-latency-us = <6562>;
>  				min-residency-us = <9987>;
> 
> ---
> base-commit: e1f6a8eaf1c271a0158114a03e3605f4fba059ad
> change-id: 20230705-topic-8180_sleep-e40beb42250a
> 
> Best regards,
> -- 
> Konrad Dybcio <konrad.dybcio@linaro.org>
> 
