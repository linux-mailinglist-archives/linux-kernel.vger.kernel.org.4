Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC93E626609
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 01:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234575AbiKLA3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 19:29:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233542AbiKLA3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 19:29:15 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518CA1583D
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 16:29:12 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2AC0JO7q027533;
        Sat, 12 Nov 2022 00:28:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=exkBZ0IHxof/bVtfpJmp8kDB7DyhAvVNhnFUg1KAUmg=;
 b=BPqKPCv1Lh0wBIYunUNj/lJWCsvAC0vew+O65QThhtN9aCvy685A7BudKvucAzOYy/V1
 9BmIffJ+mAwDXywBHs++lH2D260NdIp+rSN5Yp2EvVeQNJBoiqC4r2R0URwU7vT62Gca
 mMNXYnoFd7ZQbJRNQzzAnSdQ47MBPudEjP8bBm5AxFJRRNofxIxUbSnbRoUWwY7jDH0m
 FFcuiP22XInnsQzBAfA1LHcyoLsorpIvxuODKbAfuBoTEHMOotrYdf+lmWM9+6uknS7Z
 /ZbOZpwDYJtPyXc+z5OBPo/j2V3Tap2BCpUzm79jGt4R9KpRgYde2MyrGXH9xFxUpgPM WA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kt0nt00f5-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 12 Nov 2022 00:28:46 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AC00dLg021261;
        Sat, 12 Nov 2022 00:07:39 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcsjhyme-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 12 Nov 2022 00:07:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nk8I7jWnH3s6X3xvJigUARKj/+HesB52kJroz916EifHp/BgDHlA31WD1mJQyI00Zwy5hFxMs4ccuIVad+7zF628Vs2kXwCfefwU9/+WxgNNWmwPUF/mZORdjjyFgzlb+zdaaIIJ994mzAjWpOVUI2WFzpoT+2RmGzVG1JGqZ5LCthbTgh58HCLYm5L82Z8oVCBLB58o6Tx+6vriKPwjABp9BVlePIhJaCJ+91MFqtqGCzKOHm8cvV7nhNENPHA988qib899k8Dap2IDkTvvrjPPs7bG4HcvAkd78G0z1VLiS2Yw5g7HEHu0iqEJA228nr4NEuXKDz14m6DStVmnSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=exkBZ0IHxof/bVtfpJmp8kDB7DyhAvVNhnFUg1KAUmg=;
 b=Nc9WA4Sk+bKStD5sC+qjNxajpg6udvwYwtAtw2O12Nlc6AKQ1Xz0OCcf5eWfUL329iUWuZiInfK435Dk8nCM32TGLZVLvPyKG3vaWl9ZK0ujr2GTtuE/9aX9AaLG5ouj9BzRzjVAUu9PdAVJANPj0fNp7R6FN1TZfHITWOfR/5g5Tgupj/9jtVGJ625ur6LY7fHcUzYQ5zvB7bW/vR52WwPcdRylG6BVOrFsZDXpJmiA/IKKdKZku0UYGogw1rOKv672HNDuDJpdk/5YSMPAL3VZOwkyOk4alPJZUzsiogzKtUmuNIGB7jI71GcLJAbWcda0EHjYYtNMEs2tvXeNkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=exkBZ0IHxof/bVtfpJmp8kDB7DyhAvVNhnFUg1KAUmg=;
 b=swaPT8CkCAxTfBsPkMwO8KdK89/ek+JF2nyGQg0P6lA5EwGTsxSWdD/6J+c+KetYblcPyJLun2yiLetWzx334yXTrnrwd4mZkOlvewQbVTVcoarqOkxOtcUXvZM17KRiSJ1PEO9O6uicsBGoVSEwjJRYglRUWpwnJR7LpUmyGyY=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BLAPR10MB4819.namprd10.prod.outlook.com (2603:10b6:208:307::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Sat, 12 Nov
 2022 00:07:36 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%4]) with mapi id 15.20.5813.016; Sat, 12 Nov 2022
 00:07:36 +0000
