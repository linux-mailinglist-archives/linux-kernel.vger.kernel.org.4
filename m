Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2770F74F614
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 18:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjGKQud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 12:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjGKQu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 12:50:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E399FE75
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 09:50:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79D7F61585
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 16:50:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D4869C433CA;
        Tue, 11 Jul 2023 16:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689094226;
        bh=9MiOiMOs5+VWea1gr0KqPNVMAfzAFLnJIKEhFO9iDHk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=eqxhl31OaXhY7xJQ6BJkKiX2EAm/Afe8InXwasdaLIlnG79zKqAay5ozoRpKJDPC8
         fkHLW2UxEm0NsmOO5Z2WlT/qgtJGqTmP51XTkLsJLhWcdMQIpVOY8eCWjdHfIh1Fzf
         YHcbBZYPVG/lTQHHwLQLIuUki+seaiBLXuepvPOxW7dy66ho00eRFLQK3/fJDG1znd
         P1RksMeavtW0skt166OofHUgR709eKQUOzu11AdnQvv2HFZmxoSaGFYSotEQ828VTV
         w7eUJpeDGuTg3igHvtQM7w8AkRBFm/burtNhXUoLMg6USv2N/eBgvry7cs2rzeYMCe
         RHTB42SgDCQoA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B86A6E4D021;
        Tue, 11 Jul 2023 16:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] libbpf: remove HASHMAP_INIT static initialization helper
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168909422675.4543.5041944985378816466.git-patchwork-notify@kernel.org>
Date:   Tue, 11 Jul 2023 16:50:26 +0000
References: <20230711070712.2064144-1-sanpeqf@gmail.com>
In-Reply-To: <20230711070712.2064144-1-sanpeqf@gmail.com>
To:     John Sanpe <sanpeqf@gmail.com>
Cc:     daniel@iogearbox.net, ast@kernel.org, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
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
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 11 Jul 2023 15:07:12 +0800 you wrote:
> Remove the wrong HASHMAP_INIT. It's not used anywhere in libbpf.
> 
> Signed-off-by: John Sanpe <sanpeqf@gmail.com>
> ---
>  tools/lib/bpf/hashmap.h | 10 ----------
>  1 file changed, 10 deletions(-)

Here is the summary with links:
  - [v3] libbpf: remove HASHMAP_INIT static initialization helper
    https://git.kernel.org/bpf/bpf-next/c/a3e7e6b17946

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


