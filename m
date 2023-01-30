Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462FB681F4B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 00:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjA3XDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 18:03:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbjA3XDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 18:03:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC55305E2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 15:02:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7C176130C
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 23:00:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5B713C43322;
        Mon, 30 Jan 2023 23:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675119618;
        bh=CvyZvy72JS05eTOox+biJHstIc1DNDyVc51Ujeo7+YY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=oVgV5zFQpAC8umAvI8t83n06fWRTtoDE7MY8Mrjyr56VspToDBFJ7kWv9hzNHHxb3
         KswI6B3u4CzWPZcrHRXPCsFkA98UeWWcg2gLPBtaH1ItkXSPj2KtAaAUbbpcnaI5yX
         HQw436Gcmu6vThcrrHXjTx62JoAb0Ark2dl+/7WQP+vH679w7+Y7CgX9iqcBq8M90n
         wMXyyQUa1MSBUeUVnGf0QwCnBuyV3hkRH5Oudkhme/ipi4mRK87CBgYXv3mumeLv3t
         QH26Wl6feF8QQwirGjzR98hiY0CRJg+X1vO1DQ0KPZac5SLuk1D3OmNjIh9zg0278v
         DtaEg4LEgQdhg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0A5F4E5255F;
        Mon, 30 Jan 2023 23:00:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 1/3] f2fs: clarify compress level bit offset
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <167511961803.12751.4198234903796122252.git-patchwork-notify@kernel.org>
Date:   Mon, 30 Jan 2023 23:00:18 +0000
References: <20230112133443.16713-1-frank.li@vivo.com>
In-Reply-To: <20230112133443.16713-1-frank.li@vivo.com>
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

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 12 Jan 2023 21:34:43 +0800 you wrote:
> commit 3fde13f817e2 ("f2fs: compress: support compress level") introduce
> compress level, which macro(COMPRESS_LEVEL_OFFSET) is 8, But use wrong
> comment about compress level.
> 
> Let's fix it.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,1/3] f2fs: clarify compress level bit offset
    https://git.kernel.org/jaegeuk/f2fs/c/9adc6c8ff3da
  - [f2fs-dev,2/3] f2fs: add F2FS_IOC_SET_COMPRESS_OPTION_V2 ioctl
    (no matching commit)
  - [f2fs-dev,3/3] f2fs: add F2FS_IOC_GET_COMPRESS_OPTION_V2 ioctl
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


