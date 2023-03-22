Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A0D6C402B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 03:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjCVCJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 22:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjCVCJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 22:09:21 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7903F474F7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 19:09:20 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32M0wrvI017194;
        Wed, 22 Mar 2023 02:09:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=qC66Pova44mF24PzPzu4vjkbFtE9TPZttY9994EUZcM=;
 b=E+vKBK881lv10xJebGKkBDKA2m1tWRmMQnQUgYUNPXqZexwIN2xPximRoO7zoOo30cST
 vNfmJgPRJaeImsIQ+26ttDSklp0VBFfTKF8c3ffduq4N2LXm48rQZM+MnjLHMXYipw2z
 3zBx1j8hM+pgU94Q17vvdFJU18tO2lXGotXUXHiIy+frG5ToM5O+UzBtfOvrjWgxPUtZ
 lvVUAOR+kNQ/pVP3YPoAd9TfOxxLi/t2ejrHXq+JpGnhwsZYHydoegytKsnXrwmwnERZ
 CAy1DpNfnEuf15ZtFRSWy52i6e9SimDrwHK+eowccjXFfTvwscHDDseG5A8TtOscNWTy 3w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd3qdqrk4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Mar 2023 02:09:04 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32M1VCBb029648;
        Wed, 22 Mar 2023 02:09:03 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pfm1392s2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Mar 2023 02:09:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EqOB55I/Ton+mB8G9pT0tpRjj0UwhiuXYcpriMLPzfWJoSjnk7WE6ocTcBUKMR3C1EZ1AmFFTUa3sVEsNNQrSk87GBa+7mglhxGtVt/hRy+Izl44vLA0qQByBhZCWze1Huk7oxEcG0VlZG2w7dJ8v9lSK0PSWdNZstNE2Y0BfYM59L1rrPR+CHziN8Ui2adcdoE7g87ZullG97bMP8nQZmdCBI5o8ooaRegyuqyasddPwjqINV6hppgWmKh7GDrLcXihNaRvFuCeAXSWg240dN0SQ4YeUOleqxD+U8+T3cfXl2TcJ67AE6OAXm578ihOgnhtBYnxJvWXAAIj8ivCZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qC66Pova44mF24PzPzu4vjkbFtE9TPZttY9994EUZcM=;
 b=O69TkEdgYUeA2Yr44j0GY7OS7pwRD5EYn3VWhoJkTFsCte46woqgMkwAXgOoJ53KsmOqB9+85GgWcZcXvYY6myaKSTNRMtiYATSKXqZZd5KGrmU/zPeGe2XiWi6SiALzpY/VlrZQnlWYrbCU2n/plf9zr/75PlIjZzr6Bid3SE02m7rfi5W+zWJdgAUc87nfXeL2X/uOHDqW5xXrvSlBlE4wcumn7dhnadKRSo3rsYbnNXdt7jgYPNNauyrljn3Ztg6WbqlSzkkBbzTyGclooTLT6li2zj6mBx3a7C1iBdxVczeO8MwELKluJhTh2uC2zlMBrjfk05/vEa+fzOZEDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qC66Pova44mF24PzPzu4vjkbFtE9TPZttY9994EUZcM=;
 b=A0yQgod5igkPfI3KJ79grlCacccpaNZM5EOul6hmjZa2F1du8o8uhYWuDSu5tMJOJK4FmxGJVAX+7wwRLQNSkXNNaKqkhYYvCwf5DFtoLgAld3cSdpFoSRr6ZIjsJMAlzZ6X47HJHVujQv/pbJ4D6cPbqqQ6jz24CKsvFnTFYoA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB4140.namprd10.prod.outlook.com (2603:10b6:5:21b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 02:09:01 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::93c9:c99e:5ab:4319]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::93c9:c99e:5ab:4319%7]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 02:09:01 +0000
Date:   Tue, 21 Mar 2023 22:08:58 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        maple-tree@lists.infradead.org, Vernon Yang <vernon2gm@gmail.com>
Subject: Re: [PATCH v2 4/4] mm/mmap/vma_merge: init cleanup, be explicit
 about the non-mergeable case
Message-ID: <20230322020858.msvpvit63sb437ze@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, maple-tree@lists.infradead.org,
        Vernon Yang <vernon2gm@gmail.com>
