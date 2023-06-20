Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78279736938
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 12:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbjFTK0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 06:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbjFTK0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 06:26:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFFB4A2;
        Tue, 20 Jun 2023 03:26:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 581836119E;
        Tue, 20 Jun 2023 10:26:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CCA1C433C8;
        Tue, 20 Jun 2023 10:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687256794;
        bh=Pm9sy2rMlMGkxvexM4D8WBfM6mwhGIuMyl4IfHISPIA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QfYexD7t8NQLaZ3HaQHVSKkdDFh6Vs4LD1P8C1uF8IWZauvQLGjBcmNXK2OcaTRKm
         AUrwq4IC6w9E2WsOtRD4ktKSMvjWLEXBHf0/lYK/ghJAV3CvsLYYvXPW7a2VL8HlVa
         qopUjnYxvckoJ99MKSTlp14EB5njYvW1OioJHmhcM8JbLoXvTqGKO/njIr/svhApaN
         mRydgNWXFU7TDyEuk2dLqcCWNOxTMGN8I6bqjDjY8c2D4siU7SEwrL9u1t5SZm/XYZ
         iLeCsctRbzeBSQVRfR55PaGi74HErVuAG+9Z/z64L+Ojv//afqhLqkjFF6Dg42fFMV
         TLfB4LEID3RLw==
Date:   Tue, 20 Jun 2023 11:26:29 +0100
From:   Lee Jones <lee@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        "David S. Miller" <davem@davemloft.net>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [net-next PATCH v4 0/3] leds: trigger: netdev: add additional
 modes
Message-ID: <20230620102629.GD1472962@google.com>
References: <20230617115355.22868-1-ansuelsmth@gmail.com>
 <20230619104030.GB1472962@google.com>
 <dd82d1bd-a225-4452-a9a6-fb447bdb070e@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dd82d1bd-a225-4452-a9a6-fb447bdb070e@lunn.ch>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jun 2023, Andrew Lunn wrote:

> > Seeing as we're on -rc7 already, any reason why we shouldn't hold off
> > and simply apply these against LEDs once v6.5 is released?
> 
> Each subsystem has its own policies. netdev tends to accept patches
> right up until the merge window opens, sometimes even a couple of days
> into the merge window for low risk changes. Maybe this is because
> netdev is fast moving, two weeks of not merging results in a big
> backlog of patches, making it a bumpy restart once merging is started
> again. And is some of those late patches breaks something, there is
> still 7 weeks to fix it.
> 
> Since this is cross subsystems i would expect both subsystems
> Maintainers to agree to a merge or not. If you want to be more
> conservative than netdev, wait until after the next merge window,
> please say so.
> 
> If you do decided to wait, you are going to need to create another
> stable branch to pull into netdev. I know it is not a huge overhead,
> but it is still work, coordination etc.

Can you clarify you last point for me please?

-- 
Lee Jones [李琼斯]
