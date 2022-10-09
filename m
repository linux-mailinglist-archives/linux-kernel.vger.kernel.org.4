Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5FE95F8B05
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 13:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbiJIL5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 07:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiJIL5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 07:57:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9195927FD6;
        Sun,  9 Oct 2022 04:57:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41DE7B80C69;
        Sun,  9 Oct 2022 11:57:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6954C433C1;
        Sun,  9 Oct 2022 11:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665316621;
        bh=hYjoxctxSezsq5WfQzlrPURoHBTIkye+1k5THiZzHcc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yp+jQhKloviZsn82Kw5Z4ALBrWWIwmG0JDFno3WV3TDAIW7qu3ebJQiGjC4zTel/u
         mgW0m4avS92jJRk7hOW9hOIAGzXsq36hmVQ78GAu/uFOEl+DK1uazREpesFwpa1Wl6
         Je4wafpeQ98MfkDO0OzpE3Djaz9r8Y3Pc2Op6Tut9p+tWgi7/POkC/QZEv7tkQhIBt
         Z9ocDqYIJO30FW1se/D/MCM4VLhFVxtW8gFKN4ZxIRUAMoTaRcVYRgyTxo+EbjSvTy
         0seoxjEOmy+9lvYfGO5J5+nvRpTGp6HzLqcgQ3oaKTjh7iVeFbE0IJiDbU5JBgRHpY
         zOpknG7Mt1azQ==
Received: by pali.im (Postfix)
        id 363F57C1; Sun,  9 Oct 2022 13:56:58 +0200 (CEST)
Date:   Sun, 9 Oct 2022 13:56:58 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: marvell: Update Armada 37xx platform
 bindings
Message-ID: <20221009115658.to3yu7zs5iu2goh7@pali>
References: <20220713200123.22612-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220713200123.22612-1-pali@kernel.org>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gregory: ping

On Wednesday 13 July 2022 22:01:23 Pali Rohár wrote:
> Distinguish between Armada 3700 family, Armada 3710 SoC and Armada 3720 SoC.
> Armada 3720 DB is name of the board with Armada 3720 SoC, so correctly
> indicate SoC in example.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
>  .../devicetree/bindings/arm/marvell/armada-37xx.txt        | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt b/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
> index f6d6642d81c0..d2ca008de266 100644
> --- a/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
> +++ b/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
> @@ -4,6 +4,11 @@ Marvell Armada 37xx Platforms Device Tree Bindings
>  Boards using a SoC of the Marvell Armada 37xx family must carry the
>  following root node property:
>  
> + - compatible: must contain "marvell,armada3700"
> +
> +In addition, boards using the Marvell Armada 3710 SoC shall have the
> +following property before the previous one:
> +
>   - compatible: must contain "marvell,armada3710"
>  
>  In addition, boards using the Marvell Armada 3720 SoC shall have the
> @@ -13,7 +18,7 @@ following property before the previous one:
>  
>  Example:
>  
> -compatible = "marvell,armada-3720-db", "marvell,armada3720", "marvell,armada3710";
> +compatible = "marvell,armada-3720-db", "marvell,armada3720", "marvell,armada3700";
>  
>  
>  Power management
> -- 
> 2.20.1
> 
