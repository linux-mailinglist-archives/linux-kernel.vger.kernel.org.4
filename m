Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73215670FEA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 02:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjARBWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 20:22:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjARBVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 20:21:31 -0500
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB561968E;
        Tue, 17 Jan 2023 17:21:06 -0800 (PST)
Received: from ([60.208.111.195])
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id NSN00103;
        Wed, 18 Jan 2023 09:21:03 +0800
Received: from localhost.localdomain (10.200.104.82) by
 jtjnmail201619.home.langchao.com (10.100.2.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 18 Jan 2023 09:21:04 +0800
From:   Deming Wang <wangdeming@inspur.com>
To:     <sujith.thomas@intel.com>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>
CC:     <amitk@kernel.org>, <rui.zhang@intel.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Deming Wang <wangdeming@inspur.com>
Subject: [PATCH] thermal/intel: Modify function description
Date:   Tue, 17 Jan 2023 20:20:57 -0500
Message-ID: <20230118012057.4423-1-wangdeming@inspur.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.200.104.82]
X-ClientProxiedBy: Jtjnmail201615.home.langchao.com (10.100.2.15) To
 jtjnmail201619.home.langchao.com (10.100.2.19)
tUid:   20231180921042494a59269222f7e9b3d9b6437df51cb
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the wrong description and add the corresponding description.

Signed-off-by: Deming Wang <wangdeming@inspur.com>
---
 drivers/thermal/intel/intel_menlow.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/intel/intel_menlow.c b/drivers/thermal/intel/intel_menlow.c
index 3f885b08a490..5a6ad0552311 100644
--- a/drivers/thermal/intel/intel_menlow.c
+++ b/drivers/thermal/intel/intel_menlow.c
@@ -232,9 +232,9 @@ static DEFINE_MUTEX(intel_menlow_attr_lock);
 
 /*
  * sensor_get_auxtrip - get the current auxtrip value from sensor
- * @name: Thermalzone name
- * @auxtype : AUX0/AUX1
- * @buf: syfs buffer
+ * @handle: Object handle
+ * @index : GET_AUX1/GET_AUX0
+ * @value : The address will be fill by the value
  */
 static int sensor_get_auxtrip(acpi_handle handle, int index,
 							unsigned long long *value)
@@ -254,9 +254,9 @@ static int sensor_get_auxtrip(acpi_handle handle, int index,
 
 /*
  * sensor_set_auxtrip - set the new auxtrip value to sensor
- * @name: Thermalzone name
- * @auxtype : AUX0/AUX1
- * @buf: syfs buffer
+ * @handle: Object handle
+ * @index : GET_AUX1/GET_AUX0
+ * @value : The value will be set
  */
 static int sensor_set_auxtrip(acpi_handle handle, int index, int value)
 {
-- 
2.27.0

