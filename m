Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936CF664E07
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 22:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjAJV3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 16:29:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234551AbjAJV32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 16:29:28 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCDCB61338
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 13:29:16 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30AL3ccn011294;
        Tue, 10 Jan 2023 21:28:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=ON8r4iAi/C54BL7LxCnv7ms9x+EBmJEmmOUIFctdR/Y=;
 b=mOdAsIBV+cT382pE6Oia/JAR/CyKuOIoItJHs1+lWj87QqQjBcvfBcj/o+PPadRdox0k
 GKrmbyTHZDOagxh4IZJKk1V0DKZErXWQB1Ptxpq2995dTmMGnW3oysxGoHPZsnST2bqH
 rVhb7/Jqv5mIdYADWVJsgP8kuZB8CtOvI5NBe85PPP/KmZ/GiA/ulr5nGy/tyLXGKu06
 dH3g7UQPZN/qG/XTA/YecMqVLNUc4KtOrsEimWrFJ3Ironco1r3F9Ko5deRwIjKvd+gO
 jMrwOrvMhK4Ym5oqLQHC8h9n89EkNeisoAURV1ihtQwxSRAwURI++FAPLBXrAzl0OqNz 8Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n1fe5830w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 21:28:54 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30AKY8kP022668;
        Tue, 10 Jan 2023 21:28:53 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n1f5x25br-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 21:28:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jGFv7gtGJxVlGP5fjxefIKdR16jZc62au8tQ/K0FmydO/DuymeTFIpIc8lX2dwTHr0K46lMQxuHXo6vRK7Ns/3idYGKY2DqUgSVIOEy14bXKqb6tfAcwfZGpTzx6oKqUVJJrpDtN9eJbQEln5I9vgxkyLYDQA9HYoWQpxDMBUZkRSS3rrEFWKXm9/Zw9U7EJJ/+r++fKW3k2YrlnLshbnZpcqwFIvP/C6lgcVoFMITeTZu36KDmNDzUTZjaV4/LJE4Lm7g4kbN+Z9JKNcCuVATERA9Ag3F7YFvrxUcgG6rBfpFx268ICB49r/xhOElD9e9svKbk8yJg9beo3sNnB8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ON8r4iAi/C54BL7LxCnv7ms9x+EBmJEmmOUIFctdR/Y=;
 b=YmhBIMFU7/nDvYkt158LloSqj8GC2rbUsEL4Kg97r5UkU2PUT8pzF6DgRo1I5Yw34LULJOQ74cWB5IZy1SXhdaE8GZoNyo4SbZ58YjN1E8z0+wwkJ0cVSR1v70uzXn2jdoVy1R3yrGCDY3yEQKuc8yZTByEgqPTOT32iYkIEQKOdrfegp25PEJBmyCwjMntnFB90rd3lHfcMwWofDIsuVa6QnfrY8HZXEEhznCZQKz2p3GmeRc1+YZrFshNFfVN36wVeiawz4KYd6qulRyvTYyz1pvFOkJ+1I+fTXQOscYJlR3SHlYNUOqcEt4HZBfxFs1qeiHsFSktnHQ4+U4y9Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ON8r4iAi/C54BL7LxCnv7ms9x+EBmJEmmOUIFctdR/Y=;
 b=PReBubmr2rq5V/Xo4W4IU/JIW2qKsSnxndx8v5oV/DJH27ePUrSpYanBy2e/MM4DOb+8jEB7K0ZY/KYolKH+OO5ubZ8SKmtPXj5hT7mmmZis6E5T7bY77dAN532Bie96rz0FzxWI1C4H4jQgYeaeWT2gwCwNeu/23/KhR88rApc=
Received: from DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17)
 by DS7PR10MB5133.namprd10.prod.outlook.com (2603:10b6:5:3a7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Tue, 10 Jan
 2023 21:28:43 +0000
Received: from DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9]) by DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9%2]) with mapi id 15.20.6002.011; Tue, 10 Jan 2023
 21:28:43 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, jhubbard@nvidia.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH mm-unstable v2 5/8] mm/hugetlb: increase use of folios in alloc_huge_page()
Date:   Tue, 10 Jan 2023 15:28:18 -0600
Message-Id: <20230110212821.984047-6-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110212821.984047-1-sidhartha.kumar@oracle.com>
References: <20230110212821.984047-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN6PR16CA0053.namprd16.prod.outlook.com
 (2603:10b6:805:ca::30) To DS7PR10MB5117.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5117:EE_|DS7PR10MB5133:EE_
