Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551C46488BA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 19:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbiLIS7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 13:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbiLIS7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 13:59:32 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C8AAE4E0
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 10:59:29 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B9Iln0I025320;
        Fri, 9 Dec 2022 18:57:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=w8xl3NlpLDGju2c87IBrtmXfeFf4TgHlhbhrnj6xKVo=;
 b=UvehEgS07HeIGkTUZNGdaH+OPMYELAbPjCyQdI/cmtgTCRvfxVrnf110zZ5VSAnT8hqU
 K66ee4ydNI8RfTyqZYucKpT3wLCeu2jWkEgFcAhvVBbKdjmk8ZNPZGMB2aAyKm7GHxuK
 CdeRq846t+k6Ayi9CbNmHrg+t0e84q9Xcws062O4IxIcXE+7Hl4lHQOg+p3/a7BPMuu2
 N6qxbdJj1myfp6shL4QmiLlqp6d9oox2v7QynAesZILlR4+sQddMfqMdOFuZKRcPs+vM
 MmkcjxxAwethDmi9dto9GUXfY8ODMON3LhOmRsLkYu6hvGn3bKUHmzkvOKiX/S2DpPcy ew== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3maujknq0q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Dec 2022 18:57:12 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B9I31IN031942;
        Fri, 9 Dec 2022 18:57:11 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3maa7ge9ub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Dec 2022 18:57:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nbIWBw0aIXFJeAKIVjM/duX3nVsBoq3SDthzue9UkanD7No3WnmOr4LSpbeTPZzh+VgzKz7Nm2h1tmWq1jTDEyKp0VqOBfHld9TsKNS7Ud4+P5GWYFBDG47f6HY3FXmADOGwNzQwSf3DE6kfGjs9zGorwVU/P3Nj+ibCRLYCZBn9bJ4tAXeEeYwBN5nk3SvTp2Xzu6kXdj7RSrVQ7DkKx2A/9zEqY37HDUPtMDBuU8H/pN2hXMBBaqCNhuH0juJGc0PxF8QmIcLEJgfnOsOskBPcXF/jKAdWcMWs0jMCt6ukbXxqD5aI9KhD5fYWS/yqjVO/CZ0f/AJrI1B6nULUqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w8xl3NlpLDGju2c87IBrtmXfeFf4TgHlhbhrnj6xKVo=;
 b=J61YnkrX7Xc8H9SCzf2u+PW91+msSrSbNX8BcqbfiIHjs5NiqCtzBy59KtGVS13Hx7PNHpqzbr1k1L8W+LLJABpVv+Jp2PeXpCv2T9KuYVX5d6i+4r3zaDRO84wJjbxwjwh9tdwMlhrujRyFjw2KL82uvIf0671M1vQgTqJHFN6mcUEdpbyzNDa8gTqpbRnWkP+4oNNxMysNcYVeJIcclDByq6L87lOHAfk0HjyzCppkXEmOf2QarZUXGaJ9W7lEFsKrjp6jes+s+UqC151dG8BP0oZmOKmKtDWRSTn8Edwu6mbbTLqPMH0no3GyZ4bHSpgm3br7QxdgTJmZLPR7OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w8xl3NlpLDGju2c87IBrtmXfeFf4TgHlhbhrnj6xKVo=;
 b=p6WIKTX6vpKpGvvWoaOCSUP1aQyAPs0Z7fA24fkQ+bOkxPk8pAT3kpYqPp0gSStdKc+ApF4kw3CZur9JFRYCahDzoq8nnbomOg2QlZwshnMfIPM2n9n7YC2mFiSbZ8hMBY7q53gDhweJk37kmp/caUB46dZkczTJIfePYe3RnRk=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH7PR10MB6057.namprd10.prod.outlook.com (2603:10b6:510:1ff::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.18; Fri, 9 Dec
 2022 18:57:08 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%4]) with mapi id 15.20.5880.018; Fri, 9 Dec 2022
 18:57:08 +0000
Date:   Fri, 9 Dec 2022 10:57:05 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jann Horn <jannh@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        James Houghton <jthoughton@google.com>,
        Rik van Riel <riel@surriel.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v3 0/9] mm/hugetlb: Make huge_pte_offset() thread-safe
 for pmd unshare
