Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B047574019D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 18:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbjF0Qu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 12:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbjF0QuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 12:50:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A2E186
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 09:50:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66ACF611EB
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 16:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BE9D4C433C9;
        Tue, 27 Jun 2023 16:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687884620;
        bh=DcBFHXhRAWFmRLSZK2RajKpsfjr2KTMlxNIK0yzVQZM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=IiZxg11iz2NXInO20/34IniSrFfhWL7Pw2bbjGU6m4lq8d28RXgUICpWOTt+mXruH
         TTl3hkS2f9K4aa0ijDhZ7HusVR1xwBW4/Ocwk+BoW+b/QW5XJgod/0AGppGATjTEMK
         /YvceUb7XjrojDkfcOFpPCjKeJvXOdd16DXab4+XEWy6dLijHt+qRg2yFZt+tM4w6f
         U69nxVoAMvWxaMyaAKjd8TfwQ9WMopdSfXDSsAPsRobr69fJtsmQ51q4KzPxJP0GfP
         HOwZIS3ef9+7d+QCqWtxe9zIkrVFDuv9Zj5Kr/AnMgtpm4BhXbgcwlE4949R5rws0M
         Cltegzdq2cPPw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A08EAE53800;
        Tue, 27 Jun 2023 16:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: dsa: avoid suspicious RCU usage for synced
 VLAN-aware MAC addresses
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168788462065.27533.11355169093087204068.git-patchwork-notify@kernel.org>
Date:   Tue, 27 Jun 2023 16:50:20 +0000
References: <20230626154402.3154454-1-vladimir.oltean@nxp.com>
In-Reply-To: <20230626154402.3154454-1-vladimir.oltean@nxp.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     netdev@vger.kernel.org, andrew@lunn.ch, f.fainelli@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, simon.horman@corigine.com,
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
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 26 Jun 2023 18:44:02 +0300 you wrote:
> When using the felix driver (the only one which supports UC filtering
> and MC filtering) as a DSA master for a random other DSA switch, one can
> see the following stack trace when the downstream switch ports join a
> VLAN-aware bridge:
> 
> =============================
> WARNING: suspicious RCU usage
> 
> [...]

Here is the summary with links:
  - [net] net: dsa: avoid suspicious RCU usage for synced VLAN-aware MAC addresses
    https://git.kernel.org/netdev/net/c/d06f925f1397

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


