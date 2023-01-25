Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64AF967B7D9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 18:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235307AbjAYRGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 12:06:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235770AbjAYRG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 12:06:29 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E69E5A36F
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 09:06:24 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30PFNjsp009509;
        Wed, 25 Jan 2023 17:06:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=z3ea2iaVPYZ70tiYGbEI73RrGrv+fSL+A233vkE/EZc=;
 b=RFB+VXA2TsBgvars8j57xB7M/yosiF6dfuqWEakeOamZW54xJtSbdQb2O2g3F9BPQrsg
 BHniVwWuCtfD2oKOdbt46/oX0Lm5bBCzKldQONtj+1KZUrLqzyrFA7bEoSoRjuzHdKUl
 R/Aj84s5mwV37eVAbzGCJ7CapWJdj4rB5nH5FFTP4/kQpfTbi4nyJ0FJbR6B+DsHSf4E
 T5VkDgTlkBl55HiiCzA5Y11RMA6V6+kOHCtuKp6YvtwOwoiUwLRbiILZfqcB2OGtP/uZ
 ymjJbuGufnkQKZzGhcpHdOZBqLCKMTawXnCmyQu4jIP7Wd0iTLgVVenxPorYvdyZsbpO Vw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n883c8jex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 17:06:04 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30PGHiCQ031875;
        Wed, 25 Jan 2023 17:06:03 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n86g6t5av-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 17:06:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RozPcP14nkaIIKntLEpVvR0NbZwE65Q8KmLqpe7FzHlGi1JEuLmNCTphRoMPHtP8E/yIU7vJNVJxklPjTkxaqSvNnDoU0rrDQsMiIxgX0s4rdlOKFKi4EK9oIViQNsBoGUxPY2GwQCalaRP/UM7HfRb2daj/B8kTIaUlwTtwN3eWXD/3Xjj9Qtiu/NmVpWhgoX4gmRrqn4TZmpzOmgYYuEEOmF1u2AO3KIvC45HpaGbFgYuaHleCDN2i5OGC3LKIlUO8vjiIfD5nN6UE1un0bAfraE/aG4RuNZZbDSDBT62wLViIgeZMDTV3xtFZb3XA3Lyxf3mx7FN/w5SbKypCHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z3ea2iaVPYZ70tiYGbEI73RrGrv+fSL+A233vkE/EZc=;
 b=IMLwNDIaNL7LL+/yyCwKHi1DpfpsITtXqgOW1HA0HOBhJjOQJOtKMvfW5H/73otEdyVjsK6cnKa12FooMdM3axqO/adBxMEymuboIRR1IEQ1AfZJhUjPWxEFoRfQU9/37UxSjrMPcaM1rXUNRwTVGkHR93FzteYDPunYKyKDEt5kx5WtF4I09EZ9MNC6IF372nZ7aZgh3SJ/OBdz1IwvYT8+iEaGVgeSSz7dEs3xw5ScVewVUOV21LDlwDb9ICa7Hjcrl7ajVvjUiH6LbBhKBvMsQ9BaKA196ZMhUHRUjrsTYb/UoXxIdWHzaizV7nLxLejl4n752XNTMwvy65woaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z3ea2iaVPYZ70tiYGbEI73RrGrv+fSL+A233vkE/EZc=;
 b=tK+jg2s1Jy968/mkApRhUKzFSIqRp/4wv47U/4vwPPUV2HBNtQRXXa2CJyA038cA6YEDIF5KdyhtCXpBWzsuQ3tkS4fKBb7moqkEJuKG3TgcuMuoBpWVPuFvIQ2BFxWYdmaUbiOhyGDgSkglk4SOsHjHXVu+Qn89lhVwbTKRntk=
Received: from DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17)
 by MN2PR10MB4384.namprd10.prod.outlook.com (2603:10b6:208:198::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.20; Wed, 25 Jan
 2023 17:06:00 +0000
Received: from DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9]) by DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9%2]) with mapi id 15.20.6043.017; Wed, 25 Jan 2023
 17:06:00 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, jhubbard@nvidia.com,
        gerald.schaefer@linux.ibm.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v2 5/8] mm/hugetlb: convert restore_reserve_on_error to take in a folio
