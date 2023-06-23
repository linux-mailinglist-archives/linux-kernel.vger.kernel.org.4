Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA2B73AE28
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 03:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjFWBDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 21:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbjFWBDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 21:03:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9281FC0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 18:03:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDC6E61919
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 01:03:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5F0D6C433C0;
        Fri, 23 Jun 2023 01:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687482214;
        bh=S/jEbHfSkgLqfoC13Bm0yPnjBDCSVlADJchgSprepFc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bhJvOndxSGDVm+u60L0opPd6dvANbnPzebZU9YOomZS2fV+cmt+Bz9jLSHEhKvdjP
         oD471UgOnQpKcbOXloFUDa+6I8uy/envQ5TVX/srP8geH7YhpwOlkD1vTFN0Ltx1PY
         ddodssgI2VWY7Q/HdPEcq6/AZoDxeN3q9VIUJ+ppd+WfkR99hIRrzUA4QR631Xe3EG
         0Hyx+dtREVWCe+cudWfstGHKbNVPdpHu28zwzoxN9mvUREknlETudD/VdhKiRIEJbu
         CZyoNrpK1uXA8jlHkzlAi0n5Tt2e4zcHGl4dftstfES3SV+m1LHo2IU5J+wLa36izM
         DZXHuMsI2B+gQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4B390C691EE;
        Fri, 23 Jun 2023 01:03:34 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.4-5 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87wmzvogge.fsf@mail.lhotse>
References: <87wmzvogge.fsf@mail.lhotse>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87wmzvogge.fsf@mail.lhotse>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.4-5
X-PR-Tracked-Commit-Id: dfaed3e1fa7099de8de4e89cbe7eb9c1bca27dfe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e7758c0ddbc48fec149baea667d2abc85229a997
Message-Id: <168748221430.12146.11415465909512288644.pr-tracker-bot@kernel.org>
Date:   Fri, 23 Jun 2023 01:03:34 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        npiggin@gmail.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 22 Jun 2023 21:59:45 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.4-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e7758c0ddbc48fec149baea667d2abc85229a997

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
