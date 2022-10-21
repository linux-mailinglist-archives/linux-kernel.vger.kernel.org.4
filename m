Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9233B6080D3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 23:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiJUVgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 17:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiJUVgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 17:36:08 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5367421E128;
        Fri, 21 Oct 2022 14:36:02 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29LLDm1l030309;
        Fri, 21 Oct 2022 21:35:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=GWtut6AgBn4JCkr+Qj3k38QHcrKLHhENj+OqcJno3e8=;
 b=tehZUHPL+TjmQJ3E31buodH72i0NmV+OBaSjv6URW1ckAGzsy9hNt90pK/yf6TERtjiB
 /hqwQxi/OVaB+k0XHfhPvbhELidqlgS8V2KpLP0/FWeQfkATDaktxJCpFP6EKfKACiZL
 EPS7HhQWyu99CeHEskjnJ4MDwomSC/1gSEoNdFb9YysAg09403rt/IGlsQY8JVuvdT1i
 WAEIdVjGx/UHEjTm6jufEbOY8v9pXQWTfO35putEMr0Xw9s51A4JDY6v6E4QIIJovUbH
 kITEF/hUdIQ06EazorNNVMCRnTOGLx5yGqzwqQuR9AeRD4jc/nx/IAEBzeqlN6MDY1om gg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k7mw3t443-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Oct 2022 21:35:53 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29LIPR1F017086;
        Fri, 21 Oct 2022 21:35:53 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2047.outbound.protection.outlook.com [104.47.57.47])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hub7j1t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Oct 2022 21:35:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZAofFIwNFpsXSuArZ2IlNmDCX4kvI8U9AP676rb7ocd2vRG5afEpO8Ww6cKtca2Akhl8qhZAyESw3GK2jfHVclFgzJi/MCD4vMNO9p4eyxAZpVgQ2aRT9Mp5HEGR0K/oy7aPATbDpiuIU8Vi98TCx/3osFSZVoxMDgmMd1ovrRp+leTOWeQJpiJGArgYgvZnrCsCCk/4T+3ZueSWZ2Z+EB514AKn9JzS4BaYtiRQdca0mD2w99h598O4JJgVldQkVRAL+AW5B46D4nIrdDYgAiziH+H9zwvvOqUGT/quh6/XcMDUJRwZqmtGQHtMbRTLcvg1ihSZ9xEn4BXDzkHIQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GWtut6AgBn4JCkr+Qj3k38QHcrKLHhENj+OqcJno3e8=;
 b=PyQkXODuAOZuTYGcVpu6morgj9oA6AF/SZWeHMSXEagdn8aWxgtbdZvig7YfB38Q36hlswZ3wmjJkLeYp22LzBeEWdRIxm9yeBdHEgRzkX3K7aKD5ccTq8NoFqTI/e2buvnMi+5DrkgIFsAn6MgVA6Y9kS+SlEamNveyKhOv8jVkwR90P4KzsHoDFkfiD3UsSHMPctnN2qm2AUpCkV0yi7D3ivpunaKL0Pr3Z2MTD10s0U0Khh15H0+JsvE5HSFZUcwy3MlKN8JW4GvZ7C2OeNm3Hk4wA7kEH4BvGXyrE5tA5QtterKBE+Fb8gs0aJg4IZgNjgmuypjFVDVE9k7ZJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GWtut6AgBn4JCkr+Qj3k38QHcrKLHhENj+OqcJno3e8=;
 b=EIdd4Vwby8y6isB7HxQ3GXDHtFW6LZJMIr897v3X/Y5rXA60vSTQN2KkIDBpyMhPCl3HEyzVb+yoc2g6uRBP9IjbS8VlvmOd7SdRh0Q3t75aW94ixi3JaIJLdi/1+lEq4oXjLr8wkHVKNjvkMrIFcP6kE+rbnAb4BMPcctgEWVg=
Received: from SA1PR10MB5711.namprd10.prod.outlook.com (2603:10b6:806:23e::20)
 by CH0PR10MB5292.namprd10.prod.outlook.com (2603:10b6:610:ca::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35; Fri, 21 Oct
 2022 21:35:51 +0000
Received: from SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::780c:bae6:7248:d67e]) by SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::780c:bae6:7248:d67e%8]) with mapi id 15.20.5723.033; Fri, 21 Oct 2022
 21:35:51 +0000
Date:   Fri, 21 Oct 2022 17:35:40 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Nicolai Stange <nstange@suse.de>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Martin Doucha <mdoucha@suse.cz>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] padata: fix liftime issues after ->serial() has
 completed