X-MS-Office365-Filtering-Correlation-Id: e13fcf2a-5eb9-4d70-5447-08daf351a61b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UTILyRM7v1NDC4eyaE36NrJ0kqnkQjBiuW/ffcN0ovNVVNFCCnr2nWFFOTPJVA4qH3FVcHTkQXue+OqWWANRJZCyxafE0s3o8gFRce54NHAJ6kiHiv9UCk0u78yK3BdjHddlsR7873/AXSAiMONRox/s0y39+Xfp2B/UsXpCyIcBXUsPeL4nftP62i9MFPMlno1YDN44aPUJzubYXFCwcx1h2cM96Kk7enPjCWhTccwCQSilyrfNWBoiUQSeg3mCVcqTzPihKaDSEcxZ8EW8JMHcE/uWZHo9yHqhEgf9CSfjQUJx6yXoRSd0OKReKyN+RHTwoBVuzCZCaJpz+rAKw+ZZswlZNtY3T0XhlXHBuoLAjzovp08lTjtn6w1MA0qAZ8Sh+9kY4AITNckOvuI0+b6QV/5SpwTP5Iiw00Kdi6nkEGtMkDhg1oRLhhfCWniC02kJsvVlX/XPnXrLwdG5jIl/ahy/XgEeRjw8RWQUGXyVO5raPSt6VWzgtcyHFcRXJFACU8/P1LYzakvS10c9E6jfw2aJRp8VUnfRYOB8t0udaNEI7QWsOeJf/jGAw/6Vkbqs7ML9D7HpDi5xNUVh9F8dD/K24ducCJYG7MH2Cz9q/SshgF0EkC0nPHQzSC4BM7PIW9Y+zj6vNdA0NM2QVPf+ApYZa087xi8LrjTuZjX6D2OY/GK2mWWAXgVplSk6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5117.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(376002)(396003)(346002)(136003)(451199015)(38100700002)(316002)(36756003)(5660300002)(2906002)(41300700001)(44832011)(86362001)(8936002)(66556008)(66946007)(4326008)(8676002)(66476007)(83380400001)(6512007)(478600001)(6486002)(1076003)(6506007)(2616005)(107886003)(186003)(6666004)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uCHurwADmS/zdCWzGip5P+tGn7009sNnsPA1wpXmYIVwz8DMlv6ow0L81wbX?=
 =?us-ascii?Q?3Xi1crPDgWy3VjgDiIKmNTRS19WdFTjlWfAwPQn++KGSKzc/UwVmuem+Mqye?=
 =?us-ascii?Q?5F0LKG+wOl67XAaU595Zg0Gh32276qHMHsu8qKwQnv4PgpwHoyGq+E8zbnJu?=
 =?us-ascii?Q?cxT4IZCICaapQTT5x2OF+9Ar+6T2PxxDjlkSCascWkCiVCNu9Yh/oj9+Z5xp?=
 =?us-ascii?Q?DaouhkBqtTDLYPtNeV3DBuXhGo6Tyelqzsc5DralmSGIuMWt2cH1QsWI+TZX?=
 =?us-ascii?Q?yShDsBrPDCjTnnDaiXrgtijf+DJKAsea2n0ediquqnqJxOR4c8aTrkAU94jV?=
 =?us-ascii?Q?hziMwDn97A1QLginqmtXMVlrAFuvygfG8BkT/sFRym1/qZy13YH3htTJmyka?=
 =?us-ascii?Q?0wl8xUdo/8XpU6tTAPstq8ipa7GUAf9hhSR9a4y3wuGHYjxqhalvgCDOBb7w?=
 =?us-ascii?Q?43x1EcFHVrJgDy0sr+Zzy+fDd/ZxvpFgPAsYEowl9G+dQATfqhwtGxrjsnJz?=
 =?us-ascii?Q?Gylknv4eYbxZ9lcXOfnkDvpB59Y5PSLa67tGzkDE8/SHPiUesPzcWtW4nykE?=
 =?us-ascii?Q?gs3qThhg/QllQ4Jnr0MFRyfAVPJRIL6KctcbYudixQ5uoBPpuP7JTK6kNc1P?=
 =?us-ascii?Q?5MnzzYhcN9P/MzNR9P3rdOiovtdM6gjx3ZhCxUtYgktND4oYMCGFm6ikllcY?=
 =?us-ascii?Q?iGinS6eFPez0fA8WQUgVrWKS3MNeM6gmF61yO9+lLIr6EiyJ3faE1Y7q5Zn/?=
 =?us-ascii?Q?vicPvN4fGN9AdYZMe44s0xzNcW0KM7urMpmLUgShKBFjqDr3wEAMlzR9+l+h?=
 =?us-ascii?Q?lVLceFwQ1wBaKBpoWObHW89qfm3Jra9PNXjWxy6kSVb+4l7yiEqXhxH294cP?=
 =?us-ascii?Q?Hn7FTXoZRPOJG3fj/2vvRIm6t03ie+4ysLsBlqu1mz9uAaArfqxoaGcgAKum?=
 =?us-ascii?Q?KB67zt3eVV5JVsvhpBMJxnN10vUPMAJ18mgku96oXvB1M1v5LdcvsgPNctw8?=
 =?us-ascii?Q?97SdQoMw+Ee5KQLQxd9ErTSrxCj+4Z9U2MTvzjd2uBg5reKBC+ZYJOvlJ3bY?=
 =?us-ascii?Q?tawwZl5ie8br2QdwMJOuNdT+0mICaSKU4X82OiK0tY31t7+rzB1iR7boxzHg?=
 =?us-ascii?Q?OSG6Xin34ScM4pBDYeGYre/UZDh+c4G2q6+NxqgsS+P3vUJav5TNybCfgpE1?=
 =?us-ascii?Q?5FqQoDFbZAwT3srdRTvrBjhEJ8iQ/7QMpNkuEhPfimwhh+pH1ErcsYMhEHqA?=
 =?us-ascii?Q?q8y5N22LU6F/OEzTU8/+DbZqJPR5s5ZjnqmmAG+7cG7qSaOO54w9AugSTyIh?=
 =?us-ascii?Q?51Gz6AqJsnIHncYCbedM3W0EO9F8x0Nhp3dYY2h/Xli/20xDIQQHRn5PMefX?=
 =?us-ascii?Q?QmugYcfcgm0Nofeu2h8vKhODE3nzFrxiLKK15ASTGWHXFTNopZ3SeRlC5RA+?=
 =?us-ascii?Q?yJNaAnRfVCmXqN12Pfj9nsU5frFxD1q6XHFV3s3H8jA2KFw0PIauNWoIq4bu?=
 =?us-ascii?Q?SRj5Db+DEJYCEpHitz+56vaA4Z0PBbxqxcG9S5T2zP+alxOfjjoeQ6vW9hFu?=
 =?us-ascii?Q?0bMgaZX5NAefCRYlw+W3MOYd3NI/TFeeRcTLKKmjqt5ynqfshNT5LzUbMSlB?=
 =?us-ascii?Q?ydWJU2fOnhk+K8NMLZSJJYA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?qDD0T76kCWV2Ddg1lqkR2EUSCDR2m1mMztHiQlp9gCXGvP4hPx6WIG8hNkWe?=
 =?us-ascii?Q?QFGUoQ2xZJKbgdPbSuSTrROU9t5u92U78hl5mx0BmfudrjK2JFY5kWkJIoWM?=
 =?us-ascii?Q?zXH2/G6SMy1xGKzzDrNVmzTlF8j1iesUOUXrE/1DVjGBzKRXwpyK+qlyirXg?=
 =?us-ascii?Q?pNj2xzc1C/LQKrsRbFk7i12qFV42F5ZWYgKi0wicuAhXmXnV7s6p4MfC9f35?=
 =?us-ascii?Q?uhkx9utnnkhi/1b22iAiJGa/mDdwF4VZPsvVKmIO6wjMu9GMLKxT7xYGA1P6?=
 =?us-ascii?Q?YTmIZtqrzMmpubGlCGiSyXvRcBRUaghaIFDuQgiS7YI2q3CHG4qF3vFVwHtB?=
 =?us-ascii?Q?/0cJD9RoW4awCDrDyM1tXTxTCE1Ew3r53p7R841wI1R39oJrRHcnpYN1w0X4?=
 =?us-ascii?Q?Eyt3g4jfkw59Ni/Gl8pdUQJoKjRgvJ+vSs5Bki702R09Qb2KAecEZ3OoUwoO?=
 =?us-ascii?Q?FKq6F8Tq7b209VJ2Xe0DYQW2Dwr8U7kZ8yKXOAuzw9++ZqzRQkI0/HvCeYbp?=
 =?us-ascii?Q?dgh0yV/VztW9v1s+Xn/TmzIqawfmMVPKhkVRvKVWFRkO86Z7lCIf61E5pEEN?=
 =?us-ascii?Q?Tfwd0x3Heb5z/GhKMf6eiw594dgEjNWcXyI/Ukp4bGkt/g0qRUk54kdOJmXj?=
 =?us-ascii?Q?YB9Qbrh886TSNJO/7OD3dpFQbUDNqdUX0AFgQxJMuT6UlvynWrWpQhUNjvum?=
 =?us-ascii?Q?RGG0WyTJHsn+p1R9c+hK/O9eviwbnS+iwsYKsdudrVZCDYYjBSnUryz+ApVO?=
 =?us-ascii?Q?cZwkOHUBF7F3SrTmlhViueIZ7O94ItfNZvZteqQx9AvtRpyABnbCp+abmjJu?=
 =?us-ascii?Q?i2O1TJ6uVGiXswa+Cm0/kYdh338llTAGlSb04JIQPZodNaQgRXgC3sd99cut?=
 =?us-ascii?Q?4TYHx/SVxWARGeFbaA9eEMrFVsXeLbqA37hMibx4GVlV+V6O5Cqa3pAll88R?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e13fcf2a-5eb9-4d70-5447-08daf351a61b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5117.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 21:28:43.2774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JrMchX/CdYxNIYn0ONyzoN0RbbLX6ilnoBiRFi85YnuXOsIUmDiEI+dnKn/b83ujdBpc6v2/aovH931Bl2+lwCvtxke5W/H/1SN5MHHeNpE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5133
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_09,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301100142
X-Proofpoint-GUID: 8SP4qecE-oqOC2h013PD0HmLHcddQYM2
X-Proofpoint-ORIG-GUID: 8SP4qecE-oqOC2h013PD0HmLHcddQYM2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change hugetlb_cgroup_commit_charge{,_rsvd}(), dequeue_huge_page_vma()
and alloc_buddy_huge_page_with_mpol() to use folios so alloc_huge_page()
is cleaned by operating on folios until its return.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 include/linux/hugetlb_cgroup.h |  8 ++++----
 mm/hugetlb.c                   | 33 ++++++++++++++++-----------------
 mm/hugetlb_cgroup.c            |  8 ++------
 3 files changed, 22 insertions(+), 27 deletions(-)

