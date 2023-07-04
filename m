Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858F47471A1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 14:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjGDMpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 08:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjGDMpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 08:45:47 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2139.outbound.protection.outlook.com [40.107.255.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73F9FC;
        Tue,  4 Jul 2023 05:45:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PbUk/gicjITZJg874b76DIWHTTWfgLcQXWFvBYH8+gUWSJ8gx1UV+ml5LfCmcx/1bObgDE77IJISJZhWAEHEZN9pCZgE6R0DFPZc9xNGRGOFdnqd2wsM+6PSJbpdsm2U4wDZApemYnDEySoV2EHr63mFcaXmYUtzlnhLpm+RmlhP5yZrmn6RUEvqUCjput3c6dIPIbReKI7iMJzqCYGrve9Oyld9J64hjOXKIPo8nrwk+guLTZfX9yHEbVIOYuTU1OvgdY2ZJOmgoscz7+V4KolzvnRgoS/5aP9pSicRYUgz5qpd241LGrAezvpk3LBYUnqSqxOyER/9vzNG16ntjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VYN9bQxVVEqUZS565oPDVkwgcxrWVzNHrsSiU+l3JKY=;
 b=AEjkyCGdSjJ4kNA0w8qLNeuX12M8jQho2b6qD96jOH23YPMYrbqZcEsKVM7XSwwHWBbMwPVzbc6VanUCoIKehRWebnsws/i/4PM00+rPXrernikQzU5DbCXB/5s6fE3OYIS9ba0d0FHmuCq5FiQFaVs4b9T3+e1yFcVkf6nSrfBCk2hpDTHCuDCqukzarGOTNtTzwFeHZn7ZXrjj5jqO1tMpfdDCvpF1HPGNM1fRnZuPJNG7IbEhpZrMKsJaeZcEYk1O+hF4y6+YegL8H25yY7rFHOlPlsWm6t+EQF1QoXPm+X5o4Av4nudm4r09bjoQTfeF5Io4QjhcZF+WsK7ajg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VYN9bQxVVEqUZS565oPDVkwgcxrWVzNHrsSiU+l3JKY=;
 b=VYFNkh+e6H1WUkYg1xkGAIZJBxSKwgWzvEtuSUEqMliyPI1Q/RjGghH6jlItX1YBvqJtzrVlJ6YGF0+NHmoDl2S+Hz/YEuFBmNc+J8vXuAIIDYKOCIAuzMfb4Uq4+QcjycgARX906jj9rhflvqZSHggxbYzgZDqtQTpPzcVIzZNS9Cx5bZB8dQ2GihbFJx6GgbtB4zltSN4ucnR9+eiubcBXhgzQZd9jsGOxyNGn/PVsxQykOX2K2PomUQNZZZ6nK4QAeYVRZ3urblekrrwfuxK+jQ8IlS5snDV9G6dWnF8+1wWYVCJcZ5Nc5oaOuLv6XG3+/5RCaB87ttpQ5Bp9jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5936.apcprd06.prod.outlook.com (2603:1096:301:11d::13)
 by KL1PR06MB5941.apcprd06.prod.outlook.com (2603:1096:820:df::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 12:45:39 +0000
Received: from PUZPR06MB5936.apcprd06.prod.outlook.com
 ([fe80::5c03:58ad:fb2b:49d9]) by PUZPR06MB5936.apcprd06.prod.outlook.com
 ([fe80::5c03:58ad:fb2b:49d9%7]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 12:45:39 +0000
From:   You Kangren <youkangren@vivo.com>
To:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        You Kangren <youkangren@vivo.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Adam Guerin <adam.guerin@intel.com>,
        Srinivas Kerekare <srinivas.kerekare@intel.com>,
        Damian Muszynski <damian.muszynski@intel.com>,
        qat-linux@intel.com (open list:QAT DRIVER),
        linux-crypto@vger.kernel.org (open list:CRYPTO API),
        linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, luhongfei@vivo.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v6] crypto: qat - replace the if statement with min()
Date:   Tue,  4 Jul 2023 20:45:32 +0800
Message-Id: <20230704124534.1127-1-youkangren@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0022.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::8) To PUZPR06MB5936.apcprd06.prod.outlook.com
 (2603:1096:301:11d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5936:EE_|KL1PR06MB5941:EE_
X-MS-Office365-Filtering-Correlation-Id: 17726d3e-ea79-407c-8acd-08db7c8c9213
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mfqItKgKwPvJlEVZ/2k4qyAjgm2F2QI4FGUSswRAwYmN0zIx8VeqliLLnhp+RGUUc+bP/pYOiZpVrpzVs926Dq3Y18v8tBBs7G4dlhj0hb3BI/LrUcX7g1vuvIevzieraqY/hu5vMModpctvbQ7Yq+oG/5Bgt9qmRo1Wnii2Kqwk2Jhf9N82IS+01jvgL9BO78qVwDSV6lIvQK6NP+RZ3y4ElQhfwWU/EHDQw/T7N8HIbfEJthwnillcVBKwpQF4zmJmtROxyhChV9iHnB+Nq5fgwZlVD653TxbndMzSVAKsWPtX7XfvOE7we57GvREMWpnQrWyLkjR8Ae/3+Nu3j50behZqW1noO74/HNP1pgWMufg0WkwP+jTcBjr8zciHmsduBSDCfiLTlZY9B57L93DzFT34w/TiMALdKRVw86ZRMK+0TCrqDSpHA/CdmJqbSu2bgEvXFdWPHbPvQqqn2SPqhc8V4rIUirheKACRafUB/VJyJtWDy6DzsF9e51P7/ZchJpbOvn5NYi44sLaPTMlbaa+QPEGCqTcptKVr32Wjh0ni7beMobU6FkzcJiDVa/4bjqk6RUswgOYps+m/GrSqN8Z1Pg5YzZgcwsckJXunBHDKLQQyN+IdJV7VebYgrI4toKADbgptS3Dv5wSSCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5936.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(366004)(136003)(376002)(451199021)(66946007)(7416002)(186003)(6512007)(6506007)(26005)(8936002)(8676002)(1076003)(5660300002)(2906002)(41300700001)(66556008)(4326008)(6666004)(6486002)(316002)(921005)(36756003)(2616005)(66476007)(83380400001)(86362001)(110136005)(478600001)(52116002)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IGl20NRJISZCD9WylRUKfzMtqhaRY1FNAaKse9GPppeU8kWmglW/TnwjrxIH?=
 =?us-ascii?Q?fc+70Ryskr82KdCJrnHWAJrXrUcteHqOFwW8JbowAhUk6wJdxGOs9NF3g/Tl?=
 =?us-ascii?Q?crKCZE7Qlge8nE0KuFA7/3SmOoyIBw5PZ72o/ShPPTMvUss+E55QPZW65D40?=
 =?us-ascii?Q?luVOhZnarKfkyP0lz/UUE77UgFDZoVDPawMcMIn0jhhJUwnzcXJ0Robsivzx?=
 =?us-ascii?Q?NdURMpWc6epSq6iSqqmWEAyfWpaNZWvJlkf1JscwGcJqzjLsWhoRljBINHih?=
 =?us-ascii?Q?mbih0lAaFzZAVK+OGMkOi8l1n6SSLrsBuJ0YCiTkgEyzUtUctDGFT8hJa/Fz?=
 =?us-ascii?Q?Esgf4oBX+J44abkWu9+E+VKzl0mlKIaH7pQEQOGapi726Aa2XkGfQyZcHt+G?=
 =?us-ascii?Q?KK+cRL8u397UQvBOttX9G4/8jAsbKk855gPAM0bmOYZnZJFK3bqmfIjVjkRl?=
 =?us-ascii?Q?tIEClDlgFQIKPpzicJHrPibhzuJux0Ro8Mgbn48QSQ97CHbOwlEWWWXX9lHv?=
 =?us-ascii?Q?KPh7inKPvgYyV54zuSoTd7X0L95G0rjXZ2zT9JqJIxdJ0B6fOKPKPhfrEhaY?=
 =?us-ascii?Q?5h5NmudRbfzJl3B5XouPKf9cPYW9xGqjuffkocrMwdUV3UBJiChyM7sIvUVb?=
 =?us-ascii?Q?m7Kuex7+nyv5DPwbjr5DqM+zDttdcvBRl1NbOy5f4+U5Cx070SjiU2aDpKvr?=
 =?us-ascii?Q?Lg8c0lw6D3AG9HAvnhk/oNUi30bnuJQeKq6lvnL0RPc2rc61/Xq6eyQ/G9xY?=
 =?us-ascii?Q?bdkIpf/VY9Z/g7albyXzICGiysOzAv6QmlQLDsuuKfNH5JqZ8PzLid++O6gK?=
 =?us-ascii?Q?RDAF8ZVpKPQHdJC2UNv1OV5wagvZ3f/bsADpHw9cILcv5CZgXqVaKjZmJ6m7?=
 =?us-ascii?Q?cMJAYXzosoY66nyIFSJgH01EL6oGRd7qK51SPTlk59JJb9GFH16VPTMUmwFw?=
 =?us-ascii?Q?9mCJuOyv1nWkW/MfSBq/x4HSDTYizzrQLBsAajrPzBGjqkvZYpSe6TnHxHHi?=
 =?us-ascii?Q?bEyFJufoa8DQgia/UGBm8uajeOeBm5w7KFQPoHaeaaSxrgC8PA4X8wIcfko5?=
 =?us-ascii?Q?YHoYh2x6Z1iq9I0t5DpY7SADw8deQWl+uzIV4RzAp8hEJ3m3Z8QEKsbjEO5/?=
 =?us-ascii?Q?4M1KSM3kgV13ZaAHz487vPB0uXKBiKWqDbdkIfrDcBP5bsbsHFxQAWYmaj35?=
 =?us-ascii?Q?nRixAJ3Lgfyn5mfmhn4cWwkjOaBCg8lzfl95BssoIh1+8JOcKm3rfvnnGTb7?=
 =?us-ascii?Q?uF/ZQwYMpdXRilhlbPrwHBDK/JxvVjbf1XuQsj+InkvChTCTqK9tflpPcsrK?=
 =?us-ascii?Q?J9D6W1gXFK8WhzU/EL02Z5n46xFPHAYSbu1v4F6UWCSzVVTpf+Xtw1AgsV0j?=
 =?us-ascii?Q?eEMIX6ntepgw3u1ZMtTM+eGEe137DUGiycCg3PZQOkGX6r9Keixhsc/nDQzC?=
 =?us-ascii?Q?O7Fn8VLot4iNiyOYkzElmMJBERQrIOXCICZz/DDj0+QjH6Ll3C8Al0cS/Z0t?=
 =?us-ascii?Q?J7UzPuv1J1YKJJAq7xABqK76pBumF8MNhTxYVJxz+z9iQTZH/445RaRukwiT?=
 =?us-ascii?Q?7gv0a8Ke0mKZtYNMn2sNzKbwV7X1AlRHWA2xyOz/?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17726d3e-ea79-407c-8acd-08db7c8c9213
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5936.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 12:45:39.3516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ekgRoUOEF0VpY32N1sZz8lZhbbuXPXBzNa7isuL6Hh3eFzPoB1j79bDDpkl63pKx5JQnghKZyAoUUG4Xa1rMWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB5941
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark UWORD_CPYBUF_SIZE with U suffix to make its type the same
with words_num. Then replace the if statement with min() in
qat_uclo_wr_uimage_raw_page() to make code shorter.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: You Kangren <youkangren@vivo.com>
---
Changelog:
v5->v6:
- Remove the unnecessary Fixes tag of the patch
- Change the first letter of "replace" in the headline of the commit message to lower case

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

