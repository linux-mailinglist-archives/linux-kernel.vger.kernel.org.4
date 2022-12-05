Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6BD6422E8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 07:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbiLEGKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 01:10:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbiLEGKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 01:10:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9FDBC83
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 22:10:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4372EB80D68
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 06:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 02211C433C1;
        Mon,  5 Dec 2022 06:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670220616;
        bh=MCSkWHh5w1t9QGfMv6URi+brUeo2tZ38HYmvocG5Rrc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=jkrLkfCYUiHwJa3ASut8ZZmCAgEBbybFtXCmuplt3Y7Ib1ef7tpn5cAKrfGpSzjpw
         VAYOedPWnUkmDPFNf8pLxjdmPKqIapExbUIIKdv4niohCWZr46DRCqfkGbsyIFAW0v
         KWpYVnAgy1xqZ+csVkd09cC7hsUVGrpbn2MBL3iUE8AjOgzJPFE4+o6UX5QeTCFSsD
         BaKjK9wkae82QfIA3AfhxP1Pz9skO2tBEUfrA3QrXecLIoKLPMCcbV+vqMgtIoQQkp
         mA4evRWznGhmaaT2TqMQLXt+EwGL/ZCW2IKmTwVnxxcICYE1xGNRYrKs02frKzVFHW
         x+1A5TOuqHHlw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D07DAC395EA;
        Mon,  5 Dec 2022 06:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: =?utf-8?q?=5BPATCH=5D_platform/chrome=3A_use_sysfs=5Femit=28=29_to_?=
        =?utf-8?q?instead_of_scnprintf=28=29?=
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <167022061584.5741.17401847079295640907.git-patchwork-notify@kernel.org>
Date:   Mon, 05 Dec 2022 06:10:15 +0000
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

This patch was applied to chrome-platform/linux.git (for-kernelci)
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


