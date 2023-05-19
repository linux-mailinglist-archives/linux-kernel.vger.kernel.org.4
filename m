Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4A270A2A1
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 00:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjESWCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 18:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjESWCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 18:02:32 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D79C4
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 15:02:31 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34JJESfY009227;
        Fri, 19 May 2023 22:01:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=3Y22BrpTmVG5LwQMAZ+8OBnRvoromZAM5t2fjkjx9VE=;
 b=EZWVWJQIjWm0VTNS99o1AbkKUrNO8+DBy9agkWbA8Zr2M0nuTgNfXUnUW58yMh3K2NGH
 0+RGayGtQnKCNQzYkCiGnt66eXXEzJgRu/PM8GogIlo5fqBFnZuqbBVzAfF6a6nchNiC
 pC+krp3LUVRrNmT8NUJjl6X6X7cWPJuASmh6X6FNRm7Q3BW1qzNuFf4txIXns8d/AEjc
 t3WYVAuS278Qyyhfzqz8CaS4rU5YwsCDUrGQC40LaQTegVOin7Mq8p4EljYP8AukOlDu
 m6GtLF66P9aTZcJ1619IIvexKbC4Qb2GLbqh8/oFYZZH68HIFsh6zjmbDNZ877UKnm2i sw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj1fcbhy2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 May 2023 22:01:55 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34JKNbZo040097;
        Fri, 19 May 2023 22:01:55 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj108c9nf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 May 2023 22:01:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dvXOCjSG8cFvtprfLj4L9P+PO10hyUZZlQR3e7gscvJEdUQgBoO3KjRmyDoHFB5GBZkpppXNp1r1/VuhUx5yjSB1LP6xzV0um3NqHrFs58zQUgFXAyv4IFViNPI8RspjvjnL3AyIIIsSsi4Vqy4OSs0KoTePwfkmg8BT0OnCFoaea17tHGVgoatA1nTpSfJ4voszV1qBlxWlPvqo/qLLLHVN5e0n0WJMP/+5vI9Ws91sShkiufX8GHNYRgXJ555ectVygirZFmHCfmznHX9tN2Vp259Km5fxxcT4u1BsslcRDG7V6ewsr4zFqcLzN6GuxtaACZLnIQkpj5qLG114bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Y22BrpTmVG5LwQMAZ+8OBnRvoromZAM5t2fjkjx9VE=;
 b=aebvyejMU7tC72WtPQHlB/DBtO/YTiDW5/L5qXPnlo/3hMe374GlHjFVPVCwfx4pGBzypduumUmNE71LZ80F22FdJGaJlk/N+g2CeseDBjq8V+8KgD9a4ASctmJbf0XH/P1hz356PwifTqBTU8rWjo12WPLvy+tQVd8pVvIGA5lnvmmYhuRv/8jm6mgVmhya5+ZufMxgY4J21quhg3BBp+jOP+TIlwbskxjYD0M0lpcGWwwVAs1L31XUcGQOzaF0nIC/a2Hplf+5+6y1b8WNL0ZAm+ewNoA3FDm3CH+GwbVSOmWpTuQs2le9btJiiekcbsxYOsGngJAwUQXOWdiOdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Y22BrpTmVG5LwQMAZ+8OBnRvoromZAM5t2fjkjx9VE=;
 b=juVpM6RAKYUfRbbOWRNKA13ySpAew+QjR0FNM21Qkq6cY7k1SLUszCVWyFRe68Vu8DpjVCp2I+47c2WYFVFWholwu9Ny0PW6iQ84zWr/tHYYeUkOAVGBUSV/ECNyOWAGZu3eDY24O9IHTZlKVT6thtFRfcKickncg1mRkC3ohPA=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CH3PR10MB7862.namprd10.prod.outlook.com (2603:10b6:610:1ae::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 22:01:52 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::12d3:3f71:5b55:c342]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::12d3:3f71:5b55:c342%3]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 22:01:52 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, david@redhat.com,
        nphamcs@gmail.com, Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [RFC v2 1/2] mm/filemap: remove hugetlb special casing in filemap.c
