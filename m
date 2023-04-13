Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 339DF6E17FB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 01:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjDMXPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 19:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbjDMXP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 19:15:28 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894EB120
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 16:15:26 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33DKxFuS000556;
        Thu, 13 Apr 2023 23:15:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=PRIpQsJtmpDtH4hp/QDArazlqT6QZEBMdTRXKdj9SoA=;
 b=RtzKl0p7ZNwaWrvILRt+MQyJufmn63GPdkgum21o9gE9A6KQXKksBGcHwEawLkYkscSj
 mycnl7oYFp0hCergK1OxftAoZmIERPKSPuafEmkG8m9M5I/20ZoNTMqw2g1SaXKE5gGo
 qWJIkP5ty/6+eFLNa4ARKew3XEnYx3yOz0/y851NFI1wiioj0vDDyGMgNGM5nH78GI1S
 L9CxflTy1yJnyaRp+pjHjoAvngad0UELUb+wkLc0MuQ+4Tto76cnEYsMHgghLap1/f8K
 l/rhNtfVBFwLrNUi1lZ9Gr8lx3vr0bLDEnrW0iFeLz8lySCA/sAZAi5GKHWd4a+VO5Ey +w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pu0eqcuhd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Apr 2023 23:15:03 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33DL8UqK039696;
        Thu, 13 Apr 2023 23:15:01 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2046.outbound.protection.outlook.com [104.47.73.46])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3puwbsfhdw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Apr 2023 23:15:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cOi7SyG5iazmulGDaErNNq6dlPGmUK+JwSKFhv5NXCvyu6uvADDBRCKKm9sQXMGcMJV+VQqNc5yV73faQyWcZvt1Ek5bqKWhOiGg1NJwirFXz1FLK6DL2SEZfsUlJS/1NrXI+9nZYUOn7DZNMYdwf9yoyXWVES0hOeK/xMPfITqqP4wobL/FXGCDn0WqieWUqCvhaqoe7xcaTfr6sk9N+1BGs+z0sKlCpCJmEM7ywyC1rPKoB/A81fXpvoLOsVjRUgFyV+cJu5R4VRndN64XPACFHtHqNeYE3gkYHHEkiOdzuWizquFwdrMYaHRbafdGIQ22B5l2W7stvNf66In2xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PRIpQsJtmpDtH4hp/QDArazlqT6QZEBMdTRXKdj9SoA=;
 b=Jmd6HVDle4AvChDG2L+U0BtsIscis/2nzhqOqYHmqCUPVe3U94f+ihM8QS7KgORW7zPy02vvSRdKjo0l5Pk+zKwG3yzSQmIQKJHXgCEGTo6K40H2o/KTjdlnPzyeC2seHkVMd/2ONBeBLDXMWS3NtTYCmAqvTr7qhXOmKuEbSSfVGcyGsmGcUNOrXU+MgDRWGPg7owF+R6ksNybGRgbglvxjNsZHMBMHrwif6SutmxVSCDQoUmsaV0rxQn2OPQvumUp/tFpmFFQxj+nG10FS2UOimBrBuu0MbMVWt3zvi5oiH0BPG75Hc8ne3xYXDYkezgJmmzjktk5gC75iKLgbmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PRIpQsJtmpDtH4hp/QDArazlqT6QZEBMdTRXKdj9SoA=;
 b=GCSubIwnKa5WhqPfN5B2ZqpY2+IeFg5/LXj81ESwKBsTxMSQQkFhrz1q/tl0tFHFnygrsIoHpcuGzhm3+TmepKAua23m0iB9FASB8c8ZR6VbWww7+VaG8t2WBXV9qe0HOM+0gtr7ug878rdDxIEjQ+wkVp3plQ0mQrbJ46ZTf0Y=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by SN7PR10MB6287.namprd10.prod.outlook.com (2603:10b6:806:26d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Thu, 13 Apr
 2023 23:14:59 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::12d3:3f71:5b55:c342]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::12d3:3f71:5b55:c342%6]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 23:14:59 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [RFC PATCH 1/4] mm/filemap: remove hugetlb special casing in filemap.c
