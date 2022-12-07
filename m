Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48F46646144
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 19:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiLGSqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 13:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiLGSqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 13:46:40 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762534FFA6
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 10:46:39 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B7GDZcd030059;
        Wed, 7 Dec 2022 18:46:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=a0hlyXc/vwlRfb/n17+tXTco74aJeCe2XsObX+MD9qk=;
 b=U46RXdyxwhL8FDX74JaT95dGQet8w4TdJTiGEKhT5LK36a5UzpPrAsmBQEZZnJPpKqCB
 j4/gZ9pNRMejtODD5gI8qypFPorYLqyqaDe2ZpaP323eDG85Wmca3trRYlg90v8dM/du
 SUY0IAlFOxM61LUS9uLaPcOBwl1gFPykZUhYsQaN7j7xc0Okv1lrPwdLAnLSZZQnB1+T
 YMmu4mikF4ueu0hgiFqwTMTI6hhNWG226CTQp7Winci+AnmvK+r4Bu0YhNLs2bR2+kgy
 bCFh79Mp615WVaBpxiLOu2vNVoTOtBU2SiWVkOCd7/XKa2bsBMgXfvLhUbjnS8ibeSbm 8Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3maudk948t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Dec 2022 18:46:21 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B7HWnTf002023;
        Wed, 7 Dec 2022 18:46:20 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2171.outbound.protection.outlook.com [104.47.73.171])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3maa7cqp8h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Dec 2022 18:46:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eureI5ikxsvKZfCZ8jRbp3Av1E1uPlXSupvhTaecd1iXO1WJtWiDSH37iFyWcma5U/R3jPqsXfVO3ZOox79DtulsAmuuIkFmOuo/ZqNVd9lukhUrPwUL9mYBMaUtDk8Wskz7EIj48cd/ovziWXsNY24vUEnOCHjpprQGq5MBWTqQMjFyQhOPQwVBwib340bMeaFRYyVa70rn36GQeHOPMKyFI2x1FFtOIDD7Hf+/qa2wA+XFVN5xkq2OAHa73KI8Darg9XLzghWeJ4EDF6oKwc+hWv+jT/VqHd0lGmFJT1sItxya4ZeW5x27l1bTmi/3bPyK07g4/Ax1QykbmuwiNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a0hlyXc/vwlRfb/n17+tXTco74aJeCe2XsObX+MD9qk=;
 b=EgL0b4UR95+MG6sejINT/aRXv8qcjlyQmNbIJt9AIPYiLoxb/g3d/y9LAf39m8rmGHhRgzwqnKzKqfibJa9hlk3x/KAkUdAvAbyAf7cEgGK4GcSEVabWQYkYovdPaGmFldJiSne8PpBCXWJMCCQynzIv3r+SAgBaCwuvpLXI2YS8dgxjzApT/vjMVE5GaleDZxvbzyUHLIm96sKKo9yr7bIbqf8tTIE9zfXuALhemp2iRGWYLsgfj7KF1i2FrNbHOHMjTQvBToxYmughprctxcIQop5/1xiswjED/qEV3GHBj/+g6YzOobVgXVFdPksF3Vz9rfcyVwkbShBU9zo0XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0hlyXc/vwlRfb/n17+tXTco74aJeCe2XsObX+MD9qk=;
 b=OBcBH/hX4QWpRnSz2qJZC0KOa0XewivzWl/NFSzDfO44FG9vzwz8Omi16Jg1xWn9sUpFXncHKqpl9xVjqiJ276gF26+en2Wss8H/vnvUu2lZnarcakdJ6v0q5H1ZrJ6X1oRZ1mqyM4GwpTKXW0J7gxQ+d2NOZojmaGym+PFs7pI=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4370.namprd10.prod.outlook.com (2603:10b6:a03:20b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 18:46:18 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%4]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 18:46:18 +0000
Date:   Wed, 7 Dec 2022 10:46:15 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        willy@infradead.org, almasrymina@google.com, linmiaohe@huawei.com,
        hughd@google.com, tsahu@linux.ibm.com, jhubbard@nvidia.com,
        david@redhat.com
Subject: Re: [PATCH mm-unstable v5 07/10] mm/hugetlb: convert
 enqueue_huge_page() to folios
