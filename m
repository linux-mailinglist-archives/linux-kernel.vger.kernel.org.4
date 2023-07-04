Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE48746DDD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 11:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjGDJnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 05:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbjGDJnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 05:43:08 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2120.outbound.protection.outlook.com [40.107.255.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBA71BF3;
        Tue,  4 Jul 2023 02:42:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CtbyvFBWOjcuB2N7+gjRmX4JG8FZCwJpxROFwrbbHeRI5Iy0RZbfN/XoS+xCPAVdjxCs3Q5pYi5CK1FOLO7mNebrK0eO9VBBisjmQPvmQS6zlKJMXfCikv95FkrofJ5R27gjST+MduKZjPaQXEhHJHk+gWmIJjUeYj69Mcss+5mhA643bXRsahFbyvzeVOVYQQ/UQ8MWBc1CuNcWT+JQTJTrr9CwERxng7Bfa82D1x6uPNil7Gi3YSbcM8ripB3ChDBoFpo3fPD2LbuhQVSZOV1v4n8v4rJUGb5Fy0MTUDWQ2hBLzk1mpK7sVbzrbfUjSQ1w5tQI7B6qT6FqDNyk2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SToyjRJvmFXNJXEA97mByE9Emzul0j4TBfmMECCccnM=;
 b=OuMn30hqRRIRkOeq2flzVhidhhV2pjCcljJJQaSJ0kwQJbpTgdg8QCx4yBIpC9U2MkW6UzLUG7yO5pycRD2ibu4Q2E8xaRAA5nUV9PXYnZNee5VoErYxzDfLMBjm6HCCYUr4omcud+mNvJLDOtY4KPMT/CeWEoNoRnH4zc/X5cC287DpHooMEZJIyUVNacNB1ePUaZ9iR8Mc888gCOCUSTM3zmOv1v6Sx8eo/OdT13aMM1xe+tSlwDEoPf+3TG0Kka2gyxQaJ5wD+Fhg18pjTXJlP5qwOdPW8Lg5/Sgrg9oAhQo27Mi+0G2YUjuWaDO4LQvQjSq4fZY52GLeO51jiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SToyjRJvmFXNJXEA97mByE9Emzul0j4TBfmMECCccnM=;
 b=dJw4LcLOgxnRASA7WaZF5lHxP7A9D/uA7qYku+S4DfC2n0GNAtdbDdvkbJZ08tEgeKh+u0eWA8UV1RwEjSTBh4TZauySUdDRZW8wTOTuYdpQh3XVQxRu58SyDjs3+5BFQNnvxUSqF4RhRSYE5hj8gtKT1rliZjqqEFXDDZA811gEpjnszuwJiG6oPQv4I0cvzAGjkaPF/q7iAnLnC+VTZ+Wcsc1znOjz/gJVHi+htCZdGYgQReJrTj6PTMxQMBcaURzcm5kga7TYvVPimBuA/jWn/tmZO+ZA0BExgg8zrlK/moADbycSWa4IDwPTFCT0coyQfVA01oAia+JG5wtJUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5936.apcprd06.prod.outlook.com (2603:1096:301:11d::13)
 by TY0PR06MB5683.apcprd06.prod.outlook.com (2603:1096:400:273::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 09:42:14 +0000
Received: from PUZPR06MB5936.apcprd06.prod.outlook.com
 ([fe80::5c03:58ad:fb2b:49d9]) by PUZPR06MB5936.apcprd06.prod.outlook.com
 ([fe80::5c03:58ad:fb2b:49d9%7]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 09:42:13 +0000
From:   You Kangren <youkangren@vivo.com>
To:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Adam Guerin <adam.guerin@intel.com>,
        Damian Muszynski <damian.muszynski@intel.com>,
        Srinivas Kerekare <srinivas.kerekare@intel.com>,
        "Bruce W. Allan" <bruce.w.allan@intel.com>,
        Pingchaox Yang <pingchaox.yang@intel.com>,
        Bo Cui <bo.cui@intel.com>, Karen Xiang <karen.xiang@intel.com>,
        qat-linux@intel.com (open list:QAT DRIVER),
        linux-crypto@vger.kernel.org (open list:CRYPTO API),
        linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, youkangren@vivo.com,
        luhongfei@vivo.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v5] crypto: qat - Replace the if statement with min()
Date:   Tue,  4 Jul 2023 17:42:07 +0800
Message-Id: <20230704094208.642-1-youkangren@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0303.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b::11) To PUZPR06MB5936.apcprd06.prod.outlook.com
 (2603:1096:301:11d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5936:EE_|TY0PR06MB5683:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f59d386-24ba-441d-2ba0-08db7c72f200
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t2qfV4KZAOUtVoJ3bec3JPjekPa0dMQpsYiRK5QYOvIc8PqspKVHtWrr24vos/qqCKdHF3RwyFPe9KLbNemilZV4JzuUjA8SoPnBDJAl9wKF44rJWeWcMh6ee0eYrVHyk9vh0xhleGxYEfUG16V5nH9YwkJ45SZBF2/92/YmEnBw730vFaEgArmqGCIuR2418ky3Rd+k6TVwYP3Y8FzffIm6aVjnd3M1SgjWzjSOLDzkasOBDnWUFvWvTzLSteUU4HKBmSDlFxHLflhaYYfx2ujQHo75S5wQ26onu+f9gSRIwV+Ph/DZOEznDdcXtNwfl0p5XbRuhczzKzFxe3I+jamsJCHUfQyHihaEXn9kup3fqYCuYFdzD88qZ+r6NtKMRfV+Vk4TTgRjFWD+3xtBDZVm3N+sV9tnIqb90NU7IK3lhWY1VDLtsdIGOL9Q3GsGpNS+lbHoiIOugsJrcrX9VtBnC3wclAYeyXHRoMMiXRK3dIutHq2es/HcUNbWJEvdcCa1GLRe7a8UrMhaNirD2G14Fij4GoQthseccCfUB3e9Iaf9x+ZafKQRu3QjG6vwKcHPoG/MKTGft7HR3QpxpcfD5Q6Uetn5x0HkJHug1wjzMBWsrrJ3kbSWB5Eytes8hK8MkgdefbhucJ9K3q2gTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5936.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(39860400002)(376002)(396003)(451199021)(4326008)(316002)(66946007)(66556008)(86362001)(186003)(26005)(6512007)(66476007)(1076003)(6506007)(83380400001)(2616005)(921005)(2906002)(6486002)(38100700002)(6666004)(52116002)(38350700002)(7416002)(5660300002)(478600001)(8676002)(110136005)(8936002)(41300700001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jB6c531nUquJTJAtBuJV2stm8e84yi6FQoS46y1CRyBiNtOMGbGQx9ZWV4iS?=
 =?us-ascii?Q?dF+TyYYPTrwLx7ut7LFKEvgna+eJk/lSAKqOmTYUkdJaj9DJFEX7qXQUfOWq?=
 =?us-ascii?Q?ZMJQqZ0H5a0sBggnp+Np0yY6G/h6xIOtrTQPbZYfn7yGlL3HHH/NvcvQiiro?=
 =?us-ascii?Q?NoxmDwusiQ3+52muwLVRhj4PuRpHPWVbgEFUiHhNtwSyLcYkwFsWtyLWIuTt?=
 =?us-ascii?Q?nlHiq/4dyevrW3JmWNuj8wDjTiQPq5uvzx3nTEqhxjwYTW7ZODTIgkM3RUWP?=
 =?us-ascii?Q?pcO5OXFqJAJvUtvzbljRt5PoB/3rsveptX5dfL4AErn0ItGW1KG2bWijYTdw?=
 =?us-ascii?Q?YA2gSnOPS9bMPkrVRLv/DYuVrfrE69ASiHKGBliVnv2Frj+pQGtdMrZ/vQGp?=
 =?us-ascii?Q?qe7sGZL9LJEfLNGAm5HUbBIamU8W2u6PSvBnxY1YvQgE9oVlLLLnKfq/x6Ns?=
 =?us-ascii?Q?ZPsn0yZvmoAfhWSQE6crIqJNlr8kSQbFFd/4yhgalGnTpM2qdG+ADBhsRWBW?=
 =?us-ascii?Q?9g47qCu5e9PbdctZMzl+IDw6yfHXwyBZQ7BVWLzOuMFrXHxx94Rd//oYBv8O?=
 =?us-ascii?Q?lqsuKF+SN4pneX6j6SkQ5VNYCfUP4vdhVF3AJf5DmCiANH8CE9yVaZAWrvAF?=
 =?us-ascii?Q?xUQxiwfuYY151b+gADIMrhqwQIAy7Sc7JVdVbwHgsYSPVOxYs7vfGsO/aPBB?=
 =?us-ascii?Q?3z2mIBCM4I8DCMw6A5SNXAZ3ug/dNegeREdTJ236OWlMvgNEfrz6/VmZg7uE?=
 =?us-ascii?Q?ZtqAvRegROOtpYpGi/oCKF2b0USg0k+KZ1T/WmKpm4/7ye+ofIZPi0N7TnyX?=
 =?us-ascii?Q?qZN8u13Jgb8wZRPzz9seRTHreA5tuT3YBmKLZ5nUYpubdQW4R2XNioqyWXtx?=
 =?us-ascii?Q?dVBz7z+vubt9EOOPvvlBs0U6HEL2VHf3FE60N5LhwMq+tDMrpIiI0TEIV1Jw?=
 =?us-ascii?Q?2cWB26PFCxWWvPlkk/Pb5zF/lATgo8PPczh9LoaMbetsEFtxVoCQRMJ5YxK0?=
 =?us-ascii?Q?55+f+0dPY3Eq7qotnKv0gD6hQIgODA8sKkbE3Y4uf2ryx7YySgR6d/sPVy9n?=
 =?us-ascii?Q?PZ+Lhlu1jcDqq5Ugx8QtbCf9Iruaf6zBLRgsiIdCxDT31pRoU/DKjppxc6ko?=
 =?us-ascii?Q?1tdjiE72A7dda7DliV58s219oSaHEZu2yKVv0kIByFUe8zTPj5jC2lGb2L4O?=
 =?us-ascii?Q?Af09leaCDb+NpP9ZJ9sisvrgRvDy3p3EKaX+Et74WjWntoC8etnLLDD+sZLf?=
 =?us-ascii?Q?IQh0HOCelmuqfZK1+vQBoEwNo7yW4FKU0eMMOnNhaP2Nuke8RysyjRF+Zb27?=
 =?us-ascii?Q?OrE2WQFjR3/qq/2TOHVdjtkoM7AvIaymglMRaipLxp8PU2mFjs93ThGDHL1o?=
 =?us-ascii?Q?ccB2Z47Dzle5/baEEblGxRLcUK9IXI2VhgZqahDZ7dnISjGW7omhpit1z93d?=
 =?us-ascii?Q?m9Ed+2lDBpYkKwo994wMKCAYxS+1K+bFf4x5rJvlzo8b5YFqqjob4PQmBl1f?=
 =?us-ascii?Q?FIvBsjbHyDrBXgh8ky0qUdDc9yvSsMHzPkUboJ+ISyFeJJyRcuXGuaI/vvQQ?=
 =?us-ascii?Q?w0lQS8Ovi5HfTyZ9VXcuhuLOOKFryNu61KWVz1wK?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f59d386-24ba-441d-2ba0-08db7c72f200
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5936.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 09:42:13.3599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rEEcM4lGYnP/fGrgIQhW+bylxpUgPlqQ9V3YLzfZE2FBX6MaRPK5PqKd0Xu7CZ6FmuM52O4h9fhDjElJWMCuWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5683
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark UWORD_CPYBUF_SIZE with U suffix to make its type the same with
words_num and replace the if statement with min() in
qat_uclo_wr_uimage_raw_page() to make code shorter.

Fixes: b4b7e67c917f ("crypto: qat - Intel(R) QAT ucode part of fw loader")
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: You Kangren <youkangren@vivo.com>
---
Changelog:
v4->v5: 
- Add the Fixes and Reviewed-by tags of the patch
- Add the version update information of the patch

v3->v4:
- Remove the header file <linux/minmax.h> in v3

v2->v3:
- Add a header file <linux/minmax.h>
- Mark UWORD_CPYBUF_SIZE with U suffix
- Change min_t() to min() in qat_uclo_wr_uimage_raw_page()

v1->v2:
- Change min() to min_t() in qat_uclo_wr_uimage_raw_page()
 
 drivers/crypto/intel/qat/qat_common/qat_uclo.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/crypto/intel/qat/qat_common/qat_uclo.c b/drivers/crypto/intel/qat/qat_common/qat_uclo.c
index ce837bcc1cab..4bd150d1441a 100644
--- a/drivers/crypto/intel/qat/qat_common/qat_uclo.c
+++ b/drivers/crypto/intel/qat/qat_common/qat_uclo.c
@@ -11,7 +11,7 @@
 #include "icp_qat_hal.h"
 #include "icp_qat_fw_loader_handle.h"
 
-#define UWORD_CPYBUF_SIZE 1024
+#define UWORD_CPYBUF_SIZE 1024U
 #define INVLD_UWORD 0xffffffffffull
 #define PID_MINOR_REV 0xf
 #define PID_MAJOR_REV (0xf << 4)
@@ -1986,10 +1986,7 @@ static void qat_uclo_wr_uimage_raw_page(struct icp_qat_fw_loader_handle *handle,
 	uw_relative_addr = 0;
 	words_num = encap_page->micro_words_num;
 	while (words_num) {
-		if (words_num < UWORD_CPYBUF_SIZE)
-			cpylen = words_num;
-		else
-			cpylen = UWORD_CPYBUF_SIZE;
+		cpylen = min(words_num, UWORD_CPYBUF_SIZE);
 
 		/* load the buffer */
 		for (i = 0; i < cpylen; i++)
-- 
2.39.0

