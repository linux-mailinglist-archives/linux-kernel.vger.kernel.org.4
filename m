Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2DA574552F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 07:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjGCF7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 01:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjGCF7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 01:59:12 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB91BC
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 22:59:12 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 362MW8di027336;
        Mon, 3 Jul 2023 05:59:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=bMN5wxrHdDVf4pWWBhvN1nIvgXVXW5I+t9zbWvnRgtg=;
 b=bDu6Z0zn8qpX9Vc3p/R2eN+c1Zrx13TQPrD+A/DGnKDaf4vX2lUw1FNrsZRLSDdmV92d
 Ik05U/QuXfXQvMmG9oX6QNaLXJBmDHXCOt4t3CjnJFrjWEFhkigYJ8x8aGReO+MD52we
 i0L87yjvrfWkY5//CQa9yT6vKdFYzVLD8VhomQMJ62HmSogEVwoI65YhUIOB+uQt5Uk+
 LZbRkHoA21h0rVlaSqGtGw/0Hw4mdiiQe3gEmXeGjB0fdaivreHPdOPJMvt4/h/ILqf5
 EUboNdhHpqtug/O+YKnDqVubFbEjoiwWUhppRdHHehk4PxGTbPxoelN1Rn3BwT9wr85B ow== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rjcpu9ssb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jul 2023 05:59:05 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3633xh1p039614;
        Mon, 3 Jul 2023 05:59:04 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak2kv7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jul 2023 05:59:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cdQ76AFjUgXUSkWNYcfQswr//rV4CnZY/Sf57HXHxxgkkqL/dzQTOaG5P8g5u1yaPOAlCzmaK/2f/rtA6XRFIj5OQ8yUTe/0AFryaCxQw/DvSyT3w54Pq85uJ4LK/0lGnvBm9AJo47m92+NNCFQlTLx5RYdB94YvzfRJnB7fpXSV/oR/iNpDBmg2SjRRzjNq2V/E83FSA7K80PQDzGK4iqt/F6KZx36s8ES/MkulBC95xCYBGxmW6eNm8t5LFcnM4uyYizZH0ckoAoe6+VR1Xuq4g7vf9koh6r3oxKj3kxBxDMuIDyLO9LSOnpxkg2aUXqR1Fa6E94KgparQ3YdCBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bMN5wxrHdDVf4pWWBhvN1nIvgXVXW5I+t9zbWvnRgtg=;
 b=Y87FZubXHC3mO4OxC1j5BNvtaWQtnj+6EXKj7DcbB9rR7iCwIHIhrj/Jfdb7UavWw1HqZ1+O0Icpf8C8oY1JQDtHCdO71gbUuQPIx7L8occ5dL1UVI9l2N0ahSfY9LUztZrycZzU+GRvA/jX64U46j96FttceKwJFRb/1Y6cU5/JEzJq04rqklmjUtv5I73OQGX4tb7wPYvDoRFE61cAhs8Gdc6I3e9PAtAECpaki9kvIhB8Wmzj6uvTpaOdTKxF4ZuP2N7zMJNG+/qGhQuYPNqgabunhIlF17au7qR6vBsSeYtypaLcp6K9Sg2vPxu9ZtFfo5SyvK+eEmxAmuNyUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bMN5wxrHdDVf4pWWBhvN1nIvgXVXW5I+t9zbWvnRgtg=;
 b=XpaYXvx4qrvBM1fQeD7m/W7g9s4kuv/yp6IySf2AH1mJfEqForhA01sBvKGhwHC6ek4xmrttmo5eWTZMbE8tHjz03QiClrixG+Th4sDIllyvf7VejE3rQjDjfXg8Ep8HZLmNWW/6eLoJbM/v/TRkRa7TLSYQqgkccjakurzUITU=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by SA2PR10MB4697.namprd10.prod.outlook.com (2603:10b6:806:112::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 05:59:02 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5%5]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 05:59:01 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH 2/4] mm/memory: convert wp_page_shared() to use folios
