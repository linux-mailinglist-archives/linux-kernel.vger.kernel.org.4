Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 324796390D4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 21:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiKYUsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 15:48:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiKYUsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 15:48:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1B727147;
        Fri, 25 Nov 2022 12:48:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1AA0360E9C;
        Fri, 25 Nov 2022 20:48:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79C78C433D6;
        Fri, 25 Nov 2022 20:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669409314;
        bh=TATGHwB7xBd9ArAnJsTaMk1P+5Zzj5vCxD/NRTaBBL4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XrcQf7nWMEAJ1N88RUjCqAJxBXPPrA2+P8wpUXoaibfxxeT+D87xI5QWcrB4n6g0o
         VwDyUL3vEnjtADBQ9FB9V9gdfuB6z3yTvgVqRC02I1qoYoo1mVVJpFaEDZqt//hXjN
         kCM3w6++k/fndbocPozJanGEdVxPqTLffhHwcGvOAIthqNKRXfEu3tl4WlHcAsCnWW
         jLon8YXRb/neZbIV1MitlA9RfHGYl9Sl524I6Ej1xpavCEpcvwY6yArPRgDRCYFsiI
         kRIVzav9UoVlS1Kqka2Kr0PKpNY8u/X3lvQlZqytSKz9Fk6UIfMb55sFVz6Gcp9Psu
         +5XNCSRZrubAQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 64B20E270C7;
        Fri, 25 Nov 2022 20:48:34 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 6.1-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y4DqhTPzzIz+GiyO@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
References: <Y4DqhTPzzIz+GiyO@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y4DqhTPzzIz+GiyO@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.1-6
X-PR-Tracked-Commit-Id: adba1a9b81d5020a9bf8332fee9ff0171fe7623d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e3ebac80b6e9efe47b0ac3bf4b2d800b0b1958ff
Message-Id: <166940931440.23524.16829188065171648049.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Nov 2022 20:48:34 +0000
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 25 Nov 2022 17:17:09 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.1-6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e3ebac80b6e9efe47b0ac3bf4b2d800b0b1958ff

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
