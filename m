Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E07705B08
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 01:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjEPXNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 19:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjEPXNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 19:13:16 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6783849CC;
        Tue, 16 May 2023 16:13:15 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GJx1R4021201;
        Tue, 16 May 2023 23:12:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=q7RwmTbLtVTYX2WfAVyhUAt+nc1wrAaadL+Yux1FGqM=;
 b=rctqsm/Wrar/rFHd+4PlRbou17Qo7b0rJLMCkPcdRdfbIOS0QTYgWAJbx/539MsdXayt
 TKm9kvTjJJBx4i15P/eAjHv/7reRS8FUJ+UB6rX882yHBGKTgj4IiNHik3P6O/GfauEB
 11GegEDMo063IfX+pipqvB4oDiwUGnwLBhnbtgqRtyQ4fQgGnJRyh819PH0Pkog4L8YU
 KnNhLeU0FMLx7TjQvHStOV8mKT5gueNBHpwrB6btmL9kfi2LCK4Y2KrDzsvUAbgmRAoj
 xzygE5RGdlmmR28MWOiYLBYol4fjykr9UjK5OmWvr9gXD7P/j3H05V6Rdjma5/UpFoAg DQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj0ye4972-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 May 2023 23:12:47 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34GN5ddg039975;
        Tue, 16 May 2023 23:12:46 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj104faep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 May 2023 23:12:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HUVMxUmdnD1U754guhJGWrtr11X2/0YjherrRcPV/xvNLFDl8YATJRIlsp23yKHyIws5aWKUvuT+CroW5HwdE50QMjDeIGGesA7yS0MkRGYOZ0vSUiWE8FN/GBTztuF3xhiaAi8vCi3TZlD/U+rDCXfTQhPKoZphaIuIMmdSdS/ziRSpRzDNYZloVRsmGV7D8q68O0VVpUYgt8+Y+3hIxEaYXXAcaXzTIFJZE5EuMBTqcqxuhzrVE8g8o7a8u3e6iRhf0Fc7Cy7Cw8TmVXKpVYQucEwcUangmr5TrdkeIkB66uKmOPfMPpkktrdAnHSGXDzVny2jXVs8FVjosB5JVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q7RwmTbLtVTYX2WfAVyhUAt+nc1wrAaadL+Yux1FGqM=;
 b=M6NxnK6fFpDeL5z/cr2667TWKfsmCB3NjaXpvQSvvVA+VQ4k7nEW1Auu4vwPoqCzw1WeZ0FWQts5OHvtzzoO1vnzt3OcNIdEFCrtEd1MHdzc3QvzyNHVJJSPlVc30rCjDxvhM5zpKLDRXK79xACKF6X6ba4nKrO7I5y5KGab4FdV2RZDQ9xBNOaS20EaoWw+QGU/WJhiSs5o7Epy8W7pdhW00dXXYbMl4/dahvDphiX2/6QDlpoqnVRG96TkZilii1wazhfn2UVs1wsKYcZgihUxwm3L4YVSaibA0Z3htTeH3cELOzKIRnHRMTFKGafzuu0Q0McMxBm3r27tFigTVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7RwmTbLtVTYX2WfAVyhUAt+nc1wrAaadL+Yux1FGqM=;
 b=NRg8v3/+Ue0V8/V7we4sbNNA/jyTEswpKP93tyvSHr/C8rPCgcdvzLps3SmCpif9YiLedtGHvQeIVNi5wKal9+FbuG61knHAwmi60nXrdvDXUbo46xGlDNAAqBW8/wiYpXpNysFUzmZ421mTfGgEribFdABu590gMhZrLo4Qgo4=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SA1PR10MB6591.namprd10.prod.outlook.com (2603:10b6:806:2bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 23:12:44 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::ffb:de39:b76b:52eb]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::ffb:de39:b76b:52eb%3]) with mapi id 15.20.6387.032; Tue, 16 May 2023
 23:12:42 +0000
Date:   Tue, 16 May 2023 16:12:39 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        willy@infradead.org, ackerleytng@google.com, vannapurve@google.com,
        erdemaktas@google.com, stable@vger.kernel.org
Subject: Re: [PATCH] mm/hugetlb: revert use of page_cache_next_miss()
Message-ID: <20230516231239.GC30624@monkey>
References: <20230504233858.103068-1-mike.kravetz@oracle.com>
 <20230505185301.534259-1-sidhartha.kumar@oracle.com>
 <20230505215806.GA3497@monkey>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230505215806.GA3497@monkey>
