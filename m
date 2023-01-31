Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF8E68361D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 20:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbjAaTK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 14:10:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjAaTKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 14:10:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC074609B
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 11:10:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89080616D2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 19:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 62616C433A8;
        Tue, 31 Jan 2023 19:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675192220;
        bh=9C5PDr6OI020i8CExGuBr9TUCXMNsJnEct3Kfz+VhCI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=XhKx4Y8n/ghpCiZc5qHN1WazEY/Rbpmf7bDCBffHhjPhfr37O2XlxHP8ZipHR+aG1
         J+t1jQBesuTvIWWDbLv2zdBzanFEcWqP25xxr7J42+7wy8RFCwpqD+AXnKJtGVnOdF
         7HnRsfv2IrpH6eiTBD4lT34cd3FIVsy+hEiZNdxSnaL+UJg2lgOgPSOnyHKBDl0e3Q
         mn8a3Uw0p2xSApijr/DcQeCzE4liaET79+ij8TtT64qfn9kEMKL85mKzgK4Ua/osPz
         xJbEZkzpBuXA8VdpSK7BxWCJkq5Hge/SkcqRQ24yeo3pRulJTnJwpKA+Z7pq76UzLn
         Kq1sPCI8x3Hvw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 33EE2E50D6E;
        Tue, 31 Jan 2023 19:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v3 1/2] f2fs: fix to avoid potential memory
 corruption in __update_iostat_latency()
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <167519222020.20142.16236320006789243348.git-patchwork-notify@kernel.org>
Date:   Tue, 31 Jan 2023 19:10:20 +0000
References: <20230120161656.70308-1-frank.li@vivo.com>
In-Reply-To: <20230120161656.70308-1-frank.li@vivo.com>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     jaegeuk@kernel.org, chao@kernel.org, lkp@intel.com,
        error27@gmail.com, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Sat, 21 Jan 2023 00:16:55 +0800 you wrote:
> Add iotype sanity check to avoid potential memory corruption.
> This is to fix the compile error below:
> 
> fs/f2fs/iostat.c:231 __update_iostat_latency() error: buffer overflow
> 'io_lat->peak_lat[type]' 3 <= 3
> 
> vim +228 fs/f2fs/iostat.c
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v3,1/2] f2fs: fix to avoid potential memory corruption in __update_iostat_latency()
    https://git.kernel.org/jaegeuk/f2fs/c/dcbf2ae5504f
  - [f2fs-dev,v3,2/2] f2fs: use iostat_lat_type directly as a parameter in the iostat_update_and_unbind_ctx()
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


