Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D940743C78
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 15:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbjF3NQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 09:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjF3NQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 09:16:52 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11301997;
        Fri, 30 Jun 2023 06:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=KWObxhlhiwyPBpeNhUx3gfwUnUTNDGSIphm93nsll0Q=; b=T5+/aB36Re7bQvZ7FQAYDVqW2M
        HvBEC5NOk2UtHC3zbdXmvKwFxDs10q7x3DwXqTF1OtgpthByDklBph7mdszJBsmDcJ7UNu2hbc/JU
        oQL1N24XMb+OxNeEigQBaZau9kK8JGdTFNiFyjAMCLVRMY7hJ89qmISO1ochdspPMbmM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qFDzA-000J2R-M1; Fri, 30 Jun 2023 15:16:28 +0200
Date:   Fri, 30 Jun 2023 15:16:28 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Jie Luo <quic_luoj@quicinc.com>
Cc:     hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] net: phy: at803x: support qca8081 1G chip type
Message-ID: <c2e8eeac-7e2b-48fa-bdf8-fa036e40a8a2@lunn.ch>
References: <20230629034846.30600-1-quic_luoj@quicinc.com>
 <20230629034846.30600-2-quic_luoj@quicinc.com>
 <48e41540-6857-4f61-bcc5-4d0a6dbb9ec1@lunn.ch>
 <b735b442-8818-c66e-5498-9faa2e4984f2@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b735b442-8818-c66e-5498-9faa2e4984f2@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 02:39:06PM +0800, Jie Luo wrote:
> 
> 
> On 6/29/2023 9:14 PM, Andrew Lunn wrote:
> > On Thu, Jun 29, 2023 at 11:48:44AM +0800, Luo Jie wrote:
> > > The qca8081 1G chip version does not support 2.5 capability, which
> > > is distinguished from qca8081 2.5G chip according to the bit0 of
> > > register mmd7.0x901d.
> > > 
> > > The fast retrain and master slave seed configs are only needed when
> > > the 2.5G capability is supported.
> > 
> > Does genphy_c45_pma_read_abilities() work on these devices?
> > 
> >       Andrew
> 
> Hi Andrew,
> yes, genphy_c45_pma_read_abilities works on both normal qca8081 2.5G chip
> and qca8081 1G version chip, even the PHY ID is same, the only difference
> between qca8081 1G and 2.5G chip is the 2.5G capability removed on 1G
> version chip.

Great, then please use it to simply the driver.

       Andrew
