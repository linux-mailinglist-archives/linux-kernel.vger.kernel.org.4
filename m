Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17CCA6663AA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 20:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238603AbjAKTUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 14:20:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234822AbjAKTUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 14:20:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B83175BF
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 11:20:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C26861D10
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 19:20:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 01B28C433F2;
        Wed, 11 Jan 2023 19:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673464818;
        bh=52urJWoz0blI4bnQ+w3PNpauD8QBF38h3Q2tnnT+iTQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=rUnhfTub9goIwjO4RLaQaPVLBC+/Is8NWoPXtun5PVwSVVuRuzoCDPV1e9+HpOe6g
         TJckIi/o3djadXioCVaW+AWK7Q5GFGdp6cckC5e9BKoXnpAYHImJlddRWTGWqSGy0p
         ZM/bWx1gmViM2sWGxbQOLrWaMeBibJSk9wgjKAeJTC9Pjld98eV2Kg1pcEPR2Jz7H1
         oTnUxfhgob0+jESUgsgIme+aWBmWIX7/OubkZ+48mjD0lvJg5uVGukVIUKH4Lzm6cV
         Sdd6HvtjUYwQC+1ptX9T1vCPkgfAQndRX2si0jQbGjG6hdzl2FIxfuzKQrO2bouq70
         Z9nBjRz9w9sOQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CDFF4E270F6;
        Wed, 11 Jan 2023 19:20:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: merge f2fs_show_injection_info() into
 time_to_inject()
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <167346481783.5008.9895955069686531878.git-patchwork-notify@kernel.org>
Date:   Wed, 11 Jan 2023 19:20:17 +0000
References: <20221220183904.53908-1-frank.li@vivo.com>
In-Reply-To: <20221220183904.53908-1-frank.li@vivo.com>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     jaegeuk@kernel.org, chao@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 21 Dec 2022 02:39:04 +0800 you wrote:
> There is no need to additionally use f2fs_show_injection_info()
> to output information. Concatenate time_to_inject() and
> __time_to_inject() via a macro. In the new __time_to_inject()
> function, pass in the caller function name and parent function.
> 
> In this way, we no longer need the f2fs_show_injection_info() function,
> and let's remove it.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v3] f2fs: merge f2fs_show_injection_info() into time_to_inject()
    https://git.kernel.org/jaegeuk/f2fs/c/c40e15a9a59f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


