Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE7174A1DE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 18:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbjGFQLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 12:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbjGFQK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 12:10:59 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2089.outbound.protection.outlook.com [40.107.6.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B6E18B;
        Thu,  6 Jul 2023 09:10:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eehbWR0kzRCOI9ide2pm921yR61UqczOxaKBpuonTQDyCQpN2b25jx4AE1lLBe1LO657hRSHz3N4R+6fPW0n8k2bA5qkLG91cynFmM/BZHb5wNEz81SJMIjnJzGp7vkNFw8jiW1c7UufNJf2NfWBO0UkkrCLiCyLvZZmSsCKYCUzyr2IRsQJLzlMcZJ6J9wJroU4/8cnVh8+tE6mO+dXX2v0ndXfOGD1S/BroYbTYbn7PD7DNqvdajkVAP9Ztm+YE/oCv78u5XHwfpkt0dQMwnil5qpZeuVG1LZOqnKlMjocM2uRhPczXz9uvFZipnl34lRp7txH35TX0ldf3FZnhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vnULsrWmi82YEDCXub+2+nk7QaSKEsYCDkB+lWW4aLE=;
 b=lHERkQSzp2XmwE2iyb65O2OL9hSccH2bgaEZ+yz9zwNcCoju7UpskdVyCzELP4dwvKnKERfPxXNslnt3Zg7cCuBImha9oKzGHxNqD2ph8gsNcR15mQlez2UgTYzl+4M6dRQ6/YIdiguTzvHshLY6ToBIZhA84Bkg2p7b/YFwYdsu4ASa8ROruYxPekmggvgdy6VEHk+E5+qHkxaU6kfYd3Tgspe2Xn9+7MvHmjhuhZy73KGwFbZqGK2QFK5DpGa5u3wpOb4uWWOzqzXxHkMVGkfrQV9M/T4oEA+Jgp6nbdM7Sjb3bc/XD8LhAYVGf/nNxtn79PQIwd5uWt1qvlssGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.74) smtp.rcpttodomain=ucw.cz smtp.mailfrom=siemens.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=siemens.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vnULsrWmi82YEDCXub+2+nk7QaSKEsYCDkB+lWW4aLE=;
 b=BsUSvnY8QOSMhkZuyZxw2rEMgIEefKPze9bii0OrCn5iIrjIMD0c33GpRtkiBIfP9L08r3LqEsQTW3WLm6BD2JybEuyG/TsIbyJMG27PktOy0cP6vteNWMymURqwqyJWcSkf3MsUTOqz8rqzzVqZiIcA0CG99PJqs3W1QfujppmOfl67UL9qoMQeT2IVK6gFkNBp4bz5WdvEqDUSd9ZdVuBL7m5mA6NOMNccFvz3kqEkYAOuCALAlY5u2CYr2snqgc9bTC7Zi8rPBsZFDKvHKiLqZ5zVrTFfkKW0IZGeGyVdD62IdG5tJHSIs/aINgQCaev/POhIFf5VsH3Nl7i42g==
Received: from OS6P279CA0143.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:3a::14)
 by PAVPR10MB7354.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:31d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 16:10:53 +0000
