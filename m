Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B2E615531
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 23:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbiKAWlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 18:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiKAWln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 18:41:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2609765CA;
        Tue,  1 Nov 2022 15:41:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B58A461646;
        Tue,  1 Nov 2022 22:41:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 077BBC433D6;
        Tue,  1 Nov 2022 22:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667342501;
        bh=6LjcZLlfXDajYf+UxU5rviBR8j+wzEQGyunyc6QKoJ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NZOE4r2QOoMe/gw6ilbIheWaB6WW2CopdX6sszLKtSf51i55E0x3CdPKTjETEh05p
         fqCqJbcStGs5o0GjS6DAA3Mt2FUelOJ0c4b783TWqtCG/J5uzUGgfNDuDuCrNTed/c
         x9p8qf1C4qwUFoH5ddS7FJb/rtemnlUmq7X9is1ttDCF0msp3ig2A3GEAuQ5uNaG5/
         vmv2jaKXwwBXui/z1s0nGzJZoxm/Brk2o9VTwJJB8QWlPAC5g7geAXTFidNy+178nV
         Q7eT1lW1l0v0gZv6BFxXkfw2QTyEVwtMQb6ZY1YUugwGNohIRy3fL9yzqfFlDDg7VO
         lqkneEc9Kbsjg==
Received: by pali.im (Postfix)
        id E0C277F8; Tue,  1 Nov 2022 23:41:38 +0100 (CET)
Date:   Tue, 1 Nov 2022 23:41:38 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Gregory Clement <gregory.clement@bootlin.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: turris-omnia: Add switch port 6 node
Message-ID: <20221101224138.66utw2el3kc2opgx@pali>
References: <20220825122102.18634-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220825122102.18634-1-pali@kernel.org>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PING?

On Thursday 25 August 2022 14:21:02 Pali Rohár wrote:
> Switch port 6 is connected to eth0, so add appropriate device tree node for it.
> 
> Fixes: 26ca8b52d6e1 ("ARM: dts: add support for Turris Omnia")
> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
>  arch/arm/boot/dts/armada-385-turris-omnia.dts | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/armada-385-turris-omnia.dts b/arch/arm/boot/dts/armada-385-turris-omnia.dts
> index f655e9229d68..8215ffb6a795 100644
> --- a/arch/arm/boot/dts/armada-385-turris-omnia.dts
> +++ b/arch/arm/boot/dts/armada-385-turris-omnia.dts
> @@ -463,7 +463,17 @@
>  				};
>  			};
>  
> -			/* port 6 is connected to eth0 */
> +			ports@6 {
> +				reg = <6>;
> +				label = "cpu";
> +				ethernet = <&eth0>;
> +				phy-mode = "rgmii-id";
> +
> +				fixed-link {
> +					speed = <1000>;
> +					full-duplex;
> +				};
> +			};
>  		};
>  	};
>  };
> -- 
> 2.20.1
> 
