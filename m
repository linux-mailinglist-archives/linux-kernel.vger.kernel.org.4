Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B4E747844
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 20:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbjGDSZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 14:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGDSZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 14:25:29 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A807E72
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 11:25:28 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 364HDgRC017750;
        Tue, 4 Jul 2023 18:25:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=XSvx+eef/UaNFcPsTdv7T6GExYtWzb/XY17SvtvDVx8=;
 b=Ke9PxH6Vx5w8HNngOsFJ0ZB+LJq/fDX0lVhbnGGLqyOxsZU43Y0BfNsejded/4uJS6/U
 mBYKgGur5E54Z+k6lB54g+fffGDvX7M8ghe0hniQbeQz+H6CvlO34cfWyKCyMDEYdtRh
 scJFLPsUccykstbGKuCu8tnRKVty+6G8sRZPVv+hkKEKtnoIialoZIzo768GtXlzL0s6
 LkzeV1m6M43CXoaC21fUL/MteP25fDOK19TB58Rkjq7mljOiWdtl9nWhWEjinV05+0S/
 sN0gflMBnyq1Z6enqvQsQ8nEZmgNsTAfm8lPzs2ypes8KXywXKqpwkf+WJvqEY52RDq3 qw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rjc6cn1np-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Jul 2023 18:25:20 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 364Gmr4e039494;
        Tue, 4 Jul 2023 18:25:19 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak4nc96-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Jul 2023 18:25:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cro/nwfOeBLTFATG5UV2X4ZIhjyKhGN6M6zTuRrP3K3CNdoLshpB3/rvlBJY7WCZ/xD3Ys6LJR+ribrFzLgCyH/VL/p58mVyOq7H0C2qdl5u7VAYBjxTmMiF9bSr14ZuksXS6FWEcAmYYKnwQFf/ACe3xgviaXXqlgdc4IwGdKt2KpAa0a61lMfjfegeWUIw7nxQ4xIirob3Rvh8+AP8nl9N3WhwqDBii0WRZkaQxAj9qeTUnv0vX2WrQrYmmzu1Ki9lS42Gk1xANlqceJJGUlSZvWFaEAN3bDvlNukhk23WlkbAOYCZRTNS0BdaFuj68IaQoPlBZ8wWdSMIlufTGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XSvx+eef/UaNFcPsTdv7T6GExYtWzb/XY17SvtvDVx8=;
 b=U6Hi0t8GqQ8ViYQ3mKBrrPPUrRnwI2bzOfIRTI8BD6+tUwTmteriyrKe5emGmIfJxMiSY+Ut77zwDZFMvU3YDw1ftpz5Bf3uf00xLAV9GRLKi51IvfQWHRbqnFDYPDQdrolJE5EmgZBCzwOUPJf2IMN/1xnAtX2SfyP1QW1UaFRPzCQ8nAgIAr98XXsLEm3y/lNDIAePMWxT10DKtL2caae9mBfa2ClgOp81hR5x5K4SqCXY37l5mRF0WKgef/tF3qpjo/lqs+PUHvoDp2vomR8fXinR3ezb1lPyfnuDOpbkv4qnrqNSD1omgSbKGJU0YHytLkc0DZuKnCPniJAPLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XSvx+eef/UaNFcPsTdv7T6GExYtWzb/XY17SvtvDVx8=;
 b=lW3tJ0ai1tJb4CJgTei3ifxI0/Zco7qlBj+2MOBE4tPK3r3jRfYVnI7KQhD4yazCX69dhL/Af4iugwBVWhcbpowgGAW0JwfwKRLnUB+uhliD8cLKp4JUvzMF/Ho1kIRJQrmge1TU+rw9klQZHODmB2lnpQVI0tVefktT1FZKXlg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BN0PR10MB4871.namprd10.prod.outlook.com (2603:10b6:408:128::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Tue, 4 Jul
 2023 18:24:55 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 18:24:55 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oliver Sang <oliver.sang@intel.com>
Subject: [PATCH] mm/mmap: Clean up validate_mm() calls
Date:   Tue,  4 Jul 2023 14:24:42 -0400
Message-Id: <20230704182442.1015301-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT2PR01CA0025.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::30) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|BN0PR10MB4871:EE_
X-MS-Office365-Filtering-Correlation-Id: d45d79f9-2a1d-4ccc-9dad-08db7cbbf75d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vp8ftub4SW/VjvN7E/oUM+npgypL4NENDJ1o51mb5IYxdz2sR4g3QH3xnlFJKMd9IoOsefrcXku24+Tvb5yxXS7Lzs1V9tIBWIhWsuEx0UFk2FXEqClZx8iwNylJREFLi16QAqHr8/n6gz7BHxp3brASitssWt4TR1iWky5SdcXq4G8uT8fshDEiKEQ+xq8NKvOel1ZtX+nWS6vLh1jsEWFmiQPiZmVlnOFkN8Z62b2UZ4OAWUil1J2mkwfnsv1pCObNGo4nGD7MqcG3DhdF5RQ0k6Nmhq81vvuKUy6ER/aMFil0M59XglKInxY0vrrlzmxmv6SUo+FdNg9+UNL2fCx3rr6df6c/jqD438s/HqG9N5fGfElgAdqpWELAMP0twSR25P1akd6KLNuVyKBNX+6F6pGAwY65qhOutLeuwDRFrx4fyCgbRHY1nLcwL4p+vQBtdKiQGn7e0ukkhWyCbqAh+UsHchf+HbECOr8mSjx04Xr1kv2ZBsyzZKMTC6gGv3p2TkNTBDgOGavDIhDu1hCLt3zckf5Xr55e2rQ33eyTwsHsiQRFpyBryJx+98cq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(376002)(136003)(39860400002)(366004)(451199021)(6666004)(6512007)(6486002)(54906003)(478600001)(83380400001)(2616005)(36756003)(86362001)(15650500001)(2906002)(26005)(1076003)(186003)(6506007)(38100700002)(66946007)(66556008)(66476007)(6916009)(4326008)(316002)(5660300002)(8936002)(8676002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bkIt+e4LADnKyzr1ZAdxvb32cMzfNTIpPXivFjbx9b4vZ51x972ieCjdnNlY?=
 =?us-ascii?Q?DAxqDmO9eywyYQ8NWgbCXLjeRlzaH0vK3vwpi7tfdUgAUZpwIut01G6bzIhl?=
 =?us-ascii?Q?ZLQ7l7lkoMduo9kUVFTozR2uGOY5hWLBrkdLdavGsUNI6ZmA1y/8oz5/edF9?=
 =?us-ascii?Q?mRSL9Y8W1d2+0KzXd/+ymnwVahvTHsCj9+vy2RNIaPQPiAjWbYnIwNVkE8O0?=
 =?us-ascii?Q?5H//ewAOPFBx9rbw4NkEqv4+4bphUhouVGkzyPzJH8HwL7ZKXFbmPceJZW6V?=
 =?us-ascii?Q?lK3HOVSAc3G47y2aek0CpiKfWhhR1pp65fhWsPOhNHR4M56hfuUQQEruqj6h?=
 =?us-ascii?Q?QPo2x+HvuOSlzV2BcyoqnOyXhoDi1VpYs9boStNsmIqrQrHCsz15HTVxLteM?=
 =?us-ascii?Q?z+UdJJsnQ3zH++9m9oe56LQCQ/Rf5anCjLPDAMi3P8Hkc7AvfbyG+vhZauiv?=
 =?us-ascii?Q?NcsF6PoLrq5U/NTowaXkZe30mn8poG3Pi9gGL9k6VbXpwpDWqkMOw2OmvRS6?=
 =?us-ascii?Q?UKOJsiRX384PFIoBbZn93/JyrTCeNw4DlJ2B1EpmbkVwhkk0T5ENJYmx2GDW?=
 =?us-ascii?Q?IgeBs6oet/auDUQjOSv0g+offO6B9fxXOIT03R3y8lRlUp5KutL5ogOB6WPY?=
 =?us-ascii?Q?OA10mr6JYdTjYQSWxE5qDJBSthRpRDaXUmBHaCFL2so6PljAH1oK5/33GiF1?=
 =?us-ascii?Q?63UGrbhfpJLT/11LDcNzskvVKyBNVWB1epjOwoc/pe8kcRY2canuu/FVZgBz?=
 =?us-ascii?Q?RVd03ht5ixoQ7PoFGa7qHFGjev5PHm8XpxAmXWpkNmdfJdHgIs7yiVRRu/9v?=
 =?us-ascii?Q?6b4gBdQ0SZpS3wEKRXl00XcXcgNk1WC/ah3CslVe5hAiL4lAXGPRMDp0N9Bm?=
 =?us-ascii?Q?YzN1gVyXENQ86gKw2DmTV7B7XaTiwdMMjMl+3b3f5EooukPU2o2zLXlja+mx?=
 =?us-ascii?Q?NVdNVB+dmHgURm+PE8wW1rq75EQ4VYuqpMgZ4apCnwAtd4/zjLvNghczBC8T?=
 =?us-ascii?Q?8spB3ASrw1irVKi4PBQ1PtI19KE674qTCLpee+z6ZbRaZo9cvqw3S/wz8nMY?=
 =?us-ascii?Q?4xx0K7/qhCl3AQ3Hp1dlHoEblhqoTO/42I1IMTBHDBN/vUFwsP+aaNgQVPaX?=
 =?us-ascii?Q?hSfODpJcw2T9zFlFFUNLZ29kljx5xXsWRyjB2G5hkMagh334cqwmt0vyxitg?=
 =?us-ascii?Q?g04A1hN0sAgRsDvqEUPfG33VAn/IfeDA7CL4nVeSjTRFlS9y2Ru8UBD8wzm3?=
 =?us-ascii?Q?ZVxdvJNYgII6qqUl7R6fdaPPpt8S/fivy8ZxJpnFiloIVRTtCHw5fe9Id99Y?=
 =?us-ascii?Q?2xP++p6WnF6SX5Z8OKHH9OASksP0WpRGJ32Drw48zBfE6UApziVShnQDVpge?=
 =?us-ascii?Q?m+ZtukU6aqqEe74ZBDEFriiK0q1MTifxTYnz5rie3ZdeL1sTQfzI5KRX+rXg?=
 =?us-ascii?Q?Dkx0NoLNOAXnOrFDL0xT4nj8CYdxVWl95rPmrPjsfh5ARoSVq8rdEMYRgiS7?=
 =?us-ascii?Q?mmi/6ydMBWot8aSgdSz57ofXz3n1Dsh+B7FRL2LpgVD8VTO4WC4hsCMyrlUe?=
 =?us-ascii?Q?TXbcqEoRdvXb2TWLCtNfiKD3zQvCxxFmOIDETvdZEx7YV6tVzxe8yJ7QAiPQ?=
 =?us-ascii?Q?Ng=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YnPfh5rDHsTYKV5tx18RSo+v6fh4cUPhevv7bP443ihY0hynizvxisTXX//mE45mg+SEvnWouG5yp3GSXfn8XxqzKCBVT5m/kLaBH+vTYDretNyk7ayhD+6UGomhkWcjQFEgX3xFJcR9ArtfPCK4/xQaBaN+q9MxU30+7P4Cf/zT7qHmf5JvYHrS8uZgWCbM9kpas4on52GOLMDAcM3+XY1m7mVAqyCI4aTm9PV6kWXFnkdpcPT0m0cO/BUzinlMZvQtyQv4OYw47bflx7sxjBTer0HQpn/oNmsOPoWY2jJ12MxLOtXfnLjf7qMfgEUVRLoBdFqXDD8WZ6b0lmCqC8Jty3jflMG201HY9+BEJGgM4aKecESKY85/O/5hDqj5ERBaWqE8Gmb09bCNh0j7iMpB43+ma/a40O6v7enhnqZAqdzrl7Aa8FsuuCeUM94jhlz4GYaDV1C2tuzypYrS6eBPrCxGXROi+FhJtxbnkI7PlHWyP2M2Lffgl9LtBodI2X36xZV1nv7GjJqDM5AQoNngI9HR4Ptt10Le1ncQ4rzKSvZA62d7dPD43b1LDpZUmUWYMdIT+BPgdB2VboUkOLojI1Nu4UiQ6t3QouTii0xqImCShRfslhpPTTlKFuZmqUSprXGoPKvfo3O/5eTzCPpaez8KDcfOLPtYYPJSkXmwcf47NyRFuvUtSPsmEFliODh7bz141+o/Ax+ye/SQwkkGAEgIjDOG19R7VnkwA8glrmwjdEknrkjj+uMKDfRPxgnrtRBgDE7L9sfwLOw13ZpjptHqmpfbdr4EvE7DdtK70P19w//eFbwk7eZHZ37GbsFhaTzGwmCE3KIr3P5b/QFVLjq96g5XgUQtWeMMUA2oi3ulhBhCeju6lEZL0sfw
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d45d79f9-2a1d-4ccc-9dad-08db7cbbf75d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 18:24:55.4904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cmjs9AYoD3xW61sJN9vht5wZYFLKtiVtJY92o77A2G6oL9iyJtwO8Y58QbQNi2SaSmPenUv+vjMWz1hwT2rvEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4871
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-04_12,2023-07-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 spamscore=0 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307040159
X-Proofpoint-GUID: ew8SxjzSzUSlZ9lZxkCGGeEBYFWZZqwt
X-Proofpoint-ORIG-GUID: ew8SxjzSzUSlZ9lZxkCGGeEBYFWZZqwt
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

validate_mm() calls are too spread out and duplicated in numerous
locations.  Also, now that the stack write is done under the write lock,
it is not necessary to validate the mm prior to write operations.

Add a validate_mm() to the stack expansions, and to vma_complete() so
that numerous others may be dropped.

Note that vma_link() (and also insert_vm_struct() by call path) already
call validate_mm().

vma_merge() also had an unnecessary call to vma_iter_free() since the
logic change to abort earlier if no merging is necessary.

Drop extra validate_mm() calls at the start of functions and error paths
which won't write to the tree.

Relocate the validate_mm() call in the do_brk_flags() to avoid
re-running the same test when vma_complete() is used.

The call within the error path of mmap_region() is left intentionally
because of the complexity of the function and the potential of drivers
modifying the tree.

Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oliver Sang <oliver.sang@intel.com>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 204ddcd52625..964a8aa59297 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -597,6 +597,7 @@ static inline void vma_complete(struct vma_prepare *vp,
 	}
 	if (vp->insert && vp->file)
 		uprobe_mmap(vp->insert);
+	validate_mm(mm);
 }
 
 /*
@@ -678,7 +679,6 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	vma_iter_store(vmi, vma);
 
 	vma_complete(&vp, vmi, vma->vm_mm);
-	validate_mm(vma->vm_mm);
 	return 0;
 
 nomem:
@@ -718,7 +718,6 @@ int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	vma->vm_end = end;
 	vma->vm_pgoff = pgoff;
 	vma_complete(&vp, vmi, vma->vm_mm);
-	validate_mm(vma->vm_mm);
 	return 0;
 }
 
@@ -891,7 +890,6 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 	pgoff_t pglen = (end - addr) >> PAGE_SHIFT;
 	long adj_start = 0;
 
-	validate_mm(mm);
 	/*
 	 * We later require that vma->vm_flags == vm_flags,
 	 * so this tests vma->vm_flags & VM_SPECIAL, too.
@@ -1018,10 +1016,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 	}
 
 	vma_complete(&vp, vmi, mm);
-	vma_iter_free(vmi);
-	validate_mm(mm);
 	khugepaged_enter_vma(res, vm_flags);
-
 	return res;
 }
 
@@ -1196,7 +1191,6 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 	vm_flags_t vm_flags;
 	int pkey = 0;
 
-	validate_mm(mm);
 	*populate = 0;
 
 	if (!len)
@@ -2023,6 +2017,7 @@ static int expand_upwards(struct vm_area_struct *vma, unsigned long address)
 	anon_vma_unlock_write(vma->anon_vma);
 	khugepaged_enter_vma(vma, vma->vm_flags);
 	mas_destroy(&mas);
+	validate_mm(mm);
 	return error;
 }
 #endif /* CONFIG_STACK_GROWSUP || CONFIG_IA64 */
