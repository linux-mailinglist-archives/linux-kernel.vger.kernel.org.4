Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 746455E8C1E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 14:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233799AbiIXMOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 08:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbiIXMOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 08:14:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D85E171C;
        Sat, 24 Sep 2022 05:14:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E35E3B80D1B;
        Sat, 24 Sep 2022 12:14:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84222C433C1;
        Sat, 24 Sep 2022 12:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664021642;
        bh=6LjcZLlfXDajYf+UxU5rviBR8j+wzEQGyunyc6QKoJ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BrLRVunGElBOmBjPOJi/u8HwrCVMk3XLMhps9+hUd2oivlgXczbi1FAftsfRKYLR6
         yc6IeQ+baKSEwTYTzgHoXYzdv7qatwOGGfI4DdwgKpZRgnnh3MhEsJ2hLhAz6sSSVk
         PIyhY2yi/HYweVQXxTgf+NAEY9PVdAj8HPjklA7q62WpwdQkVVWaC4Yhse9dekO/7a
         7Kvk+QH1V3FA3QqIG6cUZ1n6tCDixZnpp2c3e8mc/OeSDyXPhUkVPb/3JEq7Tk5EpT
         Ky7NFFPLl+SCnx0fOfKjrV7zwB6QuFU5QO73JPESGfZcoPgTbkaDkpDjQKqJ84EjGG
         wFw1JxBhL/dQA==
Received: by pali.im (Postfix)
        id 24E058A2; Sat, 24 Sep 2022 14:14:00 +0200 (CEST)
Date:   Sat, 24 Sep 2022 14:14:00 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
Subject: Re: [PATCH] ARM: dts: turris-omnia: Add switch port 6 node
Message-ID: <20220924121400.dhpybxi2u2nyhtlq@pali>
References: <20220825122102.18634-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220825122102.18634-1-pali@kernel.org>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
