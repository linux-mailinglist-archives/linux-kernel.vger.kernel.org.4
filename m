Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC706FB655
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 20:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjEHSea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 14:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjEHSe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 14:34:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567FA59F3
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 11:34:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF14761847
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 18:34:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 49015C4339C;
        Mon,  8 May 2023 18:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683570867;
        bh=TNvoTz3NbOFEJrnEiM49QKPvbzCgS37E7OGjAtEsRsY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=p9/NIXDwgryeNUn5DGG41xjRsbiCmgPp6PZigl/4kxKFAgY7dT+jLOz/uyOcSyi7+
         kW6gNPY4EB8c6Lw/+sEqmVeyW8c4et88oBbWC8fN1DmMkNuN85+wSD11ihhmxePAQg
         EviDXCwsK9Qjhu/c9C440VKLZhTAJTDjvP43SQWkRBt5yL8yQgo1l2AvsE32lMyM/6
         94dDj8iW+ZaUIuT6e+8fczPdosqDpJc8WLP3C6Kvw8Ky4anqVrpqt8ZzWT6i/g7Lu5
         MYgbTh5FVtTVqe1YBH2l0Mk1og3Ut7zyf6PCWFhrYZZFErzqSYyJRk7hYLlYc3WB7z
         0oizvHVW5Nm2w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 203D3E270D4;
        Mon,  8 May 2023 18:34:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v11] f2fs: support
 errors=remount-ro|continue|panic mountoption
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168357086712.2764.18059620800942332067.git-patchwork-notify@kernel.org>
Date:   Mon, 08 May 2023 18:34:27 +0000
References: <20230423154915.530254-1-chao@kernel.org>
In-Reply-To: <20230423154915.530254-1-chao@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        frank.li@vivo.com, linux-f2fs-devel@lists.sourceforge.net
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

On Sun, 23 Apr 2023 23:49:15 +0800 you wrote:
> This patch supports errors=remount-ro|continue|panic mount option
> for f2fs.
> 
> f2fs behaves as below in three different modes:
> mode			continue	remount-ro	panic
> access ops		normal		noraml		N/A
> syscall errors		-EIO		-EROFS		N/A
> mount option		rw		ro		N/A
> pending dir write	keep		keep		N/A
> pending non-dir write	drop		keep		N/A
> pending node write	drop		keep		N/A
> pending meta write	keep		keep		N/A
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v11] f2fs: support errors=remount-ro|continue|panic mountoption
    https://git.kernel.org/jaegeuk/f2fs/c/b62e71be2110

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


