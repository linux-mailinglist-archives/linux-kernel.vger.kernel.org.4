Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1CF7237E0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 08:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234982AbjFFGjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 02:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234658AbjFFGjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 02:39:36 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7717AC7;
        Mon,  5 Jun 2023 23:39:32 -0700 (PDT)
X-GND-Sasl: maxime.chevallier@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686033570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r3h2rz63OfzutXB59RZcgO/gJzpMB99B07DK2JRkoIg=;
        b=BHCkoLX5X22HoXzHGb8MujppnFnDTWFmr8poVY6B+5CL+Q+Z2ybX6OUWmQicxCJBRYfWoi
        9EnPsX6jCAajf7PbC/053GAthHJh0B9zPk1ZinplqxqpkvqvkrqZKmmRXuzHgVPa5444sx
        DKm3QVtUJLO7PD6G7jQDpv10RyzEUnFQcdoTEhoYL7wkV5wmyaffoZKeyKmoagdx+d4BEW
        0N5v5+OqH9VoEABYsWcGXiLaq39uOe+gRKCzxHsdFjuKCWHzp5ckilEYQwbIqvGJKcVlSt
        vxFPvuDZpAcsuyshfUg5Js/L5x47AI5MrrbGZJ1RC165WIQrh6XgwWhHOFawug==
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
Received: by mail.gandi.net (Postfix) with ESMTPSA id 08A1740006;
        Tue,  6 Jun 2023 06:39:26 +0000 (UTC)
Date:   Tue, 6 Jun 2023 08:39:25 +0200
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     broonie@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, alexis.lothore@bootlin.com,
        thomas.petazzoni@bootlin.com, andrew@lunn.ch, edumazet@google.com,
        pabeni@redhat.com, f.fainelli@gmail.com, hkallweit1@gmail.com,
        linux@armlinux.org.uk, vladimir.oltean@nxp.com,
        ioana.ciornei@nxp.com, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, mcoquelin.stm32@gmail.com,
        joabreu@synopsys.com, alexandre.torgue@foss.st.com,
        peppe.cavallaro@st.com, simon.horman@corigine.com
Subject: Re: [PATCH net-next v4 0/4] net: add a regmap-based mdio driver and
 drop TSE PCS
Message-ID: <20230606083925.2a543bc6@pc-7.home>
In-Reply-To: <20230605114626.188c357f@kernel.org>
References: <20230601141454.67858-1-maxime.chevallier@bootlin.com>
        <168596102478.26938.1530517069555858195.git-patchwork-notify@kernel.org>
        <20230605142039.3f8d1530@pc-7.home>
        <20230605114626.188c357f@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jakub,

On Mon, 5 Jun 2023 11:46:26 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Mon, 5 Jun 2023 14:20:39 +0200 Maxime Chevallier wrote:
> > Thanks for applying the patch, however as mentionned (maybe not
> > stressed enough in the cover) this series depends on a patch that went
> > through the regmap tree :
> > 
> > 
> >  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git/commit/?id=e12ff28764937dd58c8613f16065da60da149048
> > 
> > How can we proceed on that matter ?  
> 
> I don't see a great solution, Mark already applied the change and 
> so did Dave. Don't think we can put them on stable branches now..
> 
> Only altera and stmmac-sogfpga are going to break?
> Maybe we're close enough to the merge window to put our heads 
> in the sand and wait?

only these two should, indeed. I'll still followup with some fixes for
kbuild issues still.

Thanks,

Maxime
