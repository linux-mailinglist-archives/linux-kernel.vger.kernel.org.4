Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF5273AEA0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 04:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbjFWCa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 22:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjFWCaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 22:30:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4DC1BCA
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 19:30:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A42C461949
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 02:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 09B52C433C9;
        Fri, 23 Jun 2023 02:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687487421;
        bh=LoT1cg4zyU11gDTCuPqAyvdFlyVJgFvFy/QlS8hr4XU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=YkgvgL5c4c/zY8R4e0PxRR28AXKWn42A0n/H9LJXBCK68W1n+sRfNIpe5rGZyDpTs
         bky/evCmc+DK5sfjbhJUwF3ZDIAHoI0sKC+dBXU1eyo5WXihEHGfmv40U4q39qf859
         8W/Z16o1VHQPqH8t24XG86TCA0SBvY4Bs95uMKfWLn5s3jAsxSNKlyabnXVXHCqk70
         rykVHm2Wz+NmixfsIUvopexBJcTkKmYu/EfkSA+02JQNjw9yr5PxhF/Xol9QQUzSmq
         qK19YxAuz5ng2H5HCEbMf4D5LaObNEyV1LczF99NVGmrnA3+VP0KwPcc9w2vJQc9qg
         91ajVHqNuM56Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CDF80C395F1;
        Fri, 23 Jun 2023 02:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] MAINTAINERS: update email addresses of octeon_ep driver
 maintainers
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168748742083.21061.10549192533508725101.git-patchwork-notify@kernel.org>
Date:   Fri, 23 Jun 2023 02:30:20 +0000
References: <20230621101649.43441-1-sedara@marvell.com>
In-Reply-To: <20230621101649.43441-1-sedara@marvell.com>
To:     Sathesh Edara <sedara@marvell.com>
Cc:     linux-kernel@vger.kernel.org, sburla@marvell.com,
        vburru@marvell.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        hgani@marvell.com
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

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 21 Jun 2023 03:16:49 -0700 you wrote:
> Update email addresses of Marvell octeon_ep driver maintainers.
> Also remove a former maintainer.
> 
> As a maintainer below are the responsibilities:
> - Pushing the bug fixes and new features to upstream.
> - Responsible for reviewing the external changes
>   submitted for the octeon_ep driver.
> - Reply to maintainers questions in a timely manner.
> 
> [...]

Here is the summary with links:
  - [v2] MAINTAINERS: update email addresses of octeon_ep driver maintainers
    https://git.kernel.org/netdev/net/c/b9ec61be2d91

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


