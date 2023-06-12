Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0CF72CA60
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 17:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238453AbjFLPhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 11:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237415AbjFLPhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:37:33 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471BE10C3;
        Mon, 12 Jun 2023 08:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=D4Oc+bZss4VIBoUt8LCocGVjkMBkepIH7WJl/EiFV/k=; b=jOOnxa9rWyqzivORQcLNC6jV8Z
        i3F0ez9WkTtGAAlxjZLFJI1ypUW1qdQdqygIOwHhj9M8kea6KAYrIVn946KbSEIf1ndAK3mBwyU9l
        jals9nxAQ7mitms1A+O5pKo4/0uGzKaC8yyC39667QJCNfSM2uHij9yL3Pd/JgVbzg5k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1q8jbe-00FceP-K9; Mon, 12 Jun 2023 17:37:22 +0200
Date:   Mon, 12 Jun 2023 17:37:22 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Jianhui Zhao <zhaojh329@gmail.com>
Cc:     hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: Assign the c45 id to phy_id property when
 matched.
Message-ID: <b89d8987-574e-42cf-aaac-9c3524bc0610@lunn.ch>
References: <20230612143320.2077-1-zhaojh329@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612143320.2077-1-zhaojh329@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 10:33:20PM +0800, Jianhui Zhao wrote:
> If a phydevice use c45, its phy_id property is always 0 previously.
> This change make the phy_id property has a valid value assigned from
> c45 id.

It is more than a valid value. It is the ID which was used to match
the device to a driver.

But as Russell pointed out, it is only valid if a match is made. And
if a match is made, you know what driver is loaded via the symlink in
sysfs. The more interesting use case is no match is performed and you
want to figure out why. And for that, you need all the IDs, since any
can be used to match to a driver.

So, back to a directory of all the IDs

I also asked that you update the sysfs documentation. I've asked this
twice now, and you have not done it. A patch will not be accepted
without the sysfs API documentation.

     Andrew