Message-ID: <20221021213540.7zlhwbbbp7og4lrl@parnassus.localdomain>
References: <20221019083708.27138-1-nstange@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019083708.27138-1-nstange@suse.de>
X-ClientProxiedBy: BL0PR1501CA0027.namprd15.prod.outlook.com
 (2603:10b6:207:17::40) To SA1PR10MB5711.namprd10.prod.outlook.com
 (2603:10b6:806:23e::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5711:EE_|CH0PR10MB5292:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d64677d-b153-467f-dc4d-08dab3ac39c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kbbth3emXfJ/mxN+nLmhZgq3H4KuxohmQ0yecdR0t15Cyu7tY6gKOGqqz7WuGFu0nos48aIpWaz1bTT12QmQo8lvLe4poegXVrRAfO/0NLWALaL2yPU2BgJ+jSpwfs9TLFnFYFTij0nTjBkf9t5pFWfZIWk8Dr/mH9CCDksN+G1l0XBCFP6GDQvFjTWbx1Deu0SLpTd+k0egCnyD9cW5ZBadi0hJbCkjycMc4LV1lPVMkD4tKIr50Igqq74NQy9TT9UoSVPR9YI5S2yu5WkEG8ORp2m4nIVCnoLFN2TRkL93mKuzxT7DaLhKF02rMLP/Li5NGkZkQoyEZpnaApdVqGsfwR0vwPjJMtznM2It2/tJPvc9BYQVXgneF965qHVYq2KaXL1qw6GfzUxSMFSMb5aOQ9haIdm+oNhO0fBu82tFyRLnN+/pSNts+Iem4PXeRSW7SdEm2GC7F1LQ+thwHYxWbT9qUxaYBCZsRNghcL0qdiPJVCabr1Ye5rHxIxbjDYUPP4CyELMaPAtDFHp/y88pOmhLTtzTZqzBOkMuYOLYvhf+uwqEWk5rSOTAOWaQEKLH8OpojnV9BK1Z6tDjDvSc9cgmlt8Xh9o/OaoCxQASEceqZPvNaw/on2b5DGVUeNCyJ/W9qCUZfzewdNJg8wJLeWVSbgeh7Sid2VDtGBYlEPSogDX93e/2kvqJhdkss/+/Z22L4dSsS0gU/1XZpw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5711.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(396003)(39860400002)(346002)(376002)(451199015)(4744005)(26005)(186003)(5660300002)(2906002)(1076003)(41300700001)(9686003)(8936002)(6512007)(86362001)(38100700002)(54906003)(6916009)(316002)(8676002)(4326008)(6506007)(478600001)(6666004)(6486002)(66476007)(66946007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KJtHB8aqFEZJukcMOxBje6+UOFzr0WUl+mkMVSgqsKsgwTMnrw/cRGzW02J3?=
 =?us-ascii?Q?HXYuIbFvpnfUHN1OJ2F9d0mby6wmPJBJTGa1syst8o48Omq39JuiqrNGpOsh?=
 =?us-ascii?Q?Q1kJCH6N3FE00CjEzGsZ94RJeCXaVbQPJBzTas0d4D7yqxDcSw7UzM5pmx2n?=
 =?us-ascii?Q?wM1DCAgJAISCaDCNxmDsBk9CjaakSlSNwCj+2Nv0trizvtFxA/leOeglYjTh?=
 =?us-ascii?Q?THGK0PxQR9tKTvou4pDdZEbCv14ad7yz3P0nq93sPlpLfObYTZGs0GArA2Kw?=
 =?us-ascii?Q?0bYFu5CIAulsAQEWYnwa2ydwQ3mCgJFEeDjoonN6wB7IACvXj6zlDYDJXFt6?=
 =?us-ascii?Q?YqdVqBXhF8B2vxE0hMROqjUzTCnRJHxtkq0BaN7dXkMOvEEDP5QvRyMnEE0u?=
 =?us-ascii?Q?GbzM+53DapICAum3gi1FqdokRr3Gj/wW33Sp5ivHqiXP/G74oNWCuGba8sEW?=
 =?us-ascii?Q?ZzHUxfDzPzdbQ5QMvCjxH5DAt99waxfyfCwFAlk6Yd9b/CZhjUhaWlwJBJzd?=
 =?us-ascii?Q?9XtXL9mrhLRzjenhLI/UYWz+87O/FBZrgSd/2PnuiAOKKhVy85f5JLIoAS+A?=
 =?us-ascii?Q?O4IpT6G09jlg+hgOJWvL0c7GAaTYed5qd2CS0op/QCKUzhCFbXpC3JrcDhmN?=
 =?us-ascii?Q?UtuuDlvlv/3dIe3UC9SXtQ2IPZEAHTYGnvKAVGbdWrjxNBObZ58HqPMDA4cA?=
 =?us-ascii?Q?PabwPp309j05AvCklSFNDJTeO+PMRB9ESs1NcLVEG08moQJzrlj3hT3aLmaC?=
 =?us-ascii?Q?5r+pqj9taMXs8vlZi+P9HscwQIyWVdxfEfkSomYRYtMclSObMTGBBhdVBaJ5?=
 =?us-ascii?Q?XK746GzIw1sXjjkRRAmUuF7MYmX6ZrISUjEtLch608C98Hj0yKuk0FAwmrAs?=
 =?us-ascii?Q?k+1pmJzj0xbWSFJJ97NYtIxadW2+u9m65bRCJJUB+jvbwIqyZphBhQVMcFRP?=
 =?us-ascii?Q?XWM019zKr3UD5SJ29N7wMCi2ta+V1hgcmotlPBb9O/ZQDNjfzBc0b5ugMtsV?=
 =?us-ascii?Q?yMkwd3n2gNwB7Ayp96gVSahn1tFwPjHQp8iyX0joMMToKi0vF8+9mhOmh2Mw?=
 =?us-ascii?Q?QsOWulP3OOI7t7HYv3bxbhL0ZKn1ZsWPwnk4d1OnWDru9s83qAN2o5UH7pMV?=
 =?us-ascii?Q?azu2QJrKlGdoHwKxLXF1zrEGfGEtS49V9lgnq70XVBRbXjPpzLgoG28VGB5F?=
 =?us-ascii?Q?2G31fbRrYXo5Mp7hbzEY34/bvgsALMZCeYWKeJkX+3gQuALP/fvL/ykCohpB?=
 =?us-ascii?Q?zv2DrHC51Kr3HaCXK29jplqq2tQCQnWZbfKBuaMLYez4kxsn3gjVNotaZMxU?=
 =?us-ascii?Q?eq2nmf+ZyJym/dMw9MJNEDRlx59nbADtlLu+JYs9OpmCg7vZlGXjSNXwcU5t?=
 =?us-ascii?Q?Y++cipBGRnWXioLvf35LubzGTf9IhjMKSq4brBX1U0reaKaYnrgo7rUlbjho?=
 =?us-ascii?Q?bPOYrcDeKEmy/1ga+mEZ3rAzpF6gxLb9RGJ9b+/MEXYKbKrNtewk40Sn60c5?=
 =?us-ascii?Q?iVX24bRcJ/rjCbsFXKRW9/2kb/wsEjQdBDjd9pvkiqAjXadDEDiqvckvs1kk?=
 =?us-ascii?Q?4TFgjOWstUYDhMCg7pcquRvMcLRhmL0cxi3/2JDCDx3vuh3e5pmAofeXdxhN?=
 =?us-ascii?Q?qQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d64677d-b153-467f-dc4d-08dab3ac39c7
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5711.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 21:35:51.3367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vFwEM7ShwjUWS8QIlhCGKUTvdQ9lVhef/kfGid63MIbi/X+mvOwdkvjb+XK6QS11kd9Sr+aLWmeB4O9HsLz1JZLGe0ASN+a8TGil+Ma7LVg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5292
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_04,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 malwarescore=0 mlxlogscore=883 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210210125
X-Proofpoint-ORIG-GUID: aiwAREzHf2MaxBUJUB4FOYckgk8_V4_0
X-Proofpoint-GUID: aiwAREzHf2MaxBUJUB4FOYckgk8_V4_0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolai,

On Wed, Oct 19, 2022 at 10:37:03AM +0200, Nicolai Stange wrote:
> Hi all,
> 
> this series is supposed to fix some lifetime issues all related to the fact that
> once the last ->serial() has been invoked, the padata user (i.e. pcrypt) is well
> with its right to tear down the associated padata_shell or parallel_data
> instance respectively.
> 
> Only the first one, addressed by patch [2/5], has actually been observed, namely
> on a (downstream) RT kernel under a very specific workload involving LTP's
> pcrypt_aead01. On non-RT, I've been unable to reproduce.

I haven't been able to hit the issue in 2/5 on RT on a v6.0 kernel in an
x86 vm.  Were there any other things running on the system besides
pcrypt_aead01?  More details about your environment and your kernel
config would be helpful.

The first two patches seem ok but I want to think about the second more
next week.  I'll look over the rest of the series then too.
