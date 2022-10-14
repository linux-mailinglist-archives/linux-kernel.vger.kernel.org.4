Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEEF5FE7B8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 05:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiJNDuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 23:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiJNDuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 23:50:09 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2099.outbound.protection.outlook.com [40.107.117.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE8B6335E;
        Thu, 13 Oct 2022 20:50:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EVbFnUQFz9XOfLy9s+LvXE6nmkZjNe3E/8TtBzgzGcY43XPuCXiZEIh4vLRPETQ2oepd6Bfw0+ZWd5HtlVn3r271KYgdDskWfdZwO/+aVeV70Erqr1o+h9SCCIVN3ze8x3VJV0+Q/eXPbyj7x1JN7DYYkpI2EvZ+RPSIFOUEFwCiuLgh97GaAZhZsJdWOewalYTqv0Z2qgM/T2WmA7EE9QICv4zrhZyriej69uFbxTffQU5D8qw+Ir0xV8CvHMAUtCN1CkZgHmrmQcsRd/vq/F97heaHHroyKQdisRS6rbkU2apjz5IxmREAanw1DQub4Ukwg9XXF0jwhAtiCyyhMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3LYKqlmxSoaLgyEYPHydckJN10tpNn9+YMILn6cGUt0=;
 b=P+46QVPXzBDtTrCR3YtO152fn7ifowh9yi25Wv4+ElyR+Axz/G26APzi2K6PDv90LBsvg5vjNUdQZYjQYkYfKYmsrRh7T3JchnHw6LnOUF7vf41yVcjXE88Xf/A1OozGbKYBEmGm61Ta82mvG2AXunl896OvrbhNbP5Qg78GmTmbGvcpJD2xgct2xHlSFOrmDT94jnr6L9UawAfKI7RvbCwmXL2hpqOORryMokw/wdSDdVL2J9ZD3utRABBnWsJ2+2NfsUfN/G/GWGN8uLwVMuy7VbvrYvjTrZ1jCmNge1pfBXKM2eRIhDQH7JOzBWGDbGErLdTI3ssOBKlg+SNpQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 103.192.253.182) smtp.rcpttodomain=linaro.org smtp.mailfrom=zeku.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=zeku.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zeku.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3LYKqlmxSoaLgyEYPHydckJN10tpNn9+YMILn6cGUt0=;
 b=8XL8xjjL+XuG981T8H9oE17N3Wyd24Y2TJvYmra7x+CUqe6IO4n+dZ9wuNHOg637WTxP+z5iCC4GVMIUfUj28o1o1sElHZpfGV7pfHkkEFEC84oFrs2q3FNG6Jn7QpdAorVhXdiLJP2TfgyRR6Ci4n+fcYcLC/hQAq2gSuLGPl/qgHgW5ufsKjtTSM4EUydXaFTI0+2orzMWjBPmlh5dqQ1u+AUufszYbXNjPA/lhGkOYrYy41+MPUkkDn+cbjfDjohscy8A+1x7uXFOmp3BiFpWg8HsOKfsXJkW1I8hJf+AlejbIRF+TVsMtKhORU9owldxE4rOgMxGGgignYa1Fg==
