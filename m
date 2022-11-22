Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284EA6342A8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 18:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234231AbiKVRmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 12:42:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234371AbiKVRl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 12:41:58 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D09769F1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 09:41:56 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AMHU5nJ010146;
        Tue, 22 Nov 2022 17:41:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=QscRxYK9Rxbae18yN9BR8CFSjNoa45mz6EGDh9IoI0U=;
 b=TDec6ocd9IVDWc7cqbAYkasUCJ5KYfmoq+2caL4uml+uLbysZphvs5tv7ULXgQG9XxnR
 FhLWNSn/1DkR5dcQT0mbrz30B5ImFoHY4Hc1ZW5/ShHAdREelV0+Smiy3JzXsUI4NRT/
 ca7dxfWzXVa/PIYl0AaiD7YsVwlNJHc3Yty0GeKzQI/Iv1gtUMdYPWm1wSXhete5+uIM
 wGpotYf2DPr/tmiRJn1L5qQwL7y6rdA1K4VASnsqjS+zHOJkQ6T8GRTdYR6p0N8jGXJD
 EPc5khvfZWc7NIJHP0nxRYOTsmKtqIjw8L8u53lZGYCzVCbqKWuXQ4vNv0ffo2X7a7Pk hQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m12vg81kd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Nov 2022 17:41:48 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AMGdJPH028911;
        Tue, 22 Nov 2022 17:41:12 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kxnkbh5pd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Nov 2022 17:41:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lQexSIpFo0zJy8ZhRWDx9BJ4Lr7WSkXjuK/qM/Hw9EWW3lYbHzfL0iiZnyRNUhpwC1sqhdTtiQhHhaBHQcV6Cmn/Fit8fXZ0d8zH3Epf3Nv9w7Sn+1UHEx0U6r1U9IjZB6on9hXDaZasH9OV51PYEv3N97HTZk510/SDYg00cQgZo77bRSxiAV9GT8KPze004XZHPYQA23qcb+T24wxyAoqyiThKVDyBylvNqYkAPuEtnfSU1ccBuCK5C72YOBGkG5LzREHPfFr5QHQrMFS5Kx9umfdhlDm8uFh4VTtHr1NDfBqhzXpkW2kTl67WYCc95Y0B1TpSsYgzZ8sT3SifxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QscRxYK9Rxbae18yN9BR8CFSjNoa45mz6EGDh9IoI0U=;
 b=ZgUGxAZLjKuulQ2K/AW0X4zHr9bllqy/6Q8H/MtB9pUA1NUHChi2Me6OXT+nb2+mSPDILoZMCJ+9qsZt2cH1cUKe0291zU+xBTVi/HPYB/an1xRRoYX+j/eKhsjpfbDohj4poB+BE+nlNB/GfLQOFSggdZNmMfVxrgFYHwn2RHWF1FidMPyDdlEOHnmfsnjr38XhSkwXjSyEG/NAZr2/RmBjCikhFWB5ExVJ2P72kN36261+3UiBGWMoRYjAreVS2pYPzN6PxSoH7Ha5OSjQROfNFaZ2DTpNb5l5TeEQSNczt+AV8pzCmjzdtFCvXThGr4zmASIuNs76WD3W9/F2SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QscRxYK9Rxbae18yN9BR8CFSjNoa45mz6EGDh9IoI0U=;
 b=d+oHDnifLHMUUlllhNdJme0u7TxkdXgJQ1gLrKLXi+OCti9RYGMzdWKYA94jLRGm7JTidhN0jsWXd+H2eN2GdA+AASlHgmF+l/hYirZbC4CbTlzGr6w+FN8NiXqnoHE9bPgp3OUYRo7SIq2BFxxbHuC4UxrLmMg06rWHbiHyG+g=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH7PR10MB7009.namprd10.prod.outlook.com (2603:10b6:510:270::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 17:41:10 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%4]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 17:41:10 +0000
