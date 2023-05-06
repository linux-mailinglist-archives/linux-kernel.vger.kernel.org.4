Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4FB6F9238
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 15:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbjEFNSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 09:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbjEFNSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 09:18:35 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433C81CFC1;
        Sat,  6 May 2023 06:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=copZqT4Awq3JwFogujKYu6Qa/kRT3sXtwa10VzFrQvY=; b=2tldN4awosLIqOjCnZf2PjXhX9
        PWeflNPxop0MlRw+lJxVriLGxYmbxqNy5Q4lfN16rlw61echF1/7/RNaZuGDh7Q9BGh5j+l1LdBDr
        lKcIrLap1x272E+VwU11eEoKthzAAl5bamizgCKZ4VnIAmhY8FFaJjhN6Zy2s8yAIXM4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1pvHnm-00C4D0-JH; Sat, 06 May 2023 15:18:18 +0200
Date:   Sat, 6 May 2023 15:18:18 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Tobias Waldekranz <tobias@waldekranz.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH net] net: mdio: mvusb: Fix an error handling path in
 mvusb_mdio_probe()
Message-ID: <ea4446fa-124f-4410-91bb-c4fd291b8e34@lunn.ch>
References: <bd2244d44b914dec1aeccee4eba2e7e8135b585b.1683311885.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd2244d44b914dec1aeccee4eba2e7e8135b585b.1683311885.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2023 at 08:39:33PM +0200, Christophe JAILLET wrote:
> Should of_mdiobus_register() fail, a previous usb_get_dev() call should be
> undone as in the .disconnect function.
> 
> Fixes: 04e37d92fbed ("net: phy: add marvell usb to mdio controller")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