Date:   Fri, 19 May 2023 15:01:41 -0700
Message-Id: <20230519220142.212051-2-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230519220142.212051-1-sidhartha.kumar@oracle.com>
References: <20230519220142.212051-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0136.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::21) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CH3PR10MB7862:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c7efd63-2d3d-45da-5a98-08db58b4a6ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XhoGmR1kifsBa1vcudChDpClfOWBdCZ0qFHI8Nd1WAikakRzStPlxG0TwXPUT3/DGM1TB+jeMY5hN1KNSQSbxzxLvpr74HSF2FQOMXhcTTSjPrPuRPE05mCPfVch9ITx8FplliPOCR6ouKVLrum2/lnVtvqnd98GrpuxSjtX2ox348Bk0shUJCM2PWjqBilWZv3SNBh3QO2KdKmV37oszGDHUgWzrlAofVWqWU/ROw9d7T0VSRg+ObZHLWUYk6RwbgzmxWAQOKDmLceHzsRemb2UQ6kLzr7ERPTo9gYNYiGaBOw/iL6hXMLhfWla4CNbTZ4PkB4oxCmWIk1OMQAvIvNJuhNuheiSpx5USQLG6WVNB7P2JbZsz4fA8QHIh0pfuEcB/FKwWvrWBguAPLbW9lmgSs0NZEt/+MnWp3Vin7hRU+wIH17ua3ii3dUsx4a6NHW8tb1BY/XqDR8wiBsYwbFj3t5zYfkARJNqqVpzQU9fxU8pWw5wQgcqgHRLNkdHy9gxHlYZPE3WtMEcUnvLqu18h1uw0AQOGlJ1cShh37lUPHSLAv6Zqr7NNtts012F
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(346002)(376002)(366004)(396003)(451199021)(86362001)(36756003)(2906002)(2616005)(6486002)(83380400001)(6506007)(6666004)(107886003)(6512007)(1076003)(4326008)(66476007)(186003)(66946007)(66556008)(316002)(41300700001)(38100700002)(8676002)(478600001)(5660300002)(44832011)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T6y24uwkHPPouqmzFTW/N5JquggJmchRgTV8wKuwDBgsOrPuOmNKb3Aicf9m?=
 =?us-ascii?Q?M7zjuiVcDC6hhBEdugoit+Gjznh+XF9omr45dh1/U8immP95sCmPPwXhQXDo?=
 =?us-ascii?Q?n+A7c304td813DRZN7qBdqTBREj0Q6BuLaATr3FdTVGMwI0lo1L6BJWMb/Si?=
 =?us-ascii?Q?mnjxYwrO84UbfgAfGOh7JyztA+O6eJopDQVWWYFOqaRZD9+4qZAWB7Apth09?=
 =?us-ascii?Q?53shNRvwtyKnOIHF7KTgJR/9f326o4hIVV5jzxMEvBCrzoRp2GxUtkxzK146?=
 =?us-ascii?Q?TW+FTth/dVSjX3PIzhpssNcLzpLzJ9GA1rJTnaBcvIWffkmp+dfForh2IOuS?=
 =?us-ascii?Q?mlAW4FwcAjN1SSMW0xkoIrb+mPzod7BuUavQTZMV168vhn6Q9+jgL44enlIG?=
 =?us-ascii?Q?YmOxkD3OIPWlx04IdlLhvBQXkG3gqXeou2fZdtNlrzG7HW58prQHeu7dwslj?=
 =?us-ascii?Q?AJ04LzHP+6v6/IRXfQ6ZuckZAjnF4PKLhDUR3t0B252j5AtY8JwiA2RuS4rv?=
 =?us-ascii?Q?AdkPfFlBisgme6snCUiPja9ZongE/GDpzj8f4aVgGvHqNIaPTD/b4iiHuFOo?=
 =?us-ascii?Q?Oa/YCJtQvdvVSXclAz1vOMTKxpzvdtqbfKyqN+8PodfyhzVk8CTcG0xtqKMC?=
 =?us-ascii?Q?5gK8C1xubUFTRDwQnEhdffaLIBkAZLaMuvcNoNuFhdgB8j6oCznh4zlfMVfD?=
 =?us-ascii?Q?Kp1U3fwfMTib4Jtp1jNPOirPlZUyeLc1LzjYx6Ut3UivLRcnu4xkx/kx3NFC?=
 =?us-ascii?Q?i7gTf/oaSPT6mApkHh65wrveI2SGJv/jlt45jAmkzVYV2kZs+SdHhH4sp8EU?=
 =?us-ascii?Q?p08V5fUxhzBVB2l4Agd5MQP1srZnJZkJIS2Mllgt/MCGsDPJ2r/ulabogmN5?=
 =?us-ascii?Q?CaWxtNGG0Ltf8DSsfiUakxp5EnbM5bYc7EoFn0uJbqNFmGGSLyVeOvzWg7W6?=
 =?us-ascii?Q?HNzTeTZQUgsHVhvRDyEwo1hAGJFL5QJiI9MUzx/wHLSLDJTJ/N9+SopEYmE8?=
 =?us-ascii?Q?Q4IoFRtyK0A5i8pCkqQPEvcuVfJltn1GYT2rz5+Lggcni9CpseGL9QmmkDeE?=
 =?us-ascii?Q?hv22e/bsZJD3NT/GpPmSpSbHOSybH5/z3blk4aiVM9UXZGMAHH5MTyd1NOTu?=
 =?us-ascii?Q?WOyZuQz2tuw5fuBML9cnJGZKLgMR05zXjsr8bRL9qojJB1rjAlXYD4QXWORd?=
 =?us-ascii?Q?e5hI0DjYW31kLnD77zMbSp/FSyfi5KRRfqcRqVkKlgP9T2EnW6221C70I0av?=
 =?us-ascii?Q?Z6bXe/X/zi0ytC5HSrL4wP6iMN4pELnAezT+IVTeMs0TCPHwGffsHIfVP2b1?=
 =?us-ascii?Q?g5elyZ36lfWjsem96A9OLETzD8Y1Yqb/1znP9FtIzgJ301KiXFfLnQYSrJ9b?=
 =?us-ascii?Q?eJy9lUh0d6oY7j9JxFHKgEnpguuOaEoLTJwaVUJD85ouW+QQ6g89kFP5iDF+?=
 =?us-ascii?Q?MOKmHHVro9usF/h7O5ZDBUKyK+liUM4Ok/txzpyVnpSff4RcHVRjbTlJovep?=
 =?us-ascii?Q?ug4S450MvIPMIEyNxsXf4xUD8rK2Ge6A2hH9s13UYapr8QAHnyXlgCC9YLfw?=
 =?us-ascii?Q?41I0OYpL4BY6S6Y/u+tqrROClg9oCdnHwBEtPejw2WbizTpml2z1JFrkqRex?=
 =?us-ascii?Q?yikAS0BuBGEaEYpKp4X5T/Y=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?AVi+LaU5dFVjwymf/rQzKkIY/HRjuUrDMssVAYFnvEY5KvA66qZEi3mHpfEh?=
 =?us-ascii?Q?/tc5i1sZ5rRxf4oGU3hSsoFDpkeCTJrHxxazrf0NVRSA7skg/YI8wr3755kJ?=
 =?us-ascii?Q?VDRo/PjFKBrGKyjSBfMkMb6ktVBOiSEqjN1IisNfk+rLXgY1JiYrB4LqB8aO?=
 =?us-ascii?Q?gkoquLUSoJe6KQgOzjmPeXK0VKccOc/C1ATMLMuarPHBbQ6kI6ssW3/KJFZ/?=
 =?us-ascii?Q?RFOs2yxSGq+ZCto9VH0AytFAZGvHbzdyoYDH8glbd3/bBwPGjMrf/Iiakh8Z?=
 =?us-ascii?Q?I+II7/Ncqa3iGmW9VQDY0BkyOel0Cz461uStb9t+zWDXbeG1u489TnpAvaH9?=
 =?us-ascii?Q?k/oqBdQ47g0fXPf4f9/IsmUphWkl8czUwElZKgAi5pR0/Aq2eSpuC1Cnw3eB?=
 =?us-ascii?Q?6yTNpx42rn/ykKfFJOdN9FAxx5FkASoaPN2uALW3JNYW1CM380kEj+3RChsq?=
 =?us-ascii?Q?NywssWeq0QTSO4G83HhiddioEpOyDqEwPuUYw0MQwczOctdPE8bBT0+lbURD?=
 =?us-ascii?Q?4NeFvLlE6s2gRYmRcAgtNjzBgnUfCR3cswXwGk44YtWKMIrR0tisD7N+W0e/?=
 =?us-ascii?Q?7CkpbRkQWSt6vvvUdSbgXcNsCsqckwVLSKHYPWsPl9OMKEb94bCnwafPS3Bd?=
 =?us-ascii?Q?9lepBBbaKJ1Tuex6gJDMunVMpo89gopK1ukhw8xZAvoERNIRj/DjC+RVm1Aq?=
 =?us-ascii?Q?k4krueMHF+MNG7hqRtnsCVR1U3uNKRpQ5wJWSwjuVENGTFpFI9EGGbUnyAep?=
 =?us-ascii?Q?Dhw/Qh/blJ4nStaeg+lLU8KAR7TJIQpV7bJPdKVFSZeGunTC4vD2riSBpDSM?=
 =?us-ascii?Q?MK00x18uSIlYfX1I1yGVCW8tIHq/EfmL7QxfTFqLIRr9yyumqdGx4vPNHJvi?=
 =?us-ascii?Q?qeJA/7mBmmijlMD4wQapb8FZIp7ycUI7fAI2VRxjo4LupM5j6O68BbfxUbqi?=
 =?us-ascii?Q?lYGDJ4zyfzKhnpZ0NeiV8NACtQ+NT9up94ZPCHSdRx8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c7efd63-2d3d-45da-5a98-08db58b4a6ae
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 22:01:51.8937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tKcd9ebVoB2QPdiVEYmVAFWRSHSkE0/fWuz8nzG3ZRhCiwwxOxce2mbOGrtUw/RrieZCw4aGbG2hpW2eIkzilDqN1y2tc4jeVoe7+CeHNnw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7862
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_16,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305190190
X-Proofpoint-ORIG-GUID: Bzby6xGu6_4T6BllsjrEGRaz_bY1NLve
X-Proofpoint-GUID: Bzby6xGu6_4T6BllsjrEGRaz_bY1NLve
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes special cased hugetlb handling code within the page
cache by changing the granularity of each index to the base page size
rather than the huge page size.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 include/linux/pagemap.h |  6 ------
 mm/filemap.c            | 36 +++++++++++-------------------------
 2 files changed, 11 insertions(+), 31 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index c1ae5ebc375fe..7ca967849c2cc 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -719,9 +719,6 @@ static inline struct page *folio_file_page(struct folio *folio, pgoff_t index)
  */
 static inline bool folio_contains(struct folio *folio, pgoff_t index)
 {
-	/* HugeTLBfs indexes the page cache in units of hpage_size */
-	if (folio_test_hugetlb(folio))
-		return folio->index == index;
 	return index - folio_index(folio) < folio_nr_pages(folio);
 }
 