diff --git a/include/linux/hugetlb_cgroup.h b/include/linux/hugetlb_cgroup.h
index f706626a8063..3d82d91f49ac 100644
--- a/include/linux/hugetlb_cgroup.h
+++ b/include/linux/hugetlb_cgroup.h
@@ -141,10 +141,10 @@ extern int hugetlb_cgroup_charge_cgroup_rsvd(int idx, unsigned long nr_pages,
 					     struct hugetlb_cgroup **ptr);
 extern void hugetlb_cgroup_commit_charge(int idx, unsigned long nr_pages,
 					 struct hugetlb_cgroup *h_cg,
-					 struct page *page);
+					 struct folio *folio);
 extern void hugetlb_cgroup_commit_charge_rsvd(int idx, unsigned long nr_pages,
 					      struct hugetlb_cgroup *h_cg,
-					      struct page *page);
+					      struct folio *folio);
 extern void hugetlb_cgroup_uncharge_folio(int idx, unsigned long nr_pages,
 					 struct folio *folio);
 extern void hugetlb_cgroup_uncharge_folio_rsvd(int idx, unsigned long nr_pages,
@@ -230,14 +230,14 @@ static inline int hugetlb_cgroup_charge_cgroup_rsvd(int idx,
 
 static inline void hugetlb_cgroup_commit_charge(int idx, unsigned long nr_pages,
 						struct hugetlb_cgroup *h_cg,
-						struct page *page)
+						struct folio *folio)
 {
 }
 
 static inline void
 hugetlb_cgroup_commit_charge_rsvd(int idx, unsigned long nr_pages,
 				  struct hugetlb_cgroup *h_cg,
-				  struct page *page)
+				  struct folio *folio)
 {
 }
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 62552172683a..f3e1d052b40c 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1206,7 +1206,7 @@ static unsigned long available_huge_pages(struct hstate *h)
 	return h->free_huge_pages - h->resv_huge_pages;
 }
 
