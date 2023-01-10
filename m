Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48150664E06
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 22:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbjAJV3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 16:29:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233179AbjAJV3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 16:29:18 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E805F48C
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 13:29:14 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30AL0Pw0030230;
        Tue, 10 Jan 2023 21:28:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=8LXZYJ3IF5YwIJs7/2QVzJbgQ0tay2z86vhYBUXlFls=;
 b=liQg+Oyswq18i1XeSN3JWa52uLQp9deuM2P7BlKCXG78m0B9FlGi+QEWp5yI78W7ggAA
 HvGbPavVCePAhYF7ITFEHfuGOU0RR0iyRk4ME9oOBgnACOIhHbRfEPtSwfYlFX5fi0OP
 pdA0BvpJrQylVEkibI9nNIc4ft12AmuxoUfJkoYnUgBrqUZLI8GBUVYZJFoq/Hhgepwg
 tMebYCJUmJU7USUJ3C+5L/fAWI+Yd8jQEk/oEDM4sDo+R/LAa45ZVfnPIK6Us7qKduRI
 Pf6hMYVJtIkk/U1NXY5qZIl526QXzK6SKYZhC6PAZ48kksuwwtalO7sS08W9OZRerLK+ Bw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3my0btpf80-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 21:28:56 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30AKY8kU022668;
        Tue, 10 Jan 2023 21:28:55 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n1f5x25br-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 21:28:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=noEEqFT94ehjSChaYsvymqQ8m7qLp3FaARO3VVRR87U22ybv+PIOwc+wxM2rjraHSTAIksqcD3YvDcMljyapVJUN28I2y2VsW1oKciEkg6TNvWWE0xM7fZBfqFizwrir8CkoQ24bINKTJo5puuPuxzMGbaNcMAadh/tJQ/TVyD8jLppBCdpcmlZJl2La89V/SobAigcCDorlhG6yoDUFB7l2bXx/u7gKUZu3g8FVE4rMXBLedsd+nZm1LuNL/H1XmT2S2zuftxfIoBg4Gvj7soSA5h5VaD6me1vUmVU2fF7bI3BLgjKXQHK2//te+1p5lJKhUZvZaDnIFDUKoiZFpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8LXZYJ3IF5YwIJs7/2QVzJbgQ0tay2z86vhYBUXlFls=;
 b=GukLpCRdkDNd1+Q8Fuq5R4SmINQyUwfRvAlF6V2MyDC3Kjwc6OvyMN8sBRg0g5mTg/b5R9ygTEuvu2CPP1ShNHt19blV5f8A/sNGrkjQmbePAjtIksX2c2eDzUYY/5vCa/ulOtNcbH2li2ZhoZPfdZEDYxHL2krFCePKO8xuNcmD51CrQckckGNY+AiGOWZSQcGTs59kjaLPkSVvMABkDy+GJIEfcs+nMn5fFS5qa5qO81YQCHvWV7ueUZUuQJioKYn/gR8PbOZ3Xj5RDbmJuVXx1Lox4Sd2RU/0kly8iw1Te8U3FFozlAeAu85R6EP9nO0jCbpSytIn7AFvy0lZ4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8LXZYJ3IF5YwIJs7/2QVzJbgQ0tay2z86vhYBUXlFls=;
 b=kApGot+ru9Ozl1Xg/OMtUn9lilmbUIPbpZM1cB4k+bB8e4lQAdQbVOnIQo72hXx7Ndik0vw5EtHgemeAWWMStQwurPsB2TObXXRrfSTrGaDrf77YdE4ijHnrNaNT+PROorxBjm5rh9UpfJ3Kgirpwl3GaOuJGdeQb1VkwPxHCKQ=
