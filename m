Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8696E4444
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 11:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjDQJqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 05:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjDQJqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 05:46:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24C72D62;
        Mon, 17 Apr 2023 02:46:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07A6361261;
        Mon, 17 Apr 2023 09:45:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A25C433EF;
        Mon, 17 Apr 2023 09:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681724753;
        bh=xFEBMGmd7Mk5+H9Ze+mGV6l0JUy6WwOM2TTVW6ctmag=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RTXhlnBoFTQVPHf+Bfy7/A8I6yleRkZxpO3sTM7Oz46EQo230zyoJjlgBA5jIYdpI
         +1lhm+BVb6z5oa7DwRqU+yRJvTAuvMG7qM6mvOLcIzRcIa/qz4rknTvPgODqvKlroR
         aw4HBAR/VhHSUXi0ZbVV2bfZPr3pO0qblmcvF3rfPilpmhvJVkSAe4UOdYYeavmRBH
         TucTZOeidtFmLLbHCtyKqeL8LxGF/CWJA3AKqNayF22r6J2qRZ9D9HtWYajnQ+iNc8
         EEVfIri+UY4LbyXcCPOO827VJbvi3Bh8BzXqOwCRANsWKGZZaDENZ2haYsRTCaWFgE
         KfK8v2/xwN7HQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1poLQv-00066X-2Q; Mon, 17 Apr 2023 11:46:01 +0200
Date:   Mon, 17 Apr 2023 11:46:01 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp: Revert "arm64: dts: qcom:
 sc8280xp: remove superfluous "input-enable""
Message-ID: <ZD0VWVLuANWB1VI7@hovoldconsulting.com>
References: <20230411170938.1657387-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411170938.1657387-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 07:09:38PM +0200, Krzysztof Kozlowski wrote:
> This reverts commit 87e1f7b1a041a37390bf4fa7913683fb4f8d00d8 because it

Unless using the default revert commit message, I think you should
follow the standard way of referring to commits (e.g. 12 chars SHA +
summary in parenthesis).

> removed input-enable from the LPASS TLMM, where it is still correct
> (both bindings and Linux driver parse it).
> 
> Reported-by: Johan Hovold <johan@kernel.org>
> Closes: https://lore.kernel.org/all/b7c9ac38-6f9b-8d05-39c6-fee9058209a9@linaro.org/T/#me6c2cc2d87c17c0f30f541e8161a84fdde69f5f5

Are we already accepting Closes tags? I thought that was still under
discussion (even if akpm is currently including this work in his branch
for linux-next). Perhaps better to stick to Link until this has hit
Linus's tree.

Either way, the lore link is unnecessarily long:

Link: https://lore.kernel.org/lkml/ZDVq1b0TjXH5LTYx@hovoldconsulting.com/

is better and includes the right Message-ID.

> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Looks good otherwise:

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

> ---
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index 7608a4800732..ef9bd6ab577d 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -2725,6 +2725,7 @@ data-pins {
>  					pins = "gpio7";
>  					function = "dmic1_data";
>  					drive-strength = <8>;
> +					input-enable;
>  				};
>  			};
>  
> @@ -2742,6 +2743,7 @@ data-pins {
>  					function = "dmic1_data";
>  					drive-strength = <2>;
>  					bias-pull-down;
> +					input-enable;
>  				};
>  			};
>  
> @@ -2757,6 +2759,7 @@ data-pins {
>  					pins = "gpio9";
>  					function = "dmic2_data";
>  					drive-strength = <8>;
> +					input-enable;
>  				};
>  			};
>  
> @@ -2774,6 +2777,7 @@ data-pins {
>  					function = "dmic2_data";
>  					drive-strength = <2>;
>  					bias-pull-down;
> +					input-enable;
>  				};
>  			};

Johan
