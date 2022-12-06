Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65787644CC2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 21:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiLFUAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 15:00:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiLFUAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 15:00:39 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB50840442
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 12:00:37 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B6IxFNp016855;
        Tue, 6 Dec 2022 19:58:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=mpDRYC0dDHvU2rsn8H7MTkW8jsFEZD6GTsUMsbFkFVA=;
 b=WIpr6beVLL+DT0ciLT0WdsWH9T/6pSHES+e1v9nYCWDBmGfgcMnvenKvl+OvaUAkqgXU
 pRa9XjNohJGURhfAnGZ57PL+lItSD/6MQP6lTBlBPwRQVnRPxaNCSn7Pe0bNi+5c0ofR
 ZKUbH8uroQBpuNn3Up2d0c/Qpteoncc0OD0NTxJpk41aFQXkQ7MTN55YgdRQjF08lkxG
 Ae0UYV13df/qtWkNYGOXDOXNvOhV4Km9z81lnLrFzBqEnCY9N7qMd3qt0YipM9350fCY
 8rdY6bQM7f0+gzA2/Ckr+McTm0iuLQTn3k45+oOJ4PXf7diulH1PQ2FAz6CjVTa1aHYy 9A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m7ydjh0e2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Dec 2022 19:58:16 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B6JM6EV033143;
        Tue, 6 Dec 2022 19:58:15 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3maa7ax2wq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Dec 2022 19:58:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AyzLyL0FB35CL630EmBGbU4Uu6f1qhCN1nNw0GwsA9JPSmSmYpduFMO2W1EjedIqqfx+YipJJuHSnv3eWIjpGNkZ8556h+RhK3FzdeKoGceTQHG2GwIBS6KpzdqXxOFixj9P3o4M7E0dcFPgVq5Dmm7I4it0jY3zyT0vNQAv4zcNG7in6ZpmLkVOgsLWV2e0AsAY+3Qw3JBDOIWmN70og2roVNdz2E8h0Tm2VVX35FQxBKC/I2KTOVS6Nqj2bm1l2j0JN6VDMeaOW6ZQDWLNl/4dMLTCqNt+D9FRzEhE6sI3h/cwzoInn89sQnCUconbccx/FzcvaBcxWJtIv0pnLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mpDRYC0dDHvU2rsn8H7MTkW8jsFEZD6GTsUMsbFkFVA=;
 b=gcYVoZx6Ag0xQL0u5H2ZT9NPEUbMO42lPCUXSkZ6xE3peFb1XxqfsNDkiifZZBnH2DlxWaWWBUxv+fltiIlBko1BpEIILiGB0fjMA7opdHroyBtJTfWIT0VKlzLWA3XVQ9tke7JIt5/tDE78+5WYsPBlzCDDkNQYWCE8BXB3PXAfPKqEQi/uGaeVwIhC/EovAMPCZ3Exi2rHDQmt3pGFgfO8KJQBOQ24o+/WQS6Ps2l0x+GhFFD4+ZdSO50i1TiJcKLV2/BSy4417cdgsKuU01eQfsf54J12PKhhQIyUUXeu028OPwi5g3HuJHJFlRWyJdFZsrCa5RJOnhIAkijcfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mpDRYC0dDHvU2rsn8H7MTkW8jsFEZD6GTsUMsbFkFVA=;
 b=EZwD/efERUhfrh55TVDnU9khoBd3URYN491vWTxHtnNKsW4+og2WoIzqMbvLd6nOq3hrqkJxh3aBI+rL99wYMAWi53UXhtqO3vLPKP3RmUMLwuxHaqs9T2Gh2VQsANklO2tNxJFvIlhajV/GGTQa72sC/LBq510dAy1LTKPSFoY=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BN0PR10MB4999.namprd10.prod.outlook.com (2603:10b6:408:129::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Tue, 6 Dec
 2022 19:58:13 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%4]) with mapi id 15.20.5880.014; Tue, 6 Dec 2022
 19:58:13 +0000
Date:   Tue, 6 Dec 2022 11:58:09 -0800
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
Subject: Re: [PATCH 09/10] mm/hugetlb: Make page_vma_mapped_walk() safe to
 pmd unshare
Message-ID: <Y4+e0ZO5TQQLpNrv@monkey>
References: <20221129193526.3588187-1-peterx@redhat.com>
 <20221129193526.3588187-10-peterx@redhat.com>
 <Y46EMlDLCThbrl+E@monkey>
 <Y493aNfcK7n7s1B1@monkey>
 <Y49+aYHTy/UwV7JQ@x1n>
 <Y49/MPNKib6eDfqk@x1n>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y49/MPNKib6eDfqk@x1n>
