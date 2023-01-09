Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634DB6633A0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 23:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235606AbjAIWAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 17:00:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbjAIWAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 17:00:45 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BCB9BC5
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 14:00:43 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 309Kwjno030021;
        Mon, 9 Jan 2023 22:00:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=3Tudcb1gRcBGlByDIGZAnco8VG4VyrLF3w/lW1tssAc=;
 b=lA2nmxud1EPDfSXeTa8/BToQb5ViMXSIL4P5IePGkUZ8r9erg+q1pYWO+qLAnqoXc9/d
 R7sF1jQJqhLhsdewXLmKretz8y/VdWrt/81Qb9H/SK0Q1/NLmctnYioJIaTSzH3U8svK
 dsS2ReAoSQP4thpvbkLqwh2QDswp81UEzgc/td/u/RIq9a26Y4uUYzaVmqrCy95jL+Hk
 vAJKm6GG6jxz9YuKthut6uN4c6wvLPhle+u3PyHSFN/UQj4RaxlSrDukHzNjh5I9mrlY
 xPqhmMc6mDXwMI6lhqbkj98/frFpWGL7otzPKj1ok4bezoY9+HPt31GDW3bzlEtW9vI4 Rg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mxyh3kwf0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Jan 2023 22:00:19 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 309KZBOp035416;
        Mon, 9 Jan 2023 22:00:17 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n0h8uresv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Jan 2023 22:00:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jtw581ClB3Q12Rn+vMz0kIs8ExGxbztidOQ8gIJiHKVSgG1O1APko47/N2tyFpJXL2Fgnhr7FWllkiNEc6ZuM553nHL+cFnZlptX56L8d9wAAD0zXDDX/uHroroWnIN3XG9s4sfPTMXh84OrV2ThN25TkJezDwa78VAn/+jd5DjX527lH5qYILuBVevOAn2BjyPfAT5sJSKHrwCD2kzYo+52+ex94FWFdBqn9BnrPQY281xv2vngHTqGskRWfSFY8gKfsMaEv9n/JfnsU6gU+F/Pas8+SVjFMh4nC8yMa0YauNZQJNXzyvjsKb1iP7u8dOzQlrNjE/If7XgHPv4lBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Tudcb1gRcBGlByDIGZAnco8VG4VyrLF3w/lW1tssAc=;
 b=C/kntPGzAmIsGdpRLmascJhXcOHuN2chuNaoAXrrb+RfSH1M00D1Enm04sOg7G9poENDtD5OSvxifgphxW6fZQK1+rUiAIjL0qiGUBagwr1cLlhdF8eq+fe6RL+bP5DdWKZ6/aeAFRK3sEEei+9i0QEr2lQZFueZ8fTlGRV6MAmhWIBsdwrXYqq1AKGkkgTrwFyIzBBe+do9UpGJxhR0coXr3U0caOfDpQSyr5exEimftkHzuf/Zu8sV2SsXSEVqJBg4kp0o8cUD1ApFugD2Y7W/O6zHSlstDsL/AOo92CmkdQj0seUAPi53P3fdG4Jc6wdxbZJ+fQn7foTmDr3KVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Tudcb1gRcBGlByDIGZAnco8VG4VyrLF3w/lW1tssAc=;
 b=qw97PUyLJAVkU85Hcg2nKfhYA9yRqEbLgBoWX+E8ZyN6miXwImkvgBQqp6K9nSFzE/p9Wm3cbtdBSxFIRGkLPs3bK5EuroytiJfSo1yyA/S1M5pohRukIUT8q8+H2Yx9WVEkGrsTx3dy90lll3qujQWFV96GDmzOhXJt2fYqy0s=
Received: from IA0PR10MB6844.namprd10.prod.outlook.com (2603:10b6:208:434::7)
 by PH0PR10MB5627.namprd10.prod.outlook.com (2603:10b6:510:fa::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.10; Mon, 9 Jan
 2023 22:00:15 +0000
Received: from IA0PR10MB6844.namprd10.prod.outlook.com
 ([fe80::caab:6a2d:1342:4d75]) by IA0PR10MB6844.namprd10.prod.outlook.com
 ([fe80::caab:6a2d:1342:4d75%7]) with mapi id 15.20.5944.019; Mon, 9 Jan 2023
 22:00:14 +0000
Message-ID: <82d4e87d-edc5-19e9-bfa8-70029610457e@oracle.com>
Date:   Mon, 9 Jan 2023 14:00:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/1] sched/fair: Fix inaccurate tally of ttwu_move_affine
Content-Language: en-US
From:   Libo Chen <libo.chen@oracle.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, vincent.guittot@linaro.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org,
        Daniel Jordan <daniel.m.jordan@oracle.com>
