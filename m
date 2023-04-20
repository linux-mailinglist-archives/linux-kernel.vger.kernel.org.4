Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3F96E9D72
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 22:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbjDTUwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 16:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbjDTUw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 16:52:29 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18DF40DA
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 13:52:27 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33KJx9UJ009153;
        Thu, 20 Apr 2023 20:52:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=LPihfX5mRvNfl1HS1a/gX3pQpVaofQcNSVuF+N/0WJ4=;
 b=mDYMaV+RPO9Ic9U+T2w6/CQcQCDoCVA47HrorLtT2ocYZWROLZnEZHenttE6OUL05vK4
 2v3ZK2yGw2GhoDO0XKV/F5ZkU85ms14jtazplVY4yfnYRKgzveDzLdMfalPKawE2Zby2
 9gvY5rpr4QJPPoTxbuSR6KIM/w8v9Bs4S2mQm00g0Xz5Cka7OJ7PrzpE4QbHoUs38rm6
 bo56UzEcaqr0KCp3SKgknYCOz+7N42AZcSBT1uDWi4LM2CVe7p8fV4F/srHKxwcEgWAn
 78aFUhD7Qrreh/C9ZYcR/R5EIBVlOl4aJ0e1ycHQCA2ggsJugJVTcN9wUR0lqAli0rsA fg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pyjh1uyra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Apr 2023 20:52:09 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33KK7Zcg011330;
        Thu, 20 Apr 2023 20:52:08 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2048.outbound.protection.outlook.com [104.47.74.48])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pyjc8grq0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Apr 2023 20:52:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mCxT/q8eKTTylcJxPnvEC2veqtRmGPpJJxXXOJ1PANhwlrqys3WVAZMmDxPUw1shpKWnftAqB2QMS0nCkGtlOCtOChO46Ni8CFnaW4A4trOLjVhUvFJryx4fQwbi6QIbIgP54IvkrKIiFrLHA/jnnz7RvgC7zIvXopCy/X917MQGXTRnt31MCbmnG7WvASRH0HrEfZ+T2HyGkh6Nm1CuDRofjDwSAEzlbTuCzR5mm8LLpqrkc+k/Cj52WWzekiF7LD1TEGEHa9CcMHF/yByy2RgMaDVOeumJSW0kpGkLtCPoAGGhN3vtXYAuDcRyfYyE8QHQNFC+spcFl/IqkfeF9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LPihfX5mRvNfl1HS1a/gX3pQpVaofQcNSVuF+N/0WJ4=;
 b=AH33iUAl00QcTe4S8D7Q3t/uwq72Bv/HCQ25hMgr1N10W9f4r8MEcPKIhH/IW/jbSRKkQyIKbKuno6xk+EEHaIipyg8711xG8AzEtNbnbbIGw85h5VMjnZxU3SujK/cjPj0whrjYxLitnHSaQ8GMSqM06llPiWL5L2LOJ0MRfJ/LQ5Te5akmj8Dgz9FTR/cvJNvIUpeOaj5E4YgejNKLPixjxmOXdWr4RyDKkd1OC3nptW+lvvxwUB2gkNngEDIoQdrtq7uW2mKQ01rDzDOaQyHFzWDJn1s+1pRO5ZdWzt4HK1hQCn4OtoMYRVyQYrFZ8WHH1ZCdXBnQnzgdAsj9Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPihfX5mRvNfl1HS1a/gX3pQpVaofQcNSVuF+N/0WJ4=;
 b=PapERf1Axp/pai8QtIUhG4VFIYWLsINV2hhRtUHTESWcxd+/HD+xaVr71pCBoSCdYkk50VH+4BRXbAzrfGYV+sdfdShAWyf7HfECf38nqxbU3U8rx3oAXMErRDXXSaDDvBaco5LfvPImcRlDpIoFyTzH9OjJuqPm1D1qEnRay40=
Received: from SA1PR10MB5711.namprd10.prod.outlook.com (2603:10b6:806:23e::20)
 by SA1PR10MB6568.namprd10.prod.outlook.com (2603:10b6:806:2bb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Thu, 20 Apr
 2023 20:52:06 +0000
Received: from SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::da62:d148:3055:6392]) by SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::da62:d148:3055:6392%7]) with mapi id 15.20.6298.045; Thu, 20 Apr 2023
 20:52:05 +0000
