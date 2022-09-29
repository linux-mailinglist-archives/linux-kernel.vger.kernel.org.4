Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783365EFE8F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 22:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiI2UUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 16:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiI2UUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 16:20:07 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAAB43B706
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 13:20:05 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28TJmwXN012062;
        Thu, 29 Sep 2022 20:20:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=bLIdoX87E8vPE0HpjhmSECkIAW3fIlEg6ekGhn4tZiY=;
 b=0C4j7qzInwrfjE+jn2jtG1/pKX3tWOhpd8qXTHy05gP73QDNuZ2g/Xbr7pyFjHNnSXFH
 x86cfzGe1F+1BSUKh8/vnZ0Ic2THknRurDiDCkpy0Rc0+V05BXx89Ng/z/GevofSu575
 I/n796SGiEmhS5PUpkoQYlndVu8aXe2g4xLO5A7LGVW+msT3OIq4okKtSZZ+taHqvrcI
 yMUh0nzPsrY/2aMlBL/F6hFb0VvBNjP/6aG8SFfAKi27w4+Q9OSdQBxpRfzlFj6ckvWk
 7ZgawyUsfVq6jDi9G+dnqa2nBo3WA0yb1ST5VIK2/iACnSKJweSsJ+DvlSTbUMV4BEZR nw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jsstpwd78-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Sep 2022 20:20:01 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28THVmhF033772;
        Thu, 29 Sep 2022 20:20:00 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jtpv35kfn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Sep 2022 20:20:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K9UXH9n4zbmPXjNPm6KhKb9/pf1wfs4P/m2emBkatv2+Xktf5YSMttxHSxTSgGzOpwg/cjwpRru31Jtl2gVJtXuWSv7bWx6F7KEHmDyNsbyPIH2tAyWoAZj4MRR5qi6Sp7pmGej0p4eMkQsMVHSpMQ7QkUigE6leWVZqPZVBN/yZl9SkTAtn3nJULSUmEnjbGAsXTXSCvg7zklZv+xFQI/0nwCGx1CBV16peiUUczaCPkl7eTZDssNItrQE2c0IdKoc5yqOV0IWriv5Eg/EPM+N2OE1/rW6HkC04c9H6Osyfg41JDoFgTHw6uKfvW6+8ojIFYkaYPm1qzC5ei+eNPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bLIdoX87E8vPE0HpjhmSECkIAW3fIlEg6ekGhn4tZiY=;
 b=hDkKUaezkE6VAz0qww+J2MRPxAN4XHouSWCVCFpsDXPYTzUAanuM1ARjR8MbxGzf3Oe/oJ42xPoTSs/D8i5YFZlM3OMdAdyvXmnBbRgjfk7phK3VBRr8se6qTBJfRaLyST9M/KqwS4YbweYlycvu7MQ8YXppe7tKJDxIq3jIg3Sd8/oOORht10zBs9xJmToZdOamBj0b1IIALk6YG17tgVorTqpxMawwA2PK83fKccsEqq7UOEc6k6x2a9GkVzcrhoGK6npEaQwf3eVs6jG9WgT/UD8hDOtoA4Oh1qj11c5pdTHh0UZJtn0emkzoJzq8GrbtTGb3A1iMr62JpnAo3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bLIdoX87E8vPE0HpjhmSECkIAW3fIlEg6ekGhn4tZiY=;
 b=zu/sVNiutpweu1LBYT0y5IdSg0t5UfDrzQ/bq/pHpokzGHPLwb56Q2DIkl5frD8YUbh3rKK/zwJJnHaK8yegJ2gN8nLcnvxB3n9oNgZagRUBMyd7pMlNDhZgDwi5roPuarruJ723ydJbQleNPVy6PdA9ujqbs4yeHTRvR/ogbqg=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH0PR10MB5779.namprd10.prod.outlook.com (2603:10b6:510:146::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20; Thu, 29 Sep
 2022 20:19:58 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::4c38:703a:3910:61d6]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::4c38:703a:3910:61d6%4]) with mapi id 15.20.5676.022; Thu, 29 Sep 2022
 20:19:58 +0000
References: <20220927225944.2254360-1-ankur.a.arora@oracle.com>
 <20220927225944.2254360-3-ankur.a.arora@oracle.com>
 <CAHC9VhRBuBiuf6917fpP7n+Sy5fFTpzzEqRXfMGPCbnNU4jswg@mail.gmail.com>