Date:   Tue, 22 Nov 2022 09:41:07 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Peter Xu <peterx@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        syzbot+f0b97304ef90f0d0b1dc@syzkaller.appspotmail.com
Subject: Re: [PATCH v1] mm/gup: disallow FOLL_FORCE|FOLL_WRITE on hugetlb
 mappings
Message-ID: <Y30Js24EqCncvqO/@monkey>
References: <20221031152524.173644-1-david@redhat.com>
 <Y1/0e12ZJT6+N0kI@nvidia.com>
 <Y2BIbyxT0Bh6bCUr@monkey>
 <e2e59601-ced3-a62e-48e8-69fd24b1297e@redhat.com>
 <20221121133320.a4e1c70af6ca72f29795fd5f@linux-foundation.org>
 <4b926dc7-b8ec-e363-b9d8-35c0f2c897f6@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b926dc7-b8ec-e363-b9d8-35c0f2c897f6@redhat.com>
X-ClientProxiedBy: MW4PR04CA0342.namprd04.prod.outlook.com
 (2603:10b6:303:8a::17) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|PH7PR10MB7009:EE_
X-MS-Office365-Filtering-Correlation-Id: b352d433-4d8b-4d5d-ff27-08daccb0bde6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ogPYrSEVov+Ck2dX2yQ77yITk42fNsW1h+4IP9BTSCtLp8v+sQeziqhNDdNgcdN55WA+Gm+OfmKoOwY/kMQ04ogp4sKjrC4PEenNkJhyrCfjuuYMI9VpQpfXg0UveG9UPlJuLKd/MQC9lFbcdOg8TbGo1Zi6MsWfjQRhWbJPlUl8z377Lg1nC7f5jp284y4KuG6yvpn5zGkt9ItPDv1uc9cX+GWQFr0J2WU0Za6l3SIVyW6417h56RswsMM5oHRTq/MGAX/UCXYTOxTbSM7vJbBBcpdBFs5g6WwqSjyGQ+JUJbMs0QLkXMVpuYyN8WNbWazVwIYlP+jMNdtQoJd6O7kDc3xkpz8/2QyOPuv3tDM1dM3ic8GXF/IO27wgE0MP+QYemkhAIqwZ0XrjC6JM4/R51Pug7FzMtBwd2hOAW8NgYpQI7gYYQtdq8wspRB7s0eMV0CNtjZ+/gH6FIkuBkECFlT+Nu+SEmzFgsha2doq+bhbPsf4lHZdWiyEli4akGC8cD4OYiDCAUTzfkCmo2Jh57W9zTe3DqMKhHFCGfMLpYwIG4yjWZq/dy4Ataz6Pg3/p89DCMsLlHslrYs1INLdlInU9AcVEuf7aCoRd1OOkjx6cQeTFHnTmvEnCnhWz/GCd99ZqgOCeLM4j0ixrnzu0Jvr01dehkXIoMncsrgVfNy6VB1gzfhiIi4k/6Hg6imIge+R+vpVJAG8ipPWviGkIEj5ro5RRQmgY4k6CslGdVSLEb6GXlZCSLEupm1sB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(376002)(39860400002)(136003)(366004)(396003)(451199015)(41300700001)(6916009)(5660300002)(2906002)(86362001)(38100700002)(6666004)(66946007)(8676002)(4326008)(9686003)(66556008)(6512007)(6506007)(26005)(53546011)(33716001)(186003)(83380400001)(54906003)(316002)(66476007)(6486002)(966005)(478600001)(66899015)(44832011)(8936002)(83133001)(266184004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GR9pTLDqW5Sq/V0R/07OF+MkjaxA4iyplw6c2DiGYp13Rm5zQA4u2/swVoUB?=
 =?us-ascii?Q?PqxvtEGLjeNYgGQetMHcdBs3I1A6LRURW0Vc5ULuEoKKx62WSmcIC7YCmfbV?=
 =?us-ascii?Q?gKnR5NqkKNiYgCsSZ/6BwL3YYsqiID+kVfUzt/WR7wDNJ3+5ITNIwfz9qXi9?=
 =?us-ascii?Q?l+YBrZR1oDz0DLeL7cwJyCypfuNLhIrFinWHBpuS1ToiEf75mtUl7WjjDpK9?=
 =?us-ascii?Q?CBMhqWx77JtPuRdPvQUFISegKNZ6/mE3gEnkBKNPyu+rX67tZU7qp/BnYaGL?=
 =?us-ascii?Q?+lOTrnKwfWRR/Pk4EDfofel0k8I0RdHto/HsU/pkA2PbGvNOOndPrAXLXefJ?=
 =?us-ascii?Q?FomAI4ji4mkU9VfLgbALzRBGqQLE6b7n7S5Pk8weaBWe4Ojdo/RTwd2+7Bl8?=
 =?us-ascii?Q?cs8fgecTMasyGDDuM46eR3Em7dCpPHNmHolPYkJSp9fmZ8sYELB7tjJw/BL/?=
 =?us-ascii?Q?ucZ39YOnc5BmAD6FKWKtvoja86tUqn+ORKSJWI1t6Bzu5WBGN3VPLI9+OgT0?=
 =?us-ascii?Q?KCq0uolQVJ1Z/3hSnzSQmQeT7ionigr5Az5GhwSIyqzcxP8KyQncQQ6N18/T?=
 =?us-ascii?Q?KtrsdBYknh60pkmdIvlcIS+AfQOhxlHJn641ulpMSz/ve3GchGzIfughXNH3?=
 =?us-ascii?Q?kO8saAOlvR3i6IDf0Xr40Woc4URw01xcB9A7BLNDfMdO/CpXSXY7cGs+ShAj?=
 =?us-ascii?Q?TXNmzFYi7LloT9UWtkUQWX8PYkMNaXc+2Ljp8Epe6bcse5xy2sj0j19cjkW7?=
 =?us-ascii?Q?/LuMogsNL1eQ/8Z9WwEXaktCVNzFZ1m4Crz4O31WfNS64xBv4aL0r6EuqfEj?=
 =?us-ascii?Q?HmmPEQRwwKiINBRiqDn/YxfNs+afvT8bXvtGfdrqU06FyePdIAU9HxZ43dzb?=
 =?us-ascii?Q?jgh1RoMk88q0XeOf+wG1iOb+c6PqAwv2yUDp2ElXCLqvBNhMCfYqZOImTsAT?=
 =?us-ascii?Q?fyioqj0cN4lw1MlRs9r5/wT5fw3Z/7FxSSd3Gc7E+hv+VxDYGdNq018CMBV1?=
 =?us-ascii?Q?dwJxgkG5ADpwXGqb4Z8gxrvqglEofrJdy1uxi5sgQ7feziyaGF+Z1UOCEFL6?=
 =?us-ascii?Q?HJv7aLzFvFa5nBorwfTxKCqv21Gja7MKTzjKXlaoxhAYUpP+rQ/cMd/vIRUk?=
 =?us-ascii?Q?RX3irCSif2YXI/y1z0xvBK2aUHauqneJLgnc+u5rK4bTE0jrshQ/wlH2JTDQ?=
 =?us-ascii?Q?NsGdlXPkIpzGLdR8UE+6Fjfj9jjbeBDOOlQoOmQ7YyMTmCva0uNhhjKUCUAx?=
 =?us-ascii?Q?ywn37k7OVSYZWy1FC2LPMspqqexBHmca+avdcVcpz9AUpXFDvFF+yqPgucu2?=
 =?us-ascii?Q?MVuAiGUEMd6JDqaMZalnSr7Kfeq9ZK04Zxaj+KupZSnP81sHB+1/KdPd+O8a?=
 =?us-ascii?Q?JMdUB8ecZsrt2jPURQ187kqDDKg/wLogQck2aeDuxfUvunEdFVW1Qa78280/?=
 =?us-ascii?Q?aU9FSub/Drvw2CGelSEOj2gEkrhP5XVp3FnFJsL19oNm+xpWwrZ7wGtydvwF?=
 =?us-ascii?Q?SlGDSUjCShqvdwTO4bH/O2+ukQ6D5sqJzV730Pnu5TSkrOSXsgRn4KPPFZzD?=
 =?us-ascii?Q?pVWnBrHtGwILsP2MfslVOpMc9Jx+wlsnaXxuXjKFsZu5S0XWqrQu9pcTGowT?=
 =?us-ascii?Q?6g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?f8C+DwvZ89TGifnJ+OjdHMR00Pjs1pBTV768GZ+wFktrb5Jbcp06TuoK4gQp?=
 =?us-ascii?Q?dVNQ/dsZcCAYKTRTAw1lr0BmM/ipvEoWOrrVO0/EEI1dsG6e3/VjuMadEcry?=
 =?us-ascii?Q?tm9Evr9myCxwDOJdvudZnb0brXrHcLXuXH/A+UCKStOLpLl6jYlG9U8XA8Fd?=
 =?us-ascii?Q?Db8dShmuitwfi+rTodtyCU+vIPdg1lVIgI11R6qu8/nAt6VCASn85xw5ChWq?=
 =?us-ascii?Q?KaVGZR65lEyCV2SMJMuLHP8j8uVmejMXgApXmt7RkBPumUXaz9cKFCdVmxjH?=
 =?us-ascii?Q?P3UDYIW3Pho2ZPOG0WdKtAGGPup4H7PkEuvG1e1JRKo4rNib+dlna824B06G?=
 =?us-ascii?Q?SU9sG1yMusRC8cDqIOxvYOPMfp7l1pGuH6TV5GVmJ8I8Xtq9FqddYw+94UfX?=
 =?us-ascii?Q?HMclwT5NDuTs43CKuJmZcR70RYMb1HHlDthTdERcfnc9WhRbkAyUAXucC6rA?=
 =?us-ascii?Q?1Yaqn43uvdvwugUEcSpIEB7tARtpCKfMpagkEPrVqwxI+WkcuyRYz+0E6yuG?=
 =?us-ascii?Q?mQej36BWQEb5afu8rn4nF7w415ktX7XR9ynwRDp4W/WGKQt8SqZbbTPixtZw?=
 =?us-ascii?Q?CoO3unQ13Lud60ES6m+8EZWi5dqlbNgtdUi1/n6cHNRS6dBUICix+J/dOLJy?=
 =?us-ascii?Q?Di5h8ht2VKit2bwMSwWF4Z6HCmNQ/GSM5pYXzX1WvtkbpoSTqM/oq6ir7KXO?=
 =?us-ascii?Q?JguWaDzfn7EHgkAH32W8+CODRvT5mZ1MNj/jWLOU+oSy3+llL/8cuXxun86v?=
 =?us-ascii?Q?xPYNoaJyKFlG307xtDvKyjD4fRJ2JvNK1wfnOuv3wKaCpNANs05XDeK+NRJ8?=
 =?us-ascii?Q?U3a07q6HZpk7XNGJOqQ1i8QYh+T+Ffs3VqwGO1RbymfbRlgaG6ls9EWYE/bI?=
 =?us-ascii?Q?1C33OB7nAULpJlyF05mmQiH0BJrjyTG3ch/aKvBn6qq4EztOCjTdIB0qedMq?=
 =?us-ascii?Q?qz8XbIQqcuVx3awMweBxGsNt8fcOycZ1q7wD5Rf3hlxt+jnMdU0jdbl3nQZ+?=
 =?us-ascii?Q?s5J5rTziK59P0QuU+DqmfqZ/PQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b352d433-4d8b-4d5d-ff27-08daccb0bde6
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 17:41:10.0251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MnKJ840is+wBxN6DKOvVviTblxmPJTom2ZbZzCxqyxHK7TgdK54E7AlsuTAZ7N6sPjRM6OtzcIbdMuJLTuZnag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7009
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-22_11,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=948 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211220135
X-Proofpoint-GUID: -R3sOqZs-bRueUbyWghdwHEHSyploW2Q
X-Proofpoint-ORIG-GUID: -R3sOqZs-bRueUbyWghdwHEHSyploW2Q
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/22 10:05, David Hildenbrand wrote:
> On 21.11.22 22:33, Andrew Morton wrote:
> > On Mon, 21 Nov 2022 09:05:43 +0100 David Hildenbrand <david@redhat.com> wrote:
> > 
> > > > > MikeK do you have test cases?
> > > > 
> > > > Sorry, I do not have any test cases.
> > > > 
> > > > I can ask one of our product groups about their usage.  But, that would
> > > > certainly not be a comprehensive view.
> > > 
> > > With
> > > 
> > > https://lkml.kernel.org/r/20221116102659.70287-1-david@redhat.com
> > > 
> > > on it's way, the RDMA concern should be gone, hopefully.
> > > 
> > > @Andrew, can you queue this one? Thanks.
> > 
> > This is all a little tricky.
> > 
> > It's not good that 6.0 and earlier permit unprivileged userspace to
> > trigger a WARN.  But we cannot backport this fix into earlier kernels
> > because it requires the series "mm/gup: remove FOLL_FORCE usage from
> > drivers (reliable R/O long-term pinning)".
> > 
> > Is it possible to come up with a fix for 6.1 and earlier which won't
> > break RDMA?
> 
> Let's recap:

Thanks!

> 
> (1) Nobody so far reported a RDMA regression, it was all pure
>     speculation. The only report we saw was via ptrace when fuzzing
>     syscalls.
> 
> (2) To trigger it, one would need a hugetlb MAP_PRIVATE mappings without
>     PROT_WRITE. For example:
> 
>       mmap(0, SIZE, PROT_READ,
>            MAP_PRIVATE|MAP_ANON|MAP_HUGETLB|MAP_HUGE_2MB, -1, 0)
>     or
>       mmap(0, SIZE, PROT_READ, MAP_PRIVATE, hugetlbfd, 0)
> 
>     While that's certainly valid, it's not the common use case with
>     hugetlb pages.

FWIW, I did check with our product teams and they do not knowingly make use
of private mappings without write.  Of course, that is only a small and
limited sample size.

RDMA to shared hugetlb mappings is the common case.

> 
> (3) Before 1d8d14641fd9 (< v6.0), it "worked by accident" but was wrong:
>     pages would get mapped writable into page tables, even though we did
>     not have VM_WRITE. FOLL_FORCE support is essentially absent but not
>     fenced properly.
> 
> (4) With 1d8d14641fd9 (v6.0 + v6.1-rc), it results in a warning instead.
> 
> (5) This patch silences the warning.
> 
> 
> Ways forward are:
> 
> (1) Implement FOLL_FORCE for hugetlb and backport that. Fixes the
>     warning in 6.0 and wrong behavior before that. The functionality,
>     however, might not be required in 6.2 at all anymore: the last
>     remaining use case would be ptrace (which, again, we don't have
>     actual users reporting breakages).
> 
> (2) Use this patch and backport it into 6.0/6.1 to fix the warning. RDMA
>     will be handled properly in 6.2 via reliable long-term pinnings.

I am OK with this approach.
-- 
Mike Kravetz

> 
> (3) Use this patch and backport it into 6.0/6.1 to fix the warning.
>     Further, backport the reliable long-term pinning changes into
>     6.0/6.1 if there are user reports.
> 
> (4) On user report regarding RDMA in 6.0 and 6.1, revert the sanity
>     check that triggers the warning and restore previous (wrong)
>     behavior.
> 
> 
> To summarize, the benefit of (1) would be to have ptrace on hugetlb COW
> mappings working. As stated, I'd like to minimize FOLL_FORCE implementations
> if there are no legacy users because FOLL_FORCE has a proven record of
> security issues. Further, backports to < 6.0 might not be straight forward.
> 
> I'd suggest (2), but I'm happy to hear other opinions.
> 
> -- 
> Thanks,
> 
> David / dhildenb
> 
