Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A406EF8F8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 19:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbjDZRGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 13:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233921AbjDZRGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 13:06:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6A37D99;
        Wed, 26 Apr 2023 10:06:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BA646132A;
        Wed, 26 Apr 2023 17:06:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F965C4339B;
        Wed, 26 Apr 2023 17:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682528792;
        bh=luhXDip7ZThYSriayg4A6CXDv28E1cgSnb+UHfM0u8E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JFxxa6D8768xouyfUFRqRT3nR+u3110qlBQfn3DHuc6AR18eolzSMo5NPf1ofuST5
         3b2xuj/Ad/92qy3rzgREOyg8WU4IVCY+WSEB5IuktvIbaP4DV8Lk+LNmmj+wFMSPk5
         oJw4gZbZghPvxDQrmOrlrXIWlFup2QEwYC/+5FjUncIClnKZmisOaUTxlhae7rlYoE
         Y5rSdBe3uVls8qvZb0V712ubak5oEyD5Wg9sbor7MH9F7WAyNTROuTFwhEW1jUVGyN
         TuVvFnESvaVaXq/L/fjotrmZOHiF8zHLH00rz+LqLbh+kpVHexkhscKf3is+lw0L20
         etcNu8E4J6MXA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7F87AC43158;
        Wed, 26 Apr 2023 17:06:32 +0000 (UTC)
Subject: Re: [GIT PULL] Crypto Update for 6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZEYLC6QsKnqlEQzW@gondor.apana.org.au>
References: <20211112104815.GA14105@gondor.apana.org.au>
 <YcKz4wHYTe3qlW7L@gondor.apana.org.au>
 <YgMn+1qQPQId50hO@gondor.apana.org.au>
 <YjE5yThYIzih2kM6@gondor.apana.org.au>
 <YkUdKiJflWqxBmx5@gondor.apana.org.au>
 <YpC1/rWeVgMoA5X1@gondor.apana.org.au>
 <Yui+kNeY+Qg4fKVl@gondor.apana.org.au>
 <Yzv0wXi4Uu2WND37@gondor.apana.org.au>
 <Y5mGGrBJaDL6mnQJ@gondor.apana.org.au>
 <Y/MDmL02XYfSz8XX@gondor.apana.org.au> <ZEYLC6QsKnqlEQzW@gondor.apana.org.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZEYLC6QsKnqlEQzW@gondor.apana.org.au>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git v6.4-p1
X-PR-Tracked-Commit-Id: 482c84e906e535072c55395acabd3a58e9443d12
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 733f7e9c18c5e377025c1bfdce6bc9a7d55649be
Message-Id: <168252879251.19907.570748263553593045.pr-tracker-bot@kernel.org>
Date:   Wed, 26 Apr 2023 17:06:32 +0000
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 24 Apr 2023 12:52:27 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git v6.4-p1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/733f7e9c18c5e377025c1bfdce6bc9a7d55649be

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
