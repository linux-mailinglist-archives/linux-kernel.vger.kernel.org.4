Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89B966345B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 23:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237394AbjAIWv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 17:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235313AbjAIWvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 17:51:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0AF13FAF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 14:51:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5461B611E0
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 22:51:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8AE81C43398;
        Mon,  9 Jan 2023 22:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673304674;
        bh=XjPLId5bteLVGoRQ3LSG9S2TniodXuedRHK/YAPOVSY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=tDZwho0QNdV6o2N6kd1yaTPhx18RAVrmGQES5G+6l9wc7SPcosiMZnU+7H2gRprz9
         Njrmbi1IlQo3c9jZPt/SSt+oB6i6YtvMPw1XutFpEBzdZv4ANL/zlhMVzg3ol9ZzUo
         oQJsmm2zrrPIOhEHX9s25mdban8NADs7BYsD7dniuZyDAqKYIiqvXSOKbilnxDdjyG
         SDzsrhcmCoA9GGxUvAVnILKx44BOVaTtR7qRN6NsLLorMkOJr+p00ehgNpCQRwMTzL
         Yw8zw5bYq2LeaohvS61YOCW5jiRFcC2mH+U8FrR01E29V55+DNSC8DAoJ40EFzrjaV
         JBdLEiJpfHavA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 68CFBE21EE6;
        Mon,  9 Jan 2023 22:51:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to call clear_page_private_reference
 in .{release, invalid}_folio
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <167330467442.13717.5107793430608586611.git-patchwork-notify@kernel.org>
Date:   Mon, 09 Jan 2023 22:51:14 +0000
References: <20221221121345.14353-1-chao@kernel.org>
In-Reply-To: <20221221121345.14353-1-chao@kernel.org>
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

On Wed, 21 Dec 2022 20:13:45 +0800 you wrote:
> b763f3bedc2d ("f2fs: restructure f2fs page.private layout") missed
> to call clear_page_private_reference() in .{release,invalid}_folio,
> fix it, though it's not a big deal since folio_detach_private() was
> called to clear all privae info and reference count in the page.
> 
> BTW, remove page_private_reference() definition as it never be used.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to call clear_page_private_reference in .{release, invalid}_folio
    https://git.kernel.org/jaegeuk/f2fs/c/6779b5db90c5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


