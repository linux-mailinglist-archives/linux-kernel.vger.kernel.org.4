Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAFC606AA0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 23:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiJTV7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 17:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiJTV7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 17:59:30 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA22C60D5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 14:59:26 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29KLi0AU013176;
        Thu, 20 Oct 2022 21:59:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=Z0y372m787jRwy8/eS/8U7UxbWhahTjs9mMzVEO8ZEo=;
 b=pVHFnOW7DLtBuKdtYZc4BmR1JOuTlmxINCSyj/JX0Dv7Pr8ijIxOAWUGT4nKJhwWsF66
 ucmFTeIGRrqNVSbmfal0jd8/7Ncc4bgdCyPrdFGy5xx7SS3eLJVck0gNw67NA0hx6HIY
 pyYlHD7XEFF456SpW/ZfXnTTT03hISA2tAbk3Nt5YN3spls3JEM5kG38Ry8uyUkEK/I0
 3zxrBAail1B7vMWfRIQBWNFBFRBIcwdhOf887o6iYpDHknd/mylkybWe2K/EkY0Ai2xR
 9hUMjVmXk/aDVtBTw5kbKkj7xxbSdTrMm7o2B9u7Es1W1joEBvaNEV5PP+jgPeaT5f/J fg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k7mw3pp9d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Oct 2022 21:59:15 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29KKcXSV014679;
        Thu, 20 Oct 2022 21:59:14 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2170.outbound.protection.outlook.com [104.47.73.170])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hu95wes-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Oct 2022 21:59:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AwQvaiglK8HoEmat4LEomiJx3FrhmURKVREvvdFTD5rBO5pzIwFZYQ/JA8QIgStsldtUK5YFNxw2c6zvhrada81mOjqyjJtTefoOIRknnYqxo0pTEr+Jvfi+apeyqNp7D636H4+/mUostg0bYGnbDKkAvCHebB9dFMGTSXzl/oOf0SSMEfBkp8yeYjQ/CyUs/ge1WW6dzSdGvdUV8ymIlqlfXOGHvk/Yo9XpxiW6NvEeGkoPkX7VXfnwNp64V35MeoZELg/XkJCiPZQpBGpQzQC3DyhnjH1rewC4DbO1GiiV976KuGY55RfB9zk9QtQPMb84ytklOhGcB0fB0cJHXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z0y372m787jRwy8/eS/8U7UxbWhahTjs9mMzVEO8ZEo=;
 b=Vkbqp3b9c7UCNyLSxfd765yiEkXzkmeUUsyGgnVINjh3A1kPGs/Qa/Li38icjtPJap4345e3cdBAZwJEqKrOr6GCVd5Iy2fV00cDbvZt1v722QKz1fz6TENmXgZbE22eYL37yzs8br0dh1Oa0FNMp+OVrFQC1T5XxRXcsLio4AHXhsFcsCIH+Hxty+17UKqq1ciqh2TBGW2R3iGVFxLxvV0RSOtRvLf0ZWUnOezsGmGWrJHUh64UyIqmFllMqS9Dxy7pVfPDhWx5XnNWp+sNol62sIBo5u7gxdhtMf9G8rGFJJsBIAhL0yY3+MXPY3TdORJS2+BkGqhlfoGwCdmE+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0y372m787jRwy8/eS/8U7UxbWhahTjs9mMzVEO8ZEo=;
 b=EJphrwv9E+CBZltBLwhWwapXxT4Gh8e0Mov23T7MkblySv8cstXY285DYjsiRCvo40pH8KNyUgEXe3wLklmn7Ao03rCv3wUjt5FXhmYzhHgDF3/bpaU0KDAWrZvvi7pRhMUUWuAezCyPIOjcMLpq749bf6xs/wFaYq+MRD4MoZY=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4337.namprd10.prod.outlook.com (2603:10b6:a03:201::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Thu, 20 Oct
 2022 21:59:12 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e41f:b75b:3246:c1c7]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e41f:b75b:3246:c1c7%4]) with mapi id 15.20.5723.034; Thu, 20 Oct 2022
 21:59:12 +0000
Date:   Thu, 20 Oct 2022 14:59:09 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Wei Chen <harperchen1110@gmail.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>, hughd@google.com,
        dhowells@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: kernel BUG in page_try_dup_anon_rmap
Message-ID: <Y1HErfuQox2DfwxV@monkey>
References: <CAO4mrfdLMXsao9RF4fUE8-Wfde8xmjsKrTNMNC9wjUb6JudD0g@mail.gmail.com>
 <8ef3a72d-8719-aeaf-1a03-9b7cb1a03cc4@suse.cz>
 <CAO4mrffHdnG7fEkxcoEXEhqYN8HkcY9d1-NxRvHsqf0mQN6T1w@mail.gmail.com>
 <Y1F+aRB0/ZhHIlE8@monkey>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1F+aRB0/ZhHIlE8@monkey>
