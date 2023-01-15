Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B35C66B114
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 13:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbjAOMuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 07:50:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbjAOMuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 07:50:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA21F762
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 04:50:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EE2D0B80B59
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 12:50:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8EF6FC433F1;
        Sun, 15 Jan 2023 12:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673787016;
        bh=oQPjHzPeXEjsOkF6tDs2VQsOgln3FQJ79HKCqEmaDoI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=TlQflLoygYr6Ej8d7htAarcWmDH8WI14donDzSoENVHz8PVOmab8l3lGveUNEbLSK
         lwxZNkrxFQmmCfOBbLF8MWrhE7/manrM7yn+dUHo9WTDBGyafamg00fJkp7QEXbnCN
         1V8fr0Safhm6QdX9y791T5vHCteN7inU6NRzEju7HSZ8Z3Aw+SCTB79SnGULIxKVo/
         G6TTXB8AH+dQpscpI2txfPwwU6Tv4tVqs61slzXkBhiB/38SMMWy8fIs4BLLjRtw8N
         BXcdYVBqsJY9ThhOCeHOlIdG53CANo1PJlbUrvPQW4D6IZxQDCzEPtPjOHTlcpyyfR
         kxv+0Rnv7f+Ug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 71451E451BC;
        Sun, 15 Jan 2023 12:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] platform/chrome: cros_ec: Use per-device lockdep key
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <167378701646.8704.18327455670891800657.git-patchwork-notify@kernel.org>
Date:   Sun, 15 Jan 2023 12:50:16 +0000
References: <20230111074146.2624496-1-wenst@chromium.org>
In-Reply-To: <20230111074146.2624496-1-wenst@chromium.org>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     bleung@chromium.org, groeck@chromium.org, tzungbi@kernel.org,
        angelogioacchino.delregno@collabora.com,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to chrome-platform/linux.git (for-next)
by Tzung-Bi Shih <tzungbi@kernel.org>:

On Wed, 11 Jan 2023 15:41:46 +0800 you wrote:
> Lockdep reports a bogus possible deadlock on MT8192 Chromebooks due to
> the following lock sequences:
> 
> 1. lock(i2c_register_adapter) [1]; lock(&ec_dev->lock)
> 2. lock(&ec_dev->lock); lock(prepare_lock);
> 
> The actual dependency chains are much longer. The shortened version
> looks somewhat like:
> 
> [...]

Here is the summary with links:
  - [v2] platform/chrome: cros_ec: Use per-device lockdep key
    https://git.kernel.org/chrome-platform/c/961a325becd9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


