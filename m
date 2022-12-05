Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE8C6426F7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 11:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbiLEKyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 05:54:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiLEKyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 05:54:33 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98ED19016
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 02:54:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V3iiqocOncFbH4yYkFRmHQtdhJFEW6N5MX8d2Iamwn9DYRP61r6uJl1M8IoPI5lTwRvtZ6tvJ31EmWpbZctlqjwmTq5pAOs252ASoEj18OOTafsUPTbtTivlUOxNMOMd2O1vhWSHbJjip+u/ChldXYY+qZfVaM0IS2kVyg4Y6a2mjELjvu7VXSrHwPraRjSkHf+NjrSyuMOaSuVX5DOBPpthdsXu0d6eQ2xJZG8UqEMseQuGcZeEGgbImWBSOdVgaZ68NSEFbn3uufyrWE7ajPTFFyTfk+RroTdqrgGCbFG9/g1albh5qnM1RYL4ZC51joHUSYZ21vm0zmSK2PkXCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+GkIRKYtBUi1XSOGmh2wwAycFw1LhTdG5ETce4c0W0c=;
 b=X+SOaRDGY+qiwdlacQ8Sn73SS/CF0UUOtDbH/tOzgtX79r0yusL7tuZt7FxSyaXsHwFPcWQHNcUGN+wH5U+1AyXi7nCsjmDXhTPoYdsLEGbu3thGv5sGs5hpT3DnHr2lo0NwhhrFkvmexKaWP6vVDI8hArU6drYxGv+RSjQkDHT8MetO0/HiwHDFJeeHlnu303HmwnbCVahdbime0M0+7ofo7LAa4rIllDNqr1QWYC3LmGFoQvohk0uhNhQCy0/SkMZZ4ta+sZ3/5Cn02W5olaZvQ/gSJwdJHq1GJSi76CUOCaTp7yfTjX+7GhHjTKP8JipGSdrR/J2280gwSFryLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+GkIRKYtBUi1XSOGmh2wwAycFw1LhTdG5ETce4c0W0c=;
 b=4YqlBNUYDKm2oh1pETA9JlGGWSUlooqTaNmvLGHrh/Ju0eBZgEbfxz7Ca2FrCyubI4bYvQ5StKYmArpHKwyrVkcjMnqrzHy4wHgvCjUoyDN46v9HvzhaERGecWOQgF9MYVn2u/DaHJ2pnoXoTrlRl5YdTwFMyUNPy36bVrkQlFc=
Received: from DM6PR21CA0023.namprd21.prod.outlook.com (2603:10b6:5:174::33)
 by SJ2PR12MB8034.namprd12.prod.outlook.com (2603:10b6:a03:4c7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Mon, 5 Dec
 2022 10:54:30 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::26) by DM6PR21CA0023.outlook.office365.com
 (2603:10b6:5:174::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.4 via Frontend
 Transport; Mon, 5 Dec 2022 10:54:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5880.14 via Frontend Transport; Mon, 5 Dec 2022 10:54:30 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 5 Dec
 2022 04:54:27 -0600
From:   Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
To:     <linux-i3c@lists.infradead.org>, <alexandre.belloni@bootlin.com>
CC:     <linux-kernel@vger.kernel.org>, <boris.brezillon@collabora.com>,
        "Naveen Krishna Chatradhi" <nchatrad@amd.com>,
        Akshay Gupta <Akshay.Gupta@amd.com>
Subject: [PATCH] i3c: Correct the macro module_i3c_i2c_driver
Date:   Mon, 5 Dec 2022 10:54:13 +0000
Message-ID: <20221205105413.937704-1-naveenkrishna.chatradhi@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT033:EE_|SJ2PR12MB8034:EE_
X-MS-Office365-Filtering-Correlation-Id: ac72c8c1-d869-46ae-3c08-08dad6af15e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OUsxMlssuP+yoUGKbVWQbLEOpQu5vPpsPE8ydoCwUraguSb8Vbo/N1Qk39Zww5JXqXU4+/JXjZpYGcojE8TlGgmOPBGgs9Rz5rAXx3Sr5fX1Bh8Z3GGmJ9RyCZp9uTfHyf8zcwk2reHL939VLj5Zv0CqvwlvF/tiK7jOavULk/8k+pF86XoyTGrlyW6MykIg/dAQcuadtij9L9vt0njgSzWrboUBZ/B3degN+AgDecJkfQziBPAHB3XSVRnNicLxBdh+2ypUoQTpMZ80s+TbKyBm+rGEHFFAivIl0os/cRpEc6Xg5I6B6vP7909+ZrA7WjBejVifFlHp0iYtspkfNcVDoycOzDfngVBtpcbsAhqH2XPO/Ns/UG7kUzWuepvBkcXBZmTDmGTLfpwhpXvCzOp2G4S/mHcqb4rP/rLCMPJWtjqvIjjwC92oX1i6I8zkOLWUkWLSBz6Mq/ahkuWB90/FpV53m7KLqnrBiUL702M7EJ6OOc8fp/hSmTX5Xxua2EG6fYfHnQpvovvbplD8DHvUaW8T5vk+kQDj5lfG7vXc+5AXMVtDI4GjRV7f31y3HyNucRhxPoYPBGQQJBBHpaIPRr08mC4YLuorArLzYXOukdwL1wu30vNK9JEU5HrqKjlVgLd1xAvwARnIe1Znn78ukuD/LWYpFyXNoppyxNyaYmbfQr+cChVehoW8Ro2jylnSuvuYkGceTXMmVIDHZP0mTx8sw6OTexFP7FOlu5n4alWX+xXPAa/8fncoNkFd6JbC82llNFUUHeK6+FM2zw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(186003)(26005)(7696005)(8676002)(478600001)(6666004)(47076005)(426003)(1076003)(41300700001)(5660300002)(8936002)(336012)(2616005)(4326008)(2906002)(36860700001)(70586007)(83380400001)(16526019)(81166007)(82740400003)(36756003)(40460700003)(70206006)(356005)(316002)(82310400005)(110136005)(86362001)(54906003)(40480700001)(70780200001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 10:54:30.0334
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac72c8c1-d869-46ae-3c08-08dad6af15e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8034
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naveen Krishna Chatradhi <nchatrad@amd.com>

Present definition for module_i3c_i2c_driver uses only the
1st argument i.e., struct i3c_driver.
Irrespective of CONFIG_I3C being enabled/disabled,
struct i2c_driver is never passed to module_driver()

Passing struct i2c_driver as the 4th argument works.

Signed-off-by: Akshay Gupta <Akshay.Gupta@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
---
 include/linux/i3c/device.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/i3c/device.h b/include/linux/i3c/device.h
index 8242e13e7b0b..419192b5cc4d 100644
--- a/include/linux/i3c/device.h
+++ b/include/linux/i3c/device.h
@@ -287,7 +287,8 @@ static inline void i3c_i2c_driver_unregister(struct i3c_driver *i3cdrv,
 #define module_i3c_i2c_driver(__i3cdrv, __i2cdrv)	\
 	module_driver(__i3cdrv,				\
 		      i3c_i2c_driver_register,		\
-		      i3c_i2c_driver_unregister)
+		      i3c_i2c_driver_unregister,	\
+		      __i2cdrv)
 
 int i3c_device_do_priv_xfers(struct i3c_device *dev,
 			     struct i3c_priv_xfer *xfers,
-- 
2.25.1