X-ClientProxiedBy: MW4PR04CA0037.namprd04.prod.outlook.com
 (2603:10b6:303:6a::12) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SA1PR10MB6591:EE_
X-MS-Office365-Filtering-Correlation-Id: 15399bb3-abeb-4912-32c2-08db56630d09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ABnCp3V5WTC+nS3IFkYvNZhmUdrwE7OZ2NycTGVtGavaf7DNJvaS8WYT8Td1VO/Br1OETrJIuUuWHiJw0V6NOxCnHqa6em70L+LSwaJmYvg8UQ9O1NZ9vdoFVAXYKEgA5CHsy/Pkd3ccqnLjDkpfYV+1QTCpxcA164+DZATr+ZzL9nNwAEbLhjUIZsBqp4oew7fi2bMY9Wti7Cj6ustnpz6OhRqKN4y/FB4a1Erc8DCnZpZCVZ2J4uHopWDfBDJsrzvWDVGhYGX1Bza68LIVfhdH7mx2oHQ5u+THJifFIlHqkL2rvo0rlJDJfutKPN7MoV1v7IXY8YsdOe3moVww56be6+xQPWpgY2gn2EIjV0s61lJpeVNF4qH1EP48qu5oXjKEfWiUbdclDPLEFw2dLwsE5dmIWcRYVv5TUbnCxZiSKNo9I2fKrHqlDLX1Z2H6P86PdlR1SwbAbY6sdJFyTbGoSeXk9wArjEh4dTvRGoO5f9qGW9BPTExQuUjkkVFp3CbAjWus993GkoBvjNjwUnERjtZqD6SOibOwIgmVh29PPTnAPlJP8g3mmUD5OSSzw/T5jSCpn21qHZVdHPmAAa0002hy3nRvfY58O2Cut+s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(396003)(366004)(136003)(346002)(376002)(451199021)(478600001)(26005)(9686003)(53546011)(6506007)(6512007)(1076003)(6486002)(966005)(66556008)(66946007)(38100700002)(6636002)(4326008)(6666004)(66476007)(41300700001)(316002)(86362001)(2906002)(83380400001)(8936002)(6862004)(8676002)(44832011)(33656002)(5660300002)(33716001)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MZri2/XMFpJqqAnGMSXhW5yka1EX0AbPCKNa7ANuP747puUSONmnO4h/sASB?=
 =?us-ascii?Q?vsRxx350J18GhXgWwZ1DH4d8edkDm6HBygVVatWBa1CCY0Gilh+7EVPW2kSm?=
 =?us-ascii?Q?fE8lnuNWaxld5C+9inawsmlNjUhR6BPtz/CVrv18k4iSpNLTs2YOcdHPtF6t?=
 =?us-ascii?Q?6EDFC3MTxgIhqWbFgSi+AYU82vdWsAodjcZsfigFVA8cNnJCA60mzMUkFlFH?=
 =?us-ascii?Q?6qqDHVzAOu1Grv19x/D7PTX2FZ3k36hDlHXVxhOYH0U3hJ7vILFEqyqcApWO?=
 =?us-ascii?Q?gz1118BmHIN0Zbvyi3Xn0IFe+chVpN3JQ2AVYULt4eMtFzkxQri6yXcqXIoo?=
 =?us-ascii?Q?IqQcOAeXMhav4d77m6D3s23nuWEHQ59wvZd4V8kUvDiJGCJzp0/jh57LNAPn?=
 =?us-ascii?Q?3kGqWBQFLpYcAFUAf/v3PUPsgmGVnzoi+PnwBnCngdSPf68IbdaURQGf3cHy?=
 =?us-ascii?Q?sP2onc3FJdMVNcw6r8s54zZcVJ8rBqa+eDYdCFNuWoA76pQKLqLNnGY+Gyo0?=
 =?us-ascii?Q?re03IsBaNWG1mClWXD3kWoONSEYNwnZKH+U8SA1fyKRhkBjwTsMQ0FLmUrbG?=
 =?us-ascii?Q?Jycpv3dQPaKivsWVGf+gy6zTWPmG6s0qOlmCJlzkqxkPSS2b9mOuVMOkSn6H?=
 =?us-ascii?Q?5unIs9ULe4/CPbobfLJCXo+N3nvSYY5+4xVjTDXTcFOqkdWUGu7y1AiYj/XC?=
 =?us-ascii?Q?JpCB1b8XOkBVj+XmkQSD65sMwzjMWF2I8ZZBAjrf7v56PzLvNtMiXm1UTDLY?=
 =?us-ascii?Q?oGwhN23urPKn1kQvmZqH8YlelPiRnoTYs4nMeKcIK0zo9T5tW/ACAx8sMZFY?=
 =?us-ascii?Q?MVFKp4O7jcv1m1NuBxECkdKNzf8ZEVvO7wWS531tpFeBPCA82PFgN0cWrRcn?=
 =?us-ascii?Q?FyIHJbrijjmzluCyJHoPXRfuC7XhOgXVt2MFaHqCS2C+LB9sz+qzM3C+nzxH?=
 =?us-ascii?Q?bEZpt0JZ6dtYOit0AtJeR1CPR4XBFeDUsQrLc6kTr0Z3mea561LDy7EEI+LV?=
 =?us-ascii?Q?7wlJaeepkL7xOcDt0HKEc1bncdFc794rhtJPus/+saCd+zqRf++UlDb5rZ3f?=
 =?us-ascii?Q?dAfHkbshejI/bUbF4+3jd1LtF4h6tRNtqZ4/Wq4IsiDTdLoUJMhhlln+qNGt?=
 =?us-ascii?Q?BDH7N7EWxE+cuBhxmocp7srekhwrp5dZLu1+aw0ocE/r5u9Yu8W+VcFjePUw?=
 =?us-ascii?Q?xKxMbHphm9eDjkznWPkx1cgHCzge5bZyViV9YVTjd0K2PIwH6NWaeRl5Dape?=
 =?us-ascii?Q?HsIXmurlHfJfjI/voiYKE6PQi8cGkd/7sF2I8wG/alf+l0Mlj9F/UdJVsJZ4?=
 =?us-ascii?Q?MwJsDrwiWT4AGnv1ks2zP6zU1GUmyJdXmeLvUAAnoiqgXXPFwS0EyNvL5177?=
 =?us-ascii?Q?MbFLKlpcestdzQF0DYjuOM5K/u6Jx4KdeCIRwCalV3awQ75i18w5tq686klj?=
 =?us-ascii?Q?3PH1LUqwbGCS96xjaAN94C9uXHjhFontQmoRomXFDUwTUSy76J+Aqbb+A0w3?=
 =?us-ascii?Q?XXptp66mxnZnORXNsUHI/VPtT8Ik/Ccr0HC5VWT5pgjt6r5GMWBy8IHSdxRp?=
 =?us-ascii?Q?e5ixo3j4woGWzMrCZljj5DrXamnOeSGpGLmON/Rx?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?wD8rYG2GW2neBp21dFd6BfPlHbwwFS41OJuf+/Iibij//nbkZj7nuMagoYZ4?=
 =?us-ascii?Q?5Te6cyX2FmOYwrqDPbMnFI0Td5QJBD2cM3RQYK3Kv1jTLMmJj6rnzrNekO5X?=
 =?us-ascii?Q?zKpKPPAI1q+gHzS71KJV1/TgiXrGB9eLgYnexakWDzGnLfmqizrsbHxcH/RN?=
 =?us-ascii?Q?yhq5TO03D5KzR/wnwq7HFfbDg+Ssl1Y79iatvWXQVrXGPeSGXTXqedyWdgbJ?=
 =?us-ascii?Q?LULGpmlgJzgbzEpgFlWsdt0ZzczthLJpiEdBPn3IxSALUT12mNXLhPyHYtQu?=
 =?us-ascii?Q?6VElfvJbOsgxSTXKqkUlEfk0QpEn4+8BFj2d+yKfHYdPwe9odg79RE0ppXu3?=
 =?us-ascii?Q?aTH9nIX9cGsc/it1qCQpYNxl5X/2jyCY/Gt6dY6yobkpITaZNao00qgV0dIL?=
 =?us-ascii?Q?Gbw+NoKUmZwllOEaEseIplxlznxMNUmiAXcd6TK5D18ehCc2n0jnGkvSn3Xm?=
 =?us-ascii?Q?bB325b7/a1OpVurBGCnsC2cKCWVPGHcJmTamSai6OGovFMwgVjzj5NEOgKXZ?=
 =?us-ascii?Q?qJmLfzJbEQnWwsy/ZcoB1KtkQqvulo7Oq6UldPblApfagTa/G1fQdwx67pN8?=
 =?us-ascii?Q?YjI45JBcHAq5/DPGpDSED3psnw7OpXhGeFAxEQQ9+1tXe8VdMt9+/2IKhK6q?=
 =?us-ascii?Q?o7sVZUkrRg15jCtVBNHIyK/QtOJNgJLr6+bWViPLN8LVfQhlBJPvynwZlOcq?=
 =?us-ascii?Q?tvkL5X/16XRLSFUX5+Hc6tNo8UjIUd4UAJ8885OKpWXJ77dwliMiRg88P/6R?=
 =?us-ascii?Q?KmX4Zy7BhyoiIpcWuuCQBGvgW3lClzjroPYXyNFybj02H7cTD4P7FYycQBlp?=
 =?us-ascii?Q?C1PWFXqucFPIDWFf/vlj1LSKwvSLPyurFXeOHNvtntrTsE06N8HgnfKHLdAC?=
 =?us-ascii?Q?UkJH8tjBtlAjkTjs1p5KCreoNIoza8GkojYh8Qf4XYGC31BIjJRwl7+207QM?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15399bb3-abeb-4912-32c2-08db56630d09
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 23:12:42.5625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jm+tjbzumOszjws8IG0RzgliIBwAregMCKtNQEWOHHBpALmxe9Y247IY2mAiM2zNLq+VpIO/Y8jQa3mRC90Jlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6591
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_12,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305160196
X-Proofpoint-ORIG-GUID: TauzLtfnzuv7N9F5Pa_r6da_-Lj5mJg5
X-Proofpoint-GUID: TauzLtfnzuv7N9F5Pa_r6da_-Lj5mJg5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05/23 14:58, Mike Kravetz wrote:
> On 05/05/23 11:53, Sidhartha Kumar wrote:
> > As reported by Ackerley[1], the use of page_cache_next_miss() in
> > hugetlbfs_fallocate() introduces a bug where a second fallocate() call to
> > same offset fails with -EEXIST. Revert this change and go back to the
> > previous method of using get from the page cache and then dropping the
> > reference on success.
> > 
> > hugetlbfs_pagecache_present() was also refactored to use
> > page_cache_next_miss(), revert the usage there as well.
> > 
> > User visible impacts include hugetlb fallocate incorrectly returning
> > EEXIST if pages are already present in the file. In addition, hugetlb
> > pages will not be included in core dumps if they need to be brought in via
> > GUP. userfaultfd UFFDIO_COPY also uses this code and will not notice pages
> > already present in the cache. It may try to allocate a new page and
> > potentially return ENOMEM as opposed to EEXIST.
> > 
> > Fixes: d0ce0e47b323 ("mm/hugetlb: convert hugetlb fault paths to use alloc_hugetlb_folio()")
> 
> Small nit and a question for people more familiar with stable backports.
> 
> d0ce0e47b323 added the usage of page_cache_next_miss to hugetlb fallocate.
> 91a2fb956ad99 added the usage to hugetlbfs_pagecache_present.  Both are
> in v6.3 and d0ce0e47b323 (referenced here) comes later.  So, I 'think' it
> is OK to fix both instances with a single patch and reference the commit
> where both are present.  Or, should there be two patches which is more
> technically correct?
> 
> > Cc: <stable@vger.kernel.org> #v6.3+
> > Reported-by: Ackerley Tng <ackerleytng@google.com>
> > Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> > 
> > [1] https://lore.kernel.org/linux-mm/cover.1683069252.git.ackerleytng@google.com/
> > ---
> > This patch is meant to fix stable v6.3.1 as safe as possible by doing a
> > simple revert.
> > 
> > Patch page cache: fix page_cache_next/prev_miss off by one by Mike is a
> > potential fix that will allow the use of page_cache_next_miss() and is
> > awaiting review.
> > 
> > Patch Fix fallocate error in hugetlbfs when fallocating again by Ackerley
> > is another fix but introduces a new function and is also awaiting review.
> > 
> >  fs/hugetlbfs/inode.c |  8 +++-----
> >  mm/hugetlb.c         | 11 +++++------
> >  2 files changed, 8 insertions(+), 11 deletions(-)
> 
> IMO, this is safest and simplest way of fixing v6.3.  My proposed changes to
> page_cache_next/prev_miss have the potential to impact readahead, so really
> need review/testing by someone more familiar with that.  If a fix is
> urgently needed, I would suggest using this for backport and then either
> use my patch or expand Ackerley's proposal to move forward.
> 
> As a backport to stable,
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> -- 
> Mike Kravetz

Any objection to using this patch to fix v6.3 while we decide what is the best
way to move forward?

-- 
Mike Kravetz
