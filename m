Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D5E6F1D53
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 19:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346418AbjD1RXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 13:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345888AbjD1RXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 13:23:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08AB944B6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 10:23:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 84B08644D0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 17:23:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB387C433A4;
        Fri, 28 Apr 2023 17:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682702589;
        bh=xfUuoos1E74ke3s2WSPb60v+SvUU0kQ/t4ISa0IkK20=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=dSWVd/OjbnhrvwA0mqUI03cNoNNCMJfxSbNnaFFsvh4SZS0928j2S8/fuSPSOpuRg
         NsrghpGnGsdfEpf9sCfaUiA/hUX7C8J1d5Jp3kJ++mb5Er+Ppm1WHLF9An01Ya+6Ku
         mGVHsvlpsDF9GT+epr8Yb8loQGV0vM2/wdVY8hXkCp15w8bMDbotMybQY5FQ07XDHf
         JShKgedYV8+71kWD2VdEG2ufY+aIO0hKZa1XBBPu+Qw95JbCNbGs/vJl1EK7l9eEx4
         9CJYKbnov3+eQ1LPpyjf8u+YDCJY+vwPU9WqKfHp/RNSE0K6A63Xa3mmF6k4Smw3l3
         13OTA2EnAKIuA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D1D13C3959E;
        Fri, 28 Apr 2023 17:23:08 +0000 (UTC)
Subject: Re: [GIT PULL] x86/tdx for 6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230427181548.1070481-1-dave.hansen@linux.intel.com>
References: <20230427181548.1070481-1-dave.hansen@linux.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230427181548.1070481-1-dave.hansen@linux.intel.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/daveh/devel.git tags/test.1682619270.x86_tdx_for_6.4
X-PR-Tracked-Commit-Id: 7a3a401874bea02f568aa416ac29170d8cde0dc2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7b664cc38ea7bdd5e3ce018bba98583741921bd4
Message-Id: <168270258885.30920.7012030243958003583.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Apr 2023 17:23:08 +0000
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     torvalds@linux-foundation.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 27 Apr 2023 11:15:48 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/daveh/devel.git tags/test.1682619270.x86_tdx_for_6.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7b664cc38ea7bdd5e3ce018bba98583741921bd4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