X-ClientProxiedBy: MW2PR16CA0025.namprd16.prod.outlook.com (2603:10b6:907::38)
 To BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|BY5PR10MB4337:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a3fc9ac-0829-48d9-a3d5-08dab2e65210
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bf3hbZM48KR3CxC51lpmoMP719CvnMzgEzA8sEUEN35rUqFnVIHCaQhlMqpz2/x6A45LtgfZyekEHPcGbLKHi5PM3NwscgYScWVX/3kgq6zF6A/9iC+4SwtcbEAt0NyiyeqCT/cM5O4QVaLfuYu7YrGW0KnNugNfjgQqVE+aBn72n1ucYMvXc7jm2Jy4Ck6a5HnY7568dCy1KuDhQIsgEMzjeexcW5VglzbtNjvRnQdE5DdayOvYoAL4fYdGt4I1n1/iD+hUeEvLT0SyThuN/FaVcWrwHMhXZfvFA6DfIvobgU05QknZq/FdNmH2h6/yq6jMrccI2Le7J+/EhiIw0GOjZkHLYsFf4rjn5oO2wu4Vhu3sIwhqywWCcFpd3RjZzKsSbBXKnSZTZWyPyqqv5wPqGIc77yn4W5fscU7d4HKzKAdVCOD+/PUJe+pXNkLu32gxbRcLLx03NIsrM7xSYDUr3Rmsiv5tQJaBA4Q0HWelRirDTcR1/yqfrIuWqWCc5m3dpBlSTNB+lJCddz57TLBrzc5exgBDHAsM/wtyAfe7vR6Bi98c72EiaZyh1b1LcJtn1uDBPcfq8nLGKL2FYkVTzAXFdr6p3+73hD6l4hGOMX5ZrB29USf8TXspK4c/RvjxWicqolWv645JeQvG2XuIMPmPQXqa3VJj/d0d6HmOahqeXs2uIdZTmnRKOq2whrxGeO4F/g6ie3wtwiHLZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(396003)(366004)(136003)(376002)(39860400002)(451199015)(26005)(54906003)(8676002)(6916009)(66946007)(4326008)(66476007)(66556008)(6512007)(86362001)(6506007)(83380400001)(41300700001)(9686003)(5660300002)(53546011)(316002)(8936002)(38100700002)(6666004)(6486002)(33716001)(186003)(44832011)(2906002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XM7CvRSchefoUeHZs7pg8Z0NpR18HxjzQ9Gh1AcdnPgEO/2WkXV6q54sfkad?=
 =?us-ascii?Q?d8TESHclKI50f23txgKUvZ6ZZwWmBGd5+LWsD7nggYKRdwt9hDjzTY5dCOuq?=
 =?us-ascii?Q?Sdfx+2yZDbCMx+Y3TDu8nRS9zqDZXkdY5opMzVxoDjMJTBxRVLrEWRyoWyPr?=
 =?us-ascii?Q?07N2Umv/0pY5yK/icmfHWo3kKVnNU+T9qMrpojKNj6O4pwH6NMd83KvIKWeE?=
 =?us-ascii?Q?Xuh9HvIfw2Uj/Rqkrgb6FBIeEZdLSbFt2PyNIFjnH86+/98DwX3QvsJfRLu/?=
 =?us-ascii?Q?VuJjd98vsuL7bvfxmR6xC3UOD/9Iu3eirC8juUplbmU6rCoSP7qENkGCP+2b?=
 =?us-ascii?Q?NYIjB8ncLIVmpiwgbB2AgoncTDcGPALeJBIb8LEB018EqcXM9SEbb3zayG3m?=
 =?us-ascii?Q?uqkt4zhZ2LuYxABytYVY0RDjd06mZ3t8lsVIS8ELgDphoT9w1E+xqbiuhysu?=
 =?us-ascii?Q?dx2f06Z4e3+wgWE4QXQtJr2di2+kzMz8RBKESiXBqjpEIwAvzyg/hS5w5zM2?=
 =?us-ascii?Q?cTLixRorrjn8deJmSE/AF/JYLLAifj6ZYDCKeWt5D5ulTPVMpeB9+YZjg6XG?=
 =?us-ascii?Q?NXGQq3j9bckFSPMg1j70lzyp/Ubfwix2Vm2JkTNm7WJmpUBSRq/dX6etiSFt?=
 =?us-ascii?Q?mcalCEhh36ECCjbqr/vFy6ZTJy2X+b4a9YLnAQCjj/BbtcWQh5nuTno+uHTM?=
 =?us-ascii?Q?PuOLRPHdwC5U0mYfLTMUThVwMndHsQxS/hHRiisvMlicS3Z/wUbgSs1kaBGm?=
 =?us-ascii?Q?rtnxqjRtkszI5EZYQ4+UKFygEwiiGzUVgFLM44ZctS/N2sxRXMWnBtUVUlpI?=
 =?us-ascii?Q?Lg3XrG3AVH5Tw21JY2FYo7f9V4cQ7pwKlcujAm3LGzZ9BPoSQFEPdl0culP5?=
 =?us-ascii?Q?ztJ+5KWF2M7sE45oQU8oysK6lKp8Xgi/Go+f8OZU9GufUYoewOWqgBL3a++f?=
 =?us-ascii?Q?SY+o3mMZ3Ertq4c/YFk2ZGT9ovtLpioTCCY7llwYS+izqVOMFdXAv58OSS/g?=
 =?us-ascii?Q?kVXzuralj0NEgRZ8mm4BdytFJ+31mhaBu1HnxB+DlqoPcQi69LPpP6pBpALw?=
 =?us-ascii?Q?xDH+gwtlw1p6FvjIBVYxl7QwN5bsID2mwgVP7jBLpDeZvK2TYwjfuygNxkMT?=
 =?us-ascii?Q?ZcBJ+/soENGG0QPvopme/SZxkhAPzLUOtWBwKt7DfMQi2jQUA0PQlFRw+sud?=
 =?us-ascii?Q?e2RSd/AVnStcqdpF6oPEbezcUctlqyg34JJTtOXq5YdJmR6EK+REk0u5HnLf?=
 =?us-ascii?Q?nBnBgSgbWYXXsjYjMKOE/hwoK/i8Y4N8uce1uxv7o+G4UPWnTmEv/PfBEX6R?=
 =?us-ascii?Q?LU1LFnA6yCUed5VIbCHCSRf4tJgLU0T43nFRzed18uaFQYWs+EqjYQT+MBHI?=
 =?us-ascii?Q?eWg9bb9AVn/RTyxqnqkERHH1eYFTfPhpuLqQZis5rl5nOCwUIPJRleStP5fX?=
 =?us-ascii?Q?WItgG7ghTzgDrcgqChCkibg7+xHgT1TdyFlLSbbbtxPZORt6hf/yPog5lB2N?=
 =?us-ascii?Q?+K53x1hPqecCQAOd+5SHvygIVw7W5XPFVhqVI/1Rvo+KTHBadp5edXpg4z/C?=
 =?us-ascii?Q?G01BrJetfVqg55SqIsqdKQpat7LByWlSVoo3n974cQg1PFB4fuKQqFOMHFOe?=
 =?us-ascii?Q?Pg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a3fc9ac-0829-48d9-a3d5-08dab2e65210
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 21:59:12.1340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uB8hG40pJg8GFOxgNydtxE6j5v2E68lSRSXOQ1b296I6x+VcTlMPkQU42aWpob8KIqt8pOxBZdyuqLuAJS09Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4337
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-20_11,2022-10-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=518
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210200139
X-Proofpoint-ORIG-GUID: F99ReT9RnewnuVez2KSgDPUW0g8wEjLg
X-Proofpoint-GUID: F99ReT9RnewnuVez2KSgDPUW0g8wEjLg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/22 09:59, Mike Kravetz wrote:
> On 10/21/22 00:21, Wei Chen wrote:
> > Dear Vlastimil,
> > 
> > Thank you for the reply. The bug persists in v6.0. Here is the
> > information. Luckily I got C reproducer this time.
> 
> Ooh.  Looks like the reproducer is doing a MADV_DONTNEED on a hugetlb mapping.
> That support was added somewhat recently (5.18).  Not sure if it is related in
> any way.  Have not looked at the code/implementation around write_protect_seq.

I verified that the new hugetlb MADV_DONTNEED is the root cause. :(

The reproducer calls madvise(MADV_DONTNEED) on the hugetlb mapping before
mapping any pages.  madvise(MADV_DONTNEED) ends up calling:
zap_page_range
	unmap_single_vma
		__unmap_hugepage_range_final

__unmap_hugepage_range_final ends up clearing VM_MAYSHARE.  This is
because it assumes the vma is going away and wants to prevent someone from
doing PMD sharing with the vma on it's way out.  The causes confusion in
subsequent faults in the vma as sharing or private keys off VM_MAYSHARE.
We then end up with pages in the page table where page_mapping is NULL.

Somewhat good news is that I thought clearing of VM_MAYSHARE as done above
was kludgy and was able to remove it in 6.1 with the introduction of hugetlb
vma_lock for pmd sharing.  So, should not be an issue in development
branches.

I'll come up with a way to fix for 5.18 to 6.0 kernels.
-- 
Mike Kravetz
