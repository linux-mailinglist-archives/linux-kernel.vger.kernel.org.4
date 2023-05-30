Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575057171E3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 01:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233963AbjE3Xkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 19:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233937AbjE3Xkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 19:40:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78ACB18F;
        Tue, 30 May 2023 16:40:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D47B463544;
        Tue, 30 May 2023 23:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2E7D5C4339E;
        Tue, 30 May 2023 23:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685490024;
        bh=93IH1PJyULP9H9CKkenkkwO9S03yefaslN8oe+MaLpU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=E4BXP1JocNsvJNxCns1JewTFpD978vXapuTcGmiDGO2Zn6GZdbrZRKM9IdKFWaQ2R
         JiT7c9FdrMZvA0K0Xq182r284IX9/Z1Abp/iyhzvXqHpqlSbpXb+JDWF72baj2MyD/
         Fr6FHawDFPFYRrqPzrQVD0n3uOuVKKFrQkdBRDrMExmGU4rRraMjVv0h3/zjm9HynU
         BjNaSvzCeTjCSq3fZ+Axra7izOLxYd/Okq40gydDQOb/YS7F6jSWey3V6UYiLqFoCC
         mbNPdM56bUNTI6xSURugIsqofhluRLWGfgFrG+18v4uG+t1lskmvzHOqAQbWlgnmzW
         3QhuCEag7t0Gw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 11E2DE52BF5;
        Tue, 30 May 2023 23:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v6] f2fs: add async reset zone command support
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168549002406.8773.17572147089084947715.git-patchwork-notify@kernel.org>
Date:   Tue, 30 May 2023 23:40:24 +0000
References: <20230508081042epcms2p8a637deae7de1829f54614e09d5fde5e5@epcms2p8>
In-Reply-To: <20230508081042epcms2p8a637deae7de1829f54614e09d5fde5e5@epcms2p8>
To:     Daejun Park <daejun7.park@samsung.com>
Cc:     jaegeuk@kernel.org, chao@kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        sukka.kim@samsung.com, beomsu7.kim@samsung.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 08 May 2023 17:10:42 +0900 you wrote:
> v5 -> v6
> Added trace_f2fs_iostat support for zone reset command.
> 
> v4 -> v5
> Added f2fs iostat for zone reset command.
> 
> v3 -> v4
> Fixed build error caused by unused function.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v6] f2fs: add async reset zone command support
    https://git.kernel.org/jaegeuk/f2fs/c/7aa6ef440cd7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


