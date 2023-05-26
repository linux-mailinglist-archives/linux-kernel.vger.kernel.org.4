Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40DB9712B63
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 19:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237232AbjEZRHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 13:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjEZRHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 13:07:15 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265D6F2;
        Fri, 26 May 2023 10:07:12 -0700 (PDT)
X-GND-Sasl: maxime.chevallier@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1685120831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dLtQUPZvC6LXco0Vx6AbaJ5HU7nv5vKBXlxIPke6z2Y=;
        b=CECpw3jEVwuuKSlFLCkzKlgJtZIWmEHnjED4pWNOGYwHBJrqO6sf5p7UDG690IZ1rQOkIk
        uccVNqiMPwntgpaPwZrWVQISP02SBSYaGartrfM6cueTkfN9GMtZEqEANkdiQYdd+5Wog9
        kI2MVxiSKMClhk5O75rUDMNkZwLbkIGwyuJu2/UgBjfcbkX2uMZBJ7uWfIJFr49mDsDB/p
        O1UsRMlMM8oQnUc2zpDPMgz2Hvo3ide+77FwvMNanOSpJq11QPQuu18vB12u6mvsxlpr64
        T3hXEE75kq4tTx2hKBRUXFNCH0bnF+GwYi76S2yoJuQBlOxNM0LAgzOKdvZ3yg==
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CD8A860006;
        Fri, 26 May 2023 17:07:08 +0000 (UTC)
Date:   Fri, 26 May 2023 19:07:07 +0200
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     Simon Horman <simon.horman@corigine.com>
Cc:     Mark Brown <broonie@kernel.org>, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        alexis.lothore@bootlin.com, thomas.petazzoni@bootlin.com,
        Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>
Subject: Re: [PATCH net-next v3 3/4] net: pcs: Drop the TSE PCS driver
Message-ID: <20230526190707.217c5bde@pc-7.home>
In-Reply-To: <ZHBxH/O/NtssUZTF@corigine.com>
References: <20230526074252.480200-1-maxime.chevallier@bootlin.com>
        <20230526074252.480200-4-maxime.chevallier@bootlin.com>
        <ZHBxH/O/NtssUZTF@corigine.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 May 2023 10:43:11 +0200
Simon Horman <simon.horman@corigine.com> wrote:

> On Fri, May 26, 2023 at 09:42:51AM +0200, Maxime Chevallier wrote:
> > Now that we can easily create a mdio-device that represents a
> > memory-mapped device that exposes an MDIO-like register layout, we
> > don't need the Altera TSE PCS anymore, since we can use the Lynx
> > PCS instead.
> > 
> > Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> > ---
> > V2->V3 : No changes
> > V1->V2 : No changes
> > 
> >  MAINTAINERS                      |   7 --
> >  drivers/net/pcs/Kconfig          |   6 --
> >  drivers/net/pcs/Makefile         |   1 -
> >  drivers/net/pcs/pcs-altera-tse.c | 160
> > ------------------------------- include/linux/pcs-altera-tse.h   |
> > 17 ---- 5 files changed, 191 deletions(-)  
> 
> Less is more.
> 
> Reviewed-by: Simon Horman <simon.horman@corigine.com>
> 

Thanks ! Also kudos to Russell who spotted the similarities between the
TSE and Lynx PCS in the first place, allowing for this driver to be
dropped :)
