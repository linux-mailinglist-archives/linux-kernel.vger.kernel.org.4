Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDD466AE32
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 22:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjANVep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 16:34:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjANVen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 16:34:43 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DAD9ED3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 13:34:42 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30EL1jxj006082;
        Sat, 14 Jan 2023 21:34:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=6/6V24s28TCB2t91zNhdK8JM5M4ffaT1pMYZt9YdkHU=;
 b=gBe05I7G6kNTjfNaC19tvxc1bk1nRWtOBmMKh23flr2wS9Tw7zZ4aHhy+XO48PMYueCi
 ccF8hPkp+jSa4edeqlLBKlCAoOBUWY6LI1knsBo6X/x31hMCjisP61+clXN7SbSMdpoO
 eoXQ6CFUq/EkYSEYYbO4Nbf238gYuB8V0n2gMZa0MMTV4WKRi1GKRLOoHRQe+hWgW3ZW
 53wYJE92FwwYIXOjkShVBR9j/8gvbbpjgWKbqhY5yZ4GRt6jEH+MLpGY10Azwa84rDOs
 L4SK7P/uzr22lVeLDbgsjTiomoaDpKh0JqN3f511tY2rjSHxj1dnNm4lL3XmUKnfOg5F /g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3mxt0mw5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 14 Jan 2023 21:34:33 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30ELS9fo013279;
        Sat, 14 Jan 2023 21:34:32 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n44b4r28w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 14 Jan 2023 21:34:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IcOiBa/JHhi0IV6qfizFQ21ko3iHBwtpv57IBbBWeizTm959Y4KrOJ9TZs8fGjYLn0kIRZw6UVFdihOMMnIjkxCFaiZ1x+tCJP+p0kGwZdwm4UL7YXbRQB6xtsH0/5dY6e3SmIpTj1+LT+UuwRFffAtnHbncWQc4dV49aJaSCJKPw2f8QJK0aAky5R/35TBUGjk6PGO1ERTjtDeLiWaIFp7GZ5w9Jc45Qh/W0SS/80eKdkkYn8C+EqyGYdQKhKfUPqnd6CtAT0BsslcO54wAkyk8HmLnjWbdM7hNwO2DO5575b9+vi8U/23eOqSgQ3KCjaCj2gpsL/SBU8FRmJhKZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/6V24s28TCB2t91zNhdK8JM5M4ffaT1pMYZt9YdkHU=;
 b=C7srCIpLvrocUKLILtj3wm13hwouyv5wyY7u0d07CtHZsVO1ayXt9YrI+mgI2G0R0fo0KpyfluPgeQdB4xklyeUDpUWTWZlYWMe0D4tZXvby31gCzkjJYGS9qqI6qHSBmeL/Z21gY0eN2zBvtaSxlMEkwdQMT/y5ULP4vNmFGuPFYpIIDK50haiIQc08spXFdOF7g9UCTBrUg4xdX+3Sr+iQ7Q03NXQpAWYRWKY7nHze2p8bZlECnYVlTIoIytM1LIF4QnaU4QymIkKB+1i5Hf0Cz8QM8Qu0wVCNmHTyegtX+lUPXblDeluKYlyzGCIDKJi+/lj/RpW2InBkr/x2EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/6V24s28TCB2t91zNhdK8JM5M4ffaT1pMYZt9YdkHU=;
 b=EvuOBd2kpoJ0Kbb0xmT3r96OaYOCWG+NO7tQ2SAdMj/6wktMsU00Pos/ffqsRcNBNVVVp3KJYvfIByjA1wbazY5tavZsQWk9nd4mMb9MxiCrb6S6a5VqpT0F3MftGj/OJVUZjyU4XV4/8T8cBSScdLCPbCcqRvWg0DrJHfqF4LI=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BN0PR10MB4824.namprd10.prod.outlook.com (2603:10b6:408:12f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Sat, 14 Jan
 2023 21:34:30 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3a1:b634:7903:9d14]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3a1:b634:7903:9d14%8]) with mapi id 15.20.6002.012; Sat, 14 Jan 2023
 21:34:28 +0000
