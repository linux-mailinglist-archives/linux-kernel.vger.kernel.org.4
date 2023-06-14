Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3DA70DFCF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 17:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237206AbjEWPAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 11:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237184AbjEWPAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 11:00:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD3E121
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 08:00:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20D7362C25
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 15:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 808B5C4339C;
        Tue, 23 May 2023 15:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684854020;
        bh=mRwXoyY9oWP89l1e78Jo5a0ZJ7zR47R7VPH9XIMjDtk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=OXkWGWY/AqYHwyl3DI5zlhtNT1XmoN0zBkZI4tyOu755n2YPefLqpWe06PmRJthHb
         LyuOkT0qUJ65VZhVSR3OX+e9OfXRMAuebDcq8EY7uCKTJ/YB609JrvrQJroIHAA9fe
         h4R9PwvEhmzxLeMj50XJAJJSI2Ha6vPH54M7QmHto6b/BX9nOoIZaj3zv6TPBJ3FZv
         BzuFXg9fkDj1JCB27v3lDFFYGv2ivqMG2tyV1vTumE8BJ1CaJQE6JItdok+Xagdd34
         CUaunPwvoOlSQQfrEF+evhx3Eyb8h8xv1KZljqX+rakaGBplwCOmWjIItIlf4ShytV
         ez59b4omiJcIw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 67670E21ECE;
        Tue, 23 May 2023 15:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpftool: specify XDP Hints ifname when loading
 program
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168485402041.5478.8959103942618026686.git-patchwork-notify@kernel.org>
Date:   Tue, 23 May 2023 15:00:20 +0000
References: <20230517160103.1088185-1-larysa.zaremba@intel.com>
In-Reply-To: <20230517160103.1088185-1-larysa.zaremba@intel.com>
To:     Larysa Zaremba <larysa.zaremba@intel.com>
Cc:     quentin@isovalent.com, sdf@google.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        niklas.soderlund@corigine.com
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

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 17 May 2023 18:01:04 +0200 you wrote:
> Add ability to specify a network interface used to resolve
> XDP Hints kfuncs when loading program through bpftool.
> 
> Usage:
>   bpftool prog load [...] xdpmeta_dev <ifname>
> 
> Writing just 'dev <ifname>' instead of 'xdpmeta_dev' is a very probable
> mistake that results in not very descriptive errors,
> so 'bpftool prog load [...] dev <ifname>' syntax becomes deprecated,
> followed by 'bpftool map create [...] dev <ifname>' for consistency.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpftool: specify XDP Hints ifname when loading program
    https://git.kernel.org/bpf/bpf-next/c/f46392ee3dec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