References: <cover.1679431180.git.lstoakes@gmail.com>
 <f5e27d1bb9259b7ef7a45099a838e47fbaaad3ab.1679431180.git.lstoakes@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5e27d1bb9259b7ef7a45099a838e47fbaaad3ab.1679431180.git.lstoakes@gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0334.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::16) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DM6PR10MB4140:EE_
X-MS-Office365-Filtering-Correlation-Id: dc2f3089-7913-4fd0-9943-08db2a7a6715
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 14BIrCjVeBpLb6xjo8vRkoociUm/2LwDGKmfgMK8aJIRmrrC7VaT2JBUGHw3DyWHymIeY4NweKZQm4/QHp1N80QQmTaQYP6bnHFkOJxFtfHwzpFyCfFEyS2x7FEOrRxPQPmprsCuyfPOlb2srw8O7G59KwokZUXsUlYTWHD6iUS5AEakoxsq+bQaZhuwqNv8DOxC+5vhTWu+6DoomKFvuSpO3XJNflOygvvL6KjzoPPi0BZy7BPKt0H0Pkzoe2XO+3yo1AmugJsZsUWJk7h2SRZTNI9uZQk4e/cvXZLk3zWgUu0vYIqWn56lRU4cAhH+0Ecqk737AU1cW8H0RV5fN0p49CabqjAlXNUP5HxhvONXXRMAjkm64sgE4mElkQv5E5BctSGkK7iNcuuzexCad0nl14tPTIl/EvC3q3m5eIvWZXnHXS2E4Bq+IRIdBIdrD3k8hTTiyki5HrdpWBpnAeTcN75MP/W1gpZFDRvT5NQfGvfB4lifyRzYyGqgM423M5fArj6royynbvCwbWjrlPDPxfedAjv6s06KLs75VlYn59WS3MSIYdRuAckrG40HNBEufA8IDnD6RslYjEWkaSJXzjkZxet37GO2i4MY3Uya4L9fe+y5MF96qWs41ao1U74ngBoOsoOkm1VAOJgr+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(39860400002)(346002)(376002)(396003)(136003)(366004)(451199018)(6506007)(9686003)(6486002)(4326008)(186003)(6666004)(478600001)(83380400001)(316002)(54906003)(6916009)(66556008)(66476007)(66946007)(8676002)(1076003)(6512007)(26005)(8936002)(5660300002)(41300700001)(38100700002)(2906002)(86362001)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I0FnwhC/didDvVXviHixC/e8hPsBeDLH1LtdaGXxazWQjp4Ol0G/GpeK2jSc?=
 =?us-ascii?Q?7rpV9aPbIMtqX74AxDuMTnyDdZ7W5AsttY9vn6xjLQlI6ZFIuTwwKVVoBnQ4?=
 =?us-ascii?Q?cBlj5S23JUH1rU0JyNuIGTOmW/SW5p0RJizI3eisuPCpyjQzIoGWDTuff+Yr?=
 =?us-ascii?Q?IsICorirtvmHXCAPd0ByjKatlbMW8T2l82nRluVa/tZW+V6l4VaN9hj3lUl0?=
 =?us-ascii?Q?1S1uM/1dR9+skxuXoSSkw8FoHw9FLpPcNGKU1ZOJD9ahiXSd0EK4uAvYlufH?=
 =?us-ascii?Q?nDqaHqQZZ1eMECIPNTG5/NbMau1eAV3IZ4T9yQCmZpp0m36CoE13fXoM3GZ9?=
 =?us-ascii?Q?NPqw4hSX8ec5iI4S/++8H0BtL2TuFPWK6vDMpVWt6LeH3e5eHgt/f47Fn9ms?=
 =?us-ascii?Q?Xth7SSFUi3Dn+NjmqqeXi7gn/xarD7QnBl3CeqYtESAm56dB6XeQJUbp4Mv3?=
 =?us-ascii?Q?+/kOBPaNptY0WQU5wov9icpnWfQs/oP3R1YQIF3qWSdt/K3/HW066BnWhyQZ?=
 =?us-ascii?Q?UyPSGZorW2mVIugG/EwrQAxvpZBrwPUw2IuvBV4Yc8HtNrymqVRW9q2CfdVa?=
 =?us-ascii?Q?I1JKjVf9WEPVzL+vR0HDcXXSYpUFOraxVi3Hiue4uO+bQwMqQino9vntWIzt?=
 =?us-ascii?Q?7P04YNoY4+fJp9lSt9Gbyj42lPTjNO6Yg9uDv9NhVAhUou7jQGo2UFPboVa/?=
 =?us-ascii?Q?SVYE879Yk/M9JNm0jwhpNWp2XussmaBqiESGEDFmx5w5QZgq2EsEenXN5m6p?=
 =?us-ascii?Q?vUQlR8Wjo7YpKJOdvuHSjbn/6tmLTCG0I1EL8e+4EjGH6EAUSHxfANQCX2Os?=
 =?us-ascii?Q?QJ4waYyZRKV3/+h9r07w2pAldjEnqHxu+sJN/oim0bYQIRzcwQuNPWSXyAVd?=
 =?us-ascii?Q?hxcofxM2IK/AvE/Jt7Orl1OgusUqwsKj2kZDGDbBpbrzEzny/28+982sdeIx?=
 =?us-ascii?Q?KVmCHKEr/5QJLQ+P3HSJ7lUKMQEiQYuZA1xTpoFebdvzIvLl7POsjkx9IufM?=
 =?us-ascii?Q?7wgSuMSPtiXCTEwnTbSeakqklPiJnMIvOACK0zL3rPmYKYUjjpRetSyazPmf?=
 =?us-ascii?Q?cQPQmo7VBFWnxUP98PyblkkKZiNOdIF8hriITjwHtVQZQ1Qd25nsZuIHXi4F?=
 =?us-ascii?Q?mZAcoGsJjeA6KUeH3HfBB/xcWpQsXH1TvhIYRT6r9jJB35ethsrJb0RaQ4//?=
 =?us-ascii?Q?FkWYCZqTW2kjrVzR/ECfZIma+Ps6fGK924z1/J2O6ReMx9vRoVdxWOJ8xxj2?=
 =?us-ascii?Q?juLvvaNM52KwV7r8lznhtjdWVGEUu1OmIwvUYWXiwQFL4tpASRGoZKZvfeYU?=
 =?us-ascii?Q?f5WnxpROgjpE2rLUIxu95v1YvhKXzRFjBPEEKQUm5RbPl/BHZZCcvZ4F95nL?=
 =?us-ascii?Q?3TmFRcGGaBeDFdKxn1mMNIvD5Lj99WJkZjeR+l00jHDttIe+6tgrXhC+d3Mz?=
 =?us-ascii?Q?usUtG/8duPN1q482/RBxn4PHmymNOv8EYhMe6rGCyccxUoGpaYnDsPsz2feM?=
 =?us-ascii?Q?bkQbCr/BOHdJqlC/gU0Ibdr3zX88kqrguuv2/HIwYfZOeOwBPjDs3bfPH2kV?=
 =?us-ascii?Q?5NmO+VP9p+9edNQvMiJfLn4qfkZ5MEQY84b8iqxlpIz2iL0Lz251Jf0MwLMA?=
 =?us-ascii?Q?Pw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?g8/iCk9RV/l4AC01WyGCH1CuKSuTtl1YuAbMr4eD2+qiMy0anAscDPNdjjyG?=
 =?us-ascii?Q?1hTkpYonlg3I0DyifPoNo6r/ze/LECJ3zK/qcWzUYYGiizu4H3Xf63O4h+ku?=
 =?us-ascii?Q?uukacciftNsImTcxb3VYyB4ux4QxCBCbz3Vb/y4mX8LYhygzWsNgfvplRMvD?=
 =?us-ascii?Q?lSeEbtijOC9vIHTIbN1nOsPlpfedrjyf7IZ3xMd+VJNvIao/dfruhpGG6Qib?=
 =?us-ascii?Q?8XwdOE+UFLBMLPV/L9dLiR88UftWBV4opTPYnhHQmSacBcCO86dMJFBQ407x?=
 =?us-ascii?Q?Fub7aCVNhPAje7In56++7/hh9pICD5p6VqDM/3eGdpvtF4w1bs39KA8y2wmV?=
 =?us-ascii?Q?kq2R6fRR3CCj9cnMXVnT1ywy2dGc2DUDvp4AmP5n781sLmWaxSPVqwYOXrvA?=
 =?us-ascii?Q?XRCz/fYab9I+phVL3HSR5mvs1iXilO4bN2Kb5gVBsCGJHRJiT6yeFC3jxdyc?=
 =?us-ascii?Q?rhksKKEAX+w+I61o3VDUEeiV2qL74ueqPJxyausNEJAnrRr5vo8UtkynxzbL?=
 =?us-ascii?Q?L2Qds63dcb52wvf1pBbxwEppKQf3KGMeHqfUK3kjUj+L6epF4+h6Qa1jRiNZ?=
 =?us-ascii?Q?EVut63EN+f1UNQRK1Ql/ccYZwH5mQi+vXiHwh57mgPlLPxCof49pPgp5Bu21?=
 =?us-ascii?Q?ef6XCU6S/Ra5j43lnc5ms+a0/yc8O/SsNLxQ2l35ggrw8g4jKV6m0ze1W8B5?=
 =?us-ascii?Q?4gzpafTgeOl0XpVkDGO0qYCDb+fETBLU/2JmVpWBLOTnHxljo/Z1OmlYGEoF?=
 =?us-ascii?Q?j1S9A6DOmMxznDZPdabXQthA1NISC9wJ5V9qo4DkmAG360hRxoeXWoLcrVr6?=
 =?us-ascii?Q?NtlId8S8n4uj8Lev7jdHRyVEJE7ok+N8RpGBma0V5UyRmz9UmNipgy7GU6m7?=
 =?us-ascii?Q?aZG/hDyOJodQEixZYTWP0Dfk1waZpK5i9r2JLyFSHMyOl5jO+t1Wj66U0P6q?=
 =?us-ascii?Q?PM3wEDUqmrVMtPZrzfiaA8PuNNu31BStkXTL8tYm4XqkxVIfbFyed3AKtTwk?=
 =?us-ascii?Q?blq3?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc2f3089-7913-4fd0-9943-08db2a7a6715
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 02:09:00.7996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7vwbd1+vx07fQF3SGi1zIhr6CmJsYkKF1EX41/idRkAShXY+va8Fz6S1N/abJdBsWHcjk9cABhN4oUmvvxlFxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4140
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_11,2023-03-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=353 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303220013
X-Proofpoint-GUID: B4OXLvdT1RZ74lvFKnn9JXPHVXOpcQZm
X-Proofpoint-ORIG-GUID: B4OXLvdT1RZ74lvFKnn9JXPHVXOpcQZm
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Lorenzo Stoakes <lstoakes@gmail.com> [230321 16:46]:
> Reorder the initial variables sensibly and set vma_start and vm_pgoff there
								^vma_pgoff
	Indicating it is used for the vm_area_struct *vma

