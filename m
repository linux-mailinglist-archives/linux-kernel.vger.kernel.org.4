Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCC16EE5BD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 18:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234560AbjDYQaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 12:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234377AbjDYQaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 12:30:17 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B96283D0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 09:30:16 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PDiZQG006067;
        Tue, 25 Apr 2023 14:11:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=3DfKy7f3QGztZoG4jh+vukpmsr5aWh+KzrUG3uqoicQ=;
 b=ghpWIYvtEN1eKmgENBEwrDiNTS4Igk9J9Q7APWdfkby69/zBrxXIMUXU4OJUMwEA6ohm
 dbbx8zHJokmrXWvmwDT4VwHRVm1UcrFp04YW8UIINuuOzArQJo/3PfKLpxjgeC6cOspO
 yowXIeZtsviWB5VdW/c0H+ZY5ypVVgThwxYUIKn1OnmESHUcchkm0CHsghmk1jOm4Lv9
 3b5M73ScVuXQduBDgi5TUr6QDcMnSSjIvZvA3TkoPUldrMnf+pyvMmQLR9Fdaa0vHAya
 RQFRIH/haekxp022k+FVAIQIsydO9BETFC69SwLbs4WYwm/YPI7yhRqiI72bfz1LLq0C bg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q4661wgpp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 14:11:41 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33PDUxeB006663;
        Tue, 25 Apr 2023 14:11:40 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q4616gt1p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 14:11:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AGY/Re3s7o3YcaU/vGnHRXfLr9sQagVcyYKR+ShQTnOgxIJo81vLVYl/4jGhhMRhrq4Tt3cx+07A5TR9lV0T5PxYh2po+jn2Nyqm8yfkMD4dIfetM+6VJG9fSS41rQnCQd9a5kVc2qEYUCW71TsdHkXpH62KQ1H4UUgjSobpwBd3K3uGC3U5uW4tNMW2IR0HlJVy7QpXbeR7vTJlcRo6SWi8tWCx00CQN+doNSGEcL2i14RwABfrfdjOXh2vAaVQPaYIg21IE6PPJAqSTFd4lpoj2XZgipwzWmSMAqK2XLzrpKyC85OBT7NdhLqUWwVGJBXAhllG8PscoynN7gBmiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3DfKy7f3QGztZoG4jh+vukpmsr5aWh+KzrUG3uqoicQ=;
 b=NuH97YwM4HsSa4hDwfkElOgAwVK/qeFvfTacTH0D2CjxpXxZVVaEKrlIgyV7Uga1TNB+TcvsqYi4ZzmictfMSZgjg1d5rkhcJu6DYLJhrIgrXdISbBdDOng1cK89StpUXCEW6R379CoYp8KNBz9gfuSIprYnNdIiAw3V+VT7agcU/MKenDHXoDtYeCqYTiEgHYi4FsaEHJIXjbOIFQDE6LvS//yjw8n834cmYHF28JbrOU/RSovzgcOfmwBldMQs/nyFkejM/OQ/wkF52bmxzTNu1mH5p9lHzRd1MFLnrqjNgsFLCLQFqSfGaTs/DpV8VP095c7ukqCmnzuB90A94g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3DfKy7f3QGztZoG4jh+vukpmsr5aWh+KzrUG3uqoicQ=;
 b=UanMrA4XNOaMbOmIq80eO03g1MW6VWxYszPNCKdr/yK8r+1A04hYYawUBjWnEe+wxQ6Ef/OpbUMl7+qOX2QoFbTfFqy7tly5uaT6SmQWVcB94N6PV+lsPruQtqfL1w9wXit6kJOEf/HESrd6nGhnpF2q9bTnle3aF1Icbuh+Avs=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS0PR10MB7125.namprd10.prod.outlook.com (2603:10b6:8:f0::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.20; Tue, 25 Apr 2023 14:11:38 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6319.034; Tue, 25 Apr 2023
 14:11:38 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 33/34] maple_tree: Add testing for mas_{prev,next}_range()
