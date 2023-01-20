Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E516759FE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjATQbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 11:31:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjATQbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:31:04 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72F2619A
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 08:30:24 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KGBggQ011434;
        Fri, 20 Jan 2023 16:28:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=jWHgUTZwZaztKJBOjvH9mNdNg+9MnJY7IDlOLmIWEug=;
 b=QlmIy21S1yVCosxUx7hFeoRllUYl2djG1zHPDBUgjSGpgb9gnc33r20vOQZN40WXLi1B
 5QgwkA0cYtxm82WJDo15lZHmG++UsFGrxqmrasERGg7667kAeKmp481OI1QOMFobsp80
 egb9IQKY+/xsERt21FU/ijSaeC+2oDwZCzs4P07nDbKYrzeJ+v39k2LetmaX8v03zP9s
 GpjGbOTmW2gwocQ72D2Q3v6vW2zIUrWJnZWKGOvepGNVXtYN1N6C2ZayrZq4CI7lqYMn
 d1IjKNhDKI1dx0X8mjf1HxP6o/pBbr6HruFV5pnPiQWRz6P2Sm9rpvR8A1laLDKENo/f VQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n7895aqs0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:28:44 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30KGNOda004659;
        Fri, 20 Jan 2023 16:28:44 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n6r2w1gs7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:28:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ia89G8af2WN3/IPK7DqpJ2SNdq+maJLLiai4jqoQfOFBGr4SMdhNEr+fMFcNHO9pU8D1JACvtm83gIC+gce91KZHjlhJl1S2aXLGnmxWoGixdD3CaEWAo9nrNV67oXsfU6T+h0nJ0wohYeltOOSBMoRllM/8msT4vBpEGLsQWOlNPOi75R97AU85zKt9JhRbmSzHsLRo54IpZNiMdM62seNmv2gFh/ivVaGGvLtotwoyYvLX9odsP0y3meE2o0tm02QKgwWXHfr10RCNPlUocE4DTU3WPY7g533YKRqPYNNJx7LFvxR5ii1FxWLoL/DcKxxkACy1SoEMUglD8LFuBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jWHgUTZwZaztKJBOjvH9mNdNg+9MnJY7IDlOLmIWEug=;
 b=dm3ES5bF6sdtph9/RNgsF1gUZipK30KPOF+VA52+dB3SM5XDyInuDX1cjMqa/5qWsu4gUtvEV84IHhUki/MUe+dgnjG65HqbKoHaLeKNLIvlj4kvH1f6nVVslKT44TRG8nnnuwbfPtJ1NMNEoV57UEXrdf2qTFZ/ErRUhGTBAdk75m1ike9SlLPsY9j24XbiBvEwZ33prlmDAKDlCzLYDuaHD/SYrxZTqiYRhrWq09HD62Ye4gmmFcDFh4qTyPbQY1cVhROKRMa5lz0QFPNikHrxWzfURGgAurpAzENxe80+5xZJhXGcXmk1qlvghrJW+0DRhsC5SHmqRe7llH+cxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jWHgUTZwZaztKJBOjvH9mNdNg+9MnJY7IDlOLmIWEug=;
 b=eBeg9E5xkuUF34VGUp4pU03q8ypODYGS95gUEELIqjzjkrXHmDo/tbz5w+aDEdVg4kN2GmKo0nF8zuSeVzBpa6XW1cecHor6hY/q7VHA3h5X4G2Uktf0/wpvucMRtgpI/Pq2hWPx98pqtAMBrLNJM6jXdF11/7JHWq3cCXA35ow=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN7PR10MB6381.namprd10.prod.outlook.com (2603:10b6:806:26f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.5; Fri, 20 Jan
 2023 16:28:41 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674%5]) with mapi id 15.20.6043.005; Fri, 20 Jan 2023
 16:28:41 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org
