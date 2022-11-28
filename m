Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2D763B593
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 00:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234534AbiK1XEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 18:04:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiK1XEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 18:04:25 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64632B26B;
        Mon, 28 Nov 2022 15:04:24 -0800 (PST)
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ASM1tJI001979;
        Mon, 28 Nov 2022 23:03:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=pps0720;
 bh=qzkABfP+g0Wxt+cG6aV52+3v2poBBCO9AJCGAzw3bXg=;
 b=m7FesLKn/jPrFzZ9Bkm6LPMADgBPlywEWo8+OTqmRJ/LPqyPXQoTm5FQs3HFew8tM/mC
 L8nJDZCgCHbmbZ1yB6DHiX3wrjAyAF8NQEdq3QJcTlAaXcpsp69oNp0xro7Jc6Bph4XO
 gkkMuKogMn/JTGtOXyJZmS/DLmgVAFhCn4PpDm2CFmrBbPCSVo4GQkkQIcwd+/2L6lVp
 Vk113zV45dgYMXYZKdmuGfcfOS/mCDqRYhQogIfvxy0EWZCVKDV4I12+G8NVor6rUxXw
 eab9eHu8+SH2YPiJGRL2N08mef774IS/EqrRw4+3mi3B4hjca1HFEEt91ogjdrA8xXW/ xQ== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3m50bd2smb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Nov 2022 23:03:49 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id DE1A1801ACA;
        Mon, 28 Nov 2022 23:03:48 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 501C280B37B;
        Mon, 28 Nov 2022 23:03:48 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, verdun@hpe.com,
        nick.hawkins@hpe.com, corbet@lwn.net, linux@armlinux.org.uk,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/6] ABI: sysfs-class-hwmon: add a description for fanY_fault
Date:   Mon, 28 Nov 2022 17:02:15 -0600
Message-Id: <20221128230219.39537-3-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221128230219.39537-1-nick.hawkins@hpe.com>
References: <20221128230219.39537-1-nick.hawkins@hpe.com>
X-Proofpoint-GUID: jBNy7-NfQBYFiY9H8tmybTqFfHqOlnyW
X-Proofpoint-ORIG-GUID: jBNy7-NfQBYFiY9H8tmybTqFfHqOlnyW
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-28_17,2022-11-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 adultscore=0 mlxscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211280166
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

The fans are capable of reporting a fault to the CPLD controller which
then reports it to the GXP SoC via PLREGS. This patch enables hwmon to
be able to report these failures up to the HOST OS.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>

---

v2:
 *No change
---
 Documentation/ABI/testing/sysfs-class-hwmon | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-hwmon b/Documentation/ABI/testing/sysfs-class-hwmon
index 7271781a23b2..638f4c6d4ec7 100644
--- a/Documentation/ABI/testing/sysfs-class-hwmon
+++ b/Documentation/ABI/testing/sysfs-class-hwmon
@@ -276,6 +276,15 @@ Description:
 
 		RW
 
+What:		/sys/class/hwmon/hwmonX/fanY_fault
+Description:
+		Reports if a fan has reported failure.
+
+		- 1: Failed
+		- 0: Ok
+
+		RO
+
 What:		/sys/class/hwmon/hwmonX/pwmY
 Description:
 		Pulse width modulation fan control.
-- 
2.17.1

