Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E091270FC3A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 19:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235343AbjEXRKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 13:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbjEXRKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 13:10:12 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E42BB;
        Wed, 24 May 2023 10:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
        In-Reply-To:References; bh=obSv2d9CNF4TRo5tXs9NOApHq5GFeZyX6XlxyKD/0ls=; b=yE
        gkY/FlfNGqIFvgACokn7CPlkszMIyq8ZvFxmW/N2kvEMFKsjfSbWOuw/lfuzV14U1O6q9Vom0otQC
        yEHtyJ8QlDVp0SHxT+0J6T25nJeIk7YfYGT+wDgYWGCIjEzklgKpxNr5wCHYci+7xDOHjq9mT1Yfs
        15h0G4UupaNobJE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1q1rzx-00Dofj-6Y; Wed, 24 May 2023 19:10:05 +0200
Date:   Wed, 24 May 2023 19:10:05 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        paul.arola@telus.com, scott.roberts@telus.com,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Subject: Re: [PATCH net-next v3 4/7] net: dsa: mv88e6xxx: add field to
 specify internal phys layout
Message-ID: <93e2804a-0da2-48a7-942b-5231772459b9@lunn.ch>
References: <20230524130127.268201-1-alexis.lothore@bootlin.com>
 <20230524130127.268201-5-alexis.lothore@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230524130127.268201-5-alexis.lothore@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 03:01:24PM +0200, Alexis Lothoré wrote:
> mv88e6xxx currently assumes that switch equipped with internal phys have
> those phys mapped contiguously starting from port 0 (see
> mv88e6xxx_phy_is_internal). However, some switches have internal PHYs but
> NOT starting from port 0. For example 88e6393X, 88E6193X and 88E6191X have
> integrated PHYs available on ports 1 to 8
> To properly support this offset, add a new field to allow specifying an
> internal PHYs layout. If field is not set, default layout is assumed (start
> at port 0)
> 
> ---
> Changes since v2:
> - move start/end computation out of for loop
> - remove whitespace
> 
> Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
