Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDC272BB2E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 10:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233536AbjFLIuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 04:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjFLIuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 04:50:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C64110
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 01:50:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58425621AC
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 08:50:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A420DC4339E;
        Mon, 12 Jun 2023 08:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686559840;
        bh=3wEU2eWpI2dfYMagdnkzdlLhdwadAxg23iFRWigAAO8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=kCvrQW4MSxDg78li13w0I6JMFG0vYo318lLmqRFEn+u2Rm10ihdc2rGzHkRwqSyGM
         VjG6KfjeFNwKpEm/JI69Dwvq3h5XdruyzKYQZIqZC+DvZjVflo3lHpmEbDeSApWBMs
         m1WJLNQbC4wT6pdH+A5YbdtaaBHjyu1d12HnOrEGqxerAk/zYSa8TeFLbyeksreswX
         fMw1w2hfi+F4O5jQjrz2z6FoGdCibjTckDdITgOCcrwpVTTMveOG9xNuRKzjkQM2ki
         +riw/A256Aj4x7U/c8/utQSkX4IiO6EBGfwqAeLACiMr//oMtqoMzYgyOExR7cA505
         190XV3WHRNqwg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8660DE1CF31;
        Mon, 12 Jun 2023 08:50:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: openvswitch: add support for l4 symmetric
 hashing
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168655984053.8602.1349154560216964511.git-patchwork-notify@kernel.org>
Date:   Mon, 12 Jun 2023 08:50:40 +0000
References: <20230609135955.3024931-1-aconole@redhat.com>
In-Reply-To: <20230609135955.3024931-1-aconole@redhat.com>
To:     Aaron Conole <aconole@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        dev@openvswitch.org, pshelar@ovn.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        echaudro@redhat.com, dceara@redhat.com, i.maximets@ovn.org
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

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri,  9 Jun 2023 09:59:55 -0400 you wrote:
> Since its introduction, the ovs module execute_hash action allowed
> hash algorithms other than the skb->l4_hash to be used.  However,
> additional hash algorithms were not implemented.  This means flows
> requiring different hash distributions weren't able to use the
> kernel datapath.
> 
> Now, introduce support for symmetric hashing algorithm as an
> alternative hash supported by the ovs module using the flow
> dissector.
> 
> [...]

Here is the summary with links:
  - [net-next] net: openvswitch: add support for l4 symmetric hashing
    https://git.kernel.org/netdev/net-next/c/e069ba07e6c7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


