Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B539574A250
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 18:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbjGFQjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 12:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbjGFQjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 12:39:15 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C54A1AE
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 09:39:14 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 366FwsIw014172;
        Thu, 6 Jul 2023 16:39:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=La4Z+lKIizNK9+LMU6kCP/9Il0w9pgqeFSQkREsDHrk=;
 b=s9OeMNGOdkBzISh76Oc+Qx2yth+NcVeysr9qqQ/28+dXo8Fvio6eVRYiEXBH9Q9F852x
 9RK3IoId5453w6poqLYqt/QHFJtefML3NdH4KhorSsCMLsF3HiBEH9d52+Q91g2gfwjK
 14HohvwFE1rHUZZNsh44mKp2RsUYVCpiwFFu3iTrC9VyvLrOQYTDhm4LdV9dObn3zrJp
 s+W5fWqEkL71xd8mvd7tE3rL1xexJQL6TzNtVU7aZzdwjFJqe3N4J6zL77u9n99rdQQg
 GKxdTyK3OBpm0vbqlMP/PQqpeTyaJDYFZAw7IYLNj1Qh8wRXPlU6ugPk9WvYTTm1Fsd6 ug== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rp0nw03mj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jul 2023 16:39:00 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 366GYVLg010307;
        Thu, 6 Jul 2023 16:38:59 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak79pue-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jul 2023 16:38:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GNkMpMpbsQgomKgO/2T4nfVhJqXN+IVTpA2aelX8rKqPxrn5f1Ptc0+SJ1bqvRsc3idfSJvNk0jZx9fE/gQAWTan/t2uBWwwC21z/Qh5tTpVG0fEgdi2HxCxqd+x2Gm/8ZmPKgh9CwT5CrvVFxJDt5P+7Z3QU+0Y8zEVBMIWPWXCgMsy5RnxQhIa4TOV/iAlXOHVINbLdFPgNLaKUARrCdGbD1JZ/rxqr+cQsWhBMj8TrBpmWLGvdrD3M7rPmsdJyz1TrzUNpRgB4VYcA9QqR0bJUbcJhB0Kk8vVrzBDkb542K/M/3E2RlxB7MXmEk3n7MbB6Gz2dpSI9WbyY/9dHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=La4Z+lKIizNK9+LMU6kCP/9Il0w9pgqeFSQkREsDHrk=;
 b=mpeL6WyrQ+5Mbf+qtUXd6AakX2vvyCP1F0viUHatXxbY1hZwlUR1BAqU3vg3ZBNxUnrflDefNq7Jvl+So/8Zn9JXx0QU6Io88rhvqc/tc0Ys2+1QOQcehM48K3RJ3f0VPJDPd664Ta/ghaSUON9lsuYwe6WQixORyIYJRYWBScidUeuuRPd0bc9nganbzlnVEfrhoCHs93cc/cGa6V2GoyzZ7JViT4Wi+4Ck0cLcYrqiJgYGmrmuK+5YhW1R4fCBmvpJAiU1g63zSrVuaPT7eGwiFwHoB1fmpPTa+CS45TELCeV6xNors/wim2H/48UmultmKWpIExvQZZTVOpv+eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=La4Z+lKIizNK9+LMU6kCP/9Il0w9pgqeFSQkREsDHrk=;
 b=fIIHc9quLk8cQxTFKlECYBOWG35cK53Z/nfsDk78w7An5hMVloKMkwB8zg8gRStYPr1ryRxtjBac/zRiGmzhtMTW5HnOoTXrv0rHILbJiJtHPaewfohopqtpBaBPW9XHPiBRisAYHn5LOvXWySjs65cIq29pcNBgvJ7RjEKwBsI=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CH0PR10MB4955.namprd10.prod.outlook.com (2603:10b6:610:c2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24; Thu, 6 Jul
 2023 16:38:56 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5%5]) with mapi id 15.20.6565.019; Thu, 6 Jul 2023
 16:38:56 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        zhangpeng362@huawei.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v3 2/4] mm/memory: convert wp_page_shared() to use folios