User-agent: mu4e 1.4.10; emacs 27.2
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>, linux-audit@redhat.com,
        eparis@redhat.com, linux-kernel@vger.kernel.org,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH 2/3] audit: annotate branch direction for audit_in_mask()
In-reply-to: <CAHC9VhRBuBiuf6917fpP7n+Sy5fFTpzzEqRXfMGPCbnNU4jswg@mail.gmail.com>
Date:   Thu, 29 Sep 2022 13:19:57 -0700
Message-ID: <8735cagcgi.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW3PR05CA0019.namprd05.prod.outlook.com
 (2603:10b6:303:2b::24) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH0PR10MB5779:EE_
X-MS-Office365-Filtering-Correlation-Id: effd1dd9-fd0f-40c5-d1ec-08daa257fad3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nNzGJoLHX8N9VHzy5AbsE3Wvwcke/68qP43NaouBnII/DYzdlFJLKaQtVDD7lMrYcXb+uwdtgTu7bdcuSa3ftkkw9F6rXU3/oapYjJ3Buq72KS7uPs2xWEtYHtgYgmlp9xsPtjFZnxcX1RhQTYBZwhFFQDCbx3/DGaCayxAaMejX3ymwPNaRrYuw8TaccGyb7Fzxad4x1EyfweMY7fKGfXXV9gpe4WU+pIxMt/G6vKtLWArhddo0S/1bxwH7vxvVxPKFbtMIMTpjCXFiHkrYRCJUXmq1iR4kfG+vdGU9C9lsx4EMAOgmiUFgZPPPCVmh01nJiRpQQE+9VCzb4zeSBN4+6CTPr/W4SRddTly7RJiwNwZdri3iLUOIVMA2KQFR5aU2jkTVVD3WEKB9g9QfVhlveS1QtrCh68aOl/5WuZBHacug5TPpMjxMkftfU7tULeRltAUeDghWILDKL+WhrgBs2qvaeRfxyB2QBW+tPVJAuH0veXEyeJUizYYluKv/eJ6KnppekBUsVDxPh7XUPC2I18lFbi6zN+EcEYipUpGKKraMq651qIs7mBCWXbMdvCvO92DR//avZ9IyOwDRWVlL/jOjqZTrYhZuh5qnb3CMvLs/t4rUtXgoVmBRlx6ol85qod9QWMedNuyM/IUV+z895tPIAdK+0VyxiD/W3P1pS4ZQjtIOkXnjBz3lYc/Om17Hxp4mniggCtDtlxQnqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(136003)(346002)(39860400002)(376002)(451199015)(478600001)(38100700002)(6486002)(4326008)(8676002)(66946007)(186003)(6916009)(36756003)(26005)(66556008)(66476007)(6512007)(83380400001)(2906002)(8936002)(41300700001)(53546011)(6506007)(107886003)(316002)(5660300002)(2616005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q6tSaMAzrwkXL1iGOB/rZjB0fbdeehEDtgAjzKtZkjD+DccKkH0YPOuay9e5?=
 =?us-ascii?Q?pOeNwsqfmwzKzMI2z9E7twt7iMfMjXheb7ayPtFedyPGmr3Lh9CUetVUzxOV?=
 =?us-ascii?Q?PqntNHxJVrH9pzOao9QxdzK+ehdMueSJV61vG4pFOaMrYWESowepaY6fvw76?=
 =?us-ascii?Q?Tcq73YrOSvJkcsPfEvo9qbQPGT2Pvrgs6tRyiKyL4Q3jEyi5rlYLCBD9CZ1g?=
 =?us-ascii?Q?pKio8Y/R5nkRcDg7NUoK97KDILH4ERgU4sDEEBQtQ0OsDhpZdjm1WS42SUeb?=
 =?us-ascii?Q?8nVdJFVaizYRtbuEbLYMbjVp0N/lpjr2iNB/Z4kMB9GCn7evn1ZQ2u3QCXgP?=
 =?us-ascii?Q?9hLJiNeDYB2htkHwMQItEOl0zwzKtwPFeBIvbbDW47YZyacyvKk9TbqiwMHa?=
 =?us-ascii?Q?N8Co2juVMQmm83IpJRLzTMIXLngnV1x3Rc2153iX6MDDksraW7LgDTd7gxuB?=
 =?us-ascii?Q?Am90rmuzc+jMEzHvsWtrQUCtb1V55J8F0V3+/rZEL0b2JSk/dbT9Rx9THHwJ?=
 =?us-ascii?Q?+2nBC4A2XlxUDPcEpPZt/+esOUxJleQuKscNe170VAZuwQdeMNp7f4dQTbJJ?=
 =?us-ascii?Q?6ZRTHYIffnopjY0Cw2DEBZ3FRSV+RLp/L/Z5bq6bSACa4wfYCybKaOCzIvqY?=
 =?us-ascii?Q?eXkwOA0trOca9Rj6Q/aQUr+zxLuZjibNQBjIn79hLMLlzT05H6gvHMIIlAbN?=
 =?us-ascii?Q?2Q8Qk0O7sOUGYSXnWmEVLw9CSY9uLBd+uh6lwGj03ikl0L+0+e+ryVokdta6?=
 =?us-ascii?Q?zWQ4u+EfNEiiIgOZPIt5DDAL2CeJGz2cnyXDmYU+jPsxg0IdIu1Mg7HUSHBP?=
 =?us-ascii?Q?DyyQQ/pQN+7EVTDry4DFtwFuPCWIAZLpr4SfkeeuheyH6JB2vESy4b5EqjZW?=
 =?us-ascii?Q?Xau2jnuIWsAL0DnVK79sN6J9JgKwplkynw+s/VzjwcqylloNpYzbr1kYc7W6?=
 =?us-ascii?Q?0ouEwaJzX8ReeQEkaGwM45nxLpGEg4BHt6vC5x3fOYbcdjH36YBjtEauI3HR?=
 =?us-ascii?Q?NN/eRtnomzyJXmNUARMtMB3QZPsb0g3CS2Hoj6eYbO05jFAWKC09NsJfPL3t?=
 =?us-ascii?Q?X7YlyObHPjnN0DmI75ib/Qfv8Yf0NZqltVGW1YapIQV10ba0gYQEXVMCJhXS?=
 =?us-ascii?Q?ETSHKJebjXeYVbrIUjEaY7t37Bn+yCgSwENXjBQlkMHm0wIg8c+gTaxxTOFu?=
 =?us-ascii?Q?BT+TFlQE2yIs0otcP6Wm+GpkOF/XDehcw2JZ7wKWeXUXxJ2i06nRNBzybekl?=
 =?us-ascii?Q?3jjrvDwXs96XMLrJMz3J5phK8SbRrRhlhDPdCeTGJQy1bwWtwzpLgVpQfDGo?=
 =?us-ascii?Q?S5xyw/sB2tlWEKS4cpQAZc7DOre484kNaU+t2gFvS25ee6erS7WmanJCd2/2?=
 =?us-ascii?Q?OGZZ4BZY3zTapSauOWsvvvX05PL6FNZ8dqLKXCYlASnu+1SoEl0Xy7tUOIaq?=
 =?us-ascii?Q?lVKdtp6LSBtfbTtats1q8LobFEtOohsnQl/6YNGJ+evEIoBlzQu5eMG3iKIt?=
 =?us-ascii?Q?j0uvxHa9WMeE3CD4jgP+HtkGzvDPDlgqqAwIL81IRfqFqiIFpwq5pr9ZTGRT?=
 =?us-ascii?Q?eNWEG6ME300YoS1FEKjNySMY+TpB4bpkEvdB2NMetMnQ20FKYBokfFJLNNbb?=
 =?us-ascii?Q?2Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: effd1dd9-fd0f-40c5-d1ec-08daa257fad3
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 20:19:58.7261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CtCRR1CmsSlCHeFhQ/MK7QQ+ciW2FgL07Vz1bEcoZhe+QN7dJIdPk+5eDm1G8ywkMGefRtqKJc4XDzThZq0n8VT17dhc8iXNslPHSQndICM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5779
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-29_11,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209290128
X-Proofpoint-ORIG-GUID: leFE74JVTL-7_7BHeCE_T-sRm69-P-FR
X-Proofpoint-GUID: leFE74JVTL-7_7BHeCE_T-sRm69-P-FR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Paul Moore <paul@paul-moore.com> writes:

