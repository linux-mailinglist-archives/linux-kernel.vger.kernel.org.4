Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8AF72B935
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 09:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235576AbjFLHv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 03:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233777AbjFLHvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 03:51:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608262722;
        Mon, 12 Jun 2023 00:50:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40CBA6202E;
        Mon, 12 Jun 2023 07:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 900E6C4339C;
        Mon, 12 Jun 2023 07:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686556219;
        bh=nlVwwwx+2+YvwPo/OfOFeq28gAN7YWuKrvoupNI53G4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=nY+ZwPCwUwMVLHME9N5mtQmC0/U8reXtxT/cxsnYdNjnsvHC/sDt8WVV4D+bx2cHt
         mDzzkyLzR2Yz4av9o51qR7uJ7Y/VRwk5mPWBklWLy4iJTnx/rACPSfMAIPH4cdVmqn
         QX/lIUuDjVgazsziRvJ7NHw086y+d/9SWRRGN0y4BflTqZqqY+qilkGNFW0++ICBQ8
         wM1H6ec3jJW5vcPNjsVo+cZ1xpfLn0DRtwnk0LMI80ngftSCHwVT/a7r2AkmX0e1fC
         YrdBXPkliRU4P2VRd2kT6QXTwrGsGB9xa6K8PQ3PETGNnMZesgxrE+IWzMJ3q0MT6k
         jrKXogA3itcHA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 71BA1E21EC0;
        Mon, 12 Jun 2023 07:50:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next V8] dt-bindings: net: xlnx,axi-ethernet: convert
 bindings document to yaml
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168655621946.6480.12343747716640389819.git-patchwork-notify@kernel.org>
Date:   Mon, 12 Jun 2023 07:50:19 +0000
References: <20230608082458.280208-1-sarath.babu.naidu.gaddam@amd.com>
In-Reply-To: <20230608082458.280208-1-sarath.babu.naidu.gaddam@amd.com>
To:     Sarath Babu Naidu Gaddam <sarath.babu.naidu.gaddam@amd.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, michal.simek@amd.com,
        radhey.shyam.pandey@amd.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, anirudha.sarangi@amd.com,
        harini.katakam@amd.com, git@amd.com
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

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 8 Jun 2023 13:54:58 +0530 you wrote:
> From: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> 
> Convert the bindings document for Xilinx AXI Ethernet Subsystem
> from txt to yaml. No changes to existing binding description.
> 
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> Signed-off-by: Sarath Babu Naidu Gaddam <sarath.babu.naidu.gaddam@amd.com>
> 
> [...]

Here is the summary with links:
  - [net-next,V8] dt-bindings: net: xlnx,axi-ethernet: convert bindings document to yaml
    https://git.kernel.org/netdev/net-next/c/cbb1ca6d5f9a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