Received: from DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17)
 by DS7PR10MB5133.namprd10.prod.outlook.com (2603:10b6:5:3a7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Tue, 10 Jan
 2023 21:28:40 +0000
Received: from DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9]) by DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9%2]) with mapi id 15.20.6002.011; Tue, 10 Jan 2023
 21:28:40 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, jhubbard@nvidia.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH mm-unstable v2 4/8] mm/hugetlb: convert alloc_surplus_huge_page() to folios
Date:   Tue, 10 Jan 2023 15:28:17 -0600
Message-Id: <20230110212821.984047-5-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110212821.984047-1-sidhartha.kumar@oracle.com>
References: <20230110212821.984047-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN6PR16CA0041.namprd16.prod.outlook.com
 (2603:10b6:805:ca::18) To DS7PR10MB5117.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5117:EE_|DS7PR10MB5133:EE_
X-MS-Office365-Filtering-Correlation-Id: 13bb35ca-93b6-4bf3-87aa-08daf351a488
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2GxtNwQ8zfWyyIXBljBK/5885SE3Xvh1pSEOBIzJzuzMNDFhi4kaHwUtzmdkl88LwW3C/mkj8zDLKI7gXCDkVYdyP6Dp8R0gXSRpuzy6Fbxa6ikurUoPC9wRGl8nhrZ3UqUSsFo6mGc9Un7jhui/3fJ6qqn1cp0lwSAymhlzRGjOWlYJfWk2a0P1TpxvdqZ7xdP0/CpMa6L5QDDk8+ZbFvnTfeoiJ05iBzTZkmsFu45Lvwj1RnldFU+ZAwjDCeM6BWPAhUwO1ZcPw9z8jTf052BldLz90ezDQ+OISm6w1EXnlawF0NUSDUyMyHfZaIjk8WcUyzXeHFR0rvmilGyceeCicXY2W/ZpMKnJw8WSZDSWgd7udX/1f044EXVrATe5aNRmKCnP8l3O9inmlLJ/g2pXfSpnjKb7zwVac49qUsF0f69R6nng4qVrhm3AYKXcE5Wa1+4yQdY8kyoC0Vh63qhQCNvmxM9YtkfMMxaEoulIt5afP2FJosd0Wj0QZqbI3uviVZ4lTy00rfXP6vxJOGl/X1vqy3U5Uln5RPaNdTcWH70AG2W9UxiMmpm5JmPcVarnfbSHZgDPemR79FItLLmGK6IOm8M1hpSVqdR+dhQPuOcP4oMgewjPrS/duAODtfp/DjpOwpwBctH0dAIViUuufEtsDCR7ThgA4Fq38c4nKIlgPbwyi9KhGoNg6QiG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5117.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(376002)(396003)(346002)(136003)(451199015)(38100700002)(316002)(36756003)(5660300002)(2906002)(41300700001)(44832011)(86362001)(8936002)(66556008)(66946007)(4326008)(8676002)(66476007)(83380400001)(6512007)(478600001)(6486002)(1076003)(6506007)(2616005)(107886003)(186003)(6666004)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tQUB09hrqR/ZraybNqzfdzZZp0FPodD0QdtV9aAQKyo0wvWBDVLLps0C73WQ?=
 =?us-ascii?Q?CdJZ4/mKxgzYxsZvxrtE4+I5PHaYBzmuHqWijfHuWdOuu0dHxYefP4HNTuzw?=
 =?us-ascii?Q?IEoj4iNnn1fsQd27nMoU+O5OP2lfqGwoajC59dxbnQHqs5C4y0SIT7fzuzf6?=
 =?us-ascii?Q?cvbVUvjlZsoESwLipPIorkhHpdvtcN6xBxHg7KqVSZTPX42icA+NkeYvnkLH?=
 =?us-ascii?Q?2oalg4efiFqxv+noFRKPZr8VnHN4unCEeJUptjaYg9gbiS/Zh/zSJsYJ2vkg?=
 =?us-ascii?Q?tDkt3Xf83mzoTuIjsMgnDs8y8C8ElRPlnwcflygI2VZumzp1CBXyDmzA9neE?=
 =?us-ascii?Q?o0uU9RoMfgzARDkFC7kzHR7kmjA567QuJXZ03c1vZATtmytRnR7M4YTdpiT8?=
 =?us-ascii?Q?nYnk6bdYmr64bENe2PN2ooAs+UIYeOpqjyqeuaBYhjXMK8vyzwfJIFqtkAH2?=
 =?us-ascii?Q?kr1Q+li6yo/b2zGyaGa0Wz0+GzjhkGawakNjKtyyChYmCRdRljqSSHBEGNCN?=
 =?us-ascii?Q?sRMT8sjrC4YxWDGMlZEjNDrHsYLIEyRbuxuA6Q7Kxd4UoL0W34tJNfl3TJj6?=
 =?us-ascii?Q?MppJ60vMqPbe8uw3mMRhd26QbL/PVSzSLRZB7jNRxGIC0Vul2kafDDSYtATA?=
 =?us-ascii?Q?vQfiMa57abDzyiO/SVagXKjPNsQiUHbnzBi5wOO+r9k2xMU9UgWOvXLVpXif?=
 =?us-ascii?Q?DeLNus13z6Tl3xauwCxdXAaEQ0NpYq2O/Z4bAQWBbnaptMsoAGpHyj+6ekyt?=
 =?us-ascii?Q?GL3gITzO3nh7t/p8xKGE+Rir3HmqAaImejsaKgTJHkGbGatlgSRdTrAGciOC?=
 =?us-ascii?Q?LVlBKeyWDU+20IOJccNaaVr9jjdQWuZn1K+a+W4hgS7SNagN6XxeYcmIBlBM?=
 =?us-ascii?Q?V9l9bsfWoO3ij4VxriHur+jhO5HYi36venjZgJRo11nTN+Kne4yMIIqVZdtZ?=
 =?us-ascii?Q?imlPpTmqrADoRgIy6hCjlJtZPJ1wKhBGXEAzO4JK2/+vy43inrsldH+eX8HQ?=
 =?us-ascii?Q?p61UmcERGX1HoKQqi/j5eB7YZaAyNJFwh2EdkGwym4z5TdATWXEPTzDukMxi?=
 =?us-ascii?Q?lb/x7igrUzdrhyK7alEnnDNTP/18w0+nTLFsIxmUEwE7tsF2wlBPsscGbjFC?=
 =?us-ascii?Q?d2Cas3dhjjoy5CxAlwGV61xxiftnoOhOGQmUtYCnKisHIzPnYwa83MJypkLP?=
 =?us-ascii?Q?eXPQiQgs5c7X76zUK/6jO9YuMbZrb/QnxGIeipuPW8BatEqGoX9bxm173Kox?=
 =?us-ascii?Q?YmTyFfu09yCfI0wBRy3N599CAbkaHb5cERwp46xoZfjbu7xlUVjVH4/zN2FP?=
 =?us-ascii?Q?e/B2/ndqx4ddqQrY2OqhUlvDJWLWtnYThocfGPklc2m9W+0OGs/nZ/tJYpv8?=
 =?us-ascii?Q?K8Lgo038PonWQd9qQGvCLH3O2ASNMfONL9pMhH8j8uPuWZsGSbpFGF4DjkRV?=
 =?us-ascii?Q?xws1BID/D+/OKVv8ywIrgAzim293/cRvaBqmUMtIo0DROuBLUdFhKPhFHFjg?=
 =?us-ascii?Q?seCojr3z5s27JFx6rLbFvcASWzAKwLAjP8DJux6o0caFQSpSTfNJeGWEtugz?=
 =?us-ascii?Q?iCpeJ7vHZdw855cw5mxlgSqb01RR3hO74BnBd4b2Fs1AosF8CJpbteL8tHg4?=
 =?us-ascii?Q?1nReSa6vMxMiVJadK3V8kXY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?WLXKdyFDxDuZGgbzCmMs5l2Ck9vVGh95OE9yDUJqjiWqmaXnZng5WOZv7Ps9?=
 =?us-ascii?Q?xRH5m4uLmbFqQdLuL/zhgnzWbNxqYe+jDgxnYfJhJOZEYrvWH0bv12sS8cWm?=
 =?us-ascii?Q?XWm3CMgHSKKKBQ6Ftx6njDEgWPAsomAlMDEdKZYG9pBI1ZLc+CEqWpSBSJ/I?=
 =?us-ascii?Q?kRNmtB8JRu3zMZvSzlDP1HRmbQ800X2c09g9/zRR4e1FJyu+g1pEJnjpAUEC?=
 =?us-ascii?Q?vT7v1yiOMkc92wjeNDex3e0DVEOzS+Mnhtwe4wWf0sRSnifVOXO0xP1zeHsb?=
 =?us-ascii?Q?mB8KvycgYftbMiWwdmiaBVzledsKbZt187KHRoijSzLKMhoTI9bvzaCRhshB?=
 =?us-ascii?Q?7MIdspq2tjo7G7dfePBC9MZNt/lVwPda8I/mNEJvS7hgxKVGUajBUbdyPfld?=
 =?us-ascii?Q?dgJO1yKxk+eDc5lzFvJuk484nz+4/DdB78Toimtv9w6G3RfBaHwF0H1oznyS?=
 =?us-ascii?Q?MfUMTE+07XTFEDW4HCi47yD6sQMaMEb1tWLYo47/1sAwTxKyIzEylUuuIiUl?=
 =?us-ascii?Q?Kx5mFoY9yPgsWF0vYjkt11H0xIigYklr49JRFfTdKvgd8ftYSNOrK9qUOcrk?=
 =?us-ascii?Q?JfUDCF8/7U7X7N1082qzRniWyisJk6ygqp1HnnIIeEmwa0QK+ZG8AGJb2vt0?=
 =?us-ascii?Q?9TiJs07ggZe0I6IcvQjaLEw7WMV7yxeFcmT9MWU/SAPNZ4dnq2JT/O2/Gi/V?=
 =?us-ascii?Q?5NRzUtEyjKujjoXoSeCCTUhA5yV0oaf6tPSbl1yToR4oSce46pqMYlfze0Gp?=
 =?us-ascii?Q?BiKSbOEn0+xYh8Go7l5F6evwsigwFvREbrb9kJa6cm/Qy8Yz6/gRfnKxGcma?=
 =?us-ascii?Q?az833IOZsuR+tNdOPf0OK/VAc9xIsHvqsdN0rYiqM+vli/SY/XTpjuBu38x3?=
 =?us-ascii?Q?Jx07AIdHUo51EAe2q6/cdfqaNbjq95w3Idv/k6YvXhz3N22hA+ipJyovpin8?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13bb35ca-93b6-4bf3-87aa-08daf351a488
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5117.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 21:28:40.7313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0rNl2NzajHxHF2kx/Jsej0Ic4/Y8SdimmIcriQwIs0uCTwnBSXQPho0UpUa1mLMUm+2zDQP7PE0ALnTQYmG3gik8/maBieh6mENKZ/cxTUI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5133
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_09,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301100142
X-Proofpoint-GUID: X8_GjbM1-XiPd5aTgnVEMPyCWNJx3trr
X-Proofpoint-ORIG-GUID: X8_GjbM1-XiPd5aTgnVEMPyCWNJx3trr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change alloc_surplus_huge_page() to alloc_surplus_hugetlb_folio() and
update its callers.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index c206a8c1ddb6..62552172683a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2234,8 +2234,8 @@ int dissolve_free_huge_pages(unsigned long start_pfn, unsigned long end_pfn)
 /*
  * Allocates a fresh surplus page from the page allocator.
  */
