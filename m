Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344A461F79E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 16:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbiKGP2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 10:28:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232873AbiKGP20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 10:28:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BFFD1E9;
        Mon,  7 Nov 2022 07:28:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15DD56113D;
        Mon,  7 Nov 2022 15:28:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A75BBC433C1;
        Mon,  7 Nov 2022 15:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667834904;
        bh=LLlvsm16wNn4eDOqU2uQK53y2otx5Hg7kZ25DzZ5hu4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uzMWd02gZbMDG7EAbmSNWiOZNtt2CCO9dAMdyArdIe7+J4OspajSrj5NwnqExjbgW
         e5v+8XCy1OaVgiCyCLCMDnltBvfRF1VviAnXe0BlGnE4gfwoXEW/wIb0KCnYGJQeem
         1+/7A0goMOaJMyhr9zBiyqQUCCSTB+LQSb5GKr+VwlQeVP1Y0VUWHZWPgK78hWyXLw
         6UFaUT75xasG1iJ1a8WQZg5RShtNe5m+nPBEzyp+/Y6womBDqaQBXPIaao49deo9U/
         tDWSLqdSeN7NZs17dccxlOn+yVgFBB2MDwnDlLmawxTLxTYlE7EIYmD+xSuZBh2oxj
         AL2/pR1Vm09FA==
Date:   Mon, 7 Nov 2022 23:18:40 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     linux-kernel@vger.kernel.org, Rob.Herring@arm.com,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 19/20] arm64: dts: Update cache properties for synaptics
Message-ID: <Y2kh0C4YCvjOlI7g@xhacker>
References: <20221031092115.533560-1-pierre.gondois@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221031092115.533560-1-pierre.gondois@arm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 10:21:14AM +0100, Pierre Gondois wrote:
> The DeviceTree Specification v0.3 specifies that the cache node
> 'compatible' and 'cache-level' properties are 'required'. Cf.
> s3.8 Multi-level and Shared Cache Nodes
> 
> The recently added init_of_cache_level() function checks
> these properties. Add them if missing.
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>

Reviewed-by: Jisheng Zhang <jszhang@kernel.org>

> ---
>  arch/arm64/boot/dts/synaptics/berlin4ct.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/synaptics/berlin4ct.dtsi b/arch/arm64/boot/dts/synaptics/berlin4ct.dtsi
> index 0949acee4728..926da7e1a6ba 100644
> --- a/arch/arm64/boot/dts/synaptics/berlin4ct.dtsi
> +++ b/arch/arm64/boot/dts/synaptics/berlin4ct.dtsi
> @@ -64,6 +64,7 @@ cpu3: cpu@3 {
>  
>  		l2: cache {
>  			compatible = "cache";
> +			cache-level = <2>;
>  		};
>  
>  		idle-states {
> -- 
> 2.25.1
> 
