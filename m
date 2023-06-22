Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48CC739380
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 02:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbjFVACt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 20:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbjFVACo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 20:02:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846591FF6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 17:02:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11B426171D
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 00:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 652D6C433CB;
        Thu, 22 Jun 2023 00:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687392021;
        bh=WiZVeloMcs/+JOHqbX05hM3ZHPzrGrw8JH39DpSMMvE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=q3OWDtV8fw9ec6/Y+K54ko4tza46/AVwMqjJD5/9iO+ScEMY6zStf817uL+/M/VPA
         OcRapSLq4/xH5EU2/1Hc34F3XwcalxKFxfWG3v9om0tKUZ+G1Aghv5HPawPqHNG2N7
         lPUgN1r+yIGR5XHDzziKT91JUCJ5i51WAZl0ubuzHTHZXhN4slpdDjCfgz47MCNWhW
         SVoF4qybf7o1XRzgxc86kj8g/rgFH1Pq8LXNKiLuxmHQ+X8HIasu/eMajcwOSI9TFq
         uiBo58czkKvU0QqhpYdvENw7PGH1zQObqEKlZfxL0voAsAbXcjauDwDfg0ZH59dSRg
         YWWqvnrTYHJ2A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3F748E4F14A;
        Thu, 22 Jun 2023 00:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] selftests: tc-testing: add one test for flushing
 explicitly created chain
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168739202125.22621.9173578727280562724.git-patchwork-notify@kernel.org>
Date:   Thu, 22 Jun 2023 00:00:21 +0000
References: <20230620014939.2034054-1-renmingshuai@huawei.com>
In-Reply-To: <20230620014939.2034054-1-renmingshuai@huawei.com>
To:     renmingshuai <renmingshuai@huawei.com>
Cc:     pctammela@mojatatu.com, vladbu@nvidia.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        liaichun@huawei.com, caowangbao@huawei.com, yanan@huawei.com,
        liubo335@huawei.com
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
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 Jun 2023 09:49:39 +0800 you wrote:
> Add the test for additional reference to chains that are explicitly created
>  by RTM_NEWCHAIN message.
> The test result:
> 1..1
> ok 1 c2b4 - soft lockup alarm will be not generated after delete the prio 0
>  filter of the chain
> 
> [...]

Here is the summary with links:
  - [v2] selftests: tc-testing: add one test for flushing explicitly created chain
    https://git.kernel.org/netdev/net-next/c/ca4fa8743537

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


