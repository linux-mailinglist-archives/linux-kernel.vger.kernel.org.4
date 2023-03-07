Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D986AEB7D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 18:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbjCGRph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 12:45:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbjCGRpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 12:45:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EA3974A1;
        Tue,  7 Mar 2023 09:40:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 882E561520;
        Tue,  7 Mar 2023 17:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF6E9C4339C;
        Tue,  7 Mar 2023 17:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678210824;
        bh=nBD87ebtYyHOkt7XNSc1hkyvm5TVpFYpPKLC7O5xbSg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=oWFJqa5qjySzpMRgbD+E6Vsqs+wW2DJyUAeWohs7eGUror17bo3tg2sPSoO0KZZL8
         p5mBcgIkqMsd4T61tDBd5ak6bOI5aLvy3g8l9svpn5MripXzDZE+9AdPYHQn+7bIIO
         0ikJ9qAY79TKfCFBt+kHdnGLlgqbFaVLKT/PrwQQ4v5p7OXuidAh3NGR5//TwAApjA
         4e4C8G8FLFpRolu+ExS59KkLQVgfMyBN05fKR7JgkHbbhd24GZ+BGjgGGx0WnF1+L7
         s9tVgv68N+vsjJQaSZH1itlkEwcvG4fxePy++NSJlfhfLoNWTnk9mcTJDjduJMlK57
         bSpWv3XIWjPwg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C2A50E61B67;
        Tue,  7 Mar 2023 17:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: Fix f2fs_truncate_partial_nodes ftrace
 event
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <167821082479.1693.18260840022075703789.git-patchwork-notify@kernel.org>
Date:   Tue, 07 Mar 2023 17:40:24 +0000
References: <20230306122549.236561-1-douglas.raillard@arm.com>
In-Reply-To: <20230306122549.236561-1-douglas.raillard@arm.com>
To:     Douglas RAILLARD <douglas.raillard@arm.com>
Cc:     jaegeuk@kernel.org, chao@kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
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

On Mon,  6 Mar 2023 12:25:49 +0000 you wrote:
> From: Douglas Raillard <douglas.raillard@arm.com>
> 
> Fix the nid_t field so that its size is correctly reported in the text
> format embedded in trace.dat files. As it stands, it is reported as
> being of size 4:
> 
>         field:nid_t nid[3];     offset:24;      size:4; signed:0;
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: Fix f2fs_truncate_partial_nodes ftrace event
    https://git.kernel.org/jaegeuk/f2fs/c/3ccc99d5a4ea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


