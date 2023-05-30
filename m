Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9906E716414
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbjE3O2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 10:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbjE3O2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 10:28:22 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E9F1B4;
        Tue, 30 May 2023 07:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=8/vdDIsDU6ST333FXZSwbsO/gUQMDDBv1PNxRhPLh+Q=; b=3URFrK/b3TjBET++7MrVKgLYfI
        TvaUrxtL8zlNnXuOTw+D3Ogkk8ydZXg0tu7wZHNRQkicl9SRZyhd8Bv2ygeVMPhiWUn7D2emWYzld
        1tBvSy2uz8idh+3ih+2oO5eaihgsICXw7cEqIDjmtHrmKN8qGw1AKnecO86zwl7n4ans=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1q40JF-00ELGx-Op; Tue, 30 May 2023 16:26:49 +0200
Date:   Tue, 30 May 2023 16:26:49 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Lukasz Majewski <lukma@denx.de>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] net: dsa: slave: Advertise correct EEE capabilities at
 slave PHY setup
Message-ID: <35546c34-17a6-4295-b263-3f2a97d53b94@lunn.ch>
References: <20230530122621.2142192-1-lukma@denx.de>
 <ZHXzTBOtlPKqNfLw@shell.armlinux.org.uk>
 <20230530160743.2c93a388@wsk>
 <ZHYGv7zcJd/Ad4hH@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHYGv7zcJd/Ad4hH@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> So, I'm wondering what's actually going on here... can you give
> any more details about the hardware setup?

And what switch it actually is. I've not looked in too much detail,
but i think different switch families have different EEE capabilities.
But in general, as Russell pointed out, there is no MAC support for
EEE in the mv88e6xxx driver.

    Andrew
