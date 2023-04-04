Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA416D6EFD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 23:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236372AbjDDVaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 17:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235349AbjDDVaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 17:30:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1987A19BD
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 14:30:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A982463A22
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 21:30:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0E68FC4339B;
        Tue,  4 Apr 2023 21:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680643819;
        bh=2NmdC/BmqtWxzZ/ar/gnNZilCEclqyqnyDigaMMdguc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=PVTRSWggLJrNNHl5pggRwWxzDHWMJdTq1gGeYhR1wNIMkRUN/5VzbABij2nbwz7sW
         UeAZHmZxmd8s3gYvVtyO5BOPHT9mVxqzJ41aIikBQdZ30WsXXUHiYDsj8HkQU2PZcH
         bYsvRN+XYfKz4Xq5Ol96JGPraUoeb2cWz3Msc0XctfDGkAAvPv6LQDNHEKNqBlt+g+
         2nvsUwC9cP4mQnR3x+5uQ20B5qnpCdlVkmAP+Q/hA+9zG1u+4/gnJ/DDLqgZwuIXeW
         K8B1Ujc+tOucAKOxX3br1oqDKV7dgtQABTZQErkWoCukWoWpBKXe+Ln6GwpoCpAhmv
         EGPSxXqScRVEg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E5024E524E4;
        Tue,  4 Apr 2023 21:30:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix to check readonly condition
 correctly
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168064381893.16246.7986262771761292127.git-patchwork-notify@kernel.org>
Date:   Tue, 04 Apr 2023 21:30:18 +0000
References: <20230404152807.4987-1-chao@kernel.org>
In-Reply-To: <20230404152807.4987-1-chao@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue,  4 Apr 2023 23:28:07 +0800 you wrote:
> With below case, it can mount multi-device image w/ rw option, however
> one of secondary device is set as ro, later update will cause panic, so
> let's introduce f2fs_dev_is_readonly(), and check multi-devices rw status
> in f2fs_remount() w/ it in order to avoid such inconsistent mount status.
> 
> mkfs.f2fs -c /dev/zram1 /dev/zram0 -f
> blockdev --setro /dev/zram1
> mount -t f2fs dev/zram0 /mnt/f2fs
> mount: /mnt/f2fs: WARNING: source write-protected, mounted read-only.
> mount -t f2fs -o remount,rw mnt/f2fs
> dd if=/dev/zero  of=/mnt/f2fs/file bs=1M count=8192
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: fix to check readonly condition correctly
    https://git.kernel.org/jaegeuk/f2fs/c/2bce08d26c0f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


