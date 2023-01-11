Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA626663A8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 20:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239235AbjAKTVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 14:21:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237663AbjAKTUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 14:20:23 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D38C18685
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 11:20:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 224B1CE1C10
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 19:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2BE30C43396;
        Wed, 11 Jan 2023 19:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673464818;
        bh=kBFX7cJSGWf8rvuA9hm0aSTDFC40wCoDg+Fnj9OcTOg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=X1oKLEPPwLgRkJTW3WiC++39n6Y1IEJzlkCI30ErDWxQF+BK3PYx4GmLauYyYfZmh
         vzPUZG0aTLC+X/hllJ+OSJLKUrzdkwLvBYPS3nkYI+V/KD5plab4SGsia1xZOSL/DS
         98wN0ffrlTEU6s4E84WQ+FETKlNskt6xjQUuX/KQzSJJpwUDWf/lR5ZFAMpe+YzdAa
         tGbYPolu+ZxmOq1oxqqNLmELFJS6qudQNE0jkRdxT4uVbgthlPhhNj6xObMBFLY+z5
         MuAcnjfyQVs1+1bMpbcq7DdmQB0Knxd26XM2ylZHqyXGS1NYRfxCQf3s7Gje0Ldlny
         2Zolx4rLicxjA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E7FDCE524CB;
        Wed, 11 Jan 2023 19:20:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: remove unnecessary blank lines
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <167346481794.5008.4557923376515038206.git-patchwork-notify@kernel.org>
Date:   Wed, 11 Jan 2023 19:20:17 +0000
References: <20221221192634.18068-1-frank.li@vivo.com>
In-Reply-To: <20221221192634.18068-1-frank.li@vivo.com>
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

On Thu, 22 Dec 2022 03:26:34 +0800 you wrote:
> Just cleanup.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  fs/f2fs/f2fs.h | 2 --
>  1 file changed, 2 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: remove unnecessary blank lines
    https://git.kernel.org/jaegeuk/f2fs/c/390d0b99212e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


