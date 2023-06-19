Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13BD1734E39
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 10:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbjFSIne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 04:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjFSInF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 04:43:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFD43C33
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 01:41:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B0146160D
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 08:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6411DC433C9;
        Mon, 19 Jun 2023 08:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687164019;
        bh=UtjravUBCN3o1U68Iy/Hasvwofkbayx1QqElmRLNbLo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ksgRvdgkbOYVLhm0Mg4tjNiOiG6jqlM0r3VI2AY6TUGc5pWk8+XU5K+/wBAQhSvrU
         QLWWtZeKjGcBu3F3e4+x130eDB7Ev/n3tiYsnO6h8v+BkLAA2bSU6pF/a62qOtWruv
         XclF3HrFZxnTYDpxhsmktGohjlJp+IT/uiNMYCpv3KWYn0770cnimUsiEOF9PNguCt
         8ZzeZ2iUpahXkkRUbXjPUqlQB5xMZloAqDtg4GleSvy+TqwajhVWvvqrg540Y5SWzp
         wY5XZ4eRUFVhFNzXeL6eiK0/DBQVAN/26bdlyqoCmOSgQ4xi8UhWpSY+M/c3idCrIg
         LTGIPlj9bFwBQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 42789C4316B;
        Mon, 19 Jun 2023 08:40:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V2 net] net: qca_spi: Avoid high load if QCA7000 is not
 available
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168716401926.31468.11826494564143832409.git-patchwork-notify@kernel.org>
Date:   Mon, 19 Jun 2023 08:40:19 +0000
References: <20230614210656.6264-1-stefan.wahren@i2se.com>
In-Reply-To: <20230614210656.6264-1-stefan.wahren@i2se.com>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, stefan.wahren@chargebyte.com,
        simon.horman@corigine.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 14 Jun 2023 23:06:56 +0200 you wrote:
> In case the QCA7000 is not available via SPI (e.g. in reset),
> the driver will cause a high load. The reason for this is
> that the synchronization is never finished and schedule()
> is never called. Since the synchronization is not timing
> critical, it's safe to drop this from the scheduling condition.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> Fixes: 291ab06ecf67 ("net: qualcomm: new Ethernet over SPI driver for QCA7000")
> 
> [...]

Here is the summary with links:
  - [V2,net] net: qca_spi: Avoid high load if QCA7000 is not available
    https://git.kernel.org/netdev/net/c/92717c2356cb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


