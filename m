Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF0A725D66
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 13:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240371AbjFGLkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 07:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239236AbjFGLkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 07:40:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9A21730
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 04:40:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 684B763DF7
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 11:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C570AC4339B;
        Wed,  7 Jun 2023 11:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686138019;
        bh=NfzoinfF6ITp25gHnJr6r4gON/9GQA7t0s5VVkXdFPI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=BxZzXX0o2IoZK1YUjbI/11bK+JvPeRAKRehF+ANuZ0EJKhNaSLvgWUxvbwBDmEN7/
         z9O4cWDP/x4/iZATNG/m88qJWi/Aki0DNLjTPeTqMNX7p+29SAelnAn79AD49RNjOQ
         VOMTLIAqKjyX7L1p3j5rMpxF8Kw0+RV0HYvcqG6zCt+k4j4AeqUlmIMRYWu72LLrUq
         TCtmtl0WU4AviPgHTzX1Ro5BQUCeflhgi1f7PtLDylXntx3ANhh8upEVoONqqGySn+
         GMn/yEQWCPkLqYjg/eB7Tl5lYHGYD0kvrKYQs6QnrgE14lDlD324VJW+deXqzStFnc
         D6IC/fh3Wz8jg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A9000E29F3C;
        Wed,  7 Jun 2023 11:40:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: sched: fix possible refcount leak in
 tc_chain_tmplt_add()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168613801968.3806.8503105086077075937.git-patchwork-notify@kernel.org>
Date:   Wed, 07 Jun 2023 11:40:19 +0000
References: <20230607022301.6405-1-hbh25y@gmail.com>
In-Reply-To: <20230607022301.6405-1-hbh25y@gmail.com>
To:     Hangyu Hua <hbh25y@gmail.com>
Cc:     jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, simon.horman@corigine.com,
        larysa.zaremba@intel.com, netdev@vger.kernel.org,
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

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed,  7 Jun 2023 10:23:01 +0800 you wrote:
> try_module_get will be called in tcf_proto_lookup_ops. So module_put needs
> to be called to drop the refcount if ops don't implement the required
> function.
> 
> Fixes: 9f407f1768d3 ("net: sched: introduce chain templates")
> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net,v2] net: sched: fix possible refcount leak in tc_chain_tmplt_add()
    https://git.kernel.org/netdev/net/c/44f8baaf230c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


