Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2EF57497AE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 10:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjGFIuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 04:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjGFIuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 04:50:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510CA1BC2
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 01:50:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C73B618C7
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 08:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B12B9C433C9;
        Thu,  6 Jul 2023 08:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688633420;
        bh=aJfz8dDP5NttJwF1Z73B8R8tlOTOFk5spMoKt1M4TwY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=SApbaVJUIncHvm+QF2TKWS8NV2azsFAl+gsqQ6nUnd1fsna/aG/lBG89kdrqnNGpU
         oCCf31rvd5lydM+t3Zl4d64Gyp5TbReHCY0l6jDwsMxGlp42EBASnFabO9hIJBe63t
         /Zsuzo8LTliZEVLHToim/lA4Jv0RIX9TJjP30UFOPKh6tUQaRxjEBJYFo9y0FLAW1A
         oRY1Nhxn2KbIv6ufm404lt4hh/KOHjZnA/d3XuAI7v/m7doKHOBqHPcIeclrBZnWB+
         c2UCSbPErPfKmRB/M3ePK6OOL3HL7kZAltz6EssXAmkGKx31F5U8zH4XzSgBztHOet
         KPG2In2ImY7Ww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9C3C1C395C5;
        Thu,  6 Jul 2023 08:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: mvneta: fix txq_map in case of txq_number==1
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168863342063.1842.10746147881143228365.git-patchwork-notify@kernel.org>
Date:   Thu, 06 Jul 2023 08:50:20 +0000
References: <20230705053712.3914-1-klaus.kudielka@gmail.com>
In-Reply-To: <20230705053712.3914-1-klaus.kudielka@gmail.com>
To:     Klaus Kudielka <klaus.kudielka@gmail.com>
Cc:     thomas.petazzoni@bootlin.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        gregory.clement@bootlin.com, netdev@vger.kernel.org,
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
by Paolo Abeni <pabeni@redhat.com>:

On Wed,  5 Jul 2023 07:37:12 +0200 you wrote:
> If we boot with mvneta.txq_number=1, the txq_map is set incorrectly:
> MVNETA_CPU_TXQ_ACCESS(1) refers to TX queue 1, but only TX queue 0 is
> initialized. Fix this.
> 
> Fixes: 50bf8cb6fc9c ("net: mvneta: Configure XPS support")
> Signed-off-by: Klaus Kudielka <klaus.kudielka@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net] net: mvneta: fix txq_map in case of txq_number==1
    https://git.kernel.org/netdev/net/c/21327f81db63

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


