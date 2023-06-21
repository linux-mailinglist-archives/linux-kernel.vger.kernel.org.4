Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC30D73914C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 23:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjFUVKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 17:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjFUVK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 17:10:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807961989
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 14:10:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15D34616DE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 21:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5E425C433AD;
        Wed, 21 Jun 2023 21:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687381826;
        bh=778aFxmB3Fo3K9ZEIoLiqcuiGipuiqZwdEhhMcFYmPw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=p66h6MsJxbZUiIox+BDhbQ3cgE6RnguZUarKVrkyWiYFmEqSzEWQw9YR9UT7RkicD
         Wm5/VqJLj2FHUcTCC4tQm+MWknMpugcV+cfC3oYBlS23T1bDlGDLlGc+WvG1X57YAH
         D3yvcimHcLjPqyc/bn7fjyC9ddo3XhO1z51Rg+r8WaitVmtXwlYrmXu/IgNXuZ7MdS
         CX8Pob9N3fKAHcHim8v62eNGjaJ+LXSepZAq1qMNXb3O8cAY0hu6liTGBMKm+6evOz
         Wg8VC45ek8YvnUPq8J1TTcBXqTwQFcwZBUiHa9GQdyh0LMCFgikDvM1OlTP5EwZ3ea
         uFiIaekR33TVA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0A64FC395F1;
        Wed, 21 Jun 2023 21:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] bnxt_en: Link representors to PCI device
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168738182603.695.15786386736224760669.git-patchwork-notify@kernel.org>
Date:   Wed, 21 Jun 2023 21:10:26 +0000
References: <20230620144855.288443-1-ivecera@redhat.com>
In-Reply-To: <20230620144855.288443-1-ivecera@redhat.com>
To:     Ivan Vecera <ivecera@redhat.com>
Cc:     netdev@vger.kernel.org, michael.chan@broadcom.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-kernel@vger.kernel.org
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

On Tue, 20 Jun 2023 16:48:55 +0200 you wrote:
> Link VF representors to parent PCI device to benefit from
> systemd defined naming scheme.
> 
> Without this change the representor is visible as ethN.
> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> 
> [...]

Here is the summary with links:
  - [net-next] bnxt_en: Link representors to PCI device
    https://git.kernel.org/netdev/net-next/c/7ad7b7023fcb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


