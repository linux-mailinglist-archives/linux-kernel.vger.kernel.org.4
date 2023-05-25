Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB034710FF8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 17:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241346AbjEYPvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 11:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241186AbjEYPun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 11:50:43 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD32D10B;
        Thu, 25 May 2023 08:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=9zPZPSkgvuyotoAA/KTUJbfPBjL1vH6aa8V0io941jQ=; b=LDOqAV1ryRWXbT+F5bkBsxp4rW
        3yuiEn6uzp08iegx29y+n2fARDgg7gwGNPWdd5NKemk6BLw59COhjne3TSxgQlzX8uz9p/vA8cEjm
        JGrUHYHa6cHUxZRLnwxO++Y2ZYT+dgCF1qHQlpdBarooN9iOFtu6cV1W1kNjvBA7ydYA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1q2DEL-00DuN4-UJ; Thu, 25 May 2023 17:50:21 +0200
Date:   Thu, 25 May 2023 17:50:21 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     =?iso-8859-1?Q?Ram=F3n?= Nordin Rodriguez 
        <ramon.nordin.rodriguez@ferroamp.se>
Cc:     Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
        hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        horatiu.vultur@microchip.com, Woojung.Huh@microchip.com,
        Nicolas.Ferre@microchip.com, Thorsten.Kummermehr@microchip.com
Subject: Re: [PATCH net-next v3 2/6] net: phy: microchip_t1s: replace
 read-modify-write code with phy_modify_mmd
Message-ID: <99ccdedb-c2c7-4187-9fb4-b2047480e097@lunn.ch>
References: <20230524144539.62618-1-Parthiban.Veerasooran@microchip.com>
 <20230524144539.62618-3-Parthiban.Veerasooran@microchip.com>
 <ZG9/E8Am2ICEHIbr@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZG9/E8Am2ICEHIbr@debian>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This change also invalidates most of the comment. I think this should be
> reduced to something along the lines of:
> 	/* HW quirk: Microchip states in the application note (AN1699) for the phy
> 	 * that a set of read-modify-write (rmw) operations has to be performed
> 	 * on a set of seemingly magic registers.
> 	 * The result of these operations is just described as 'optimal performance'
> 	 * Microchip gives no explanation as to what these mmd regs do,
> 	 * in fact they are marked as reserved in the datasheet.*/

I agree the comments should be reviewed in light of these changes.

> 
> Additionally I don't mind it if you change the tone of the comment. This was brought
> up in the sitdown we had, where it was explained from Microchip that
> documenting what the reg operations actually does would expose to much
> of the internal workings of the chip.

They cannot care too much, or the firmware in the PHY would do this
where it is all hidden away.

      Andrew
