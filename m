Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7CF07099FE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 16:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbjESOhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 10:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjESOhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 10:37:19 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A5A10A;
        Fri, 19 May 2023 07:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=S2Fn2CNH6OWUiL3CCPS2gkoRBd4jUgsfIlC5JXckMho=; b=Mm92OALY4N4mF5Iz3bPNMdAExk
        L6ObZEZw3TlIHORHRhY2Q1X0ooWa6f4BOG1LdOl4rHazAbFMGBP6YR2rD4aH6xQvyRihJj+Hf0JT1
        McH0DD9cbJZF0OA4aykKIHxBYoEQiHeXKxJk223SqqpZOFbtE+HkMRqWQPqT3u3tyXJthdFt4FIrG
        fGoyFi8toWoulqrPd9BrL7wXOHlnrGX94uvx82gdmc5QNjvgWyg9ObwyTBrQAA9pUxbHT1f9ijI7H
        bPI6DFHmbsLuM6KtqXj9246gaexJ8gP2UBXTZmZ6VgCi7S9Hw5LaYBAOuerdQAxm4nqmYsAtkk8IY
        Kzml1qzA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47790)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1q01EG-00030j-Qi; Fri, 19 May 2023 15:37:12 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1q01EG-0004gf-3q; Fri, 19 May 2023 15:37:12 +0100
Date:   Fri, 19 May 2023 15:37:12 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     alexis.lothore@bootlin.com
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, paul.arola@telus.com,
        scott.roberts@telus.com,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Subject: Re: [PATCH net-next v2 3/7] net: dsa: mv88e6xxx: use
 mv88e6xxx_phy_is_internal in mv88e6xxx_port_ppu_updates
Message-ID: <ZGeJmNa7XgeSpISZ@shell.armlinux.org.uk>
References: <20230519141303.245235-1-alexis.lothore@bootlin.com>
 <20230519141303.245235-4-alexis.lothore@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230519141303.245235-4-alexis.lothore@bootlin.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2023 at 04:12:59PM +0200, alexis.lothore@bootlin.com wrote:
> From: Alexis Lothoré <alexis.lothore@bootlin.com>
> 
> Make sure to use existing helper to get internal PHYs count instead of
> redoing it manually
> 
> Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
