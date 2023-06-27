Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D4673EF88
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 02:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjF0ABN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 20:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjF0ABK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 20:01:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD911993
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 17:01:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E49160FB5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 00:01:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DED4CC433C8;
        Tue, 27 Jun 2023 00:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687824068;
        bh=pYt5yj6oTf8z2SMVDcm2LQZuQmxE4x3aqeAJFBnabbA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VFvqpr4iiGHJcrNah7BKmeI4eJFA7f7rWEbQh/s45pt3ERjZzsh1tbTwUUUk0jKbX
         e+DWsJwR6AdgnPFal0XP/80iBTSU3/iurOUIX08SaEdVxlYaIMRe86+ZUWEHIwCNw8
         HFZebAUryMGRaxwuPxXQXXTpjPFnSfm9Xh5Abhk40ilLMGZs0ZIu7ua6pH6x0uK8mC
         fFQ7taX9J7SnDKp+ZvyOMMas2X15yvTqgoTLDKEsPuqq+O7kLdtoCkjlHP8KZNyLnf
         U8u8UjNOoxe+obWgP/XRfoxuu7+Wbp+z+x1XSIKzHFz6HfqUEc67jLdf2DTsl6DIUQ
         l1ribo0An3iQg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C2228E537FE;
        Tue, 27 Jun 2023 00:01:08 +0000 (UTC)
Subject: Re: [GIT PULL] x86/irq for 6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230626183011.1516068-1-dave.hansen@linux.intel.com>
References: <20230626183011.1516068-1-dave.hansen@linux.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230626183011.1516068-1-dave.hansen@linux.intel.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_irq_for_6.5
X-PR-Tracked-Commit-Id: 504dba50b0c3fa02ec513d7d0405ddffba2d1c0a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a3d763f0b34d94a4f2b2e3075350a19d589630f3
Message-Id: <168782406878.12263.12615413267164546472.pr-tracker-bot@kernel.org>
Date:   Tue, 27 Jun 2023 00:01:08 +0000
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     torvalds@linux-foundation.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 26 Jun 2023 11:30:11 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_irq_for_6.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a3d763f0b34d94a4f2b2e3075350a19d589630f3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
