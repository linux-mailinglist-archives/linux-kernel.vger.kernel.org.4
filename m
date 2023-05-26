Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC1C7129F0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 17:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244202AbjEZPvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 11:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjEZPvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 11:51:15 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B6E114;
        Fri, 26 May 2023 08:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=luSvtwFvYuWEDfQ0oWnh9KpQF4jauEGj7bA+0Z7dn4Y=; b=OA7OqI7gnvQqMRhLYwoLU6eBos
        sXAQseXvyzb55q9L8L94gtuYNT8Q3H7U9yXwejTnWnRnekY8CFcbpe20VuZio0bz9+xZ8CAXCQOG+
        gfZs40AURVleyDRDNerPyG6/TQ4FKgck+/Q0LsXFaV1mGaIqPnKtwmrFQ+CvRKlRt9Y5b9v3bNQOk
        Tqs+BeduE/jGpym96MQOJNdqQBjOSuWzQN9w8Tn3VHf5N4wGR3Eh8Nn7oJc6R8qL2apVFgmDiiknu
        NPG47lMmnGT3ZPzyN7T5KBeCDgkHW6QCAu1TLsjix32DIdLnt5IDBo910YXcYoMXyEUXkShsISgfh
        WOtBoWtw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44614)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1q2ZiN-0005qz-1e; Fri, 26 May 2023 16:50:51 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1q2ZiC-0003rr-Ob; Fri, 26 May 2023 16:50:40 +0100
Date:   Fri, 26 May 2023 16:50:40 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     arinc9.unal@gmail.com, Sean Wang <sean.wang@mediatek.com>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Richard van Schagen <richard@routerhints.com>,
        Richard van Schagen <vschagen@cs.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Bartel Eerdekens <bartel.eerdekens@constell8.be>,
        erkin.bozoglu@xeront.com, mithat.guner@xeront.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next 24/30] net: dsa: mt7530: rename MT7530_MFC to
 MT753X_MFC
Message-ID: <ZHDVUC1AqncfF2mK@shell.armlinux.org.uk>
References: <20230522121532.86610-1-arinc.unal@arinc9.com>
 <20230522121532.86610-25-arinc.unal@arinc9.com>
 <20230526154258.skbkk4p34ro5uivr@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526154258.skbkk4p34ro5uivr@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 06:42:58PM +0300, Vladimir Oltean wrote:
> On Mon, May 22, 2023 at 03:15:26PM +0300, arinc9.unal@gmail.com wrote:
> >  	/* Disable flooding on all ports */
> > -	mt7530_clear(priv, MT7530_MFC, BC_FFP_MASK | UNM_FFP_MASK |
> > -		     UNU_FFP_MASK);
> > +	mt7530_clear(priv, MT753X_MFC, MT753X_BC_FFP_MASK | MT753X_UNM_FFP_MASK
> > +		     | MT753X_UNU_FFP_MASK);
> 
> The preferred coding style is not to start new lines with operators.
> 
> > +/* Register for CPU forward control */
> >  #define MT7531_CFC			0x4
> >  #define  MT7531_MIRROR_EN		BIT(19)
> > -#define  MT7531_MIRROR_MASK		(MIRROR_MASK << 16)
> > -#define  MT7531_MIRROR_PORT_GET(x)	(((x) >> 16) & MIRROR_MASK)
> > -#define  MT7531_MIRROR_PORT_SET(x)	(((x) & MIRROR_MASK) << 16)
> > +#define  MT7531_MIRROR_MASK		(0x7 << 16)
> 
> minor nitpick: if you express this as GENMASK(18, 16), it will be a bit
> easier to cross-check with the datasheet, since both 18 and 16 are more
> representative than 0x7.
> 
> > +#define  MT7531_MIRROR_PORT_GET(x)	(((x) >> 16) & 0x7)
> 
> also here: (((x) & GENMASK(18, 16)) >> 16)

Even better are:
#define  MT7531_MIRROR_PORT_GET(x)	FIELD_GET(MT7531_MIRROR_MASK, x)

> 
> > +#define  MT7531_MIRROR_PORT_SET(x)	(((x) & 0x7) << 16)
> 
> and here: (((x) << 16) & GENMASK(18, 16))

#define  MT7531_MIRROR_PORT_SET(x)	FIELD_PREP(MT7531_MIRROR_MASK, x)

No need to add parens around "x" in either of these uses as we're not
doing anything with x other than passing it into another macro.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
