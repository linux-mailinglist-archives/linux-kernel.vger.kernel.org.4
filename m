Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4643D70738B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 23:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjEQVGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 17:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjEQVGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 17:06:19 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F66244A3;
        Wed, 17 May 2023 14:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=9jsEdGvfdDsJ+mT6MXC1fTn4jh5eFXEYIuDnLOJHKSc=; b=f9CpsAplwOwRAUl4dN9HHwKYke
        2CDALifW9qh2d6s4SpqgpxLzzTQDLZKvHKHzMoBm3ws3m+o5UszbNyzbsgJqdlBR4TEnd9drTWlh9
        /S0EokUGG7eNMCX0d55+57aTeCxMrhPMf+1MGD9G5k0uPlEXOt8/XTpORNYWaSWxaJ2k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1pzOLa-00DAmL-EQ; Wed, 17 May 2023 23:06:10 +0200
Date:   Wed, 17 May 2023 23:06:10 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Yeqi Fu <asuk4.q@gmail.com>, mw@semihalf.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ivan Orlov <ivan.orlov0322@gmail.com>
Subject: Re: [PATCH] net: mvpp2: Fix error checking
Message-ID: <58029a01-f46e-439b-be4f-64f3ef726541@lunn.ch>
References: <20230517190811.367461-1-asuk4.q@gmail.com>
 <ZGU03muIumVDu0Gt@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGU03muIumVDu0Gt@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 09:11:10PM +0100, Russell King (Oracle) wrote:
> On Thu, May 18, 2023 at 03:08:11AM +0800, Yeqi Fu wrote:
> > The function debugfs_create_dir returns ERR_PTR if an error occurs,
> > and the appropriate way to verify for errors is to use the inline
> > function IS_ERR. The patch will substitute the null-comparison with
> > IS_ERR.
> 
> Exactly as I said to a very similar patch received a few days ago
> from SikkiLadho:
> 
> "The modern wisdom for debugfs is not to check for any errors, so if
> we're going to touch this, that's the route that any patch should be
> taking.
> 
> Thanks."
> 
> Your patch seems to have the same Suggested-by: which suggests to me
> that you probably know SikkiLadho and are working together with the
> person who suggested the change, so it would be good that when a
> patch from one of you is commented upon, those comments are taken
> into account rather than someone else sending an identical patch to
> the first.

Hi Yeqi

Even better would be you write a patch for the bot you are using to
find these issues and teach it that nothing is actually wrong here, or
suggest to remove all checks.

	Andrew