Date:   Sat, 14 Jan 2023 13:34:25 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv2 0/4] zsmalloc: make zspage chain size configurable
Message-ID: <Y8Mf4f2TTH8yY8Ic@monkey>
References: <20230109033838.2779902-1-senozhatsky@chromium.org>
 <Y8G3nJ9+k2lB0kas@monkey>
 <Y8JU8iGlu5uLGdDt@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8JU8iGlu5uLGdDt@google.com>
X-ClientProxiedBy: MW4PR04CA0178.namprd04.prod.outlook.com
 (2603:10b6:303:85::33) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|BN0PR10MB4824:EE_
X-MS-Office365-Filtering-Correlation-Id: 7daa3e98-25ed-4297-9423-08daf6771d8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XXIEnf319b/vwRwYd7zPgirz7ewtqGHY65DbpvcSkWoX0xuDyQlghDMZsAT8yXI4Az2qxfGGlOp2wRZzdItNVpIz4oxXNKRlqjEdoSH1qXwzse2wzmW486PLzAc8ce8KzwgEWaGSqaJgxywkvhMBcHyOx0sO6C2MGDPee5G+EyeM7ZkUd/oEeK7Wkb5oGUF2X4iTFi2e6UncT8yspttfQykMYc/5puWpucXretkwMrTwDrsq3NMPk9TEe0+V+No9NN0PPu0WDbkACQ10q+yKCXGjqnsOgD328hgphLcJEEeHcHMcNpB0NI1N0mbGgVvNAFhYZAlDhaldIFGchrZAAuOnvK+IykfxPAv3hGpgPjqDpMwNMEr9QV1XODQrTExje12PN5/oNneY+yiS2iGuwxY46Yhv0pIgnYzbMamcKE8el6HQsCdh9Ts1/01KUKPoz6+mE/tewFYLHkEJB0e1KZwogv7hhcoq0j30gDENMgTk6m0ie9sCmWNCv/Se1FrNfHh1K52cWA/MnXSA7Uf104GN32Pdw3EawZfWf7JFhMNOc96MN4Dg+Csik1+SFKWyke6iNoDriVHldNVAnzBGXSvBwqOD7Q2zUv2Ln0chmeCJWsJp3yagYGeqNZhI75rhfEKkpHu8XjCgLFcuzm1QxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(366004)(136003)(396003)(346002)(39860400002)(451199015)(33716001)(86362001)(54906003)(316002)(26005)(6916009)(66476007)(66556008)(66946007)(478600001)(6486002)(9686003)(186003)(6512007)(6506007)(8676002)(6666004)(53546011)(38100700002)(83380400001)(8936002)(5660300002)(41300700001)(44832011)(2906002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pa9NeueYbnkKc4y3oy1fZjbAkWD2qoJhtBdCtzgZcAUDK4IBoaZVUyw3HqW1?=
 =?us-ascii?Q?zZLg2jdRTXBX9yrAfgjjJ7ranSXHpY39GvA39nxpxaof2QrchHbTz8Zo7jE8?=
 =?us-ascii?Q?JJN8BioEqCdspV7iWbwxX1kGtWg/XkKk0Ij+EnMzL2IawRqscBA6hu/RFqjY?=
 =?us-ascii?Q?hzY2e06pZuAIvA0GM4ZA4kR9cyebA/VdvR5dyUvgd+tqpqD/+gC4P8BSZGgO?=
 =?us-ascii?Q?mG0zpSFdjZtL7feDCWs7gxOl25CZKwJZKpZqiQolmIf9F//pmEdSszvZxaUf?=
 =?us-ascii?Q?ZSmQf9wEYWttmTet5rqyTxW32gCExu4TmQ+mmYM+csGAHBc0ihj24PkkLlhE?=
 =?us-ascii?Q?4HSYGdprGwhYcbZctlOcz3xEjPFAPPXxHx35n1AphMVa78/EsQlzq4v5VhUN?=
 =?us-ascii?Q?lrbnmkSGvmB7sXjtQhVYS+ExuspQ/7s1fxK5hJ9Wn3CO7Cm9WNASkTQwf3mb?=
 =?us-ascii?Q?vmXx5tMIyg7JtqJZdmZ8pjr6Ay98IhFuEzwRV0i2cZnG+wVwEs4jDdtHsTlO?=
 =?us-ascii?Q?EpWOH8fEGkemBGOQSbADZnScLK3C7BJ9ghqFLVREW52AB39MvbvPUhyDqDhQ?=
 =?us-ascii?Q?KBev7x4fwyPjmCTW/GFSeHNUDispO9Zjiyz0F+VdKSsSuzgkUllguFZcGoU5?=
 =?us-ascii?Q?IY93fGlw0zurCwF04xbyaljfVTR1jVdVyNUsnRcwBrnW2TbcEGevf7qQq8Do?=
 =?us-ascii?Q?EmcYaEFJPEdXqOeAaG2rGcGNtCP48Gzyyz+NTm+4GgtPZnryMkC7e1uNx3H0?=
 =?us-ascii?Q?HY633UE6SlI35+5Po/TPiWhSD0GMyCPpErIhNsvd+8DhYSicvghP+AKxwWzM?=
 =?us-ascii?Q?oQ/vIAeD2GNTkwTpTHLJqJJK04Bp6oMWsVvc6mUqEbBQaRchsV8EdlbcTWU9?=
 =?us-ascii?Q?97bbWNM3DNXGl1zBZUPYyEhd0r2lVchRLvQFZMpdfWrx1c2o5/RWGoQifEN/?=
 =?us-ascii?Q?g8heZeTczy11M7nrmicg8nMnAbktH5lekNkTbGpHDnP2+5D5aWv9gay6uiJS?=
 =?us-ascii?Q?4TSK40+LbqDrwRivICZ2JSrE/vIrhTguX1gHG+uao4D438BCBzioFFFj4+bp?=
 =?us-ascii?Q?lppXWbAoplju0y2ko1kCgk2jOte2EF9gAn8Uj7L2yfoWuCU6CWWkLyvutnDJ?=
 =?us-ascii?Q?0trc9oRP2K1iAoe4kineEQzgUOrPp1gOkN52ts8aE1D/DZE+f+ol3TfEOpoT?=
 =?us-ascii?Q?AJo+pmL1HYgo5uD1afcnLCgG13hdgAhSCl8B+3w9gbVZJuEgFzC+qqD0SRvD?=
 =?us-ascii?Q?NuIBcZ8Ukpl54E+YlXHmQEuj0hPHUNpiPmYVX+klxBc4LqIDLX2kMGikYByf?=
 =?us-ascii?Q?H2myUlf9QTRFLKs3moxXz1BDGj//5OWRQ0Q+5SPf1bMj3v+j6CaybAPC1sVf?=
 =?us-ascii?Q?T1u3VigHPba9/Nxw2mt5T9KJP5XRCCN20aCRZwxwsxKuFan7xq/yE9BTcTQv?=
 =?us-ascii?Q?UGZGt6mEAxqOuEV2mstABb9HigslWjjWeYn9Gt8Bfy6hZgaV9X9A6Pjpi4hm?=
 =?us-ascii?Q?Wyai0jMtYirpcYmeUT3ImWQ5KUzzrmy/gnpIP4zr40mhfxsBkumd4a56tniw?=
 =?us-ascii?Q?QhxfP5IF1jZb16AtSZfQY+ZiJPgQOYcFrkPfKzmJoUNtu9Sbgpz5hvZCaJbg?=
 =?us-ascii?Q?8Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Rj4+Jaorh4TaqE2qtf28TwZ7lyvYhy6zf8F3cXXnr4gpNKblddYcB7vG5IfoJyEyJyQ3Yxx7FJNPSCuBoOgaJb680tAiwFm8eTIEN1mDe0q5D0zLV8kVWuw+9QIl+BeA85vtbVKapZlQH0pWOnTKNdNBbPsXFtI9PiH3RIldwOP1G44qXez2nAgsc/8H22tvR9LT5Vhys+FvX4T2gNBhgSe5rnEkSszjtlNIN9JfsVXLupjCoTFg9WtrLG4ncFx/XHhNe2oxMixYR/Xh8gwFtRIbkV2GU+pQPah0UrF2w+JeiedIjIrGNgV1130NzE/0pGejDF6yUZRvqoMCaYlA5F+eDv5nyz1xfV6SoyFe8ivIIQKOnbRMrdBVWCrvXv4uSN9gTV8MURUrJR5E3kmxyliqjdyyvZ3ksvLe5+U5G5WeyZzJ8MlDOXZjP2JqiCxPCg41VL+PXGZibvYUvjHA9jOId6B+5sinXU1iy3hnlzLlh3bnxsxal8I6r9/ewgykxqZjVba4YPM4jxjTSx9o19Ves4FTyJTJwFj0wnRV8ZI3WyVMZOa/RMZBCwT2Db9p10XYByh4/RNLG5+iYnttibPMSsKqEuqol+idQd9rTg4G1RhHyWeGOqhuGBDP3j3q+tSKCOVzA2WvQmT8j36I3uweLMe/x2S3lFj0wG7z7vxPpWDw0IbMF+BpuL6DXl9H9WMe+gL9EXO6qSoQp0uls5+306jl9MRh75+IqzciWVx40vXQ1/nwrfATptEEXVsJZEHUSMFMKq4pI96dvhOS8txkt/KQ8oYHUOGAWNBZ9IzUzsyh5ItQf+wFAtzUXKa5xwCGvL9eVSjs5q9iAHods65zq8LJJJVEh4hWq6aHvsmQUOxLhUv98YWL6cZpcTfq/gRTugV+4HIgd8Yh+EOXrA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7daa3e98-25ed-4297-9423-08daf6771d8b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2023 21:34:28.6554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CEsA1n5rdHut4RT8inlJNG0t2ViiLI+r4ti6i82SJPhWN5D9vVx29H6yUThFjSHLXTzWOlqhTDjiKjHWRqnwXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4824
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-14_08,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=695
 phishscore=0 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301140158
X-Proofpoint-GUID: zd2lQfXHSteh04yWBGsOzpDugATT45ZT
X-Proofpoint-ORIG-GUID: zd2lQfXHSteh04yWBGsOzpDugATT45ZT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/14/23 16:08, Sergey Senozhatsky wrote:
> On (23/01/13 11:57), Mike Kravetz wrote:
> > Hi Sergey,
> > 
> > The following BUG shows up after this series in linux-next.  I can easily
> > recreate by doing the following:
> > 
> > # echo large_value > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
> > where 'large_value' is a so big that there could never possibly be that
> > many 2MB huge pages in the system.
> 
> I get migration warnins with the zsmalloc series reverted.
> I guess the problem is somewhere else. Can you double check
> on you side?

I did the following:

- Start with clean v6.2-rc3
  Perform echo, did not see issue

- Applied your 5 patches (includes the zsmalloc: turn chain size config option
  into UL constant patch).  Took default value for ZSMALLOC_CHAIN_SIZE of 8.
  Performed echo, recreated issue.

- Changed ZSMALLOC_CHAIN_SIZE to 1.
  Perform echo, did not see issue

I have not looked into the details of your patches or elsewhere.  Just thought
it might be related to your series because of the above.  And, since your
series was fresh in your mind this may trigger some thought/explanation.

It is certainly possible that root cause could be elsewhere and your series is
just exposing that.  I can take a closer look on Monday.

Thanks,
-- 
Mike Kravetz