@@ -2111,6 +2106,7 @@ int expand_downwards(struct vm_area_struct *vma, unsigned long address)
 	anon_vma_unlock_write(vma->anon_vma);
 	khugepaged_enter_vma(vma, vma->vm_flags);
 	mas_destroy(&mas);
+	validate_mm(mm);
 	return error;
 }
 
@@ -2288,7 +2284,6 @@ static inline void remove_mt(struct mm_struct *mm, struct ma_state *mas)
 		remove_vma(vma, false);
 	}
 	vm_unacct_memory(nr_accounted);
-	validate_mm(mm);
 }
 
 /*
@@ -2325,8 +2320,6 @@ int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	struct vm_area_struct *new;
 	int err;
 
-	validate_mm(vma->vm_mm);
-
 	WARN_ON(vma->vm_start >= addr);
 	WARN_ON(vma->vm_end <= addr);
 
@@ -2383,7 +2376,6 @@ int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	/* Success. */
 	if (new_below)
 		vma_next(vmi);
-	validate_mm(vma->vm_mm);
 	return 0;
 
 out_free_mpol:
@@ -2392,7 +2384,6 @@ int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	vma_iter_free(vmi);
 out_free_vma:
 	vm_area_free(new);
-	validate_mm(vma->vm_mm);
 	return err;
 }
 
