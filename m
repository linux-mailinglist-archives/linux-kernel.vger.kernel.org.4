Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327C964617C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 20:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiLGTGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 14:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiLGTGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 14:06:15 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81936F0ED
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 11:05:45 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B7IuwVN021878;
        Wed, 7 Dec 2022 19:05:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=SfDnJ3H+FOY1l8sGf6bN0rPo+c2y0oUXtYRQVPKCLgY=;
 b=e5d16nf5fqx78ufhPdJU7NsNAUrHQcJexd/xdCjJuWEiQ7rwIKsULnKraMejAiE/Rjoj
 3iPhgDYMLHe97JqS/bt4Xjxt7It8TIzpHbTIKGXHv+aDwtahT5RUb9pBm4gMR1UFowwN
 /MrJikQQhadOC1AnLpS0zkWIrx9JSK8BldT8GJPWWtHDpOLLttMBkSifQu2wgZg4zjG7
 2z6uDbQmTf27YB2McxAvIn8jRerBp6QRN4l+8tSHZBzEwmTn5qE0D5uahrUdTYl1jdMr
 QdU24TuAMXmlCz9LUSyh02WJCelZ3/hXQYet8xFCEU+zsV3LnoZhpqiQeZwewWPmcxg4 iw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3maubah61y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Dec 2022 19:05:25 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B7Iw3mN033812;
        Wed, 7 Dec 2022 19:05:24 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3maa7x2733-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Dec 2022 19:05:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z1nJzdkHIBv8U6ScM2g2noj1F0tFInX86kFxoikUXu5TxZHs74iDGU6okFqwzN4UnQLLOuVoHhzpqculL7/UYa8p79RU10KOawTcJQTAMRypL/3/z0hUeRhNxIDBNfYLl6lYFzREbsCIQ+ZD1PNfAoI3IC5wUIss3vATXe7e550+NtIP4krYm3+lKzhiAXksqc9epkeUvYq02WASiRWq2Y935pNnSHhIJf9eKML9Xt8UyexdtEWZkpXOv71we22cGVbtpMPbKxamJfa/1nLZ8VgCivyFfYl851CSN2bLex80mFcZVxeu2nc69c2OrEgDgSy5xn4KpLXdqNGl1rB/iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SfDnJ3H+FOY1l8sGf6bN0rPo+c2y0oUXtYRQVPKCLgY=;
 b=epv7tA1w22K8JK4+ff8Q/rLQ6Tju9Tkv5zyjaP4hshgbzduBhHq34eISgklEyqwNdK0zaJWaqaXxya1bANlC+JuAIKvcT3wYtSylx0OPJbtlXoSN/HBQ3lglDBsNMxmm3NMoMBFjAQzAoMWJJ31G07fg4iREoDPT5ybfHR3eEjpOo4id0YBMMYh/zDVLOBdHMO6/OHLKvqxqDQVkdlQVa+9eongURV1gkbyrgUy1x1AAj3YTd4UXKE9nYYtjpSFdOHBxl4Ne/gCHLdfCOT9l2/KoXbEDf+Hxq0EGPei+YB5exssTPbgqEs58N6PcGjux6pXtKpjz2mR28J98B/bKtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SfDnJ3H+FOY1l8sGf6bN0rPo+c2y0oUXtYRQVPKCLgY=;
 b=a71zpUw3jUzSScdJ8kissaC/lxsevBUAGs5rZZRv0+lPErVFyl3Njg9HL8vNPMecb088lU44piPSrSqOMLrhVJNOzcgOCX3zQ7nz04Ra3IQl0ZivtWiHemZcs8y+ib2jG0QexBlpzsOBMUlu8DrZ+0OMtEzLOemt1TqQcZK+PRY=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CY8PR10MB7366.namprd10.prod.outlook.com (2603:10b6:930:7e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 19:05:22 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::51be:1301:5ec3:996f]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::51be:1301:5ec3:996f%5]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 19:05:22 +0000
Message-ID: <d5755326-a71e-242b-5e1e-86fc897dc292@oracle.com>
Date:   Wed, 7 Dec 2022 11:05:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH mm-unstable v5 01/10] mm: add folio dtor and order setter
 functions
Content-Language: en-US
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>
Cc:     linux-kernel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mina Almasry <almasrymina@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>, hughd@google.com,
        tsahu@linux.ibm.com, jhubbard@nvidia.com,
        David Hildenbrand <david@redhat.com>