Message-ID: <Y5DfdydR3ZSsKNDY@monkey>
References: <20221129225039.82257-1-sidhartha.kumar@oracle.com>
 <20221129225039.82257-8-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129225039.82257-8-sidhartha.kumar@oracle.com>
X-ClientProxiedBy: MW4PR03CA0236.namprd03.prod.outlook.com
 (2603:10b6:303:b9::31) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|BY5PR10MB4370:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e432170-51cd-4c19-5fb7-08dad883537c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t7x72OU/AwkEHtEqc+82YDQ2nIWwB3nkvJU2JfWpBk6/8wWN+YjcjJQLhV/m20MHDr7XbHCKxpIv1q9i2q5lqmoK6QAOnyUoXBME6RsHeLPSKH+O3SggaVpjXVT297/gCj0cx6wlzUqnLS2AofjO/9LdT5CVGLkjr496diPWp2NDz63MQSLfvSJg9rS+bt5fY8G02T1IoU9CQoxTqqwb01e6qSu23NEuZTdsiPc4C/HsoaxKOTISgZPphLS5oZbFBmlGSUGDM7RRa2C1wUdNq0j4KLeNTn+2ZQoFM53B2zH+ft7IgNm7S9zTuL8hB3l3efiyL/Y2sRfROwm4AW3fcY6E1GlGM4SnfmqhQ6xk7f5kyHwMnCopGms3Trgo/hj8X7tJsdTDUT6W6lCDUSFaYHXrdFdzxQ70uFN7L+2pLe3pstDI7WFauKkIwCXzlqLSAemoWkwb9e0lj0w/uzxD1k5TEs7WrbYMYDs2tsVbZAFUEhR2zc5B0l+wEAXwM2Gdb0Fh+gBx1O4arqxP70sfZEarudFDKk7b5TGCz/3NVLcjzgwF8MSdb8gh6cGSyKT41fuShXng3vm+BYh1frxfjP2EhjJGS2UtsF3nLLWJYnZ3iAndFdkeVJmE2fhEYCj/TSNBN6EdqWM2D3hljQ212WlWVL7wz8EsnX9wTpGujc8KdZoc6QdMEpCZUQsBGQ4X
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(376002)(366004)(396003)(39860400002)(346002)(451199015)(6486002)(478600001)(6666004)(6506007)(53546011)(66946007)(26005)(186003)(86362001)(9686003)(316002)(6512007)(8676002)(66556008)(66476007)(6636002)(4326008)(7416002)(41300700001)(4744005)(44832011)(2906002)(83380400001)(5660300002)(38100700002)(33716001)(6862004)(8936002)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dljlHDJ6a+BJCdo7lKuLPqBOnE9XpuKjAJ55gUgKZaNLN6K9i5lK+O6x1Oty?=
 =?us-ascii?Q?WxPwIu+pOHuGOcZfDicRnNDfU72SkqDrqnlLjZGL0D/rOcBk+c1jsPA9HN8s?=
 =?us-ascii?Q?jCG/DAn26hxz8OHKQLFPmlf0VJy1rD1kmZGg6fnZmtZH97M1dwjt7wMpo/IP?=
 =?us-ascii?Q?YmM7jSOoNrSAjVw3hgB5k0wjlbxzZBNpy38rXwYdUFyrRdpPhrU1hOiZ9hgP?=
 =?us-ascii?Q?TEWc88WjUPSv6ky2PGqBjxNopwStSWSCrJ7QzMDAxiDpjtEUzWdLWPwC4cdm?=
 =?us-ascii?Q?r0nebi53bBNIIX3OAHfpXChcgqAbqaLbtxJiHQbZCw1ZJyFik+rxUieSsGyu?=
 =?us-ascii?Q?9zvsanWqY94043N5MBCB8RDQSVThAFNLKsOWKldMWtutkNMPCO62jo5moZp5?=
 =?us-ascii?Q?D2JzdcsFYiuTyj1PxCXvO1WyKU6HslFX9MERKAoWfz0wJOj/qmIhHYFgKZV0?=
 =?us-ascii?Q?YHQXF/BEkjmq7sciuHDy9Cm0cvwtcROkNxPoR0lpMbH+b+xZP9ZyaAuo/inR?=
 =?us-ascii?Q?d/qVjej53utn5fc0BsaJJWusirHQ2saOZOTJ4iEJgWOMa4vNSPHPidx1QA9B?=
 =?us-ascii?Q?8d72uAFLrnBprtk5lHFAcZMs0JKC8gTW8tzLZs+sz++qxh6RgdlpW5ysAwmB?=
 =?us-ascii?Q?up1tI0m+CbSrSaZPVRHr2ybdt6DrWhPdxjCrZO9I9mVvkGnQBYqMylgaHzuQ?=
 =?us-ascii?Q?wv4D0X/9c96f9drNPBdBBWcNg5YfRGNyqReNtrGS00wrsq2YYSuhwKLfPBVS?=
 =?us-ascii?Q?DrKRw5jKpbJejRxCyK18DHhP1qityOgIXT3WsVw2StuY14PNDPHY/das3vpE?=
 =?us-ascii?Q?6wQ0aKBfXI02jzEnPIpWgl4aA/VvB4+IcXJPvDmuOaqowK56HEJXvDkM+xZ3?=
 =?us-ascii?Q?+EuphQCVFW0yP9faYuPqCnY85WJ37qNZn9p82Mlzy5QfSdH+5qcT8uNJpalR?=
 =?us-ascii?Q?cFOwRt3Bil51usI53C7008I5QOw5/zYMcf8CJOPxxB2Kexy2cLMfCijePP8h?=
 =?us-ascii?Q?TVy+ZSKB3R5YHKJl8r1u3mRqUDC/OyfjpzAkST4tIgrG7rrBK8UG8QZpvh1u?=
 =?us-ascii?Q?Vx6zmcAxXEfZVMjd4bTycRledqAcFUzvzW/7c4rPBu7H4ElygqAOFJU6/aTl?=
 =?us-ascii?Q?cy0ZDweolmXGMRDaOyBXN2dFLAuk19F+4p4tcv2HgGRaFccq7pVtnpRga+Nr?=
 =?us-ascii?Q?JUnSqXtpIEfNCWup2AoThDAMfflh69GWQjIzevJLED2zZuqCv8TNsY3p0wmu?=
 =?us-ascii?Q?nhDKci/k53vPzuneS2Lrxdhi/CGvyOXCkoe+VIaqTatq87FVk9tYiJ/zWv6y?=
 =?us-ascii?Q?gS7MY9JKr2QXr/okNbUBbAuaQ+rxTIST/7TySVCLrYk+jm8jgO53VPuEpyl/?=
 =?us-ascii?Q?SF39AzZEbiWamyzR1xNqMntOEH96U2zzNaQ+buVKt5w7aI3ECAAG4Sn42i40?=
 =?us-ascii?Q?rR0npvRgO1OKyDH/pTYvNWpycEDXNiws76i152tXV6XRKZBqL72oraSCjoP5?=
 =?us-ascii?Q?1oXEtk0ZgN+ptWUnBRBiWfuGO7Al3uhWp4/NL4dJ8VBFGH2MLiEMZJ0JwP9O?=
 =?us-ascii?Q?mtjqqiu72KB+L3A0Hlr4nxH/phEFpbZPkpTp0Y1fm5jVQaCuv7Rm/Bn7qyPw?=
 =?us-ascii?Q?iw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e432170-51cd-4c19-5fb7-08dad883537c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 18:46:18.1508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MBQjyqNeCcwEbl7uxvMkcZj2wdY+coPNHyuBF+XXrImPyRxBZ9wsmsTnVXxnMFftRhEh1f/pllaN1AHATo9kRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4370
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-07_09,2022-12-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212070158
X-Proofpoint-GUID: 181ZeV2mUG-6pX8bYwWkh4PiqUd39rvA
X-Proofpoint-ORIG-GUID: 181ZeV2mUG-6pX8bYwWkh4PiqUd39rvA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/22 14:50, Sidhartha Kumar wrote:
> Convert callers of enqueue_huge_page() to pass in a folio, function is
> renamed to enqueue_hugetlb_folio().
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
>  mm/hugetlb.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz
