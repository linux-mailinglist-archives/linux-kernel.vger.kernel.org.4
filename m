Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2563A7379CF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 05:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjFUDkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 23:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjFUDkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 23:40:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6AC197;
        Tue, 20 Jun 2023 20:40:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D2C161468;
        Wed, 21 Jun 2023 03:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 88EB7C433B6;
        Wed, 21 Jun 2023 03:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687318822;
        bh=D8jvkOTPdmO0u5o55l9cr1Aye25QMAx0UYHTkGhgK08=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=llr3kw6qEFuHcHIllGiEPl2yFyAGiJ3KZJ9tkteZhuGDNAyG6Spc2RBp4KTATfblU
         ZB1Qcp/xu8B2b/m13U4At2RepuRZ8Br4EsWdURcJUvoquZ8XITy+pp0cufxXURbbpa
         D5//JacKlnU2B6Rb/byjzX9k8H+4LVReqruNY2FZ3wn87dAwnrSF005yqOkvp8bAT2
         29gGG7GAEZOJjc3b1RgsA380kbuxTyGAnXozOas98YJbANITKQExieRUIszZEmmgWl
         KNLV58Q79WGnTfq9zvyB42EcYaODat9iFagrEyakC4mlJH/z7kyzkzcH5o8AQKV79G
         S6UaA94++Uzaw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 48DF9E2A037;
        Wed, 21 Jun 2023 03:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] mptcp: Reorder fields in 'struct mptcp_pm_add_entry'
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168731882229.8371.954122790611949786.git-patchwork-notify@kernel.org>
Date:   Wed, 21 Jun 2023 03:40:22 +0000
References: <e47b71de54fd3e580544be56fc1bb2985c77b0f4.1687081558.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <e47b71de54fd3e580544be56fc1bb2985c77b0f4.1687081558.git.christophe.jaillet@wanadoo.fr>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     matthieu.baerts@tessares.net, martineau@kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, netdev@vger.kernel.org,
        mptcp@lists.linux.dev
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 18 Jun 2023 11:46:46 +0200 you wrote:
> Group some variables based on their sizes to reduce hole and avoid padding.
> On x86_64, this shrinks the size of 'struct mptcp_pm_add_entry'
> from 136 to 128 bytes.
> 
> It saves a few bytes of memory and is more cache-line friendly.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> [...]

Here is the summary with links:
  - [net-next] mptcp: Reorder fields in 'struct mptcp_pm_add_entry'
    https://git.kernel.org/netdev/net-next/c/92b08290859b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


