Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5509C5F59FE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 20:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbiJESmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 14:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbiJESlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 14:41:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCB980F72;
        Wed,  5 Oct 2022 11:40:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 04BEEB81F06;
        Wed,  5 Oct 2022 18:40:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AAFCEC43470;
        Wed,  5 Oct 2022 18:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664995209;
        bh=BDpXFEAbf4odb5EKqUXdyMM4VTNVj9XzFS8JqeLfAG8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TPRz575sDeVhlg0UOMbqZ711x6282gAyrhDIE0gUkTFLbHBh+ip8DcSs8rDlVyDcT
         f9RyaoCjpMTbV22w0sqYCb9VBJcRzdxNSmfuq1peXc0B03vFH1j3SNHOKxAj0lwhb+
         Zq5LWzg/N/9SQC8l9JpQvYL3j+a03H+kn+4JVCM+Aa6Fh4Xv0+h/kYXH/pehqL5BDM
         IliwTiwe8Aytc1ywl47oxb2E6nu8d13dyzLWkxBL4JNEMGxqkUgAjvh36cVShqILtc
         e1QaNKtDmZusWDrMdV+uadaXX4k8OjxKEdhRHra3kedTtes5rZJ0IXJwfErJoQGo0x
         01ZWFym1AYkKw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 96FB3E21ED4;
        Wed,  5 Oct 2022 18:40:09 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for 6.1-1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <b23c765b-4999-17a4-d89a-55d6ba72f68d@redhat.com>
References: <b23c765b-4999-17a4-d89a-55d6ba72f68d@redhat.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <b23c765b-4999-17a4-d89a-55d6ba72f68d@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.1-1
X-PR-Tracked-Commit-Id: 8d05fc039456517d2c246c7b202891188ba40c4d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7fb68b6c821be7165d5be5d8801d909912af9159
Message-Id: <166499520961.1673.4800430495926774854.pr-tracker-bot@kernel.org>
Date:   Wed, 05 Oct 2022 18:40:09 +0000
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mark Gross <mark.gross@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-acpi <linux-acpi@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 5 Oct 2022 14:46:47 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.1-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7fb68b6c821be7165d5be5d8801d909912af9159

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
