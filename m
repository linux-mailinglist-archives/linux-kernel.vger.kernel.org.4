Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C6F70847A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 16:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbjERO7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 10:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbjERO6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 10:58:49 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9173319B
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 07:58:23 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34I6JD6q018341;
        Thu, 18 May 2023 14:56:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=tcZOdnB2lE1EqsRzUn79ee6riysqDWNmIuJsfyFVFnc=;
 b=g8PaJDZTh2msetZxgBtOVN7qQ8OOqr0xvyHlUzZLz3iQgAevuMqVMlr79xwP7/FJ2unh
 BV/Q08k3phN9PHJ6zXmGlXI6d1sA0pEmOibM03GSSeIc9WvncyGOLJ59fLC57dm1z8CM
 9/hFhzcfyNQYYRUIiBcIOIXY1RLEKcTsChYDhkLU6WkBW76lhO3OD1BonUmhKRA9a9so
 V4MPMSqTmd66lVYLJuCIzd37Zx+xulAsZrJ4CdGw16CFqoVDEJrDsVc7KtMJP7V/pey5
 d3QWQn4kvB0VBPN4Lf71uTUTKTOHHbZ0kmhtolKZj35yf1Zt3yGZ5CIdQ5YV6B7YWwfl aQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qmx8j2vpn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 14:56:57 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34IDtR7H033865;
        Thu, 18 May 2023 14:56:56 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj107c96y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 14:56:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ij3Ob0yjsdWkJPULN89P6c28ybI95mZZBJgzWfEkohNer62cF03QB8f854tRVlSEpk5hu8S5Ur55WAV994ZOk5W5pJy40R/PgyKGI04NF2pk36E/Rcw+bm8OKFeJmVbIFO07g3qeSGaFc+5dq/fGEdc5VQATv7BTkSxUAC8N1IUXN1+gt/U2g9UeTTlvdfrA/uZjVZde1zrwptc5SI3tVnQ0v5Rlomcez7HsYxJ4DPp0JSt8XneNaJesF6QNXtdZGDA9SliVKPfqmOmAg/6t4cG5hdWz/cgXyGANdaXWsHpNQiH52OH3bDax4JHHsPPZEqq6EuTGFOBIZ51vVOF4jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tcZOdnB2lE1EqsRzUn79ee6riysqDWNmIuJsfyFVFnc=;
 b=YUeKJPy940TkdWP1z3EKWh8nXSvEiUAhS6ckJmH16FdIZ3oGdY0A/FmKZmA+fRGMnTQZpZqdjTLNywHNIdyUf7HiEKFD51n+Pi/fA4sepwvZT+dhN5298gEXRvDIQjHySxzrFLh+iOebUn8klLmDQv8voPdYy7hcqBIj6TZ4nNqbZtSYNtcLa6yqdLX91gDZCj6keTVo0TbLRliw8Nf/P1+siWo0NZSTRNegVEpbFJps8w56mPFMS29kponB3bGlLySoxPebL9bcSgQUmuq3hSqAgdDnmYS/RBXOLLaYLDYyo4gesKUyD7jkm9pfw4ZPznWuLEItbxR3OjyNVS5s3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tcZOdnB2lE1EqsRzUn79ee6riysqDWNmIuJsfyFVFnc=;
 b=Wd3q0SI39EhBb96EjDEE+1AtXqzpZYPv70BnKfbZJ7RTxFd5wK1zZStJCYpH1XoXYXsa6UxE8yxqjGcULaBqzNLJP8gSH8m+0SrugF/FUH3nWkLlsHaJPEfGUHlLwmOxpk6d1EqXzmO4o6HAlQnChAqL0A7de7aw+AU5SJMdi5c=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM4PR10MB7427.namprd10.prod.outlook.com (2603:10b6:8:181::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Thu, 18 May
 2023 14:56:53 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 14:56:53 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 26/35] maple_tree: Fix testing mas_empty_area()
