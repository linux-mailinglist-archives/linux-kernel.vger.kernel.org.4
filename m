Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB1F73937A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 02:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjFVAC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 20:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbjFVAC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 20:02:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99639210B
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 17:01:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 190846171C
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 00:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 71213C43397;
        Thu, 22 Jun 2023 00:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687392021;
        bh=yZrAdNwWtgDHw+tFjhrL08lNU2dXLHjvwtacUaya9RU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=XaGA+rX0xFfkBjXhDg1XDP7zY9fccj60A4XOBgig50x4W4atPQr/oSj9RuNSjAYUl
         UaH7cn6hHSWcmxhMlM36unc6qhuiv7TJzIwVBjs3OOn5G82ubjgMU9I+LOet+xAxOb
         G8NwxsNRplf0f0gYWy239Vu94sUMvXm39vCWTLhzBNIFc586AbNRz1MfIBzNZg8FUF
         j86Tnc+u63ooZ8e4lWiqSrIVu/M282TdMk56wVYDDTYUFsh7/dLg/iobJKBN2hDOz5
         ExDPIcpJXdQGIePYXE8i6Q+Wx2hgijEVQ4ipVoJENJgN19mRwrzaZDKgdaKdxCnk2Z
         CsJQqC4sDyJKw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4DF90E4D027;
        Thu, 22 Jun 2023 00:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] net: hsr: Disable promiscuous mode in offload
 mode
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168739202131.22621.267223043566352469.git-patchwork-notify@kernel.org>
Date:   Thu, 22 Jun 2023 00:00:21 +0000
References: <20230614114710.31400-1-r-gunasekaran@ti.com>
In-Reply-To: <20230614114710.31400-1-r-gunasekaran@ti.com>
To:     Ravi Gunasekaran <r-gunasekaran@ti.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, bigeasy@linutronix.de,
        simon.horman@corigine.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, rogerq@kernel.org
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

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 14 Jun 2023 17:17:10 +0530 you wrote:
> When port-to-port forwarding for interfaces in HSR node is enabled,
> disable promiscuous mode since L2 frame forward happens at the
> offloaded hardware.
> 
> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> Reviewed-by: Simon Horman <simon.horman@corigine.com>
> 
> [...]

Here is the summary with links:
  - [v2,net-next] net: hsr: Disable promiscuous mode in offload mode
    https://git.kernel.org/netdev/net-next/c/e748d0fd66ab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