References: <20221129225039.82257-1-sidhartha.kumar@oracle.com>
 <20221129225039.82257-2-sidhartha.kumar@oracle.com>
 <BAD34D59-187B-4BB3-B139-7983A8B62648@linux.dev> <Y5ALigw0kUO/B3z2@monkey>
 <4161AF1A-9508-4DF8-B756-FEB476EB32B5@linux.dev> <Y5DXivFOA+bO0IYQ@monkey>
 <b995eccf-5818-84ee-560e-20c00f9936b4@oracle.com>
In-Reply-To: <b995eccf-5818-84ee-560e-20c00f9936b4@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0063.namprd03.prod.outlook.com
 (2603:10b6:a03:331::8) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CY8PR10MB7366:EE_
X-MS-Office365-Filtering-Correlation-Id: 1597d1ff-cbf5-426f-577d-08dad885fcbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KqhMkW3CoNN7ID9CD5FSzfrR6FMD8Qo1nlzxNUPtTQjBQjbvpmgpL0uodbXKeGW/ris2mvBpCQdgzRz1EXLs0/AoWlyGHKcBnxUnoHit7vg6mHv0SMh1QdbHKSjmRvOut2IxHDS3Ot/SxvRDGeXp3iqLuZefvP7L3toeBPQ/fdJ8AbORwC+VxZQ/1KMtB+cPeTfO7HaajneNMvV/twhm656SxfR7sG4ApzXKyu8KPLRfQ6R9QyZVpU6eLjEjTQPbJLSNNBk4K6JpqXQF70shBNQJGdWMeu9XltrQsiy8NKS+pKW2mvJrnugh3TiR8YpunDP+lyawS00sNEsVGcDkRBDxe75vI4T8gejDpbotpesFUMz9amsGRqyfldvPIwf6TluUNZnd3RRZ05SZCza9c8Xp6U9XP0itxCvQ/9mBJY1r2tLsTsnIjI/Xm903Guv4aErkzS8CUppJpz9AkgpWFM6kDxb03NHcTr8wI6GeSuFOPz/cPVz/vIl/g0Cr9mJYN2GXuT1NZXrwdZJb97LGO1ebO1Sy+cGrU1ABj4OdZld2fCJqEA3GO6pBVyNcTPKvaOmptJXKouGat6zTxhgBOT0k0ahWdNh4nP7csXBlmN5oUVtOTKUf+J8U6+z7NorzAyhgQrc4tWfu1w5t6ZRuojLJcFGf8CRiSENSyUGr6yWxdCqIJDFpRzB7R1+66gnDfiTw3MVsXwTGFWmIBN8FGJPXPrfAv08Ww0eFgtQ30ws=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(366004)(396003)(376002)(346002)(451199015)(53546011)(36756003)(6506007)(31696002)(86362001)(478600001)(6486002)(5660300002)(6666004)(8936002)(44832011)(7416002)(41300700001)(4326008)(110136005)(66556008)(8676002)(66476007)(66946007)(54906003)(316002)(2906002)(83380400001)(38100700002)(186003)(2616005)(6512007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmpSTnNrZXRDdjNSQXdGZ01hVTdsRGpyZXFPQUtiZW1oNndCY3JlVEtGNU9w?=
 =?utf-8?B?eUhaZUpqNTdLdWRNZWtpeDQrVmR5dmE3Qk4rL3hJR3N2b2NRVDEwMHZja3Bs?=
 =?utf-8?B?QkRkSkp4NnZ2RlFQMWdtek5zUFBnNlluZkpDYUpaOVVITElYOGRoTnpwbEhH?=
 =?utf-8?B?SjhCenlGVG5vbnFSclJVa0hIcEFRQ29EbGIrcEoxL3J2SzEyUlMxbzFvaDRw?=
 =?utf-8?B?SlNYNS83REU5V3VHZC9vaTZBZExYbVRqN0pjM1VtSmJ3VTAxN0lZYlVLaXdI?=
 =?utf-8?B?OWVMM3J0TlErMVF6TzRHRjZaSDUzbnFReEdWb0lDTXhIa1o2K0ZKWXdMQzU5?=
 =?utf-8?B?TUwwUWJmOERBdUkvMDY5YndScG5lM3ZnT3pvZmFwaEpCeDNsZS9zWHMvY3Zz?=
 =?utf-8?B?T2ZYTE8xOU91czJvTUdvNDMwa1d2LzdzTGNXVFJGV3k3bGluRTFrUi80NlNV?=
 =?utf-8?B?NFhoSkd2Y1FsOTlxZkEySkE2YmVDSnRPYjUwR3Ewdmd1cXB5NDFFdE1tMElO?=
 =?utf-8?B?TXBLUVNEcVpiMENBWlMrUVVnMmFta2h3YnBLQnJVOGoveFNCMURFVUhtSXh2?=
 =?utf-8?B?NDNhWjFZZU5DU3g0TGFxZWpDVXR4UnpBRjFmT2pRZXUzNkJUVHg5MXFYblFV?=
 =?utf-8?B?WWFVT3FTd3JwbFBYU3VlSGhYbVVyc2RLdlgybTg4QlBWV3hkYy9WUjZHK1Q4?=
 =?utf-8?B?OFpEL1p3Y04remNQWWlJbGRBUUpTSDczaGJZK1JKVjcwMXQyczB2czdEb0ds?=
 =?utf-8?B?enowUWtZYTRpNGhoYXY3T0Jad0k0YzNrSmxuNHRMK2pHNWs2VVNrZmNPN0hR?=
 =?utf-8?B?UmFLNllvTThXc05sWFFVT3RmWVZFT3A2NHk4WittR25ucUhkMmt1WHFmaW1o?=
 =?utf-8?B?UUtaNkoyK2kvL294bWNQMnJ5RWpCV3F5VldFM3lHRWozWTI3em5pMWlSM3l2?=
 =?utf-8?B?ZlowQWVTK25uUWgxcUtPblJXSmtVK3JDVnlqMVIzd29ObVlsVnF0SUplM1ha?=
 =?utf-8?B?Y1VIV0hWdWdqZFVyMXNlS1gvcVo2UFV1N1l2d3ExblNoYnBHMXhKcUdhVkVz?=
 =?utf-8?B?cWtrZ2dMcGJvWVdqNlo1M09pRzl6Ym53ZDRMWFpVbHVLWHpEUWYzanB4Z0Vu?=
 =?utf-8?B?VUxVV0t2QVpxcWZKVU5EU1MyYjA3cHBLbWpGV1NtR093cURSMzZCQm92Zm9m?=
 =?utf-8?B?RThqODM3YTFlL0dSWTF2VFFHNFFJQUQwYlZpN0tLNXBYcXBxUjMvQW1VU3da?=
 =?utf-8?B?ZlpUckpzeGRjZXE1a2N2azNuWjl3V0MzTzBJcVhOZUM4LzR4UUtZc05ubWhs?=
 =?utf-8?B?bjA2cDhQakpFZlVQdE5ZN0o3UTFDdFJPc2xpM1lmQm5KeEU0dVB4QUt1VkZj?=
 =?utf-8?B?Zk5YV1hBVUxLOHV1dlh5dFRObWZpWmEzVWQvMVBBRTF4TTNKdm9Pa3ZsbnNQ?=
 =?utf-8?B?ZUZaZ1k5SUxXckpFd002Rk9zUWowUG9sRk9qZDQrTzNyV28wVFkzZnVsY3Zm?=
 =?utf-8?B?SjhoMWpySzlUQytqeU1ZUjA0Y3FCSHh0Z2NCWmdWUXV5cmZ4dytCZDJHZmFP?=
 =?utf-8?B?Qi81a3lHQlhrL2RmQ0FRcnhhY2l1SkZLQ0d3eHJpOFJZTGEwdFJyTzk0L0xl?=
 =?utf-8?B?cWhoTnlmblNTRXluMVJYOEtrMEVibHdFWGZFb1ZqVFB3NlZIL1RzSDF2a1gy?=
 =?utf-8?B?cU1pSmRGWFNLVkVTd0lHa3RKVFdURnl5WFEwUVVyUUdRU0Z6UHZVSUQrSEYw?=
 =?utf-8?B?L0ZZNUtjREdnMHNwME5kMGRqd1gyK1ZXQTlPdjZ3N2pjTTVBZldBNHZhaXVi?=
 =?utf-8?B?UWRDVGZWK0owVEcybWRWallVN0pGYVhiVzJPRDFlQzNaMVhGRTVuNFYzenho?=
 =?utf-8?B?RDh5cG81MXR1SS84dG1mRHRHTHg5RnZUM09IN24zR21PM1c5bDJ3cnluRnVV?=
 =?utf-8?B?QzBSTjAxT3hBMEw5czhLZTRTVnkrOFpHVW9vNjNaU0RZSjNDMDFjS3ZvQ1ZC?=
 =?utf-8?B?VmkzTFlkWEZ5UFZSQ055SEdqbzhxNWNQYVBPUDBkRFBiaEJsMHk2UkZRRWVt?=
 =?utf-8?B?Tk9Uc29pVysrSjQ1eWI3eld1TENSOGJhcGRiekZBR1BDM1pRazI5Rk9acDA2?=
 =?utf-8?B?ajgwckd6UVZUZUJsMWI4RHQxbGFYRWZ6ODIxYU9sRE85QXNFU0ZHemtzdlhV?=
 =?utf-8?B?ZkdEeEsxcmFuT0NmUG5VSDVkeGcrNzRTbThzRlRFQUpjaTc3ZlhwK3RjV3Za?=
 =?utf-8?B?NkRCWlh1NEF6elJBREhVWWw1K3dBPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1597d1ff-cbf5-426f-577d-08dad885fcbe
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 19:05:22.4232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JkO98YZ0+Ti3/nWN4C3zxkAyhuOWlxg6Qd84waPY5qRZz5Oa5pLdWYEarl715gMEjlkJ/vftZhXbfTeHR5PWO4V36pdCCbX87v84m5YafEw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7366
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-07_09,2022-12-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212070162
X-Proofpoint-GUID: qqaXxljUyN5pkYuliKUMZD5rrfqO0bv5
X-Proofpoint-ORIG-GUID: qqaXxljUyN5pkYuliKUMZD5rrfqO0bv5
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/22 10:49 AM, Sidhartha Kumar wrote:
> On 12/7/22 10:12 AM, Mike Kravetz wrote:
>> On 12/07/22 12:11, Muchun Song wrote:
>>>
>>>
>>>> On Dec 7, 2022, at 11:42, Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>>>
>>>> On 12/07/22 11:34, Muchun Song wrote:
>>>>>
>>>>>
>>>>>> On Nov 30, 2022, at 06:50, Sidhartha Kumar 
>>>>>> <sidhartha.kumar@oracle.com> wrote:
>>>>>>
>>>>>> Add folio equivalents for set_compound_order() and 
>>>>>> set_compound_page_dtor().
>>>>>>
>>>>>> Also remove extra new-lines introduced by mm/hugetlb: convert
>>>>>> move_hugetlb_state() to folios and mm/hugetlb_cgroup: convert
>>>>>> hugetlb_cgroup_uncharge_page() to folios.
>>>>>>
>>>>>> Suggested-by: Mike Kravetz <mike.kravetz@oracle.com>
>>>>>> Suggested-by: Muchun Song <songmuchun@bytedance.com>
>>>>>> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
>>>>>> ---
>>>>>> include/linux/mm.h | 16 ++++++++++++++++
>>>>>> mm/hugetlb.c       |  4 +---
>>>>>> 2 files changed, 17 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>>>>> index a48c5ad16a5e..2bdef8a5298a 100644
>>>>>> --- a/include/linux/mm.h
>>>>>> +++ b/include/linux/mm.h
>>>>>> @@ -972,6 +972,13 @@ static inline void 
>>>>>> set_compound_page_dtor(struct page *page,
>>>>>> page[1].compound_dtor = compound_dtor;
>>>>>> }
>>>>>>
>>>>>> +static inline void folio_set_compound_dtor(struct folio *folio,
>>>>>> + enum compound_dtor_id compound_dtor)
>>>>>> +{
>>>>>> + VM_BUG_ON_FOLIO(compound_dtor >= NR_COMPOUND_DTORS, folio);
>>>>>> + folio->_folio_dtor = compound_dtor;
>>>>>> +}
>>>>>> +
>>>>>> void destroy_large_folio(struct folio *folio);
>>>>>>
>>>>>> static inline int head_compound_pincount(struct page *head)
>>>>>> @@ -987,6 +994,15 @@ static inline void set_compound_order(struct 
>>>>>> page *page, unsigned int order)
>>>>>> #endif
>>>>>> }
>>>>>>
>>>>>> +static inline void folio_set_compound_order(struct folio *folio,
>>>>>> + unsigned int order)
>>>>>> +{
>>>>>> + folio->_folio_order = order;
>>>>>> +#ifdef CONFIG_64BIT
>>>>>> + folio->_folio_nr_pages = order ? 1U << order : 0;
>>>>>
>>>>> It seems that you think the user could pass 0 to order. However,
>>>>> ->_folio_nr_pages and ->_folio_order fields are invalid for order-0 
>>>>> pages.
>>>>> You should not touch it. So this should be:
>>>>>
>>>>> static inline void folio_set_compound_order(struct folio *folio,
>>>>>      unsigned int order)
>>>>> {
>>>>>     if (!folio_test_large(folio))
>>>>>         return;
>>>>>
>>>>>     folio->_folio_order = order;
>>>>> #ifdef CONFIG_64BIT
>>>>>     folio->_folio_nr_pages = 1U << order;
>>>>> #endif
>>>>> }
>>>>
>>>> I believe this was changed to accommodate the code in
>>>> __destroy_compound_gigantic_page().  It is used in a subsequent patch.
>>>> Here is the v6.0 version of the routine.
>>>
>>> Thanks for your clarification.
>>>
>>>>
>>>> static void __destroy_compound_gigantic_page(struct page *page,
>>>> unsigned int order, bool demote)
>>>> {
>>>>     int i;
>>>>     int nr_pages = 1 << order;
>>>>     struct page *p = page + 1;
>>>>
>>>>     atomic_set(compound_mapcount_ptr(page), 0);
>>>>     atomic_set(compound_pincount_ptr(page), 0);
>>>>
>>>>     for (i = 1; i < nr_pages; i++, p = mem_map_next(p, page, i)) {
>>>>         p->mapping = NULL;
>>>>         clear_compound_head(p);
>>>>         if (!demote)
>>>>             set_page_refcounted(p);
>>>>     }
>>>>
>>>>     set_compound_order(page, 0);
>>>> #ifdef CONFIG_64BIT
>>>>     page[1].compound_nr = 0;
>>>> #endif
>>>>     __ClearPageHead(page);
>>>> }
>>>>
>>>>
>>>> Might have been better to change this set_compound_order call to
>>>> folio_set_compound_order in this patch.
>>>>
>>>
>>> Agree. It has confused me a lot. I suggest changing the code to the
>>> followings. The folio_test_large() check is still to avoid unexpected
>>> users for OOB.
>>>
>>> static inline void folio_set_compound_order(struct folio *folio,
>>>                         unsigned int order)
>>> {
>>>     VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
>>>     // or
>>>     // if (!folio_test_large(folio))
>>>     //     return;
>>>
>>>     folio->_folio_order = order;
>>> #ifdef CONFIG_64BIT
>>>     folio->_folio_nr_pages = order ? 1U << order : 0;
>>> #endif
>>> }
>>
>> I think the VM_BUG_ON_FOLIO is appropriate as it would at least flag
>> data corruption.
>>
> As Mike pointed out, my intention with supporting the 0 case was to 
> cleanup the __destroy_compound_gigantic_page code by moving the ifdef 
> CONFIG_64BIT lines to folio_set_compound_order(). I'll add the 
> VM_BUG_ON_FOLIO line as well as a comment to make it clear it is not 
> normally supported.
> 
>> Thinking about this some more, it seems that hugetlb is the only caller
>> that abuses folio_set_compound_order (and previously set_compound_order)
>> by passing in a zero order.  Since it is unlikely that anyone knows of
>> this abuse, it might be good to add a comment to the routine to note
>> why it handles the zero case.  This might help prevent changes which
>> would potentially break hugetlb.
> 
> +/*
> + * _folio_nr_pages and _folio_order are invalid for
> + * order-zero pages. An exception is hugetlb, which passes
> + * in a zero order in __destroy_compound_gigantic_page().
> + */
>   static inline void folio_set_compound_order(struct folio *folio,
>                  unsigned int order)
>   {
> +       VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
> +
>          folio->_folio_order = order;
>   #ifdef CONFIG_64BIT
>          folio->_folio_nr_pages = order ? 1U << order : 0;
> 
> Does this comment work?
> 
> 

I will change the comment from referencing 
__destory_compound_gigantic_page()
to __destroy_compound_gigantic_folio, although 
__prep_compound_gigantic_folio() is another user of 
folio_set_compound_order(folio, 0). Should the sentence just be "An 
exception is hugetlb, which passes in a zero order"?