Date:   Thu, 18 May 2023 10:55:35 -0400
Message-Id: <20230518145544.1722059-27-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230518145544.1722059-1-Liam.Howlett@oracle.com>
References: <20230518145544.1722059-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0020.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::15) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DM4PR10MB7427:EE_
X-MS-Office365-Filtering-Correlation-Id: 89fc54e4-875e-49ca-3ee0-08db57b01e1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C+DpcvW8OGYoO2m4IPUSSw9n93qPPRRUYse+8KAPpGI9EiteVIQgk/oXGppANH757YkScq4HCvEimikMCbRAzcR53UpQ9Qkg6ER533JsaeADF25QXi9rECzyRW7Bfeg8IIbxjeKEDOkB+uMSWr1wvxSdqQx3ZLcIeYsrsb6eWg2WfPejQJz6LWZaLkssDeSgBWLniq4LbBEk3utik0Nz5iqQOmyxVFVzvizoRymHnj0niP6WOVgJG+1e1aDmH+bwfYxMv+SXDDSX/bJhUE7Lb+p24q4S1Qtctwb2ACMm7z5blmrJsCDYsUf8ojbsp9c70hSeX53oi5w1weyXMMF97bchHNTc0dXKkAaFuV2mqMQmnA3T8g+XQ/jLA+GXacpb7DrsgZRjDevUwu10fdN6f4pF8Z0Rh+4XaXc3PnWW90jEZYMT+q73Eu9g0BCnifJq8xuuc/WbE43/bLAcChHfwjvSryXgM18JT6h0RxmZKNxELzZogZ/XsRGEtOzpQOPBMEf8zenuP28b4HC3RfePLoziEBy27rOTiE7T5RYCyIbBGYWXKhULz6dcdlpxq3gN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(346002)(136003)(376002)(366004)(451199021)(8676002)(5660300002)(8936002)(4326008)(316002)(6512007)(1076003)(83380400001)(6506007)(26005)(107886003)(86362001)(186003)(38100700002)(2616005)(41300700001)(478600001)(66476007)(6666004)(66946007)(66556008)(6916009)(6486002)(36756003)(2906002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4w9H+HKVC+FD9Ies0a0ak+WG2VpskwiAQgbRz/KZDJOor942bL8eurZNBQie?=
 =?us-ascii?Q?Wzb4hOgObQsBKJzr9ufDZZGsZgpirjIenn+xcIAMIix2mbt01HTEJAQjspFw?=
 =?us-ascii?Q?B4iVMPF81SeKYrte7tsxqtofjcwMUmAJv12w4XIgRmDTjzkuoAct639UMM4S?=
 =?us-ascii?Q?Wm/c1nK6jl4oSpBy1uwicnwh67fNg3YmPaPOJ+Tunwya+Wu0DE89jAQ8+SjJ?=
 =?us-ascii?Q?b8EZ8IptPoZQlJmxdWubv2GZH+YUHrmrqtlNNvbRW1NmFNr2BC4l+LgMqWIM?=
 =?us-ascii?Q?aMVz3SJvWBgD6HpgTRqowTc7InU/qXWPvYqG2emw3CTlZQnjVxE8xRG8w8aS?=
 =?us-ascii?Q?slfq2THHWtwwi78Y6vvXMuxWlufnpJ0mfTlxATGy/YtHZ+1CFyQfnAI6BR6m?=
 =?us-ascii?Q?Ti1EZjCpdFSO4ytAsHpdU8jJn4udJKl18qzGPvhXBrA1guGUa6n/weQuTbsy?=
 =?us-ascii?Q?aONH3jkqUew+uI5F8ZnIIQ5ukEcKRyDEmWTWna+RKVubEOgaVN78dx5KjeyG?=
 =?us-ascii?Q?x5/+lOZrVEGOGq2Z74KPJ2pK5GeDg3hYQToaJB50l6x58oCS0sZiSiVrlSWf?=
 =?us-ascii?Q?/HWfU949IWhxJeRLpqD08RfRv+5+qXxPdcNDH8QWQTJmE4NDgt1HU6XqF7sP?=
 =?us-ascii?Q?ZjCN3BC8hcRB86IFSUVKVdk9QLVGfYrT0uCnvKEivp4jwWYpJXoKxe/BYlGI?=
 =?us-ascii?Q?RPX1UY+9dc3EDYMVx4G8hiGwaxpONiL0OkfzqZTInImQlSjSabt/cyEDgewJ?=
 =?us-ascii?Q?kyabuUfkMBEeZnsSR5uPj3tDg6oCUYA2hNXaWA91LwhxhZnGrBOHPx78zcW1?=
 =?us-ascii?Q?oxfeINxXIU1sAt6jUY04KZ6yp2a2ovuezU+3U20qI1/S6YBZHwE2t7xwxEi4?=
 =?us-ascii?Q?Mqnq4WSYkiBCRD+2EXoahwzreGufdZeKWUF+YxHoUFQl33emJr4xJGtt1CqR?=
 =?us-ascii?Q?bxW76kGiJKl96DcIo1CXUWodFyu+7l+QlfL0UBNAwgwUPEfLqv2rUHz0WePi?=
 =?us-ascii?Q?jkdXxWjVl+BlFdJSeGTHTCH0+hpFKWwCPiN+mmgHj3xw/FbXWi6zjltnZQ7U?=
 =?us-ascii?Q?s/NrqmPLkhbE3sYD1uUKBEXZOoZv4yDdJohrvTdJRlWVAlBM6+YVpW0KFnvT?=
 =?us-ascii?Q?agZTlN2wt/AhnOsxOBAj9xcv860LFeOZQu/D9Ba65aD7F5CEM6O6//y8tqj5?=
 =?us-ascii?Q?HqyZPCa6pJ9hjQE7C+OeWo0Plvh4A/VvQhKbq96sqF2ESJvv6XqsCfSPQSn4?=
 =?us-ascii?Q?fBc3gE9fZt5kUi/+zp3crl/sIk0mKEddiMx617CmUtAnbCXAsttUkF8/4Uxy?=
 =?us-ascii?Q?QwRYSHNyK2V8pyFT7+BpFptSOj8HcO6rtOhm67xvuvvEiIj+0RHasyMxz4Vd?=
 =?us-ascii?Q?LxJOxdLsu5g53Hm/2sEJnMbcZa4Pk9ZoMMhleyOh+bXF9zIJ9vF7grpsYlyz?=
 =?us-ascii?Q?luqot3BKYE13SJ7dStr6PQ4HdpJSns+eBpHgsIoeCh5Il29+wvKF7qBpkX8f?=
 =?us-ascii?Q?HDunj+rzqgCVuDewvVDCtJ2ludLgtKlp0+jIf8qBB7P9ykUYb10dwR/gWb9T?=
 =?us-ascii?Q?E1uiJ9WZi9IHozpC+WBO80jbBgoj5zgVBK14JDZ5HooAyBsPoBx7YXq/f2df?=
 =?us-ascii?Q?1Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9A/uY4q1OaHecaCNaxmpCaIIdW9PIhHTUgjN6R0XZf0fSADKzXCRbdlYXQJWn3XLrH9KK0BAbULimWRtGmnrlOvAi/ybIQRt6ZbWhkfSwN5KrUZRDcUfcbK8bkaPymbCjRf74Ru+u4w9LJH9h4Ah9N66CXmkWQ+YhITa02Iotg97ynRa+/wye/QbNSlgqr7Lhp4htA1CI3YIGsrFS5lrTFI5isdKsAqVhx1tGURC1P2gBs+n1hxq1CnoQ1+hY+uXS0obLVFhIbF/4nPKD37CuzAF4I8qfRXCEWucA0GyXgbdqvcxZc3uQ2hyyR8XUKeJchOrYHDw4WKAhkYxkusMac/5XQv8GLkK1hq7xXIhsF5d25kVA+4VOhZqnvf+2OTyrkRtgOnI4krym5EGpL2cMefKjHT2bzf/yiMcpzf/HOBm332YGHaglCFmE1Igaj+t9yVD1p+sRlTuolkmwl841dFPCLyw1RSMK4lCK9wlYymQuxWaA1ONwivhxW/HD1QSwFpgjLROm3lVCAoj2j3zacLWoDln5AoHZEMQa7InCHzP2aUORpIkiKV7ymtQ1F2N8UdzGKuCNjil/nBxAd+/PoL89A8/FuzB5Oa4E/0cN8ibeeYmfnk8RwqDoq+NoNRl2Z2SlzvD9nI+taDo/X685fDnki/e9TxpZ2Ff5przy6yUdH7+e33AuGqzvlwj2mt0+ULNemrWEg4F4Pft8x/Rk0Vm00f6g/P74exYk5wGzjtfmKUlAGmcUOjhsfKmVDhDznNBdmrkn7uC+w+ZUfUU+JpJPTHYO2ux/4PXdd6LLAhw9oRS11MORpnzQi7ourLl/L2gQWSZhI1ax8ZqtfaOs6oZOo0cVHVvxMNMwHlKLLhqLvWLg3k78vfe31FQGLhWsH97s0/12eCzFSqDA1tcnA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89fc54e4-875e-49ca-3ee0-08db57b01e1a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 14:56:53.5160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J20/t9t8Sg6P6x3/LwS7VALg2EuqUycTYLKBz4jdGtrbxr6/XUtw5W5ktPIfXjFrfbyclXVgkhN0rrLRVOut3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7427
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_11,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305180120
X-Proofpoint-GUID: gHueLeqjCrf9jMseF_IlNqjl1HsMKXtP
X-Proofpoint-ORIG-GUID: gHueLeqjCrf9jMseF_IlNqjl1HsMKXtP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Empty area will return -EINVAL if the search window is smaller than the
requested size.  Fix the test case to check for this error code.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/test_maple_tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index f167d6ef8159..d295fdee2fae 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -2697,7 +2697,7 @@ static noinline void __init check_empty_area_window(struct maple_tree *mt)
 	MT_BUG_ON(mt, mas_empty_area(&mas, 5, 100, 6) != -EBUSY);
 
 	mas_reset(&mas);
-	MT_BUG_ON(mt, mas_empty_area(&mas, 0, 8, 10) != -EBUSY);
+	MT_BUG_ON(mt, mas_empty_area(&mas, 0, 8, 10) != -EINVAL);
 
 	mas_reset(&mas);
 	mas_empty_area(&mas, 100, 165, 3);
-- 
2.39.2