Date:   Fri, 11 Nov 2022 16:07:32 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     syzbot <syzbot+ca56f14c500045350f93@syzkaller.appspotmail.com>
Cc:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        songmuchun@bytedance.com, syzkaller-bugs@googlegroups.com,
        trix@redhat.com
Subject: Re: [syzbot] possible deadlock in hugetlb_fault
Message-ID: <Y27jxKoo1BmgbDbl@monkey>
References: <0000000000008c742d05eca72d4d@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000008c742d05eca72d4d@google.com>
X-ClientProxiedBy: MW4PR02CA0025.namprd02.prod.outlook.com
 (2603:10b6:303:16d::11) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|BLAPR10MB4819:EE_
X-MS-Office365-Filtering-Correlation-Id: b39383e4-c828-46a8-f545-08dac441e6e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Evu6O7lafxpgSZEj3q1aU3eZXIWFp0wF4pEl7Jh5T9ZNSEj+x0A0WvzHa3Nims+UR8ieZlNzfKw5RohxaJQGU89GLiWzMOn6VXhwFgqJ/OrBPFq9EMi5ZvP6tO3x71a7xm33W2clHjI2x2d4uF8q+AQhN0wv2GT4ZRrm2NACAjJJzsHqe3+9dSn+8kEaA39zol8Y69JUcp9pkgeFDNpdpde4YU9puZ3zCQyJ7QFCZkKo6gayz9zqZTHbWg9kMBHk5iQwfmRhMqiYOZgEYeuJLIt9B2i1M6WMWhQrUBU9h/9ZioKdiEllJ7MsXdavc8GBCNhMNkdUv/HUbiE/bqpbF1N1pdmMkkkNpTEvhKt/mPxmkcWFoGP7ql/Nya4+pnyJ1F6YkIICrUAV10kQGma77QnyWde9sEwy2L6L+TDXtSkPlVrDK2/yzOpTzkByx4mNPB8fNxL/plh1zv8QlB18VX+DGPEYgehq0NLSO4UW7AWuIZIt9FSsI0+XiJ1y4M7F2mGdydSx+518kCp2zuQYbLNm3iC0iY9gExl70XMTR2FZ7wx8FCchdCeCr87H+f3+ZEj3RS+3yxw4KQNip/GK+R6JtWeTL3RAvRBBbGqlRhcL2LkrOFY3VCWMm/h0OdYe5rfC+ss4iGgaRhGll6B973lrmmn/6W9z1CS3/ROlTjOzCAKzNRIQseUAMEYP7MTzBeK9Tw4etMdFWhHCQw5l/5Fd3I1qb6BFh0o5mcsptXA4yKbI2RaOiyizP/MAUk2tnvEeu/94XJcl+a2/Of8e80vnQTUKzPbodm7NQ6R7tmNl1pcuMvdxj0YAuhz0Yoqp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(376002)(346002)(366004)(39860400002)(396003)(451199015)(8936002)(33716001)(2906002)(5660300002)(6486002)(66476007)(66556008)(9686003)(966005)(6666004)(6506007)(44832011)(38100700002)(4326008)(8676002)(66946007)(316002)(86362001)(26005)(53546011)(7416002)(186003)(41300700001)(6512007)(478600001)(83380400001)(99710200001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XHcpHCNQARvwc4fFQarGrr3xquy6/6bHpbteJUItxeSc5dMyTqizQeIepVTR?=
 =?us-ascii?Q?orq3n2GGC0bWClhkfV+zvP0P+lRNKgF16atOKpCtjZTUoMqa5eaYSiLqp3Ly?=
 =?us-ascii?Q?+VC9eWdnxgTTkzT0El2Omg3KjM/t32VMkk/By47TkLfNHDCV3Mhz7whIx1W5?=
 =?us-ascii?Q?bj8jIumMNv3lt+/E6c34PLtEjwFGrIfLYhCtFSPeSQWxiZuCg2yz54OcazTg?=
 =?us-ascii?Q?M7WTviwlG0ra0APJyrtmHbTIDzArkZOJ8c/phgulJjCgsp8qspk3OIL+/8F7?=
 =?us-ascii?Q?Gp8L77LUooVXP9kq20TQz1G6Ruqp5X4seJQA/X93FxpOPCu4Th+zYaP01t7o?=
 =?us-ascii?Q?R2kUx6KdasOYkm0fB0SC4vyoD5xHi/WqxSBxdmRWRnNim21sA5+cDsVykbjn?=
 =?us-ascii?Q?mvSK6waeWpi8ZRpVgLVen7Qe3tR0QBGKcp9moI3IJcxy5lQRkYV6pCTXtNEV?=
 =?us-ascii?Q?j2LE1+4wg8VYlMbgC08ciqaXCK3XqCoQ0wFBEjPRVUppa9f1AE+4B2VQmExv?=
 =?us-ascii?Q?tnppEdqChK0kyvDLqNRNvVCXGxbhKMfbFiu+ExxrC3/pAnUX2HI/zMplyBVp?=
 =?us-ascii?Q?pbiEvx+MnR/iVjd1VUBKK5GQh9SiaJQNinfMrE2wvR3wXhgzLL2aFiGbLWcq?=
 =?us-ascii?Q?xdU4aibJK9gZj/moLZWSB+NSfjInfle9onCzIcP5at30YUF7aSNXagBClZKz?=
 =?us-ascii?Q?sFrdWEdj/t1VTY2uLHNNyWBHuejDqOtJVK4GKWZv8YOL25hPZXf79u/MiEYb?=
 =?us-ascii?Q?ZWNn4vFUh3n78PhszzmiUv7ZrtXYPNcQ3OJ9nOR39jbEeW9UjhbDkASNfMN5?=
 =?us-ascii?Q?JizFo4S5mf0IG/qxdbcGT7GXxy8gG0EGJf1ek7poJ8K+ofKUQqTdZWrCyXsk?=
 =?us-ascii?Q?L3pX4MfAt8qxguTALQyhrOkx2WFLwvL33HzxFN9YTMAdhyGr+HDZgTwgdB4B?=
 =?us-ascii?Q?w6SGJpAQ2RUrteBWMEZ+3KNHjtkVy8F/jNbrgSbA6N6VDnjrRwvS+o02R3Zr?=
 =?us-ascii?Q?a0LJTf79RtG9wuvVcvcFFltLxMsZNGcBNs1uYrTRF37POennF0I/x/Fr8jzc?=
 =?us-ascii?Q?gnvzl0a27FS+2kR3bYUI0e2XONPPvD2+ikG39rOSs1ghO5xsd0Bc4W+tPUlJ?=
 =?us-ascii?Q?OQtpwtJBoI0bNzWv92WvmE+FUcX7fLLCR9c0PGuMdwGBxTd9zxjb5hbIwoka?=
 =?us-ascii?Q?lkR522QnwSAF5fvmGqxPkfgTM7Zs2h0k5mLB6OquMpArNScAuL4T5zI+D6mX?=
 =?us-ascii?Q?TQWvYcPgZVs8hLkS87vfq9fgLbT1R6Ci9+IbQ5L1mUcpYB/iXfVkfUglGX/Y?=
 =?us-ascii?Q?KWeQNf3G4BBy0kWNmZBf/MUyycN9EQBeA/ftq6TDwS+GXzg/ylSd3H0aR655?=
 =?us-ascii?Q?MyVta7Xa9k3afJsB2qliotsHQB7ykOoc7sO2JVCI87IlYacUboypguJUxk4f?=
 =?us-ascii?Q?tLsgmXj3MPZQCGse9Q+IgcpJjHPjmP3app5FLglkSF4330ckqggPOQifmByp?=
 =?us-ascii?Q?vMNSa4teslvTpHx0P0mEaYkQCEnm69Z5kOipYipWtlvsuv/qYj1jkeCFC12b?=
 =?us-ascii?Q?o+pjH/lrAJylc7j4yOSFc13gIEUFaZpusxHiEXZtK+2EYKzV5s/7zf5zgkOv?=
 =?us-ascii?Q?Vw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?80hwy9ZUuImJRpy/JIiluJAvLK8X6azr1LTTf2VqVac7kC81HH6qwm3xAtJM?=
 =?us-ascii?Q?3BQJrloVGD0Qx7ef/CFwGiqq4628Qyi+9ObRSKBNdLCdoVpij+sISOMxwB8K?=
 =?us-ascii?Q?qFCPruJkMyCIFtdLakWKA8Tf26GVM1rQtEHl1gzwImlO+3sb7AX+5u5E2AF0?=
 =?us-ascii?Q?9OT8kqe3zMyN3EO8Qgz5v5bgVNdjUPzdj8yOIV1Os8H41inl5hZE/7FfoaMY?=
 =?us-ascii?Q?6oXg3ydYaGbwiKEqIvCNaXqLC1OoXFsjxAUZSzM8ZhX2GWlj+0+cRhuoDc86?=
 =?us-ascii?Q?6tvFtTM2SCwwjKl3VnAI3RNWYVZ0VmcBJ/4aAwgLCy0AythKQKNZoF9h7e8w?=
 =?us-ascii?Q?9Ud9oSsOS83BGPdW3ToZMxcBeIuq7NrNsnCC8nV827skSbQLGxZHfJEPGR4k?=
 =?us-ascii?Q?xbbSJzOkN0T9RO7JzcM+JxarugOSCtlYcVNPyCztBOh7peWb5OXCMmii3SJC?=
 =?us-ascii?Q?UctBawv6BOYwUCyyIn8K2USx+bqXvZDKwb0ppIflSGAEXELJPK3ppTsBk5FV?=
 =?us-ascii?Q?h7GKm6UmKJ1pMOyNZRD/WGX8ZPqq68jPszw6n2ipwWDAldMHf36jPcBnRFv7?=
 =?us-ascii?Q?caqYTeWJ4OWD6Taqxsjy4ADakb2XnUNzBYLP+2NLLFuOjbdPpg4eSV8m0s1N?=
 =?us-ascii?Q?O1tYfpktZe35SPO8wcBj4gdvcJJLVSHarv3kZHfuflgeJoQnpdXHitQsDLKQ?=
 =?us-ascii?Q?2mN2WbrU6tv8oF4xAhfJw8pXh6E8e9jgwgFr3SmKEw4LElCHDTptHtlDYGVD?=
 =?us-ascii?Q?SoCv9oB59KK93w8SaU/CKdSvXyAV9Ce9vS9HJjQYUadtoOUyRg5X3aZp6NQd?=
 =?us-ascii?Q?jSXH7VgcOIGOuffyM/n3rvZWwbAQdcUo4zzL9eEpmp2MBgEUcbWhkhYuzupi?=
 =?us-ascii?Q?AsdDAzE5A9DXBl8Ozc4no4WPVsSvHI30WAMgRHOjMejuwYBUZ7jRv6dNa4fN?=
 =?us-ascii?Q?K5D+16Goc258WxLbq1BtYrORrSDyFvVrvIcpmFiRuDjJ2J9BrYM9YC9Q8UBZ?=
 =?us-ascii?Q?3ONkUPikFWS+8aNyhm7kMT71bbhAsLP7HrOzJ6VXVHU2CDjgH74Ac7mnD78n?=
 =?us-ascii?Q?eAwjh9b9jJoUyEU1caqJFXyQjPlPtPE4X/PWs9sg87J7o48paLXPyzefZBVq?=
 =?us-ascii?Q?aGFZtlmQBp7T3Vo+pGQMTRBVjbZSWFGEWA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b39383e4-c828-46a8-f545-08dac441e6e6
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2022 00:07:36.6236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3LJZyikefD1i69vzc9sERgM05AWJYDW7Oazz6y4CNo55CNv6OVHPNt+2ku0q1dcnHx/WrQ3n4Ui93Rbip+cJiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4819
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-11_11,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211110165
X-Proofpoint-GUID: beuORap3-fwzrZuYFI6W6zpOCrRmnGfq
X-Proofpoint-ORIG-GUID: beuORap3-fwzrZuYFI6W6zpOCrRmnGfq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/04/22 09:00, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    f2f32f8af2b0 Merge tag 'for-6.1-rc3-tag' of git://git.kern..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=137d52ca880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d080a4bd239918dd
> dashboard link: https://syzkaller.appspot.com/bug?extid=ca56f14c500045350f93
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: i386
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/b4f72e7a4c11/disk-f2f32f8a.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/3f88997ad7c9/vmlinux-f2f32f8a.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/b4b5b3963e2d/bzImage-f2f32f8a.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+ca56f14c500045350f93@syzkaller.appspotmail.com
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.1.0-rc3-syzkaller-00152-gf2f32f8af2b0 #0 Not tainted
> ------------------------------------------------------
> syz-executor.2/5665 is trying to acquire lock:
> ffff88801c74c298 (&mm->mmap_lock#2){++++}-{3:3}, at: __might_fault+0xa1/0x170 mm/memory.c:5645
> 
> but task is already holding lock:
> ffff88801c4f3078 (&vma_lock->rw_sema){++++}-{3:3}, at: hugetlb_vma_lock_read mm/hugetlb.c:6816 [inline]
> ffff88801c4f3078 (&vma_lock->rw_sema){++++}-{3:3}, at: hugetlb_fault+0x40a/0x2060 mm/hugetlb.c:5859
> 
> which lock already depends on the new lock.
> 
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #1 (&vma_lock->rw_sema){++++}-{3:3}:
>        down_write+0x90/0x220 kernel/locking/rwsem.c:1562
>        hugetlb_vma_lock_write mm/hugetlb.c:6834 [inline]
>        __unmap_hugepage_range_final+0x97/0x340 mm/hugetlb.c:5202
>        unmap_single_vma+0x23d/0x2a0 mm/memory.c:1690
>        unmap_vmas+0x21e/0x370 mm/memory.c:1733
>        exit_mmap+0x189/0x7a0 mm/mmap.c:3090
>        __mmput+0x128/0x4c0 kernel/fork.c:1185
>        mmput+0x5c/0x70 kernel/fork.c:1207
>        exit_mm kernel/exit.c:516 [inline]
>        do_exit+0xa39/0x2a20 kernel/exit.c:807
>        do_group_exit+0xd0/0x2a0 kernel/exit.c:950
>        get_signal+0x21a1/0x2430 kernel/signal.c:2858
>        arch_do_signal_or_restart+0x82/0x2300 arch/x86/kernel/signal.c:869
>        exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
>        exit_to_user_mode_prepare+0x15f/0x250 kernel/entry/common.c:203
>        __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
>        syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:296
>        __do_fast_syscall_32+0x72/0xf0 arch/x86/entry/common.c:181
>        do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:203
>        entry_SYSENTER_compat_after_hwframe+0x70/0x82
> 
> -> #0 (&mm->mmap_lock#2){++++}-{3:3}:
>        check_prev_add kernel/locking/lockdep.c:3097 [inline]
>        check_prevs_add kernel/locking/lockdep.c:3216 [inline]
>        validate_chain kernel/locking/lockdep.c:3831 [inline]
>        __lock_acquire+0x2a43/0x56d0 kernel/locking/lockdep.c:5055
>        lock_acquire kernel/locking/lockdep.c:5668 [inline]
>        lock_acquire+0x1df/0x630 kernel/locking/lockdep.c:5633
>        __might_fault mm/memory.c:5646 [inline]
>        __might_fault+0x104/0x170 mm/memory.c:5639
>        _copy_from_user+0x25/0x170 lib/usercopy.c:13
>        copy_from_user include/linux/uaccess.h:161 [inline]
>        snd_rawmidi_kernel_write1+0x366/0x880 sound/core/rawmidi.c:1549
>        snd_rawmidi_write+0x273/0xbb0 sound/core/rawmidi.c:1618
>        vfs_write+0x2d7/0xdd0 fs/read_write.c:582
>        ksys_write+0x1e8/0x250 fs/read_write.c:637
>        do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
>        __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
>        do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:203
>        entry_SYSENTER_compat_after_hwframe+0x70/0x82
> 
> other info that might help us debug this:
> 
>  Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(&vma_lock->rw_sema);
>                                lock(&mm->mmap_lock#2);
>                                lock(&vma_lock->rw_sema);
>   lock(&mm->mmap_lock#2);

I may not be reading the report correctly, but I can not see how we acquire the
hugetlb vma_lock before trying to acquire mmap_lock in stack 0.  We would not
acquire the vma_lock until we enter hugetlb fault processing (not in the stack).

Adding Miaohe Lin on Cc due to previous help with vma_lock potential deadlock
situations.  Miaohe, does this make sense to you?
-- 
Mike Kravetz

> 
> 
> 1 lock held by syz-executor.2/5665:
>  #0: ffff88801c4f3078 (&vma_lock->rw_sema){++++}-{3:3}, at: hugetlb_vma_lock_read mm/hugetlb.c:6816 [inline]
>  #0: ffff88801c4f3078 (&vma_lock->rw_sema){++++}-{3:3}, at: hugetlb_fault+0x40a/0x2060 mm/hugetlb.c:5859
> 
> stack backtrace:
> CPU: 1 PID: 5665 Comm: syz-executor.2 Not tainted 6.1.0-rc3-syzkaller-00152-gf2f32f8af2b0 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
>  check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2177
>  check_prev_add kernel/locking/lockdep.c:3097 [inline]
>  check_prevs_add kernel/locking/lockdep.c:3216 [inline]
>  validate_chain kernel/locking/lockdep.c:3831 [inline]
>  __lock_acquire+0x2a43/0x56d0 kernel/locking/lockdep.c:5055
>  lock_acquire kernel/locking/lockdep.c:5668 [inline]
>  lock_acquire+0x1df/0x630 kernel/locking/lockdep.c:5633
>  __might_fault mm/memory.c:5646 [inline]
>  __might_fault+0x104/0x170 mm/memory.c:5639
>  _copy_from_user+0x25/0x170 lib/usercopy.c:13
>  copy_from_user include/linux/uaccess.h:161 [inline]
>  snd_rawmidi_kernel_write1+0x366/0x880 sound/core/rawmidi.c:1549
>  snd_rawmidi_write+0x273/0xbb0 sound/core/rawmidi.c:1618
>  vfs_write+0x2d7/0xdd0 fs/read_write.c:582
>  ksys_write+0x1e8/0x250 fs/read_write.c:637
>  do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
>  __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
>  do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:203
>  entry_SYSENTER_compat_after_hwframe+0x70/0x82
> RIP: 0023:0xf7fad549
> Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
> RSP: 002b:00000000f7f875cc EFLAGS: 00000296 ORIG_RAX: 0000000000000004
> RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 0000000020000000
> RDX: 00000000c86ade39 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>  </TASK>
> ----------------
> Code disassembly (best guess):
>    0:	03 74 c0 01          	add    0x1(%rax,%rax,8),%esi
>    4:	10 05 03 74 b8 01    	adc    %al,0x1b87403(%rip)        # 0x1b8740d
>    a:	10 06                	adc    %al,(%rsi)
>    c:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
>   10:	10 07                	adc    %al,(%rdi)
>   12:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
>   16:	10 08                	adc    %cl,(%rax)
>   18:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
>   1c:	00 00                	add    %al,(%rax)
>   1e:	00 00                	add    %al,(%rax)
>   20:	00 51 52             	add    %dl,0x52(%rcx)
>   23:	55                   	push   %rbp
>   24:	89 e5                	mov    %esp,%ebp
>   26:	0f 34                	sysenter
>   28:	cd 80                	int    $0x80
> * 2a:	5d                   	pop    %rbp <-- trapping instruction
>   2b:	5a                   	pop    %rdx
>   2c:	59                   	pop    %rcx
>   2d:	c3                   	retq
>   2e:	90                   	nop
>   2f:	90                   	nop
>   30:	90                   	nop
>   31:	90                   	nop
>   32:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
>   39:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