Date:   Sun,  2 Jul 2023 22:58:48 -0700
Message-ID: <20230703055850.227169-2-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230703055850.227169-1-sidhartha.kumar@oracle.com>
References: <20230703055850.227169-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::7) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|SA2PR10MB4697:EE_
X-MS-Office365-Filtering-Correlation-Id: b95c54a4-6470-4175-9d22-08db7b8a9986
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kj35FeXl8YgzuILauz5aoZbt7w9KZYeJak0VmW9JcF1EfUccAaJeet4ZgWKdrwXqDiXx0F7awSmiHGx4kbuSuDr/s/lfgON8/G8oqPx4En0ctrg4h6zorD95iGONkCVfiOyyEkC5XpNR7xtcgta1BU5w1DU54/Cq052WcCOPFa5fAwx3+PGO0eUn+0x2vp8oHa00LZi3VlFOadnOGABGv/6uiAVKdkE86Kg0ZhK+mx0c2ElM/bcgarl7FZ6Tg5CBGBLQ4ag5oEZ3kJxGYpqY0N+BrJ41xf+6J3Eobk0QVzRXIxw756PRNkA5Otzjuh9yZL9xQf7hxDtkVoCTWXLn1K8v9CJMREk4ftQWCsE2osIBjxYSSU7M27Z0QsZxP+G8F96My5GIWQBiKT7MuowqYK/MpLzZtx1BcvtfLA61ic+GfKZFG8ScfwbkCRCxtKLjc6NzgFmRkI8fFCczwou/qwYo8dPQXzmjuTSy1vHClXMzDFpymbnXxagkEF78O4LbArzUTSt8JLa3obLfkgo7ruDalc6hcHaTI647Ol/YJHyRHC6Ylt6eU4LVCOGZtlQH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(366004)(39860400002)(136003)(376002)(451199021)(2906002)(478600001)(6666004)(6486002)(86362001)(41300700001)(44832011)(8676002)(8936002)(5660300002)(36756003)(316002)(66556008)(66476007)(66946007)(38100700002)(4326008)(6506007)(1076003)(6512007)(2616005)(186003)(83380400001)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Hb9r1nAaluz8shVTeEGmBZy4THvww/GH6YajXOWhDaFzC1p5OIZostO/zDHD?=
 =?us-ascii?Q?71XVDcTrj61HIpE+FnkttTqWT93mmZwgy5rtKepwRkvfdjZ+HJUX86SmRroW?=
 =?us-ascii?Q?ZM/895N0PtNoOEElXf4tfMpXCVcWfhujyDWaVeigFNlPzANvSDcBYMlD4NMF?=
 =?us-ascii?Q?xhBpzM+kvxaw8afUXOi2pVPK4seGCEfYiniqAekUO1RyZ5nj1kgEN03VYvSV?=
 =?us-ascii?Q?FDCnnQGTtDYDBjFG6lH/gEkDEQ0dduBOQsiz2/91Y3UKRyYFSw2GoDiq8JUg?=
 =?us-ascii?Q?qcV06k2ShEcOW4MxxtfJzQXdXVsWF2IHbdyjh2wVK+BtUsUpaiyDUyQmjW6r?=
 =?us-ascii?Q?T5A2SFqn7iKpke959sAQweXJtsYm+wnSWcrxaSUIhfIHBjHlirO2pcufiC1+?=
 =?us-ascii?Q?elNkexu/nDdzM5yPDcsgFZLF4E3dwgo34yehuUn5bhlGxENC2SIU3jVO2Elq?=
 =?us-ascii?Q?38bPVKwstPxn244tCpm4bMDONaa4feIlNSF4P9lb9KVfAH/68GRT8cFMwtr1?=
 =?us-ascii?Q?s9NFIKfcmJ9td+WzKb06T9zO3bw4o1M/Jt8ysaadliDYqklKMAjAT1xo2ZX0?=
 =?us-ascii?Q?8e+G5Q1FN26XvTwezuqh9lVNFiQO5m1NersHFbTSnc4jduBfEUfLYGbDw4gw?=
 =?us-ascii?Q?XJ8H7V42oECGzR+CmD+iIU9Qx6OlZTUIrZl9/ilO8/HU0U56VRf8n4gDHH4Y?=
 =?us-ascii?Q?KZBIYSEi15oEKf4KgkmWSE5xg3WxepjBy60n3yyoYz8lbF9geMW3NMGfHVp7?=
 =?us-ascii?Q?W/fMT4gVPXOK4mD4SsU73/C/LpXDlcDX2HeBcKKSXWCecZBBSnopNB0yWvvX?=
 =?us-ascii?Q?YcV2KFYWxBNOz04yiac3sRCTOX3lIYNVIZvOQkLRkk85vuN+0HKeyX7owNr7?=
 =?us-ascii?Q?2eHhy8jL5zzMaPwtxruHPHBxkBkHjAyjlbCc5231MZDnnULS5K0mrsm8rQNK?=
 =?us-ascii?Q?Q4wjaawi0zafNJFxE/4+7ZCzfWRuTNiMQvV8Pv+IvrogpuGA8wXaNcpOVFkF?=
 =?us-ascii?Q?+VfQgdfZpsuOQmekD8jMyUOFBau+mIKahS62kyJrZ3Ql+BOJTvAu1EqDOaBr?=
 =?us-ascii?Q?tijEeE3aK71xF3vzU08PenbDngmecbfNHTWFQOQ+SGOfLkJGWmNoRNdmq0sl?=
 =?us-ascii?Q?vEnnG764Eak2s1cHe5uwsaYsQ2H+V/xVdmrbKq4GaIvlP+gbshgnUUkQuHKI?=
 =?us-ascii?Q?96KgTrtVvgNYpHqtOcKcrPzRUhwlIddHZo/NCHiCVTlIvt5GVC5eaYRLx6UM?=
 =?us-ascii?Q?8fMr8kD0PkBzWYgbVBUgLv59/g/Kno6VHDmemu0zxXu3x/bPd5OKpiLB7TZd?=
 =?us-ascii?Q?mWIMq45Zb00n4jcnMUoLzuVznBX/jJIXdzdMsHWDABWrYkD9EkV+D3Dc9fu4?=
 =?us-ascii?Q?+MU6OutS83SwRUqEciD/lQD0qbs9C1RiJk20w7n3ozph1BMk6qV7/E+3c5Z9?=
 =?us-ascii?Q?rwYAkwQ96jViIukl37gwxFi7ocp4I6+okpyKjycN+h3VKX3kWDSulkXjx1GY?=
 =?us-ascii?Q?tB63i58kPBm9n8H8FHTS5M1OiwflUkFlItvipetJ54Eh5MF7FbLNzt5jfHY5?=
 =?us-ascii?Q?SEHSUzdgHLPYzTzo9ruchtaZOrnNX5zyjceQEYdjXasrlZUFpG8Sn4l2qjLF?=
 =?us-ascii?Q?kfX27PN6t6oKEXadZ9Z/Ez8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Aqjh/Jm1bY69ze2izMQsOKjk/DDWQzzkmmSDQUI4ARYMMn1btMbjeWFCedLMUeFds0S2I3oNHmwKEkqoLXP8/AhG9acxW5RGT21bSOIH6JTEwjnG/dHO2tP/mToSMQ3K0vu2TsFfOhqTjU9PCcZUWLlvE5+qLB32l4NG5w4cmco6s53uSqnCYvkxfYuagzkRfaTIXpPqYGjFEboVVImtOe6t5f6mLe2x0MhK6YUHjfw9TtHUI0MqBNXiPlwiGj2vFRSE7p8E9R72GoBVxF2/szbswobjN7ZIuztYSOBxfbm7FjYA2RP37LQ63Gk1yrx1fGNCe4wHV6/Xvbtm+pyn7xWbAwIdPj0mTAD+WR0V0V8mrv7ubBU6YuvHsXpVHHwAZQ8GayEjCiLNsunMJdghdcRO9BFzKowAEOYf2VP4wbwZn/bSTGSsSLDFp3K9+VvQMyOqyMPXKCxYBdBvcTbs1zcV2WaFSOV2WusJhJt/4yhx3tTIc65SAXoH9l7sqfLnm5LGukwWeFXHeMtKZQrIzzs8eF/uagUF8o+jgtxchVlK62319fgpTAln7ZcqIvg290SuYS/tJjrzXzao/sdrh8K0mUEyd/CKvGXYXpA7poSVzVlaeDg8YcevGW7u5t2sRcKThp+DKaCFeqJWydJT6FNc/zt+Hty+byHiIbY4DahyobS2YXOhYzVCd6BcVPka2cTPmSPxnzVXrZ5yTrcOpqx7QDI0yTIk7Xnn0oD2ZuxMDYQ2T0JhCQBmPwfNTNRkv4jvbS9R2hcRoNg59vd/O45+AENwMsYPvU/XwAqL/povU56ZkxOMyGTIVeSudYWKJN9AcivrPW6V48oBKt/xQaG0K4bvdgCr8w5q2F6ltrBXpEUNMtWi60FW1gJ6JnDt
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b95c54a4-6470-4175-9d22-08db7b8a9986
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 05:59:01.5989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9sw1m94o8qjv0ozpHrl71pOoxev4eHJI7iHnItIQHJFYv7hoSd3cMZh3x8ctGnrpGmiGfpQa5r0yERPfKScyvc/jjZoga4qPZpPL6/4FsDA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4697
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-03_04,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 spamscore=0 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307030056
X-Proofpoint-ORIG-GUID: 9G54wqyZKX08ZeGYeSApwjCptShlxvou
X-Proofpoint-GUID: 9G54wqyZKX08ZeGYeSApwjCptShlxvou
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Saves five implicit calls to compound_head().

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 mm/memory.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 098fac2f5efc0..93480e846ace6 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3286,8 +3286,9 @@ static vm_fault_t wp_page_shared(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	vm_fault_t ret = 0;
+	struct folio *folio = page_folio(vmf->page);
 
-	get_page(vmf->page);
+	folio_get(folio);
 
 	if (vma->vm_ops && vma->vm_ops->page_mkwrite) {
 		vm_fault_t tmp;
@@ -3296,21 +3297,21 @@ static vm_fault_t wp_page_shared(struct vm_fault *vmf)
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
-- 
2.41.0

