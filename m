Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7ABB5E6E6F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 23:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiIVVdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 17:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiIVVc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 17:32:58 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3838D10E5D2;
        Thu, 22 Sep 2022 14:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
        In-Reply-To:References; bh=e5T5IZ2kW4KLNa3EeXF0wiTvE72Xg517TN+86OQ2OK8=; b=fI
        RONZsrFiCsYnQcrDmmSjrRxxYhnRULyR0kCamV89ao9AeYAI4pso/wfPTlxKgpssHRIXPWTQfT8MY
        WgibB/Fk7CQFz/t0iRzTMqG9SnTabYU+LAvmuOGwNFBQE1WWd+aYBuR8leTKLob7tBgWN+ZdqvJj3
        iHUTKQvgzlayv0Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1obToM-00HZb9-6y; Thu, 22 Sep 2022 23:32:46 +0200
Date:   Thu, 22 Sep 2022 23:32:46 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Mauri Sandberg <maukka@ext.kapsi.fi>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, arnd@arndb.de, olof@lixom.net,
        sebastian.hesselbarth@gmail.com, gregory.clement@bootlin.com,
        linux@armlinux.org.uk, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/3] ARM: dts: orion5x: Add D-Link DNS-323 Device Tree
Message-ID: <YyzUfs4u2z3jjiU7@lunn.ch>
References: <20220427162123.110458-1-maukka@ext.kapsi.fi>
 <20220922202458.7592-1-maukka@ext.kapsi.fi>
 <20220922202458.7592-3-maukka@ext.kapsi.fi>
 <YyzJe9+S83vByosb@lunn.ch>
 <20220922211408.56num4k6r746kzht@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220922211408.56num4k6r746kzht@pali>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 11:14:08PM +0200, Pali Rohár wrote:
> On Thursday 22 September 2022 22:45:47 Andrew Lunn wrote:
> > > +&mdio {
> > > +	status = "okay";
> > > +
> > > +	ethphy: ethernet-phy {
> > > +		reg = <8>;
> > 
> > Since you have a reg value, this should be ethernet-phy@9
> 
> ethernet-phy@8 no?

Yes, @8. Sorry.

     Andrew
