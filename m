Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F05D71F980
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 07:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233423AbjFBFAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 01:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjFBFAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 01:00:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1360F107;
        Thu,  1 Jun 2023 22:00:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B1FC64C43;
        Fri,  2 Jun 2023 05:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B2A17C4339B;
        Fri,  2 Jun 2023 05:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685682020;
        bh=rUHmOXEYpK/oNBqcnTdtouxfSre1j04IJR96syYNKDw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Vsbzlpgdftk8smVI3yWSPQcDhM00q0Fb6ZUHq53dFVgfRBZfrtlRAQFga4wIJoVFd
         GeC7zQlHYpS8h6SGynQSJBGdqsb2iHAQuzIUp7dPdAdfgQL2wFZ37BameN0mY9xKQx
         SvsV7KQYO/qPAITjmG7L2DQq3LeJzN51/OUSpwWviRWlb1AG6ABkiRLHI7KrVf6oxP
         i/41ZPo/EGc9lN2MZ3z1/knMQA6htsN30dEdUqpMXKMWpNjFZKgXKdWMNn4vb9g9nA
         CXO1BgH82XuZyHRHRYnz4SbduC6VHUAqOWvEXk5qPVnjhFyLR2C7mo78nJzqBpampD
         x7KOVAuihf5sg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 979BDE29F3F;
        Fri,  2 Jun 2023 05:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/2] Extend dt-bindings for PSE-PD controllers and update
 prtt1c dts
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168568202061.24823.10947582942293943932.git-patchwork-notify@kernel.org>
Date:   Fri, 02 Jun 2023 05:00:20 +0000
References: <20230531102113.3353065-1-o.rempel@pengutronix.de>
In-Reply-To: <20230531102113.3353065-1-o.rempel@pengutronix.de>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        robh+dt@kernel.org, krzk+dt@kernel.org, jerome.pouiller@silabs.com,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org
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

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 31 May 2023 12:21:11 +0200 you wrote:
> changes v3:
> - reword commit message for the pse-controller.yaml patch
> - drop podl-pse-regulator.yaml patch
> 
> changes v2:
> - extend ethernet-pse regexp in the PoDL PSE dt-bindings
> 
> [...]

Here is the summary with links:
  - [v3,1/2] dt-bindings: net: pse-pd: Allow -N suffix for ethernet-pse node names
    https://git.kernel.org/netdev/net-next/c/bd415f6c748e
  - [v3,2/2] ARM: dts: stm32: prtt1c: Add PoDL PSE regulator nodes
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


