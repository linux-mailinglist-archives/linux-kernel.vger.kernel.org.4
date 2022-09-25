Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498355E947A
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 18:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbiIYQvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 12:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbiIYQvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 12:51:15 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1922AC51;
        Sun, 25 Sep 2022 09:51:14 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28PC9jiX003741;
        Sun, 25 Sep 2022 16:51:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=SVjJQWzVJD6tfdVok/+WwQVOGqn6N0MAkrmSHMDczGk=;
 b=piptR/HnUC6xAT3jKpagf+OPc2JQWlhHpOgO/GzHczXcEA76qCOetYtWF58QBCaotDI8
 SsBfeXhbU8Fm1VpATubFuu0CMEkeWq48C7ndWgHN1dvpez94sAnFau9DUFfol9Iuk0pp
 v5bAIoBmKY2WojM+SZB0+ysBnOYzkX7QvG0MZlEf69qXwNeJ2ww7bmrRAzvtZIMoBP39
 jWSD3OYR2ffjnTA/UKr78+/KScPeOJOtQjo5r5Qa11nZaMHZJReY1TdULiEj9sF31BKI
 13cz59CQxetXZrPbH+/GUMXwgOG+Pl/4n4BdAG3fFuI523UAkIvp+2ozQkNW/MB5AJM8 Tg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jstessws1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 25 Sep 2022 16:51:08 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28PCAYHq002671;
        Sun, 25 Sep 2022 16:51:07 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2174.outbound.protection.outlook.com [104.47.73.174])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jtprska3j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 25 Sep 2022 16:51:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wqn7vsZCX8XzOtwPcQJ2sJANH0LawX5MLc9hYRNlArEnmDrvvvjVtgzzMpJ8g4biyJxK79Bjttj8xuqF3Jv3VBGKPiWBv3j9LiS8oavwUlAVaCjnzlXEzV1Rc2uiKm0icUp5arr3k2BRL7DUtq67TPREDq1sMfgP4NgqEknkgFSbqWR63at5gvxGmKXxEQnNgiJdWYwfeDy7jueXLqy2Gkffe2UVp445HOKz4UT8LoYe/+eTfiUV3Hr/9n6wrgmW7CsIRl/bQ+PTUUpDjrio78XGnwe84P0UPJfxgxHIbG7ZrQQMPQ1OmPQ5ZlgGK9mVsGvSDrw4oQBLuvvrsky2sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SVjJQWzVJD6tfdVok/+WwQVOGqn6N0MAkrmSHMDczGk=;
 b=HKpEQ8+YO7QyCbiE5CAPrQQQz4TNNpsXpywB7Z9B1bj8wJiwsJQQWZKP9MvWyaORsz4XrucycbgC0zMlYVh0Hz5o8vjTa6n4WyI3VPGss8u2Umdc9kGz2J5R4ltBISLJ8wW8dYK0kANwozckoa5LiZ8hS6dGhxpyscWAYEsEyMGhMn3WfIrOii99r4RNrtPQJ+pE7L0rGgpednuKnREu0uKyO+RMWagBF7PlYAO8EfTYcImEwJQf5Pl2F5cbvTOb6YvpZ5IS7Q7X78gHj/OCka6/M3evuikKxf1W90ZEjy8QUffCB+xVzrFsrrFS5GnHzY6qQXS8FsIrlNQ6jCBt7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVjJQWzVJD6tfdVok/+WwQVOGqn6N0MAkrmSHMDczGk=;
 b=FcHhVWQJ/pVsm1hQhQHdhh0P2dgwCocIlR9+Bm+BkqSoEchMJCYbM4meLkUnVursbb6Tf5VlP0KO2KEjVRS0WAaAAXVoxXecIL07jJ3WQuqdSUjKgWrYEtTde3IfKer1qlfjnWYHcWcdBBTB0w59ATU9Li2J05uiQrhWFDMmZ2E=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SJ0PR10MB4413.namprd10.prod.outlook.com (2603:10b6:a03:2d9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Sun, 25 Sep
 2022 16:51:05 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a497:8929:2c6f:7351]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a497:8929:2c6f:7351%5]) with mapi id 15.20.5654.020; Sun, 25 Sep 2022
 16:51:05 +0000
To:     Arthur Simchaev <Arthur.Simchaev@wdc.com>
Cc:     martin.petersen@oracle.com, -cc=avri.altman@wdc.com,
        Avi.Shchislowski@wdc.com, beanhuo@micron.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bvanassche@acm.org
