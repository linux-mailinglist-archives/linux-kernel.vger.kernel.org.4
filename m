Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4BC5FE626
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 02:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiJNATc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 20:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiJNATa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 20:19:30 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A93B17FD75
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 17:19:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 23A9FCE243B
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 00:19:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DBD7C433D6;
        Fri, 14 Oct 2022 00:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665706764;
        bh=uBGWHUZffcvH4jKESV4GZXVVeZ9fpDVjffjUSmnxNMM=;
        h=From:To:Cc:Subject:Date:From;
        b=fp6jGSLHOo6Yqia/gnYurcaEQZa+a2qYqpTAmVAXSCDJpLFR67wWc3i8JqJEWVsv2
         JE6qIt6flDin54nKFWJZ2a0+JhT7P2e++LLlyLz8cxCCZlEkQIHaT9lC89ht43ZXqX
         AqQhHNEAc2j2E4clJQvcUULnir6YCoRrg0FnBT/ZD/OO4G7YsfTeMttGRDsYiJVTuU
         IbSv9J2BuGN65XpeuLpKcSBb556kXpHvbiYZkyVBXDvJcABEyNN7Fm1M0zLphkQ9F+
         VmXt6Lj/VSTsNm94bXTj4oaQcpzMe6nbyPc5gdWKH6xqtiCXVrkPChHd3Ure/Z8pm6
         q+vDeyMMRt+rQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/3] Remove unused SLOW_DOWN_IO
Date:   Thu, 13 Oct 2022 19:19:08 -0500
Message-Id: <20221014001911.3342485-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Only alpha, ia64, and sh define SLOW_DOWN_IO, and there are no uses of it.
Remove them all.

These were previously posted at
https://lore.kernel.org/all/20220415190817.842864-1-helgaas@kernel.org/

Bjorn Helgaas (3):
  sh: remove unused SLOW_DOWN_IO
  ia64: remove unused __SLOW_DOWN_IO and SLOW_DOWN_IO definitions
  alpha: remove unused __SLOW_DOWN_IO and SLOW_DOWN_IO definitions

 arch/alpha/include/asm/io.h |  4 ----
 arch/ia64/include/asm/io.h  |  4 ----
 arch/sh/include/asm/io.h    | 17 ++---------------
 3 files changed, 2 insertions(+), 23 deletions(-)

-- 
2.25.1

