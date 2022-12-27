Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74C5E656D64
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 18:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbiL0RRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 12:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiL0RRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 12:17:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEB1B7EB;
        Tue, 27 Dec 2022 09:17:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BD0B611D3;
        Tue, 27 Dec 2022 17:17:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D92B0C433EF;
        Tue, 27 Dec 2022 17:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672161431;
        bh=VOvlCwr5LLF0HAoX/UmrUWREOtmjLsXsnQlpggXBacU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gDUT4k0XuF6YugBeTZIwZ2BVnU5TvFzPiG75xZLI0k2+51dJalWvcg/PKG5nMXAVV
         HfjSABzczinMtVCm+DVfuZG8f3w0K63PaMVNtV8jPz+PrFqt/ZCq4CTfuJDTuYmQNz
         b4BUiqnaV/7qzUFvw0c4svGp+cUy7VaYGlxqgrxxGSZ7RMM2EMY60F/DvJYs9Jh7LE
         oMPmm9q/3OGDGUkllwKnrFyLDYGgZWZeTiVI74jgiDu5owN/g48Dekqwwyn5FQBQpy
         T7e+OKFE0tNoWJEVkc365HOpRV4c5ottr3xBS/IiiCgJYnu7Jlg7kPLRz4MrUM0cVd
         ibYEM3UGPdveA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pADZg-0005qB-BM; Tue, 27 Dec 2022 18:17:12 +0100
Date:   Tue, 27 Dec 2022 18:17:12 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] arm64: dts: qcom: align OPP table node name with DT
 schema
Message-ID: <Y6somGn+V0CAxVA5@hovoldconsulting.com>
References: <20221225115844.55126-1-krzysztof.kozlowski@linaro.org>
 <20221225115844.55126-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221225115844.55126-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 25, 2022 at 12:58:42PM +0100, Krzysztof Kozlowski wrote:
> Bindings expect OPP tables to start with "opp-table".
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8996-v3.0.dtsi | 2 +-
>  arch/arm64/boot/dts/qcom/sa8540p.dtsi      | 4 ++--
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi     | 6 +++---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi       | 2 +-
>  4 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8996-v3.0.dtsi b/arch/arm64/boot/dts/qcom/msm8996-v3.0.dtsi
> index 5728583af41e..929bdcd45d02 100644
 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index 109c9d2b684d..89004cb657e0 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -33,7 +33,7 @@ sleep_clk: sleep-clk {
>  		};
>  	};
>  
> -	cpu0_opp_table: cpu0-opp-table {
> +	cpu0_opp_table: opp-table-cpu0 {
>  		compatible = "operating-points-v2";
>  		opp-shared;
>  
> @@ -123,7 +123,7 @@ opp-2438400000 {
>  		};
>  	};
>  
> -	cpu4_opp_table: cpu4-opp-table {
> +	cpu4_opp_table: opp-table-cpu4 {
>  		compatible = "operating-points-v2";
>  		opp-shared;
>  
> @@ -591,7 +591,7 @@ CLUSTER_PD: cpu-cluster0 {
>  		};
>  	};
>  
> -	qup_opp_table_100mhz: qup-100mhz-opp-table {
> +	qup_opp_table_100mhz: opp-table-qup100mhz {
>  		compatible = "operating-points-v2";
>  
>  		opp-75000000 {

Please also move these nodes after the 'memory' node so that they remain
sorted by name.

Johan
