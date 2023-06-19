Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB04735C31
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 18:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbjFSQas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 12:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjFSQar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 12:30:47 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7731A6;
        Mon, 19 Jun 2023 09:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=ssmapzNAbmQjO+C53QuWX76d5i6XqjJAh1aMAJuMTMs=; b=59lLnr/4qCprnqH6Xp87Bop/qs
        I+Hv0aDPgkRtdQ2ESGkjZmM1Qt2AAD0VDuwVI2hD1ZXTsDrDjAQuZud5iFGlfyiU0fsctCGVZpYNM
        HTkvuM46bTKLNJYg+EI96X+7OysOHH+8GPfLfqSl2kBDjlEcYkyD9+SOjsWnEz+9NPb8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qBHls-00GvTd-B7; Mon, 19 Jun 2023 18:30:28 +0200
Date:   Mon, 19 Jun 2023 18:30:28 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Francesco Dolcini <francesco@dolcini.it>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Geet Modi <geet.modi@ti.com>,
        Praneeth Bajjuri <praneeth@ti.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net v1] Revert "net: phy: dp83867: perform soft reset and
 retain established link"
Message-ID: <5563611e-5354-42fc-b33f-b1b4945e71de@lunn.ch>
References: <20230619154435.355485-1-francesco@dolcini.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619154435.355485-1-francesco@dolcini.it>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2023 at 05:44:35PM +0200, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> This reverts commit da9ef50f545f86ffe6ff786174d26500c4db737a.
> 
> This fixes a regression in which the link would come up, but no
> communication was possible.
> 
> The reverted commit was also removing a comment about
> DP83867_PHYCR_FORCE_LINK_GOOD, this is not added back in this commits
> since it seems that this is unrelated to the original code change.
> 
> Cc: Praneeth Bajjuri <praneeth@ti.com>
> Closes: https://lore.kernel.org/all/ZGuDJos8D7N0J6Z2@francesco-nb.int.toradex.com/
> Fixes: da9ef50f545f ("net: phy: dp83867: perform soft reset and retain established link")
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

There has been plenty of time given for somebody to investigate this
regression, and nothing has happened. So i agree, lets revert it.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
