Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078816F0A99
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 19:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244358AbjD0RQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 13:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244354AbjD0RQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 13:16:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C623749E1;
        Thu, 27 Apr 2023 10:16:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C9FB63DCE;
        Thu, 27 Apr 2023 17:16:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A7F45C433EF;
        Thu, 27 Apr 2023 17:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682615762;
        bh=Ta2bijUwmvOXeEB367jGZFS3mnAMAif4Pon2PYqBl9I=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=eUmzeFV5jR+oPxdPxBMK29Qpp5yPThcLF5O+3qI4zLBNDcBsuihKHOOTUFzssTXnF
         aMbscfIi9sMWgZRRGpDT5knoPYijsXaHYp2kNBNjco8KO/kSYA8c9V61f5h2Jn3+cS
         44AR2t8TpqNlMlcki9lNdNTb7l8ZnXbzrwl8pxpXEhJJqETSX5hj35epdGIRhLD6Pg
         rBw/vD0EsbkEuV+YkIgx3qSR7qptInP04QgUG1513HKyl1oMicXfPmVEqAwOXSJa0B
         tHvoH6pyp3CNpuzwqZ0d1EOqnbdtnXWVECfqj0snA0zLiMU5wQY2VecKJsT3Q4y52H
         Qm51NdByciRvg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 95B73C43158;
        Thu, 27 Apr 2023 17:16:02 +0000 (UTC)
Subject: Re: [GIT PULL 1/2] Devicetree updates for v6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230425215813.GA2283722-robh@kernel.org>
References: <20230425215813.GA2283722-robh@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230425215813.GA2283722-robh@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-6.4-1
X-PR-Tracked-Commit-Id: 66ae0535167660e427f9fcadeee5d05646e2bb22
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d42b1c47570eb2ed818dc3fe94b2678124af109d
Message-Id: <168261576260.15936.1110513913520247364.pr-tracker-bot@kernel.org>
Date:   Thu, 27 Apr 2023 17:16:02 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 25 Apr 2023 16:58:13 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-6.4-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d42b1c47570eb2ed818dc3fe94b2678124af109d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
