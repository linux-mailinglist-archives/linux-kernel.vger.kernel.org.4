Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101D06AD368
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 01:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjCGAlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 19:41:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjCGAlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 19:41:08 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0253B3DE
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 16:41:02 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 326NwrYI024446;
        Tue, 7 Mar 2023 00:40:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=b4DJK9495MldfOaErVkzXLyGyXwuTmRXJNQnNL5qJh8=;
 b=zcxwsSmscOc9tp8+N5hwKHt9edRNbKGQJbpe0A2MNJO7mbLgwcD/AOcgFCcM1Yab2TEj
 ZkDxnue/nTHz8jB09wKNrqcL69hfh1pTME6pRNYc6BfSr6PmHs+K0P2WxeDUD2ooWnH/
 C2eaqQYoylPzqINJlJgskgaWyhvBW1Chpvp2q1YUJMqj9YKJf2BuXLg8m4rHDti3ZpWL
 z0GHYg/XjsSgV4tjE9OEPd5K5cCZ5kdMKbVMst+TkkI2FUV4rBvbM3I1dH2F+kuhG5gY
 NLPkJ8AtUTedhnlpEbjNawXkzD9uOxfQItD+2DapqH0CMglabmofPV54hmlA3hJ1RkQ2 pw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p416wmbw6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Mar 2023 00:40:55 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 326Msmri025147;
        Tue, 7 Mar 2023 00:40:54 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2172.outbound.protection.outlook.com [104.47.73.172])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p4ttj8ugn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Mar 2023 00:40:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dhu/Ld8RCQWeec3L/NhnAlZ99LvONrqDicb0KDbuxHEFoVbxiPdi6MAFpRsypy4nd1lDpnpdK4eVeBN5+Uldy+DrpPGoP84JS4f07L7hYiiFTOrqfthFNaZ45F4znCUQ5yMFpzXGCagjgqDOUWP/O1UMWOiPlMWpaXd4AHGSHb9LKxdx7Y3gdrkq1ScNb6nZ6YhtqawQ9AasgYUXGcDOiBr/SW998UHKF9Dl/Dng0eFJPocvSjRtZw9aKSTRjbekLHlOa3SOFHx3wPXXP5o2Z4CYCiaFCKJodDR5g+htUWhO6IFQvm86VvYsBOGhPRx54LVrsBpVkwqu+KNV4jbzsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b4DJK9495MldfOaErVkzXLyGyXwuTmRXJNQnNL5qJh8=;
 b=nFdIKhM1mfRpk7Bu4T3RNAHL83C6BnBo+ery4eKQbY3cfi9nUPAbPvejI4PVYJNQLbXFznCvITcaK90U7pJbv+0vOtrsF63M+hlb5tHwwLGm/hY7YZMtbZyCi9OO7Z+l5A7HALtLYxOyxY9mdi2MF4lQ43N4u32EfgrQDp1gVu2Hq+VPlbRLCh7W2vTz9ONMnvIjz5WselQzxRLDsMUkxnuCDf+GGjSoWrg4oqAbzyWAN72AK3S3ff5qcQljPdWSNDes8qttImMLNMER/8YgLH2U45UWH5NKgQ4tUOpYBE2c3E/wDqP60LeuLY94b61D/GY/XyfYZgDwDYZe4pSbLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4DJK9495MldfOaErVkzXLyGyXwuTmRXJNQnNL5qJh8=;
 b=pIi3fmXafTsq8TRku+BlzlakWnxyj3haYAo8F6yf/BkM40mSY2jw4JuwHntis8R2w3eaBMppj4vDgLvsSQSG/svkTuFz8dziqsj+Jz7ltNyM1JFGPEV57GsvK3OxJjij9DIaqoCXxQI2EANeDl5mB86buCJ5eDeLCvFu/0yrQDg=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by IA0PR10MB6748.namprd10.prod.outlook.com (2603:10b6:208:43c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Tue, 7 Mar
 2023 00:40:51 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3db5:6e11:9aca:708a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3db5:6e11:9aca:708a%7]) with mapi id 15.20.6156.028; Tue, 7 Mar 2023
 00:40:51 +0000
Date:   Mon, 6 Mar 2023 16:40:49 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: THP backed thread stacks
Message-ID: <20230307004049.GC4956@monkey>
References: <20230306235730.GA31451@monkey>
 <ZAaCISgq4A/GnkCk@x1n>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAaCISgq4A/GnkCk@x1n>
