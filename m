Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E37739379
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 02:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjFVACP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 20:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjFVACM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 20:02:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1995212C;
        Wed, 21 Jun 2023 17:01:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E35E561703;
        Thu, 22 Jun 2023 00:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4A0A0C433C8;
        Thu, 22 Jun 2023 00:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687392021;
        bh=/uMLt2E1rz9exuqGr5hQn1iG0P4+0/KdRlRethHTB4w=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=IBB0vPirVqsC388SKFlL7nZP43HWMnizxH2Ko6+kaOyVC3+yLciavVzzheGiENssf
         E9BoMWlS/s3hk9VG3JyGRCQn7jW0Dnm8gxVY0IUIXCsZ1Z2iSxLwpFeYrde8DwdXlz
         CMP7datQeInUbXiCxNMwy+fjcJDApODgKstKXjXcPXmICcg5v+qzo046rmFfBbJvCB
         9HbkRlmzgF9Im7TxGV2N6KVKbbisHzYB3gMMxJK9kKR7fFKFw5uefdHSWFfMOuUkXE
         hMZROMUOlBwST3MhiqEmx3sJQMxTvskf20I5CtcBlC96SYpgMNtpuw6ucR4GmF0Jy7
         i3P6GqJah0rbw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 29973E2A044;
        Thu, 22 Jun 2023 00:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] dt-bindings: net: micrel,ks8851: allow SPI device
 properties
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168739202116.22621.14381446710922927523.git-patchwork-notify@kernel.org>
Date:   Thu, 22 Jun 2023 00:00:21 +0000
References: <20230619170134.65395-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230619170134.65395-1-krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        marex@denx.de, netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Mon, 19 Jun 2023 19:01:34 +0200 you wrote:
> The Micrel KS8851 can be attached to SPI or parallel bus and the
> difference is expressed in compatibles.  Allow common SPI properties
> when this is a SPI variant and narrow the parallel memory bus properties
> to the second case.
> 
> This fixes dtbs_check warning:
> 
> [...]

Here is the summary with links:
  - [net-next] dt-bindings: net: micrel,ks8851: allow SPI device properties
    https://git.kernel.org/netdev/net-next/c/1ca09f5746ed

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


