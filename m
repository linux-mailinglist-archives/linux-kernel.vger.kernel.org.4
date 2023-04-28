Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12EB96F2133
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 01:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347032AbjD1Xgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 19:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346876AbjD1Xgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 19:36:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39ED949DA
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 16:36:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C94F763867
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 23:36:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 29A93C433EF;
        Fri, 28 Apr 2023 23:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682724996;
        bh=XurUeSlKNZhVDNCbTUd5IhHGXcISaZBPu0X6iMHWDyU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Z09KZHaXYwwXqLnSU87OqwCRhZX8tkXeIx2cFI6m7gwbhOQ0MvQ9MMq6aNs7wMxmd
         rOLzypJN3YFkxZVtSbjy3xwshJfzVtdNypi6GQ0aILJ0sQ4GGJQWTcvwOj6LuXAfyR
         lCj0ZbUO+N0lvHYNd8/9SXTr215wOYreFrrlLTFEePhRN2syPHPzAIcEzOM7o5qhHK
         3sTBgrs3en/ow9XJQ42LZoEai4eeLn/K8U3Sq+6Bn4d24Cq0pn/JR4f0yqx7bAXsSO
         RTEFuOj6es/t46B9rQkKcJfBEVdd465nlhesrzDhsdvCrPFEUzn68TLAYu6iCQWUao
         u4ihpsFQYvIVg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 13E55C41677;
        Fri, 28 Apr 2023 23:36:36 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.4-1 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87fs8k734t.fsf@mail.concordia>
References: <87fs8k734t.fsf@mail.concordia>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <87fs8k734t.fsf@mail.concordia>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.4-1
X-PR-Tracked-Commit-Id: 169f8997968ab620d750d9a45e15c5288d498356
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 70cc1b5307e8ee3076fdf2ecbeb89eb973aa0ff7
Message-Id: <168272499607.24865.5167458035940101849.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Apr 2023 23:36:36 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, arkamar@atlas.cz,
        aik@ozlabs.ru, paul.gortmaker@windriver.com, bgray@linux.ibm.com,
        ira.weiny@intel.com, robh@kernel.org, mikey@neuling.org,
        windhl@126.com, tpearson@raptorengineering.com,
        nicholas@linux.ibm.com, joel@jms.id.au, liubo03@inspur.com,
        kconsul@linux.vnet.ibm.com, nathanl@linux.ibm.com,
        ajd@linux.ibm.com, kjain@linux.ibm.com, npiggin@gmail.com,
        nathan@kernel.org, alex.williamson@redhat.com, pali@kernel.org,
        rdunlap@infradead.org, linux-kernel@vger.kernel.org,
        leoyang.li@nxp.com, mcgrof@kernel.org, nysal@linux.ibm.com,
        seanjc@google.com, linuxppc-dev@lists.ozlabs.org
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 28 Apr 2023 19:44:02 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.4-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/70cc1b5307e8ee3076fdf2ecbeb89eb973aa0ff7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
