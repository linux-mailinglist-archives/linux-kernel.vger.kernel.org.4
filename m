Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978727358FE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 15:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbjFSN5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 09:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjFSN5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 09:57:31 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5316510D;
        Mon, 19 Jun 2023 06:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=dauZfH419GwV7AqGYcWLBcBdhZBxvPfNeC7rR2F351c=; b=sFkdi3+Lfzz9qXfd9vmCJ8TUba
        7lILW+oC1H6kEitcKpuSYJASswuU9iKQ//y9pEqqXr+cJV38i17uK/MmvqB9uQc9iHt5+g+pJQ+Oz
        R/IrUHxE1oJPtgdn5/OAcR89LV5nm4oaU0VhqQ+r7hxfn6cwC34joQXHwdwOcICFI/hk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qBFNf-00Guk6-Hv; Mon, 19 Jun 2023 15:57:19 +0200
Date:   Mon, 19 Jun 2023 15:57:19 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Cc:     hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        richardcochran@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, sebastian.tobuschat@nxp.com,
        stable@vger.kernel.org
Subject: Re: [PATCH net v3 1/1] net: phy: nxp-c45-tja11xx: fix the PTP
 interrupt enablig/disabling
Message-ID: <c75ba306-4f7c-4468-bc2a-f27f5f9828a5@lunn.ch>
References: <20230619132851.233976-1-radu-nicolae.pirea@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619132851.233976-1-radu-nicolae.pirea@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2023 at 04:28:51PM +0300, Radu Pirea (NXP OSS) wrote:
> .config_intr() handles only the link event interrupt and should
> disable/enable the PTP interrupt also.
> 
> It's safe to disable/enable the PTP irq even if the egress ts irq
> is disabled. This interrupt, the PTP one, acts as a global switch for all
> PTP irqs.
> 
> Fixes: 514def5dd339 ("phy: nxp-c45-tja11xx: add timestamping support")
> CC: stable@vger.kernel.org # 5.15+
> Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
