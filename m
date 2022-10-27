Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693666101A3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 21:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235822AbiJ0T3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 15:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234988AbiJ0T3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 15:29:22 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8FB78BD1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 12:29:21 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29RHmpFN001416;
        Thu, 27 Oct 2022 19:28:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=LMItJ3yW6sPPg7eShJZXRLDCBZK8f/z3Elqr4S5Peo4=;
 b=2tPCucoB+O7dNoAQo4PcWalZdvY/bKm678rpuY+IpF6zOJGEuPSDwQm2W3NJBcVh7KHY
 YcfRGhZgLNnhHd6XWnvCSvgWykEkjfhiz9WlcfS+nbSnQn37SljKLMWa+n6e2xOIDvrD
 ixMj1wwoZXOLQrqbeyABeWu+hbzHv/S8ZEZwBE+BHGKf0UDwgu0eZVlWxKPee8Vmf6oL
 TrMxU0f88Qz0HVOcOvxc/3XKjQcSjBw7lMMRCK6sTWIFzAihZehFP/rR3ZVVJlIqXDuL
 cv0613qGu4jbspZft9pO78Ij4mVobHsVPWY6RApNicLthZIPuxpzdKOvp+VexMzfIdxD Bw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfawru54r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 19:28:46 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29RIT3LN026553;
        Thu, 27 Oct 2022 19:28:45 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kfagqb8ac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 19:28:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ag5gYQyHJEIR/ysyuMXj3a46oIg0582+NCbSA8FLlasN/8HH5Bhfa5QzLSF4Do1oOq3X9jFX1M8OZ1MAJla/DmlHU2FMrXFtoB+292gkl54rTQOMTrGbnq+LbiaWBx1d9s3rbL+4NmFk8YTXJIfS9aSasV5DfjDfLkTk5+AaB7lM38/72BtZ0fwQeKJqE+Fdxuo5kLohZnpo5psRtXwSXIYuUEa3jkMt3DekVjhm/bgGQGdBW2dzYFd6QpZGOgLwE8Zpn2NM7vXd56nJClF17DlAlzxvmqDzyLoupnl0X7Fi740k+eAkoEWJdN9K6YCpcx7Uu4N7X5uhlDAzJbXbYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LMItJ3yW6sPPg7eShJZXRLDCBZK8f/z3Elqr4S5Peo4=;
 b=WCZBCpg21l4VynYFACyMKerA5+DG5zBGAOLsOfml3gSijVJMNeoHG+5lQMakzLmeifxvTETxSYsfrRXh5wPx4+Rp0m6Ds2MaA2XgI2lgb8p9/T6cZz45fd5mxMrmxT9ZoTg8BWPSi80Bg0/spxwOEny9rYL3oBehue6+HK8DxZqQ+1sb1azArbhH0B02Dt7VY8t9JNKiydcMajVw/4IcEpgHOVP2MOXe2nbnhI883LL1mX4S+dFqnWy86Gnsj0PwBAKiIN7FICyxYx1QW9L7v+Wo5chjKEV1lXUCQeatDRta1ntJteSlkhUAzAxO0EJwBzNUcaGUp2UeCGVGQBqXXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMItJ3yW6sPPg7eShJZXRLDCBZK8f/z3Elqr4S5Peo4=;
 b=IQS6PGnpTYUQy9CWSl+oOxWx01WPQCPDN5BkDinnrzX//2moxZIc3a2U74ch3QKhFDcBktxdfVqXnSzvnzzAppy66yFFqr5GFLAmRqIFmh5gOls9oVWCpYe9yTmd6yaB/Xt8VFECZeRciC+IAS+omV0Mq2zZQ7bTiVOjy1GrvIo=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by SA1PR10MB6470.namprd10.prod.outlook.com (2603:10b6:806:29f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Thu, 27 Oct
 2022 19:28:41 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7%9]) with mapi id 15.20.5769.014; Thu, 27 Oct 2022
 19:28:41 +0000
Message-ID: <368a61e7-818b-2ee4-8c8b-22218373622d@oracle.com>
Date:   Thu, 27 Oct 2022 14:28:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v12 7/7] x86/crash: Add x86 crash hotplug support
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>, David Hildenbrand <david@redhat.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org,
        sourabhjain@linux.ibm.com, linux-mm@kvack.org
