Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA8A713272
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 06:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234341AbjE0EFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 00:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbjE0EFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 00:05:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FA2116;
        Fri, 26 May 2023 21:05:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E78260F78;
        Sat, 27 May 2023 04:05:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4701C4339B;
        Sat, 27 May 2023 04:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685160317;
        bh=nvk/pGdq9FfG7GKJ36vEE0hz8Q1Pi4RYrFKF8BKFUyQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SaBq6zq7nRbF7d/rQY0vmHQLszt2LgoLPD15qP6cZ154iYt4miJsagieXluZl+F73
         BY+KWnv69qBCY4glJnxtvBCz2yAb9BJ8YWp/inh99XatI2hFnfSdtmRt6QdA37uEvN
         YOa7t5Q2Wd7iKzDV+gZMZ2j++hPdIP0zXef3SwYUQWP77UcdUXhW7NuroRsetWeS2i
         nJMVjvu10p4Ps6aPihSdkZpcPV4lJZN+bRmUACpNbT+H9H6WkaxvJKdtbP6fnb3+DV
         4QKDdApCstMWk3gzAwvizNeCF5yUz3AV70GThUM8PG1Wv8qVD8KVYxrUm3d2Vfcc68
         /iPCaJDv/zh1A==
Date:   Fri, 26 May 2023 21:09:05 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Rudraksha Gupta <guptarud@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, david@ixit.cz,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] ARM: Add label to sleep_clk in qcom-msm8960.dtsi
Message-ID: <20230527040905.stmnoshkdqgiaex6@ripper>
References: <20230524230459.120681-1-guptarud@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524230459.120681-1-guptarud@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 07:04:54PM -0400, Rudraksha Gupta wrote:

Thank you for your patches Rudraksha!


Please use:

git log --oneline -- arch/arm/boot/dts/qcom-smm8960.dtsi

And look at how other patches to this file has prefixed their subject
line. Then please follow this in your patches (it differs between
patches...).

> Allows msm8960 DTS files to reference the sleep_clk node.
> 

Please make the purpose clear in your commit message. Specifically,
which part of msm8960 dts needs to reference the sleep clock?


Please also include a cover letter (git format-patch --cover-letter)
when you send a series of patches.

Regards,
Bjorn

> Signed-off-by: Rudraksha Gupta <guptarud@gmail.com>
> ---
>  arch/arm/boot/dts/qcom-msm8960.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom-msm8960.dtsi
> index 2a668cd535cc..a4d8dd2d24a6 100644
> --- a/arch/arm/boot/dts/qcom-msm8960.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8960.dtsi
> @@ -71,7 +71,7 @@ pxo_board: pxo_board {
>  			clock-output-names = "pxo_board";
>  		};
>  
> -		sleep_clk {
> +		sleep_clk: sleep_clk {
>  			compatible = "fixed-clock";
>  			#clock-cells = <0>;
>  			clock-frequency = <32768>;
> -- 
> 2.34.1
> 
