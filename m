Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2DFE6DDEAA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 16:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjDKO7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 10:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjDKO7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 10:59:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473DB4482
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 07:59:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D46C36227C
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 14:59:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3B4D9C433EF;
        Tue, 11 Apr 2023 14:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681225170;
        bh=i2/Qc723kOViW0BxpRlb1mKU8KNrzYw2ShBKCGKxB0Q=;
        h=From:To:Subject:Date:From;
        b=UgkJ2LxSDZ9R7EiCsjpbzLvB1YeLj1mmI1K+EdzNs+w6OnmqJsELJnf+L/2Bm6nrc
         71L6H4qZ/b+w39WlB4lsj1dQ9ElyDm8+U0SG54M3TamABDkn1OebOsu20CCWUS+0Ga
         pL7zY0HFXZ4N51oszk+qozSgkODHwatscec7RSvwJe30L+109AE1fRA3szcy/Tx32E
         n11ZwYKYe232TRAJFryoYFGG1dFJt4TKf1W5ybzB0Aumm9fpCKbFlF3DTYdxl0JMu6
         NiSngvIBBE0dk3xthDbb190MeqfGa2QtSqSbgafQJn4ontZ6ZTcmj6cCg2etsEcWXq
         j27hwfpo4q24A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 256D5E52440;
        Tue, 11 Apr 2023 14:59:30 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
From:   "Kernel.org Bugbot" <bugbot@kernel.org>
To:     peterz@infradead.org, mingo@redhat.com, juri.lelli@redhat.com,
        bugs@lists.linux.dev, linux-kernel@vger.kernel.org,
        vincent.guittot@linaro.org
Message-ID: <20230411-b217316c0-82d984fcfefb@bugzilla.kernel.org>
Subject: Interger overflow when calculating imbalance for CFS scheduler
X-Bugzilla-Product: Linux
X-Bugzilla-Component: Kernel
X-Mailer: peebz 0.1
Date:   Tue, 11 Apr 2023 14:59:30 +0000 (UTC)
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tcao34 added a new attachment via Kernel.org Bugzilla.
You can download it by following the link below.

File: bug_report.zip (application/zip)
Size: 9.23 KiB
Link: https://bugzilla.kernel.org/attachment.cgi?id=304105
---
A patch to trace the variables, c files to reproduce the issue

You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (peebz 0.1)

