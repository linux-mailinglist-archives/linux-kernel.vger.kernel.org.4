Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED30C731F95
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 20:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjFOSA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 14:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjFOSAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 14:00:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC3F13E
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 11:00:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5A4162221
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 18:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 11EDDC433C8;
        Thu, 15 Jun 2023 18:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686852023;
        bh=xjpwDOfwo5GfYMb7NKBDO2vH76dSeta4+5w7iHfMRqo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=UAaL/bKhOJe/dz0JXS3mu0uFSZ2z4RinIp92NRVUjJ3/5boX+agFkiPbpN+Wb28CS
         ONYJkeCer9FO4GAaKnB23nMklwyu7i5ajE6gvR00VoLPqQK0Pc73baL8gcDP609MVz
         E85X9Wh/uc0+s86iTcAL8xg8FRiQtXQsEXbXqB3YRhq6NSsTpl1b0c34t/v96Nm6G1
         XgYKFa9r6y5WIsvnYc6E40me40VBkz0r1TcD133XKGEUj2cPl6BLwgFQjyCzcQhek7
         YsMUVcPhuxmcyDQ8TYg/mOcUIdr1ZsrWZpgJSdhGEvFaKrEJCS/0tNftnyeqhV/yNz
         kquFehz35wpgg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D3DB4C64458;
        Thu, 15 Jun 2023 18:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: assign default compression level
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168685202285.7502.4758002877500330229.git-patchwork-notify@kernel.org>
Date:   Thu, 15 Jun 2023 18:00:22 +0000
References: <20230612201626.3768393-1-jaegeuk@kernel.org>
In-Reply-To: <20230612201626.3768393-1-jaegeuk@kernel.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Mon, 12 Jun 2023 13:16:26 -0700 you wrote:
> Let's avoid any confusion from assigning compress_level=0 for LZ4HC and ZSTD.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/compress.c |  3 +--
>  fs/f2fs/f2fs.h     |  2 ++
>  fs/f2fs/super.c    | 12 +++++++-----
>  3 files changed, 10 insertions(+), 7 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: assign default compression level
    https://git.kernel.org/jaegeuk/f2fs/c/e59031a552b5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