@@ -846,12 +843,9 @@ static inline loff_t folio_file_pos(struct folio *folio)
 
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
index 570bc8c3db878..12eee69240525 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -134,11 +134,8 @@ static void page_cache_delete(struct address_space *mapping,
 
 	mapping_set_update(&xas, mapping);
 
-	/* hugetlb pages are represented by a single entry in the xarray */
-	if (!folio_test_hugetlb(folio)) {
-		xas_set_order(&xas, folio->index, folio_order(folio));
-		nr = folio_nr_pages(folio);
-	}
+	xas_set_order(&xas, folio->index, folio_order(folio));
+	nr = folio_nr_pages(folio);
 
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 
@@ -237,7 +234,7 @@ void filemap_free_folio(struct address_space *mapping, struct folio *folio)
 	if (free_folio)
 		free_folio(folio);
 
-	if (folio_test_large(folio) && !folio_test_hugetlb(folio))
+	if (folio_test_large(folio))
 		refs = folio_nr_pages(folio);
 	folio_put_refs(folio, refs);
 }
@@ -858,14 +855,15 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 
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
@@ -2042,7 +2040,7 @@ unsigned find_get_entries(struct address_space *mapping, pgoff_t *start,
 		int idx = folio_batch_count(fbatch) - 1;
 
 		folio = fbatch->folios[idx];
-		if (!xa_is_value(folio) && !folio_test_hugetlb(folio))
+		if (!xa_is_value(folio))
 			nr = folio_nr_pages(folio);
 		*start = indices[idx] + nr;
 	}
