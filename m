Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4366270C21F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 17:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbjEVPQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 11:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233411AbjEVPQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 11:16:11 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4905ECF;
        Mon, 22 May 2023 08:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=gzh0DelY5O74xD3f0GRPPv07lnaaXkzAh2BdsrAJ55Y=; b=jgH6WJZKu2mBEYqqjpC2lYLMdp
        5L7qB0dM8FoErYAEVTU8MnGt95BeGHoYHX9TYLxn08UMk8xh8nr13d7P+2jGVF8iJPSDlRkjUbWBt
        nl1GnuFAF5ReX5A98UUKKknR9m67dsYZu6JGdEnyN3ZbSlbyLjfIPdpd8y5/VJR8mHyI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1q17GO-00DYen-Ug; Mon, 22 May 2023 17:15:56 +0200
Date:   Mon, 22 May 2023 17:15:56 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Francesco Dolcini <francesco@dolcini.it>
Cc:     Praneeth Bajjuri <praneeth@ti.com>, Geet Modi <geet.modi@ti.com>,
        "David S. Miller" <davem@davemloft.net>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Dan Murphy <dmurphy@ti.com>
Subject: Re: DP83867 ethernet PHY regression
Message-ID: <e0d4b397-a8d9-4546-a8a2-14cf07914e64@lunn.ch>
References: <ZGuDJos8D7N0J6Z2@francesco-nb.int.toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGuDJos8D7N0J6Z2@francesco-nb.int.toradex.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 04:58:46PM +0200, Francesco Dolcini wrote:
> Hello all,
> commit da9ef50f545f ("net: phy: dp83867: perform soft reset and retain
> established link") introduces a regression on my TI AM62 based board.
> 
> I have a working DTS with Linux TI 5.10 downstream kernel branch, while
> testing the DTS with v6.4-rc in preparation of sending it to the mailing
> list I noticed that ethernet is working only on a cold poweron.

Do you have more details about how it does not work.

Please could you use:

mii-tool -vvv ethX

in both the good and bad state. The register values might give us a
clue.

Thanks
	Andrew
