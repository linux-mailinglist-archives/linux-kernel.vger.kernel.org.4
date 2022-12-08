Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942C1646695
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 02:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiLHBlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 20:41:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiLHBlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 20:41:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299764E432
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 17:41:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C68FCB8212E
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 01:41:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73B2EC433C1;
        Thu,  8 Dec 2022 01:41:04 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1p35uJ-000FRx-18;
        Wed, 07 Dec 2022 20:41:03 -0500
Message-ID: <20221208014041.842742311@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 07 Dec 2022 20:40:41 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     "John Warthog9 Hawley" <warthog9@kernel.org>
Subject: [for-next][PATCH 0/2] ktest.pl: Fixes for 6.2
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-ktest.git
for-next

Head SHA1: 26df05a8c1420ad3de314fdd407e7fc2058cc7aa


Steven Rostedt (2):
      ktest.pl minconfig: Unset configs instead of just removing them
      kest.pl: Fix grub2 menu handling for rebooting

----
 tools/testing/ktest/ktest.pl | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)
