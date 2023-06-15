Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD11731F98
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 20:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233256AbjFOSAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 14:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjFOSAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 14:00:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDAD2728
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 11:00:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6F25621D2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 18:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1B72EC433CA;
        Thu, 15 Jun 2023 18:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686852023;
        bh=bxVjEWkxZnaxJ/JKb6C9OMV210qolC16gpN+9qdEWu0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=X53nK8sd2GoCuS8VNutNBdgy59gg7vjxkxZm5qJinXD/F57VyJVmkSlG9nVK89oKf
         KR+rDG9TDOxn9h+8Nw6l6JzgQTehFZF+qa4bNLmLTL/cHpnTMl1J/UKp0R6RSWrWlE
         rkdvaPHyNKUtb6BGxF9NSm5LvpRZdPR19RnP55/dDxjFp14oencH/daEHVrmBRXem4
         qg88pC78MqGRycR7FqXYaq7QGG6KWls6YVm8x3RwTUMcEXh5CK+tobdMGwfKHGdv5Z
         apFLpsH8bEAf4ghC7EQH8me5+ELYVFKLhvUH7SUYwu7p6YIbg2XVvVm5YR5Zx/i921
         LVAf/DXi0KaEA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EAEDDE21EEB;
        Thu, 15 Jun 2023 18:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v4 0/6] f2fs: add f2fs_ioc_[get|set]_extra_attr
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168685202293.7502.5200872561131261330.git-patchwork-notify@kernel.org>
Date:   Thu, 15 Jun 2023 18:00:22 +0000
References: <20230612030121.2393541-1-shengyong@oppo.com>
In-Reply-To: <20230612030121.2393541-1-shengyong@oppo.com>
To:     Sheng Yong <shengyong@oppo.com>
Cc:     jaegeuk@kernel.org, chao@kernel.org, ebiggers@kernel.org,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 12 Jun 2023 11:01:15 +0800 you wrote:
> This patchset introduces two ioctls to get or modify values in
> f2fs_inode's extra attribute area:
>   * f2fs_ioc_get_extra_attr
>   * f2fs_ioc_set_extra_attr
> 
> The argument of these two ioctls is `struct f2fs_extra_attr', which has
> three members:
>   * field: indicates which field in extra attribute area is handled
>   * attr: value or userspace pointer
>   * attr_size: size of `attr'
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v4,1/6] f2fs: add helper to check compression level
    (no matching commit)
  - [f2fs-dev,v4,2/6] f2fs: cleanup MIN_INLINE_XATTR_SIZE
    https://git.kernel.org/jaegeuk/f2fs/c/4acc6b9d6104
  - [f2fs-dev,v4,3/6] f2fs: add helper to get inode chksum from inode page
    (no matching commit)
  - [f2fs-dev,v4,4/6] f2fs: add f2fs_ioc_get_compress_blocks
    https://git.kernel.org/jaegeuk/f2fs/c/1c5c646596c6
  - [f2fs-dev,v4,5/6] f2fs: add f2fs_ioc_[get|set]_extra_attr
    (no matching commit)
  - [f2fs-dev,v4,6/6] f2fs: access compression level and flags by extra attr ioctls
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


