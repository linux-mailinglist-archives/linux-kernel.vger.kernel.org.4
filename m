Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8E970285E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 11:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239667AbjEOJXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 05:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240108AbjEOJWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 05:22:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133DE10DD
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 02:20:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 989616118F
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 09:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0141BC433A1;
        Mon, 15 May 2023 09:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684142420;
        bh=cATodRhDLjGpsuA3IEGB/NaCwb/rjK3ErbF4wotuN1o=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=DTmDrN0Y17Zd3akodaoprFKtjSKgLPVQ3LyyOdibDdfKf0tXrHcLoYAYr2nPQs9lU
         ABNzzhLWpBg1QNAjSKxFSMpjP1BMi5v/8l8R62XAznun0AkJwX39FkscgBfZuvRHuS
         tcEkypTBNU2EDwGnqYZPvZ6feJmw4GlZDj+wr7v/mA59PJGaA8ecfxUF170TnkpoIE
         4jHz8uvNXvPzjBvAUZHrP9jpoVGG6A63qOHhMLg1afvakvRKQSSrX14Y44aQV2ijNU
         aTjHV7kCLmZYqm8cHkzgz02WbXv8hEu0ai+70qfIsbz4pTLYyayNOJhcy6Dw50RHZe
         Tj0UZF9C2cTFA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E0577E5421B;
        Mon, 15 May 2023 09:20:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] net: ethernet: microchip: vcap: Remove extra
 semicolon
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168414241991.23347.11880156922233782597.git-patchwork-notify@kernel.org>
Date:   Mon, 15 May 2023 09:20:19 +0000
References: <ZF9vTsEU4u3dORz5@yoga>
In-Reply-To: <ZF9vTsEU4u3dORz5@yoga>
To:     Anup Sharma <anupnewsmail@gmail.com>
Cc:     horatiu.vultur@microchip.com, lars.povlsen@microchip.com,
        Steen.Hegelund@microchip.com, daniel.machon@microchip.com,
        UNGLinuxDriver@microchip.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
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

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat, 13 May 2023 16:36:54 +0530 you wrote:
> Remove the extra semicolon at end. Issue identified using
> semicolon.cocci Coccinelle semantic patch.
> 
> drivers/net/ethernet/microchip/vcap/vcap_api.c:1124:3-4: Unneeded semicolon
> drivers/net/ethernet/microchip/vcap/vcap_api.c:1165:3-4: Unneeded semicolon
> drivers/net/ethernet/microchip/vcap/vcap_api.c:1239:3-4: Unneeded semicolon
> drivers/net/ethernet/microchip/vcap/vcap_api.c:1287:3-4: Unneeded semicolon
> 
> [...]

Here is the summary with links:
  - [v2,net-next] net: ethernet: microchip: vcap: Remove extra semicolon
    https://git.kernel.org/netdev/net-next/c/c515a4443cb8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