> On Tue, Sep 27, 2022 at 7:00 PM Ankur Arora <ankur.a.arora@oracle.com> wrote:
>>
>> With sane audit rules, audit logging would only be triggered
>> infrequently. Keeping this in mind, annotate audit_in_mask() as
>> unlikely() to allow the compiler to pessimize the call to
>> audit_filter_rules().
>>
>> This allows GCC to invert the branch direction for the audit_filter_rules()
>> basic block in this loop:
>>
>>         list_for_each_entry_rcu(e, &audit_filter_list[AUDIT_FILTER_EXIT], list) {
>>                 if (audit_in_mask(&e->rule, major) &&
>>                     audit_filter_rules(tsk, &e->rule, ctx, NULL,
>>                                        &state, false)) {
>>                         ...
>>
>> such that it executes the common case in a straight line fashion.
>>
>> On a Skylakex system change in getpid() latency (all results
>> aggregated across 12 boot cycles):
>>
>>          Min     Mean    Median   Max      pstdev
>>          (ns)    (ns)    (ns)     (ns)
>>
>>  -    196.63   207.86  206.60  230.98      (+- 3.92%)
>>  +    173.11   182.51  179.65  202.09      (+- 4.34%)
>>
>> Performance counter stats for 'bin/getpid' (3 runs) go from:
>>     cycles               805.58  (  +-  4.11% )
>>     instructions        1654.11  (  +-   .05% )
>>     IPC                    2.06  (  +-  3.39% )
>>     branches             430.02  (  +-   .05% )
>>     branch-misses          1.55  (  +-  7.09% )
>>     L1-dcache-loads      440.01  (  +-   .09% )
>>     L1-dcache-load-misses  9.05  (  +- 74.03% )
>>
>>  to:
>>     cycles               706.13  (  +-  4.13% )
>>     instructions        1654.70  (  +-   .06% )
>>     IPC                    2.35  (  +-  4.25% )
>>     branches             430.99  (  +-   .06% )
>>     branch-misses          0.50  (  +-  2.00% )
>>     L1-dcache-loads      440.02  (  +-   .07% )
>>     L1-dcache-load-misses  5.22  (  +- 82.75% )
>>
>> (Both aggregated over 12 boot cycles.)
>>
>> cycles: performance improves on average by ~100 cycles/call. IPC
>> improves commensurately. Two reasons for this improvement:
>>
>>   * one fewer branch mispred: no obvious reason for this
>>     branch-miss reduction. There is no significant change in
>>     basic-block structure (apart from the branch inversion.)
>>
>>   * the direction of the branch for the call is now inverted, so it
>>     chooses the not-taken direction more often. The issue-latency
>>     for not-taken branches is often cheaper.
>>
>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>> ---
>>  kernel/auditsc.c | 15 ++++++++-------
>>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> I generally dislike merging likely()/unlikely() additions to code
> paths that can have varying levels of performance depending on runtime
> configuration.

I think that's fair, and in this particular case the benchmark is quite
contrived.

But, just to elaborate a bit more on why that unlikely() clause made
sense to me: it seems to me that audit typically would be triggered for
control syscalls and the ratio between control and non-control ones
would be fairly lopsided.

Let me see if I can rewrite the conditional in a different way to get a
similar effect but I suspect that might be even more compiler dependent.

Also, let me run the audit-testsuite this time. Is there a good test
there that you would recommend that might serve as a more representative
workload?


Thanks
Ankur

> While I appreciate the work you are doing to improve
> audit performance, I don't think this is something I want to merge,
> I'm sorry.



>
>> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
>> index 533b087c3c02..bf26f47b5226 100644
>> --- a/kernel/auditsc.c
>> +++ b/kernel/auditsc.c
>> @@ -789,7 +789,7 @@ static enum audit_state audit_filter_task(struct task_struct *tsk, char **key)
>>         return AUDIT_STATE_BUILD;
>>  }
>>
>> -static int audit_in_mask(const struct audit_krule *rule, unsigned long val)
>> +static bool audit_in_mask(const struct audit_krule *rule, unsigned long val)
>>  {
>>         int word, bit;
>>
>> @@ -850,12 +850,13 @@ static void audit_filter_syscall(struct task_struct *tsk,
>>
>>         rcu_read_lock();
>>         list_for_each_entry_rcu(e, &audit_filter_list[AUDIT_FILTER_EXIT], list) {
>> -               if (audit_in_mask(&e->rule, major) &&
>> -                   audit_filter_rules(tsk, &e->rule, ctx, NULL,
>> -                                      &state, false)) {
>> -                       rcu_read_unlock();
>> -                       ctx->current_state = state;
>> -                       return;
>> +               if (unlikely(audit_in_mask(&e->rule, major))) {
>> +                       if (audit_filter_rules(tsk, &e->rule, ctx, NULL,
>> +                                              &state, false)) {
>> +                               rcu_read_unlock();
>> +                               ctx->current_state = state;
>> +                               return;
>> +                       }
>>                 }
>>         }
>>         rcu_read_unlock();
>> --
>> 2.31.1


--
ankur
