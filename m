Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41410740767
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 03:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjF1BBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 21:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbjF1BBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 21:01:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303F3297A;
        Tue, 27 Jun 2023 18:01:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 890346123F;
        Wed, 28 Jun 2023 01:01:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EEB88C433CA;
        Wed, 28 Jun 2023 01:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687914081;
        bh=s8TuhGgCWpwhVVNsNOJ3ANfg789tncO30W5ezzx9ToI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jIKMKAUmG9E0VxXHZqEZHva87pt25vxyjAToOzfbWQOUckm9RyY192+OKgSMWM8qR
         4+NYIX08wKVWGGjKyJu4xjH91j8u43PKTyHNWog8ObO6xaIDPu2RD0KC+cCDJZo5DD
         bjFL67hINeWnCEk8GIsrZuCX4A4iy/VrsUKsJMGNA8RMzXT/MSsZhpVbE4ej26Is7y
         lXdUKeUM4wKWtv34cLNuQSFAIuXYifF/FO66sGsyK8ZWIhXKpoQIqMWD2OYLE2LQsI
         RXQsLUrVLHfe6Elozh7G1zfaK/j+83OClk+vTKZhXnOZgQFbS8LcHmP0/itPD1jiog
         jUTocSxQw5XLg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D96AEE53807;
        Wed, 28 Jun 2023 01:01:20 +0000 (UTC)
Subject: Re: [GIT PULL] Smack patches for 6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <3b1107c2-77c1-28ce-3413-bec589eae083@schaufler-ca.com>
References: <3b1107c2-77c1-28ce-3413-bec589eae083.ref@schaufler-ca.com> <3b1107c2-77c1-28ce-3413-bec589eae083@schaufler-ca.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <3b1107c2-77c1-28ce-3413-bec589eae083@schaufler-ca.com>
X-PR-Tracked-Remote: https://github.com/cschaufler/smack-next tags/Smack-for-6.5
X-PR-Tracked-Commit-Id: 2c085f3a8f23c9b444e8b99d93c15d7ce870fc4e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 98be618ad03010b1173fc3c35f6cbb4447ee2b07
Message-Id: <168791408088.14121.6264904620933008086.pr-tracker-bot@kernel.org>
Date:   Wed, 28 Jun 2023 01:01:20 +0000
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 27 Jun 2023 08:01:44 -0700:

> https://github.com/cschaufler/smack-next tags/Smack-for-6.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/98be618ad03010b1173fc3c35f6cbb4447ee2b07

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
