Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289CA5EFE95
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 22:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiI2UU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 16:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiI2UUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 16:20:52 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479B35006D
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 13:20:50 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28TKKhUE011307;
        Thu, 29 Sep 2022 20:20:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=pZ1fLHIq6z5jVoZC55AtznmrRZJWXA1sAvwZuqOcBUA=;
 b=aRCmKuycBJBIkf5PWXWuHYjYzvurTEQ/vNQ15qExbkZja04/5bSHfOgHPYjBXUFs+iQn
 nYNTYDWIfP5WtJ2Q8k6JLyzN62VSlhIAtJEo6g6Ll/MNg2Z41S/JLgpYLiFiM/hNb0WD
 D10c0iwCffuMgR6QuxJR121HKoLKmv7OK3ZRNUyI/vPM3bIVR7nWSlzc2F8Z31unlztw
 57DZOrjtMwZW+qlI7yT2oHlaUwc91Qq5MVCoCtenVK+gMmfqGMGtqSuqIyJICvhOvaHE
 Jv/L1SeMr+83MZ0Gc/ILO7pw72/2VrUir9X7q/QQEMBAlWKGIEPiP1zAkGC7WSUPtiRE 8w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jsstpwd9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Sep 2022 20:20:47 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28THOnH2036986;
        Thu, 29 Sep 2022 20:20:46 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jtpvh00p2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Sep 2022 20:20:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PdQgGCc8Q6xFbj3Hu/O9TC7qYpAphhFVOxITDEBPhKdL+V5PdwX/Pl6zBlo8S9eeSp/KdbSTdMHZJ+G0SgzFfM3fcx9PwfDCeEydYDZn/nYRTn5YjAVMcStmBjKWRTRqM+F0+YmuKvZVzd4LD04oMTaVdkpEbl3scPH84HQIrHQTIIJdgfDyiQ4G8BNiV43/MQThqHlnYTvmrTo8ysqsru3hBFk+flpq36WbkiemmcD41Ui0Z8RiFpYz4bdi5Akd02hF1VZI66rAxikv7FYqYLFiOhRlKFZIX003fy+nMrlvtx39OBR9ZcdhxSWeGvalCPE2Hsy5xXzKNi6r02hmHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pZ1fLHIq6z5jVoZC55AtznmrRZJWXA1sAvwZuqOcBUA=;
 b=EqHh0ancjabCohZlYfkmvivCz7N2WyKhYGuxyjPoaSlmb+AzBkCRuEJN0UiIM/kr+gE5e8j7AMABbdWfHICQJfmYRFkju99mS0QO4Lq/KGu7qqfMqv9piB2zu4PqI2tJx5dZVCxbDLa4zD3oIdap7zd0NM+Xvct+1kIzLDuke2WSYi60uyhMWHgWG8KqdMn8e+bbXV1dSxA2+1s6ARntdpGxQh4T2ocPvIisf3oL9IqESSwIqDYdp9I2ZvvNVUMFOB/JbUoOeYYYFu0PZCQj2q5GQEpNXy2yyEraE+/4Rc+CBxLWvHHhai/64THV4g7WMtZuJ4Sj64vAXNpuzGd30w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZ1fLHIq6z5jVoZC55AtznmrRZJWXA1sAvwZuqOcBUA=;
 b=j9yk3rkfdjaF3Kkarh2nmN8inPrQ6jVY/89T4DqVi+4AcuHWxtpEtklg2DoN3BZQPe8ksgvtaSJAjK0UeiqCUH5s4rTfjX9SJ/warl3G/6oUtRb/bFTl8Jrewf1ebpAnUxH+X2Gx4ltasV2ONbHNeu3BugbL6AlG+W2pPGq73q4=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by MN0PR10MB6005.namprd10.prod.outlook.com (2603:10b6:208:3cb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Thu, 29 Sep
 2022 20:20:44 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::4c38:703a:3910:61d6]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::4c38:703a:3910:61d6%4]) with mapi id 15.20.5676.022; Thu, 29 Sep 2022
 20:20:44 +0000
References: <20220927225944.2254360-1-ankur.a.arora@oracle.com>
 <20220927225944.2254360-2-ankur.a.arora@oracle.com>
 <CAHC9VhRZzU5-+65AFOK826rA0xo-nbgRK_pP05Q_zjvAQvLnRw@mail.gmail.com>
User-agent: mu4e 1.4.10; emacs 27.2
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>, linux-audit@redhat.com,
        eparis@redhat.com, linux-kernel@vger.kernel.org,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH 1/3] audit: cache ctx->major in audit_filter_syscall()