Date:   Thu, 20 Apr 2023 16:52:01 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Aaron Lu <aaron.lu@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Nitin Tekchandani <nitin.tekchandani@intel.com>,
        Waiman Long <longman@redhat.com>,
        Yu Chen <yu.c.chen@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] sched/fair: Make tg->load_avg per node
Message-ID: <20230420205201.36fphk5g3aolryjh@parnassus.localdomain>
References: <20230327053955.GA570404@ziqianlu-desk2>
 <943d44f7-1fa9-8545-dc1d-890e4dd20854@arm.com>
 <20230328125624.GA6130@ziqianlu-desk2>
 <76939bf6-1d9d-5f8f-f15c-f03b2322d684@arm.com>
 <20230329135455.GA108864@ziqianlu-desk2>
 <20230330174557.m6jsgb6hsni4mxwq@parnassus.localdomain>
 <20230412120736.GD628377@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412120736.GD628377@hirez.programming.kicks-ass.net>
X-ClientProxiedBy: BLAP220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::6) To SA1PR10MB5711.namprd10.prod.outlook.com
 (2603:10b6:806:23e::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5711:EE_|SA1PR10MB6568:EE_
X-MS-Office365-Filtering-Correlation-Id: c9721eaa-2d22-4519-5555-08db41e1198d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a7tbD3dZzWcvgmCVMNqqcIF3YLhh+T6LEcZsJmyrujPf2KPpqtSNE3QQ7hwrCPlc2RINgL9R/dC/b6Vyd25XLN7qtiq2HuJOtBKTw27aKWelS331BvUKNX5c/DKUIeNE+Xu/FtuQUS3ZorzGc1GaSM+daw3CPSPZERuIilqzBksJgGTb0o9Han9pW4/MSLGjdtYdTdGQi9Q9NS/+ovBfqnIPcGPLhRgTriT6Q5emkr1rvJl92tyw7p+dRlkBdpHrXQjoJSCbBaLNskOp5vMUfP0c81z3Utv5+RY4Xa/L31GBkZr8OIjKB+AUqtTkmnd+p7hORhzLqm9X+4GeB/T9ugfGsibeEfWz3QXP7T8O+KTItbdWkO6fZwR29sDFRxXLpObBP3tyDlvvvdlMPiW/G0Pwby1+ysJAOUnM4UI9TX+3NBpOCTbm1vesFoA6IVFujJHsHil6aZWrDsCcRxQzbwkKPcAs8ZbcwAMRR8hWzvXFU0Agfl/BASWA/mTr5KQhAIqivMja2mJ0Hrx2iKlAZo7jk7Tb+YXxlsMxxtD2/8118btVSWoDVRMCj1V86gI5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5711.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(396003)(366004)(39860400002)(376002)(451199021)(4326008)(1076003)(26005)(9686003)(8676002)(41300700001)(86362001)(7416002)(316002)(5660300002)(66476007)(66556008)(6916009)(66946007)(6512007)(54906003)(38100700002)(2906002)(6486002)(8936002)(6666004)(6506007)(186003)(478600001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7CpX5GuKB3cBJYm+WzmSGLNCA2F9uQw1ZadN9LD0YZzQRRMrj3WdB1EJTplf?=
 =?us-ascii?Q?4O8xwUic1K7PqslmrZnGD1jqGFTuloKweILFVVLPaPJ4vmbHNZnzLDBX67qH?=
 =?us-ascii?Q?XT4R6NH63JH+mGnuReDz7D/1hHoPHl5l9RfF0eKCKFFrjhJCYCKSSXOhMfCj?=
 =?us-ascii?Q?y31O4HnGeGUtyJkz8S0/E/QJC8IlyZqFsupqTTXG6tsDNEg1JNAucLEjrrcC?=
 =?us-ascii?Q?WCugDfw6MD1dUReEn9UUSmByBBN/u3WYrHSbwY39vDV/nt9to9bC8uuV1NSi?=
 =?us-ascii?Q?6iL7hgNNDqXpPVY8Tz2jk2UWNpTnTwBP8pWegFMDOH8X8Gw9+LLtZlRCeUrZ?=
 =?us-ascii?Q?PBbWpIHuIjiUCuCaOuukLmZ6oOLdxcwgk0mch00fZlKC3yoQYeTQIx8ofwTl?=
 =?us-ascii?Q?Kzdh8cFFfEGb0fTxXTQUCpiLjxib3/Lcd5/hTyBXv511A1gbZo4cXLTu3CdG?=
 =?us-ascii?Q?iMtvWcdYY3nUQVFRBBrh1eQf+uytjPcfx7QNfFC4nAHiJcFERkN8mGJgc2rh?=
 =?us-ascii?Q?ZL05fBO2IPjdifAVnBVQyTI7+Kkj1D4UwS0QKMAQeMfO29KwmZEWmtBHra8/?=
 =?us-ascii?Q?pLZXXVXQANyPeuv1zkGfbLpLaHSG7Nv3jH76qiUyNuTB43YsYepbyqmoe9D9?=
 =?us-ascii?Q?HMBf7lE6eGJir04UrzjoTNins2M3iN34Weqtq44qG1/mvSrhKc7ludXzhNpB?=
 =?us-ascii?Q?hvscTMoLX+tZ5ekEk8B0MHtorbFi9t9MWh7WdfjstIl/BTQ2zJud6NQoI7rM?=
 =?us-ascii?Q?d6LEQprpyjaWP+CtixKlr7P3rSDh+bm/zK10N3f7yDe5hUhjn8fx7oHfWPLf?=
 =?us-ascii?Q?FjkD1+epZPFCDIUxUWkgi/UoItWVSaQ2Y9V70q53eQ0trAUBMhtvn+ulQs4K?=
 =?us-ascii?Q?NFuGe0j17qdKrPUMcG1oRYEVQCYvCg8Lj3bAI5AdUCXHdNl33sjvOGFMJVaA?=
 =?us-ascii?Q?BiNmPo2p5bkGrMlmzZzj3c4VTPm73//Pimi5YET/bHjq9w8TXO9bYb7XjtQU?=
 =?us-ascii?Q?47y2U2oswD9m7rzH+r0s+RRAM0837LLNy9N2vs0bc2OTYXtkHAHzcQ4ba3L8?=
 =?us-ascii?Q?PMb2azGtpKLOgwI41/FVauGmnmDhpMfd6qLNLhpoiSUKeC7z8R1CY219qTFW?=
 =?us-ascii?Q?ns7n5TaV0oHTgRZUMDvn4UgHaYPBKkuhukYShkb4SqM90g3APR2iGJ5GiTpg?=
 =?us-ascii?Q?ZSTbWkjNumRRt4DiEV7fAsBQP3tRZZFxCZUI2pN/iXPUxhbxvP1vAOEr1yKA?=
 =?us-ascii?Q?m2kbIOVLFhoHamNJE1OV4Y3aiOU/rJy4zJXPvjvEYNnzS01Xx7zyi8r8f0lR?=
 =?us-ascii?Q?B/O/7nS4DQJK5Vn2excePB8ZruPYRGOqWQPOL++DEjUwI5qJR46zWynJBDxq?=
 =?us-ascii?Q?gTgfs3iuTizLuAnUSf6QPdPdt5wdtwFc605Rc1Qk5IuPtzUhaxe0aWaoQNpS?=
 =?us-ascii?Q?3iILDkuufWznizhsVqCEht4UXyfNKkbFRUqLi4n4O0z1ngVrj6s2ZxHnW9uP?=
 =?us-ascii?Q?ovX2dp2UwEIIU5C9Hx5nm1dL0sDdt0tT5HuO0R/JKvTJF1C3I49wTlAe0F8f?=
 =?us-ascii?Q?XaSBnKm0hlq0L29U5BbsOL0b8n3XIEZOxM51RZBlMUOUuuBI/ykMY4jReYuy?=
 =?us-ascii?Q?zA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?IZQYwnSlCWEgetl7TEPTTR6TNYEbkcfekQjL6m55TGW8/cQhk3evE8O6Rk13?=
 =?us-ascii?Q?bJM/caEOe+o1y8SaZFgfI3R6W3PLh/URoR+cYnSQqeSD78rRHJzttEYc46RB?=
 =?us-ascii?Q?rTlDAnYyPtbwXpSGNLBa6ZVLy6YYj/Qk4c9pX6TBh8apXcxi/5Zq5TqAixOR?=
 =?us-ascii?Q?ZzLQpcwevP9yLds9pey+sjm2SJhysh/3PWSmZgzruurIqjtbc3mwgduVtccy?=
 =?us-ascii?Q?p0v4zPdj1K1bdU9tVjRI0xcyWrxBWlB8Ht1gGKMmddp+0g/9katu6Chkh6+Z?=
 =?us-ascii?Q?xQRXUiIk6tHsra9lfLv0k9/708zVUOTBeRjWLIY3KdUY8D4FsWiDoZ/t40oh?=
 =?us-ascii?Q?sosHfWRI2yugSio1Ok7k1DjLJMR2To5QnNT5QbY4rIvqZgw6JUPC3O7D+q3h?=
 =?us-ascii?Q?5OGsTf/21j2y4YOHt0qJDbUaDFS61xrtCmgmcOyMfr32iFEizsvXzOLiDYdF?=
 =?us-ascii?Q?PrX4+WqIyUbSlH+KfVdFX1m928x/D3Vmjd4hFvF89pS8t/y0qNSIpvFgxrA6?=
 =?us-ascii?Q?9FEvJdFNbg7apVPigqqLUYbJZLRUADSUZgalggX+p1HXuwJgCniBjRvQ2cku?=
 =?us-ascii?Q?RS024P4PtgHwiq19lJUajM0rZGhqT5XSpZJ7WGOr13PhAUcWpIyHE48J8KJa?=
 =?us-ascii?Q?ahwXdm87T7+BFJtZlXfQDimev8pgT7Vc58OhGeMGEezMSA81hpm1fmGKi5HI?=
 =?us-ascii?Q?+sxIcoUAbtvcBrsivbmhw3v2JZiAL/l9CYTuJdvcvgKoGa4i8kf6uoXd+1Vl?=
 =?us-ascii?Q?dxfJiLST8zmWUl2sn9OJ1WkkiWrfvpwcU3V3Fek809ukCHsCVpZ1RCLuRgjU?=
 =?us-ascii?Q?uPQwvdz/h5CdFZEMflsfFujVg28ADDH7rDGvB9BC6qCnUyr1ssGOraahw5cq?=
 =?us-ascii?Q?IZ8r1twWfI61obcv19ssicV+VzGBgapnFwXo/+iQDFryVWoHkOcuEB485Ubh?=
 =?us-ascii?Q?Ho9YT9pPrWyXS4gghNVoVA/Rw/RJh5Eb/O3QOF+hYMQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9721eaa-2d22-4519-5555-08db41e1198d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5711.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 20:52:05.7895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4edBTmFm5/jkcZwf/+z1Fk1kcULdPzOIoy1nGTmE4iRq1no0qmu41T3mx9NUlLVvmsF5494Wa2uJ1yxj87wttgw9OV34RZnzP6De57GOl6I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6568
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-20_15,2023-04-20_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=971 spamscore=0
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304200175
X-Proofpoint-GUID: miEN7aiEscQdDOutB1Ek6tA-hTqNQCQf
X-Proofpoint-ORIG-GUID: miEN7aiEscQdDOutB1Ek6tA-hTqNQCQf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 02:07:36PM +0200, Peter Zijlstra wrote:
> On Thu, Mar 30, 2023 at 01:45:57PM -0400, Daniel Jordan wrote:
> 
> > The topology of my machine is different from yours, but it's the biggest
> > I have, and I'm assuming cpu count is more important than topology when
> > reproducing the remote accesses.  I also tried on
> 
> Core count definitely matters some, but the thing that really hurts is
> the cross-node (and cross-cache, which for intel happens to be the same
> set) atomics.
> 
> I suppose the thing to measure is where this cost rises most sharply on
> the AMD platforms -- is that cross LLC or cross Node?
> 
> I mean, setting up the split at boot time is fairly straight forward and
> we could equally well split at LLC.

To check the cross LLC case, I bound all postgres and sysbench tasks to
a node.  The two functions aren't free then on either AMD or Intel,
multiple LLCs or not, but the pain is a bit greater in the cross node
(unbound) case.

The read side (update_cfs_group) gets more expensive with per-node tg
load_avg on AMD, especially cross node--those are the biggest diffs.

These are more containerized sysbench runs, just the same as before.
Base is 6.2, test is 6.2 plus this RFC.  Each number under base or test
is the average over ten runs of the profile percent of the function
measured for 5 seconds, 60 seconds into the run.  I ran the experiment a
second time, and the numbers were fairly similar to what's below.

AMD EPYC 7J13 64-Core Processor (NPS1)
    2 sockets * 64 cores * 2 threads = 256 CPUs

                      update_load_avg profile%    update_cfs_group profile%        
affinity  nr_threads          base  test  diff             base  test  diff
 unbound          96           0.7   0.6  -0.1              0.3   0.6   0.4
 unbound         128           0.8   0.7   0.0              0.3   0.7   0.4
 unbound         160           2.4   1.7  -0.7              1.2   2.3   1.1
 unbound         192           2.3   1.7  -0.6              0.9   2.4   1.5
 unbound         224           0.9   0.9   0.0              0.3   0.6   0.3
 unbound         256           0.4   0.4   0.0              0.1   0.2   0.1
   node0          48           0.7   0.6  -0.1              0.3   0.6   0.3
   node0          64           0.7   0.7  -0.1              0.3   0.6   0.3
   node0          80           1.4   1.3  -0.1              0.3   0.6   0.3
   node0          96           1.5   1.4  -0.1              0.3   0.6   0.3
   node0         112           0.8   0.8   0.0              0.2   0.4   0.2
   node0         128           0.4   0.4   0.0              0.1   0.2   0.1
   node1          48           0.7   0.6  -0.1              0.3   0.6   0.3
   node1          64           0.7   0.6  -0.1              0.3   0.6   0.3
   node1          80           1.4   1.2  -0.1              0.3   0.6   0.3
   node1          96           1.4   1.3  -0.2              0.3   0.6   0.3
   node1         112           0.8   0.7  -0.1              0.2   0.3   0.2
   node1         128           0.4   0.4   0.0              0.1   0.2   0.1
                                                                                             
Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz
    2 sockets * 32 cores * 2 thread = 128 CPUs
                                                                                             
                      update_load_avg profile%    update_cfs_group profile%        
affinity  nr_threads          base  test  diff             base  test  diff
 unbound          48           0.4   0.4   0.0              0.4   0.5   0.1
 unbound          64           0.5   0.5   0.0              0.5   0.6   0.1
 unbound          80           2.0   1.8  -0.2              2.7   2.4  -0.3
 unbound          96           3.3   2.8  -0.5              3.6   3.3  -0.3
 unbound         112           2.8   2.6  -0.2              4.1   3.3  -0.8
 unbound         128           0.4   0.4   0.0              0.4   0.4   0.1
   node0          24           0.4   0.4   0.0              0.3   0.5   0.2
   node0          32           0.5   0.5   0.0              0.3   0.4   0.2
   node0          40           1.0   1.1   0.1              0.7   0.8   0.1
   node0          48           1.5   1.6   0.1              0.8   0.9   0.1
   node0          56           1.8   1.9   0.1              0.8   0.9   0.1
   node0          64           0.4   0.4   0.0              0.2   0.4   0.1
   node1          24           0.4   0.5   0.0              0.3   0.5   0.2
   node1          32           0.4   0.5   0.0              0.3   0.5   0.2
   node1          40           1.0   1.1   0.0              0.7   0.8   0.1
   node1          48           1.6   1.6   0.1              0.8   0.9   0.1
   node1          56           1.8   1.9   0.1              0.8   0.9   0.1
   node1          64           0.4   0.4   0.0              0.2   0.4   0.1
