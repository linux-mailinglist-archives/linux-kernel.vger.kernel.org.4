Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65A1603A82
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 09:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiJSHUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 03:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiJSHUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 03:20:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF89C4D4F6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 00:20:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4BE3AB82266
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 07:20:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0D9BDC433D6;
        Wed, 19 Oct 2022 07:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666164017;
        bh=qZJGPYJhWSg9HQuKthn3430obiGHVRfi2d0cY0Qdp4M=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=b/qQBS2x3i6Xq3yycOaBcncVHeEIHKz5ZQg1RPwffX4qTmGT5VMMeTlLWOHWf0Gry
         kR0EDfwqBhyyE7qmX67UGeSYeg6b5tPvU1UdvXSNfdLuMOeFF4hLBCW9RTP2ChoIgL
         AY/7C8s4GMN/igad4Y5iP7j305A8+1oD0DsjvAi3WeVOvLORm5vd3ynOyaX3JcMxT+
         ljHRZIWxVUs0TobfPU0o0DSM97FYyLhXxfQyegh/Wt8B/KrJzhvULCBbwvpKdGRxTJ
         DppyOE8h7ZIXhaQlEVLNRYArZd1qvL+diF0yGu3gbyzuhqTJR5HThP4SLWCiuwq3Q7
         9zayvd/ypnGxw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E5F8BE270EA;
        Wed, 19 Oct 2022 07:20:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] platform/chrome: cros_hps_i2c: make remove callback return
 void
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <166616401693.8747.4313124084194924915.git-patchwork-notify@kernel.org>
Date:   Wed, 19 Oct 2022 07:20:16 +0000
References: <20221018235237.2274969-1-dcallagh@chromium.org>
In-Reply-To: <20221018235237.2274969-1-dcallagh@chromium.org>
To:     Dan Callaghan <dcallagh@chromium.org>
Cc:     chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        skyostil@chromium.org, bleung@chromium.org, tzungbi@kernel.org,
        lkp@intel.com
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Wed, 19 Oct 2022 10:52:37 +1100 you wrote:
> Commit ed5c2f5fd10d ("i2c: Make remove callback return void") changed
> the return type of the 'remove' callback to void, but this driver was
> originally written before that change landed. Update the remove callback
> to match.
> 
> Fixes: 5f9952548d91 ("platform/chrome: add a driver for HPS")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Dan Callaghan <dcallagh@chromium.org>
> 
> [...]

Here is the summary with links:
  - platform/chrome: cros_hps_i2c: make remove callback return void
    https://git.kernel.org/chrome-platform/c/d8cb88f1541f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


