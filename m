Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2787358AF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 15:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbjFSNeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 09:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjFSNeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 09:34:15 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461ABCF;
        Mon, 19 Jun 2023 06:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=nTWSNiuEhtESNEvZembfyPM0U3olFWyb3kIrhPDUAi8=; b=J2jcfPBY5x/ZtkWeEDS8qw3hNl
        RLSoedlit2R+tdB7rKPyuOXatuiiw7eNPx5DTRttN/tgTZmUoZrM0J9p7I989BT6YZaPMtSboPpaN
        CYILs/twAlH2OVKl7cIfBO+v77YYxll44gZS7qBahgdghX8i+42ZWQJvHdASxkZBgtz0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qBF1A-00Gueb-5D; Mon, 19 Jun 2023 15:34:04 +0200
Date:   Mon, 19 Jun 2023 15:34:04 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Lee Jones <lee@kernel.org>
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        "David S. Miller" <davem@davemloft.net>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [net-next PATCH v4 0/3] leds: trigger: netdev: add additional
 modes
Message-ID: <dd82d1bd-a225-4452-a9a6-fb447bdb070e@lunn.ch>
References: <20230617115355.22868-1-ansuelsmth@gmail.com>
 <20230619104030.GB1472962@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619104030.GB1472962@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Seeing as we're on -rc7 already, any reason why we shouldn't hold off
> and simply apply these against LEDs once v6.5 is released?

Each subsystem has its own policies. netdev tends to accept patches
right up until the merge window opens, sometimes even a couple of days
into the merge window for low risk changes. Maybe this is because
netdev is fast moving, two weeks of not merging results in a big
backlog of patches, making it a bumpy restart once merging is started
again. And is some of those late patches breaks something, there is
still 7 weeks to fix it.

Since this is cross subsystems i would expect both subsystems
Maintainers to agree to a merge or not. If you want to be more
conservative than netdev, wait until after the next merge window,
please say so.

If you do decided to wait, you are going to need to create another
stable branch to pull into netdev. I know it is not a huge overhead,
but it is still work, coordination etc.

       Andrew