Date:   Thu, 13 Apr 2023 16:14:49 -0700
Message-Id: <20230413231452.84529-2-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230413231452.84529-1-sidhartha.kumar@oracle.com>
References: <20230413231452.84529-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0154.namprd03.prod.outlook.com
 (2603:10b6:a03:338::9) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|SN7PR10MB6287:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c96e82d-37fe-497f-faad-08db3c74e6d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vdtDNffrFn9g11lYomChjMKhgY8OdTRgSVb12yH0sAwbtR/MZmulPH79b7qk7cGcdWSBfqsZdqSalt06ca8qyRu4SKWiyGvnPqlMCAGD6UfcwULKuo53xSKaAjWrDezW8/Q6LH+6K/qfUhYamGRQ4fZ5j9XIxHMk1vS70xc2WEsIhtRfP0Y2IjPwZjGeZfW+bGvTvkRh1207EgBbSkR2TWAlUSIMeCz4tacqyOQyvIhdQ5VQ8AffkBwq0swcu+85+t4zkLPwCzJGcJrby8sWITU/NMH0Yv1kHipmhskRUxat19Uo4dDfBG3NxNI8XK2gNr69nkfk44vI5je4n9l1iuaLQh+G8jF/7AJpej2Kgyphs/2hyXZYb+tvldhQa75uesxwbTBVmVe7VZVV5lJMNhOWcT3v6IDDfd1ipFYQZCyNnT9bb32CGV5tccXaSmMXstNMowVl3tJ65Gletc0KEgppH7CbiCw4xlTZZwZT5kkaoS692R8LJsSWnXwOacFKty+4ErbShAysZ5Fq5aMNGJQayUMbE+ddG4QixWDoxG0nKYzoe/Ea07rKWJdzysin
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(396003)(136003)(346002)(366004)(451199021)(6506007)(86362001)(6666004)(6512007)(107886003)(478600001)(6486002)(1076003)(186003)(66556008)(66946007)(66476007)(4326008)(38100700002)(316002)(5660300002)(2616005)(41300700001)(83380400001)(44832011)(36756003)(2906002)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5AyJ1y5HmjabXx1w4Uaa344D2qwMtAyFqjb4IIAkK8Ry5VH6PDMCjseokjVI?=
 =?us-ascii?Q?IGJTVlSZYt7l7SXjk9kduD8zv9I51JnKOyQ4xqW2EVwMm3kQbR3CRFkNcbPr?=
 =?us-ascii?Q?cVVvD6hKXfaYRugFab5H5j62qfGIa5IN1SvDGgsk8A7+6hRX+/9pcTrrRAe6?=
 =?us-ascii?Q?i3z61PS0eFaeQwiePtgW58myP0W2IlGBT20aLG1SmQrm0Ww2PZuYCQmslWt9?=
 =?us-ascii?Q?1/RI8PHG7DlZ3D6MZ82nB45MuZLVjoGPvBnAS5ZoVWrm126r326W3y+KXrFP?=
 =?us-ascii?Q?oohfxIupkRpp0pS3YqQ1ik3DAqRsop3lNWPPPC8p43ueVHNd8pquj3pNAIwv?=
 =?us-ascii?Q?5i1M5t7zsRqfDUylWRJ2/QgD6w9CoBKpmAYXBpyhkM+5L4/Xhp9i6cDJcLu+?=
 =?us-ascii?Q?tj416zBpmDCW2Pq0bpgRrTrJq5jLulFGMFemVmOfJ/gBPX2ofjAct842dT2I?=
 =?us-ascii?Q?ZlSYoaTJfO8qtP+qcmNfPhpj2tow+4yfqv2OB70EanPfRGqFvWMBjxEM0DT1?=
 =?us-ascii?Q?aIruE9n5QQjI5S09x3ak020z1PbqWoRUBDsu+45Ku8rhBZ3bV2BlzCGe0P/O?=
 =?us-ascii?Q?xENpucDJGhRJKLITO3nhrJGh+doXM1pFHStocSmA49f+75Kp4XBT/mz/BdYL?=
 =?us-ascii?Q?FuWWNZ4ENN7zOgWFkTiPUf7Ymg4UAghbL5GFAr74yXwHT7H2ZALADqwmRG9q?=
 =?us-ascii?Q?OrZ660qYlPD0+CQbJi2CsDI0SYIzYZR9jUe2Rt3nOG1mnSrN7FeMVJu35IAz?=
 =?us-ascii?Q?mz2kCfgEGvVgt4p4OBKqT80KsCq+e3ZTIm4hK2FI/lrJe2iudLhEtdvnVtl/?=
 =?us-ascii?Q?3lKeVC5JVB01ZjjmVSQzlqqanTMPf9nz5eqvJO8DS5/hJGxbikbNoapmgbAd?=
 =?us-ascii?Q?XslINeYZ48aooP1AkkPUuxtWwJyejGBbKWavzYW4oqJbhg32mETn6iLab34l?=
 =?us-ascii?Q?fiMwwn+RSzyfYi2GhHjwIZZzavuEr1EGVnYP4ptPU+xX840LEK3ryzP+5+Kk?=
 =?us-ascii?Q?St/6HQxEty6P9mkFP6X6VqeJvTYWA9wl7erU3T3xeGRBymzMVcKVAXQ31+Jg?=
 =?us-ascii?Q?q5x1quK9oZp8lBUyh/HEMI3V36AluGgHn2dhSIsOhkTycUQp3A5mKN8tnZBR?=
 =?us-ascii?Q?gFnovm5bIND/KDiPJuYt7ps0L2TIpjOSypwQEKKyMeOE257kgyaCDDbjEcPx?=
 =?us-ascii?Q?prq7TCkX3kRxKzfOPCsV2J0Yz0NGXicitm28u+wrwaATIhP4iqHD2Fpyv1Yf?=
 =?us-ascii?Q?W8NDaihK3Df2UFlxAFuvBTxu/EqviIrqpbip+qc3+LFKznlVoVMGi8taT40T?=
 =?us-ascii?Q?xxsxrLqccZA8Zk+G9eVcTh+vF5YVeuRvgH4C9lRmHm7GSGQOnNBbyDpBg6aU?=
 =?us-ascii?Q?ZEj2QaZvesiAKUAQhqb4fVS1xr4t+P/kAmyrrTPv8Ol7+HX3H6qgU5D1GF3+?=
 =?us-ascii?Q?Dai48P87tINeiCO5/fSZSIlaDzXLFKcBDaJhj9Vu5Uw8yqaIfG/5UhrExuSW?=
 =?us-ascii?Q?uholzEEoJ3K2WTdQCK74RTmzqMIGa00dZNtbaOQU7me5fB5oqOK2eyOS4OtL?=
 =?us-ascii?Q?mR9nLDpnADBHPhOzvTszSEcyMZJaIQOJIaaNzR2CWQZmP3qplEWNPNZ/wjVt?=
 =?us-ascii?Q?x6pv11BspOi903jgHW/kLYQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: t967ruiFklitBy8Zd23w2HimJRec4trp4OJuAbbms3hFqNktMKoSipxtu2ifASeQWutQyRvCG1rw41S8jId4HJ+Jz6Rwu8fyLQztfaHFOOE5GJAKqWKWb9gIFokq1D01tBkR1kofYwcaN1XtYCXHTH2f5hr/Ev0974DJjaWQ/Qy5yktGyCuJ3uozFDqFLxP7tc+TEM8DnivH/550Zd+f3bQQSQHXSZ62TGvJLLR+VgGwvOQWbiNLqDFUX9eVlysI4QswMXfQuHmPsRzyGwdvBzMni9/K65tFnVQDVUyEhEG5jWR8jD8m+OV1h3i93woHTGM+wBDjwT0EhsRYs2a0ErMTq3qsDrF3fMth1sva/c7va+ROxGeBLwcJPpCbDlDimpPiH3GcSc43SCudCNdV379asRr7ZKa/818Ds2k4rKbMs5PVsnlPDK8WL8HK5pfW8NVCWhBy+z5Z+JFOxX/pz42wan5iw7cohSURIU8fFz5Tm1oYq/jFEXLkDfedz/1M77VIhPT3QBIXlc5gvOCE1PlbBy9b0RFnGn1ZUJBmHiWlmW/+3EIQUOe6iMywtJHgvwHB56CoLIxBOXVmC90rttWkq83w7edFf4bt/ukYmY0d78FtReSlkYkeJCmwP7QseWKUTG8wfbUIxzzHOEIziPuDVQFZJ7Hih9kLDIXNLr1+UA/WfwvkH6jqf30m0s3vhzu62BVH9ojIBr9gN+hqgUmEHLnzaJstwOXR1b/27/IF08qjD45d9uV4UiAHYyC27TcXXjdU/PFXcd68vrXVYZIsFWgYy7R8V9UgYJGfataceNWdUAvRO0v68EzLJgjNfEJy+4ZlQknS+BPdzZ4Vm7n5d4FZWo3fNML2pDgiSaj8yOG4hPzzrZdbuSOEastNf9n+abf9L6gcjzt+UXKxZSEQRciCzyGqOCJ18fd0zW8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c96e82d-37fe-497f-faad-08db3c74e6d1
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 23:14:59.0681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6sw7GDjbBv/MCVN+GbK3b062fYIHZzCUWzke2bQACAZKfE80yrtkSIshtk7T62JOtJdLU4AmOVZbGOdeiy/lM+1PS/WUXcpOq95OK7m3bkk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6287
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-13_16,2023-04-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304130207
X-Proofpoint-GUID: y7rTOmua3XSpD2ZxXbo6N_BQud3xTn-d
X-Proofpoint-ORIG-GUID: y7rTOmua3XSpD2ZxXbo6N_BQud3xTn-d
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch aims to remove special cased hugetlb handling code within the
page cache by changing the granularity of each index to the base page size
rather than the huge page size.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 include/linux/pagemap.h |  6 ------
 mm/filemap.c            | 36 +++++++++++-------------------------
 2 files changed, 11 insertions(+), 31 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index fdcd595d22944..330b1db913f5a 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -717,9 +717,6 @@ static inline struct page *folio_file_page(struct folio *folio, pgoff_t index)
  */
 static inline bool folio_contains(struct folio *folio, pgoff_t index)
 {
-	/* HugeTLBfs indexes the page cache in units of hpage_size */
-	if (folio_test_hugetlb(folio))
-		return folio->index == index;
 	return index - folio_index(folio) < folio_nr_pages(folio);
 }
 
