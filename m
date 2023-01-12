Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798926671E4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 13:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234031AbjALMQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 07:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232322AbjALMQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 07:16:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDDEDF5C;
        Thu, 12 Jan 2023 04:16:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B6F16202D;
        Thu, 12 Jan 2023 12:16:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9AD97C433F2;
        Thu, 12 Jan 2023 12:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673525767;
        bh=qKvxqJrQD6gMmrvKxQQZLRkeW/PDtQHGoQSY6zODWEQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fgqf+vuT59VayFnFnX4kDUMknwm2PO7RjK/UPx3MOcWJ4oydbECp/J3bRgHi2/Eni
         Jsxtl6I0c6/rN+vSvHjItWR/YRhp6+nAcReHXHPD8iPeFRhjWC+iZw33UhzKYzS+Be
         V9y6zMz7tjwwLAGGi5yftKlTuV59/hwPOGfJP2UpjfgfsG9wE7bh+jBpOQt1N5RIau
         U5L6ZfN64xyyqecQylUUWCErWQVtSvt6Ns0HjCwzqZUlFRem6XB/uJ6xe7fex+qxeL
         ECVGZqeYIeoCdVgSYN61tQo5YhU1CEF0KWfk5V9kXGdx9gwGXRVmYKaIoDvInoNDLn
         BxKW75HoJpgLA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8267AC395C9;
        Thu, 12 Jan 2023 12:16:07 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.2-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230112113333.DC00AC433D2@smtp.kernel.org>
References: <20230112113333.DC00AC433D2@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230112113333.DC00AC433D2@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.2-rc3
X-PR-Tracked-Commit-Id: b442990d244ba2ffe926c6603c42deb6fcc3b0db
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c757fc92a3f73734872c7793b97f06434773d65d
Message-Id: <167352576753.4374.14190021290932194301.pr-tracker-bot@kernel.org>
Date:   Thu, 12 Jan 2023 12:16:07 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 12 Jan 2023 11:33:19 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.2-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c757fc92a3f73734872c7793b97f06434773d65d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
