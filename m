Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1130619135
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 07:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbiKDGmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 02:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiKDGmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 02:42:40 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2098.outbound.protection.outlook.com [40.107.237.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF66DF70;
        Thu,  3 Nov 2022 23:42:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Br5SsGB0+A1TwBnq0lq79sMcti7PYWlpDIuCL/HOlC2R6ymi3RsBnrJ6PSZpdWDzZhqO8hkUsnwk4rrG5auGEJ5o9mEByj7WdFOtdHwGqw2p7z06STSjoPEWdtJXhgPfgNMQwD/xKF2/adMIrIsKcdZXi/QMvVHuQqezcy2BC0Pa3SFHKJLGjwaa9l7NQd3dSEdPrivQF44Zgk+hoIpZqS93tsOi82Ehz0JUOOjfMjyC1laJ19k8PL68slKSRrHr8UTAxg9kxH+tkEdQ45lijI5d4iZahI2zYw5AeK2sowekX4Scxie1oK4OFmOvoZCF3XgycP3GppJ3g2cG+PMAXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t+OUE+mdVdCTet5tOTY66WL++4ZAEuURRw/ws7vPynM=;
 b=AZvjUY4BXCAHL9Tma/AvmMW/LAXjd7X8R2Rd0ZK6HoJOy/BHzjd7tTH8cWo7qYXKJkuR8tM/Kd07tAXHMgw/wIbaN8whN4kwyF53PigXGZEthJywNDqPb+vCbwp8xdHB9F/QyoWLW6xbr/LwsvQ9weepKzSakzm4kpDcmu+WphjlulZ1ADo6OPWatm5eaBy9mYeJyOlWt+iFoBh/y+k3zVXzINJfKUtsGTUP8E/SeY6SttouzWJ/4lizXRvyq5kERG+TThuEUHl2OrjK5ojv2g3H/1BaMpDX24QmcemzXRFR6GD/LRnFJq4Z1/MNsoM2ZAEkuCam2m3wZoBE6RO5FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bayhubtech.com; dmarc=pass action=none
 header.from=bayhubtech.com; dkim=pass header.d=bayhubtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=towerbridgetechnology.onmicrosoft.com;
 s=selector2-towerbridgetechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+OUE+mdVdCTet5tOTY66WL++4ZAEuURRw/ws7vPynM=;
 b=Z1L5SjSlQ8L+rKCUbuUlKhIMSku9gQ6dtdaFDJ9cC2xmce5C++tb2OluVCp0ycfsgh2yqaotqTK+TnbkVWbu/UCEItQpj1eRRJHvyU2FcDvqjR6LH8ODCRFjg+0ZU8d0qcDv0dwABjTifOJClDvM5wr8BAkIPr28dlzWfthn/XQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bayhubtech.com;
Received: from MN2PR16MB2781.namprd16.prod.outlook.com (2603:10b6:208:e3::30)
 by SN6PR16MB2686.namprd16.prod.outlook.com (2603:10b6:805:d6::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Fri, 4 Nov
 2022 06:42:35 +0000
Received: from MN2PR16MB2781.namprd16.prod.outlook.com
 ([fe80::8aac:579e:4f4c:eb0c]) by MN2PR16MB2781.namprd16.prod.outlook.com
 ([fe80::8aac:579e:4f4c:eb0c%4]) with mapi id 15.20.5769.016; Fri, 4 Nov 2022
 06:42:35 +0000
From:   Charl Liu <charl.liu@bayhubtech.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shaper.liu@bayhubtech.com, chevron.li@bayhubtech.com,
        thomas.hu@bayhubtech.com, xiaoguang.yu@bayhubtech.com,
        shirley.her@bayhubtech.com
Subject: [PATCH V2 1/1] mmc:sdhci:Fix the SD tuning issue that the SDHCI_TRANSFER_MODE is cleared incorrectly
Date:   Thu,  3 Nov 2022 23:42:21 -0700
Message-Id: <20221104064221.812-1-charl.liu@bayhubtech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0029.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::19) To MN2PR16MB2781.namprd16.prod.outlook.com
 (2603:10b6:208:e3::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR16MB2781:EE_|SN6PR16MB2686:EE_
X-MS-Office365-Filtering-Correlation-Id: c2dc505e-0eb2-42f1-74eb-08dabe2fc1d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZqnEhYh2qJJfiAfEKPGVrn6BqgsoKSDfRc+sW89pw6qBRLZrMZ1X3R8M7/5OAr1GoW//Yom1g3V4+BVKUu/fR2/wnuC439QrNSJiLnxpFIPJL5A1rkyHZyyzGd8gn3PQO+s2cisnQIG1hyEUlrVDYfAzGBM7gNKqJTLpyCHKL9k1F9dAyh8LOFdH6V5mlnQQ2U+LO+OSDTnEg99UC+PQeXWOm7T/sz/5D1MGodvWu7wTLo3oYghdhz0HgIncQRawbkBbbzUKtsqHJqEzYOpIxBzxPA4jxPZ0one6cj/vQDVdegP5CQB2FRvu2m2gazggw9Z+D29FrrBYzUfmLumphcOPCATIqFKI/PPFh8o2Hr5/grWz+jP6DQ7WdMgcOxSQFAhvpn7dPcX4DANhI16EUWOa9QW5S2p7tBdPBsDUBRBoI4kT3zSI0Ot27kcn8CdJGtqLTfcdiAk9AdfXvVGbr4AIbNl+UBiFcwbzKRkndq0pcg1AHss2QQHGZcN9Zu9nWSEJfdwZz7BTcq11hwym9s/qD8FXZPzcGuOn00qP2FAmtA2h3RFCY5R+wC3QKvFl9mRe7IS8EhJPvq4RISKmgda0J2jgjSdwuTScB0rLxSdjIY9PcqrxXvgOKK0dZnEEGSfMHoNA34ix3DptZxtqeEmhCQcFds92bgNMF1tHDnAFuhJcaQd4lxUaVkm724NlLuE6OSS5E4GuWWhr6yoZBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR16MB2781.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39830400003)(136003)(376002)(346002)(396003)(366004)(451199015)(83380400001)(44832011)(6506007)(6666004)(478600001)(2906002)(107886003)(6486002)(38100700002)(36756003)(6512007)(2616005)(52116002)(186003)(86362001)(4326008)(316002)(1076003)(66556008)(66946007)(8936002)(41300700001)(66476007)(8676002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?238UJnGVantirW1FbiQSyOfVuFUunGLrrMAjoHQXE4OJ6gkoaEtOMosAPxIT?=
 =?us-ascii?Q?NRt7zMI7XxRhYdLoUr5/GjD5MGm7oGK51FPG6PyD61qpsck3AKNh3KyIBq5n?=
 =?us-ascii?Q?2nNUx3bcTcwYjKLOqkJm+W/2sI5oCtVJafYdQ4012VpbotJGrtfZUdSGbnsz?=
 =?us-ascii?Q?m+eEYSDu6UdQcfkgXpi85ayy3v2B8g15CM2vVmrysF1OFFo9+KbYVf4QIXNb?=
 =?us-ascii?Q?tOXI2qf+dP9qbgYB4SGnWb+xJ/cTyjuDjHqG0Zz50s0gXcO3AGUZYBNFlHGm?=
 =?us-ascii?Q?zYz5eg6dY9vSD+in9HY5k3l6v1P1Mahnwe7Hva3nppfHJJbDJCOmXSrGmzc9?=
 =?us-ascii?Q?JSMMBOkIbzu6kyB3j6VYQQy8Bqp4ZrXNyh0plxQB6Ov/d5oP56dj4s7QgA/I?=
 =?us-ascii?Q?LGbB6+2/j51fz1bNeUOopvkpQKQQcVekQXOP1PZngXzxme05tSlG38ThYnqG?=
 =?us-ascii?Q?zIgI2iNv6VjR3dwFuSZJpx8epUlbxBb154EEpCn9Gph3/+leOhn+UGJq8Mwa?=
 =?us-ascii?Q?Ay2nG/jnlC5RgZXzMNkrcjz09qZJivvWdZ2yvHlotSGuRxB9yfTR9lwFmFMn?=
 =?us-ascii?Q?bLJIeYiALcSgDdAcvbiB50sZSbG2e7JDdF/59v1r0UCek1GKsURsteS/Wv4M?=
 =?us-ascii?Q?twZdqjyN1yA6e5aQXJvQ0p6f0HkOyv7WZhwqm/jUZv8IlzKFH45tRn4gzXgP?=
 =?us-ascii?Q?SDFRdaVbtxv2Occ/W2cUmxH3717JXbNC5kMLD5PrTWjQFmdDDAYp5MTAEEdi?=
 =?us-ascii?Q?Re3eGhSWcgVbqfkV7aTAaG3+QenFApuCI/Pl+gyVQfCyFDQKKRAo+KSl6ZS0?=
 =?us-ascii?Q?xAuT9yALf0wmPf0M3G+tD4qSxVxHzjF/Oj5/1Ww7OYH3ZwKo1Qp9l5EBXrpA?=
 =?us-ascii?Q?3JlzoClGTyGn0xPiGh1a3B1wFFnQX1abvbSPO4l/ZHltgs3pcTG8JOE4ZAyC?=
 =?us-ascii?Q?BQelZYqx4Ul7xZu+zkAOX+zVzAjzdFRUY+X8g97wTY8rj7P7q8deya5pnxGA?=
 =?us-ascii?Q?T7pbIxOsJyn/WvdL7QKCg7H/lv1BfgPusl9rRqtC3tm6pbrI4Q1AtF5KLlhU?=
 =?us-ascii?Q?wgtIS+wQyl9KoQt4DQLQPzCwVU6XYzh4aGzREUw/YTZiNNjOmy2J7lX1Vh8u?=
 =?us-ascii?Q?u2VDqy3vsgHzZmei9aAxWLkLICkYjw6ZWAQjE5z2Rxhx9R1RdlQExK0ub4dQ?=
 =?us-ascii?Q?DUyAmFtf9fiyN1Ziq13u+lWePxh0paUjCkRnQORJH4Nb36mXHu8P3XFvAkkS?=
 =?us-ascii?Q?GhX6/R5OXpKa1tADQDYTwyUAQF1qsovvxgFRbjh+xCxRlD6drIw4aCL2yq4t?=
 =?us-ascii?Q?2/1U2xQZUSyg8pJ8Agqhit1OWsxFQrRBXShwp+0TdRjCDHt+jhDqWSn11J+z?=
 =?us-ascii?Q?7jVG2dGxQ7kaIzRPQxTkrmJqyXLvCjXEMjjEskfVMjHBBZcLEY9plPrTyO65?=
 =?us-ascii?Q?MMZdVPoXPdFL1mDpuNGKcdrsZep0TugSoCbloOkJyq2x/K6S383u9wGEjtVJ?=
 =?us-ascii?Q?xDHPmpCOrjMmaAlD/9QC5PG6NH+PN+h8dTWN4HBU/DClFEFVAVcffRbi/ViT?=
 =?us-ascii?Q?R11Ys6BUYUIhhBrpIQyMARCNHrFVbg6HCoHuxQ5sYeiMb59pE29P5OGdMz4h?=
 =?us-ascii?Q?BfzK5h7zYKDYXs3kl22nxK4nqNM0dJiqX56SjwyGrlY8TFMu+Gl4VmqATBpd?=
 =?us-ascii?Q?qwBG9w=3D=3D?=
X-OriginatorOrg: bayhubtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2dc505e-0eb2-42f1-74eb-08dabe2fc1d4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR16MB2781.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 06:42:35.2263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0a7aae2b-8f2e-44df-ba2f-42de7f93c642
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YpfRKbxCa0cq+nSdBUuaiIpRzEuBgre9Zz882qOQdYoDFFFJaHH6ywml3I9JEFcrKqVWVPkzft+mXEsz38xEEO7umafH8yiG0u/ZiUbsPPw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR16MB2686
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When cmd->opcode == MMC_SEND_TUNING_BLOCK, the SDHCI_TRANSFER_MODE
should also be kept

Signed-off-by: Charl Liu <charl.liu@bayhubtech.com>
---
change in V1:
Keeping the SDHCI_TRANSFER_MODE when cmd->opcode == MMC_END_TUNING_BLOCK

change in V2:
add the mmc_op_tuning interface to judge if the opcode is tuning CMD
---
 drivers/mmc/host/sdhci.c | 2 +-
 include/linux/mmc/mmc.h  | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 22152029e14c..9388628215ca 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1430,7 +1430,7 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
 		if (host->quirks2 &
 			SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD) {
 			/* must not clear SDHCI_TRANSFER_MODE when tuning */
-			if (cmd->opcode != MMC_SEND_TUNING_BLOCK_HS200)
+			if (!mmc_op_tuning(cmd->opcode))
 				sdhci_writew(host, 0x0, SDHCI_TRANSFER_MODE);
 		} else {
 		/* clear Auto CMD settings for no data CMDs */
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index d9a65c6a8816..d809bdfcc59b 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -99,6 +99,12 @@ static inline bool mmc_op_multi(u32 opcode)
 	       opcode == MMC_READ_MULTIPLE_BLOCK;
 }
 
+static inline bool mmc_op_tuning(u32 opcode)
+{
+	return opcode == MMC_SEND_TUNING_BLOCK ||
+	       opcode == MMC_SEND_TUNING_BLOCK_HS200;
+}
+
 /*
  * MMC_SWITCH argument format:
  *
-- 
2.32.0

