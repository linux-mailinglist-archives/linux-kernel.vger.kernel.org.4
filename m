Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8762664C2F9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 05:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237670AbiLNECp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 23:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237097AbiLNECN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 23:02:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551F1222A4;
        Tue, 13 Dec 2022 20:02:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0E4CCB8168A;
        Wed, 14 Dec 2022 04:02:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C56C6C433EF;
        Wed, 14 Dec 2022 04:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670990522;
        bh=jV/Tuisxoid+ZgkBs8kLVAFtPvrsk0GT90M5VDPk/co=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cbgk+pCI/fRKBQOirqgiziv5878pzHYvpJeMKOn8XODOcjkYxuC152XSPsGyilbKG
         Y5qrENXhzJPBpxwvepm1YbRVMA2sgx69PTKzVMhym0sW6Se1ok3wEzkeJxFF0xtSO+
         zcKrsh2jqo5kV48Kjr6GxlI6fV8j7lJHh7ISHtKEVx4Nv0Lo9EcD1i1x3LZrTNS3mK
         5YRXsZUouIXSoWc5EmyN9mlnywkUcc3SH24dlq3uB9/wxUXGpHbwvSfTJygJHWm1in
         opPmUaNHobGEWJBmGb5F22Z1ebkHe97UedoTQnlnRw6yDUiDF2JKNnJJ5/MZqfpurX
         qyfAFv7r5wACQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B5444E29F4D;
        Wed, 14 Dec 2022 04:02:02 +0000 (UTC)
Subject: Re: [GIT PULL] MM updates for 6.2-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221213142614.525a9240506119abc3cef6b6@linux-foundation.org>
References: <20221213142614.525a9240506119abc3cef6b6@linux-foundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221213142614.525a9240506119abc3cef6b6@linux-foundation.org>
X-PR-Tracked-Remote: https://lkml.kernel.org/r/20221207130140.7c014015@canb.auug.org.au Thanks.
X-PR-Tracked-Commit-Id: c45bc55a99957b20e4e0333bcd42e12d1833a7f5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e2ca6ba6ba0152361aa4fcbf6067db71b2c7a770
Message-Id: <167099052273.14158.17876184301328807312.pr-tracker-bot@kernel.org>
Date:   Wed, 14 Dec 2022 04:02:02 +0000
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 13 Dec 2022 14:26:14 -0800:

> https://lkml.kernel.org/r/20221207130140.7c014015@canb.auug.org.au Thanks.

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e2ca6ba6ba0152361aa4fcbf6067db71b2c7a770

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