@@ -3043,7 +3034,6 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	struct mm_struct *mm = current->mm;
 	struct vma_prepare vp;
 
-	validate_mm(mm);
 	/*
 	 * Check against address space limits by the changed size
 	 * Note: This happens *after* clearing old mappings in some code paths.
@@ -3095,6 +3085,7 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		goto mas_store_fail;
 
 	mm->map_count++;
+	validate_mm(mm);
 	ksm_add_vma(vma);
 out:
 	perf_event_mmap(vma);
@@ -3103,7 +3094,6 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	if (flags & VM_LOCKED)
 		mm->locked_vm += (len >> PAGE_SHIFT);
 	vm_flags_set(vma, VM_SOFTDIRTY);
-	validate_mm(mm);
 	return 0;
 
 mas_store_fail:
@@ -3284,7 +3274,6 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	bool faulted_in_anon_vma = true;
 	VMA_ITERATOR(vmi, mm, addr);
 
-	validate_mm(mm);
 	/*
 	 * If anonymous vma has not yet been faulted, update new pgoff
 	 * to match new location, to increase its chance of merging.
@@ -3343,7 +3332,6 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 			goto out_vma_link;
 		*need_rmap_locks = false;
 	}
-	validate_mm(mm);
 	return new_vma;
 
 out_vma_link:
@@ -3359,7 +3347,6 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 out_free_vma:
 	vm_area_free(new_vma);
 out:
-	validate_mm(mm);
 	return NULL;
 }
 
@@ -3496,7 +3483,6 @@ static struct vm_area_struct *__install_special_mapping(
 	int ret;
 	struct vm_area_struct *vma;
 
-	validate_mm(mm);
 	vma = vm_area_alloc(mm);
 	if (unlikely(vma == NULL))
 		return ERR_PTR(-ENOMEM);
@@ -3519,12 +3505,10 @@ static struct vm_area_struct *__install_special_mapping(
 
 	perf_event_mmap(vma);
 
-	validate_mm(mm);
 	return vma;
 
 out:
 	vm_area_free(vma);
-	validate_mm(mm);
 	return ERR_PTR(ret);
 }
 
-- 
2.39.2

