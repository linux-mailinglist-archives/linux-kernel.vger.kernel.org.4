Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4410E6FD982
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236668AbjEJIdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236656AbjEJIde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:33:34 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC51618E;
        Wed, 10 May 2023 01:32:40 -0700 (PDT)
Received: from pendragon.ideasonboard.com (softbank126090219015.bbtec.net [126.90.219.15])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 98ED3547;
        Wed, 10 May 2023 10:32:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1683707550;
        bh=nM5QgPKfCmF1wsdKevgnAnxt/AZVokp9Qof29aUhkvg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aTfGTkbf55Iin4WvtgASq0rmKw74QUQK/aFuVHPOS5F1TYxrcxkjaqpmpYEi62imV
         XYHX/9amSrEUACNxnn6OUF0xgn0ga2pj9bKgzQQ93kjyofikVBFO9HzU+zZMgq9Mws
         DTd6v6bz0kza408GMzCpo80okVtE7IUhKRpb0Yds=
Date:   Wed, 10 May 2023 11:32:33 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Michal Simek <michal.simek@amd.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Harini Katakam <harini.katakam@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Piyush Mehta <piyush.mehta@xilinx.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Tanmay Shah <tanmay.shah@amd.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 20/23] arm64: zynqmp: Rename ams_ps/pl node names
Message-ID: <20230510083233.GH11711@pendragon.ideasonboard.com>
References: <cover.1683034376.git.michal.simek@amd.com>
 <373136eccf8d22cdfb499adbc8d5f5510d6c1035.1683034376.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <373136eccf8d22cdfb499adbc8d5f5510d6c1035.1683034376.git.michal.simek@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

Thank you for the patch.

On Tue, May 02, 2023 at 03:35:48PM +0200, Michal Simek wrote:
> Fix child node names to be aligned with commit 39dd2d1e251d ("dt-bindings:
> iio: adc: Add Xilinx AMS binding documentation") which requires names as
> ams-ps@ and ams-pl@.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> 
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> index 7bd3e816226a..d01d4334c95f 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -955,13 +955,13 @@ xilinx_ams: ams@ffa50000 {
>  			#io-channel-cells = <1>;
>  			ranges = <0 0 0xffa50800 0x800>;
>  
> -			ams_ps: ams_ps@0 {
> +			ams_ps: ams-ps@0 {
>  				compatible = "xlnx,zynqmp-ams-ps";
>  				status = "disabled";
>  				reg = <0x0 0x400>;
>  			};
>  
> -			ams_pl: ams_pl@400 {
> +			ams_pl: ams-pl@400 {
>  				compatible = "xlnx,zynqmp-ams-pl";
>  				status = "disabled";
>  				reg = <0x400 0x400>;

-- 
Regards,

Laurent Pinchart
