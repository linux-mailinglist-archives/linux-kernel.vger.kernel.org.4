Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489C469E9B4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 22:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjBUVrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 16:47:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjBUVrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 16:47:01 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0E4311E3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 13:47:00 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31LKNfRs007208;
        Tue, 21 Feb 2023 21:46:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=LGIy1rurewpl2sPN26PdN8BG+C4foXzflXZ4W4mnjeo=;
 b=0/GYVOhhUc/s6o+m3svxNRXBC8zLrFaiCBIlykEF6yNYkoAP5srXsjwI7x0oS2Qgb/Zg
 aB1OuM7Mf5RAzG65NMAiOIuCQi1Yy0rVcN/RwwBunRuR7TfGDr5rdxQ40lT7UfJ2fc4x
 562EKb9mGhlfFTZAHULl24YEwRGwdbNC+rKM8R/qZqSaFJ4VkPadtUN2A6M/4eTJeIMg
 dr9I/trgyCl46n8YgNORGq8VZejhXzWIO2z/R6+4bcC9qTrrfHTD/oq149F4vMk1dJNr
 VTckleHGFjO1uDMFY15w3Q0d9qLmvC16v+3gaAskb3loYl2EEGYGxBa3v9LrWvE87+NX Xg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntp9tpfeb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Feb 2023 21:46:13 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31LKRQjq031257;
        Tue, 21 Feb 2023 21:46:12 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn45qsfb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Feb 2023 21:46:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HTyNisMaeul2da1gFcOFU0OfAOqfbUkaNf/asI6NVDkB8lRSTsPpr0ErjgvjCxrWKMjA3fMKs7TeQWkLvTtuTAqkekmKjL9hi6PCg9VyjAnMpnsYONQGCcVWgw+ft9a3h0kPfYadEibOiGaFgQYRWhFu9sTYoWg3RxTp2bnHrNqUG89oAQ1Uuvty4WQ/zXRF97xvPJssG3km/TWDDS3BWdHjZQtQOayMP0fEVzPzlGrUX/hvpXuS0DDVnY08TkmMKL1JyJrSLSBR6YqYfm2UFpZ3h+n0MtF4ox1mRLMquJHXVi7lvf5psctVqsHnuSPU6cM3HsmcaWd/lU7Hd8fo8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LGIy1rurewpl2sPN26PdN8BG+C4foXzflXZ4W4mnjeo=;
 b=mMkMD4+Rvb4miaPTkBT5uW2/1ycDpNiMNCjF6j27/RlCiz+Sj52hjlHabqoDc1tbUDr9BvhtdPuqY68ril7kitzFHTFf2vJVK1Ve64S+h1yFZSW8uC2dCeSFmv9uHdP/n6a1fmhY3X7ziSfvRA8W0QSJz5cvMRnDIEtlOYf3w7ZxH8DpK45C4Ru0KkrfakTzcnusS64jao0x1Bzo8haBPSWRBXfkc9TB7vrmpOh2nIK46rZuq8+/w8YIDNuMC05ZhfeVdw+4geLN6Wt4EibuUOkvfNmHTOOa/vOCc12jGuXRfrEYRVHX/XT75U1xkQoCi/FdlnLsMOvEbXCgIpU0kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LGIy1rurewpl2sPN26PdN8BG+C4foXzflXZ4W4mnjeo=;
 b=vSd9n//zrqldittyPUFx0COPXKxe8I1xS9cGEbhkYkdHZi5GXazstcv9DcEW5TDj9fHlc6Zvt7dPhv74A05unRzmPhAD8Vq7emGxAlnAtPCnqIPE1iA8pVtyJxSCprFFopX+/ujtXNH8JdqykzWrXiPmYB/9CUBL/Yn/YN5MVWU=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4797.namprd10.prod.outlook.com (2603:10b6:a03:2d8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.17; Tue, 21 Feb
 2023 21:46:09 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3db5:6e11:9aca:708a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3db5:6e11:9aca:708a%8]) with mapi id 15.20.6134.017; Tue, 21 Feb 2023
 21:46:09 +0000
Date:   Tue, 21 Feb 2023 13:46:06 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     James Houghton <jthoughton@google.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Zach O'Keefe <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Frank van der Linden <fvdl@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/46] hugetlb: introduce HugeTLB high-granularity
 mapping