@@ -844,12 +841,9 @@ static inline loff_t folio_file_pos(struct folio *folio)
 
 /*
  * Get the offset in PAGE_SIZE (even for hugetlb folios).
- * (TODO: hugetlb folios should have ->index in PAGE_SIZE)
  */
 static inline pgoff_t folio_pgoff(struct folio *folio)
 {
-	if (unlikely(folio_test_hugetlb(folio)))
-		return hugetlb_basepage_index(&folio->page);
 	return folio->index;
 }
 
diff --git a/mm/filemap.c b/mm/filemap.c
index a34abfe8c6543..fadc8ca9b9695 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -131,11 +131,8 @@ static void page_cache_delete(struct address_space *mapping,
 
 	mapping_set_update(&xas, mapping);
 
-	/* hugetlb pages are represented by a single entry in the xarray */
-	if (!folio_test_hugetlb(folio)) {
-		xas_set_order(&xas, folio->index, folio_order(folio));
-		nr = folio_nr_pages(folio);
-	}
+	xas_set_order(&xas, folio->index, folio_order(folio));
+	nr = folio_nr_pages(folio);
 
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 
@@ -234,7 +231,7 @@ void filemap_free_folio(struct address_space *mapping, struct folio *folio)
 	if (free_folio)
 		free_folio(folio);
 
-	if (folio_test_large(folio) && !folio_test_hugetlb(folio))
+	if (folio_test_large(folio))
 		refs = folio_nr_pages(folio);
 	folio_put_refs(folio, refs);
 }