-static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
-						int nid, nodemask_t *nmask)
+static struct folio *alloc_surplus_hugetlb_folio(struct hstate *h,
+				gfp_t gfp_mask,	int nid, nodemask_t *nmask)
 {
 	struct folio *folio = NULL;
 
@@ -2272,7 +2272,7 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
 out_unlock:
 	spin_unlock_irq(&hugetlb_lock);
 
-	return &folio->page;
+	return folio;
 }
 
 static struct page *alloc_migrate_huge_page(struct hstate *h, gfp_t gfp_mask,
@@ -2305,7 +2305,7 @@ static
 struct page *alloc_buddy_huge_page_with_mpol(struct hstate *h,
 		struct vm_area_struct *vma, unsigned long addr)
 {
-	struct page *page = NULL;
+	struct folio *folio = NULL;
 	struct mempolicy *mpol;
 	gfp_t gfp_mask = htlb_alloc_mask(h);
 	int nid;
@@ -2316,16 +2316,16 @@ struct page *alloc_buddy_huge_page_with_mpol(struct hstate *h,
 		gfp_t gfp = gfp_mask | __GFP_NOWARN;
 
 		gfp &=  ~(__GFP_DIRECT_RECLAIM | __GFP_NOFAIL);
-		page = alloc_surplus_huge_page(h, gfp, nid, nodemask);
+		folio = alloc_surplus_hugetlb_folio(h, gfp, nid, nodemask);
 
 		/* Fallback to all nodes if page==NULL */
 		nodemask = NULL;
 	}
 
-	if (!page)
-		page = alloc_surplus_huge_page(h, gfp_mask, nid, nodemask);
+	if (!folio)
+		folio = alloc_surplus_hugetlb_folio(h, gfp_mask, nid, nodemask);
 	mpol_cond_put(mpol);
-	return page;
+	return &folio->page;
 }
 
 /* page migration callback function */
@@ -2374,6 +2374,7 @@ static int gather_surplus_pages(struct hstate *h, long delta)
 	__must_hold(&hugetlb_lock)
 {
 	LIST_HEAD(surplus_list);
+	struct folio *folio;
 	struct page *page, *tmp;
 	int ret;
 	long i;
@@ -2393,13 +2394,13 @@ static int gather_surplus_pages(struct hstate *h, long delta)
 retry:
 	spin_unlock_irq(&hugetlb_lock);
 	for (i = 0; i < needed; i++) {
-		page = alloc_surplus_huge_page(h, htlb_alloc_mask(h),
+		folio = alloc_surplus_hugetlb_folio(h, htlb_alloc_mask(h),
 				NUMA_NO_NODE, NULL);
-		if (!page) {
+		if (!folio) {
 			alloc_ok = false;
 			break;
 		}
-		list_add(&page->lru, &surplus_list);
+		list_add(&folio->lru, &surplus_list);
 		cond_resched();
 	}
 	allocated += i;
@@ -3352,7 +3353,7 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	 * First take pages out of surplus state.  Then make up the
 	 * remaining difference by allocating fresh huge pages.
 	 *
-	 * We might race with alloc_surplus_huge_page() here and be unable
+	 * We might race with alloc_surplus_hugetlb_folio() here and be unable
 	 * to convert a surplus huge page to a normal huge page. That is
 	 * not critical, though, it just means the overall size of the
 	 * pool might be one hugepage larger than it needs to be, but
@@ -3395,7 +3396,7 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	 * By placing pages into the surplus state independent of the
 	 * overcommit value, we are allowing the surplus pool size to
 	 * exceed overcommit. There are few sane options here. Since
-	 * alloc_surplus_huge_page() is checking the global counter,
+	 * alloc_surplus_hugetlb_folio() is checking the global counter,
 	 * though, we'll note that we're not allowed to exceed surplus
 	 * and won't grow the pool anywhere else. Not until one of the
 	 * sysctls are changed, or the surplus pages go out of use.
-- 
2.39.0