References: <20220810223313.386614-1-libo.chen@oracle.com>
 <YvonlUOgMbla6dSh@worktop.programming.kicks-ass.net>
 <aac4a43d-4999-1da5-a617-b512ae0b3982@oracle.com>
In-Reply-To: <aac4a43d-4999-1da5-a617-b512ae0b3982@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0148.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::33) To IA0PR10MB6844.namprd10.prod.outlook.com
 (2603:10b6:208:434::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR10MB6844:EE_|PH0PR10MB5627:EE_
X-MS-Office365-Filtering-Correlation-Id: af29c021-cadc-4337-4625-08daf28ce2af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G3kTbuvF4vRRbZOR5hl0gMKslzDU9txA4XtMnwMxf/a3AO1ZBqjDYnEmIO9PTi5QeS3acI0XfFLAvW1/zLw7DGIs2u+T1HFm3cN4yeouPJzhu5lO6X62csQf35cNonD3XffwgLQ7yZ0j+sGfEeoBB1sCsiZ7ijA8KuN5FkYToGIMguNpd5sgl0b2t/ArTcK527DMyCj6qIOTaAokDCcDr3ElgrJJhp9DlRPIbgFrRY+vC3/1zAr/wC8G1zqFPH/erNbuLBZ7nd2hQqsh8CLs8zbfy3kqEHMNaoNkVR28TZsmFQY+rtKEHQGz6axOqwZ8l+8HNAgdmYyXaRtFhwGTS6s5wrIZcwEKelVGMv5OaW5YD/yWbg6IIEhX/9Jt3w+f46OD3EQsu7RXpmH8IQivcAZU7hA1VrflmKLPj1FvRnSvQubbA5DBWGW8lEVz8DNF6o8oXoDRiR2l5WXiIF+w9WglRB+R7I5mNmUnb3bTB+smSPIVeEs1wdpoLVwvjVxL8ylo/HQM1Mmf63xdQvPYGXRwTBO4pdd+Olr4mPu70gLtbowz5ty3Sc+h7F8diPeFLlzCVYnDX/gaJRFPhtY6JlQrNrwFjRbI7rKp0Ls/1pcWC9hAEJiJx4jYBu+1+3npj0eThaT3gk8LKS5IuVClB7Vyv+KMY4GFFTlEd4n3ZjR79KXxWdnQrQYDAQyB6MHGxVBTtLiuxBuSG740dyemydilpLq31cmVDjmsi3rDbGg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR10MB6844.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(366004)(39860400002)(136003)(346002)(451199015)(478600001)(36756003)(86362001)(8676002)(4326008)(31696002)(5660300002)(38100700002)(66476007)(66556008)(66946007)(8936002)(41300700001)(26005)(316002)(6486002)(83380400001)(2906002)(6916009)(44832011)(53546011)(31686004)(6506007)(186003)(6512007)(2616005)(107886003)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODhsS3BXSWlaMXZIVkN3U0ltOGpEQk1CMWU1TUZKTkthT0lOMDBUZGVWV1hq?=
 =?utf-8?B?clB0U08rWkI5UmxCQWo3Z1ZPK1ZwbnQwK2lZQ1NCcjljdnpUWDl4UGRQY1ZL?=
 =?utf-8?B?ajdVWXVIcm1FV0pUQzk4NkpHVWF5KzlYVlkwQ2RYc1BuVjBNdmpKMHl5NTR4?=
 =?utf-8?B?RkE3ZW8zVXhoKzJ3bUowYTV4K3V1b0kzeE9SN0EyK01FRS8zSE1wNnpKeENP?=
 =?utf-8?B?WnNlZWR4Y1VkdmRqS3RGVEFyY0d5dTlLZEFxRUk0RkFVaDVxN2l2YjB4bWdN?=
 =?utf-8?B?cDkvNnpjK1krMFBqbjE5SDVOemFZdytZa0lOWGdHQnlwcUhLendSTlNadTRB?=
 =?utf-8?B?cjVzZHRMZSt5OWx3OHlRcFlkK1BZZ3lYMFlDMzZISFJpVnRKdk41bG1BcW82?=
 =?utf-8?B?K0lxMEJYYjU1MmYvR2diWG9nbWw1VDNxUjVCOXlzQnR4WEVuYVAvcmVlSWUx?=
 =?utf-8?B?YVN6OWM0L3A3ZlJQZWdzMWs0NitYbzdlNDZSZFBoVUdqVkgvdFJZTVZxMXFI?=
 =?utf-8?B?Q1l2amE3UUs1bjNRNnZ6dHBPUVp4N2c5YllueTRJYTIzU01DT2dQaGE3Vi9S?=
 =?utf-8?B?bnZvWnZjckNrTzFIbEg4ZWtKeUR2OE9rRWlLbUlBY0p2L1hvWjV2KzFlSVJO?=
 =?utf-8?B?RHdLZmxUNzhxZXJVRElzQ3RPenZwQ0JVZW95MHVsR3RZZW5UWnlKRi9LQWtB?=
 =?utf-8?B?T3ZFMmN2RG00V3hzOEQ3bG9oQWhhYXZqcytWYWlOVUZZYzdlR0NmeVlzajFN?=
 =?utf-8?B?YzdQNWtmcDFXQjBSUm9NdXNXODMwdGwybG5VcFF6R0pxMDNTcTYxT3BUZXVz?=
 =?utf-8?B?VnA2ZWZJWnRFSG9WQmpXVnY3bW0vS3ZyNUgyTjA0YlJYUG9xVnFtSGNYeG5U?=
 =?utf-8?B?QkhCdlJybTd6bCtHY3crSUZYL2duZGlOcExGYmlQWEN2MVZmaGJFRXNkbmZl?=
 =?utf-8?B?Vkdyc0dCOTI3dzYvRG5CdnM2WW9UUnZCSVUzc3dzWmNzRUZ1eGlUV2lHS2E5?=
 =?utf-8?B?Y2dtcXBIcXgxN1VpRXhWZWVMdFZLRnpBNWI5dWJlUTl3cmZmM1VsY1FXd1N2?=
 =?utf-8?B?REM2Y1ExWmhGUDhlWEVUSjljK24yZTVDNXoxWnZ2UzkwdDhzLzhObi9JY0VN?=
 =?utf-8?B?N1BkN1kzMW0yY1pYN2JjVzhqVHh6S1B1TVRlQU8wRWdWSHJOVndrbXlUTW00?=
 =?utf-8?B?L2FjR3NWWUt5RjVqSERIMUdGVUNXVGZ2UVB5blhRelFqRjdZTE8xZHh5MTNF?=
 =?utf-8?B?MEphOUNLS3FRUm9CRnQ1WFd6ZVQrK0RlSU8xSkhlTzhZenp3bEJPaVB0RFlx?=
 =?utf-8?B?emhuUnptdE1kOXZiTzRiZjQwaVMxOTQwc2FESjNFem9USmV5VGxvSFdMQVlh?=
 =?utf-8?B?WUdTUmxSOU55UkRLZzNJR1l4anBrdEkrSmZmOUR2VHVuY3AxbFdMa2FTR3ox?=
 =?utf-8?B?Y3NDamRya0djRC9wRER6OGwrbFprZE0zbnhwNXoyeEJKV1RBSkJrZHFCTzQ0?=
 =?utf-8?B?YWdMUUtYWXdFRWl6M3IvSzRScW9rcWY3VlZ1TFlGUUpMOXZEMytPS1lJK2hK?=
 =?utf-8?B?dnhVczZPTVFRY1RKOWRaRW4zWFZFMlR2VE5GTVRVMlBRbTIrSVMzalVhZ1VS?=
 =?utf-8?B?L0szeWJDWG1DeFc2QTMxZ3pnYnVEVFkwQ05iSGY0WVBsZVlXWmsrK2p1dlMw?=
 =?utf-8?B?UCt0Q2JkR1E1dXBPazNaeFc4Y2piQ0dpRUJ6b1dvaGNLTVlYcVZjbVVidjRy?=
 =?utf-8?B?Q3dnREk4aURpR2xOQjRiaStWRGJjd1RmaW83UmRIYzAvbkttaDhUazV6ZUlD?=
 =?utf-8?B?Tm9mc0MrL3JUSVNVMXlmWHRWTG5JdFYyZkUyTU1iaDFKVzdxVitsMTRySlE4?=
 =?utf-8?B?MlpoSkJLVFlqZmJCdW5CVHJlQzJBUTg2d0I2YVRGalhabVJ1K1hGYTlWNEdq?=
 =?utf-8?B?VDZIOENzSXJ1TUlHTEtrR1lJM3B2Q1lpS1hKN1lRWHNoUWVnWnZrR2Z1ZTZY?=
 =?utf-8?B?VHpZSk5ZTFZtV013WlRFc0kzMnUwQk44czl5MEpMa3VRcnQwc3Zxamk0TVJa?=
 =?utf-8?B?NWZzZkxPTFhDVXZtZWk3Mmlqelh2c3JaejdBaVo3OEhzWitxRlM2ZXk3RHpj?=
 =?utf-8?Q?S4Jzb2L/YY5+dBsfHZN1C3TOj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ZVL3T3BRqWg0zHTuZhcHG2yZYpDHmsEjxaSh/F7+2yoCYSL//kQYu+2PVRUCO2cJD7NexfIYfekG/B2Th/VAVQD+NooqMEWtL2Vug934TR4G55Kd9o9NtTmGRpA6D2/6sfrXOWuAj773voHYXUIKgEoYKl4BrNInIPZN4GyEMlY4343rmXcwe2EXjAfx1aJN8fhpXMZLHM7tIT4pxPFC/INL3FyADzwQocn9zPpeVafZDH3QkLFBpXnhvi2j28jEgvmAlealMp4oOWKox9/S6IQi2cMPIoEhsyVmebL+9X0/QRf1PpjqwfgnNr1kLgw0kI/Qn3mT1FgfrMkbC9PPL+7ANHnKn6cxs7flVAy2GtGUFrMuBlwbnmaEVomxrh1m+8qgztpyZX96WWzjb72muguGNfd2TvG/Jzz8OAdID4YHa0gAqPQvOvQ3O5knRe1jqOD+bsUb1lP+QknKyIVea+6thSKf0Phaxlb7PpT7J5/lxDxsBi6/ySHw5e8w27mM0KW1nyMtyeewMY7UgR6B7ymby8mYcY5Ik+52ZTzZ0ydlw2ByLzEW8pQO0HKB1kmX4TpPWtKydtNTDtgzPrnqJZqESnHVJM4JYznUPanudnTaLZLk8AmiTBl0yVZjdvj3uAGE+AlF9ScsBzVZiSfvwuQg9POipkoQoEMbemV13N/syBS6wbcZc28YdJnlex5Pid5OH2k4x2PGFJZBEdTh8mfvR8FGQpQZYL538qSMOngfdzR341DmEIAUnVExg+WhzODfw5P63puKTTq/Q/XEhMKHRx9YA3lX812iKuBhSeH76PkfZjM1gnHGeqcZPa0YclP04m4k5q9oscH/7GmDy4mgoVF+3Hmw4QPaf5Tk68Ua3fI4Iwjz7MVhofmJ7oqh4cfNK0lJrKTseJeDADvAxQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af29c021-cadc-4337-4625-08daf28ce2af
X-MS-Exchange-CrossTenant-AuthSource: IA0PR10MB6844.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 22:00:14.4153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kE837sCm4HuZbjsPZde3DSLtM7iDj+8vwXmOKHerjxr03OS9v0NAFNvXCCrnxpqvwCaGY6YDoOw0AT23XQwGeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5627
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-09_14,2023-01-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301090152
X-Proofpoint-GUID: UBD8kpWiDZJRCeeztWDnKQ1PmNs007sE
X-Proofpoint-ORIG-GUID: UBD8kpWiDZJRCeeztWDnKQ1PmNs007sE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

A gentle ping~ Vincent has signed it off. Let me know what else I should 
do for this patch.

Libo

On 8/15/22 12:19 PM, Libo Chen wrote:
>
>
> On 8/15/22 04:01, Peter Zijlstra wrote:
>> On Wed, Aug 10, 2022 at 03:33:13PM -0700, Libo Chen wrote:
>>> There are scenarios where non-affine wakeups are incorrectly counted as
>>> affine wakeups by schedstats.
>>>
>>> When wake_affine_idle() returns prev_cpu which doesn't equal to
>>> nr_cpumask_bits, it will slip through the check: target == 
>>> nr_cpumask_bits
>>> in wake_affine() and be counted as if target == this_cpu in schedstats.
>>>
>>> Replace target == nr_cpumask_bits with target != this_cpu to make sure
>>> affine wakeups are accurately tallied.
>>>
>>> Fixes: 806486c377e33 (sched/fair: Do not migrate if the prev_cpu is 
>>> idle)
>>> Suggested-by: Daniel Jordan <daniel.m.jordan@oracle.com>
>>> Signed-off-by: Libo Chen <libo.chen@oracle.com>
>>> ---
>>>   kernel/sched/fair.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index da388657d5ac..b179da4f8105 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -6114,7 +6114,7 @@ static int wake_affine(struct sched_domain 
>>> *sd, struct task_struct *p,
>>>           target = wake_affine_weight(sd, p, this_cpu, prev_cpu, sync);
>>>         schedstat_inc(p->stats.nr_wakeups_affine_attempts);
>>> -    if (target == nr_cpumask_bits)
>>> +    if (target != this_cpu)
>>>           return prev_cpu;
>>>         schedstat_inc(sd->ttwu_move_affine);
>> This not only changes the accounting but also the placement, no?
> No, it should only change the accounting. wake_affine() still returns 
> prev_cpu if target equals to prev_cpu or nr_cpumask_bits, the same 
> behavior as before.
>
>
> Libo

