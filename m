Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D63D74412B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 19:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbjF3RZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 13:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233208AbjF3RYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 13:24:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A333919AF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 10:24:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB598618F2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 17:23:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1D39DC433C0;
        Fri, 30 Jun 2023 17:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688145835;
        bh=4KZpDBMjgtsDbjCKv/Gbyt2RHGrPJMISMi8TtypstTw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=A/6BTFen1JqA/6VbKwB8ojVdwRRmwPB40u+7GblrxXhQwxZXwXswT6stNKOAipcMX
         vSrDbY9Vu+1SfuLRNXh9nyK3RSoXOnKBZmmCZbKRxEfGysu43/tB8pwQMAsNnLWBW0
         EEAq5uyc8KaN19ygmH4CnwMkCRTM0urxjnJgPFhIerLcPUPg7tKS1Gv1jEOTjiWFva
         rS51hN3PCHl019MRQHDNlJ5Rf2m9IJo5JxS2f/pYJUNg+ZNsjJSblWuLVDTcBDdYWS
         HnO10dN2MeaUcI/FzyvnOHFyRXkqi20dJBtFuvzrQhOHz6aoR5r/TozLV8621GY8ni
         xryCE7FRPw1aw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 07E18C43158;
        Fri, 30 Jun 2023 17:23:55 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.5-1 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <877crlgrdl.fsf@mail.lhotse>
References: <877crlgrdl.fsf@mail.lhotse>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <877crlgrdl.fsf@mail.lhotse>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.5-1
X-PR-Tracked-Commit-Id: 54a11654de163994e32b24e3aa90ef81f4a3184d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d8b0bd57c2d68eb500f356f0f9228e6183da94ae
Message-Id: <168814583502.9404.7781714394572409298.pr-tracker-bot@kernel.org>
Date:   Fri, 30 Jun 2023 17:23:55 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, trix@redhat.com,
        paul.gortmaker@windriver.com, bgray@linux.ibm.com,
        adityag@linux.ibm.com, robh@kernel.org, arnd@arndb.de,
        aneesh.kumar@linux.ibm.com, masahiroy@kernel.org,
        nayna@linux.ibm.com, tpearson@raptorengineering.com,
        geert@linux-m68k.org, joel@jms.id.au,
        u.kleine-koenig@pengutronix.de, naveen.n.rao@linux.vnet.ibm.com,
        colin.i.king@gmail.com, elver@google.com,
        gbatra@linux.vnet.ibm.com, naveen@kernel.org, npiggin@gmail.com,
        rmclure@linux.ibm.com, jcmvbkbc@gmail.com, rdunlap@infradead.org,
        ndesaulniers@google.com, linux-kernel@vger.kernel.org,
        jarkko@kernel.org, linuxppc-dev@lists.ozlabs.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 30 Jun 2023 20:45:58 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.5-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d8b0bd57c2d68eb500f356f0f9228e6183da94ae

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
