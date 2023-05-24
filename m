Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A44170F5DD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 14:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbjEXMEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 08:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbjEXMD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 08:03:59 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54189D;
        Wed, 24 May 2023 05:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=QS4dRc2ejXzZCq6ibsWwYoY8UB/tpnmN3LUTUIuEaZY=; b=YUehNb+CS4U7sUnaAmcB1oF8j5
        HqVRuD3aD1Tb2L/c8bXndKfhqmMvU6lhn0FzTpyB0nXZ+UnwSmKBt6n8ly2/giEMiVglIA6khaZyz
        8ewSw8jR+cCaiSz1bQTElF4IrfDUF1IueAvfrlYK2M+fFzvddKuUC3wWfSLDtbEb85FA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1q1nDS-00Dme2-Qf; Wed, 24 May 2023 14:03:42 +0200
Date:   Wed, 24 May 2023 14:03:42 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Parthiban.Veerasooran@microchip.com
Cc:     hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ramon.nordin.rodriguez@ferroamp.se, Horatiu.Vultur@microchip.com,
        Woojung.Huh@microchip.com, Nicolas.Ferre@microchip.com,
        Thorsten.Kummermehr@microchip.com
Subject: Re: [PATCH net-next v2 4/6] net: phy: microchip_t1s: fix reset
 complete status handling
Message-ID: <e0ea8a35-3ea6-43a5-bb5b-a914f86cd492@lunn.ch>
References: <20230522113331.36872-1-Parthiban.Veerasooran@microchip.com>
 <20230522113331.36872-5-Parthiban.Veerasooran@microchip.com>
 <f0769755-6d04-4bf5-a273-c19b1b76f7f6@lunn.ch>
 <b226c865-d4a7-c126-9e54-60498232b5a5@microchip.com>
 <e9db9ce6-dee8-4a78-bfa4-aace4ae88257@lunn.ch>
 <2523bd58-2b2c-723f-6261-aa44ca92e00a@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2523bd58-2b2c-723f-6261-aa44ca92e00a@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> As per the datasheet DS-LAN8670-1-2-60001573C.pdf, during the Power ON 
> Reset(POR)/Hard Reset/Soft Reset, the Reset Complete status bit in the 
> STS2 register to be checked before proceeding for the initial 

register _has_ to be checked before proceeding _to_ the initial

> configuration. Reading STS2 register will also clear the Reset Complete 
> interrupt which is non-maskable.

Otherwise, this is O.K.

	Andrew
