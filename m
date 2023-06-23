Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3181573BBC1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 17:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbjFWPet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 11:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbjFWPeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 11:34:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8AD1FFD
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 08:34:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF20361AAC
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 15:34:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C36D6C433C8;
        Fri, 23 Jun 2023 15:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687534484;
        bh=5F/1bOj9rfDgivkCjgiGDm4pRQrUOqnlQhxZnmM/tEE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cg49VDk6Q/0V8Ky7B5OSjJut4pWQJc2k/BYq4Trm7CFPZl2+XUik/NuJd2+y1xPmy
         tFN/toiOo/Fz48wFP6zXHx0zKPYsfK9k4Sl8NQdXSPwMiNiobVR8+ZTxRRJk5qbYgI
         wqByPPhj5JQWpFcdzAG/PeBJjtxUyDO9jPVkvRIPinILjnSRFKSeplHDF5CcQhpVw0
         Oyn3VJ8xQDUiKXVK3vSMOYqGtFx3jGwadzHO7yjmY6Rd5ZMcGsh9NyekbSSX29Qu7s
         PoEkWZd/smvNPEBemEpWsHMdIkQOBu1tN7dsHxUizSvA7aDGSkO2B0x96NB3uhcp86
         /Rs5PIFczsJag==
Date:   Fri, 23 Jun 2023 08:34:42 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH] net: dsa: qca8k: add support for additional
 modes for netdev trigger
Message-ID: <20230623083442.02b17d69@kernel.org>
In-Reply-To: <64956c02.5d0a0220.ed611.6b79@mx.google.com>
References: <20230621095409.25859-1-ansuelsmth@gmail.com>
        <20230622193120.5cc09fc3@kernel.org>
        <64956c02.5d0a0220.ed611.6b79@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jun 2023 05:10:47 +0200 Christian Marangi wrote:
> > Something may be funny with the date on your system, FWIW, because your
> > patches seem to arrive almost a day in the past.  
> 
> Lovely WSL istance (Windows Subsystem for Linux) that goes out of sync with
> the host machine sometimes. Does the time cause any problem? I will
> check that in the future before sending patches...

Unfortunately for some reason patchwork orders patches by send time,
not by the time the patches arrived, and we use a time-bound query to
fetch new patches. So if the date is too far back the patches won't get
fetched for the build tester.