Date:   Thu,  6 Jul 2023 09:38:45 -0700
Message-ID: <20230706163847.403202-2-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230706163847.403202-1-sidhartha.kumar@oracle.com>
References: <20230706163847.403202-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0024.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::37) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CH0PR10MB4955:EE_
X-MS-Office365-Filtering-Correlation-Id: a6c958b8-95db-496e-3a57-08db7e3f7dbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PpUh+5NdLaHK1h4YNoseqVi2fYwg3kLiaL1X7t7V1uwzNvBqzOtOyWzGrnwTZQd88L8dx8pSOU2K5w2znep+77xK37nO/Qu+VUuzhwJvKWsVsrqYktLkZDVSogEX6g3TqcssxNb6H4igO8RA14StX/a6MlpT5okG2dr/2ZkogFp2uT+8xze7RK9qAzwFX2/cdwsIrzLkuINjp7qZIr3P/Y5gvRfY123DmmzQM4BqhpDEYZKbB7nkBLwAjJfctVFn/a+mCDpfPczu+F6h0vp+hQQeGkpmPQ0kpJWorinUW50hW7EX8/S8CbEMhrH8cVG8qyiIqYaPKIMDpdg4lOd/gKWWEx8ht1PBhBBSO5c9IPtbpv6qpkEjlymOGHSLF4vG+ki8Ea51ElvGwiFVL11HAgZjVFOu6acY9jcGw3zNnjWAST4WYmvBa78jNqgPOOA4W5AxNTrzVQc7jLPSCt30KeTOU/uFGyoMx0mxryGVmI7VSvaLetyfd5mtbCFG53MSQfq3nxfCuCY+Qlh00yGavcf/1gTM8fSIWUABxIdd6bPgNgyWQgrSCX+8RAa+Q88k
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(396003)(346002)(376002)(366004)(451199021)(5660300002)(44832011)(66476007)(66556008)(66946007)(38100700002)(4326008)(41300700001)(8936002)(316002)(8676002)(86362001)(36756003)(2906002)(6666004)(6486002)(83380400001)(107886003)(6506007)(1076003)(186003)(6512007)(2616005)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2F3/QA9OUtXUXpl2Pv+chwn+CX4Md4nuTp2oTiilfIfBuwe60uwOu8EOn8++?=
 =?us-ascii?Q?zNgi5b8pe6pEpfu7f6RB/2X74/rv4/ZksEOeApjRhIVtJjL/WpF7as3gvR7z?=
 =?us-ascii?Q?1/DOVlXKYdjJVZKB7WQT0Z5PtSgSKUHZCv0A8hfDPPcYHaID8z2Jzy+mx+lS?=
 =?us-ascii?Q?6qDBBT94fT80mBrOg8Jo6gln8cFn6COPawD8qLBJoodyLg16bxWhpRLWAW1X?=
 =?us-ascii?Q?glw47Pc0aQWrgz+/Z6cwnBVWcQV+1yHVB0sHjKu3zNKfVf8T2Zpd2fxCFLfq?=
 =?us-ascii?Q?j2OeYsrwdQz/pWeT4X1X+7O/9AwPE4fA3+eonXaeRjJO1+i/ViSwQR8RGNvJ?=
 =?us-ascii?Q?ry6ehpEUYcmUJOtOEgpXMi0FAvi8giJpnQU4CEV7bb04xyPqCi6cRhDt4mp8?=
 =?us-ascii?Q?0Jx+5VtE5YzGZaWUlWNxiVObdLHshkC/5i12dCLQTWvVG8nG0mdIWPXX/PT6?=
 =?us-ascii?Q?5Qq5KLMF+xpjaBRCF5RqK1ScywVVavAPZAbk0PaMaceLnkukgaQfbyQP9Tsg?=
 =?us-ascii?Q?5pMofRafVvlMeRoISqzG3imVlNZ/eubEqQAvnUf4+PKg9xs5rzjNqoBiBjpS?=
 =?us-ascii?Q?To/JYnQ7/LXqZ5tU+nDcC8P+skB4YD5JzMd3cIjUuxn/zWWO1dj9uwgsee0B?=
 =?us-ascii?Q?gstZCRnBUqkiKMo6mFpoIJwpQMbWJxl6+IXJfSdAg5bmMEq13tfLqRNe7ohf?=
 =?us-ascii?Q?uvom9WkFMALJyTnHYIS5Kdx7NNdjCQJGrZkeL/kv3Uba9LLm/MzwqI9jncQ5?=
 =?us-ascii?Q?2oJQtg3uSXBsHMM3KfRCp4eYWq9RncHTt64JrQs9+T6/QxVPHqQ8L9Mo4BQH?=
 =?us-ascii?Q?I4lOI/fVVp12dm4ymsCfC9zStgKJoB2tb+O7QFKst+Slrvo6zmk9fXpP/Y5M?=
 =?us-ascii?Q?SMgdJTxD/8OViYc617QTu8i0+cFSfCGxjJUKiOEEAbEgj+HMNEwwYcuLWXaU?=
 =?us-ascii?Q?wnuoOIhC/igzM4liEvr54UCsikwnGOE7RXNrVS0AHlBaoyGGVAZNTPCK6bD9?=
 =?us-ascii?Q?DN+kx4HLXEk77obhPUfC4bOxZP6e+3nodFIXixIovp/Pz//sBcMgR2TvlTWe?=
 =?us-ascii?Q?gsvl0udsJXIVVyr2cLOnSY6jGtA2zsQL3Uj7PScKThJGCAUwkI5lMH9WpPwA?=
 =?us-ascii?Q?uEhLrTU/3mpqsdnDwOfX88SqsLw1ouUV/QE3uogCfgmPbA7o3q1bX04e0Sg6?=
 =?us-ascii?Q?g6tqnQZH4xOP+ad/BKYnUJpmgUMEXMqHNRL9+ToI3hDT9VX1kw8NvyYMehu+?=
 =?us-ascii?Q?c8l975H41DBQC/7cm15OXVBwjQuGh1pws+PaRkNTLpjmWuGFg4KUE9lfVSlG?=
 =?us-ascii?Q?o8hjTCKE2tr7djsXdVyZ8YZvJkzRDGfpesqcvvM7BHOGG3i3LD1S9H9nqxQk?=
 =?us-ascii?Q?i2b58KvQhjD1VEmDdbgUnHPI8Hih95BHrU5+MzUxacN5tNMizMJ2QCa8pLM2?=
 =?us-ascii?Q?04/dpiLX0SuI07umQXlcfXhjeTVQBkv32SkLKWERQSL9kSEXaElzW3qJP6cu?=
 =?us-ascii?Q?o/hQtCxWKpo3zh9TphXMexC0Zd5pCanx4BizBdp0nqvuq2nSOPGaDPZclgSe?=
 =?us-ascii?Q?ZbnrQF3wrVUnFoKyKcUS1C0WJljw636ULc+DZlH230Zq2ar5uITdwWYK6W1f?=
 =?us-ascii?Q?9mxDWLi4cTUVkvX8e+aasTY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gltjr4x/81QellTs1z9Rz8yOfu0+8R1BOp4UDQw1W8hzZkZSe/9oUP33duSsbL2Oqft+SLG4cPgOod5nQD/KINvlYzi+BcrvQYnVHmVKMq03W51PHCvax9At1oEF/iNTgNCbqqbOTl6awrgN/FiPa9UOif6NP+SNOWDEqF7bwYV9wKf+g7vz9gv64qg2FqDZfahnM+vdC/cb9+QNaLYG+uHamKVuFpB993jIRiOuxQxmk5nGYXBenlMQcjHJdqsWB25rok07EboAFfwuy81ZOaRZHHeOynKj9YH1hUKGKhaE6z4fD2r82Ob/3rcy16073xV76REq4aidDrxSzBXCaZGXTCFdxTX64zAhL182YZ+uRIm+3wfW5S57GbrsOwGFYH0EjITL5HRYO/2P9WpNw+30BibYoL1h+IlM3fcz6Uibcl5EcuMpd5IvJ5IuaAn5WKJij0LF4y0F/gUY6vEEs2pFPrAy+3f07m2deoSo6EzzmdDH9RUi2G090gMxdHxSpnmuPa5yXHOp7AQgq+qFMgO8pHQktBNyEdJoyGAELnG0NukU+3cUd0VUBuPoLPkaQZk6CAVBofE6cyjVjrVJeOU2bw96wpNhM56sPZzoLFLPxUauU6vYHtBmpR4mKF8Mn3HuI3B1q6Cv9Au/EZfR9slUEEfh2+l7/x1oJuBKWxMzvf21Ej9yvvfn5w5FODvTHfaNkMxGJcJ0foPWKcOyFBgex4xlM0cFibn4jfdqUgmLQln7/QsIMqFACB+ZBOXoCl6P0jxQAqgQHki66Bf1jHJi792yXKVmspXB6L/E3n1y02J+1FRBn5PKqmj5srseroZoZGx7uGYsRkjqcTu5UNbRaWFLn907plg9jtobweqrUcOAittzjStqyqTeT56Z/iIf25bjkKuzy9cXKbPIBg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6c958b8-95db-496e-3a57-08db7e3f7dbb
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 16:38:56.2418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tU+iqB6ttr43aJwO0j5V47jbr6nZx+G2ODcK3rgl3qaGHHXEkQlP/YXw6Mm7oQKNKQ4/OxHKoc2W2kXzI5SuHUwLbIa7Yid2UJklzbmuH0E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4955
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_11,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 spamscore=0 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307060150
X-Proofpoint-ORIG-GUID: 6rnXGtSvtB2SHbdrWX9tGa16FLQlmblg
X-Proofpoint-GUID: 6rnXGtSvtB2SHbdrWX9tGa16FLQlmblg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Saves six implicit calls to compound_head().

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
	v3:
		- remove extra page_folio() by moving up folio initialization
	v2:
		- change function definition to pass in a folio
 mm/memory.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 1736a130fa829..673b9fa67d0d7 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3285,13 +3285,13 @@ static vm_fault_t wp_pfn_shared(struct vm_fault *vmf)
 	return 0;
 }
 
