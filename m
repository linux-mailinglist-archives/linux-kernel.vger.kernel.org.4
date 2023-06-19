Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5309973567A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 14:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjFSMKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 08:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjFSMKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 08:10:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4829D11D
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 05:10:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF72560BCA
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 12:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1C913C433CA;
        Mon, 19 Jun 2023 12:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687176621;
        bh=gyZBJ07gcbD6a4Fyl1xZ2umbKV3jBW9w9n9qetj27So=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=OGJRj69ii7V/JoFUMgpHyyPVnJdSFl31f9yU/1cbIuzwZaNj6vK9+92cXKVMaW+Jz
         5l74n1cSs2Vl4P0HcSJkWVgJlcZm1yv+c9q7L1pKNlIFzo6lHr1dDd0zzYAscr45Sq
         71W3n3CFg8mdU8leGewDeXT0b7u8LR7XEHoH5rwAme/LbVo2tWrVIC1n283UaFXthd
         ro81fJ96dzMrFOocP8+AdXYH2UXTk9Ipe5PxhVC2Su3BOSkPeSl8XFR/6uZXUMhdYK
         hMxWaN+Vq22myfIZGT4F1aDkPyAZ3mtyvgB2oPvhTWcLXE76flsd1G8NWx2KHwfGLR
         nUvMFVXtOsxTA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 019A9E301FA;
        Mon, 19 Jun 2023 12:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next] xsk: Remove unused inline function
 xsk_buff_discard()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168717662100.5239.549809460077247982.git-patchwork-notify@kernel.org>
Date:   Mon, 19 Jun 2023 12:10:21 +0000
References: <20230616062800.30780-1-yuehaibing@huawei.com>
In-Reply-To: <20230616062800.30780-1-yuehaibing@huawei.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     bjorn@kernel.org, magnus.karlsson@intel.com,
        maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
        hawk@kernel.org, john.fastabend@gmail.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        maxtram95@gmail.com, simon.horman@corigine.com
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

On Fri, 16 Jun 2023 14:28:00 +0800 you wrote:
> commit f2f167583601 ("xsk: Remove unused xsk_buff_discard")
> left behind this, remove it.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
> v2: resend to bpf-next tree
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next] xsk: Remove unused inline function xsk_buff_discard()
    https://git.kernel.org/bpf/bpf-next/c/e2fa5c2068fb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