Date:   Tue, 25 Apr 2023 10:09:54 -0400
Message-Id: <20230425140955.3834476-34-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
References: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0135.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::16) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DS0PR10MB7125:EE_
X-MS-Office365-Filtering-Correlation-Id: 09903fc9-71b8-4d4b-0dc2-08db4596fc69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VXMupEzGnDy4wHfjrQGrm9jFrzMBY0xvOeCdgOLFJSM6jeGfosxbsOOjy/GokW/2BmXZDCqsQXI17qvvfXVXU886X4oJu7kqhKW2tMMwPFxymXc7VbhjftUyA6KAhGd4ldttS04ncok8OjQDbqJ3iA3+5FVzKukr8/vNCSybcmFvYRK5dbu9dQ+JaR5sSe2IFwPRVXn53YWl2YdXDc4M1mT2S66YcaP/1EyTfSe+VZl5cLmEa8Vg4P6EK1lcfLfl5FV6gvFpcX0STrYdj5s76ukvhnTW6z2WxbwkIEtUoRgEyE8sMRNgSWmBTlPb/K7fbKf2juDkz71Leny9rA8ie3qJyrNQKuMH8cCdzS3SH+vGmYGM5KJrcJBGnA8MJmmxHFnLJ0hY49rv9RInEGWeyVA+ngAHVWxsop1G8XXNgd2G6VKAD9Bj4yUeMfauJ+RU13pxjJMv9PG5T/Q8gJHl4WBHHEej0kJpTrOLmnioMcy7C87avmhhiMt4Zqa13pkV3d6epKltq9kQGtLNTmCAA9SUOeopIKtyOihXnpZBegrsHvvI28yzU6gkru8JD+zY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(376002)(396003)(39860400002)(346002)(451199021)(316002)(6916009)(4326008)(38100700002)(41300700001)(5660300002)(8936002)(8676002)(36756003)(86362001)(2906002)(66476007)(66556008)(6486002)(6666004)(6512007)(6506007)(1076003)(26005)(107886003)(478600001)(2616005)(83380400001)(186003)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ucV+D3VuzXfS/Ud6oIAmmmyq9j/blPPvzKjE0XSRXGH9YuIV4uCTSgVZMCUG?=
 =?us-ascii?Q?zUWMk7ICwCZcl+hZpg/TTvVrerqY4SwMaaYIh62DGj2ueyOeY/Ow0Ef3J+Ml?=
 =?us-ascii?Q?O/fgrLJ7/Gj+J8otDiwZ/B76x6uzMUWRigoKzV2fjWDE0jQFfWvkjPrRCQe5?=
 =?us-ascii?Q?hFinXgtd16QL5DZ6nOG/ppdDlpO461rOCmltotAuI3ZZam50k3YvZ+CVfVFQ?=
 =?us-ascii?Q?lYXHknCWaCUOYChIBlj0bQVxRj3FzBmIamuHOi9w9BhRXtWSoaRxS0ukzyb6?=
 =?us-ascii?Q?dazaeIlaWQz+/yyIC8/IR0H1AhaC5V8qv6Rw3zv45WsULs0Syr6Yq0oquJvb?=
 =?us-ascii?Q?JYbXbZIavM4IFsp4P/6foq1PA1YSB2JGiQ65osSy1iX/3svzwZ3m/m0loug+?=
 =?us-ascii?Q?umFhYGgj2tAddWmHFoqq5kcKZkP0LQHG5ISvT+zuFizxEjEKH5Oqsmuf+QeD?=
 =?us-ascii?Q?KXHvF/UUX5mKWRB6d1DhjGD4IGBqILLoNr3EFDlQXF44AfIZJ3H5aNJqRf7g?=
 =?us-ascii?Q?SOoIGRquEVa7+m6qRRU0g7FCItoHvwo1IlN6cAXR40D0q00C5+gnZENPrfe1?=
 =?us-ascii?Q?Vpj2CPnWAW9wDHjN4oQBF302MOG650FH4UdpKUuvIJlAE5yGvcYPqOAsxRkc?=
 =?us-ascii?Q?M1d5bNx3/gswpEDqVeSG9C5vfBjZACuBqZwv60nvnNNyrD8vFVmWwbdUdORm?=
 =?us-ascii?Q?GZxnXMLH944OSMnMjduXJ1RUlvMhZgEsY54jKxRs+q889JRfgyAU/HQjLd4p?=
 =?us-ascii?Q?OqJmuiSbwrROo3JqAs8+vFbsPj7PNDevGQMtgniAn/DK5A2Y1z1vY/PHeNK9?=
 =?us-ascii?Q?mwajyqRqsOhKdDBPOsk3f/lIpTDEF/EtuZOu/jeO/veQ5aYJpg2m1/nI1Yx1?=
 =?us-ascii?Q?1C2asiauhVc1AaItGsZJ8DBHo8ePMK4ZkTBc5+X5V3kUmZ/1PlTmzVAWae23?=
 =?us-ascii?Q?ActitOF24K+RWcmCgTTyUgTaPrVwcF2EB9S/TM7d1tB3xYs3timZFGN6Xb/m?=
 =?us-ascii?Q?rcOARZ5ghJvjf8b8akx1lzR2vPIlZs5ZDHPxa7+kPpO1neA3Jepn5x+gH/bL?=
 =?us-ascii?Q?/C/zJfZvnBLkS1yI7DyjpJYWyNv9ugIHpe0gNNJOeshGfNt/4gjHWVuR2nmE?=
 =?us-ascii?Q?B74ZcNvQ/oryhXS8bInbq4rhJkxHXuvTeJStHzbAs9Zo0lukrnyo/r/BzjiT?=
 =?us-ascii?Q?ltsbI5ggEYpP11gI6S9wEuh7xQKXDP8uEC84c/8agQ2ei/PhNRFTVDJIAxI4?=
 =?us-ascii?Q?HOuWA2mnP824Ol4rPbPiG2X+vLvwBRZiJ3gJvWKdyKjpOSvBzVQLV5fj4mwx?=
 =?us-ascii?Q?rZfyHiIDr1peK6gf+2DbXypRiGNbshHLw8u13Jvq5+Fnzu1SB9SobQ6CVgE+?=
 =?us-ascii?Q?qhvSlXMHTt5Zkd2AJPM2iXJCMRl1Sa3qsTD/HTMnyozjyewOeX2ar+AemvNi?=
 =?us-ascii?Q?Z5XHL29Cyvj0zIRw/HzDEvCty/zNyA8lfHbhKa7TW5Fvu8Di4t4l/7AAHXsP?=
 =?us-ascii?Q?fuXXKb0hSJ21zR9SSIP14so7zMFPBB+yCQWJ+BTl3duuXt7oTa5sOUJYyjEv?=
 =?us-ascii?Q?NTmAxydHhe9ODn1Pma3ATODE0jXE8Q5nx6GsOwlkx3OmoTKbbs/plqCx3R24?=
 =?us-ascii?Q?BQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: u4NMXoa6wKyocETEhcApDYRZEytUXTHxcEUiPNYyFkpfdOJD3E3Cy7D5oGHvSN2P08ki8x4DVW5+ywAcM5jzo9dY0aYihnuCwYgE2T9CWsX7OLeLfxYt4NbWtNgDdoqrTcqoo6s0c73cd1SU+X0MrvlKUVAOHMz7ibJjfBLXSfgoEUiVAVv1B5RNSMWP9Z0EFNfr6QKbxQG7mtw3iknp21KhpnlezfrFzUUOte8yqZD9Xy5ZFo7dwVE2vMe7rKxNk6XzxRE0rpf3ODZyKRN8S8KU+31zXJN0dnE7He064IZqO3PoK8YTp7sBqTBw/01s0QVqcynXf3YK7AdHNWdosAs8+cgEdUigoBQWD7qTqtk1jYgesz4YgqHYeEbNjzR/LbMUGcvho/BSSmxammCWLy5evA5/EWUeO5mWvELkU7cJG2AtJJ94UhNW0Dw4i+duPQc7r9MPjryRdyrLxDIjH4Qfto2FpTJ5FwGd9McuSDFxmfKbWxV4klqMZvIhfDltsQOjv4JI67b2bNuELioh0lpHo49f9QCH8VzzZqsrJmXEsydVdb1SWw8NNE5J9jo976E3nelSup80I9hNcEdf3g9a/wAFb7AIWhM+10F34weSPI+epyuReAxYliZCwiJrj7sHmFC0j7zEK8Fwuu2nTBqPvoTVgBYJyfM+9/a+vgE2cyZFP21r3l6/8j5+SypM4H6eyEUuBWlju4ITcGxy1XMN6bFKcAEv/U1q0lNr7K8+nKQxtWQcx2cq3OeYGWxz9JQnrrkbWm1/k55tpoYODStLQTEfUWf4tobbqeNWIjzHPEoJRjhtwMp06r56IA5RJLBxn/jRfTbpjjcq2wQ3BhNPtMiM2enO4ZSnVYqKjf1XjT9TRWAzLFvc4hyle7S86dvWRbcXjvYQm4xpFS746Q==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09903fc9-71b8-4d4b-0dc2-08db4596fc69
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 14:11:38.6045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GblnROLj/y93IeG59GyQCJeIFJv/Yg/6Z2Llsnxjp2Zcu7a37ZeyPubBcO7WMzZ6Jk6yIOQD/7yiucnVMNAErw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7125
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_06,2023-04-25_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304250128
X-Proofpoint-ORIG-GUID: _JD2u7UsrKi3xpWhhpuNHo8WsrdfRgI_
X-Proofpoint-GUID: _JD2u7UsrKi3xpWhhpuNHo8WsrdfRgI_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the testing for the new functions to iterate per range.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/test_maple_tree.c | 148 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 148 insertions(+)

diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index 7b2d19ad5934d..adbf59542951b 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -3356,6 +3356,150 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	mas_unlock(&mas);
 }
 
+static noinline void __init check_slot_iterators(struct maple_tree *mt)
+{
+	MA_STATE(mas, mt, 0, 0);
+	unsigned long i, index = 40;
+	unsigned char offset = 0;
+	void *test;
+
+	mt_set_non_kernel(99999);
+
+	mas_lock(&mas);
+	for (i = 0; i <= index; i++) {
+		unsigned long end = 5;
+		if (i > 20 && i < 35)
+			end = 9;
+		mas_set_range(&mas, i*10, i*10 + end);
+		mas_store_gfp(&mas, xa_mk_value(i), GFP_KERNEL);
+	}
+
+	i = 21;
+	mas_set(&mas, i*10);
+	MAS_BUG_ON(&mas, mas_walk(&mas) != xa_mk_value(i));
+	MAS_BUG_ON(&mas, mas_prev_range(&mas, 0) != NULL);
+	MAS_BUG_ON(&mas, mas.index != 206);
+	MAS_BUG_ON(&mas, mas.last != 209);
+
+	i--;
+	MAS_BUG_ON(&mas, mas_prev_range(&mas, 0) != xa_mk_value(i));
+	MAS_BUG_ON(&mas, mas.index != 200);
+	MAS_BUG_ON(&mas, mas.last != 205);
+
+	i = 25;
+	mas_set(&mas, i*10);
+	MAS_BUG_ON(&mas, mas_walk(&mas) != xa_mk_value(i));
+	MAS_BUG_ON(&mas, mas.offset != 0);
+
+	/* Previous range is in another node */
+	i--;
+	MAS_BUG_ON(&mas, mas_prev_range(&mas, 0) != xa_mk_value(i));
+	MAS_BUG_ON(&mas, mas.index != 240);
+	MAS_BUG_ON(&mas, mas.last != 249);
+
+	/* Shift back with mas_next */
+	i++;
+	MAS_BUG_ON(&mas, mas_next_range(&mas, ULONG_MAX) != xa_mk_value(i));
+	MAS_BUG_ON(&mas, mas.index != 250);
+	MAS_BUG_ON(&mas, mas.last != 259);
+
+	i = 33;
+	mas_set(&mas, i*10);
+	MAS_BUG_ON(&mas, mas_walk(&mas) != xa_mk_value(i));
+	MAS_BUG_ON(&mas, mas.index != 330);
+	MAS_BUG_ON(&mas, mas.last != 339);
+
+	/* Next range is in another node */
+	i++;
+	MAS_BUG_ON(&mas, mas_next_range(&mas, ULONG_MAX) != xa_mk_value(i));
+	MAS_BUG_ON(&mas, mas.offset != 0);
+	MAS_BUG_ON(&mas, mas.index != 340);
+	MAS_BUG_ON(&mas, mas.last != 349);
+
+	/* Next out of range */
+	i++;
+	MAS_BUG_ON(&mas, mas_next_range(&mas, i*10 - 1) != NULL);
+	/* maple state does not move */
+	MAS_BUG_ON(&mas, mas.offset != 0);
+	MAS_BUG_ON(&mas, mas.index != 340);
+	MAS_BUG_ON(&mas, mas.last != 349);
+
+	/* Prev out of range */
+	i--;
+	MAS_BUG_ON(&mas, mas_prev_range(&mas, i*10 + 1) != NULL);
+	/* maple state does not move */
+	MAS_BUG_ON(&mas, mas.offset != 0);
+	MAS_BUG_ON(&mas, mas.index != 340);
+	MAS_BUG_ON(&mas, mas.last != 349);
+
+	mas_set(&mas, 210);
+	for (i = 210; i<= 350; i += 10) {
+		void *entry = mas_find_range(&mas, ULONG_MAX);
+
+		MAS_BUG_ON(&mas, entry != xa_mk_value(i/10));
+	}
+
+	mas_set(&mas, 0);
+	mas_contiguous(&mas, test, ULONG_MAX) {
+		MAS_BUG_ON(&mas, test != xa_mk_value(0));
+		MAS_BUG_ON(&mas, mas.index != 0);
+		MAS_BUG_ON(&mas, mas.last != 5);
+	}
+	MAS_BUG_ON(&mas, test != NULL);
+	MAS_BUG_ON(&mas, mas.index != 6);
+	MAS_BUG_ON(&mas, mas.last != 9);
+
+	mas_set(&mas, 6);
+	mas_contiguous(&mas, test, ULONG_MAX) {
+		MAS_BUG_ON(&mas, test != xa_mk_value(1));
+		MAS_BUG_ON(&mas, mas.index != 10);
+		MAS_BUG_ON(&mas, mas.last != 15);
+	}
+	MAS_BUG_ON(&mas, test != NULL);
+	MAS_BUG_ON(&mas, mas.index != 16);
+	MAS_BUG_ON(&mas, mas.last != 19);
+
+	i = 210;
+	mas_set(&mas, i);
+	mas_contiguous(&mas, test, 340) {
+		MAS_BUG_ON(&mas, test != xa_mk_value(i/10));
+		MAS_BUG_ON(&mas, mas.index != i);
+		MAS_BUG_ON(&mas, mas.last != i+9);
+		i+=10;
+		offset = mas.offset;
+	}
+	/* Hit the limit, iterator is at the limit. */
+	MAS_BUG_ON(&mas, offset != mas.offset);
+	MAS_BUG_ON(&mas, test != NULL);
+	MAS_BUG_ON(&mas, mas.index != 340);
+	MAS_BUG_ON(&mas, mas.last != 349);
+	test = mas_find_range(&mas, ULONG_MAX);
+	MAS_BUG_ON(&mas, test != xa_mk_value(35));
+	MAS_BUG_ON(&mas, mas.index != 350);
+	MAS_BUG_ON(&mas, mas.last != 355);
+
+
+	test = mas_find_range_rev(&mas, 0);
+	MAS_BUG_ON(&mas, test != xa_mk_value(34));
+	MAS_BUG_ON(&mas, mas.index != 340);
+	MAS_BUG_ON(&mas, mas.last != 349);
+	mas_set(&mas, 345);
+	test = mas_find_range_rev(&mas, 0);
+	MAS_BUG_ON(&mas, test != xa_mk_value(34));
+	MAS_BUG_ON(&mas, mas.index != 340);
+	MAS_BUG_ON(&mas, mas.last != 349);
+
+	offset = mas.offset;
+	test = mas_find_range_rev(&mas, 340);
+	MAS_BUG_ON(&mas, offset != mas.offset);
+	MAS_BUG_ON(&mas, test != NULL);
+	MAS_BUG_ON(&mas, mas.index != 340);
+	MAS_BUG_ON(&mas, mas.last != 349);
+
+	mas_unlock(&mas);
+	mt_set_non_kernel(0);
+}
+
 static DEFINE_MTREE(tree);
 static int __init maple_tree_seed(void)
 {
@@ -3621,6 +3765,10 @@ static int __init maple_tree_seed(void)
 	check_state_handling(&tree);
 	mtree_destroy(&tree);
 
+	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
+	check_slot_iterators(&tree);
+	mtree_destroy(&tree);
+
 #if defined(BENCH)
 skip:
 #endif
-- 
2.39.2