In-reply-to: <CAHC9VhRZzU5-+65AFOK826rA0xo-nbgRK_pP05Q_zjvAQvLnRw@mail.gmail.com>
Date:   Thu, 29 Sep 2022 13:20:40 -0700
Message-ID: <87tu4qexuv.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:303:8f::24) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|MN0PR10MB6005:EE_
X-MS-Office365-Filtering-Correlation-Id: 059a4c84-8ba2-4f48-430d-08daa25815eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iH5qzigty8Nm/f9cLNzQdtsDQaLEh9iG/VgEBGeuPot/ayNdEX9iMmK9k3lXxQWVA7FnIA+FCY7pmZ9Eqmh4Z5ujddL72SUeNYgqfZgmxQHHIfIH9ZxbaYNxAGm8C92KmW7TGpxyYmQ5V/BfENeKzITrW2asqGVQjnRKQ3Y4H6gAy+64lPovQlpwGTx46woiVEZ4EWWvSjqAn9el21PShlcx6yzSKl9aEtrX6j3zUtYZr9nbmLpVV+RcpbWodvLLcYbV9soDHZTZYFsNe+96CPPss6pc0FR6JkrDqofGQsLig5w6chE29EOK69PwsPbPkmRnjjCCS992FfKkKfIjGik4aT4RSOnhla2obGgvjYZcHnn4YnaD07o032k1Ji/umZPKPEsY9shLnZvUQw295xegM9lEzP2UKNmVTl9sFn3an0jv2WmdRH42Y1/sZ0S4JvUTrWg2BJa1YXEnFpa0RErWQSQEdnUM3TFdKoXiER1/6K6apfczomn0ViJU9RDsE+14V2iam+fAd4Tf7iDEVV6K4F/h5ZMLCTDv1triyt/kV+iHCQE+qOyAzbtcUeHAN0t0JmNx+AeRi8CTDGUUMBoPBExn81FNZIf7tLP63DJoL9Mso4Dg2ZFFHq9ZLTViSfOM7S3EDFn003Pc+J++s3fDmAEeF2f1QhDfRxH5tltW0/52g4qutG36v3ujQGgoxkEoazKMi38+Ln56p/S9VQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(396003)(376002)(39860400002)(366004)(451199015)(8936002)(5660300002)(83380400001)(53546011)(36756003)(6506007)(6666004)(107886003)(41300700001)(6486002)(6916009)(478600001)(2906002)(186003)(4326008)(66946007)(66476007)(66556008)(8676002)(2616005)(26005)(6512007)(316002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TkjQH8772lg6uEYcyPf6HC2mWL7Cy1VaLNxiTSro/j0YaGb9wKc+nHcVEq3b?=
 =?us-ascii?Q?csHdlhYTfkzK45vbYQiTUPvb8PRJEjtXl6n8rUWB45YlJAAnjA3Y5MafiqRq?=
 =?us-ascii?Q?JirSwBkPs6/ujf7zkAKwblEjoDrAgp+gr1w8/bUWzneuyLPWXirIT7Zy3gIQ?=
 =?us-ascii?Q?AkIrbNxuR0V0nsp9QLWOZxy9ZxlUrDZ8vPxreH0GeY6RMTZRI8sElMJDe4i9?=
 =?us-ascii?Q?pI7OVhAZOW1ml1j9a3Npz/mA/3qi4GK578MbiW+348Tt+SCzUuuPhzNldDoy?=
 =?us-ascii?Q?oDrZ+6Kxs0gGg1+NtSHSXf8taByxlxCitqKAM6vgeCvwu6r5M846dm1XWUjR?=
 =?us-ascii?Q?Zr8Ra1vJgIWD6Kdv6ceRPJuyqQEXC48I7mG1hujxDx0FhzJc3BlHhjcQoMSd?=
 =?us-ascii?Q?5PPhqD5QuJRVt9FkAykhVc1aCGanWnUHoPCGFMUBfbF93iNYmhMzI3qBDSie?=
 =?us-ascii?Q?E4FI10OQcXR/fvrNI0xAT31XrKX800VpuVggBCOwwzDT9zu8vemuzxS9qruQ?=
 =?us-ascii?Q?xNX0MWa/673P4/avzYKOXmNxL8e+mFP/WiwgPgtjQIlxCWfueA0o6/J0TTtN?=
 =?us-ascii?Q?dohhmGTHbp/o4X9+IoO/GtcTu5L4TJ4+TvLL43KMYqNZ0VonOs1GZX0pTtwc?=
 =?us-ascii?Q?IkTVB9mixE3pKj3rjQcY/VYevXVbMY7ijeBkK9IJKCpdf1t0iIDYqSgmdfih?=
 =?us-ascii?Q?2esuHs1rHbjMpCQz9vKiaBTOIPHhujsH/NagcY4C2EJXElcKjjcYEnOYaibE?=
 =?us-ascii?Q?tVcAVVgDisghFw5EAVXeOxlL7Ery7ftE7FJMNrs5x0jrCSMpz2Pj7lxiP/iN?=
 =?us-ascii?Q?060XnZONw/aXm4uUpI3yg0Of1EXF70uXvbuE7f457D3IBqX5rcYVnbPOT5jg?=
 =?us-ascii?Q?cV+Gpyz/XVDlhYAWkveyWUyxoypR1hf52VgIWnxInADYzSzWTuBylebFiU9m?=
 =?us-ascii?Q?4ZncYYwx6qYRdRyXBH+yb3ZF+yd6cQCWS1YSxn2DpfQTmOMImb/zeFZesFYk?=
 =?us-ascii?Q?YtOD5mPQvgjW+/ZD8c8EnxbJSMtRGsstxnl+0aUdmcpMp83U9uSk1BWnomml?=
 =?us-ascii?Q?StJiJ8BG3pEKcDYXFON4iGhPtUrDveTSuq8WacG6u7e5mZiHtJX0fDAiu4lY?=
 =?us-ascii?Q?eQMkI6hIFsEphIDCqgZr++gfurXoKmj1jB/iLf1enbNH7y3QYJ4wlSUV5lOx?=
 =?us-ascii?Q?WgG4/dB8ghmAkBsAHFTf2yqzs+uh7R1z8ZHLm3/1hSG6ImHVPDIUO4sU/fOu?=
 =?us-ascii?Q?23gnZ9oF+dU7uhNLPAtUR0HpJgUbZQaLN/oKcqV4rnsqQj9rqEaPPrUUgtgX?=
 =?us-ascii?Q?ZwUFjzlKKgToQ3SUEQ/vzyNP8fvODZ7ClJfORpO/1nWDxPLnufnDq5LwxndP?=
 =?us-ascii?Q?L/o5RWGc78Rg2k7sKVg5qSVFUENbUojkVk7eJygjeBLkQHo/kmGcgKMjG860?=
 =?us-ascii?Q?zCUx84eNW42WQMQ2i3ll2MFEWgVXQ7uul47Ye+VIUmLsqBu4lFYtrf/e/n18?=
 =?us-ascii?Q?Hfw+15APSyBM64+4hA2Zr8pPQpHTbVe4RTx1+B/Y2CruUWOd2pR5H/Nz7fBm?=
 =?us-ascii?Q?R+nSkzwAoEZ/yxIEDyhJ2uEOkRTPZ1HW3mq8+B5IvBe+Da+ocHi1KHIJPHNm?=
 =?us-ascii?Q?Wg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 059a4c84-8ba2-4f48-430d-08daa25815eb
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 20:20:43.9440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9JXm2nSwIoa0Cda4d6VDpyzH+X+xDri5gRBF9Oz+Jyi2f8wJLwJDPwEvoxRFVEzm3CxsEk+TNbtXwQjU+DHLlWbjJyi7Mvy1rxi9vN+z7TI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB6005
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-29_11,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209290128
X-Proofpoint-ORIG-GUID: jTmFSmFtC6OtFEcAuzF-TV0ccqqaY43O
X-Proofpoint-GUID: jTmFSmFtC6OtFEcAuzF-TV0ccqqaY43O
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

> On Tue, Sep 27, 2022 at 6:59 PM Ankur Arora <ankur.a.arora@oracle.com> wrote:
>>
>> ctx->major contains the current syscall number. This is, of course, a
>> constant for the duration of the syscall. Unfortunately, GCC's alias
>> analysis cannot prove that it is not modified via a pointer in the
>> audit_filter_syscall() loop, and so always loads it from memory.
>>
>> ...
>>
>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>> ---
>>  kernel/auditsc.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> This looks pretty trivial to me, but it's too late in the current -rc
> cycle for this to be merged, I'll queue it up for after the upcoming
> merge window closes.  Thanks.

Thanks.

Ankur

>
>> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
>> index 79a5da1bc5bb..533b087c3c02 100644
>> --- a/kernel/auditsc.c
>> +++ b/kernel/auditsc.c
>> @@ -843,13 +843,14 @@ static void audit_filter_syscall(struct task_struct *tsk,
>>  {
>>         struct audit_entry *e;
>>         enum audit_state state;
>> +       unsigned long major = ctx->major;
>>
>>         if (auditd_test_task(tsk))
>>                 return;
>>
>>         rcu_read_lock();
>>         list_for_each_entry_rcu(e, &audit_filter_list[AUDIT_FILTER_EXIT], list) {
>> -               if (audit_in_mask(&e->rule, ctx->major) &&
>> +               if (audit_in_mask(&e->rule, major) &&
>>                     audit_filter_rules(tsk, &e->rule, ctx, NULL,
>>                                        &state, false)) {
>>                         rcu_read_unlock();
>> --
>> 2.31.1


--
ankur
