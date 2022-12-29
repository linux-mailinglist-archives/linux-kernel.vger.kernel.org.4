Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1BB7659054
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 19:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233974AbiL2SYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 13:24:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233791AbiL2SYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 13:24:15 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8FE8113F80
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 10:24:14 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C164316F3;
        Thu, 29 Dec 2022 10:24:55 -0800 (PST)
Received: from e120937-lin.. (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 537FB3F71A;
        Thu, 29 Dec 2022 10:24:12 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, wleavitt@marvell.com,
        peter.hilber@opensynergy.com, nicola.mazzucato@arm.com,
        tarek.el-sherbiny@arm.com, quic_kshivnan@quicinc.com,
        cristian.marussi@arm.com
Subject: [PATCH v6 11/17] firmware: arm_scmi: Add debugfs ABI documentation for common entries
Date:   Thu, 29 Dec 2022 18:22:47 +0000
Message-Id: <20221229182253.948175-12-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221229182253.948175-1-cristian.marussi@arm.com>
References: <20221229182253.948175-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add description of the debugfs SCMI common ABI.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 Documentation/ABI/testing/debugfs-scmi | 70 ++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 Documentation/ABI/testing/debugfs-scmi

diff --git a/Documentation/ABI/testing/debugfs-scmi b/Documentation/ABI/testing/debugfs-scmi
new file mode 100644
index 000000000000..ee7179ab2edf
--- /dev/null
+++ b/Documentation/ABI/testing/debugfs-scmi
@@ -0,0 +1,70 @@
+What:		/sys/kernel/debug/scmi/<n>/instance_name
+Date:		March 2023
+KernelVersion:	6.3
+Contact:	cristian.marussi@arm.com
+Description:	The name of the underlying SCMI instance <n> described by
+		all the debugfs accessors rooted at /sys/kernel/debug/scmi/<n>,
+		expressed as the full name of the top DT SCMI node under which
+		this SCMI instance is rooted.
+Users:		Debugging, any userspace test suite
+
+What:		/sys/kernel/debug/scmi/<n>/atomic_threshold_us
+Date:		March 2023
+KernelVersion:	6.3
+Contact:	cristian.marussi@arm.com
+Description:	An optional time value, expressed in microseconds, representing,
+		on this SCMI instance <n>, the threshold above which any SCMI
+		command, advertised to have an higher-than-threshold execution
+		latency, should not be considered for atomic mode of operation,
+		even if requested.
+Users:		Debugging, any userspace test suite
+
+What:		/sys/kernel/debug/scmi/<n>/transport/type
+Date:		March 2023
+KernelVersion:	6.3
+Contact:	cristian.marussi@arm.com
+Description:	A string representing the type of transport configured for this
+		SCMI instance <n>.
+Users:		Debugging, any userspace test suite
+
+What:		/sys/kernel/debug/scmi/<n>/transport/is_atomic
+Date:		March 2023
+KernelVersion:	6.3
+Contact:	cristian.marussi@arm.com
+Description:	A boolean stating if the transport configured on the underlying
+		SCMI instance <n> is capable of atomic mode of operation.
+Users:		Debugging, any userspace test suite
+
+What:		/sys/kernel/debug/scmi/<n>/transport/max_rx_timeout_ms
+Date:		March 2023
+KernelVersion:	6.3
+Contact:	cristian.marussi@arm.com
+Description:	Timeout in milliseconds allowed for SCMI synchronous replies
+		for the currently configured SCMI transport for instance <n>.
+Users:		Debugging, any userspace test suite
+
+What:		/sys/kernel/debug/scmi/<n>/transport/max_msg_size
+Date:		March 2023
+KernelVersion:	6.3
+Contact:	cristian.marussi@arm.com
+Description:	Max message size of allowed SCMI messages for the currently
+		configured SCMI transport for instance <n>.
+Users:		Debugging, any userspace test suite
+
+What:		/sys/kernel/debug/scmi/<n>/transport/tx_max_msg
+Date:		March 2023
+KernelVersion:	6.3
+Contact:	cristian.marussi@arm.com
+Description:	Max number of concurrently allowed in-flight SCMI messages for
+		the currently configured SCMI transport for instance <n> on the
+		TX channels.
+Users:		Debugging, any userspace test suite
+
+What:		/sys/kernel/debug/scmi/<n>/transport/rx_max_msg
+Date:		March 2023
+KernelVersion:	6.3
+Contact:	cristian.marussi@arm.com
+Description:	Max number of concurrently allowed in-flight SCMI messages for
+		the currently configured SCMI transport for instance <n> on the
+		RX channels.
+Users:		Debugging, any userspace test suite
-- 
2.34.1