References: <d6386653-eb71-188c-8a09-5db46b4e42d4@oracle.com>
 <YzcqE1RVtPcuLlxN@zn.tnic> <Y0Dh4ieUUZ4oXa1/@MiWiFi-R3L-srv>
 <Y0b9apyIs+RpSo1e@zn.tnic> <53aed03e-2eed-09b1-9532-fe4e497ea47d@oracle.com>
 <Y0cmaPTKQuWtwIRh@zn.tnic> <Y0d+mFivS+88+Chr@MiWiFi-R3L-srv>
 <Y1e7Hw0PRDI9NxU9@zn.tnic> <Y1lIoTBNvHrKX5K9@MiWiFi-R3L-srv>
 <d2ce1bed-a053-4840-2e84-643b678392c1@redhat.com>
 <Y1qNBDY99Ypan9Ok@MiWiFi-R3L-srv>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <Y1qNBDY99Ypan9Ok@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR2101CA0008.namprd21.prod.outlook.com
 (2603:10b6:805:106::18) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|SA1PR10MB6470:EE_
X-MS-Office365-Filtering-Correlation-Id: b3686153-9224-4393-cf83-08dab8517466
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Lm+8TpD83wJVYdw9I1d9rXdTmjGaL6yN7jFzg4d+ZBk5mS4Q4liadiuz22OMNtvXrbkvkEULA2u0hI4c7NBLltqDy5vxIhqJeG2AeXb45bLrf3AYW87DwTp1KaiI16rz0hJFbUaWOJa9bZnT2fm2G57uxeQHTo297kB4ZqEnTM/zEUlIcLZJLERwa7Ydt4gKHgwO1yrxAS+yDlWXHvFOf/O+2WzXScRlBdcmzP/EXWbLmaTQ0Q5d8MP33lt3wiFUX901y+mvFhKwPlanfh+U0uESl/HAt2JT5IqeVUMzBSfEO2Vj2TzE9RkbtbqyzltZoCtI8CUlwzGd+KgQGniWsjXqqJrZcesavssKIXLMDChKDb8M4LhaE+e0XaAKSp6o7Pw9/V8ZLEStfhkAEK5AYc7VfhTN2NjqHNZ+CsQYwHn8pDvIGV9bvouyL1iyaF2qZ50GlIePGHlkdB/VwFjZtFH5anjguxqq/GqhOMGrh/cIOIVBFstIijoBE+uPieBeRXK4cuEcz6JMdRyVtdRM2ggQ4u+5gXqrjvHISqxVAc5xl5RcjESRbem6P2AmEGAPQAJFvCzWFgW/yisUgW3Kob5LMXce4BVVc/KbcDu+jzP5+R++NtC498udfuNIjcVZKttk5Epnn52g2S82q8+ckSxU+sVe+/dXjbxP0fEdme2QS3DO5u/NEoWqkhmBC6852pl1lTV/m1xyYrSoLhuSwPYthb1W4p2YqwgLD3pBXH00Hb+Ip3jS2y+NrwWYF1avo0xuLGxrPeChRnfikQjsi+lEp3rae08cA88aYYZMWg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(376002)(39860400002)(396003)(136003)(451199015)(31686004)(31696002)(36756003)(86362001)(41300700001)(8936002)(5660300002)(7416002)(2906002)(186003)(83380400001)(2616005)(38100700002)(54906003)(316002)(66946007)(66556008)(66476007)(4326008)(8676002)(110136005)(6512007)(53546011)(6506007)(6666004)(478600001)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alZhTjVNTHJTL0hHNy9FRkpNMFZxcHF4Sk5TdyszZXdNeVpwRlRiUXBLTU1U?=
 =?utf-8?B?ckMzU3M3N08zUDMrMDhsanZ3S1FLNGUvT3ZGcS9ScitCcEl2ZGU4R3drbEZG?=
 =?utf-8?B?bVFmVDZqc0E2Y3RrS1cyNWVSRVNyUjFYZjZDNFBSUExSSG9Kby82a2JkOGxS?=
 =?utf-8?B?czhMeTBuMEJMbDJSQkN0b09ZamhiR2Q3SXZlcWJNcjR6YVEzRXZOSW5DVnlk?=
 =?utf-8?B?NllLVkYwNWdvK0VhMTl0SVRRRGtLa1J2MFFtMUg1c2VlRW1nRW1Yc3ZXS2lO?=
 =?utf-8?B?RmREeTZDL0NHZGREN2trVnExeGxONVdta1gydldUM3FycHpwalIvYWRzam85?=
 =?utf-8?B?enJjd0hKWTRKb0ttSzBYWVNDUUNjcXhRcUFsaFUvWEdwbllSNDQxcGJkRWZo?=
 =?utf-8?B?VXB4TUN3eWdEREY3dnY4SFFxSVBITDlHdVJkcmNMQzBkZUFFUmRnODAxejlJ?=
 =?utf-8?B?cGE4ZlB3UzhhUk8wMGF2VWhSdE9OUTRFREhwZ3JiY2w4anRGWEhPSmkySndz?=
 =?utf-8?B?THNmOGxOcjJvR3hyK3lkZGtMMkg4QkQrWGp2KzNkb0JyQ0dqS3k1cTR3U25V?=
 =?utf-8?B?YzJJQUpScXJRUi9JaGlhMXl0dTUvYnJMQ1JvaENtMlVLdFpyeWpQaTdWR0p4?=
 =?utf-8?B?ZVhlZVRnNUNMTFlEd0FkNnVQeU9JVTBDNytFUFgrYjIzNVdBa0N2YitObzJZ?=
 =?utf-8?B?UzlPekdNbzdoY21RZEQ0SUhPT2Q4RG9YUXR4UGtyVnBxNk1hOXAvNS9CZFlQ?=
 =?utf-8?B?QXVXbXJTS1d5S1JlV0FsV3ErMEN0WFZtbkcxLzg1M1hRQmE3bzNRZ3lwZERD?=
 =?utf-8?B?Y0tIT0lzM2x4UHZod2dFeWdHQ014RzFiRVJGOXNsbHpvVzh6T3hKTDh4dkx1?=
 =?utf-8?B?VzhYRkpBaklUTE5DMWNhcVo3M1hzdjJQQ1V6bEhUZzdsWThtcmhuWHRzdE9a?=
 =?utf-8?B?SDRZTTBUeFdnM3pDMVczK0pZRVEwT1BKMkZ3NEo5SVBHbnNRd01OOWdyYTdL?=
 =?utf-8?B?eDBKOVRIRlQ4djAzbnhPeVptYWs1NFROenlpNWVHOU1yUWJIOFU1MG1xamt1?=
 =?utf-8?B?aVM3WDdMRytJU1lBZlpPOXdWZnJRSmFvNDNHSmlVR1RLeEI0alpVRU45MHpG?=
 =?utf-8?B?UzFGRjBrNXRoSXJJQ21IRlBiSXU5TkxpZ3dhYnMzYUxKUnJVckZ6ZjBzcDdo?=
 =?utf-8?B?VC9aa3ZSSGVZRWVQOXZHdlFNWjYxbFNkWm9EOHJZY21VMnBLd0o0WGVaZklG?=
 =?utf-8?B?K0laK0V5aUVMdkptWUQyWDlEd1pHZkd2WTVHejQrbDQyZ1B5YTg4UFh5TEtr?=
 =?utf-8?B?S0tkZTBXN21rNlFNalAzNlBIamFOUUhaRkIvZllvcEpOci9VNkdEait4elV1?=
 =?utf-8?B?cE5zQWpFb3NRVnFuLzBXakF2dXNBQkFDRG5laWVWZlp5N1NZYjR1N28zbjhn?=
 =?utf-8?B?T2JESzgza2R3aW9IMUVUeVRPa2JlYzJuTHBiTEZkNGhhaTUrR2gxSEk1eVlJ?=
 =?utf-8?B?and3UkZZREhrbUtmSGZURjlLTk81YmhhUWNJbk5XL3E5dnpXeUgzUXFjZTRs?=
 =?utf-8?B?T3VMSElUMVdFa2NpWTBZRkJibkU3ZXhrcEh3OEMxL0lCR2J0Zk0wYlVhSGJ4?=
 =?utf-8?B?bm1pcjdIelIzL21iazRYL1VHTjRoUjdHSDdTNVhwVGpEVHYwYlpVVUlBVm9x?=
 =?utf-8?B?Q3BRd3V1YTFrb2RJaHhrV3d6YUxHSWpvU1VLSFoyNU5xQ0xPaGYra1dVSzJG?=
 =?utf-8?B?SjNrVWtwTzhTYmYvY3E3bU9QMEJVS2hCMWhXWmFwSFBIbXNvRmpOZHJSdmdj?=
 =?utf-8?B?ZW1aaTBsdFNRWWF0aUkwcHR4aGhRYURKRXBQcit3elRJcWtLNGh4SzNvK2N4?=
 =?utf-8?B?Z0Jybkp4NG5wanJSSkd5OTF3dkxFaDVoeGMydDFTTiswallYVUVsRlJ4RmlW?=
 =?utf-8?B?a0srMUpSVzNoNGF1dmc3bEl4NTFBS3loaS9DNGlteGZON0lxSkRBdTltUkt1?=
 =?utf-8?B?cHFkbnVBRm45ZlVia2MxclJrOW5OVldkQVRJY2loMG9GbjFZbXNOL1BtN21m?=
 =?utf-8?B?d0crakgxSVB4YlZycFJLSDhTYXZOUlQ0OC9PY01yT29CZjA1WHRjcTVEckt1?=
 =?utf-8?B?cUFVWTFNcmQwdktFckNzZ3F3b09iYVdDeEtjOGs4WW1tVGNkL3o3emVLMmJi?=
 =?utf-8?Q?sYcPbVHqvbm3/VCopl8Z0DA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3686153-9224-4393-cf83-08dab8517466
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 19:28:41.3602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kyigMhipPU/Joi6pbVHKM2R3dkNC++iMn9j8QvxOHcHmWlcEb/SZ36usfZxHyeH2FCCw4J8MSgdgXscgowGV59nvdAhb7wkwWWCh0LyAOZc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6470
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-27_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210270110
X-Proofpoint-ORIG-GUID: AYD_Lf8TJOeKc0C-T2sTSUCzcKKvAZe2
X-Proofpoint-GUID: AYD_Lf8TJOeKc0C-T2sTSUCzcKKvAZe2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/27/22 08:52, Baoquan He wrote:
> On 10/26/22 at 04:54pm, David Hildenbrand wrote:
>> On 26.10.22 16:48, Baoquan He wrote:
>>> On 10/25/22 at 12:31pm, Borislav Petkov wrote:
>>>> On Thu, Oct 13, 2022 at 10:57:28AM +0800, Baoquan He wrote:
>>>>> The concern to range number mainly is on Virt guest systems.
>>>>
>>>> And why would virt emulate 1K hotpluggable DIMM slots and not emulate a
>>>> real machine?
>>
>> IIRC, ACPI only allows for 256 slots. PPC dlpar might provide more.
>>
>>>
>>> Well, currently, mem hotpug is an important feature on virt system to
>>> dynamically increase/shrink memory on the system. If only emulating real
>>> machine, it won't be different than bare metal system.
>>>
>>> IIRC, the ballon driver or virtio-mem feature can add memory board, e.g
>>> 1G, block size is 128M, 8 blocks added. When shrinking this 1G memory
>>> later, it will take best effort way to hot remove memory. Means if any
>>> memory block is occupied, it will be kept there. Finally we could only
>>> remove every second blocks, 4 blocks altogether. Then the left
>>> un-removed blocks will produce 4 separate memory regions. Like this, a
>>> virt guest could have many memory regions in kernel after memory
>>> being added/removed.
>>>
>>> If I am wrong, Please correct me, David.
>>
>> Yes, virtio-mem (but also PPC dlpar) can result in many individual memory
>> blocks with holes in between after hotunplug. Hotplug OTOH, usually tries to
>> "plug" these holes and reduce the total number of memory blocks. It might be
>> rare that our range will be heavily fragmented after unplug, but it's
>> certainly possible.
>>
>> [...]
>>
>>>
>>> Yes, now assume we have a HPE SGI system and it has memory hotplug
>>> capacity. The system itself has already got memory regions more than
>>> 1024. Then when we hot add extra memory board, we want to include the
>>> newly added memory regions into elfcorehdr so that it will be dumped out
>>> in kdump kernel.
>>>
>>> That's why I earlier suggested 2048 for number of memory regions.
>>
>> The more the better, unless "it hurts". Assuming a single memory block is
>> 128 MiB, that would be 256 GiB.
>>
>> Usually, on big systems, the memory block size is 2 GiB. So 4 TiB.
> 
> Thanks a lot for these valuable inputs, David.
> 
> Hi Boris, Eric
> 
> So what's your suggested value for the Kconfig option?
> 
> 1) cpu number, 1024?
> 2) memory regions, 2048?
> 
> About below draft, any comment? We can decide a value based on our
> knowledge, can adjust later if any real system has more than the number.
> 
> +config CRASH_ELF_CORE_PHDRS_NUM
> +       depends on CRASH_DUMP && KEXEC_FILE && (HOTPLUG_CPU || MEMORY_HOTPLUG)
> +       int
> +       default 3072
> +       help
> +         For the kexec_file_load path, specify the default number of
> +         phdr for the vmcore. E.g the memory regions represented by the
> +         'System RAM' entries in /proc/iomem, the cpu notes of each
> +         present cpu stored in /sys/devices/system/cpu/cpuX/crash_notes.
> 
> Thanks
> Baoquan
> 

I prefer to keep CRASH_MAX_MEMORY_RANGES, as explained in my response to your message on October 26.
eric