@@ -2106,7 +2104,7 @@ unsigned find_lock_entries(struct address_space *mapping, pgoff_t *start,
 		int idx = folio_batch_count(fbatch) - 1;
 
 		folio = fbatch->folios[idx];
-		if (!xa_is_value(folio) && !folio_test_hugetlb(folio))
+		if (!xa_is_value(folio))
 			nr = folio_nr_pages(folio);
 		*start = indices[idx] + nr;
 	}
@@ -2147,9 +2145,6 @@ unsigned filemap_get_folios(struct address_space *mapping, pgoff_t *start,
 			continue;
 		if (!folio_batch_add(fbatch, folio)) {
 			unsigned long nr = folio_nr_pages(folio);
-
-			if (folio_test_hugetlb(folio))
-				nr = 1;
 			*start = folio->index + nr;
 			goto out;
 		}
@@ -2175,7 +2170,7 @@ EXPORT_SYMBOL(filemap_get_folios);
 static inline
 bool folio_more_pages(struct folio *folio, pgoff_t index, pgoff_t max)
 {
-	if (!folio_test_large(folio) || folio_test_hugetlb(folio))
+	if (!folio_test_large(folio))
 		return false;
 	if (index >= max)
 		return false;
@@ -2225,9 +2220,6 @@ unsigned filemap_get_folios_contig(struct address_space *mapping,
 
 		if (!folio_batch_add(fbatch, folio)) {
 			nr = folio_nr_pages(folio);
-
-			if (folio_test_hugetlb(folio))
-				nr = 1;
 			*start = folio->index + nr;
 			goto out;
 		}
@@ -2244,10 +2236,7 @@ unsigned filemap_get_folios_contig(struct address_space *mapping,
 
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
@@ -2285,9 +2274,6 @@ unsigned filemap_get_folios_tag(struct address_space *mapping, pgoff_t *start,
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
2.40.1