X-ClientProxiedBy: MW4PR03CA0057.namprd03.prod.outlook.com
 (2603:10b6:303:8e::32) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|BN0PR10MB4999:EE_
X-MS-Office365-Filtering-Correlation-Id: e8f3dd14-f368-47a1-dcd9-08dad7c43512
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: axXMwrKFBQvh1Z2UdZ2Jy0gM7//hg7F91pkwk0xEBAuw1hj/32OXoNzrtd6IgivkNI4wVOZSel1vesOZC0QWn+nw5W2nFFApJHJFMCLOwwlKrh0il1HELW0aa9GMws7WPff5NfkDVDGCsrEKYem0RB51v84FYVyro0w3WGC2W2XBsJ0eHagUBZeahWc7rMVyvO5W7VA+ugvwYHyF80ScE2LL3mzMoBINqyHnmy1yf5aVXB3sbaaRXDeLg9Fp6yRkA1sOJmbyS5fwGLtmyWAA1d+4XmNw/33sM+fURexqNVSVY9ji8/MoTQNRBMmCB5t/Hb5fi0NTg9W8zuH3CFL/Js554ZS3/XPe1/HCBLU1t8U6oTjCuMlFr0a4ylSRdexiT/yU7dFoYRDYc+/pGPgJ1OXNJPvBpjfELlN+36mfYKoZjPapLQcukEJ18LZRAV6eg2kl8ONzz0CjBDwebLweKdF0KnCiQv3CHyKJNEXbLxxAlJ+Q5e3UfckbXMIMDswU24h933+3TEqud3Nir+WsniaFQWgPflVq4i7PCCBHJnXVtwqxp7DF5SuOmrbD+GNbN2qfyzzyFmCJEoMq/U/PMqjNsBjL9d/SNkn7ZM/GjEBp52CosO3R5TfV3CkuV5chD7DRxqLvo+L0WRDUczep2Xm6mycmDIO67KPIdh6+fNUUrqHOcuyE7vpcu2zG0chc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(346002)(396003)(366004)(136003)(376002)(451199015)(38100700002)(83380400001)(7416002)(86362001)(44832011)(66946007)(8936002)(4326008)(41300700001)(66476007)(66556008)(8676002)(2906002)(478600001)(33716001)(5660300002)(186003)(9686003)(26005)(6512007)(6506007)(6666004)(53546011)(316002)(6916009)(54906003)(6486002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w/LCjproIQS504h9Wdq2IR0tk0GQnhhGwdJeHPOYVENQ45z2miZCLt1SMAQp?=
 =?us-ascii?Q?DSEdoexChD4nL2JoZskqphYiAsVTnL3SLqRUtm6tQ9+yC2kkFjqirxsbQage?=
 =?us-ascii?Q?cptURiNIPHcujX9a+n0uf4dLT/Hlsxi8c0JcYo2xL5WGO7wN5C2+T+YBOgyQ?=
 =?us-ascii?Q?TCYCsd8CULLZE6B9wp6Zfzg4gBYDWF3LRLcGTCvKAEj9KTjFbo8c8YVDKFC2?=
 =?us-ascii?Q?Csr7APPxP95l+Y4VFU94VXADs0ts3hLp78QH/bQhQd4kmKnWzH1lQlRLyKap?=
 =?us-ascii?Q?gskoyuz7MP/C2QIGSf/oTF+Q8RtVCpkLHkW46RlZhgE/AanBxyxYiG59Ys7C?=
 =?us-ascii?Q?5v0xwxeZTuXdzPOEuKQX081Gcm+kSDJcIEoIJ6yY7o5CxfGzbUnq5E86CEGu?=
 =?us-ascii?Q?q5eeSryHizXPpEm7P/bp7r+Mtu8vg2lR3bjYhQuCCIfk9KIrL2Gx0Wjgca3n?=
 =?us-ascii?Q?ondjUD1s0nemU7oeO+4MYGVBjt835YXKhaGjy3utW6dSJHmH2vjgs17Ttuqz?=
 =?us-ascii?Q?k8EfMAvg2L5pc6kVkbjNsPb12lgFW/aC0j7PEtrKVaN46DHW4lfUuBDvSZxe?=
 =?us-ascii?Q?jMghqZkcI7hJ4uaW7TgWUONoHYvNy8LURrDU2rOMch97b9Z7eWboI6ylbl2w?=
 =?us-ascii?Q?o37CvrktFvgpyrZKJKroB844pimwvUtVvbsUacxBSDBORWT6QZ/xiW0sITUk?=
 =?us-ascii?Q?C9TjPubSMFcDIuaZcfUim5cKENXu7kB79rsFK0eEBT5RBzq0v8JMWyP1K/fA?=
 =?us-ascii?Q?BSEjPDpB2Crx3pDQv94SLZOfyDVXhkUm0fDvucqD2bNHxMGodu3Ar3ogq7ct?=
 =?us-ascii?Q?BaKcziYBw5UcsKApNNHJIPZxMJxIFAvbs9ovWRvwM5xdnt7s7R0FXyHElccU?=
 =?us-ascii?Q?IqFlcfXTNephih+qbjJB83jxbCJg0fTqRQbYvS9HQ3NWQAL7zvcs167Wsihb?=
 =?us-ascii?Q?Bk+B7lZdIfWzyiEtykqsaXdgK0jqcisizf29lrBPsLMvUKtQjVRDlnFP29Az?=
 =?us-ascii?Q?NfH5hvrSXTnu0h6GkG7HFrzX1I6Vk4KMonFeo6ls91C4+oFDC6pQeStEJhtD?=
 =?us-ascii?Q?ybm3sC3M3rMZj8oJFiXCQl4Mz08o5EpMaiPEQ3DVy43ctTsqCOiOZV2XUjqY?=
 =?us-ascii?Q?ld8rwszlxB0x9BGmcYyNcugEzpYV10b86cOAQLYQuftVIo16H5wCGtS8ZysQ?=
 =?us-ascii?Q?7cm1+ROgUTQOsR2U3G+mhTa2lslRbvyebXhj9y7W8SeOTKd6GV7kwf/xEr1R?=
 =?us-ascii?Q?a/HeN+zMdMuyV8VC9r6uC3GKKHmuz6D4ykR11rJTFO8nb4uMze+d6pKiDYOl?=
 =?us-ascii?Q?771YD9pE1zWu5nC20UCWIAYmWcK5RgynTvdCfc3COwFvWS6Z1PnLRlPy43Ou?=
 =?us-ascii?Q?ba78xY0OitvDPhlMAZH7LuSvUZZ1CxbStYphAHq9ffX4X0Vcg5jI9yeWWV/7?=
 =?us-ascii?Q?2QlJSLKcNq5SviM1oj2dhngwH/VlEUJ5hjT74YFhfZa9B3Zihu4Qcf1lHhxJ?=
 =?us-ascii?Q?9yBKgnRINyVop141w3vaqMY10KdtsPK7YavyMNJsBETFXfYrPCu2I9SdqNVN?=
 =?us-ascii?Q?/A30pfkpToN0QIEs2u+sIy9Yts+4gTE6tmGfCcjFCX8V3X3npevAEzX8QEHr?=
 =?us-ascii?Q?+A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?KsF08mRPfpWVP/6wpcSQ4d0PGl/puEm8sY0HDcIpYEojjuqBJP31PZx2lYEB?=
 =?us-ascii?Q?hBTkMRNFHME+gmV8CEX7o14h/eXvDjh0di0jiAnvWY0pJoOiUV9BukOwerwP?=
 =?us-ascii?Q?nIg6ad0NrrNzyapWLOp747pUYAhQ8U09C034VZrVrHQHuspi2bdG7klMAiru?=
 =?us-ascii?Q?gNpqQlW/kdw2ppNq8pIi/R5uYF4ZyDSwuPsL0pq8YmcCJ++h5WlMSRNjulkd?=
 =?us-ascii?Q?ioc4CgguxHMRDAT7issWK1/y328/5syW/AD9Wq+U4Qq2zjKLyCqckKy1XROl?=
 =?us-ascii?Q?9ADC7z+alpMBclHhvaFBPW148dbSb4tbs2+k167Brp3I2kdMFtf9p0xUpeEM?=
 =?us-ascii?Q?mC+eUY042hcR+dck7qNhs59Hqzc3Bkcb6GY+2qxS5tAnp0A+QFaGXWdqrwtn?=
 =?us-ascii?Q?VWf/iHCNRmV1TSknhEUfmVTF7XUe2xklEVXSzeJYX50hfVeU/obsjF2D2xH9?=
 =?us-ascii?Q?C1nUEZ++WzAYJgQ8ZyiWY4HnODQ/aiIgZ0CGCMJ802Tp6QbUT1LaVDO7ZlgS?=
 =?us-ascii?Q?8z+kRdi2IE3oVg8Wytqk+r1CyMAmDx1EZOhESrHl5Fm7K7mWWWsuZ9P1RYjz?=
 =?us-ascii?Q?GKHA7pYRxYHYKUre2+vAnFh02zfZT71a6ceTeqoLz8ohJULpgvwYx/pkZqIx?=
 =?us-ascii?Q?jKYspJ0Dlej6bTcjPwXEXL0P+wHJOo7eNJjmAbF1Sif2BdMxBnBD2KqX72Iv?=
 =?us-ascii?Q?AvU3ftuP0RgrCKc0kE/lokoXpjJUSis2NmJuV1HnEgNqMByvEhHJddME4z+p?=
 =?us-ascii?Q?wbuE4DVT0Ph5pUAKvV3jqBt0KGnn0oQihtWOMgKmgtEnOps7VZHo77iwkmB/?=
 =?us-ascii?Q?Vebq8+DtnerXHAs4GxNK5oclfIa9a56vlwhVPWJCY8E857neeXBGVHIr5SSd?=
 =?us-ascii?Q?oqkUBZP0GgbpYIqOVbqG0JakrjjYyXsUTp0jFt+r2zha5I/rgXdPYAgjxz62?=
 =?us-ascii?Q?ha4EXb51t4E+w/YdJtwSl+xwgwl8/AjvsoGLqUJNYUjualwPqHpUFAI4PePR?=
 =?us-ascii?Q?hprob4qrNq2WQ+Vjk0RXrh8+bk04axxITW9sU7xFDRIlNBNECTBQiuOk9mdA?=
 =?us-ascii?Q?kp9KnV4u2jPtUslDCa7RESWfZk6XHg4jNzmuJLUvhWfa6GNmPWM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8f3dd14-f368-47a1-dcd9-08dad7c43512
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2022 19:58:13.2836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jblkO0m5oDWhn28jsAI9GbsH+rYFn0aJlNJ5I4gWEExgNWUR2ZVxSITbeV+bGsdoYHJJPuqf2BjX7YMHAQxwJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4999
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-06_11,2022-12-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212060167
X-Proofpoint-ORIG-GUID: -nYCc-zUbl2tbR68-exxfMp30NhFEVGe
X-Proofpoint-GUID: -nYCc-zUbl2tbR68-exxfMp30NhFEVGe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/22 12:43, Peter Xu wrote:
> On Tue, Dec 06, 2022 at 12:39:53PM -0500, Peter Xu wrote:
> > On Tue, Dec 06, 2022 at 09:10:00AM -0800, Mike Kravetz wrote:
> > > On 12/05/22 15:52, Mike Kravetz wrote:
> > > > On 11/29/22 14:35, Peter Xu wrote:
> > > > > Since page_vma_mapped_walk() walks the pgtable, it needs the vma lock
> > > > > to make sure the pgtable page will not be freed concurrently.
> > > > > 
> > > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > > > ---
> > > > >  include/linux/rmap.h | 4 ++++
> > > > >  mm/page_vma_mapped.c | 5 ++++-
> > > > >  2 files changed, 8 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> > > > > index bd3504d11b15..a50d18bb86aa 100644
> > > > > --- a/include/linux/rmap.h
> > > > > +++ b/include/linux/rmap.h
> > > > > @@ -13,6 +13,7 @@
> > > > >  #include <linux/highmem.h>
> > > > >  #include <linux/pagemap.h>
> > > > >  #include <linux/memremap.h>
> > > > > +#include <linux/hugetlb.h>
> > > > >  
> > > > >  /*
> > > > >   * The anon_vma heads a list of private "related" vmas, to scan if
> > > > > @@ -408,6 +409,9 @@ static inline void page_vma_mapped_walk_done(struct page_vma_mapped_walk *pvmw)
> > > > >  		pte_unmap(pvmw->pte);
> > > > >  	if (pvmw->ptl)
> > > > >  		spin_unlock(pvmw->ptl);
> > > > > +	/* This needs to be after unlock of the spinlock */
> > > > > +	if (is_vm_hugetlb_page(pvmw->vma))
> > > > > +		hugetlb_vma_unlock_read(pvmw->vma);
> > > > >  }
> > > > >  
> > > > >  bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw);
> > > > > diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> > > > > index 93e13fc17d3c..f94ec78b54ff 100644
> > > > > --- a/mm/page_vma_mapped.c
> > > > > +++ b/mm/page_vma_mapped.c
> > > > > @@ -169,10 +169,13 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
> > > > >  		if (pvmw->pte)
> > > > >  			return not_found(pvmw);
> > > > >  
> > > > > +		hugetlb_vma_lock_read(vma);
> > > > >  		/* when pud is not present, pte will be NULL */
> > > > >  		pvmw->pte = huge_pte_offset(mm, pvmw->address, size);
> > > > > -		if (!pvmw->pte)
> > > > > +		if (!pvmw->pte) {
> > > > > +			hugetlb_vma_unlock_read(vma);
> > > > >  			return false;
> > > > > +		}
> > > > >  
> > > > >  		pvmw->ptl = huge_pte_lock(hstate, mm, pvmw->pte);
> > > > >  		if (!check_pte(pvmw))
> > > > 
> > > > I think this is going to cause try_to_unmap() to always fail for hugetlb
> > > > shared pages.  See try_to_unmap_one:
> > > > 
> > > > 	while (page_vma_mapped_walk(&pvmw)) {
> > > > 		...
> > > > 		if (folio_test_hugetlb(folio)) {
> > > > 			...
> > > > 			/*
> > > >                          * To call huge_pmd_unshare, i_mmap_rwsem must be
> > > >                          * held in write mode.  Caller needs to explicitly
> > > >                          * do this outside rmap routines.
> > > >                          *
> > > >                          * We also must hold hugetlb vma_lock in write mode.
> > > >                          * Lock order dictates acquiring vma_lock BEFORE
> > > >                          * i_mmap_rwsem.  We can only try lock here and fail
> > > >                          * if unsuccessful.
> > > >                          */
> > > >                         if (!anon) {
> > > >                                 VM_BUG_ON(!(flags & TTU_RMAP_LOCKED));
> > > >                                 if (!hugetlb_vma_trylock_write(vma)) {
> > > >                                         page_vma_mapped_walk_done(&pvmw);
> > > >                                         ret = false;
> > > > 				}
> > > > 
> > > > 
> > > > Can not think of a great solution right now.
> > > 
> > > Thought of this last night ...
> > > 
> > > Perhaps we do not need vma_lock in this code path (not sure about all
> > > page_vma_mapped_walk calls).  Why?  We already hold i_mmap_rwsem.
> > 
> > Exactly.  The only concern is when it's not in a rmap.
> > 
> > I'm actually preparing something that adds a new flag to PVMW, like:
> > 
> > #define PVMW_HUGETLB_NEEDS_LOCK	(1 << 2)
> > 
> > But maybe we don't need that at all, since I had a closer look the only
> > outliers of not using a rmap is:
> > 
> > __replace_page
> > write_protect_page
> > 
> > I'm pretty sure ksm doesn't have hugetlb involved, then the other one is
> > uprobe (uprobe_write_opcode).  I think it's the same.  If it's true, we can
> > simply drop this patch.  Then we also have hugetlb_walk and the lock checks
> > there guarantee that we're safe anyways.
> > 
> > Potentially we can document this fact, which I also attached a comment
> > patch just for it to be appended to the end of the patchset.
> > 
> > Mike, let me know what do you think.
> > 
> > Andrew, if this patch to be dropped then the last patch may not cleanly
> > apply.  Let me know if you want a full repost of the things.
> 
> The document patch that can be appended to the end of this series attached.
> I referenced hugetlb_walk() so it needs to be the last patch.
> 
> -- 
> Peter Xu

Agree with dropping this patch and adding the document patch below.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

Also, happy we have the warnings in place to catch incorrect locking.
-- 
Mike Kravetz

> From 754c2180804e9e86accf131573cbd956b8c62829 Mon Sep 17 00:00:00 2001
> From: Peter Xu <peterx@redhat.com>
> Date: Tue, 6 Dec 2022 12:36:04 -0500
> Subject: [PATCH] mm/hugetlb: Document why page_vma_mapped_walk() is safe to
>  walk
> Content-type: text/plain
> 
> Taking vma lock here is not needed for now because all potential hugetlb
> walkers here should have i_mmap_rwsem held.  Document the fact.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  mm/page_vma_mapped.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> index e97b2e23bd28..2e59a0419d22 100644
> --- a/mm/page_vma_mapped.c
> +++ b/mm/page_vma_mapped.c
> @@ -168,8 +168,14 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>  		/* The only possible mapping was handled on last iteration */
>  		if (pvmw->pte)
>  			return not_found(pvmw);
> -
> -		/* when pud is not present, pte will be NULL */
> +		/*
> +		 * NOTE: we don't need explicit lock here to walk the
> +		 * hugetlb pgtable because either (1) potential callers of
> +		 * hugetlb pvmw currently holds i_mmap_rwsem, or (2) the
> +		 * caller will not walk a hugetlb vma (e.g. ksm or uprobe).
> +		 * When one day this rule breaks, one will get a warning
> +		 * in hugetlb_walk(), and then we'll figure out what to do.
> +		 */
>  		pvmw->pte = hugetlb_walk(vma, pvmw->address, size);
>  		if (!pvmw->pte)
>  			return false;
> -- 
> 2.37.3
> 
