Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF166113A1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 15:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiJ1NwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 09:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiJ1NwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 09:52:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1F71C073A;
        Fri, 28 Oct 2022 06:51:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B12706288D;
        Fri, 28 Oct 2022 13:51:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 241EEC433C1;
        Fri, 28 Oct 2022 13:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666965115;
        bh=8LGyRSk3SzWLea/SocQw2KYwe2/s43N0zn66ZL8tl3w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ocZDdUVBp9IQpEIWrO89mtv1ATbEs0Eyw3QCvjwXDwKu8rEU585hPJeUPquXYXb0c
         E1ryS39iHtVvHHnYXb/kiTKxA7NJ6UETpmJtRBvXEZ4T/Q6d+Gey3Vzl7lNC98/Zw3
         ONWGqUtio6PeKcJOYunHWtjntQ27XotjpZTnmq+xv+8Buswq0rskVxviWz8/+jQbQX
         EMPPcjBqs1Zb//8p4dN0O8+DDI4iXPYFNxUHsH63yU8UnYB2Em2bN49ZCD+SxqCL5t
         u0B1hxwIRwUkPK4nx9KbCfBJD8fuHINT0cao8JGLnfnONuGhoYOij79HlELi1ZB6mj
         IFD/F/zqBUjZg==
Date:   Fri, 28 Oct 2022 08:51:51 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Robert Foss <robert.foss@linaro.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robdclark@gmail.com,
        quic_abhinavk@quicinc.com, dmitry.baryshkov@linaro.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        quic_kalyant@quicinc.com, swboyd@chromium.org,
        angelogioacchino.delregno@somainline.org, loic.poulain@linaro.org,
        quic_vpolimer@quicinc.com, vkoul@kernel.org, dianders@chromium.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org,
        Jonathan Marek <jonathan@marek.ca>, vinod.koul@linaro.org,
        quic_jesszhan@quicinc.com
Subject: Re: [PATCH v1 8/9] arm64: dts: qcom: sm8350-hdk: Enable display &
 dsi nodes
Message-ID: <20221028135150.6rkih4d67trs23h4@baldur>
References: <20221028120812.339100-1-robert.foss@linaro.org>
 <20221028120812.339100-9-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028120812.339100-9-robert.foss@linaro.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 02:08:11PM +0200, Robert Foss wrote:
> Enable the display subsystem and the dsi0 output for
> the sm8350-hdk board.
> 
> Signed-off-by: Robert Foss <robert.foss@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8350-hdk.dts | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
> index e6deb08c6da0..6e07feb4b3b2 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
> @@ -213,10 +213,32 @@ &cdsp {
>  	firmware-name = "qcom/sm8350/cdsp.mbn";
>  };
>  
> +&dispcc {
> +	status = "okay";
> +};
> +
> +&dsi0 {

If you prefix the label for the dsi controller and phy with mdss_ they
sort nicely together with the other display nodes.

Regards,
Bjorn

> +	status = "okay";
> +	vdda-supply = <&vreg_l6b_1p2>;
> +};
> +
> +&dsi0_phy  {
> +	status = "okay";
> +	vdds-supply = <&vreg_l5b_0p88>;
> +};
> +
>  &gpi_dma1 {
>  	status = "okay";
>  };
>  
> +&mdss {
> +	status = "okay";
> +};
> +
> +&mdss_mdp {
> +	status = "okay";
> +};
> +
>  &mpss {
>  	status = "okay";
>  	firmware-name = "qcom/sm8350/modem.mbn";
> -- 
> 2.34.1
> 
