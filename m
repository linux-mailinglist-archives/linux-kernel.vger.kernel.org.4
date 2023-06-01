Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C799719B13
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 13:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbjFALkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 07:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbjFALkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 07:40:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5AE129;
        Thu,  1 Jun 2023 04:40:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A426B643DB;
        Thu,  1 Jun 2023 11:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F1044C433EF;
        Thu,  1 Jun 2023 11:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685619620;
        bh=tWKWC14NSUd9pJRuuWFe1qj5v2WPgvywMtEEIdSejIQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=OAid/USZoUrsOwc/UoTVAc9n8Ib6Bb98eKvWIutHzXLvme7rZuzV03ywKtqEr5yis
         d2nqmszqr2+DxstOFkZENbQfg6BpEgMY1VJZG4wf7YFo5uJ8uE3vgCqVRwnz7IpfhZ
         +7TeifzsaKJkQOe+Db3OLHjoOrSYOtD02aEmh+5H9qG3p+6mDXlrEmSRiwMofDi1yq
         H+VcLfUj0f+B2sMEjhHMeoKEz87LPqa4uCS+evPsz5IyE/bbUh3RDuCOrHF6BjbzXP
         WlJRiJvJWPPU/EihT9Cqqzy5EgI6F4uBmOxfwO6YOzVDEW1WSY4cEIwBqE9qPYvvue
         dS5SSdeaHq/TA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CD2DCC395E5;
        Thu,  1 Jun 2023 11:40:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: ipa: Use correct value for IPA_STATUS_SIZE
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168561961983.20738.2293135915204536945.git-patchwork-notify@kernel.org>
Date:   Thu, 01 Jun 2023 11:40:19 +0000
References: <20230531103618.102608-1-spasswolf@web.de>
In-Reply-To: <20230531103618.102608-1-spasswolf@web.de>
To:     Bert Karwatzki <spasswolf@web.de>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, elder@kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 31 May 2023 12:36:19 +0200 you wrote:
> IPA_STATUS_SIZE was introduced in commit b8dc7d0eea5a as a replacement
> for the size of the removed struct ipa_status which had size
> sizeof(__le32[8]). Use this value as IPA_STATUS_SIZE.
> 
> Fixes: b8dc7d0eea5a ("net: ipa: stop using sizeof(status)")
> Signed-off-by: Bert Karwatzki <spasswolf@web.de>
> 
> [...]

Here is the summary with links:
  - [net,v3] net: ipa: Use correct value for IPA_STATUS_SIZE
    https://git.kernel.org/netdev/net/c/be7f8012a513

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


