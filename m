Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0E65EFEA3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 22:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiI2U0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 16:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiI2U0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 16:26:37 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C260B110ECC
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 13:26:36 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28TKPr2R029682;
        Thu, 29 Sep 2022 20:26:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=KzXlyoG5z4t+C//JD15ANsPhzw2y6SPgE37HpyPjMng=;
 b=v5oxkbSp0Tt6YdZyiPelZptfXoJEP4yFVURXs971gT/p7qJeGkweOQ2eljtJLsWRouB9
 u3rdU7xbbCOhPbmdthtf6kYR1kG7fCrn2pgd2ibL9oTMgVhwatqTt0uKgm/yF/ewLyiJ
 mq+CuiTja3xTVLSEOpx9UngKYy6jT3KItnC0eZhGAGbWZoG6r+AJ4vQBOIn1tnh97elY
 pp/md1J2+y5+Pd2x9QneDtIuFF1fGEjDQOZYRm0rRTUJbVKdjN/K8YC4rk0d5+BFWhTd
 dSfo6QC+h77fu8SsG1xWdii3gV8eQDtFwoMb3o8/5ALJLTrbGtLXgD1jBszqc9d4Ud1K DA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jssrwp17v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Sep 2022 20:26:34 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28TJic6a036947;
        Thu, 29 Sep 2022 20:26:33 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jtpvh08q2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Sep 2022 20:26:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBycilYIGeGQOGRvVkBQ2IvHx6pqpWtLvdw23vWX4IAZzwpazlMF4g4IFqYROw1T44SMOhkKCVcQE9r043cRKI0e9imuBxJ/m0EVb14u0ZZqgfgncH9birlUoiw2Qr/9DSG4B7aSA4KyOzYVIXOOojHgPVF/tgqcuz/al1XtUrnT8g0Qs1ZSF738+epw9XWhi1vJKsbQxndzM8+BE7SskFZb0C9yLPk4yPb+17bgykbotO/Q/k+Zvr8on1aayxgUw+OXek2NXVIcxEeXRFMrWw/1DrfQaVLpKM0VGqVJ3g62pxIdL/OO2R/C1FZ2zJOszPJhRxsR5EzoJvFi+mn1yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KzXlyoG5z4t+C//JD15ANsPhzw2y6SPgE37HpyPjMng=;
 b=B3svOFZbUpifjAyCVljkeIrQ8qCmRkH+UOllXIAUyv7tzdxwoBKjSuYv6q3P65xOa8Z/9ccqdAoQaQHJDYKwQdy9CDlhdmkEybcBo/3jHZiEXHDdaIjj+J525vTig9mjL2iP8Ug6d+ZjxN20nPmbD+BSbgLL3O2SMdMyMaC454zK2iMpZ6g1aNLlEQjwcBVzQelJ42ZRJZrl1cL/TQQUttufFZqq77+iQVyNhUa/Jdz8QmF/4gcEYN0Bq0wBgRHZpWdiOH1mpDdb/p3UaAehsylj25dICALRNG5enSA2BWfWFcmGP2hImqgM2G+uLGW+otNHsleFv1t7j7lAdtQuwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KzXlyoG5z4t+C//JD15ANsPhzw2y6SPgE37HpyPjMng=;
 b=HAUacEt2msTXlo0jMWvQ1q9AO4k1ckrqQ8uSVh/CNl2TJ2xZR0TOBo/MJ7ZKv3nWWo5FQGhnaeeLmcB6Vep14itOWAq2DDUZNCJLqSp+/K5X2y7jA31ZkinJds+8Ybpx0aDT/s9KxiUV+hTX5EQ5dysuZpT3AFrhrRPsuELRD5g=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SJ1PR10MB5977.namprd10.prod.outlook.com (2603:10b6:a03:488::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Thu, 29 Sep
 2022 20:26:31 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::4c38:703a:3910:61d6]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::4c38:703a:3910:61d6%4]) with mapi id 15.20.5676.022; Thu, 29 Sep 2022
 20:26:31 +0000
References: <20220927225944.2254360-1-ankur.a.arora@oracle.com>
 <20220927225944.2254360-4-ankur.a.arora@oracle.com>
 <CAHC9VhSY+ELJ_yX+U+ZzAPOtjJ=eGxtmLTtgpm6NhkYE3Yffuw@mail.gmail.com>
