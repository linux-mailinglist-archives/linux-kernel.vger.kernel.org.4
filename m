Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9C4675454
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 13:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjATMXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 07:23:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjATMXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 07:23:53 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F02B07DFBD
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 04:23:51 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5277814BF;
        Fri, 20 Jan 2023 04:24:33 -0800 (PST)
Received: from e120937-lin.. (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E73EF3F71A;
        Fri, 20 Jan 2023 04:23:50 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, Cristian Marussi <cristian.marussi@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] firmware: arm_scmi: Clarify Raw per-channel ABI documentation
Date:   Fri, 20 Jan 2023 12:23:26 +0000
Message-Id: <20230120122326.1932614-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Explain more in detail how the per-channel <m> identifier is chosen.

Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 Documentation/ABI/testing/debugfs-scmi-raw | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/debugfs-scmi-raw b/Documentation/ABI/testing/debugfs-scmi-raw
index 5468ec08c084..b1c505ed444c 100644
--- a/Documentation/ABI/testing/debugfs-scmi-raw
+++ b/Documentation/ABI/testing/debugfs-scmi-raw
@@ -80,9 +80,13 @@ Description:	SCMI Raw synchronous message injection/snooping facility; write
 		Each write to the entry causes one command request to be built
 		and sent while the replies are read back one message at time
 		(receiving an EOF at each message boundary).
+		Channel identifier <m> matches the SCMI protocol number which
+		has been associated with this transport channel in the DT
+		description, with Base protocol number 0x10 being the default
+		channel for this instance.
 		Note that these per-channel entries rooted at <..>/channels
 		exist only if the transport is configured to have more than
-		one channel.
+		one default channel.
 Users:		Debugging, any userspace test suite
 
 What:		/sys/kernel/debug/scmi/<n>/raw/channels/<m>/message_async
@@ -103,7 +107,11 @@ Description:	SCMI Raw asynchronous message injection/snooping facility; write
 		Each write to the entry causes one command request to be built
 		and sent while the replies are read back one message at time
 		(receiving an EOF at each message boundary).
+		Channel identifier <m> matches the SCMI protocol number which
+		has been associated with this transport channel in the DT
+		description, with Base protocol number 0x10 being the default
+		channel for this instance.
 		Note that these per-channel entries rooted at <..>/channels
 		exist only if the transport is configured to have more than
-		one channel.
+		one default channel.
 Users:		Debugging, any userspace test suite
-- 
2.34.1

