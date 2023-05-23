Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B79E770DFCD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 16:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233878AbjEWO5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 10:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237037AbjEWO5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 10:57:36 -0400
Received: from smtp.missinglinkelectronics.com (smtp.missinglinkelectronics.com [162.55.135.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71F3139;
        Tue, 23 May 2023 07:57:30 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp.missinglinkelectronics.com (Postfix) with ESMTP id 460222066D;
        Tue, 23 May 2023 16:57:29 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at missinglinkelectronics.com
Received: from smtp.missinglinkelectronics.com ([127.0.0.1])
        by localhost (mail.missinglinkelectronics.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id aBGxfYAg7Nb9; Tue, 23 May 2023 16:57:29 +0200 (CEST)
Received: from nucnuc.mle (p578c5bfe.dip0.t-ipconnect.de [87.140.91.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: david)
        by smtp.missinglinkelectronics.com (Postfix) with ESMTPSA id B90BC20484;
        Tue, 23 May 2023 16:57:28 +0200 (CEST)
Date:   Tue, 23 May 2023 16:57:23 +0200
From:   David Epping <david.epping@missinglinkelectronics.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net v2 0/3] net: phy: mscc: support VSC8501
Message-ID: <20230523145723.GA8529@nucnuc.mle>
References: <20230523090405.10655-1-david.epping@missinglinkelectronics.com>
 <c613298d-53bc-46ef-9cb2-4b385e21ba7b@lunn.ch>
 <20230523133236.GA7185@nucnuc.mle>
 <ZGzOZm0oJimLHCDA@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGzOZm0oJimLHCDA@shell.armlinux.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 03:32:06PM +0100, Russell King (Oracle) wrote:
> I'm sorry that you're the one who's modifying the driver when we've
> spotted this, but please can you add a patch which first removes
> phydev->lock from vsc85xx_rgmii_set_skews() and then your patch on
> top please?

Sure, no problem, will do that. Thanks for your detailed post.
