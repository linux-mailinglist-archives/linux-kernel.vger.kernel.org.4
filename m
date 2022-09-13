Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 044A95B6B66
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 12:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbiIMKHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 06:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbiIMKHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 06:07:39 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478D32CC8C;
        Tue, 13 Sep 2022 03:07:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2CB7CCE1122;
        Tue, 13 Sep 2022 10:07:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE3F8C433D6;
        Tue, 13 Sep 2022 10:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663063653;
        bh=9T09pnZ4br3N5U7hSARbndf3XneEvzKGBgD2m355k6U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EVtodVYM0Atf9N+5W/k/GHEkAuhbUSmUtshrsGrqF0nxKiat3+D0MIxwxSly66xTR
         1HJlvhkN0QZQu0OA4NHJw/hplCKNHMgp9A+fhZYRKfUB80AdcZ4F36x+YUA/EFy4n8
         zEiI3dV8t4NKzP4F4AftmZS49CXCd2XTfhajmZAh3pBDbbM/qLRgqPsmN6xTcECksx
         si1pih/ndkD3/Ab2B8i0fAGPYQczAmF3oP54KPpmNu6AZ4EeEJprwiG0p9Z5Q4rurt
         L1ZiUCQLsHcW2VSZUonuLczNElqZIFtr+MOftEkePKZGS0zoY8SGWzgHQb9n8Opt6v
         N8s3k92sjZf3g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oY2pI-0006Wa-7D; Tue, 13 Sep 2022 12:07:32 +0200
Date:   Tue, 13 Sep 2022 12:07:32 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     konrad.dybcio@somainline.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, johan+linaro@kernel.org,
        steev@kali.org
Subject: Re: [PATCH] arm64: dts: qcom: thinkpad-x13s: Update firmware location
Message-ID: <YyBWZOMz3mKlje05@hovoldconsulting.com>
References: <20220913054030.3234-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913054030.3234-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Resend with Bjorn's address updated as the Linaro one now bounces. ]

On Tue, Sep 13, 2022 at 11:10:30AM +0530, Manivannan Sadhasivam wrote:
> The firmware location in linux-firmware has been changed to include the
> SoC name. So use the updated location in Thinkpad devicetree.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

I guess we should pick a commit prefix that we stick to for changes to
this driver.

	arm64: dts: qcom: sc8280xp-lenovo-thinkpad-x13s:

is arguably unnecessarily long even if it follows the pattern of some
other qcom dts.

Shall we just use

	arm64: dts: qcom: sc8280xp-x13s:

which matches sc8280xp-crd? Or stick "lenovo" in there as well? Or just
keep the whole thing unchanged?

> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> index c379650e52b1..3b7943d6e164 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> @@ -554,13 +554,13 @@ keyboard@68 {
>  };
>  
>  &remoteproc_adsp {
> -	firmware-name = "qcom/LENOVO/21BX/qcadsp8280.mbn";
> +	firmware-name = "qcom/sc8280xp/LENOVO/21BX/qcadsp8280.mbn";
>  
>  	status = "okay";
>  };
>  
>  &remoteproc_nsp0 {
> -	firmware-name = "qcom/LENOVO/21BX/qccdsp8280.mbn";
> +	firmware-name = "qcom/sc8280xp/LENOVO/21BX/qccdsp8280.mbn";
>  
>  	status = "okay";
>  };

Change itself looks good otherwise:

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

Johan
