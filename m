Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31416424DA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 09:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbiLEIkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 03:40:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbiLEIkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 03:40:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11719DF43
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 00:40:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C131BB80BA7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 08:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5F844C433D7;
        Mon,  5 Dec 2022 08:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670229616;
        bh=Py7U0J9lhyhMmERlESNqJ/l87ZCQ8dpAgBdNRMRcqGM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=PJyocrVDKyVYKt9w4LONlrFDWTeUDGTNJgovQ9yzyF/WWKk2MO0fLjXYOFEuv7kaU
         ZauGeRi5g4r1tIZV6+V0UTzYnbhS/xSiJVbeXK6OyJgJlWdMMTgMaZ8gzI/gNNpPeO
         WL/bg2cp4Z7XYZlghgpixWfySue5GUu99J/pG2GN0ckRXCaITVXFk0wFxC4pyFt0YM
         ew6qHJ+FODJtpGWUriVpqwLjZ4v2zSdloXtQb4JuN6hX9umIS9wkRPArpDb4ynDIHO
         tKO07OVeHJxt94CpsLA/Lh/dM9KXcgt7P81FNz02ytlGSFzlb6V7DpAoU12P9wwx6N
         nRuiQsXJMyVgg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2EFF9C5C7C6;
        Mon,  5 Dec 2022 08:40:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: =?utf-8?q?=5BPATCH=5D_platform/chrome=3A_use_sysfs=5Femit=28=29_to_?=
        =?utf-8?q?instead_of_scnprintf=28=29?=
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <167022961618.18204.6417258868175494719.git-patchwork-notify@kernel.org>
Date:   Mon, 05 Dec 2022 08:40:16 +0000
References: <202212021656040995199@zte.com.cn>
In-Reply-To: <202212021656040995199@zte.com.cn>
To:     <ye.xingchen@zte.com.cn>
Cc:     bleung@chromium.org, groeck@chromium.org,
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

On Fri, 2 Dec 2022 16:56:04 +0800 (CST) you wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Follow the advice of the Documentation/filesystems/sysfs.rst and show()
> should only use sysfs_emit() or sysfs_emit_at() when formatting the
> value to be returned to user space.
> 
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> 
> [...]

Here is the summary with links:
  - platform/chrome: use sysfs_emit() to instead of scnprintf()
    https://git.kernel.org/chrome-platform/c/7af6ee18ad6e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


