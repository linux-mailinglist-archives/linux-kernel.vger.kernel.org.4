Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385307427B6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 15:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbjF2Nu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 09:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjF2NuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 09:50:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803913588
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 06:50:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DA7161554
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 13:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6DA72C433C9;
        Thu, 29 Jun 2023 13:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688046622;
        bh=tPHOeazIYJqtUaIpapmfwYkwFJ7b2e1P/zfK0tB0644=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=HMivQ3lQOzaz7GetenJtuSMJ/kIIS19PNJ2RvbhzIdgO8tM46X00UCM/fxM1zgbyT
         oGb8sBEoRP4F2UqnmzOuVVIjVfelVOSWw7mS5MjEHrRhYiSFYLxt2GT+2gfUbHMhgl
         p/A5UpF6LCOGmMCwjisg01qXzNN1WBMzsDYwIatgAUGxeC7mjSe00iufen4f/xCu/c
         DCIrfnDMi/cf/M/A2Hs1/hf/gopk+I1hnfJE5g9DkYvaJRbJTPr7y7VFYdBl8GwXte
         J332SKxO/MCfGnzu1B6ME/SwmAHH6tdw/IKVdKp9MQBQKsz+uNr0mo8F90+eilRpKc
         LrmMTJK3Jd0Eg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4F2C6C39563;
        Thu, 29 Jun 2023 13:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] bpf: Replace deprecated -target with --target= for Clang
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168804662232.5062.13182575367358956077.git-patchwork-notify@kernel.org>
Date:   Thu, 29 Jun 2023 13:50:22 +0000
References: <20230624001856.1903733-1-maskray@google.com>
In-Reply-To: <20230624001856.1903733-1-maskray@google.com>
To:     Fangrui Song <maskray@google.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        quentin@isovalent.com, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev, yhs@fb.com
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

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Sat, 24 Jun 2023 00:18:56 +0000 you wrote:
> -target has been deprecated since Clang 3.4 in 2013. Use the preferred
> --target=bpf form instead. This matches how we use --target= in
> scripts/Makefile.clang.
> 
> Link: https://github.com/llvm/llvm-project/commit/274b6f0c87a6a1798de0a68135afc7f95def6277
> Signed-off-by: Fangrui Song <maskray@google.com>
> Acked-by: Yonghong Song <yhs@fb.com>
> 
> [...]

Here is the summary with links:
  - [v2] bpf: Replace deprecated -target with --target= for Clang
    https://git.kernel.org/bpf/bpf-next/c/bbaf1ff06af4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


