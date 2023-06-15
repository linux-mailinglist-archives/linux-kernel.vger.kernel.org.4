Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD1E732281
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 00:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238819AbjFOWKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 18:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbjFOWKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 18:10:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BCA2688
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 15:10:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0122D6248C
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 22:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 56FE3C43391;
        Thu, 15 Jun 2023 22:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686867021;
        bh=PvDVB/s3EYPnFpmPS9hYT5dQN4Ri0f5Z0pnM2zA+VP8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=MFbYa0FBEeGECayN1plDNj1lAef0yDQu8if4g9haK9ewoi/d/74KLnAx0lnv/hUiU
         G+hL0SUH+FfFxhio6bHu8NOrYDI23DCuWXBHO7SR16Kj3XPknD3PaxqVpBZFRO2bQz
         LZ60e4NpFsTi8nlNL75Tyr0mHzEtITSt92FyD1e2ci63cbq+6F+P1Dl+4gEQl/4yei
         BMFJ/N3QvqrS2XZ+N+juySIfH+jId3DUQBJxZ4r1cso9lYpnglPulc5DOtvk0CrWx6
         RbeqZnoTLWoad0Yvxn2eHmD7PM/LVXtHKdOpyB8twpk6u+Rv4uGXXERF45RXhxbdw1
         +yPx7w3ELz4fw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 33F2EE270FB;
        Thu, 15 Jun 2023 22:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] octeon_ep: Add missing check for ioremap
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168686702120.9701.16100974127550672864.git-patchwork-notify@kernel.org>
Date:   Thu, 15 Jun 2023 22:10:21 +0000
References: <20230615033400.2971-1-jiasheng@iscas.ac.cn>
In-Reply-To: <20230615033400.2971-1-jiasheng@iscas.ac.cn>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     kuba@kernel.org, vburru@marvell.com, aayarekar@marvell.com,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        sburla@marvell.com, netdev@vger.kernel.org,
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

On Thu, 15 Jun 2023 11:34:00 +0800 you wrote:
> Add check for ioremap() and return the error if it fails in order to
> guarantee the success of ioremap().
> 
> Fixes: 862cd659a6fb ("octeon_ep: Add driver framework and device initialization")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
> Changelog:
> 
> [...]

Here is the summary with links:
  - [v2] octeon_ep: Add missing check for ioremap
    https://git.kernel.org/netdev/net/c/9a36e2d44d12

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


