Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4713663CE82
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 05:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbiK3E5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 23:57:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbiK3E5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 23:57:51 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D3611448
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 20:57:48 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATMxKv9000926;
        Wed, 30 Nov 2022 04:55:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=ITudXnU7xisLjTA3jgg0Ee+OrQZhPG+IU3DIzW94GTw=;
 b=jNRAYfA7sFFr0dVTgeuvzegV1GFZWpbvoXp5WExSCk4JE4mfjLdsoq9UhYpgs5s3IMoc
 aTYRxY9gU9dC7w8BxD7k7Ta4EvceMcj0+EHaf2k1t9pdxU3/M/gtabZVpHaurcQS+nXQ
 I4wwxS/eomXsT1K4RIu6w+L2q7QWrasiVwi7lhdfk0fbEMbfLw4Z5xcXUszqYT3IQNQu
 orkIwxrIr9oVM8tx/mJTGYU3TTxje6BpqjPOXLkDte0H8VfzLgUpmbjKY7Y4F3Zej+/E
 XXgRafr3LDQ5Si/P4O3fQfeGpqVjIq9TjLCUjs4RCoHRGJixB8tt7DKNGclf1XhaVvwC pA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m4aemf51t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Nov 2022 04:55:28 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AU2AeF8031445;
        Wed, 30 Nov 2022 04:55:28 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m39886egu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Nov 2022 04:55:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/FLTfMiHp+iHpU8nZul+VSTPJuj8bzDpO3CNlY2yp8j6aLVJKdgTnUuHJNzL5TFrCKo+F0qF4S4Mm76xvbVC+uzEsEr+Gqn0aQTZvRHttwz7mMNVv17yD7ihhBV/PC4W/axnrez7gZ/2AG0twh3WM+bMgOPGgFjDl3ShIy9miKVGfhptiG9V4+30dA8F5LDL2LYSZO/PWTXB7JydoEnAK+fyjdEmvgEJv/Tqm6VzXWRR2wGRHCiua3WvU9hliy/7XJCK8WHTsOAjCxJYu3zcAWCwkaKrIN45E18NkwTf36rOLE5TIqtpHV9SIt8Oj9szltvW+I7zSEn3arvdQkuRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ITudXnU7xisLjTA3jgg0Ee+OrQZhPG+IU3DIzW94GTw=;
 b=JICDoCSFHUkIncmAmn7iCNA6nhSPLb72dgLG/YIZWgqhjon2SXna6yMi/Z1IIQ1UQQMe85ivmoPJZvXpbjoRmBbFFfUQliamaSEcDfYcxqZXtwxmnnlr6fdBuEKyPwgEbQgnl9wYx0sFr6DtZhkoLukMKDZzCO8W+34WxF5TlM2A2F1cnU5zTUQrcCI4NDq7X/0QfAU8A4BMteznWbEAeiCMAs7fXH+5142tPQFGjJ4Og8IV/kPEvQ/dNzXi2MYBvWJuWI+YlnLcRGP7ur6mN6BYWANnaibjdB9bUqTXf/5zXxvylSoPUFLgutzlZXaFk2E0e3LMPmqzz/g+HmCIbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ITudXnU7xisLjTA3jgg0Ee+OrQZhPG+IU3DIzW94GTw=;
 b=0Rie1IHKOSXBOpeY+I7gpZpa3sWd0NIufYHbUil0FNymmsiPlF0XnL79R/lnqAf0Pra2QCNy/GN18wPpXJD1Zq+IyWrETP4hxUZJA4uF5ghnqUp0oVBvfYI4ODnxkj320ybJvHo1uExGfXu+AO3OQA6P7F9G1H3SwrOTNaPKKME=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BL3PR10MB6138.namprd10.prod.outlook.com (2603:10b6:208:3b9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 04:55:25 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%4]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 04:55:24 +0000
Date:   Tue, 29 Nov 2022 20:55:21 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        James Houghton <jthoughton@google.com>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 03/10] mm/hugetlb: Document huge_pte_offset usage
Message-ID: <Y4biOcQzE0yJ82aE@monkey>
References: <20221129193526.3588187-1-peterx@redhat.com>
 <20221129193526.3588187-4-peterx@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129193526.3588187-4-peterx@redhat.com>