> rather than later so all initial values are set at the same time meaning we
> don't have to set these later.

I did these later to reduce the number of times we were checking prev.
With this patch, we check prev 3 times, but before we were checking it
once.  The compiler might do something clever here to reduce the
checking?

I'm also not sure adding the conditional operator in the init helps your
goal of cleaning it up.

> 
> Rather than setting err = -1 and only resetting if we hit merge cases,
> explicitly check the non-mergeable case to make it abundantly clear that we
> only proceed with the rest if something is mergeable, default err to 0 and
> only update if an error might occur.
> 
> Move the merge_prev, merge_next cases closer to the logic determining curr,
> next.
> 
> This has no functional impact.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---
>  mm/mmap.c | 55 ++++++++++++++++++++++++++-----------------------------
>  1 file changed, 26 insertions(+), 29 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 7aec49c3bc74..d60cb0b7ae15 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -909,18 +909,18 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  			struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
>  			struct anon_vma_name *anon_name)
>  {
> -	pgoff_t pglen = (end - addr) >> PAGE_SHIFT;
> -	pgoff_t vma_pgoff;
>  	struct vm_area_struct *curr, *next, *res;
>  	struct vm_area_struct *vma, *adjust, *remove, *remove2;
> -	int err = -1;
> +	struct vma_prepare vp;
> +	int err = 0;
>  	bool merge_prev = false;
>  	bool merge_next = false;
>  	bool vma_expanded = false;
> -	struct vma_prepare vp;
> +	unsigned long vma_start = prev ? prev->vm_start : addr;
>  	unsigned long vma_end = end;
> +	pgoff_t vma_pgoff = prev ? prev->vm_pgoff : 0;
> +	pgoff_t pglen = (end - addr) >> PAGE_SHIFT;
>  	long adj_start = 0;
> -	unsigned long vma_start = addr;
>  
>  	validate_mm(mm);
>  	/*
> @@ -940,6 +940,23 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  		/* Is there a VMA next to a hole (case 1 - 3) or prev (4)? */
>  		next = vma_lookup(mm, end);
>  
> +	/* Can we merge the predecessor? */
> +	if (prev && addr == prev->vm_end && mpol_equal(vma_policy(prev), policy)
> +	    && can_vma_merge_after(prev, vm_flags, anon_vma, file,
> +				   pgoff, vm_userfaultfd_ctx, anon_name)) {
> +		merge_prev = true;
> +		vma_prev(vmi);
> +	}
> +
> +	/* Can we merge the successor? */
> +	merge_next = next && mpol_equal(policy, vma_policy(next)) &&
> +		can_vma_merge_before(next, vm_flags,
> +				     anon_vma, file, pgoff+pglen,
> +				     vm_userfaultfd_ctx, anon_name);
> +
> +	if (!merge_prev && !merge_next)
> +		return NULL; /* Not mergeable. */
> +
>  	/*
>  	 * By default, we return prev. Cases 3, 4, 8 will instead return next
>  	 * and cases 3, 8 will also update vma to point at next.
> @@ -951,26 +968,6 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  	VM_WARN_ON(curr && (addr != curr->vm_start || end > curr->vm_end));
>  	VM_WARN_ON(addr >= end);
>  
> -	if (prev) {
> -		vma_start = prev->vm_start;
> -		vma_pgoff = prev->vm_pgoff;
> -		/* Can we merge the predecessor? */
> -		if (prev->vm_end == addr && mpol_equal(vma_policy(prev), policy)
> -		    && can_vma_merge_after(prev, vm_flags, anon_vma, file,
> -				   pgoff, vm_userfaultfd_ctx, anon_name)) {
> -			merge_prev = true;
> -			vma_prev(vmi);
> -		}
> -	}
> -
> -	/* Can we merge the successor? */
> -	if (next && mpol_equal(policy, vma_policy(next)) &&
> -	    can_vma_merge_before(next, vm_flags,
> -				 anon_vma, file, pgoff+pglen,
> -				 vm_userfaultfd_ctx, anon_name)) {
> -		merge_next = true;
> -	}
> -
>  	remove = remove2 = adjust = NULL;
>  	/* Can we merge both the predecessor and the successor? */
>  	if (merge_prev && merge_next &&
> @@ -985,7 +982,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  				err = dup_anon_vma(prev, curr);
>  		}
>  	} else if (merge_prev) {
> -		err = 0;				/* case 2 */
> +							/* case 2 */
>  		if (curr) {
>  			err = dup_anon_vma(prev, curr);
>  			if (end == curr->vm_end) {	/* case 7 */
> @@ -995,7 +992,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  				adj_start = (end - curr->vm_start);
>  			}
>  		}
> -	} else if (merge_next) {
> +	} else { /* merge_next */
>  		res = next;
>  		if (prev && addr < prev->vm_end) {	/* case 4 */
>  			vma_end = addr;
> @@ -1011,7 +1008,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  			vma_start = addr;
>  			vma_end = next->vm_end;
>  			vma_pgoff = next->vm_pgoff;
> -			err = 0;
> +

Was this blank line intentional?  I assume so, to give a gap for the
comment below?  It's probably worth having.

>  			if (curr) {			/* case 8 */
>  				vma_pgoff = curr->vm_pgoff;
>  				remove = curr;
> @@ -1020,7 +1017,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  		}
>  	}
>  
> -	/* Cannot merge or error in anon_vma clone */
> +	/* Error in anon_vma clone. */
>  	if (err)
>  		return NULL;
>  
> -- 
> 2.39.2
> 
> 
