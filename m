Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E309E70E388
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 19:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238191AbjEWRhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 13:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234240AbjEWRhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 13:37:35 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71DC8E;
        Tue, 23 May 2023 10:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=NXKwFfu8nmJ95agEH0m9dpdy3EJ7tX+thsbj69CeYBg=; b=V8T+fhTYJrq7NpoMBAeeUINVYO
        bpqn9Vfh1QAxlVT2Oy/BmFMLY24YGFkVN8gCAdYiSAUKCrgk1GIsmNR3lBbPbpZRmXi+kzTZRDfiW
        inBZU7UoVGamWy8SbiAq6zWrfyV1v6KbY1PRH6a6T4zlh6uPVW4RtAe2/ZCLzVCNio58=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1q1Vwq-00DiRV-6s; Tue, 23 May 2023 19:37:24 +0200
Date:   Tue, 23 May 2023 19:37:24 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Vladimir Oltean <olteanv@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/3] net: dsa: mv88e6xxx: add support for MV88E6071
 switch
Message-ID: <357c733d-77fa-42e3-ba0c-ef6e50ff04ef@lunn.ch>
References: <20230523142912.2086985-1-lukma@denx.de>
 <20230523142912.2086985-4-lukma@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523142912.2086985-4-lukma@denx.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 04:29:12PM +0200, Lukasz Majewski wrote:
> A mv88e6250 family (i.e. "LinkStreet") switch with 5 internal PHYs,
> 2 RMIIs and no PTP support.

chip.h says:

        MV88E6XXX_FAMILY_6250,  /* 6220 6250 */

Please update this comment.

I would also suggest you don't call the mv88e6250 family
"LinkStreet". All Marvell SoHo switches are LinkStreet, all switches
supported by the mv88e6xxx driver are "LinkStreet".

With these changes:

Reviewed-by: Andrew Lunn <andrew@lunn.ch>


    Andrew

---
pw-bot: cr
