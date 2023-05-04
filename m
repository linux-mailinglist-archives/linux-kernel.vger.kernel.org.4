Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3517C6F7772
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 22:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjEDUuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 16:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjEDUun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 16:50:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D43CAD38
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 13:50:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0CCED639F6
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 20:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 64990C4339B;
        Thu,  4 May 2023 20:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683233420;
        bh=4U+MQWXPhAFShSzpQ9wcZo3T2ye1/JC3B6/TNh/iYDI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=mdTuJg32CupgYMIEN8AcUZilymmSCsqwN+p4U3vKcf3ZsOKUDp9oNb4T1rzawaej/
         v/ywJ7+/tiF3JjF+KWaPz9ukI0rI6WItEa19JE5j2Cy25TnDEW0prK5QDVokZS5jp0
         +E9BQ672OYO7+XXe6+1M9cDBgd11PjcN3jnQR7v+5cYgo1k/YaUgPmfdhLcd3CK52N
         VqH+q5r9oTBJww2WRF4iaiJEZuXTPp/iZpj5SM3FxWKfsIpzI+W18mUT1end0emGNq
         HtSS0bLe0Wr8yypEspaiPEz3fqpUSfYAdZ7TFBGrzK8mC6miY5HgG5LdAFIMSTxsG0
         yqN1xif2dosjA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4AFF5C41677;
        Thu,  4 May 2023 20:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] 9p: Remove INET dependency
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168323342030.20811.7559124935659386918.git-patchwork-notify@kernel.org>
Date:   Thu, 04 May 2023 20:50:20 +0000
References: <20230504194725.546460-1-jandryuk@gmail.com>
In-Reply-To: <20230504194725.546460-1-jandryuk@gmail.com>
To:     Jason Andryuk <jandryuk@gmail.com>
Cc:     ericvh@kernel.org, lucho@ionkov.net, asmadeus@codewreck.org,
        linux_oss@crudebyte.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, v9fs@lists.linux.dev,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu,  4 May 2023 15:47:23 -0400 you wrote:
> 9pfs can run over assorted transports, so it doesn't have an INET
> dependency.  Drop it and remove the includes of linux/inet.h.
> 
> NET_9P_FD/trans_fd.o builds without INET or UNIX and is usable over
> plain file descriptors.  However, tcp and unix functionality is still
> built and would generate runtime failures if used.  Add imply INET and
> UNIX to NET_9P_FD, so functionality is enabled by default but can still
> be explicitly disabled.
> 
> [...]

Here is the summary with links:
  - [v3] 9p: Remove INET dependency
    https://git.kernel.org/netdev/net-next/c/d7385ba13771

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