X-ClientProxiedBy: MW4PR02CA0022.namprd02.prod.outlook.com
 (2603:10b6:303:16d::15) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|IA0PR10MB6748:EE_
X-MS-Office365-Filtering-Correlation-Id: 5850330a-80c9-4837-3056-08db1ea49a45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yIrli7MfvCzYCmbXmsIZU4C4EGq4nDUBgzohRasEWHIo+/fZKM3CfUXC0AM9CNqERCgzTPHINlD42dBTuhHFASh0l/LPW6p+bn8cbOHXGGCRR+Ohgmuk8rDW8C0w1mHjv6O0tDKZIiRl5ZxOHsX735K3eLtPdJzVjxvWrttJZjx/2XdotjXZyEZ3LPPF5KuFLBQaA+eTrWBPIeMal8957pSIvgyPdVSrlJsPCrg+f4E/JM8kpHb+eovM1quSc5Vl8LZkfjUS0WaeDiq1+jOPDpX88koFE1CMYZCgZasU3kpgZeotdWnW1V1qWuOKAJcIvetoOmyNTSxRGXi7L5hIjW1Bfsq/MhfUv7mdJLCBdI8QHM0AYNvB5qifGLYrPBG8AxdzNf4IGCevXt9pwO4CMyRlCn5SVksUjBfYejtxzB149tNpMNcWhUClLf7fZuAeJKCTre6beAsBtfixbuavRak+GJCuqaGXk8HkVbFwtm8e84yuf4zborBH0dbgN7nWLHepEGo2WrBI4CBxSsWIc7qFtL7o9iLruXKI82NNHu1aaWPNczkJkFSP6vo6B04MaZIT91zgEHgn+ifD4/sssqCTwFPjGiwlBGZIL2Deeo3ml7c8/IIcemLgaw6lutuefMVTgwOBk8Z1vOMtWwWuVQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(346002)(39860400002)(376002)(136003)(396003)(366004)(451199018)(33656002)(86362001)(41300700001)(66556008)(8676002)(6916009)(4326008)(8936002)(66946007)(5660300002)(66476007)(316002)(33716001)(44832011)(2906002)(83380400001)(38100700002)(3480700007)(6512007)(186003)(1076003)(6506007)(9686003)(26005)(53546011)(6486002)(478600001)(66899018);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B2iUbMROQgBxhjyg6/9WC9/wLPHe8cKp0SH/Y6o3DOnnFDJ8eahr9P22wz9P?=
 =?us-ascii?Q?8f6kGbEXucV7o/8BK8h/sTGNUlIPuyGkaVd8HPtbyvpL1pasXcF+OKetQ/oP?=
 =?us-ascii?Q?9s0xRB7MnbUa+jz26B0k6WFah0ivkRRsG+BSGXsTLtN5+8hTyLpbPnN3pZe6?=
 =?us-ascii?Q?jmY4UyGBXTroQXrfGat9q/JRPQyj9qRXNv21BXlKCKU3qFgW+cl19AWZ4wq7?=
 =?us-ascii?Q?f3spsxP+8owwWdOk1ysuqHmgYqy6uQmo6/HYK2NZG1Rw3b4dPXChD2gYq4AZ?=
 =?us-ascii?Q?1nmM6Vm8PX4GZokVYNPN/E7/fiZZZmLtx2plCur2Tn43oQLlllf5U+uXjIv6?=
 =?us-ascii?Q?SBgKRow6h9f23peA8sRQ3Ta2Fgto7tkiE301y4fj8BHl409NO3BDAtV5jukt?=
 =?us-ascii?Q?z/VdRN3P4G+RCWeuwEpRaxea1J6qQWBRQS1ttTjcfyxSp2tMrc8sQ2RVDjwW?=
 =?us-ascii?Q?weO1JW06xzSvmXaXhugO7pKdNZh54J7cfCPzF1gF2cgKM9zS8VGW45lAbhP4?=
 =?us-ascii?Q?IW6subscXfRxlheHEbLRz+k/Yv8vH/wyck+suzH83Ren/JGyVL/3z3UrU47M?=
 =?us-ascii?Q?oivm0kZ2DAmuE8xJbplvCvHOcldFqFSifT70Ixy4oaSJOTjNg5gy7UAEa2BB?=
 =?us-ascii?Q?4cvdnPj6BduVXMvxmIOvW0IwWm+GJbJBTKocasIN/gRNFdzbvrBnBCfHR9pW?=
 =?us-ascii?Q?M/Ylj7qBMb7cgvJ13+Va9oh3UpZxebPwZyH0F+qd24rsSiIZC6SooF1mdlXJ?=
 =?us-ascii?Q?7cLanc+CdpwoXypYnNcVPL6XXcaVAkG0UHxIvc+/6KpS4G5Zk2it2LqNFFkr?=
 =?us-ascii?Q?S2Af93nfeOcSOjnY8c0w+5f0doi4J6skGhuUv0h5yg14pIf7mlUduj1lS0Hc?=
 =?us-ascii?Q?S4TwM9PYIEUOSiEGLo5v0UxZHiSqI0+WuKJMSzG+KXUM5ExlR3kShCLLPWcN?=
 =?us-ascii?Q?o7jjGbDIkUJKSUvjb9uhfsaDxzEQyjI/8Zqd6g2tUSh/V5+cLEXIwvurRTVo?=
 =?us-ascii?Q?AOSz26sG7BN/xjfAUp/hvoKYGgCJ5X5seokQ9hP2EKJdTvEPoscNsMdK0EEq?=
 =?us-ascii?Q?fpZaGYy/sOSSbxG+N4N2jA4BsGt5PM5hNcNflQdAXsA9NUmo81zyRUpSJQfZ?=
 =?us-ascii?Q?LHfwNKIjHErsCqb6BRNTIlHeqQniH3N1h9EfFGHei1TQlyHCYk5OkliZ3dQh?=
 =?us-ascii?Q?sPZFTXYHXEu0DI/Zc756Bw9m9QnjHpxniMXPNcl2aSBoUw0mxFtZhhkpANv9?=
 =?us-ascii?Q?6YOQLDlSsdzXc+fDhLtxr+8sv8GOui/Pnxjc479iMWaMfWGd5HvFc6ZDIxMR?=
 =?us-ascii?Q?nbrMfHk/DSHrHeWFPcqJ9XvFYpKOCG7EBfzzB8AwLqxXojVUc8Q8gNsl7++T?=
 =?us-ascii?Q?fXs+Mikmcbr9QSs/22RvqKS18p++4bGnqU6tPe11cVJfxcJQUFLTv2h8Axv1?=
 =?us-ascii?Q?D6Cx2Rc6cKkc6Wwwo1iKbqmVeJ43IPiztDLVH4PlTvDGfEHcc1QHSAUcgdUN?=
 =?us-ascii?Q?GvuIQpH64n4TAqFA7DYm8dU4HJRnkjtfqlsNwUZGqu9yFQkzGNykxtymW56P?=
 =?us-ascii?Q?LP4F21CXC4N4F9fCc5C4bbBCoDY2ALFcqwGo2lovh3KB+wOqqO1d+OHTsk/3?=
 =?us-ascii?Q?bA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OqPoKix1os04/6KzGDIyraaQMgijEmFX42nD/2rHlyWRGr689pZ3UUD3fzsGuKUMZBjEU+5k//Kup57xmDfBXLuDLBDYm8dGnKb41KRSf32UddcKgEweR6PUelWKr2ynCCSjrBhI/oSj8oStuMJZ2QuIlfZsrg7i90M43LqpSzYhFCGytYyIGdWtfaMEudtTqaS6t46UNnzGP3RCe+oPftPtvMgJTO8038HOoF66jxkIXC+XH41JivxAZxu6sZ7v8LDdo+18J4jsRjiXnztPC8roP8+B89E1LiiCPhugvw0/IqKIpcVSaGN/31rRCq9KXdcLYQKw7G8CzYcMGkEfLY8Dunm0lB1Pnl8sZSuWQXc25U0yjPpBNaHYCxnqnNzwduLeI3krCb7Y4uHVeZHoPJgBuUOmX7QWSTI5K6C5d/kchhmzvLJp8gnbHK3Sb/5GHy4qRhMUIQXi7uF4YnrwDkqd/llwYTh9eppSmPxn5+8B+LQkWlprUp3gIspx9ZCDVw5TmLuZok0lHmssgIMWyR1vfg76KuD1dYc8WC7x1Vgrma3jkQ3PiTCE2QfqiQTtWSHR8aPBrFtBXSoask2TjFFCQ36XtBSlKlPJ3qHuphmIVrRxqnN4LP98W/ErJCMOWBfrV/sEC7d51nb72HSqXMKNvaUdmGgIv029C+Ol9rNBZzsqMOz8rREtNOflrNquZxmOTcX445C19jhRtgRu51i4+q0SAarcTrMzr0Xl82ongnwp7MaDF38U24G3BfDsFElZC9iM3EZRnKXNHZTgRhepNgKWpzK12xTFlvvEDzI/BvQcvc1NN6+o1CH3vG86
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5850330a-80c9-4837-3056-08db1ea49a45
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 00:40:51.6326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1q3AyPHN7z3Z4xpkzDi43mlGijwbkYDuJBTMOJrtQOMZf6DVh7kW4fwmqhonDSbvUEGc9K7GcW1F8ATJwGb/Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6748
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_14,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303070004
X-Proofpoint-GUID: 0JcefRUupeDfw9GvtYrWUTXOm1H2e8gr
X-Proofpoint-ORIG-GUID: 0JcefRUupeDfw9GvtYrWUTXOm1H2e8gr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/06/23 19:15, Peter Xu wrote:
> On Mon, Mar 06, 2023 at 03:57:30PM -0800, Mike Kravetz wrote:
> > One of our product teams recently experienced 'memory bloat' in their
> > environment.  The application in this environment is the JVM which
> > creates hundreds of threads.  Threads are ultimately created via
> > pthread_create which also creates the thread stacks.  pthread attributes
> > are modified so that stacks are 2MB in size.  It just so happens that
> > due to allocation patterns, all their stacks are at 2MB boundaries.  The
> > system has THP always set, so a huge page is allocated at the first
> > (write) fault when libpthread initializes the stack.
> > 
> > It would seem that this is expected behavior.  If you set THP always,
> > you may get huge pages anywhere.
> > 
> > However, I can't help but think that backing stacks with huge pages by
> > default may not be the right thing to do.  Stacks by their very nature
> > grow in somewhat unpredictable ways over time.  Using a large virtual
> > space so that memory is allocated as needed is the desired behavior.
> > 
> > The only way to address their 'memory bloat' via thread stacks today is
> > by switching THP to madvise.
> > 
> > Just wondering if there is anything better or more selective that can be
> > done?  Does it make sense to have THP backed stacks by default?  If not,
> > who would be best at disabling?  A couple thoughts:
> > - The kernel could disable huge pages on stacks.  libpthread/glibc pass
> >   the unused flag MAP_STACK.  We could key off this and disable huge pages.
> >   However, I'm sure there is somebody somewhere today that is getting better
> >   performance because they have huge pages backing their stacks.
> > - We could push this to glibc/libpthreads and have them use
> >   MADV_NOHUGEPAGE on thread stacks.  However, this also has the potential
> >   of regressing performance if somebody somewhere is getting better
> >   performance due to huge pages.
> 
> Yes it seems it's always not safe to change a default behavior to me.
> 
> For stack I really can't tell why it must be different here.  I assume the
> problem is the wasted space and it exaggerates easily with N-threads.  But
> IIUC it'll be the same as thp to normal memories iiuc, e.g., there can be a
> per-thread mmap() of 2MB even if only 4K is used each, then if such mmap()
> is populated by THP for each thread there'll also be a huge waste.
> 
> > - Other thoughts?
> > 
> > Perhaps this is just expected behavior of THP always which is unfortunate
> > in this situation.
> 
> I would think it's proper the app explicitly choose what it wants if
> possible, and we do have the interfaces.
> 
> Then, would pthread_attr_getstack() plus MADV_NOHUGEPAGE work, which to be
> applied from the JVM framework level?

Yes, I believe the only way for this to work would be for the JVM  (or
any application) to explicitly allocate space for the stacks themselves.
Then they could do a MADV_NOHUGEPAGE on the sack before calling
pthread_create.

The JVM (or application) would also need to create the guard page within
the stack that libpthread/glibc would normally create.

I'm still checking, but I think the JVM will also need to add some
additional code so that it knows when threads exit so it can unmap the
stacks.  That was also something 'for free' if libpthread/glibc is used
for stack creation.
-- 
Mike Kravetz