Cc:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 34/49] mm: Remove unnecessary write to vma iterator in __vma_adjust()
Date:   Fri, 20 Jan 2023 11:26:35 -0500
Message-Id: <20230120162650.984577-35-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230120162650.984577-1-Liam.Howlett@oracle.com>
References: <20230120162650.984577-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0050.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::10) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SN7PR10MB6381:EE_
X-MS-Office365-Filtering-Correlation-Id: 2325895d-02dc-4c36-db58-08dafb0362e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WGO6e7B86bCZ2iMVTU1BdjwHqD4r2eX2SNM9JQP2ZcNgUE08puhVHtvJKZiN7azrm/udNoWlbsDQkRrMrA1MjLBPLvbJ356U9tsASx3+eyXnl4DAUkjhquya83CcjQz4enqooMCDhnWxeyiV1PzoebCno2wnUG/NVdmggUJetcy7osP7SDbinpzR8FW1bWhhF5e6YZLZAYOyNAKChPXVgdN7SOymBkikK4/10SQ9W/ifIC+q5LifZl5ZTC37cAb/ncV9SorzMmP08iMBy8hC2daSYH5HwYgwIfP0q5hL/W4RypXsdFBwQezHMKgs2FS9o7VQHbeLxX+MdDc4DQ5sAGsi8H8EarX+2J18YD90fh4XdmpEHpnTRvXFsX6vNlXukRpIXNv2I75zEnoOwXQiubj+BRuDNJW6gaZIUEwsas8Tx2H3pwWt3s1e0vV3AGQj+jID/XhbiIOKW29d4BCfRbHTjda3vPQV3PDH4uczo0VLZEtyNBtW0VAbTlgvyW+Sy4wWpOnd2ELoDtpHLQlzVHNu8QYPIlhbXzje08UdQNlGX86dnjNqqFPVfH1fv0rpJ50s06wMyIgZt7OfZiMF/XVX1/BDBROp9pjlfTFT4Wjn+Ijuz+ewGolOx56do0cMGFR/ostt8PwI/T67QOqsXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199015)(316002)(26005)(54906003)(41300700001)(2616005)(4326008)(66946007)(66476007)(66556008)(36756003)(83380400001)(86362001)(8676002)(38100700002)(6486002)(6666004)(107886003)(478600001)(6512007)(6506007)(1076003)(186003)(2906002)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r7apehFTaIKa1So4gBVOVlaqSbMz/AhjXF2FHEaedxeAzunfkMZtyBtOtY21?=
 =?us-ascii?Q?eQ92Sk5et+KuyQugQ6F6m97IsLQZSqGwkKF9BlfKqWaF//mGfdvzQmytR9U1?=
 =?us-ascii?Q?iZZ9CD545wPU6s73GgCArF65IJS7qHzmSOmkgFTvDVdAI7SaDiqTx38k+m3k?=
 =?us-ascii?Q?2gUsCjhkPLGiwjz0L1jFP3SdXkvv+TLxHpdNy2L3lFuFOgyuPV+EMJDFn5dv?=
 =?us-ascii?Q?7TTxzaSJgVKH4hv5RS6dj8AS0S0evNoa8beAWw36VmmXxGjVB7YUMCTjnJz4?=
 =?us-ascii?Q?LAtv932FO9CfhXnfAZPSeRkjoeAeY3BcgUpxbcah5osGe2sgt4xgTijqVExY?=
 =?us-ascii?Q?Uz3qSkfkmD0NaAL5kP5usxm2Aa2BocYRoBGrE8S6khcavWnbeZ8O/O/QH3TA?=
 =?us-ascii?Q?bV14EXYCJbSmGfhm4sayutuCyrwikE08vZ7RKfhMQkk5hWOKiGSFbKBfP+dg?=
 =?us-ascii?Q?heG8VhYM9S8ebo7WPGd/HC+Kl4BD2oAZkwxZ3wT826yqz+3loi9aJluClMN6?=
 =?us-ascii?Q?IO4X9QtZH54ZbMKhsLFhf9/Aew6IukEkdMpTGsb/SUYbThHg6CToq7Oa19Qm?=
 =?us-ascii?Q?GmCDV8VeFkBcOvZfE4PPfDxbpgs0F8YQmZcz0yMwlynOllGKdQock/wGjKAT?=
 =?us-ascii?Q?yu592QVtPPWoCaCiZ67CCYEbLQTOxALEsijEw5qCxFLSWrKoEnE180AaaFE6?=
 =?us-ascii?Q?/Ln0Oi7yqG2Y8yXIWB3hqlbbzyUJviXvJdt8NV6p3kK9fQ6Cglq+3uKx7Qi4?=
 =?us-ascii?Q?9HJw1AADQjYWiJ3lLPP4PRYtop1nWeX5VjKR5kiiA8TdxbjrDpuW+IWsj5pR?=
 =?us-ascii?Q?/5uB9XFcoh8ZknKuG1juuUsAVLQkaBZB+BvL6Xt/CV/9ATvYfl+F68h1E9/r?=
 =?us-ascii?Q?6onZzxasI30cDclYFLnMh8rgzatOj2JmcChUFJfVJJhgwpqCj1v8vqZi8QZQ?=
 =?us-ascii?Q?czCT8o26Nz0EOahsjdWAa3ZzdBDmSIstpgHoU7MilZwG04WwpihUePPTo0FR?=
 =?us-ascii?Q?Wx2lv9TCYyBmCBhoH99+Ew4fKL/gJLaKXvFsi+KKLyL/TwoyDD+KNrKDn472?=
 =?us-ascii?Q?fanSMqHHLQf+V2UhmiuKcShxHezb2gmeymxzfzt8BfggC4YFUmcbxYXmqmes?=
 =?us-ascii?Q?HGhX3kNyLvrQGkhBbfKhDz9yr0KT2FzCASiF0Jdeo84X5xVGSUoOBAPXt1bU?=
 =?us-ascii?Q?vnyv1+M7vPTnUv48ZRyDso7Z4hJtCer8tK6ggV02kMGnSqlydm4w98C4SyxI?=
 =?us-ascii?Q?qXdkhR0wKbkMCHhFRVru7BePYQJRfNOfRg5Pf5p8o15QWZ6QYBAMSn3EXpsw?=
 =?us-ascii?Q?aDC8pvePF1+SCDBIqxBFO+HVxvYe7knwdRgvaCuBuWdUvaVB7u4k4TbFYPvM?=
 =?us-ascii?Q?QY6CQT/zV3xGBURZO0FW9sdxkHaaQ/bQe+syS4buQQFbvCx0EdPxzu3njreg?=
 =?us-ascii?Q?Jg8zTp1HzPqAxX95WDlHpI35Ep8sFheNEZgsoaj6mHIgapUizhYf5oBYdQ8y?=
 =?us-ascii?Q?K7RZQPhHOYfZszT+2tltFV/sIZmnUXp5LVU8LhwyuLWgZLDaxszdgOGFOAT5?=
 =?us-ascii?Q?uucOShQ5J2y3iVysW7Fjjksf6ogXacYhzd4yl4CQJRZx6DA/oaDyn5E791v+?=
 =?us-ascii?Q?BA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ADSNNl/gZvWOFbfuMGCa+MeOa2mLkz1XL0W+5NlFSGPGeFH151Q1CgRAXn2EbNH+bmR7SOMfv1RuQQ1JTiYGAg4xwVLFOTTlhTZCi1bJQ7OpYrPsKalWjayqmGDc6VZgDfDmQAZkGv/4N2G51m5m+OR6MbsRk9ZM3slXKyQeCpz+VP5V6Qj3rwwxWxrQz/ZPX9xyb5a7ZfzA+Kft275JeOZE2I1xaOzlX7Wbg+kk/gPJRjAJAYiRmORIA9jWvL/xP9BQ8QlyEOZAcKVR6S3sGi7obR0lHUwEfle3I0+KJTHC6Fi3jWh26/sUaOMYMcxpQkfFhHOHdVo4NHyM3nHH9DUsJITIB9K6t/cPw/jKJFBo9t62V9PgexvMk4ndlGaHefzwgFac1c2HG1q4cqqNJgni9+C0k00OufXycY5wiRT0Dicto1dJBVQD6OiWz1OYDG1CyvbPz3ZE2K1qGDdbe1gnfmdK/k1X/PqCn0ErmeIOs9S8NEukvTQz+KStlJyJz6rv570uYn0QWoImNk/ltgUxgzM9AoZ2v4r+XKCG4Dpb+/GDKL9Xg18LUd9ARsqrOXaMJ1FP/2NPIk0DXim8KBruPPl+RSy9cXEGHsPoI7S5zxNvkmk6Tlm18xGZgBEDT9i21q3Cnan4AaIQ7etkSefGA0gLwdeUzaH8g1hG+OYzlxElXFizRRiG+PTwYzQRLSJBKSk6/fdlg/GiRDAXzcl/t1tHaYT42Ta9pYxmLrAlR0kNFOVWAqdayfDyAseJPDkgHNoo0LdTWkUNkpVTl+elkezhd+sQKtPFYUzM1OO64fJeBhY+UaeoqFHoB0U6tBhIjH2Olj1Y6krUlblbLr4o7NYwRpSgCJz31bVkPUb4ncOpz1aSPjnYxcHk51MfYVlG7r3xw4MyR2bHdRh2gA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2325895d-02dc-4c36-db58-08dafb0362e9
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 16:28:40.7905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DUHJi9WlzOE+lyd2NdA4/HPiYJAutGvEE9sOOwE46VNOiXPrI011+ZboVYEhDoEWy37UjcJo9BgSQDFlrid+OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6381
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_09,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301200157
X-Proofpoint-ORIG-GUID: ylG8RIj9HBc5xosU5AvMROWcvNnsZ4hw
X-Proofpoint-GUID: ylG8RIj9HBc5xosU5AvMROWcvNnsZ4hw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

If the vma start address is going to change due to an insert, then it is
safe to not write the vma to the tree.  The write of the insert vma will
alter the tree as necessary.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 5f03c8f3f407..58b2187b447b 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -722,10 +722,12 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	}
 
 	if (start != vma->vm_start) {
-		if ((vma->vm_start < start) &&
-		    (!insert || (insert->vm_end != start))) {
-			vma_iter_clear(vmi, vma->vm_start, start);
-			VM_WARN_ON(insert && insert->vm_start > vma->vm_start);
+		if (vma->vm_start < start) {
+			if (!insert || (insert->vm_end != start)) {
+				vma_iter_clear(vmi, vma->vm_start, start);
+				vma_iter_set(vmi, start);
+				VM_WARN_ON(insert && insert->vm_start > vma->vm_start);
+			}
 		} else {
 			vma_changed = true;
 		}
-- 
2.35.1

