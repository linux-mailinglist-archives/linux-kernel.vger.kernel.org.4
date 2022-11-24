Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C171F637DEE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 18:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbiKXRCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 12:02:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiKXRCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 12:02:49 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269CA28E17;
        Thu, 24 Nov 2022 09:02:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T5Ttxe5rm9O9zhrB/SM0kgOCFQWBioV2UJvF3N/ciOupKRywOyXzBfLLG1LFbhFtTvWGCQEDesPdDbxJS68DX9FzPMf47I+RFNEYqhKLwR+T5+s6mxC5v3A+6z2A7TZkWmWhgQ6vP3Uuvip4N7ZQRNOKcK6ir/LgaLIKqXvmXoflnKVt77HVz+gjG7/bsJTstdW7YogJ2jYV0SUOEtIQzjfxFr/KJCqn0kKwmtTzU97gA6/+pdZs69gOKikJfjXB3f2zaLlzXXeouKs/PQUnKsUFi7Ei2dJGNHbfagUMzfgKsHeDf9+ZFEE5CLH8s0IyVuOjqkeGSmwYJSl07S/sPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rCxUi6Ej7HAvB3psTTvfKgksiyqOsMWJpEj0jytfAls=;
 b=hoIFUrTaMurZS0jLUR2JB1Ezs510lYxC5YpyfEyAIU4a/Cnefe4ySN44wtQroLeIV5GtdCO2LPIRglBn8Y8A4zx6yLF8QZYZ0XPTkUmkIA/G/s9vFkATf2TxaJARb3dcZGg8dEFk557clr0hCI6ducC8b20cY8cCKa4c2lN8iqo3N6WD0MQpUZwBpBQjovB3HTue2rQxvfSVKBhov4+RmAdTGWLH9jrVOea3u97e876/Gpa300FzgnDTdylnMKfweZDTg0gWqEXlX2o3OPX88KBDsiKX78m3nXUd8lRYDj8PHwJDBgpthtgPcatYatcmHiET9l+Vm4lcy/RzwY3YrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rCxUi6Ej7HAvB3psTTvfKgksiyqOsMWJpEj0jytfAls=;
 b=OzRkX2QbFUxDtBgn5ujugXrVz8s/IF+NpSbwWxDqXzCbG22GUC7hRLKLc6Y2RcwTE4yE6SM0Im9UMwSLAfirjb1dqU28TPnH/LH35mVVq2TWjqotdU+BpHkwtf3pH2cbD6d7gNbxs2jP+vi/XP6MPo5OCew+SIzxRo/5b+Rixys=
