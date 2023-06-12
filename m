Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D79272C709
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 16:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237062AbjFLOKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 10:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233506AbjFLOKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 10:10:51 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D647710D4;
        Mon, 12 Jun 2023 07:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=m03rWMwPE7gqGA7MHPCVEzUL029rB5aoIoIIjHYelOw=; b=IWXMHYciz7hFNjWSEL9a6PIzdH
        mRJ25djIfVImhhezTEXbGPAJtkEo9LUlm8KK+WXt/gTj1tVahwoHK4LxMfcjqfClPaXNb0Q7hjqy9
        DJWal61yjhGIsmyOgg+s2HVQ8pTMp0a2TWrEY9sGffGudmxmZ2gm2AM1RyPpMAuhqRbc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1q8iFb-00Fc62-7i; Mon, 12 Jun 2023 16:10:31 +0200
Date:   Mon, 12 Jun 2023 16:10:31 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Jianhui Zhao <zhaojh329@gmail.com>
Cc:     davem@davemloft.net, edumazet@google.com, hkallweit1@gmail.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH] net: phy: Add sysfs attribute for PHY c45 identifiers.
Message-ID: <062bc2c3-fb3b-43d1-b1d5-4eff754cfe47@lunn.ch>
References: <20230611152743.2158-1-zhaojh329@gmail.com>
 <20230612140426.1648-1-zhaojh329@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612140426.1648-1-zhaojh329@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 10:04:26PM +0800, Jianhui Zhao wrote:
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 17d0d0555a79..81a4bc043ee2 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -541,8 +541,10 @@ static int phy_bus_match(struct device *dev, struct device_driver *drv)
>  
>  			if ((phydrv->phy_id & phydrv->phy_id_mask) ==
>  			    (phydev->c45_ids.device_ids[i] &
> -			     phydrv->phy_id_mask))
> +			     phydrv->phy_id_mask)) {
> +				phydev->phy_id = phydev->c45_ids.device_ids[i];
>  				return 1;
> +			}
>  		}
>  		return 0;
>  	} else {
> 
> How about modifying it like this?

O.K.

Please update the sysfs documentation as well.

       Andrew
