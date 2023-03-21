Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7C86C371C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 17:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjCUQka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 12:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjCUQkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 12:40:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB44E46B6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 09:40:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 56805B818E5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 16:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0DD41C433A4;
        Tue, 21 Mar 2023 16:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679416819;
        bh=/7au02i0+mo0Z5j2lMsIaSmHsivtpsY3DMU+Mi3Kk0M=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=b2SdIUkbCT6NMLevpCGgl69bjSszOWNbnX8XTP982A1R8QqlyUQ8qAWOQUWx9mwFG
         TaqRLoKJp5kUrRZSgnSrGumCdekk1yb/TdespC/m4PgeoXEC7yjtWh+4gtlwiajE9W
         Y7s2AZXI5MXG+oO9+jhqg15VjbsQoSJamxKMU5AiNb9F/ZxvGrM6C6wcT0NV2+sPbp
         vSZ/0/uW/2BCTQomW9A3nhqiglKH++cg/iXdMcq8LmonUDDK/R7uhdz54bZvCrt72S
         1qrjuab0EbA9uvKTIF5aXJU1QHt9WFylTwgxeEClKtNyLWtUTLQ0l76W3yrjmxtTL2
         Hcn2jMVrYZkUg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D989FE66C9D;
        Tue, 21 Mar 2023 16:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to handle filemap_fdatawrite() error
 in f2fs_ioc_decompress_file/f2fs_ioc_compress_file
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <167941681888.25004.14878736903526507777.git-patchwork-notify@kernel.org>
Date:   Tue, 21 Mar 2023 16:40:18 +0000
References: <20230302095509.53720-1-frank.li@vivo.com>
In-Reply-To: <20230302095509.53720-1-frank.li@vivo.com>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     jaegeuk@kernel.org, chao@kernel.org, linux-kernel@vger.kernel.org,
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

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu,  2 Mar 2023 17:55:09 +0800 you wrote:
> It seems inappropriate that the current logic does not handle
> filemap_fdatawrite() errors, so let's fix it.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  fs/f2fs/file.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to handle filemap_fdatawrite() error in f2fs_ioc_decompress_file/f2fs_ioc_compress_file
    https://git.kernel.org/jaegeuk/f2fs/c/d15180a8d1d7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