Received: from MW4PR03CA0193.namprd03.prod.outlook.com (2603:10b6:303:b8::18)
 by DS0PR12MB7946.namprd12.prod.outlook.com (2603:10b6:8:151::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.17; Thu, 24 Nov
 2022 17:02:46 +0000
Received: from CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::7d) by MW4PR03CA0193.outlook.office365.com
 (2603:10b6:303:b8::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19 via Frontend
 Transport; Thu, 24 Nov 2022 17:02:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT059.mail.protection.outlook.com (10.13.174.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5857.18 via Frontend Transport; Thu, 24 Nov 2022 17:02:45 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 24 Nov
 2022 11:02:44 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 24 Nov
 2022 11:02:44 -0600
Received: from iron-maiden.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 24 Nov 2022 11:02:43 -0600
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <corbet@lwn.net>, <lukas.bulwahn@gmail.com>, <ojeda@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <bilbao@vt.edu>, Carlos Bilbao <carlos.bilbao@amd.com>
Subject: [PATCH 1/6] docs: Update maintainer of kernel-docs.rst
Date:   Thu, 24 Nov 2022 11:02:37 -0600
Message-ID: <20221124170242.1892751-2-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221124170242.1892751-1-carlos.bilbao@amd.com>
References: <20221124170242.1892751-1-carlos.bilbao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT059:EE_|DS0PR12MB7946:EE_
X-MS-Office365-Filtering-Correlation-Id: eff32887-6a65-4e0b-a337-08dace3db552
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q9TvzAEsBcXVcjrzTApq93Ze5U9DgfdywWnhVLmNjzLJI75R5C4UjRLWQHxdv3uMawmGrPl2T5Bn6fISFjuLVZ1+J/FmOWzQUbw9nw67CD5skP+T/KDZ8Ihn06SBHcqDHq1tLps+H1oW268GhXcJB9K6rwmcN0cgpvL6fuzZoB+DF39UOT1eBHYviMQVY8ChfBAjdbQ/NZRvDzOFza0+bStTaIb53qDEurD1oXqanlqhyoM49D5bAKVscLyjSuW987OMgkxVzjYVBZiFtuE1ANZWMXI9IdmdrVbnGkcYqEym3tVxpusAC6IjmvXXAnE7DIamzkcmDALgJJ39J843JBAVkn8NgfSson0NiOPx0UIfeAAV0X/iEuK3CFe+Janeu10eowZAe0X/A+Fa+cX52QQqmEHosalVDmpQnzwo76sfSAQZ1Gb5O92lz8fI1uBobNdWA3JX+YQh0wTS11DmBdn1IiPH6MwzWM3ih7/t6FQzi/HRatSQJm5Xgfvcj4v9K4oTe+rgzAEjiE8j9VUsuF8gIvdB6u33XpSWwXIL1GtjAFY/h/Ke2JmKk/Qa++Ay1Lu8d76EUd1ez+URPxEA4RcAXTGoa8MyUfiy98Tl7XOM2Z/Nj2Uwt1AfWnBA6B3LKdyWcIwosF2dAvLPDyP3DS20tC5SeFIJcbM66AaghVj8R49Bh7MRyNgf6Wt+ttp/rftrNc14xmk2udml/SRfgmvZWmJXXuD/e3AXryfMDitLJpRCz3gAS7gTCm7F8g2BdOvVy6clm9kqezJN7WfOI2LTgJ4enKd0frBx/383ik11nUENzazKs3HT58ak9sAw
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(396003)(346002)(376002)(451199015)(40470700004)(36840700001)(46966006)(15650500001)(44832011)(36756003)(2906002)(40460700003)(186003)(316002)(82310400005)(426003)(86362001)(2616005)(70586007)(70206006)(8936002)(110136005)(47076005)(81166007)(54906003)(356005)(40480700001)(83380400001)(5660300002)(4326008)(6666004)(8676002)(1076003)(26005)(966005)(336012)(478600001)(82740400003)(7696005)(41300700001)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 17:02:45.5359
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eff32887-6a65-4e0b-a337-08dace3db552
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7946
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set new maintainer of the Index of Further Kernel Documentation (document
process/kernel_docs.rst). See Link for further context. Also remove line
that keeps record of last update of the text -this information is already
available elsewhere.

Link: https://lore.kernel.org/lkml/20221118170942.2588412-1-carlos.bilbao@amd.com/
Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
---
 Documentation/process/kernel-docs.rst | 8 +++-----
 MAINTAINERS                           | 5 +++++
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/process/kernel-docs.rst b/Documentation/process/kernel-docs.rst
index 306ad373a002..5e533c827cef 100644
--- a/Documentation/process/kernel-docs.rst
+++ b/Documentation/process/kernel-docs.rst
@@ -3,9 +3,6 @@
 Index of Further Kernel Documentation
 =====================================
 
-Initial Author: Juan-Mariano de Goyeneche (<jmseyas@dit.upm.es>;
-email address is defunct now.)
-
 The need for a document like this one became apparent in the
 linux-kernel mailing list as the same questions, asking for pointers
 to information, appeared again and again.
@@ -614,7 +611,8 @@ Miscellaneous
 
 -------
 
-Document last updated on Tue 2016-Sep-20
+This document was originally based on:
 
-This document is based on:
  https://www.dit.upm.es/~jmseyas/linux/kernel/hackers-docs.html
+
+and written by Juan-Mariano de Goyeneche
diff --git a/MAINTAINERS b/MAINTAINERS
index 6f2ec7c71a4c..05a76d045df8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10017,6 +10017,11 @@ F:	Documentation/hwmon/ina2xx.rst
 F:	drivers/hwmon/ina2xx.c
 F:	include/linux/platform_data/ina2xx.h
 
+INDEX OF FURTHER KERNEL DOCUMENTATION
+M:	Carlos Bilbao <carlos.bilbao@amd.com>
+S:	Maintained
+F:	Documentation/process/kernel-docs.rst
+
 INDUSTRY PACK SUBSYSTEM (IPACK)
 M:	Samuel Iglesias Gonsalvez <siglesias@igalia.com>
 M:	Jens Taprogge <jens.taprogge@taprogge.org>
-- 
2.34.1