Message-ID: <Y/U7ngTyPlg2XCRj@monkey>
References: <20230218002819.1486479-1-jthoughton@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230218002819.1486479-1-jthoughton@google.com>
X-ClientProxiedBy: MW4PR03CA0121.namprd03.prod.outlook.com
 (2603:10b6:303:8c::6) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SJ0PR10MB4797:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ad105fb-d8bd-43dd-cfce-08db14550af9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vRIfycQJ5RbZyFSC22Uo3WzWbSoFWK2rDiRzjXi3DSrNHMhobzSnDxVK6gPPF9mvkhrgwUhrbZkCQSzb5V2nVOpV/BvpTdQZ9osjGOXuePkqDaQml6mTI/G97gN6NhFW76GXVtS1Ffq/AmEuAUQhIlXnPK/b1l/Jy3A8l8uosyLjXyoBnMLoISN9Z5wCAET7tI+u889XU57JCOv0In5P4RLVtZ615q33JSnEQjQTCKJYgWOsTLGBmUGC+UvQqMoqbrivUNdb/ZPTEQA9nQmET9bGYJEBA2JtknsgCvwXsgpIc+8GpcBFOzGKeVSOZZucEgZTVEs0aTgrQfc2trIAaGHttkhGetjnfpv4b/lHF4PLiB2RXewxVgACYb32iL1Z68/VBN2iqa9I4DCcMU8bQPet3BIn0UknzHP2JdP7cjlYLlaZaHKGMFavTOs3sfhP7CcUxCcmCcXDjswjoeXP5QWF4veOqnk9BIpHJnpLwd+EyKn/BEZIsxhnwdL4RyGqH/UzXjNa+yrvS/jiNN07gjLR9aJP/UXf3KCVdjJFoRKLdxmZ9DlnAjUyt2e5yKTYXo08aHqVKf0ycZag7MrV5PTJeCOqviK4Qgb7Six3NklLW5r1XwXiFJCFIHeRrkIL3eiZtdGeKylDz9n1ORgpGcVi8d4/GRv7njPqZ89QnIE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(366004)(376002)(136003)(39860400002)(346002)(396003)(451199018)(86362001)(33716001)(54906003)(66946007)(6506007)(83380400001)(53546011)(6666004)(316002)(26005)(6512007)(9686003)(186003)(6486002)(966005)(478600001)(66556008)(66476007)(38100700002)(66899018)(8936002)(8676002)(41300700001)(4326008)(6916009)(5660300002)(44832011)(7416002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y8PSLRDKC2cYyqJkALshK5ZEEO1kU5aAdXpZuIUl4Nume8aHFRiDx3n/AcsA?=
 =?us-ascii?Q?qmlbhAytr1+8rd8yyngTF2G/0AEmy5NRJeois6DodTGTC+mz5ysSb5xThlP+?=
 =?us-ascii?Q?bXGo9741sQrQMB3RGPb7i0pJnM+IW1E578xy7ckLiejLGThy2Tku/X1Rtm7a?=
 =?us-ascii?Q?3EWOR7/fCCDUI23YPEt1/+2Q7OEAXKt4+tILJ1ftzwLSSqlDh2Wn/4Fp+WWk?=
 =?us-ascii?Q?DlwHKWHPSt3CmcDALjUvAnceDS+gpidIrGgWt4YGI66D/9YZNWLARKGswazL?=
 =?us-ascii?Q?mMV4E8Yukav4MuB5IixRR7C4xRvgdWCyeYTVVO4E7V0LkmqWEUsCj17HNf/c?=
 =?us-ascii?Q?Ep/tx9JnhxZwMYvqTybHw6WVtz3kJH3GymOFBD/4WLGxGDT70AnLjLFqwZ8J?=
 =?us-ascii?Q?1ZeZMwcQu8jW1DGPoCoIcDWEmdwQO9uPC4yAeEwTrcBhQ5MAFWmFMEHaZxKd?=
 =?us-ascii?Q?cApj46y6XwH/SCvK2A4m44d0QUwrviXiSUuF6ltPtd5FS7vCmESBXdvgkVv4?=
 =?us-ascii?Q?cTMoBFm6y9HDQLvvyr4wQITlcsDtM7cOO85X8hln3f9szRbrgR2nvjvpMSQy?=
 =?us-ascii?Q?FPsnHxs+aIrBpKf17mUgP/15ikb/pTpix3ipICVnV3Jc7gqB4uXiB0TUzJHm?=
 =?us-ascii?Q?oPN5MrnkrALN59/WO7ReLfLbndkYtUJFGRcoVuwPhak/sdKnyVq1Cp77mgWJ?=
 =?us-ascii?Q?XdRp6jAIOUIK3C5LsTVRR1+giPbfHzrdJmiy9OuSgu8gvsyVubmKVtmqf+u6?=
 =?us-ascii?Q?k+KQNDHBPTsOeOaIh72eAR5twye7T/7+1siPAdfMOGQw1A7cc8AilhAX2EHw?=
 =?us-ascii?Q?nkYxTgV+Dxwu1KXmY0EXOaXcwhmIwVDV6UQHZ839yZ1YEkT8njFz7unj34yN?=
 =?us-ascii?Q?803WMa77+3hXqwDSZENdIIjUU3Lds6656sXfENFShohU8EVBnTcmnocKrqn2?=
 =?us-ascii?Q?nytuXok5fkNRnsCBs6Lic7vjmyCaUQ8xNO9E49ey5D1LmS7SPjTkJyiGLv6A?=
 =?us-ascii?Q?gNh7L+rBsJW8FDsDp6QdJoJSsUjVy6i+QNA1KNAUahl8M57jmLZzOWmYtlEF?=
 =?us-ascii?Q?KJzgSJsSCxtX41R7V5J22xSVVQcfLVcBIqYLkf2CdjZ/tD94HiL41pGykL2L?=
 =?us-ascii?Q?e/J2MWZClrEKKpE9+ZHXT3SGnVM3n0Gi4SqkKRP/zg+a81IgaT+F7jvc+uON?=
 =?us-ascii?Q?+KmcB0WJ1rJxf253j1bXhYgZnvYqUrZlzSbBAkC0xG/dKw98vduHAhq8WlVL?=
 =?us-ascii?Q?RCic81Evi3EKeZW8PHeSN2na0djBESJuzo6/5WF3ohvk/AXCIYg5ZGiK24i/?=
 =?us-ascii?Q?Zsx4lM9Vo3hwq2hjX7CvtPzebMi5Owl6uFR4HlvYWfQZpLFtzF6IneOLlPCV?=
 =?us-ascii?Q?myDovnYVF2ixqge3DtqR8knlpa+peZnbhsevAoZcKckBMu3WZA5McMp5M4H4?=
 =?us-ascii?Q?7G3Ce3W72OGpBINt2gscQAV+plHAzehj8YLJS+BKsTHFYar0TXxChq5QW8eJ?=
 =?us-ascii?Q?M9d/CibZ0HHans4TQmKWmflMgRBiE0C7lnMPwAs3SIEIw6hL5jMCbRP7rOMh?=
 =?us-ascii?Q?ojFFO46mcoJ0DmrmuYPSXJKVR/b1exfrbqZ+vxnJkI/kB24IUJctOLi8VBsa?=
 =?us-ascii?Q?CA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?19uhoK7+/1nFWKgbm43fPX7DC1vzjM2zFsk8vMtpl6WigUcYnLC8Qg3HwaDT?=
 =?us-ascii?Q?NTYvBokE6SAmsWiiAXYEybg+cs8Vg68XzWO0DjFtnVx1gFhwiVQiaZjDMMHt?=
 =?us-ascii?Q?9DYh7v/GebqLgPIr5L7t0XSDPzUb75hSoZBlICLZAhcDEOU2wLEdGS603DD/?=
 =?us-ascii?Q?GUmyettMcJWdR0jiMWghXFzWeiru5brj+9SFmXfMU6T35slxwy0d41mSitrg?=
 =?us-ascii?Q?SYMRKH5sNpU0YRiertB7r4kXDJ2sLu/bbTfLYGOKhNOseFff/4uHdhaHJ+be?=
 =?us-ascii?Q?hlEbuVNwI7KB3uPwKIZGwJU3rQPuhmLgodSRXzLCt4WxgiMYog24r5ibQVpe?=
 =?us-ascii?Q?C1xnXHOIEd3yWGXeZH0G/iPxBPMtAdj8bbknugtKWN1sdPNLtkcmbhC+PCT4?=
 =?us-ascii?Q?Z3LINHOwsU41g87L99Pav6Bki5dCn2JCdB1asquw8xKf3eZV9sSan77fKV0E?=
 =?us-ascii?Q?TJOdnaYj2TXZXHYwaqft55yoeWyiYficGktJ7qOrmoVsxeRxl3Z7oyYamhQm?=
 =?us-ascii?Q?TvcpYkO271a7EMCo6GbGMadFtunRTS03onjAanqAQ3fdY2ZiwxQDJG0kxJNb?=
 =?us-ascii?Q?KTepPgqqRiNPWw1TuiamCWXMhSkgH2DTki01TQqC65g4TnHv4U4L+Y+BAdPO?=
 =?us-ascii?Q?TWE/7sbFvvklP38Q5NnmOTKfG7rFn1CxqwqOkFzC0By4v16HP72BbJa0sgIJ?=
 =?us-ascii?Q?0x6fTVaJ5E8QNMVGQ6MeuaBRLpOpkOW11AjvztSVugUsqAtx7lYNgQCisa4F?=
 =?us-ascii?Q?qwj1ApfwClnVP66Qjf6vNOEGob0BNi4XbVdPuMU4EaTd5bN19olEkcEzffCV?=
 =?us-ascii?Q?LnTXxNDdsge0Xp10AkuS4JHUT4oeLrPrmNAZ0NKkj3dKQm6U3jrV8RQZPXHu?=
 =?us-ascii?Q?JmmLs0vtDZH4bMvuYJwuy9UYzc7bydLGV1BzYEOQ5sEYAXVUUVGd1MA4iXEK?=
 =?us-ascii?Q?wHIKtUskreBlF+QoaF8i98UknW60sdJY67PT0e7TxLnW4SImJsrD2WKxYXe7?=
 =?us-ascii?Q?5/RRFbt5b2ZSH1mQRE/iCyUsW3PatOK54mi7jZoOSS+ayfsVel9Zx5ZxbFgu?=
 =?us-ascii?Q?qrwGNXzUspiDYzITVfNlkhafSrkSB82y2JObM9f61QG9SZ24P3VfLg2+Pl0X?=
 =?us-ascii?Q?Z3sBfJjMSA0qJTvoF0q3Cy0LiTzbwG9t7A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ad105fb-d8bd-43dd-cfce-08db14550af9
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 21:46:09.4007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LzmQI/8FiUcSWLBl0UlOvq8p/x9DKye0vVggiSxrDx0CYIZXMTbCok3BkO4Xhc23Uax4L8q7JbrPeyjizxYylQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4797
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-21_12,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302210188
X-Proofpoint-GUID: EjsFHQ9H5MgEzA5eAL9bLMRDGtY9pYe6
X-Proofpoint-ORIG-GUID: EjsFHQ9H5MgEzA5eAL9bLMRDGtY9pYe6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/18/23 00:27, James Houghton wrote:
> This series introduces the concept of HugeTLB high-granularity mapping
> (HGM). This series teaches HugeTLB how to map HugeTLB pages at
> high-granularity, similar to how THPs can be PTE-mapped.
> 
> Support for HGM in this series is for MAP_SHARED VMAs on x86_64 only. Other
> architectures and (some) support for MAP_PRIVATE will come later.
> 
> This series is based on latest mm-unstable (ccd6a73daba9).
> 
> Notable changes with this series
> ================================
> 
>  - hugetlb_add_file_rmap / hugetlb_remove_rmap are added to handle
>    mapcounting for non-anon hugetlb.
>  - The mapcounting scheme uses subpages' mapcounts for high-granularity
>    mappings, but it does not use subpages_mapcount(). This scheme
>    prevents the HugeTLB VMEMMAP optimization from being used, so it
>    will be improved in a later series.
>  - page_add_file_rmap and page_remove_rmap are updated so they can be
>    used by hugetlb_add_file_rmap / hugetlb_remove_rmap.
>  - MADV_SPLIT has been added to enable the userspace API changes that
>    HGM allows for: high-granularity UFFDIO_CONTINUE (and maybe other
>    changes in the future). MADV_SPLIT does NOT force all the mappings to
>    be PAGE_SIZE.
>  - MADV_COLLAPSE is expanded to include HugeTLB mappings.
> 
> Old versions:
> v1: https://lore.kernel.org/linux-mm/20230105101844.1893104-1-jthoughton@google.com/
> RFC v2: https://lore.kernel.org/linux-mm/20221021163703.3218176-1-jthoughton@google.com/
> RFC v1: https://lore.kernel.org/linux-mm/20220624173656.2033256-1-jthoughton@google.com/
> 
> Changelog:
> v1 -> v2 (thanks Peter for all your suggestions!):
> - Changed mapcount to be more THP-like, and make HGM incompatible with
>   HVO.
> - HGM is now disabled by default to leave HVO enabled by default.

I understand the reasoning behind the move to THP-like mapcounting, and the
incompatibility with HVO.  However, I just got to patch 5 and realized either
HGM or HVO will need to be chosen at kernel build time.  That may not be an
issue for cloud providers or others building their own kernels for internal
use.  However, distro kernels will need to pick one option or the other.
Right now, my Fedora desktop has HVO enabled so it would likely not have
HGM enabled.  That is not a big deal for a desktop.

Just curious, do we have distro kernel users that want to use HGM?

I see it mentioned that this incompatibility will be addressed in a future
series. This certainly will be required before HGM can be expanded for
use cases such as memory errors and page poisoning.

Just curious of other thoughts?  Does the first version of HGM need to be
compatible with HVO?
-- 
Mike Kravetz