User-agent: mu4e 1.4.10; emacs 27.2
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>, linux-audit@redhat.com,
        eparis@redhat.com, linux-kernel@vger.kernel.org,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH 3/3] audit: unify
 audit_filter_{uring(),inode_name(),syscall()}
In-reply-to: <CAHC9VhSY+ELJ_yX+U+ZzAPOtjJ=eGxtmLTtgpm6NhkYE3Yffuw@mail.gmail.com>
Date:   Thu, 29 Sep 2022 13:23:55 -0700
Message-ID: <87mtaiexpg.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0130.namprd04.prod.outlook.com
 (2603:10b6:303:84::15) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SJ1PR10MB5977:EE_
X-MS-Office365-Filtering-Correlation-Id: 32616505-efc7-47ce-73c9-08daa258e4d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pPfWvlsm88/TPJR7m+fOzuP0rpHfjTDNOqtoNMicKStWXrsDzHpslzFTnstVkEyK90VI2v6Fl1V7LwaiX/q7c2V78l+XyGLT1qhyCND9FAHVmUoC8BSKK9amv/pegvLTJM8j48hBAFjK/FP6AJ85TbYMaFSvXfa3kfDcD6wFMVhyfRctW9qVd5wmlrN2QzuUpLOFQnhz/R3UW+BAbVZ2yGFUb8pY2Nu40NVpHVplI+7/9cFaeMKBnQBu3yj3Lcos2m5u24aKXSfomH+FkGVewl1gxioqeFSyYr9TzKPOmeqsCkjQkGqhIgz8wp5RiefwLSDtLbPNs4NFKFfth9+R1aCjvbTg/1aCkuhhGK4fAhbkUjGwABfsZ+6kQ+d2SzawZMcKj6cKXf4Jd6ymOHtixQ9tn6Lk6yRst17oThigAT/Q8MjKKPc3loLlMbToAvRcDPvycRZ9EFgbdtnjDP5Id60cijMXg2+F4HNEF95bQwpuRI5FiJuEiOf3uckvPec0o4fHUCDpZwFtJYMPGO7NmmhJnhL67CO+GwRiCsRh8GQWdRd7D7UovxQmDr8Kyxr8ai64QGaOCrHztDZE81PB/hlenTRXGA9uZLthpeNIrUzGYclyHwkEqIjGq73iv2qkPhl+cGcwWYhnLerwtzVQejIkNvcTql2o4fE8MWfiWx95h6upT57rx+nFZSmxIwus9PMlmPF+tgC0yDwPn/MYEg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(396003)(366004)(346002)(376002)(451199015)(5660300002)(26005)(6512007)(8676002)(316002)(6916009)(66556008)(66946007)(478600001)(66476007)(6506007)(8936002)(53546011)(6666004)(107886003)(6486002)(4326008)(2906002)(83380400001)(38100700002)(41300700001)(2616005)(186003)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y1RbZP0rDyxkOArEdXWvHsWB8Jjdkt25+xarFpuN1gpAJHaImd1IMkFk1VRq?=
 =?us-ascii?Q?Jn10tzB5jczsiDtN69eyPbteQV+8k5WlfPq7TeDdAQkFDvqYCypzAIVMynyJ?=
 =?us-ascii?Q?JKsJADeLbA8VhoLvkhmnNMcchDuB1AyZzUE6RK6uORl13WblTObctGMPtA/f?=
 =?us-ascii?Q?d3JquVAvQCWZSYaTWC7xuUkhYvmRrBMqEDXOgMRM9h0mcPR453yZV3FprNOq?=
 =?us-ascii?Q?UMDeWJ1k/MmWyqMA9FjrYTiR/9OJsyTW2H0oOADq5esI6N6PhwSA1K8UGBS3?=
 =?us-ascii?Q?YXH6ow78qEhpq9TdJYj2dBpPuXKgOKaHosAo/Rc6TnnNoD9hRzVZ35NjF6OH?=
 =?us-ascii?Q?CvpdKMEgnit38pMxkMSXYo40C4V/HD2YLCaJU71g/n1f7jWInav103STE9xu?=
 =?us-ascii?Q?UFdEqolkJyxNL1su4pPJBrtwUo6Sg9unt0qto8jrVoCWMWrRt/MjhgeEFqDo?=
 =?us-ascii?Q?V1shdGW139A9wgdjxHYNc5+38BcGoWMNm2IbzooupfiTH7oKouM3GvZL9A79?=
 =?us-ascii?Q?o42tQhb4I/JBV4kSN2pFN9Y4VswVIDdv+Z6fWEHUaCct7YlZiX0dRYO84o44?=
 =?us-ascii?Q?Tss1otiq1ntWnIPcQvxU+eAbG1UQEkpRRIdrdnwbpA6MK26UXAeTeyHSzIHX?=
 =?us-ascii?Q?CT1QwDRZz3jHFnYqFSQhYM/ve7T+EN6uWMiFnIaUdXBSR50fh1EefZAcHdTP?=
 =?us-ascii?Q?ZvDX5Ct3lMSUVXq8n+PP1WtGqTm1t9c1BN2XMNRs7ri8cHsDGvRH1yCHjwQC?=
 =?us-ascii?Q?qUJ0M9WvG2vmYjlmFShr9YQrug92vLHAdORdZukHdLHfBNYV8TIvsimGnqOB?=
 =?us-ascii?Q?58JZQFI/4kGKDox65sapWSE1EIR+u0tVY9irMVDeFf7dcXBR++n5FgsPGzmK?=
 =?us-ascii?Q?FJ2aB1/X4iFx3lHbvSIXoAajotUUYHnXqW56K6vbNTnXY7oMiWwOWiUUQyuD?=
 =?us-ascii?Q?ZYduabZ2EeCoRKlyAUH/dTeIZWXwCroOYOhY9Sp8AYyUn+Avy+EbwJgdAkBC?=
 =?us-ascii?Q?17zc0gCmwTZgYCW6hHlRNoz1W1ZfPJiOQTDqTeJOne0YLB81d/0mbtOzmU9A?=
 =?us-ascii?Q?ibZQvj0A8OnVqaswMlzkho23c+howHY84qsvQC3LCqGTwaDx45zE7up7mU+N?=
 =?us-ascii?Q?NjummUqqvXl/uM/Yo8333k0/d54MuOV09pylTlB5Oagd6ZZyyJ7nd1YckVbf?=
 =?us-ascii?Q?Hr3D5kqyJ1+SQjI8PZMxxZehCb+VbE0YiV65jsdKVn4PQCEslF555zHOi/wm?=
 =?us-ascii?Q?7Sh2/ka8OvkfhnDpLYGTN3VFX53NvNkQbkQ+O+LbKXG8JKsYD2rgxNMADLYO?=
 =?us-ascii?Q?bVNJOAi2XweQF/v1tU28jRczURE8pJSTPHAM74I1zNPKiMlH7s6ZOrIys+jy?=
 =?us-ascii?Q?E9vWtebceamy3jFunHutRdnKQ41hz2FlqPA2c3Klh5pB+M1RURMMtD8Hq5Vn?=
 =?us-ascii?Q?vkc9Es7knJ+NJVQzRAIi2FFYwLgdndLD/EfzzVy+bQSdlI+uSZWYsot5LO9l?=
 =?us-ascii?Q?mPHqR+befqhLGqGE72yup1rJi/RebftLQtVZNQfwCTWGsC9FthdyZcNYQICO?=
 =?us-ascii?Q?eP8rhy2UUrIG7pz9AEPh1kgopyJuwVErBsoiyFlstLaZfamSfFqz5L1qRSu9?=
 =?us-ascii?Q?zw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32616505-efc7-47ce-73c9-08daa258e4d9
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 20:26:31.0217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NdFywi+T6Ac9MZCLirz77CCTXmf6AmK6PWkqCCNNEoR3E0+3I7iZTi7KbhvOHrdAhjE5hZUWFU0Y/IyDTHFgxSIM4wweUub8/kogqcSk5ng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5977
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-29_11,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209290128
X-Proofpoint-ORIG-GUID: WuZx8OroHtILJCoU_IA0Hjsq865CuQ0K
X-Proofpoint-GUID: WuZx8OroHtILJCoU_IA0Hjsq865CuQ0K
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
>> audit_filter_uring(), audit_filter_inode_name() are substantially similar
>> to audit_filter_syscall(). Move the core logic to __audit_filter() which
>> can be parametrized for all three.
>>
>> On a Skylakex system, getpid() latency (all results aggregated
>> across 12 boot cycles):
>>
>>          Min     Mean    Median   Max      pstdev
>>          (ns)    (ns)    (ns)     (ns)
>>
>>  -    173.11   182.51  179.65  202.09     (+- 4.34%)
>>  +    162.11   175.26  173.71  190.56     (+- 4.33%)
>>
>> Performance counter stats for 'bin/getpid' (3 runs) go from:
>>     cycles               706.13  (  +-  4.13% )
>>     instructions        1654.70  (  +-   .06% )
>>     IPC                    2.35  (  +-  4.25% )
>>     branches             430.99  (  +-   .06% )
>>     branch-misses          0.50  (  +-  2.00% )
>>     L1-dcache-loads      440.02  (  +-   .07% )
>>     L1-dcache-load-misses  5.22  (  +- 82.75% )
>>
>>  to:
>>     cycles               678.79  (  +-  4.22% )
>>     instructions        1657.79  (  +-   .05% )
>>     IPC                    2.45  (  +-  4.08% )
>>     branches             432.00  (  +-   .05% )
>>     branch-misses          0.38  (  +- 23.68% )
>>     L1-dcache-loads      444.96  (  +-   .03% )
>>     L1-dcache-load-misses  5.13  (  +- 73.09% )
>>
>> (Both aggregated over 12 boot cycles.)
>>
>> Unclear if the improvement is just run-to-run variation or because of
>> a slightly denser loop (the list parameter in the list_for_each_entry_rcu()
>> exit check now comes from a register rather than a constant as before.)
>>
>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>> ---
>>  kernel/auditsc.c | 86 +++++++++++++++++++++++++-----------------------
>>  1 file changed, 44 insertions(+), 42 deletions(-)
>>
>> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
>> index bf26f47b5226..dd89a52988b0 100644
>> --- a/kernel/auditsc.c
>> +++ b/kernel/auditsc.c
>> @@ -805,6 +805,41 @@ static bool audit_in_mask(const struct audit_krule *rule, unsigned long val)
>>         return rule->mask[word] & bit;
>>  }
>>
>> +/**
>> + * __audit_filter - common filter
>> + *
>
> Please remove the vertical whitespace between the function description
> line and the parameter descriptions.
>
> I'd also suggest renaming this function to "__audit_filter_op(...)"
> since we have a few audit filtering functions and a generic
> "__audit_filter()" function with no qualification in the name seems
> just a bit too generic to not be misleading ... at least I think so.
>
> I also might try to be just a bit more descriptive in the text above,
> for example:
>
> "__audit_filter_op - filter helper function for operations (syscall/uring/etc.)"
>
>> + * @tsk: associated task
>> + * @ctx: audit context
>> + * @list: audit filter list
>> + * @op: current syscall/uring_op
>> + * @name: name to be filtered (used by audit_filter_inode_name)
>
> I would change this to "@name: audit_name to use in filtering (can be
> NULL)" and leave it at that.
>
>> + *
>> + * return: 1 if we hit a filter, 0 if we don't
>
> The function header block comment description should be in regular
> English sentences.  Perhaps something like this:
>
> "Run the audit filters specified in @list against @tsk using @ctx,
> @op, and @name as necessary; the caller is responsible for ensuring
> that the call is made while the RCU read lock is held.  The @name
> parameter can be NULL, but all others must be specified.  Returns
> 1/true if the filter finds a match, 0/false if none are found."
>
>> + */
>> +static int __audit_filter(struct task_struct *tsk,
>> +                          struct audit_context *ctx,
>> +                          struct list_head *list,
>> +                          unsigned long op,
>> +                          struct audit_names *name)
>> +{
>> +       struct audit_entry *e;
>> +       enum audit_state state;
>> +
>> +       rcu_read_lock();
>
> I would move the RCU locking to the callers since not every caller requires it.
>
>> +       list_for_each_entry_rcu(e, list, list) {
>> +               if (unlikely(audit_in_mask(&e->rule, op))) {
>
> As discussed in patch 2/3, please remove the unlikely() call.

I'll pull it out of this patch.

And thanks for the comments. Will address and send out a v2.


Ankur

>
>> +                       if (audit_filter_rules(tsk, &e->rule, ctx, name,
>> +                                              &state, false)) {
>> +                               rcu_read_unlock();
>> +                               ctx->current_state = state;
>> +                               return 1;
>>  +                       }
>> +               }
>> +       }
>> +       rcu_read_unlock();
>> +       return 0;
>> +}
>> +