Received: from HE1EUR01FT003.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:3a:cafe::f3) by OS6P279CA0143.outlook.office365.com
 (2603:10a6:e10:3a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24 via Frontend
 Transport; Thu, 6 Jul 2023 16:10:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.74) by
 HE1EUR01FT003.mail.protection.outlook.com (10.152.0.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.24 via Frontend Transport; Thu, 6 Jul 2023 16:10:52 +0000
Received: from DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 6 Jul 2023 18:10:50 +0200
Received: from md1za8fc.ppmd.siemens.net (139.25.69.40) by
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Thu, 6 Jul 2023 18:10:50 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>
CC:     Henning Schild <henning.schild@siemens.com>
Subject: [PATCH 1/2] platform/x86: simatic-ipc: drop PCI runtime depends and header
Date:   Thu, 6 Jul 2023 18:10:39 +0200
Message-ID: <20230706161040.21152-2-henning.schild@siemens.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230706161040.21152-1-henning.schild@siemens.com>
References: <20230706161040.21152-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.69.40]
X-ClientProxiedBy: DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) To
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1EUR01FT003:EE_|PAVPR10MB7354:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bcea9fa-8727-4c1e-27fa-08db7e3b925f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bzbtz348/8gdoEAy4AIZyQwpNO7Rtw0sfxrTxCbizBtM9AKiUPF98VT/uJbUUfGfDY/IrbCLHNz+GrSaGMkM39Ra7zS3JXe0IC/SO1WiSSbHWfAtyA4j+WK+cRG3QqYDdzAhj24jk/LzO34glyu2sSt8CNNxhSVliwkDerAE2VZgjNFtIpgUNcQi6F8ZgkaooOaqjLOxXuMt2IAJKAi1vNeyA3N6toGjM6dtbMRpYCklqh4QGeXgEYOTVu0r96sV7CZRT0oz7mIZv+RMw9PPTEF1WtjyhwF9PkqLx2zI2kS98tnl+bS1H86c5G46GUFNFUvhmThRi/Etb5RS/Iu/yNVKfD2/sb0xWgKfGzUJe3a4982LoSFqi0brMppg4bXZ2+m01usxVpqxNJkdAOlHBDDJnWKH0+yIFV03C1OdJS1tWIZxirpyG8wVUf7niodWIU4keDjHJlpGzu9fpTGPnzZmaTmTJsxLpk60WbMbmGtAjg82EC3acmuOvLZJEFLl1k89RTlj6xGyeKvT7PUpKrnDe03VUWQtTCKn90RVn/yJBPXrIsMWa4SMNep9Ao27hZTm3RCm9IbkA3KSJPjO04Wc+DODy/tk20RouHnIXrPJYApGReTLxXfMNyVHCnvnqIFagDqvQLNaMySTKLIUPi5uRuWf33UYSfWAgvS3hegmwBduVoUZoplgD4DLHYQsOxr3kZiEcRL+rYPxrSErhOANMS+L4L7u1jkneigvSiZ4pS4E9Wv51atH2+Xpl1Ip
X-Forefront-Antispam-Report: CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(376002)(396003)(451199021)(40470700004)(46966006)(36840700001)(478600001)(6666004)(70206006)(110136005)(70586007)(16526019)(1076003)(26005)(186003)(336012)(36860700001)(107886003)(2906002)(82310400005)(41300700001)(316002)(4326008)(5660300002)(44832011)(8936002)(8676002)(7636003)(7596003)(356005)(82960400001)(82740400003)(40460700003)(36756003)(86362001)(83380400001)(47076005)(2616005)(956004)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 16:10:52.5843
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bcea9fa-8727-4c1e-27fa-08db7e3b925f
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR01FT003.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7354
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We do not use PCI any longer since
commit 446f0cf9e08b ("platform/x86: simatic-ipc: drop custom P2SB bar code")'

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 drivers/platform/x86/Kconfig       | 1 -
 drivers/platform/x86/simatic-ipc.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 49c2c4cd8d00..d9ba3cb9ac50 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1076,7 +1076,6 @@ config INTEL_SCU_IPC_UTIL
 
 config SIEMENS_SIMATIC_IPC
 	tristate "Siemens Simatic IPC Class driver"
-	depends on PCI
 	help
 	  This Simatic IPC class driver is the central of several drivers. It
 	  is mainly used for system identification, after which drivers in other
diff --git a/drivers/platform/x86/simatic-ipc.c b/drivers/platform/x86/simatic-ipc.c
index c773995b230d..2523f6dc9db9 100644
--- a/drivers/platform/x86/simatic-ipc.c
+++ b/drivers/platform/x86/simatic-ipc.c
@@ -15,7 +15,6 @@
 #include <linux/dmi.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/pci.h>
 #include <linux/platform_data/x86/simatic-ipc.h>
 #include <linux/platform_device.h>
 
-- 
2.39.3