Received: from TYCPR01CA0005.jpnprd01.prod.outlook.com (2603:1096:405::17) by
 SG2PR02MB6023.apcprd02.prod.outlook.com (2603:1096:4:1d5::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.21; Fri, 14 Oct 2022 03:49:59 +0000
Received: from TYZAPC01FT017.eop-APC01.prod.protection.outlook.com
 (2603:1096:405:0:cafe::ea) by TYCPR01CA0005.outlook.office365.com
 (2603:1096:405::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29 via Frontend
 Transport; Fri, 14 Oct 2022 03:49:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 103.192.253.182)
 smtp.mailfrom=zeku.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=zeku.com;
Received-SPF: Pass (protection.outlook.com: domain of zeku.com designates
 103.192.253.182 as permitted sender) receiver=protection.outlook.com;
 client-ip=103.192.253.182; helo=sh-exhtc2.internal.zeku.com; pr=C
Received: from sh-exhtc2.internal.zeku.com (103.192.253.182) by
 TYZAPC01FT017.mail.protection.outlook.com (10.118.152.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Fri, 14 Oct 2022 03:49:59 +0000
Received: from sh-exhtc3.internal.zeku.com (10.123.154.250) by
 sh-exhtc2.internal.zeku.com (10.123.21.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.12; Fri, 14 Oct 2022 11:49:58 +0800
Received: from sh-exhtc1.internal.zeku.com (10.123.21.105) by
 sh-exhtc3.internal.zeku.com (10.123.154.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.986.5;
 Fri, 14 Oct 2022 11:49:58 +0800
Received: from localhost.localdomain (10.123.154.19) by
 sh-exhtc1.internal.zeku.com (10.123.21.105) with Microsoft SMTP Server id
 15.1.2375.12 via Frontend Transport; Fri, 14 Oct 2022 11:49:58 +0800
From:   Weizhao Ouyang <ouyangweizhao@zeku.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Weizhao Ouyang <o451686892@gmail.com>,
        Matthew Ma <mahongwei@zeku.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        John Wang <wangdayu@zeku.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Grazvydas Ignotas <notasas@gmail.com>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Weizhao Ouyang" <ouyangweizhao@zeku.com>
Subject: [PATCH v2] mmc: sdio: fix kernel panic when remove non-standard SDIO card
Date:   Fri, 14 Oct 2022 11:49:51 +0800
Message-ID: <20221014034951.2300386-1-ouyangweizhao@zeku.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZAPC01FT017:EE_|SG2PR02MB6023:EE_
X-MS-Office365-Filtering-Correlation-Id: 27ff2d38-c1f6-4240-3c04-08daad972a92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S+P+Cx7uuHZZJdQfhwQ+1F+EnfFkK192FKJV6hhAZH5PZcPVVScaU8ljyJ3e/eHedkliQR/S7vZMlUnuz7lkD18V4wcPi6bdIEWSpctjMrRMQUzDcezvOagCdjtuqQ8HKjh5w8ZAXt4gUg+9Y2sI5BBRKHQCid5U7WSn3uHm3FcYh/CAlEJfVCPKyVVCwQ1pr77d03tzOweDNKagdm5HGc506b3HAMD8sAmwmq9MShBHcqfw+8TCTI1N8hi2TQwqHT4/lT7dKfzp4x6noUUe6TgI7ojeIzm30ddKgC01wQL3oKDIje85p7MNfaNtH5qT9ah+B77Htxznbpulu/IreP7g0TrzZFG4mLMPCYABgaB+g1osmtY/IMwcjp9r9qfQWwDqTRKhdxa0BScYFK/PcsU9LWQ0uozPKSozlcK6b+t9RV1FzyQN2Aagi0uPHGnN0iRlolA5q3YZ0kSdTpMsvOkI9lkFywxF1qzr5zcL7vFO5MvmRjhwD+I+8QZsXDnG+fd59L2yXM3s7TYMPlrT+ayCu6rvZBcGMNfYwpKj1ubVOJiMwA56MlW/tn1Kz+iRAZy9FuEId4Je2z5HWSlcmdd6ikVXdeAPA2GSo3E8lmFMnsJvoTcph4BatWHR1E8zD4/vYF7+KDG1z/sFaMt0eK3c5ouM38HdJFxDDL+qQ1/r3Bsnlzf24GFXwubtla1oFyQ7i/eFXRtDpvBivM8lM18xremP/QuTaZokApL3LWp++eysfFQN1wMtPniGd8o/ifYKYr4/JU7jnHegs7ME7w==
X-Forefront-Antispam-Report: CIP:103.192.253.182;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:sh-exhtc2.internal.zeku.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(39850400004)(396003)(451199015)(36840700001)(46966006)(1076003)(426003)(6666004)(70206006)(41300700001)(316002)(36860700001)(2906002)(336012)(107886003)(356005)(81166007)(86362001)(54906003)(8936002)(110136005)(478600001)(5660300002)(186003)(82740400003)(36906005)(26005)(70586007)(4326008)(47076005)(40480700001)(8676002)(2616005)(83380400001)(82310400005)(36756003)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: zeku.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 03:49:59.1146
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27ff2d38-c1f6-4240-3c04-08daad972a92
X-MS-Exchange-CrossTenant-Id: 171aedba-f024-43df-bc82-290d40e185ac
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=171aedba-f024-43df-bc82-290d40e185ac;Ip=[103.192.253.182];Helo=[sh-exhtc2.internal.zeku.com]
X-MS-Exchange-CrossTenant-AuthSource: TYZAPC01FT017.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB6023
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Weizhao Ouyang <o451686892@gmail.com>

From: Matthew Ma <mahongwei@zeku.com>

SDIO tuple is only allocated for standard SDIO card, especially it
causes memory corruption issues when the non-standard SDIO card has
removed since the card device's reference counter does not increase for
it at sdio_init_func(), but all SDIO card device reference counter has
decreased at sdio_release_func().

Fixes: 6f51be3d37df ("sdio: allow non-standard SDIO cards")
Signed-off-by: Matthew Ma <mahongwei@zeku.com>
Reviewed-by: Weizhao Ouyang <ouyangweizhao@zeku.com>
Reviewed-by: John Wang <wangdayu@zeku.com>
---
Changes in v2:
-- update Fixes tag

 drivers/mmc/core/sdio_bus.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index c6268c38c69e..babf21a0adeb 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -291,7 +291,8 @@ static void sdio_release_func(struct device *dev)
 {
 	struct sdio_func *func = dev_to_sdio_func(dev);
 
-	sdio_free_func_cis(func);
+	if (!(func->card->quirks & MMC_QUIRK_NONSTD_SDIO))
+		sdio_free_func_cis(func);
 
 	kfree(func->info);
 	kfree(func->tmpbuf);
-- 
2.25.1