@@ -855,14 +852,15 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 
 	if (!huge) {
 		int error = mem_cgroup_charge(folio, NULL, gfp);
-		VM_BUG_ON_FOLIO(index & (folio_nr_pages(folio) - 1), folio);
 		if (error)
 			return error;
 		charged = true;
-		xas_set_order(&xas, index, folio_order(folio));
-		nr = folio_nr_pages(folio);
 	}
 
+	VM_BUG_ON_FOLIO(index & (folio_nr_pages(folio) - 1), folio);
+	xas_set_order(&xas, index, folio_order(folio));
+	nr = folio_nr_pages(folio);
+
 	gfp &= GFP_RECLAIM_MASK;
 	folio_ref_add(folio, nr);
 	folio->mapping = mapping;
@@ -2069,7 +2067,7 @@ unsigned find_get_entries(struct address_space *mapping, pgoff_t *start,
 		int idx = folio_batch_count(fbatch) - 1;
 
 		folio = fbatch->folios[idx];
-		if (!xa_is_value(folio) && !folio_test_hugetlb(folio))
+		if (!xa_is_value(folio))
 			nr = folio_nr_pages(folio);
 		*start = indices[idx] + nr;
 	}
@@ -2133,7 +2131,7 @@ unsigned find_lock_entries(struct address_space *mapping, pgoff_t *start,
 		int idx = folio_batch_count(fbatch) - 1;
 
 		folio = fbatch->folios[idx];
-		if (!xa_is_value(folio) && !folio_test_hugetlb(folio))
+		if (!xa_is_value(folio))
 			nr = folio_nr_pages(folio);
 		*start = indices[idx] + nr;
 	}
