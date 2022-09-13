Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBBB5B6B46
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 12:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbiIMKBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 06:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbiIMKA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 06:00:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0C4356C1;
        Tue, 13 Sep 2022 03:00:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 086C261376;
        Tue, 13 Sep 2022 10:00:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E3A6C4314A;
        Tue, 13 Sep 2022 10:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663063253;
        bh=FxlTTbRW/PHWQLM1GoFV+cyBk7DG7ySc4dceL+AbcAA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m36TKF+Od7aovmLVkhd6VzfaQH3QQPFD2jJIjUB1cTBbWhHGsAVbHjILijA9zEFGq
         t+CNJvwqRiS06ZSs/43Jk/ZMRe7/g9Rs8GSLNx7UJSviH66AzmkOAGBCE/e/CB157t
         HnAwO4JmfoODZJcMnxSca+unDNZQKQrJGV2BYLowEvMHZakmLNFmkmaoteSLrMCl9O
         vS87clT1cmNLUsluCbV89hmWkDKQFvxIVt97ldS5cBN2oWO3cYjnZs8h+uYwVgEMFm
         pK8MRozpi3QAvAiZUWFgKq3gFmXt6a42/zRptKaAHa28I95oDpLEb5ZoWMc0fBcP4x
         vxPpCfF0k18xg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oY2iq-0005VP-G7; Tue, 13 Sep 2022 12:00:52 +0200
Date:   Tue, 13 Sep 2022 12:00:52 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     bjorn.andersson@linaro.org, konrad.dybcio@somainline.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        johan+linaro@kernel.org, steev@kali.org
Subject: Re: [PATCH] arm64: dts: qcom: thinkpad-x13s: Update firmware location
Message-ID: <YyBU1G9O1l4LqMF7@hovoldconsulting.com>
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
