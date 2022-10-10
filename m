Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4BA35FA6A4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 22:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbiJJU5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 16:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbiJJU4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 16:56:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141391F2C4;
        Mon, 10 Oct 2022 13:56:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B3C2FB810C2;
        Mon, 10 Oct 2022 20:56:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7641FC433D6;
        Mon, 10 Oct 2022 20:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665435395;
        bh=WIJn9KxJcJnHqlqL9MSNcN9GhI0k4/dZ5mFZldwiUBo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=PgB0ClGghhvwaGueVpRg5AJqSYqq4gH5trIXiXbzCkei4hiFho/VU5hH5XFXC7K+3
         E0M1fSOOHe/NTaS9lhJohW/YshSviF9E1bhLnVZYsP2pdMM0q1fZR/XfE3POX2YBCQ
         BB/j6GIfP57qEnJtSnaW+8VyrAQrjAS2t2RCe4PuADgS8aViL6t5otTSqDTDzndqgn
         u3JlByJBAc9BVN8VoMCGLfL/qSdbCSnT+oZ/XDgjjgmBrXrwA2awX/mSeETaJRnZ1E
         wYfo8OXEt6USwwPMv3ZLBn5SFPU/w8n3kqtag+Kpe77QoqSE84WCRBMifLr58z/w5+
         qACX7xkOQZcDw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6548AE2A05F;
        Mon, 10 Oct 2022 20:56:35 +0000 (UTC)
Subject: Re: [GIT PULL] Crypto Update for 6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yzv0wXi4Uu2WND37@gondor.apana.org.au>
References: <20210817013601.GA14148@gondor.apana.org.au>
 <20210929023843.GA28594@gondor.apana.org.au>
 <20211029041408.GA3192@gondor.apana.org.au>
 <20211112104815.GA14105@gondor.apana.org.au>
 <YcKz4wHYTe3qlW7L@gondor.apana.org.au>
 <YgMn+1qQPQId50hO@gondor.apana.org.au>
 <YjE5yThYIzih2kM6@gondor.apana.org.au>
 <YkUdKiJflWqxBmx5@gondor.apana.org.au>
 <YpC1/rWeVgMoA5X1@gondor.apana.org.au>
 <Yui+kNeY+Qg4fKVl@gondor.apana.org.au> <Yzv0wXi4Uu2WND37@gondor.apana.org.au>
X-PR-Tracked-List-Id: <linux-crypto.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yzv0wXi4Uu2WND37@gondor.apana.org.au>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git tags/v6.1-p1
X-PR-Tracked-Commit-Id: b411b1a0c8bddd470fc8c3457629ac25a168cba0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3604a7f568d3f67be8c13736201411ee83b210a1
Message-Id: <166543539540.11766.11135314368387558365.pr-tracker-bot@kernel.org>
Date:   Mon, 10 Oct 2022 20:56:35 +0000
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 4 Oct 2022 16:54:25 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git tags/v6.1-p1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3604a7f568d3f67be8c13736201411ee83b210a1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
