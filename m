Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02CEB659052
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 19:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234005AbiL2SYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 13:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233937AbiL2SYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 13:24:12 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 111F513F5F
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 10:24:10 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C091169C;
        Thu, 29 Dec 2022 10:24:51 -0800 (PST)
Received: from e120937-lin.. (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 997C03F71A;
        Thu, 29 Dec 2022 10:24:07 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, wleavitt@marvell.com,
        peter.hilber@opensynergy.com, nicola.mazzucato@arm.com,
        tarek.el-sherbiny@arm.com, quic_kshivnan@quicinc.com,
        cristian.marussi@arm.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v6 09/17] debugfs: Export debugfs_create_str symbol
Date:   Thu, 29 Dec 2022 18:22:45 +0000
Message-Id: <20221229182253.948175-10-cristian.marussi@arm.com>
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

Needed by SCMI Raw mode support when compiled as a loadable module.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
Used by the following patch in this series:

"firmware: arm_scmi: Populate a common SCMI debugsfs root"

SCMI stack can be configured as module so export is needed.
---
 fs/debugfs/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index b54f470e0d03..1f971c880dde 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -899,6 +899,7 @@ ssize_t debugfs_read_file_str(struct file *file, char __user *user_buf,
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(debugfs_create_str);
 
 static ssize_t debugfs_write_file_str(struct file *file, const char __user *user_buf,
 				      size_t count, loff_t *ppos)
-- 
2.34.1