-static struct page *dequeue_huge_page_vma(struct hstate *h,
+static struct folio *dequeue_hugetlb_folio_vma(struct hstate *h,
 				struct vm_area_struct *vma,
 				unsigned long address, int avoid_reserve,
 				long chg)
@@ -1250,7 +1250,7 @@ static struct page *dequeue_huge_page_vma(struct hstate *h,
 	}
 
 	mpol_cond_put(mpol);
-	return &folio->page;
+	return folio;
 
 err:
 	return NULL;
@@ -2302,7 +2302,7 @@ static struct page *alloc_migrate_huge_page(struct hstate *h, gfp_t gfp_mask,
  * Use the VMA's mpolicy to allocate a huge page from the buddy.
  */
 static
-struct page *alloc_buddy_huge_page_with_mpol(struct hstate *h,
+struct folio *alloc_buddy_hugetlb_folio_with_mpol(struct hstate *h,
 		struct vm_area_struct *vma, unsigned long addr)
 {
 	struct folio *folio = NULL;
@@ -2325,7 +2325,7 @@ struct page *alloc_buddy_huge_page_with_mpol(struct hstate *h,
 	if (!folio)
 		folio = alloc_surplus_hugetlb_folio(h, gfp_mask, nid, nodemask);
 	mpol_cond_put(mpol);
-	return &folio->page;
+	return folio;
 }
 
 /* page migration callback function */
@@ -2874,7 +2874,6 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 {
 	struct hugepage_subpool *spool = subpool_vma(vma);
 	struct hstate *h = hstate_vma(vma);
-	struct page *page;
 	struct folio *folio;
 	long map_chg, map_commit;
 	long gbl_chg;
@@ -2938,34 +2937,34 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 	 * from the global free pool (global change).  gbl_chg == 0 indicates
 	 * a reservation exists for the allocation.
 	 */
-	page = dequeue_huge_page_vma(h, vma, addr, avoid_reserve, gbl_chg);
-	if (!page) {
+	folio = dequeue_hugetlb_folio_vma(h, vma, addr, avoid_reserve, gbl_chg);
+	if (!folio) {
 		spin_unlock_irq(&hugetlb_lock);
-		page = alloc_buddy_huge_page_with_mpol(h, vma, addr);
-		if (!page)
+		folio = alloc_buddy_hugetlb_folio_with_mpol(h, vma, addr);
+		if (!folio)
 			goto out_uncharge_cgroup;
 		spin_lock_irq(&hugetlb_lock);
 		if (!avoid_reserve && vma_has_reserves(vma, gbl_chg)) {
-			SetHPageRestoreReserve(page);
+			folio_set_hugetlb_restore_reserve(folio);
 			h->resv_huge_pages--;
 		}
-		list_add(&page->lru, &h->hugepage_activelist);
-		set_page_refcounted(page);
+		list_add(&folio->lru, &h->hugepage_activelist);
+		folio_ref_unfreeze(folio, 1);
 		/* Fall through */
 	}
-	folio = page_folio(page);
-	hugetlb_cgroup_commit_charge(idx, pages_per_huge_page(h), h_cg, page);
+
+	hugetlb_cgroup_commit_charge(idx, pages_per_huge_page(h), h_cg, folio);
 	/* If allocation is not consuming a reservation, also store the
 	 * hugetlb_cgroup pointer on the page.
 	 */
 	if (deferred_reserve) {
 		hugetlb_cgroup_commit_charge_rsvd(idx, pages_per_huge_page(h),
-						  h_cg, page);
+						  h_cg, folio);
 	}
 
 	spin_unlock_irq(&hugetlb_lock);
 
-	hugetlb_set_page_subpool(page, spool);
+	hugetlb_set_folio_subpool(folio, spool);
 
 	map_commit = vma_commit_reservation(h, vma, addr);
 	if (unlikely(map_chg > map_commit)) {
@@ -2986,7 +2985,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 			hugetlb_cgroup_uncharge_folio_rsvd(hstate_index(h),
 					pages_per_huge_page(h), folio);
 	}
-	return page;
+	return &folio->page;
 
 out_uncharge_cgroup:
 	hugetlb_cgroup_uncharge_cgroup(idx, pages_per_huge_page(h), h_cg);
diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index d9e4425d81ac..dedd2edb076e 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -331,19 +331,15 @@ static void __hugetlb_cgroup_commit_charge(int idx, unsigned long nr_pages,
 
 void hugetlb_cgroup_commit_charge(int idx, unsigned long nr_pages,
 				  struct hugetlb_cgroup *h_cg,
-				  struct page *page)
+				  struct folio *folio)
 {
-	struct folio *folio = page_folio(page);
-
 	__hugetlb_cgroup_commit_charge(idx, nr_pages, h_cg, folio, false);
 }
 
 void hugetlb_cgroup_commit_charge_rsvd(int idx, unsigned long nr_pages,
 				       struct hugetlb_cgroup *h_cg,
-				       struct page *page)
+				       struct folio *folio)
 {
-	struct folio *folio = page_folio(page);
-
 	__hugetlb_cgroup_commit_charge(idx, nr_pages, h_cg, folio, true);
 }
 
-- 
2.39.0

