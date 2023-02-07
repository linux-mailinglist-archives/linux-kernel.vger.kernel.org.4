Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7EE868E0B3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 20:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbjBGTAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 14:00:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjBGTAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 14:00:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C86131E13
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 11:00:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 957406113E
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 19:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F2C0CC4339E;
        Tue,  7 Feb 2023 19:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675796418;
        bh=BcIOalxqWOrgaDJrq9uO5FEbZqioEpeR56hDPQadaes=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=jOHkP2DOGkeFQ6xpbLfOntxl03B5I5xTjyhc7ByKewUlmBRX74ou3zikK5Mdgn/Vx
         F2eYpAUi3Fw0Hp0wKWhoTpD0jqG1Yyv1/uiZPTGR7pZ/M6RhghDxpogeI1zQ1QqJv0
         4Y4ujFf6KYp+QgpsRK3oLNqmPZ68pHryQZzl6sjDo5K5sy6YL8U+CRIZpGXmUEBnbE
         jT/zoYhYen4jS8pKP3pb8Bx72dK5pKsuZXfyFHD+3DV32TuWE0K8f+DqSPOO6T+hG6
         3m0wAwW/xTTUXJOaKshjNNg+ljdtqulhXN+EAGacFmXF7DKpCuubdQVAxUEuVRVwcE
         XHPvOXs0Guhsg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CBE7BE21ECD;
        Tue,  7 Feb 2023 19:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v4 1/3] f2fs: fix to set ipu policy
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <167579641783.24576.11656544535078514322.git-patchwork-notify@kernel.org>
Date:   Tue, 07 Feb 2023 19:00:17 +0000
References: <20230206144310.2344-1-frank.li@vivo.com>
In-Reply-To: <20230206144310.2344-1-frank.li@vivo.com>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     jaegeuk@kernel.org, chao@kernel.org, linux-kernel@vger.kernel.org,
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

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon,  6 Feb 2023 22:43:08 +0800 you wrote:
> For LFS mode, it should update outplace and no need inplace update.
> When using LFS mode for small-volume devices, IPU will not be used,
> and the OPU writing method is actually used, but F2FS_IPU_FORCE can
> be read from the ipu_policy node, which is different from the actual
> situation. And remount to lfs mode should be disallowed when
> f2fs ipu is enabled, let's fix it.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v4,1/3] f2fs: fix to set ipu policy
    (no matching commit)
  - [f2fs-dev,v4,2/3] f2fs: add missing description for ipu_policy node
    https://git.kernel.org/jaegeuk/f2fs/c/9e615dbba41e
  - [f2fs-dev,v4,3/3] f2fs: introduce ipu_mode sysfs node
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