Subject: Re: [PATCH v2] scsi: ufs: Remove redundant function definitions
 from ufshcd.h
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1h70vs8id.fsf@ca-mkp.ca.oracle.com>
References: <1663761485-2532-1-git-send-email-Arthur.Simchaev@wdc.com>
Date:   Sun, 25 Sep 2022 12:51:02 -0400
In-Reply-To: <1663761485-2532-1-git-send-email-Arthur.Simchaev@wdc.com>
        (Arthur Simchaev's message of "Wed, 21 Sep 2022 14:58:05 +0300")
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0088.namprd11.prod.outlook.com
 (2603:10b6:806:d2::33) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SJ0PR10MB4413:EE_
X-MS-Office365-Filtering-Correlation-Id: c8a00021-b096-4f91-b537-08da9f1622ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J2zZQxnKmS8gKZyFAMWBTNeo/x2zbnNc8AoPTnDy40/sMGTxS1n2AOehNUxNPHzEOy4mfVU9IcJl2t6Zrnnepb19qtihip8j/ss3F4Z7KD+YYPjaibhHYknmrxLnWpI6lTPzAKKR1N0y6v7lE0ONMnnahUIP77pTMKIcDlRBmW/3dzOkSF6aWMrPAv5TpCcx4F/R7JuQvCugn17w87K1wQn1MrkYXJh072KZTVosVBGPuPuzlgw0MRXd5QC5hJTqKVLPlE678V1jp6egBoXDmaavKGOf/mQnIhWbnJkAu+hImH+iiL/NUSn7IPDWESd//dGT5Rkj/LncIyikA7oRXx/okuEffF/bMhvZtn1ca3CH32ZDWBHrXzaxJj9VzwNjjljU3/V8K5gyqXbZO+DgKVB/7Ryd8J6nO5Zz7L1oIl38g4ZEzOI9i0hcsyYtmkiViPuM7abo02FtTEc/AIrfL/4wM+Kpoi4+NJUIAihnNU+Llv8typkvVYbb57e0DqhU50Re5pPnQ7g0nAIHlGriSvNVhLrByx59xRfQCV4iYFUhiuooOsTI1tSmJZ2yN65v8h2BMYkWYgDrwwHB1NotYslSLA6ve4ZBo5hrvq0Y55jBloIQuqYAwxTcJBXAQFpxMt2/1VLy4xEwNO9bhgGEgMKtm+Ebyxaeo0TUMyqCGdbtZf/Ejo7QFsp2ig7tDgWrY/8wCZp6F6N7Q1xApnyKSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(376002)(346002)(396003)(366004)(451199015)(6916009)(2906002)(316002)(8936002)(5660300002)(558084003)(41300700001)(86362001)(66476007)(66946007)(66556008)(4326008)(8676002)(83380400001)(186003)(6666004)(6486002)(36916002)(478600001)(26005)(6512007)(38100700002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MVdM9HqYg/l0wJ6s6MFgoDY37lj1e/GW2Ynr7v4LhYhSjy4TUjHouc+OMrr7?=
 =?us-ascii?Q?bFDUgRnsYecqCkzkUNUapdQOdI2eI65qPmXsJ+Ne0Uy6xTxwBz7Mw4fSs9dg?=
 =?us-ascii?Q?sPwYZ5p1PLKcRUZYE5H8/iJVFg+2zLM1fW7osT8uvve/CIIHOXcf6jSQ7hwj?=
 =?us-ascii?Q?RTMktWwpxMkttZwZJ71LRLZyn89VmFEqNP/El7lB2fWdkMQrCMS1zLI5oW0y?=
 =?us-ascii?Q?QIk+dO583IFPRVRDuRmntjui8XMVAah6dlM3BZ3e7G8eXg350aKIz8P4hr34?=
 =?us-ascii?Q?mmHfNANEkC2bZStu17sUdZcPb7FfVCP42sctSDb0ttwZnPtpONUnTHaiM6q5?=
 =?us-ascii?Q?Yl2k0XpGLaONoI4ArwJ6cClPw6KXf4P+KRHzN7H66ruvK24kw+n8avBxH2uv?=
 =?us-ascii?Q?y0nYO+V0YLcaL9RkO96n2w1mX6sUQfErv2vsOTT8fAnQXMixiqYMQZonG+TK?=
 =?us-ascii?Q?PCqb7if+r2XrBuZEv4jADGgi4/7o2IVRWpObvo39P5ZSOAQBre7XQC9I1JIY?=
 =?us-ascii?Q?nbVR8SOEEJC3uRR1yX12t/OA+yvmHBw32bRkWFGI2bN55PE2G4xcG3cAifTh?=
 =?us-ascii?Q?M+bLD3YU/Q5oAxLyswMWn2CAcoy+6dxn6QSYmnVz8nIE3E621Ksi34U4Uhj2?=
 =?us-ascii?Q?kjSbVkohiBPeDHg2DMmgKEevcOLiHgnSEqbw7Vbdb/7mhzNOirr/feSh/i2F?=
 =?us-ascii?Q?L4qbg6BXpVyJzdYyLdb7N3iopEtUVwHGfRjyMd1VvAlDLZ3s7+57nnYWdBnO?=
 =?us-ascii?Q?0ZSLPv5W7dvI3cw6GSCX7HNKp+kZYd1B16ZanqvrfnYs9TsGJINFjYSxytd0?=
 =?us-ascii?Q?l83G0inM1YQvkIZPCZOU615YYIZAVgSB+PhCs2RQzgkeJyKjQZudtLuokBXo?=
 =?us-ascii?Q?aesHLyJN6XWIYe8suHPMdQDvX9nTn0MFyHggbLi/z9fp1LguZIQ1vxwN+N53?=
 =?us-ascii?Q?P9tIo7BT/0ONDTkumO80T8mXD2sUbc706byMYGBbHalx715dXkZyIBJ0rayo?=
 =?us-ascii?Q?n8KrI++aNkSsbpPBIqrWAH/IIEk5f7M44H6OxGhVAwY6bb93PgcVbFri9fWK?=
 =?us-ascii?Q?O/Lk14IlTKTeWeXdi2mrOi28LPq1gCyvB9XBIBpWt1aGJnnSZ+94NxHKDK85?=
 =?us-ascii?Q?3u6/AackRBmY8TFSFRFL3DvLHoBdIEZWZbwaUJuQWthYzZOTQ4xBz1vZ0nFp?=
 =?us-ascii?Q?z0SGtb4KrFD2bsgSOMXLcgwl5ay+W0ZbncbWenAVI3+GcgPAATOnyTp5nKmV?=
 =?us-ascii?Q?BId9wf79HgRkR+nSeT6Yro7t7qCrKsYukQR5u91HDgicg/Bsu/JScchMS+cQ?=
 =?us-ascii?Q?NkaBizqCi1HsStEiHknrTiYTNRov9WgBbYswR6o9GPGPsAqi92tVhgNU7ryn?=
 =?us-ascii?Q?bjwvIf3By5eFTpONKwHvzvDyrONFYC74By3L40PZJT+rX8zWNqkI1uEROphP?=
 =?us-ascii?Q?qjTog8ZoldD8xSS7IWX2aCpR4KNn+Mt0SKALnwVtKRtZb3ku83oCzqHpwBwG?=
 =?us-ascii?Q?PVkmoR/gpv9cxZJsBtvmgNNchoj3QLvP34EBrRB571+tLpsLcQLQe71O7Yfr?=
 =?us-ascii?Q?nppzBlKTSJ3KiVEO/DmR0qj9dvYC2/1xLSODJtx3BT5XqCUuy9pg+2yGiw5w?=
 =?us-ascii?Q?ng=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8a00021-b096-4f91-b537-08da9f1622ea
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2022 16:51:05.1656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: niZEgy1I7NBH2GAbPaoM7U7R9jTQ3U/KxJFXqs2ld7U9w2FE4+kiYWNeGrK4wD6ZkaNB2CZ3nwFUSYxcwupCouboJX6P1scJISesn8jwVDE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4413
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-25_01,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxscore=0 mlxlogscore=684 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209250123
X-Proofpoint-GUID: Qe_hm27EKKjzZfQFZVepTx7VooklqbFN
X-Proofpoint-ORIG-GUID: Qe_hm27EKKjzZfQFZVepTx7VooklqbFN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Arthur,

> This patch removes Query-Request API functions declaration from
> include/ufs/ufshcd.h. Those declarations solely to ufs core private
> header.

Applied to 6.1/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
