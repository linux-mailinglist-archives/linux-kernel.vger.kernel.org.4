Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23CAD645420
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 07:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiLGGmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 01:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiLGGl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 01:41:56 -0500
X-Greylist: delayed 104 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 06 Dec 2022 22:41:51 PST
Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB7C140E6;
        Tue,  6 Dec 2022 22:41:51 -0800 (PST)
Received: by soltyk.jannau.net (Postfix, from userid 1000)
        id E640B26F49A; Wed,  7 Dec 2022 07:41:49 +0100 (CET)
Date:   Wed, 7 Dec 2022 07:41:49 +0100
From:   Janne Grunau <j@jannau.net>
To:     Asahi Lina <lina@asahilina.net>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Marc Zyngier <maz@kernel.org>, asahi@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64 dts: apple: t600x-pmgr: Fix search & replace typo
Message-ID: <20221207064149.GB20388@jannau.net>
References: <20221207014305.21018-1-lina@asahilina.net>
 <20221207014305.21018-2-lina@asahilina.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207014305.21018-2-lina@asahilina.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-07 10:43:05 +0900, Asahi Lina wrote:
> It looks like the search-and-replace that happened to add die IDs to
> the t600x PMGR tree was a little bit too eager on a comment, and nobody
> noticed! Let's fix that.
> 
> Fixes: fa86294eb355 ("arm64: dts: apple: Add initial t6000/t6001/t6002 DTs")
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> ---
>  arch/arm64/boot/dts/apple/t600x-pmgr.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/apple/t600x-pmgr.dtsi b/arch/arm64/boot/dts/apple/t600x-pmgr.dtsi
> index b8daeb0368d5..0bd44753b76a 100644
> --- a/arch/arm64/boot/dts/apple/t600x-pmgr.dtsi
> +++ b/arch/arm64/boot/dts/apple/t600x-pmgr.dtsi
> @@ -225,7 +225,7 @@ DIE_NODE(ps_afr): power-controller@1e8 {
>  		#power-domain-cells = <0>;
>  		#reset-cells = <0>;
>  		label = DIE_LABEL(afr);
> -		/* Apple Fabric, media DIE_NODE(stuff): this can power down */
> +		/* Apple Fabric, media stuff: this can power down */
>  	};
>  
>  	DIE_NODE(ps_afnc1_ioa): power-controller@1f0 {

thanks

Reviewed-by: Janne Grunau <j@jannau.net>