Message-ID: <Y5OFAfYA9sNr3m6Q@monkey>
References: <20221209170100.973970-1-peterx@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209170100.973970-1-peterx@redhat.com>
X-ClientProxiedBy: MW2PR16CA0024.namprd16.prod.outlook.com (2603:10b6:907::37)
 To BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|PH7PR10MB6057:EE_
X-MS-Office365-Filtering-Correlation-Id: ccd3f119-bdb4-4dff-bcc5-08dada172bc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pOksqAUtdNxED6bi3Tq6deEpdyyXfYSQ9tKrJWeNPWx9W7mAc3PZ71hN/NK41x+BS2FlSfVzQnR3qToEMiyKFMiAGtRAg11xMq/dF3Lbd6YTxARq/pGbxy5gekSCUFI10pRQ76POPIwEbh+8h8C1mYBBg0EEeDqpWwjw3LQHlWBU3iQKxWeQKV2UxrSqPzP4mzj8Ts9MzViWY9CM1XVuy2F45fE/I/wQRamp0K5nZkJQZVjFLLoOmKtTtFKW8Y95eHzMM/eWDJxchXrgp5oungTESPlNoRwkezJhVwOyEe3xAuhj5I6rw4ZIHVhefdpovjMD1C3j2pyiQUoHpc0bksAv2NGauTNNIgbX380/MJhRkzJU2gbhpBkQ7p6ZC3JXlt0gvP+jNV9AzY8K9ctbr31lRGm+VOmOkhxQ/M9JPOeldxyBCNg4a9HHXGMikupEV1wytY1zuTuNtClZM88BMs/iAXp3EUEjyMpQxcqkEDaBvYe/UOncZ1zs7/tbolY4cYOCFXOS7Z8dSzxh4sU3L41ciLRGtNol/TbUWhFip98eb7OL4HLHiPk/idinTS2wXKBV1SeElhY8a7mH90xv6AbbQu+HeUIKur6O+UxQq161wq0nbn9oMkqm+b6aISR2cXZlOwW2xsZpMRRQI9oCbZ/Vrb0mbtFZe4vptCO/9iIAY/GLHli6eu7gs4I3cg+P
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(39860400002)(376002)(136003)(366004)(396003)(451199015)(44832011)(2906002)(5660300002)(4744005)(7416002)(41300700001)(6512007)(478600001)(9686003)(26005)(186003)(83380400001)(66476007)(66946007)(66556008)(4326008)(8676002)(8936002)(38100700002)(6916009)(316002)(86362001)(54906003)(6486002)(6666004)(6506007)(33716001)(53546011)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pmSOTCq/tNX1+h1fAB9vjiWOkKC+ZrAHs80ZZcjnyBIye2xDzyD5wjZzJAXb?=
 =?us-ascii?Q?K8v0sl41t0Y54nKwPM1FVJJcFwYA1qIv8TOpou/ZeFDfrhG20nsYn3llXuWS?=
 =?us-ascii?Q?GHkBU0sCt6ITqpbRuv/T9ZnNH/25hJbjbX1Nq/MCiyCZp1dsdtAGccAs+TnK?=
 =?us-ascii?Q?Ha4/PKytUodaovEW5k7Ex85f3yMBHF85kz8FOElTETYQ4b8UpT4z9XyEbzrf?=
 =?us-ascii?Q?/AjFjDT/2apNYGLVJyV+Bzf/Q1wiX/PlbOWg5EX9Wqgzs37w9vPZSkjeqVqW?=
 =?us-ascii?Q?x/tgnn3602/2SPUj/Fu1eCHn5d8UxOEgnb20Il4IbHTlC99+d1wwuKBqkkxD?=
 =?us-ascii?Q?nu3XguuGLgxwpwsXAnAEsgA01TszLodZzF5Jznu2iIxQaJIfExRqz0csx0XT?=
 =?us-ascii?Q?5Mj3QSE3PXzYsCVZZV0qEukayP6dgx0Zr0/4qF2Ro0+P3zjdly8bT3U5Vx/8?=
 =?us-ascii?Q?YbI865gMdBTaf7YGnv1W6ySuoKbmnQuxznuvr4wNC+h6ElS1sg643H0bj+tf?=
 =?us-ascii?Q?PCRbLr6juApmsRe6c2eCDRE8S1Dq3NDl3F2dEWVYpFw45Y1Bee7IBsw9LjuY?=
 =?us-ascii?Q?ea0eGePDRHHQMq528ctAy1tFhiGO33Dor7U6btMqnItDZ/A/40uG0V+e6mx4?=
 =?us-ascii?Q?f3hYl8wbJzsYLYeocwGs0xyMSLUZeDWe3KtnIIC9pmPJuu5d2BTtsZxD0bnI?=
 =?us-ascii?Q?3uBRfrXeYhA++1/W67vdHawrPlDAiC+QFtQGlDOZb/cnY2du7AveSazlR0Zf?=
 =?us-ascii?Q?Nn0T8HhahJXZPNYrd5165PQykQfxssXhKLXJpDdqtOGa/oXekTeMYx/rzie3?=
 =?us-ascii?Q?2iIKPAoIzvit58iQqMLw8BLAktDyEaKBwQDQwswyw2DnDEwjufWaDUYY1WSl?=
 =?us-ascii?Q?ebCdv4EwUkT5U33rfD73l7WvXCyuGMEVSd9mFjVSevepfQg/driEHzlYQHx0?=
 =?us-ascii?Q?ItedrLBmKsLBhqHUac6zuqg2CH5GZ+DapvsLygvJ/oJQxf+4FzPKPwzoXZ+V?=
 =?us-ascii?Q?qLtC1ib4VC/dvW3O5Ym7YOttWU9LPVVqzCZbU13NSebbA0HSBkftRt+a53XL?=
 =?us-ascii?Q?RnJNeAfwNpTQLI6odF/Zvv+2ojlgujWpb6EZZyg1XiafHtWBGW29eigoW3Zr?=
 =?us-ascii?Q?nvlFYO6SE1em5UBoHjNfELYi9s1ULWNzDSAbbKDUxcDkVXukjsd7PrNdI4l7?=
 =?us-ascii?Q?Fks5JrvUSgB84RuSEy0Z/tZsd87NfsQ2DIUp+2iOSntVUZmQoepnYqg0XTud?=
 =?us-ascii?Q?hvm5SvW5dmaONNl+Iofeg9Ek3rTIp794BvpiQPtowY5thyWMKZGGC7VQ1Aua?=
 =?us-ascii?Q?DFzJ1pdFClM2x04mTrS6UvJz3eUzC5XbHMMnc6QNSr0BmZrmi+YsiUR+ak6G?=
 =?us-ascii?Q?6YqL/zQN4/9KNPHZYdY0P7+JxQ7YK+gmSP2btiQbEdC5oNLMYrv29dB5bRCO?=
 =?us-ascii?Q?B+2aTLTHcIFzvr15tTFO+dL7EdeBEkUGP15R5GZEz840FwEL35ZPwJuZA+Kp?=
 =?us-ascii?Q?V/IkbhqWhB/vOIwgG4fUDEQdXsqy0aaq+gtKRJcqdyk7VsRbtSpApvO8Mmim?=
 =?us-ascii?Q?y+hhoSG4DlJxtK8D9hqdyxsOfpY9yUodm4fYMRzrU/7z1+exZug2b3ZSZoGq?=
 =?us-ascii?Q?dA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccd3f119-bdb4-4dff-bcc5-08dada172bc4
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 18:57:08.2731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AJXOZMoFSdvghMQwSEumoTxKwEglJmGjhXv94HNTHXVqY5feLDCQs/I9OfftDwlnYgmZoh016SMDJ5bc+9ixEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6057
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-09_11,2022-12-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=842 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212090153
X-Proofpoint-ORIG-GUID: 4MPK0hwWeoftBlGSTq2_3xdo0ouO_GuX
X-Proofpoint-GUID: 4MPK0hwWeoftBlGSTq2_3xdo0ouO_GuX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09/22 12:00, Peter Xu wrote:
> Based on latest mm-unstable (dbccafc6e992).
> 
> This can be seen as a follow-up series to Mike's recent hugetlb vma lock
> series for pmd unsharing, but majorly covering safe use of huge_pte_offset.
> 
> Changelog for v2->v3:
> - Added a-bs and r-bs
> - In walk_hugetlb_range() hooks, don't release vma lock for cond_resched()

Thanks for your continued work on this Peter!

As a followup to that discussion about releasing vma lock for cond_resched(),
I do not have a strong opinion.  Glad you kept my r-b.
-- 
Mike Kravetz