Date:   Wed, 25 Jan 2023 09:05:34 -0800
Message-Id: <20230125170537.96973-6-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230125170537.96973-1-sidhartha.kumar@oracle.com>
References: <20230125170537.96973-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0113.namprd03.prod.outlook.com
 (2603:10b6:a03:333::28) To DS7PR10MB5117.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5117:EE_|MN2PR10MB4384:EE_
X-MS-Office365-Filtering-Correlation-Id: edb7cb53-3212-483b-b3ec-08dafef66efb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VoFzedH55IxCXfs994+vmKyLkCt/LlDNMQLY3tBZtJLSdUZPcp2x3O/TRH/28jq4ZpywmFHA2lCdK4Z9LXjL2KfYQ3XkMwLHHNkeKPIKelE9TOCC3GVOHQPmNEOcr6xsV7ZT7ehpbRlsCT/Vc0G+AOFN4Yolh0Gz1zuQZetM/6iXSCp9kdJmRjDAI2L8ZYkZAEH09tkQtQAnj9MzwC6duB4pltWubslUgt8g/5r8ukVyrm2a3LF/0V8ahRmmIPFoVbwIONx6SeFv3LcEV/RDHydPfeRAxeoG0fpmZ7JcwRxAbQPmJDpwOJ2E7FeoTdlnAMgYzdSuJkJMyBlfQFYnEpPOQ8boAiAao77COphlJ+2LkSU5oWMKAg2NBQq4NFKrQgn7i0fBs2s2ckEIGpZeD4Oxbb95RPb19ABFI7uyC8FbBAgYroDunMCVH8Yd5BrhdCVoSe3SX/LWkb8tc6IwgbfJ3NJWE1HiAXT9IxZPCB7PLwLs0XCv1a13+hzP7b3Qj/EIuyc9ybHymHr/iW96n0CBZiS8poBE7VmnA0qhCh7gunY8jmg8NsuR/bW7AgbGxcQMgz75yZZXeXvnKyuZeI6/uqBOSxJ4HTtn9HAIvSbl83ubfuo3P0ojE22/n1kwfozK/Z+4ZupiCbKDx6HWBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5117.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(346002)(376002)(136003)(39860400002)(451199018)(186003)(26005)(6512007)(38100700002)(66946007)(66476007)(66556008)(8676002)(83380400001)(4326008)(8936002)(41300700001)(2906002)(44832011)(107886003)(6486002)(478600001)(5660300002)(6666004)(2616005)(1076003)(6506007)(316002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YPhLAf4DVUj1h4TmYkHSr8/shIEAgSHcEffxPtTP9ON5EHyGB7Id81zmPj9X?=
 =?us-ascii?Q?BYVgb6AeBqj5qU/L9i/P9Bhwotn2UyxWOLDvgECPKg7ZgkdBzEKHD4RmseAy?=
 =?us-ascii?Q?Bhq9DllPLiOc0Ce6ZBcPVV+Qo8UTYFHLpjTuqCMLrvzxhpvW/KqT4qgu66fN?=
 =?us-ascii?Q?jeKF4MfhDY+62BkAJQPfPGTvwd+ySAoMcq0IGBS8TjtOdpUtNG55sooyYvAB?=
 =?us-ascii?Q?zOAMxYHAzpapXMTH0zXRCmAu4xMSrTZ9V2Old4LaDlZWj2Ye5FWZuHne3qyX?=
 =?us-ascii?Q?Kh56ze4IbrREIY2tilANDtcGMTkKUTNkJ5We0PYx48fOnthCc7tPsJMchA0T?=
 =?us-ascii?Q?q2Us4xT8Kzh+uDYseT2etvRBIfNjh7rooItfaDQNDRyI/UKrRozX5uglYt6d?=
 =?us-ascii?Q?qExS6yOszUgUC6u6P8r6GLg2pLtfsnT+ZiH4jBLwF75xzJJynVf7I2h6r+Mr?=
 =?us-ascii?Q?gsAH4L+PW1nU51CWqR7QPvucH2heJ3RcADGDCmCpRJLlut8f5K+YpHHu3vn7?=
 =?us-ascii?Q?AlnAtTpdn33GZClG+0JpYe4bbcNI+6ySgA9JEyk6MtAAKPNjiF9nxeakdgBm?=
 =?us-ascii?Q?hxphRq1RnJ9lHzLU4YALAqGhzV4sOyGNz0ijXgr/LnfXt26+pA0kV4MJVJrI?=
 =?us-ascii?Q?SNaSIYlNvwjtPnKhEVl3iinHeUr6OgVNHqzSV2p0mC2EYpJeZZpRPYmhCMpi?=
 =?us-ascii?Q?f2/bYQ3JT6erPYBMk0/3Y/zidpnAn7CIbVZMWe9MmXifOlI3xL2Cey3TRFf0?=
 =?us-ascii?Q?zO/Cvh4ZwvMeW8Y0yLIMOOsJRIhQv1zY/hgODpycMhh8oX5rDPh/m6SoQGwm?=
 =?us-ascii?Q?5HvN9MjPajx/3+qIOY6JOeBOP4XqBj+w249wlMeS2sYaKjyzmj8Z3V+MUT00?=
 =?us-ascii?Q?iDVvCWkoxGorsB9QAto56VXOjx/6uCc57gWWmPgLDUtSFN6+a681Pww4newJ?=
 =?us-ascii?Q?f+sFi3dR/gKkHJrEaVrR0a7tsHp6PpX20t1W/hpE2pIB7QRLPRr14xHQPKx3?=
 =?us-ascii?Q?ozxM7IESYpQ3BiHMm8iZMGqCVLZqgd5bVwKTgN2TMKBj0xWkRj4+GVX4PwX+?=
 =?us-ascii?Q?XugoGRJHnJ/oP6RK52NMF7Dg37FjDQMzqAq2k4uEW/qMFv/y4QrQ9zNJVekY?=
 =?us-ascii?Q?oJEWjlXkEgXHY/gFPJOOCCQhLIg0YLn6f5bspENJopW+Jz67i0ZSwiMchmZV?=
 =?us-ascii?Q?IGOr14MhtuTml+EYhDvHYgUUmMl3J7kIp6Qq4xKefi1TEb9htowNGwDVMscC?=
 =?us-ascii?Q?hTyS6r2gYJ7E4NEA/PWowKnOybgkDojMy6/f/o3u+ou5d/2fSaSIz1tyqHfo?=
 =?us-ascii?Q?EN9HxCWtiyz1BF1RgKkj9r0g5E1nzC7mMc3nfvaFtR7NcZC7kIkrpY0aEwZz?=
 =?us-ascii?Q?pJ90rd3DPqDfm9TqdZbE4AfL/Lg+hB+5E6BS5gYiMnW2I6m0M3Ax6eaJt/43?=
 =?us-ascii?Q?SHSUcIs2+/h5txJWrAur8m0Sc/Z8EgAfcDntg2lfpjv7Qqbx8GVA7nvw6G/8?=
 =?us-ascii?Q?tx76919RbmtTh+OSZKZDFHqTbQiMe8oSObYzO097enFmimxNj5Qph29t/Qfc?=
 =?us-ascii?Q?Y1E87mOP/Q+lQBqtW0b30V8EIAouAk+X1dDVcXza8c9AnJ2Ebu/C/U5mVOMN?=
 =?us-ascii?Q?gQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?tvU/MuygR6xJmmOKrNWuHw4HaeUnvU46vo6iQ1URTC1Rj9MxXS0kzSp9oXAa?=
 =?us-ascii?Q?HNyQ/hT4XV7SvAhyezyjNFgrw1+f4x20LWOBttjXKgXQ4Tn/c9JlpEVaWEzX?=
 =?us-ascii?Q?G2UIP9cOIaY0w4uSS3dccszTBR25O3KQKO1p3FWgeUOtCxf630wRpZSQnUnK?=
 =?us-ascii?Q?Ij7/KkQ+Pvm6gc/huTNq7xde8c8vSICNI4cCRGGBelWt5tIvzfAE9AoLwDUF?=
 =?us-ascii?Q?xVnkQGQXPkGQdAhxMprs2stiHS0BgS28fT37BjOPB6K4E56oFWYHMLbiQGWn?=
 =?us-ascii?Q?0b4kN9CXwECUS0o5zQTqZnfYXrTrKalYFyezpFiTDaz3Dldy7YG1JI7RVgBw?=
 =?us-ascii?Q?5X3Je4uydP3iw+WGLBxVnRud1HEWAOtihWsX4NEgu7UbbV51c/0O/CMJcQis?=
 =?us-ascii?Q?8ZCNCkWNe4NgHSg3ErmeN+zHhZ9T8i04U7sLU4+OBB7I4kRDdpLQxfs8qFFC?=
 =?us-ascii?Q?saSTDlP3QNcEz2OdOC2TltSPW4+PGYapz66FHqxwN4Ows0p0Po14f49RYT40?=
 =?us-ascii?Q?y+GrpUlVaJ6fsz9vNLR5Ch5N2o2fTaREW+PR+ds0dKtwU625WmtTzwBvdDRO?=
 =?us-ascii?Q?Fe29ROVBLPNrLu2QccjHqN0tt668t1aEtYALjCnmIKutQj2+XtC1w49wxv1l?=
 =?us-ascii?Q?wA80BpFRVEQdq0MbUeI2ElKGW8m9N8eZAy+tvbT6mNkdWwGZf0f9EJpSO9jE?=
 =?us-ascii?Q?T/zr6Yvq6zk3+x4rQ8usiFZ/igEeqVACoak4hOAzetsvU/GnyFUT6TouvXC4?=
 =?us-ascii?Q?PeQc5WdmAB/dYms6O/Uioh0CgGLk0j64KiZmwPcexUfLIL5PDMPSMOGyJ67g?=
 =?us-ascii?Q?Rxz8ShrWDZmbZaJ7tYdptOCiQJlSP8l6Dx6cpWXJz6OZHfBRopqoCRAUPPRM?=
 =?us-ascii?Q?vS8uXlPfCCMwEvOq7Kk5BGyaN7OTuQWKX2f+nqq6n9LopGwrlDiJMPFmXU9U?=
 =?us-ascii?Q?YRwePrwzL2sGC8I69fIXZ+8wBWf8QXvSwh1b4rbmr8k=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edb7cb53-3212-483b-b3ec-08dafef66efb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5117.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2023 17:06:00.7182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9dUMvuj/ypICxdDliAPL+YEwgD0PWkwBOT++nF7AQQ4wz8NKVXv4xhft90E41J3eK2/2rZUmB19M7pTIBNrfrX40YeE1GHjtVwV16nUF6gY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4384
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_11,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301250152
X-Proofpoint-ORIG-GUID: SVNEP9c7uXmuU6nQBfSepqD9lZtyfC34
X-Proofpoint-GUID: SVNEP9c7uXmuU6nQBfSepqD9lZtyfC34
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Every caller of restore_reserve_on_error() is now passing in &folio->page,
change the function to take in a folio directly and clean up the call
sites.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 fs/hugetlbfs/inode.c    |  2 +-
 include/linux/hugetlb.h |  2 +-
 mm/hugetlb.c            | 21 ++++++++++-----------
 3 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index ac16ada48f75..e2b8a00696bd 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -873,7 +873,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 		__folio_mark_uptodate(folio);
 		error = hugetlb_add_to_page_cache(&folio->page, mapping, index);
 		if (unlikely(error)) {
-			restore_reserve_on_error(h, &pseudo_vma, addr, &folio->page);
+			restore_reserve_on_error(h, &pseudo_vma, addr, folio);
 			folio_put(folio);
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 			goto out;
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index f6849e67ffef..d46f9db09a2c 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -725,7 +725,7 @@ struct folio *alloc_hugetlb_folio_vma(struct hstate *h, struct vm_area_struct *v
 int hugetlb_add_to_page_cache(struct page *page, struct address_space *mapping,
 			pgoff_t idx);
 void restore_reserve_on_error(struct hstate *h, struct vm_area_struct *vma,
-				unsigned long address, struct page *page);
+				unsigned long address, struct folio *folio);
 
 /* arch callback */
 int __init __alloc_bootmem_huge_page(struct hstate *h, int nid);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index e104dba1e5ea..aad028706fbc 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2802,9 +2802,9 @@ static long vma_del_reservation(struct hstate *h,
  * and the hugetlb mutex should remain held when calling this routine.
  *
  * It handles two specific cases:
- * 1) A reservation was in place and the page consumed the reservation.
- *    HPageRestoreReserve is set in the page.
- * 2) No reservation was in place for the page, so HPageRestoreReserve is
+ * 1) A reservation was in place and the folio consumed the reservation.
+ *    hugetlb_restore_reserve is set in the folio.
+ * 2) No reservation was in place for the page, so hugetlb_restore_reserve is
  *    not set.  However, alloc_hugetlb_folio always updates the reserve map.
  *
  * In case 1, free_huge_page later in the error path will increment the
