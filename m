Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8DC74B58F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 19:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbjGGRLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 13:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232548AbjGGRLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 13:11:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BE3196
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 10:11:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DFCF619FF
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 17:11:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8BD48C433C8;
        Fri,  7 Jul 2023 17:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688749868;
        bh=3OYXRE6Ot9Ype6mtCR9io7G6N31R1sHqQqEJ3rFGnPU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Qf+sXfpO8qRoZCwNQsehudWAYZtTuFE8dUlx+J5522yXB0t9Ot/RzLTxtN4hYHVS5
         zAOVuB/OdO23dwISgu9zfwVlTfOy+FHlVuf1kld/puvkfSWMeJL7abkNyGeh3kRJO6
         zjmm9WAh3wMIw/1wrTodUrZZnVxawABDoKsfF9K1J5SMxFUCDZ3W0ISgJpATy3ysfw
         +0UJX3r5Hbv0SSHQBtrnk4uDm4Q/ZohS47kuStlP842rt7fA7UE7IRWCRLUKYe9f36
         JZFxIyr67vsdg1FftX/oKIP63YfiFNKmOzGkSBOTP0u9B2glHawRNFHRIUtU1kI38c
         l5nx7AzIXsAGA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 791ABC4167B;
        Fri,  7 Jul 2023 17:11:08 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.5-2 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <875y6vluoh.fsf@mail.lhotse>
References: <875y6vluoh.fsf@mail.lhotse>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <875y6vluoh.fsf@mail.lhotse>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.5-2
X-PR-Tracked-Commit-Id: abaa02fc944f2f9f2c2e1925ddaceaf35c48528c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 22dcc7d77fa463914bc2a2fb4580e6d183ca415d
Message-Id: <168874986849.21562.9091829766126316645.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Jul 2023 17:11:08 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dianders@chromium.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, pali@kernel.org,
        rdunlap@infradead.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 07 Jul 2023 23:26:06 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.5-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/22dcc7d77fa463914bc2a2fb4580e6d183ca415d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