X-ClientProxiedBy: MW4P221CA0022.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::27) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|BL3PR10MB6138:EE_
X-MS-Office365-Filtering-Correlation-Id: de93ce23-8d48-44d9-b1d7-08dad28f1790
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0WcSvamcOvVBW1aa8E8ixmuSYrh7zn/+C3KTWS6Cs0b+N74Y4dYf+bxG6REVIuc3d8i1B5onRNeLUuwNCr4ZcKwFX43qc5sVSTbvIIxpwzEiCIdNIq4/nvkG3uzbk/io21DBCRFyEyulbdWqt6RTeVl/obJSm5BTUDEFQB3AdaBIAXKGRPiRAU9Qjpv3BF5xO7e6MhOk7LrKcvWXsUBNRPIxNzOQ44ad2wmTMFFBRtpgV8uFVgC0Is8wAiBSwcprcCuwner2fnqmD5Low2zUvuW8YhzX2hBkwvrafERquXDPuGlwcZ6zgmjALtSj/YxRMt4wPQ9bh205nrRHvuAMMDCkZFPAwBHVsaXpGBUhr8eAZwVIvSO5+0Ay/Ndq4AMGuZ9Cq7gwkZyjyCxhWtzWhjx76AzaQPFS/GoTwcftuKmWlfI0lc3K2zlbtyrI6RVDVNBghGHjx9QFiw1x2OjQtps5YwM8fbPdmVwrwEc+odnlR+3dLhzqbBD7rCJK+KONYrv13lYgbyxpmbX5CLJyKqNCCFPRTUw+ZxwY/yHYQeVStjZ+mG3rgj4TQW9OHQmjEhXwPt2kYxLQ+Zlh675djQLQi5dtJ/+MRX4tlT0ZHyhZmpsJE4Dt71pBGXdmDG+uQYSTWQ+E64Is3Gv6vsK/PFBwx7QcwgWnqDNyUahfUIVCxri4hFisBfBk168Hp9HLBR0e/1R0lclKaYLIZCWpVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(136003)(366004)(346002)(376002)(396003)(451199015)(2906002)(83380400001)(41300700001)(5660300002)(7416002)(186003)(44832011)(86362001)(38100700002)(33716001)(9686003)(6512007)(54906003)(6916009)(6506007)(26005)(8936002)(478600001)(316002)(53546011)(6486002)(6666004)(66946007)(8676002)(66476007)(66556008)(4326008)(10944003)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?30nCGcgnDcqs9LxkXz5HEnAhvnudBEWHAqsYZnNi+dyfCcA/RVRx4QjpOGyt?=
 =?us-ascii?Q?YOpzivXVWyHQevqXGFFbf2ZiOMVJ7CyXS9JsLClCf+PT9Cydv139vLk0NpMu?=
 =?us-ascii?Q?YZZgOKQzKTLJK1XbL296LSJs5Lq9kMqvrAst/wyYu3i5Vu5PNUUW35bkGKIc?=
 =?us-ascii?Q?ZPTivNdL78/UQSDG4iww1Bi00nlozt+GpiWk/atW752ADbYv8mLm7+ewbVfN?=
 =?us-ascii?Q?DVuzu3sUGkRsfFoO66DHVvJFCOk8h3JnLb5J4WTW7d3ryqE0T3QPquCtCgvP?=
 =?us-ascii?Q?8EAD+WHvfPqZEg3VgMALfO9RgucDsxgZiRp3hF+h94xTMhmbEmKqPigTuDDm?=
 =?us-ascii?Q?ZIqXbw/YWoFK+8kXskwPdoE3PzDHEmO7Q+GFt114W7EZ4oQnAX3x9Dtrm7I1?=
 =?us-ascii?Q?i/SySqRkbexNncihwzuL1qY+33Y+OKLL2g7nGJ2Zk8e3EEozQmh1g2YYxJSI?=
 =?us-ascii?Q?aGuBxI35ZchxS8yyCLOMH+sBtR+vbmFmBIhHB5acuK9ebTlIlRVDNepbDI56?=
 =?us-ascii?Q?I29X/nEztZl1ZK4RO1hUacl1behmJVv3SaR9rveBi+GH1lEqkVQPLtNiUtlC?=
 =?us-ascii?Q?MZ1iC/vJrS2P9FOt8CLpdTqevv9Z6FbOCsMOUzpBsPRAJrsY7nvNipEnabNG?=
 =?us-ascii?Q?WJyuVL2s5JxIXMy0QRa6CHl3Mf61TnRZ1zuTToPHdqtLC03mi4q10Ht5dhCf?=
 =?us-ascii?Q?9HG/1bh2KGqJLMnV32V+eu3cvbgvaiCmJP8jtcbUItxFZTyG7OyJDKFLfExK?=
 =?us-ascii?Q?j/QtV0XxBve1wuY+EyWeaDJf7TPk+EI6iaE2Xl90U5ci/GYm/sIzAf1clPcz?=
 =?us-ascii?Q?bcDQSBf/EaPvh8hwoZBo9BTBOjcSN+bN/60C/1t8nD5Q208SuXgdyrEDdafn?=
 =?us-ascii?Q?/WSgWjycxufVwoGE0vhRKDu+u6+FYub6gep9mBimXcza3IjXL0vL+gHleLCH?=
 =?us-ascii?Q?OAip/tZRNYtMLi0o36S9vH4JhGt+3KD3tcy2iQOtdh6ECIDibqCYTELqsG4J?=
 =?us-ascii?Q?MAO+XNVWjNiXBBQp8M3nfSO79jGySbSwTHEtI9ZmFbW1GiJgOKpoFi6yc0DF?=
 =?us-ascii?Q?zXrBp7n5gQK1mEmuV+lvf76PKdYWMp/YdlLCI51vK5L6aNX89iu59XbVySF4?=
 =?us-ascii?Q?2kWR/7naWCPj+VJVZgmfoi38gLwZL3PYooLFAKJDNhRqMc300SmlU+/BVRFZ?=
 =?us-ascii?Q?/TeLUNHNqBIlqxLY8t1arqf107CiXXrLiC6sPENktxTbcZQtPAcVv3d+Vjiw?=
 =?us-ascii?Q?LthizTTUmWtJZ/h24cT3zADiCAAigBwTgI+OoqvG/EieY1ZsBiSPfVpTY2dO?=
 =?us-ascii?Q?RLha+Xrbmm/qyWkLCtxivMWbtXNdXakWSdUzDVG003eVqb39BBstJ14+g+q0?=
 =?us-ascii?Q?KYHBIq0QrCIHzgaf3EHzonjb8bJLijCZJch3R35Q2fUwf92QnoPIZmF72YIj?=
 =?us-ascii?Q?n/rOJqUTWFjQqBitqgCfgczJd84hPWhsOvZej/PU/6MLsTP2dugmPqv3J7Ic?=
 =?us-ascii?Q?ZNfKucGgG1AhCHNgdG5Yq2gSIjXcwp+Dm8sYG/uErbKQFmAZFRgYZoC8PdH4?=
 =?us-ascii?Q?Qsfbx9ap1MZKrjiK2DtetGYiacFCHURELqfIgYn/6eIQSsmy+Gr+kq6PiZQb?=
 =?us-ascii?Q?fw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?a5C7w7N9XOOnPMfFFNCaHgUQoGVRwlQufxMhgmZKg3da/tav6Tdh1Ey5A6FR?=
 =?us-ascii?Q?IXFhUg8FdgHb5Mjh+0V4iwYlLm4U1lX9oPjPjqbb06reYgKib41lDWzuLnKW?=
 =?us-ascii?Q?9E8OrRw5PtgXEuv2jYFuXuwAkHDcE2Jakg+BjQTtbmqt4lVIwh2ypd10qsTa?=
 =?us-ascii?Q?mOcyosQbF8l8rH19DGqck2KVLBA8h+V2IZNOh7w92IjaynuqUSHW6wSMSRx0?=
 =?us-ascii?Q?dG+lKxAbJZOpCduzdrQrZXks5YDODrsSPdDtFKIu0si7gi2IIDMDTlpifVke?=
 =?us-ascii?Q?eS3lGvDDyla8ZgTYaoW8S8ZUo0A1LMCrONesRlV2hL0mK04tIh4Q/5ogMOym?=
 =?us-ascii?Q?zXixqG8WfeVyU0lAQScGEHybz4qlh4tdDnWqpk3Az1FL0SvvgiO9GYvBR3bc?=
 =?us-ascii?Q?9MwlH3DukevuavixDr6WSd1TVIarBd/s/VYGZi99Zxenr+rRprCykU+1/Jdn?=
 =?us-ascii?Q?iY6jq0nAwoV2yz8pfP7Gh9tsabAIe4PiWkwY+gywQEz8ftYwga//wWQ4mj7F?=
 =?us-ascii?Q?x5JP6zj3XqLTmjTaktc/Z/V5DY4zzH+n+ahY9b2TKJLKMYPLqCpztZeZtCbs?=
 =?us-ascii?Q?rzqhdAx5BYI7woMW1KvkqRy4BtnqjijZ4Qi0XjTrZdof6Q/5szQBPA2oLbeJ?=
 =?us-ascii?Q?C7othHaoWaJNBBgn87MpAUnPk52vhtoGM2EpEDpm3pr3tY62mJpMwm9ULAUy?=
 =?us-ascii?Q?UBXS6HIJ7fiQO+W447HW78NXL0Z1dmV6EBtz76pN/p33EIuzA+uHuuxNsQ2b?=
 =?us-ascii?Q?gXAtof08RutTccXK3oJ/aYCCfC2NgsYJ+aM6yCr60mzkZAhY8KL3WLidW+5D?=
 =?us-ascii?Q?G1qo5/HDFz6ael+6zmqub9VeqyPRt8CiairBctUAfLmdxsro26DOXTOhCjs9?=
 =?us-ascii?Q?52l7OSc5V5O+db7HdUykfhan1BJw+R5g5Aw9UTqfNrreEFC2Lz3h5/NPYWXn?=
 =?us-ascii?Q?gMmaKTbqhc/mLZXbFJNE/fSFS8AonJHewJqMfcnR1Xf1BuQJQFJeWK72zSY7?=
 =?us-ascii?Q?CXQYx3VLha5EcYv1AV6Cm12sJ8YjdwobGf7debXJC0fG11Ysb7jtSaB+wHCf?=
 =?us-ascii?Q?ZWzxXRlujHiSXL050H0YjjJV9YmRKW5wnPziBTPkQ4mReaC55LU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de93ce23-8d48-44d9-b1d7-08dad28f1790
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 04:55:24.5423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ip7yZT/RnBQNlMnSw9X4/935h1+b4Jq5IOIlxNe/uhKFKEHJaBpMxu3YczePA1rWc1rCCsjNDknV9Ue9T+Iq2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6138
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-30_04,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211300034
X-Proofpoint-ORIG-GUID: Cwnokv2HnoxREnZeeuTDBVTGocT2NCze
X-Proofpoint-GUID: Cwnokv2HnoxREnZeeuTDBVTGocT2NCze
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/22 14:35, Peter Xu wrote:
> huge_pte_offset() is potentially a pgtable walker, looking up pte_t* for a
> hugetlb address.
> 
> Normally, it's always safe to walk a generic pgtable as long as we're with
> the mmap lock held for either read or write, because that guarantees the
> pgtable pages will always be valid during the process.
> 
> But it's not true for hugetlbfs, especially shared: hugetlbfs can have its
> pgtable freed by pmd unsharing, it means that even with mmap lock held for
> current mm, the PMD pgtable page can still go away from under us if pmd
> unsharing is possible during the walk.
> 
> So we have two ways to make it safe even for a shared mapping:
> 
>   (1) If we're with the hugetlb vma lock held for either read/write, it's
>       okay because pmd unshare cannot happen at all.
> 
>   (2) If we're with the i_mmap_rwsem lock held for either read/write, it's
>       okay because even if pmd unshare can happen, the pgtable page cannot
>       be freed from under us.
> 
> Document it.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/linux/hugetlb.h | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 551834cd5299..81efd9b9baa2 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -192,6 +192,38 @@ extern struct list_head huge_boot_pages;
>  
>  pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
>  			unsigned long addr, unsigned long sz);
> +/*
> + * huge_pte_offset(): Walk the hugetlb pgtable until the last level PTE.
> + * Returns the pte_t* if found, or NULL if the address is not mapped.
> + *
> + * Since this function will walk all the pgtable pages (including not only
> + * high-level pgtable page, but also PUD entry that can be unshared
> + * concurrently for VM_SHARED), the caller of this function should be
> + * responsible of its thread safety.  One can follow this rule:
> + *
> + *  (1) For private mappings: pmd unsharing is not possible, so it'll
> + *      always be safe if we're with the mmap sem for either read or write.
> + *      This is normally always the case, IOW we don't need to do anything
> + *      special.
> + *
> + *  (2) For shared mappings: pmd unsharing is possible (so the PUD-ranged
> + *      pgtable page can go away from under us!  It can be done by a pmd
> + *      unshare with a follow up munmap() on the other process), then we
> + *      need either:
> + *
> + *     (2.1) hugetlb vma lock read or write held, to make sure pmd unshare
> + *           won't happen upon the range (it also makes sure the pte_t we
> + *           read is the right and stable one), or,
> + *
> + *     (2.2) hugetlb mapping i_mmap_rwsem lock held read or write, to make
> + *           sure even if unshare happened the racy unmap() will wait until
> + *           i_mmap_rwsem is released.

Is that 100% correct?  IIUC, the page tables will be released via the
call to tlb_finish_mmu().  In most cases, the tlb_finish_mmu() call is
performed when holding i_mmap_rwsem.  However, in the final teardown of
a hugetlb vma via __unmap_hugepage_range_final, the tlb_finish_mmu call
is done outside the i_mmap_rwsem lock.  In this case, I think we are
still safe because nobody else should be walking the page table.

I really like the documentation.  However, if i_mmap_rwsem is not 100%
safe I would prefer not to document it here.  I don't think anyone
relies on this do they?
-- 
Mike Kravetz

> + *
> + * Option (2.1) is the safest, which guarantees pte stability from pmd
> + * sharing pov, until the vma lock released.  Option (2.2) doesn't protect
> + * a concurrent pmd unshare, but it makes sure the pgtable page is safe to
> + * access.
> + */
>  pte_t *huge_pte_offset(struct mm_struct *mm,
>  		       unsigned long addr, unsigned long sz);
>  unsigned long hugetlb_mask_last_page(struct hstate *h);
> -- 
> 2.37.3
> 