@@ -2817,9 +2817,8 @@ static long vma_del_reservation(struct hstate *h,
  * In case 2, simply undo reserve map modifications done by alloc_hugetlb_folio.
  */
 void restore_reserve_on_error(struct hstate *h, struct vm_area_struct *vma,
-			unsigned long address, struct page *page)
+			unsigned long address, struct folio *folio)
 {
-	struct folio *folio = page_folio(page);
 	long rc = vma_needs_reservation(h, vma, address);
 
 	if (folio_test_hugetlb_restore_reserve(folio)) {
@@ -5102,7 +5101,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 				entry = huge_ptep_get(src_pte);
 				if (!pte_same(src_pte_old, entry)) {
 					restore_reserve_on_error(h, dst_vma, addr,
-								&new_folio->page);
+								new_folio);
 					folio_put(new_folio);
 					/* huge_ptep of dst_pte won't change as in child */
 					goto again;
@@ -5634,7 +5633,7 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * unshare)
 	 */
 	if (new_folio != page_folio(old_page))
-		restore_reserve_on_error(h, vma, haddr, &new_folio->page);
+		restore_reserve_on_error(h, vma, haddr, new_folio);
 	folio_put(new_folio);
 out_release_old:
 	put_page(old_page);
@@ -5846,7 +5845,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 				 * to the page cache. So it's safe to call
 				 * restore_reserve_on_error() here.
 				 */
-				restore_reserve_on_error(h, vma, haddr, &folio->page);
+				restore_reserve_on_error(h, vma, haddr, folio);
 				folio_put(folio);
 				goto out;
 			}
@@ -5947,7 +5946,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	spin_unlock(ptl);
 backout_unlocked:
 	if (new_folio && !new_pagecache_folio)
-		restore_reserve_on_error(h, vma, haddr, &folio->page);
+		restore_reserve_on_error(h, vma, haddr, folio);
 
 	folio_unlock(folio);
 	folio_put(folio);
@@ -6210,7 +6209,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 			/* Free the allocated folio which may have
 			 * consumed a reservation.
 			 */
-			restore_reserve_on_error(h, dst_vma, dst_addr, &folio->page);
+			restore_reserve_on_error(h, dst_vma, dst_addr, folio);
 			folio_put(folio);
 
 			/* Allocate a temporary folio to hold the copied
@@ -6339,7 +6338,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 		folio_unlock(folio);
 out_release_nounlock:
 	if (!folio_in_pagecache)
-		restore_reserve_on_error(h, dst_vma, dst_addr, &folio->page);
+		restore_reserve_on_error(h, dst_vma, dst_addr, folio);
 	folio_put(folio);
 	goto out;
 }
-- 
2.39.1

