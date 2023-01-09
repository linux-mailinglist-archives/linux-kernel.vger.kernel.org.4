Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F2F661E77
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 06:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235999AbjAIFaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 00:30:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234205AbjAIFaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 00:30:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278862C6
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 21:30:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A1E21B80CB6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 05:30:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4331FC433F0;
        Mon,  9 Jan 2023 05:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673242216;
        bh=E75lcGz7LkVv7ZTlmKv/+QUdYCQj+x1JMimW1iTMQ+Q=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Ox6gmlFLjqZbCLGjHD9H3xqQhQjqhKHpOV8rSyRv3RFIag5sX7fmptesBY8rSpxNH
         Xs/yXKncl4VAcNooxCdV8toCMSLQ3bZn8pD7jntrRJtch+ODfYFIE7HbqGOC6KuAoN
         /L6UN04ScHnP/WXHSWTWXNfOhMMzRyjys25C4S7pgQq7JKY8EgFaehyGwLRq9jpvnZ
         wBbtWgWpM/8iLqVEfVdJS26ttjvudQZokldprKZvc4vVIJlq5iL3AW7Df5mkWjF+9N
         5vktKtQ3jtu43CRRW088+rNVcquNLYFYHL43Fp/1LkeXccnxt5BcFAP/MBwB2G/MWb
         Q+gJfhKQ0jMfw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 32ABCE21EE9;
        Mon,  9 Jan 2023 05:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/2] Handle CrOS EC Panics
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <167324221620.8677.14256406572957344179.git-patchwork-notify@kernel.org>
Date:   Mon, 09 Jan 2023 05:30:16 +0000
References: <20230104011524.369764-1-robbarnes@google.com>
In-Reply-To: <20230104011524.369764-1-robbarnes@google.com>
To:     Rob Barnes <robbarnes@google.com>
Cc:     groeck@chromium.org, pmalani@chromium.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        dtor@chromium.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to chrome-platform/linux.git (for-next)
by Tzung-Bi Shih <tzungbi@kernel.org>:

On Wed,  4 Jan 2023 01:15:22 +0000 you wrote:
> Currently the OS ignores EC panics when they occur.
> After reporting a panic, the EC will force a hard reset,
> possibly after a short delay. This may cause loss of data.
> 
> These patches add a handler for CrOS EC panics. When
> a panic is detected the OS will attempt to flush critical
> data for debugging purposes and attempt an orderly shutdown.
> 
> [...]

Here is the summary with links:
  - [v3,1/2] platform/chrome: cros_ec: Poll EC log on EC panic
    https://git.kernel.org/chrome-platform/c/d90fa2c64d59
  - [v3,2/2] platform/chrome: cros_ec: Shutdown on EC Panic
    https://git.kernel.org/chrome-platform/c/957445d730ba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


