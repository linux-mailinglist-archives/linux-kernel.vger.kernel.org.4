Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC8B56B7129
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 09:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjCMI26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 04:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjCMI2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 04:28:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9632235257;
        Mon, 13 Mar 2023 01:28:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 350DFB80E43;
        Mon, 13 Mar 2023 08:28:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB9CEC433D2;
        Mon, 13 Mar 2023 08:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678696125;
        bh=8hqvgA81WhlKH7GiULB7fMHFFqWZRI5FZBkLu0vavzY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ph6h+CSUjqzZED4DEOBt/X1W9D6cYIFExUZdRsKR/PK8eXLpdjFbw6/7hp7PVuZIW
         Pk0zmzVxCAFegVjTlQlZFP8C8eaxdk6QWgBt/Bpo/pQvRiYvCp9UplEiteFdz1m7wd
         QJbqhb386S8KL83dcCeCV9EyM7puLB/uLmU+OQldcIY2iYz8fIJ5XVtwaYopTLns5O
         5U8ArinP7rGEy/A3FdrzZKGqusRKqtIJswLURjLXNthZVvXcQPPXmeVvQNu39kDCGY
         UNnK3DQNHHC5W60McbCWW/oDPw+T565rOMPIEMGqmZNU6N1MixMgrxGjaTHnXnq8U8
         2onP2bsNkgaZw==
Date:   Mon, 13 Mar 2023 16:28:34 +0800
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
Subject: Re: [PATCH 2/6] ARM: dts: imx6dl-yapp4: Change LED channel names
 according to dt-binding
Message-ID: <20230313082834.GO143566@dragon>
References: <20230210154855.3086900-1-michal.vokac@ysoft.com>
 <20230210154855.3086900-3-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230210154855.3086900-3-michal.vokac@ysoft.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 04:48:51PM +0100, Michal Vokáč wrote:
> The lp55xx LED controller binding was converted to schema and dtbs_check
> now complains:
> 
>   led-controller@30: 'chan@0', 'chan@1', 'chan@2' do not match any of the regexes
> 
> Use correct names to fix that.
> 
> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>

It's been address as part of this commit:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4b0d1f2738899dbcc7a026d826373530019aa31b

Shawn

> ---
>  arch/arm/boot/dts/imx6dl-yapp4-common.dtsi | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
> index 52162e8c7274..aacbf317feea 100644
> --- a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
> +++ b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
> @@ -274,7 +274,7 @@ leds: led-controller@30 {
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  
> -		chan@0 {
> +		led@0 {
>  			chan-name = "R";
>  			led-cur = /bits/ 8 <0x20>;
>  			max-cur = /bits/ 8 <0x60>;
> @@ -282,7 +282,7 @@ chan@0 {
>  			color = <LED_COLOR_ID_RED>;
>  		};
>  
> -		chan@1 {
> +		led@1 {
>  			chan-name = "G";
>  			led-cur = /bits/ 8 <0x20>;
>  			max-cur = /bits/ 8 <0x60>;
> @@ -290,7 +290,7 @@ chan@1 {
>  			color = <LED_COLOR_ID_GREEN>;
>  		};
>  
> -		chan@2 {
> +		led@2 {
>  			chan-name = "B";
>  			led-cur = /bits/ 8 <0x20>;
>  			max-cur = /bits/ 8 <0x60>;
> -- 
> 2.25.1
> 
