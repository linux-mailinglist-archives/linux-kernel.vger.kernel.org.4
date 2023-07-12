Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7395874FDBB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 05:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbjGLDaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 23:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjGLDaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 23:30:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6AD10C2;
        Tue, 11 Jul 2023 20:30:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FAD4616CC;
        Wed, 12 Jul 2023 03:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6047EC433CA;
        Wed, 12 Jul 2023 03:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689132621;
        bh=nf8s+njeK8OMoPoLEn08q8t0z0oB7UZlF/uGzfV+kxQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=uxU3r6W9obyLdEo5Qg2fFf+Yr/eImZxrHX8NjSw7HPFSShWnwX+JhEpvb/5V589qT
         jYNimClhQOiN5TLD7OasoZTeSwZYArJexemm4XQOJLCnCBsESSj1zbpt7qKn935un0
         y/u5xlRhi3lqB57AFG13I6Hr104tf6nCWI+FwEZwXivW+gLjUybX5CRDJAONvSNBNm
         uNzGIp8Wf//cTSX+Fb4oWHcfEWB5ukjF39qgCDIGSWtMq0Qp4O3Ooc9X43yy+avi4Z
         GGAYMWEmsi1NvSjWaRolqaYs1pzUWcz0xaZRAJ8GmAy5TSnVnbnLsUYk3noD9oW8Y3
         UhewL4cmnqeog==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 46137E4D006;
        Wed, 12 Jul 2023 03:30:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] MAINTAINERS: Add another mailing list for QUALCOMM
 ETHQOS ETHERNET DRIVER
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168913262128.27250.10319125912738064702.git-patchwork-notify@kernel.org>
Date:   Wed, 12 Jul 2023 03:30:21 +0000
References: <20230710195240.197047-1-ahalaney@redhat.com>
In-Reply-To: <20230710195240.197047-1-ahalaney@redhat.com>
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
        mcoquelin.stm32@gmail.com, pabeni@redhat.com, kuba@kernel.org,
        edumazet@google.com, davem@davemloft.net, joabreu@synopsys.com,
        alexandre.torgue@foss.st.com, peppe.cavallaro@st.com,
        bhupesh.sharma@linaro.org, vkoul@kernel.org,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org
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

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 10 Jul 2023 14:50:57 -0500 you wrote:
> linux-arm-msm is the list most people subscribe to in order to receive
> updates about Qualcomm related drivers. Make sure changes for the
> Qualcomm ethernet driver make it there.
> 
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [net-next] MAINTAINERS: Add another mailing list for QUALCOMM ETHQOS ETHERNET DRIVER
    https://git.kernel.org/netdev/net/c/e522c1bd0ab4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


