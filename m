Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A9F6C999A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 04:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjC0C26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 22:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjC0C2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 22:28:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0CF49E5;
        Sun, 26 Mar 2023 19:28:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3197FB80B2D;
        Mon, 27 Mar 2023 02:28:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D431C433EF;
        Mon, 27 Mar 2023 02:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679884131;
        bh=yEnbU4jXi0im10fYUjokipCSwa2/toPw9vBKXRJ/ogg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JovX1fMzg6gRSGQwt/R8zxIjrJ8pze+N2oOsv1QcGhBMxmn12HClC/MqKejng/9Zr
         2x0kV2Po5OdWHCqaiTC1QsqbQfstKXqAs0wMSonWCAEzlHUpLRwKYQpcPIHOZyvCYj
         kY5oEA1z8bCwmGlzIK0LLkfN/hm+YNKDy/KjmTOg/YijGlB1QekkoqxwHKn6B1jM41
         DVTSNjeO+Iy+ThC/c1jYjoo0YS22lwvz4PvUCFB7yXTTzEDDPaaXe/I9gUvsGjtuOB
         KslI6sSyOJXwrNKu9D5Bjmd3m6fJ+kzuYAxjY0shN6Te4tnmSOhljRj6bPv8K3gBTf
         xw3I1gjTA425g==
Date:   Mon, 27 Mar 2023 10:28:44 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/5] =?iso-8859-1?B?QVJNOqBk?= =?iso-8859-1?B?dHM6?=
 imx6dl-yapp4: Move status to the end of property list
Message-ID: <20230327022844.GE3364759@dragon>
References: <20230314180608.44482-1-michal.vokac@ysoft.com>
 <20230314180608.44482-3-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230314180608.44482-3-michal.vokac@ysoft.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 07:06:05PM +0100, Michal Vokáč wrote:
> The status property should always be last in the list.
> 
> Fixes: b86d3d21cd4c ("ARM: dts: imx6dl-yapp4: Add reg property to the lp5562 channel node")

It's not really a bug fix but only a cosmetic change.  Dropped this tag
and applied the series.

Shawn

> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
> ---
> Changes in v2:
> - new patch
> 
>  arch/arm/boot/dts/imx6dl-yapp4-common.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
> index cb1972f8e8d2..8a78a656bac0 100644
> --- a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
> +++ b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
> @@ -269,9 +269,9 @@ leds: led-controller@30 {
>  		compatible = "ti,lp5562";
>  		reg = <0x30>;
>  		clock-mode = /bits/ 8 <1>;
> -		status = "disabled";
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> +		status = "disabled";
>  
>  		led@0 {
>  			chan-name = "R";
> -- 
> 2.25.1
> 