@@ -2174,9 +2172,6 @@ unsigned filemap_get_folios(struct address_space *mapping, pgoff_t *start,
 			continue;
 		if (!folio_batch_add(fbatch, folio)) {
 			unsigned long nr = folio_nr_pages(folio);
-
-			if (folio_test_hugetlb(folio))
-				nr = 1;
 			*start = folio->index + nr;
 			goto out;
 		}
@@ -2202,7 +2197,7 @@ EXPORT_SYMBOL(filemap_get_folios);
 static inline
 bool folio_more_pages(struct folio *folio, pgoff_t index, pgoff_t max)
 {
-	if (!folio_test_large(folio) || folio_test_hugetlb(folio))
+	if (!folio_test_large(folio))
 		return false;
 	if (index >= max)
 		return false;
@@ -2252,9 +2247,6 @@ unsigned filemap_get_folios_contig(struct address_space *mapping,
 
 		if (!folio_batch_add(fbatch, folio)) {
 			nr = folio_nr_pages(folio);
-
-			if (folio_test_hugetlb(folio))
-				nr = 1;
 			*start = folio->index + nr;
 			goto out;
 		}
@@ -2271,10 +2263,7 @@ unsigned filemap_get_folios_contig(struct address_space *mapping,
 
 	if (nr) {
 		folio = fbatch->folios[nr - 1];
-		if (folio_test_hugetlb(folio))
-			*start = folio->index + 1;
-		else
-			*start = folio->index + folio_nr_pages(folio);
+		*start = folio->index + folio_nr_pages(folio);
 	}
 out:
 	rcu_read_unlock();
@@ -2312,9 +2301,6 @@ unsigned filemap_get_folios_tag(struct address_space *mapping, pgoff_t *start,
 			continue;
 		if (!folio_batch_add(fbatch, folio)) {
 			unsigned long nr = folio_nr_pages(folio);
-
-			if (folio_test_hugetlb(folio))
-				nr = 1;
 			*start = folio->index + nr;
 			goto out;
 		}
-- 
2.39.2

