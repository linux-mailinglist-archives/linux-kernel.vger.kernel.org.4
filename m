Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA8B5683629
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 20:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbjAaTKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 14:10:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbjAaTKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 14:10:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5727E45F72
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 11:10:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F068A616BD
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 19:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 540FEC433A1;
        Tue, 31 Jan 2023 19:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675192220;
        bh=tx/vmfHTRwhpigYWiQ00JP3gioiHgi8wMMfUioCGDE4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=DKMnM/n/hJ2bg9kZlAjQNK8kPmcaOh+gXRw21XjI+4+XjME7abinbIr7E162JUIow
         fhlC8b/XWM6wSSJDKZbGA76/IxpdQILA1odfHz/0WUy5VHm6dfGXWkwqivvnPrqPZK
         ITQTlmgwjjp7qgwyXjxep2sR6oh/dcEj+y0HKx47AsVMF58bzO7VngMgKZM6d3O+2k
         DbFGw/VLZ7UR3Cvmdsi0CsljKnuEiECkCFbKShIIphf4xum3VjHYxw4e36WFIDx0px
         EAP8/Pp+j8qmi6vdhhF4kDKDOBKEc2AagMnFzu7fa+xsmBwzMySGgfSn64STqFTQzI
         GBrPycrT0BtJw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 242DBE50D6B;
        Tue, 31 Jan 2023 19:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: clean up i_compress_flag and
 i_compress_level usage
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <167519222014.20142.13564540908735669128.git-patchwork-notify@kernel.org>
Date:   Tue, 31 Jan 2023 19:10:20 +0000
References: <20230128103011.1316979-1-chao@kernel.org>
In-Reply-To: <20230128103011.1316979-1-chao@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
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

On Sat, 28 Jan 2023 18:30:11 +0800 you wrote:
> .i_compress_level was introduced by commit 3fde13f817e2 ("f2fs: compress:
> support compress level"), but never be used.
> 
> This patch updates as below:
> - load high 8-bits of on-disk .i_compress_flag to in-memory .i_compress_level
> - load low 8-bits of on-disk .i_compress_flag to in-memory .i_compress_flag
> - change type of in-memory .i_compress_flag from unsigned short to unsigned
> char.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: clean up i_compress_flag and i_compress_level usage
    https://git.kernel.org/jaegeuk/f2fs/c/81649c6e4db8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