-static vm_fault_t wp_page_shared(struct vm_fault *vmf)
+static vm_fault_t wp_page_shared(struct vm_fault *vmf, struct folio *folio)
 	__releases(vmf->ptl)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	vm_fault_t ret = 0;
 
-	get_page(vmf->page);
+	folio_get(folio);
 
 	if (vma->vm_ops && vma->vm_ops->page_mkwrite) {
 		vm_fault_t tmp;
@@ -3300,21 +3300,21 @@ static vm_fault_t wp_page_shared(struct vm_fault *vmf)
 		tmp = do_page_mkwrite(vmf);
 		if (unlikely(!tmp || (tmp &
 				      (VM_FAULT_ERROR | VM_FAULT_NOPAGE)))) {
-			put_page(vmf->page);
+			folio_put(folio);
 			return tmp;
 		}
 		tmp = finish_mkwrite_fault(vmf);
 		if (unlikely(tmp & (VM_FAULT_ERROR | VM_FAULT_NOPAGE))) {
-			unlock_page(vmf->page);
-			put_page(vmf->page);
+			folio_unlock(folio);
+			folio_put(folio);
 			return tmp;
 		}
 	} else {
 		wp_page_reuse(vmf);
-		lock_page(vmf->page);
+		folio_lock(folio);
 	}
 	ret |= fault_dirty_shared_page(vmf);
-	put_page(vmf->page);
+	folio_put(folio);
 
 	return ret;
 }
@@ -3365,6 +3365,9 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 
 	vmf->page = vm_normal_page(vma, vmf->address, vmf->orig_pte);
 
+	if (vmf->page)
+		folio = page_folio(vmf->page);
+
 	/*
 	 * Shared mapping: we are guaranteed to have VM_WRITE and
 	 * FAULT_FLAG_WRITE set at this point.
@@ -3379,12 +3382,9 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 		 */
 		if (!vmf->page)
 			return wp_pfn_shared(vmf);
-		return wp_page_shared(vmf);
+		return wp_page_shared(vmf, folio);
 	}
 
-	if (vmf->page)
-		folio = page_folio(vmf->page);
-
 	/*
 	 * Private mapping: create an exclusive anonymous page copy if reuse
 	 * is impossible. We might miss VM_WRITE for FOLL_FORCE handling.
-- 
2.41.0

