Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E7A71F975
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 06:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbjFBEua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 00:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjFBEuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 00:50:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD6AF2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 21:50:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD2D164C44
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 04:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0FAF2C433EF;
        Fri,  2 Jun 2023 04:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685681420;
        bh=nxetWMwym22r3Da4wkbaXrkCtXnbLkInvpg0/XMvFo8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=VPlAUzeUXhEfS8NNUZpwF4mSXRi2HO5IBa6294KFiOMF1Mo1D1ov7riuzoiAaEPul
         WIciGZ7Cg+ieIrblvlQ5YJocRkyYqxYYsbAzyjFPsp9r7FfIs5in9GL1WHWafKDukR
         e6nFYNCfVEl2/mBxCJJAifkMz8Iy/gPjH+b1SG9cA4bYcOpVi3OsJ8DZlenC5MSha7
         fb9scydjG4ikAI25UJ+4U16/lHXyAaaZT6TthXWzANRjLQTHNwYQipuDFvrV0Q8CfU
         d3bH1qORg8+3u7fjgk5bjJVeh/QZO9LLOiBqHM6KKcYnUlDiTNhALnDT8llwJUvkw4
         p+5EF4d0OHa8A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E5339E52BF5;
        Fri,  2 Jun 2023 04:50:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: dsa: lan9303: allow vid != 0 in port_fdb_{add|del}
 methods
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168568141993.21492.6855399273666602310.git-patchwork-notify@kernel.org>
Date:   Fri, 02 Jun 2023 04:50:19 +0000
References: <20230531143826.477267-1-alexander.sverdlin@siemens.com>
In-Reply-To: <20230531143826.477267-1-alexander.sverdlin@siemens.com>
To:     Sverdlin@ci.codeaurora.org,
        Alexander <alexander.sverdlin@siemens.com>
Cc:     netdev@vger.kernel.org, olteanv@gmail.com, andrew@lunn.ch,
        f.fainelli@gmail.com, linux-kernel@vger.kernel.org,
        privat@egil-hjelmeland.no
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 31 May 2023 16:38:26 +0200 you wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> LAN9303 doesn't associate FDB (ALR) entries with VLANs, it has just one
> global Address Logic Resolution table [1].
> 
> Ignore VID in port_fdb_{add|del} methods, go on with the global table. This
> is the same semantics as hellcreek or RZ/N1 implement.
> 
> [...]

Here is the summary with links:
  - net: dsa: lan9303: allow vid != 0 in port_fdb_{add|del} methods
    https://git.kernel.org/netdev/net/c/5a59a58ec25d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


