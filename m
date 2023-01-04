Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A8365D6E7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 16:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239291AbjADPIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 10:08:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234778AbjADPIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 10:08:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1444C192BC
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 07:08:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A42FD6177A
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 15:08:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA3EC433EF;
        Wed,  4 Jan 2023 15:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672844880;
        bh=eyjVkneoD29HZD7V05u7LVYFGlTV8AkMwGCe+d6NoPs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O5cwxBnCTCSPqEzRib+obGailptzMvW37krTp2gwiUyDawk3i8yH1FMgJtaL62XW7
         uKmYqT6pniUu6kJIhDs0KVBrugG2Tzz8waoo70mZrGcLqptewRKEofWCIctTCNqgcv
         wkdl/A7XPgCtwElfr9073cIB7u0exAC4dUCmwBwAx5D5jX8yefyU8MDNnv+6zeP0nh
         E+Yy3ZWMzEF4xVQ7Ryp0tjeeyuKNB+6A+/NOISt0gZOLK4lJw5QLtbo/tyFva1NX2D
         mj1TJfw1KgNLnbNZc5M2QJ+N9uwkOdMgOQXMNGGQl9EIk/x1jQg9XGwY+ICNyU3AHs
         dDgRfyBqNTQlg==
Date:   Wed, 4 Jan 2023 15:07:55 +0000
From:   Lee Jones <lee@kernel.org>
To:     ye.xingchen@zte.com.cn
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: use sysfs_emit() to instead of scnprintf()
Message-ID: <Y7WWS6D5Vv3m0XzW@google.com>
References: <202212021528368292334@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202212021528368292334@zte.com.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 02 Dec 2022, ye.xingchen@zte.com.cn wrote:

> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Follow the advice of the Documentation/filesystems/sysfs.rst and show()
> should only use sysfs_emit() or sysfs_emit_at() when formatting the
> value to be returned to user space.
> 
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>  drivers/mfd/kempld-core.c | 7 +++----
>  drivers/mfd/lm3533-core.c | 2 +-
>  2 files changed, 4 insertions(+), 5 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
