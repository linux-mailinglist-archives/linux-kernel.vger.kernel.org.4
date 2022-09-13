Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0655B7A9B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 21:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbiIMTNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 15:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbiIMTNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 15:13:15 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB4D61B0F
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 12:13:13 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28DIfQdI027079;
        Tue, 13 Sep 2022 19:12:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=AO+PaVuKYfTMq4HgpQWV8zi90ZPEP170vlxTyo2tzjk=;
 b=IyinWeLjN9DAN8qVliK0qy+eXdjWF2Iti0mAmJtM/KxAuBIOXRSisERa0ToB97JlUqlO
 a3qzrvO/xm6SjLqMIlMBYCj+6akiF5QmROD/k6kyqM11ijOFZkzHP+4r1zCen6PS3oQ9
 I6ORxnw42QYYriPDLEDzA060qI3Qq/wbJ21jqWm9tzf+LU5aovj2+zHCTcYlWGlZZBM+
 xqkRIvi3qrFSpVPEHGVLL+UahcXQoAF+m1LP1ZX0ONVbSyHXfW0gGHozEmkMeR3T3PUm
 XHEQYV/Eux7K/LIw7HqiUUgoGUscUjDYaonjVg+pZlwUIvqhKAVDfvh5ETAyd+bR3WdC Wg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jjxyc84t5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Sep 2022 19:12:41 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28DIkcKF023900;
        Tue, 13 Sep 2022 19:12:41 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2042.outbound.protection.outlook.com [104.47.57.42])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jjyeggsg2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Sep 2022 19:12:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ofvI6ImAvYClSUza9Gm/8FRD8G3Ja6LHsWkZ1awIs7b3TvIhue9SzVaLNRZv0JzDeymN6UA0i+8ZbfAl7B8vE2s3oltxXjM02Se6t9Gh6oKbSwvm1N8uHNRA/hPHEoZT+4w7vN4THyaeMTN7ThWhH0CXBBdkBBjLNIGoE09h5oD5F0UM6TEqaXMywUoXQtbs+RifD7MmS3ao+SgrHWCGsjSczGmILN7Pv5nQX4vjY/S+rk28r2GfR6VtOAwiqMtKbs6caFjMNhd/dk/HJGGP89pEKgFSVOrr0ecTAY6nle8Y4Vec74l3GWBJcFoWUxoEXCFyqZMCNfHQAYGYUhPiyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AO+PaVuKYfTMq4HgpQWV8zi90ZPEP170vlxTyo2tzjk=;
 b=YZffkSxLK1UFWzgHQBdtsSn5zVUtII+tQ9KSpi6Gjxem2gKVeTSveAfmrVcpbqtxKhb/m2fN0Bj51l58oq0lmQH5duY9CrTui7tQ7zVYJ8mHMP1wzm3agWFmvL3IeoDUSpgkqJYs8w7fznp5Wx8uSodknbhHXQjMvmY9vcxbFVDB6z44smpaF796xwuoryq7CeEDxGDT/4gvDQqycO5kTcJL2ec3auwMWIX4d3GIEwzHccsSEXXe9qSUsQPwDcDmYr9hDQNWPUAf0vO4Y+ZnCqWW/u4u/7kJR1uM2v2WHSYt6wjXOS1uvRURv0ZqopVA0CCiUVq+GYTS/9pH+IlL/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AO+PaVuKYfTMq4HgpQWV8zi90ZPEP170vlxTyo2tzjk=;
 b=hZdxZw4g9fmbMsdx10PYOqxnh0TRFmzj1sab2TAbB6udnNzm/h1ifZocSYw8Lan/IAwjfsIq9U1Idss+T+MrBoEYvls62xL9xw9UKlHPfalFDD3rqrjKtIT8uOsNrsbIKRiHotI4GbXenB8Og6GuS7w9naejax9Cz6RFV7vB7S4=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by SA2PR10MB4570.namprd10.prod.outlook.com (2603:10b6:806:11e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.16; Tue, 13 Sep
 2022 19:12:38 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::18a0:409b:1256:1bcb]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::18a0:409b:1256:1bcb%4]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 19:12:38 +0000
Message-ID: <cb343eef-46be-2d67-b93a-84c75be86325@oracle.com>
Date:   Tue, 13 Sep 2022 14:12:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v12 7/7] x86/crash: Add x86 crash hotplug support
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
References: <20220909210509.6286-1-eric.devolder@oracle.com>
 <20220909210509.6286-8-eric.devolder@oracle.com>
 <Yx7XEcXZ8PwwQW95@nazgul.tnic>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <Yx7XEcXZ8PwwQW95@nazgul.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR16CA0039.namprd16.prod.outlook.com
 (2603:10b6:805:ca::16) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|SA2PR10MB4570:EE_
X-MS-Office365-Filtering-Correlation-Id: fd4a6535-c668-4c20-bf22-08da95bbec2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a6vhdf3d3AE4+exCOkQsWCUTC/R85rFCnoK/cKuhVOZkgNoUgmKNxnZI46KEx87mK/tMA/QKALDMqvyle5argt78q62QEaCZEMys40rGiFXhb5c+ghJBIQ8SzDkqvb0eSojKBBEyt5ayUNiBCFrNxPA2uRkK8qt5nwo/vSQ0MTD1tY7MVuzXskMa73GDS9+BZMoBrWI2zzoexGv3XyMHPOvWXd5s6dRLYrqYPgn6I+yW4/5IOAZGOi4xl8E8ECm2lpETrIDlp88VfzAVehRPI2+Rd4tpWH0EV8co53O1FTu/hDc+p0HyA+AT/Xpz9qQowrLr33lp88UlgEvAk1RPl0RL4iDNrigEAN4lwGkhJGQCH2v16nQXP/A2gJRJieXJEnkC+cWZDXOfsVVsljU2jXQvxTj4rE2N5t4sD27+1FH/djyB4x/dM+X4qyCZAPPbZIETFcYA7T6hI0tLwFzAmpdx0cO2wLURyTKk0Ou3h72ZuaOlMNsFbp3u7TE//5YvX2nzFVQg2rXQFUE1rXGcG9DbqmR9KGcQ+NooQbKpJvqflvPtw9BGiG5N+SQztlD+lU9bJbfX0Iok4sb+NDc/D2uA6BIjltQkmPEo7m7V3fjMJC53/bsMo55vD+XvvLGRlgq9Yt0ubTxzRbBEjU3N2kXmQdUJ9GrB7TKEUCqBsYm6vD9PyN+FR2Xqg2ijrx6eua9G8c9Y1raL4vP+tRdu6FnLyJpYnKWuivmfqhZEdk+dP/CzMHUngUiqQ2yp51/0wjFo1cK1mXw/qCicdOYzAz5eHSosx8le9wb8QJK4bIVIXFqGF6RzTmbJ8JnxEzKi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(366004)(396003)(136003)(39860400002)(451199015)(6916009)(5660300002)(107886003)(7416002)(38100700002)(66476007)(86362001)(31696002)(66556008)(66946007)(8676002)(966005)(41300700001)(4326008)(2906002)(478600001)(8936002)(6666004)(6486002)(316002)(31686004)(83380400001)(6506007)(186003)(6512007)(30864003)(2616005)(53546011)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDQybFJtTDg4cTRlMU05TTFkaG5nVmFGRjE1ZkI2TVFYdlBOQm9OSklXWXVX?=
 =?utf-8?B?dWh2LzVwYU52UzVQazg4em8rK3gxRGpHZ2dHVGFOMFhvd2RobzdJdEJUaDFx?=
 =?utf-8?B?QVdqMHo2aEd0V2l4dldGNUkxbHJWQWNOeE5HY1NLRldRdlM4S1krUWhVbHA2?=
 =?utf-8?B?R3pPTnhhbjA2RjZkZUo5OXJNditwZDhsSy92WWovM21EdytRNFhoTTd6b0Vl?=
 =?utf-8?B?ZFV0aFBBTVYrWmg3ODFkd1lsVWk1L3ZHQUlYY3JLYkVuRTU0ZXhkUVcva3Jv?=
 =?utf-8?B?dkhybTJPd2ptd0JKS3NWak9BM21qanFPeEJCZzdoVWNNQUd0Zi9CN29TdDJv?=
 =?utf-8?B?a04xeklpVFZ0b2F5a3RoSGJiLytobDU4TkppYUFPeTBUbXFpT2N0V0ZrYWlT?=
 =?utf-8?B?bUpSY21HQ3A1V2dWeUVWakFDcjRxc3NvbmhTeWl4TDB1emtjUzUyQ3lpcWh5?=
 =?utf-8?B?b1RxVFAxb1huaWFxbStWTmFQUytERmoyKzQveGw0c00zQ3hJMlBCS1RRdTZv?=
 =?utf-8?B?UGVKNDV3ZzN6eXNpSC9qdmt5Z2M5cUhYU1Y0Si9BT2h1SUFMNVhyOS80d05k?=
 =?utf-8?B?Y3o3dUl0SU1hdjJnaWtlUjQ5Zk5EWTYvanI3M0VyNmdaNmFTeFplR2g0b3BS?=
 =?utf-8?B?Wk0rK3cyYXBNR3dlb1oxOENQZkpId3JNVlVaeXVkaHljM3RnQjVZTWlsZCtT?=
 =?utf-8?B?azVJU0ZhcmFDOEFBcitPUWE5UlE5bzlKMzdENm1Rd3BGMkR2UGJyYVFjRFV0?=
 =?utf-8?B?MlF6Ni9sMkVLL0tLcWZHSGNneHN0YjRaNmc2aVBuM1RrMFJiMmgxUWkxM0tE?=
 =?utf-8?B?a2ZPU1J0VnJuL24xSzRWRkVFUnoxUGJYc0p6NlovRjVyVnNBZnBCV3h5N1pP?=
 =?utf-8?B?UVloV2owRDlFWWx5TVorbUp6QStTSVp1V011K21TUi9ObnorYUJNNFMrbHFa?=
 =?utf-8?B?cUZ2YXJkZXpqVHJpb3BSTHlWckJKM2UySldzQWJTeHNZTVFhZnFoYTM4T3Ns?=
 =?utf-8?B?OG45NGhTM1Q3L096Yk92bVhVQ251Z2s0eWUraWxZMzBJbjF6WVI1cDVYRFR2?=
 =?utf-8?B?QXZ0VWp1cDY3ZjN1NFUwRGozRjArWitUbWxXaDcxd1BoeHdmVEVxVEcxN2dh?=
 =?utf-8?B?VElIRTN1TmpoMURWVk56ck85ZWo0QUdaYmJjd3lHMGttN3FSbTBmSGVObDlS?=
 =?utf-8?B?d1hwdlFGSHNvLzc0WW5ic3ArQVdxdXZ4dmVtSTJ1djlDSFNYeDRHMG1yZG1r?=
 =?utf-8?B?cGhZb25YRVF6VTA1SGJiNVF0RjFIMnVnNTFjYlB6SW51Mm94VERDdmlwZks4?=
 =?utf-8?B?SVQ0M2g3dEdpOFR1UTFXcDlweHg3MFB0NnFZdkNPdnBaUHlwUnY0c1NIRHpr?=
 =?utf-8?B?NHAyaEFBNnl3cXQzaGRMQUNvVTRpdVE3TlYwSVlJd1JIUUZsTWZCQ01ISHla?=
 =?utf-8?B?N1V1dWZjNitDOTQzbVJ5Y00rd1l5cms5TkxJRVZ1RVJIeHhCWjZtTW1LQ3pu?=
 =?utf-8?B?OWJhcHc0NHFncktOVlJiZFlvb0g4QTBXTXI2MUpyQklyTHhJWWRBS0pQMFpO?=
 =?utf-8?B?OWVBaW5zOEdvRld6U2htanpHSUZxY3NDSHRndXhoT2pKdHR1bHNuSGQzMW0w?=
 =?utf-8?B?UlNlZ09UK1czTmk1L2E1K3pvcTRCL2ROS1FzQnV6MjlLVkx2SThHcTkvdzcw?=
 =?utf-8?B?eTE2TzB2cWVxNm5jRVBYbG8zdzZIUEgxZnZiM3I4WTZNQ1ZCSHFqQkt3OW8x?=
 =?utf-8?B?YzVEdjJFNGlLNFNVcDVWVS9iR1d2SUpZOGtIcGlLNE9GdzBoclBJOEo5aXE4?=
 =?utf-8?B?a0k2WGlObUk1MEI4VzB1a0MreFJhWXBUSXRhTjkyVng2MUNFUURhUHllaklp?=
 =?utf-8?B?S1dhUWlMb3RHaXR5WU9hOEdPbEVpM1czWkJpQmwzdlZ2YzZ3SVlhTHo1clRV?=
 =?utf-8?B?WExhc2NURWdhNmdmSk5qQ3JxTTRNbnNmMkdpWldoeGI1S1hqWmJWcTg0a2Va?=
 =?utf-8?B?M0FQUndWOUZZWWRickRJaFZCU251azltNG1qZUREenlvWVJhd0lPYnU4Sktn?=
 =?utf-8?B?Y3hJWUpJSmVtaDFBNStpQXNXSkk1cXd6RUhBMXFiNVgvUStzZUdFNFp5emZQ?=
 =?utf-8?B?WGxMNmtVZDhCdGRjc3dSeE9sbEN4T2xXK1QvQnV4a0FiaksrK25vUlU2NXlZ?=
 =?utf-8?Q?bDtoLKavmZCIP0Te99QbixY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd4a6535-c668-4c20-bf22-08da95bbec2e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 19:12:38.1974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kJNrM0BS5EapBWzsFB9d9W5Pq2rUs0LD6mD68aTxW5POlgQIWv8jx/xW6f047E3s0QVl5eDDOScoxRvyyqyJf08S1TxUbo+4bJEbxrUNzzQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4570
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-13_09,2022-09-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209130088
X-Proofpoint-ORIG-GUID: 4jItRaTEQ0GVcPqsz6GXtr5hBVVQInSA
X-Proofpoint-GUID: 4jItRaTEQ0GVcPqsz6GXtr5hBVVQInSA
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Boris,
Thanks for the feedback! Inline responses below.
eric

On 9/12/22 01:52, Borislav Petkov wrote:
> On Fri, Sep 09, 2022 at 05:05:09PM -0400, Eric DeVolder wrote:
>> For x86_64, when CPU or memory is hot un/plugged, the crash
>> elfcorehdr, which describes the CPUs and memory in the system,
>> must also be updated.
>>
>> When loading the crash kernel via kexec_load or kexec_file_load,
> 
> Please end function names with parentheses. Check the whole patch pls.
Done.

> 
>> the elfcorehdr is identified at run time in
>> crash_core:handle_hotplug_event().
>>
>> To update the elfcorehdr for x86_64, a new elfcorehdr must be
>> generated from the available CPUs and memory. The new elfcorehdr
>> is prepared into a buffer, and then installed over the top of
>> the existing elfcorehdr.
>>
>> In the patch 'kexec: exclude elfcorehdr from the segment digest'
>> the need to update purgatory due to the change in elfcorehdr was
>> eliminated.  As a result, no changes to purgatory or boot_params
>> (as the elfcorehdr= kernel command line parameter pointer
>> remains unchanged and correct) are needed, just elfcorehdr.
>>
>> To accommodate a growing number of resources via hotplug, the
>> elfcorehdr segment must be sufficiently large enough to accommodate
>> changes, see the CRASH_MAX_MEMORY_RANGES configure item.
>>
>> With this change, crash hotplug for kexec_file_load syscall
>> is supported.
> 
> Redundant sentence.
Removed.

> 
>> The kexec_load is also supported, but also
>> requires a corresponding change to userspace kexec-tools.
> 
> Ditto.
Removed.

> 
>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>> Acked-by: Baoquan He <bhe@redhat.com>
>> ---
>>   arch/x86/Kconfig             |  11 ++++
>>   arch/x86/include/asm/kexec.h |  20 +++++++
>>   arch/x86/kernel/crash.c      | 102 +++++++++++++++++++++++++++++++++++
>>   3 files changed, 133 insertions(+)
>>
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index f9920f1341c8..cdfc9b2fdf98 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -2056,6 +2056,17 @@ config CRASH_DUMP
>>   	  (CONFIG_RELOCATABLE=y).
>>   	  For more details see Documentation/admin-guide/kdump/kdump.rst
>>   
>> +config CRASH_MAX_MEMORY_RANGES
>> +	depends on CRASH_DUMP && KEXEC_FILE && (HOTPLUG_CPU || MEMORY_HOTPLUG)
>> +	int
>> +	default 32768
>> +	help
>> +	  For the kexec_file_load path, specify the maximum number of
>> +	  memory regions, eg. as represented by the 'System RAM' entries
>> +	  in /proc/iomem, that the elfcorehdr buffer/segment can accommodate.
>> +	  This value is combined with NR_CPUS and multiplied by Elf64_Phdr
>> +	  size to determine the final buffer size.
> 
> If I'm purely a user, I'm left wondering how to determine what to
> specify. Do you have a guidance text somewhere you can point to from
> here?

This topic was discussed previously https://lkml.org/lkml/2022/3/3/372.
David points out that terminology is tricky here due to differing behaviors.
And perhaps that is your point in asking for guidance text. It can be
complicated, but it all comes down to System RAM entries.

I could perhaps offer an overly simplified example such that for 1GiB block
size, for example, the CRASH_MAX_MEMORY_RANGES of 32768 would allow for 32TiB
of memory?

> 
>> +
>>   config KEXEC_JUMP
>>   	bool "kexec jump"
>>   	depends on KEXEC && HIBERNATION
>> diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
>> index a3760ca796aa..432073385b2d 100644
>> --- a/arch/x86/include/asm/kexec.h
>> +++ b/arch/x86/include/asm/kexec.h
>> @@ -212,6 +212,26 @@ typedef void crash_vmclear_fn(void);
>>   extern crash_vmclear_fn __rcu *crash_vmclear_loaded_vmcss;
>>   extern void kdump_nmi_shootdown_cpus(void);
>>   
>> +void *arch_map_crash_pages(unsigned long paddr, unsigned long size);
>> +#define arch_map_crash_pages arch_map_crash_pages
>> +
>> +void arch_unmap_crash_pages(void **ptr);
>> +#define arch_unmap_crash_pages arch_unmap_crash_pages
>> +
>> +void arch_crash_handle_hotplug_event(struct kimage *image,
>> +		unsigned int hp_action);
>> +#define arch_crash_handle_hotplug_event arch_crash_handle_hotplug_event
>> +
>> +#ifdef CONFIG_HOTPLUG_CPU
>> +static inline int crash_hotplug_cpu_support(void) { return 1; }
>> +#define crash_hotplug_cpu_support crash_hotplug_cpu_support
>> +#endif
>> +
>> +#ifdef CONFIG_MEMORY_HOTPLUG
>> +static inline int crash_hotplug_memory_support(void) { return 1; }
>> +#define crash_hotplug_memory_support crash_hotplug_memory_support
>> +#endif
>> +
>>   #endif /* __ASSEMBLY__ */
>>   
>>   #endif /* _ASM_X86_KEXEC_H */
>> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
>> index 9ceb93c176a6..8fc7d678ac72 100644
>> --- a/arch/x86/kernel/crash.c
>> +++ b/arch/x86/kernel/crash.c
>> @@ -25,6 +25,7 @@
>>   #include <linux/slab.h>
>>   #include <linux/vmalloc.h>
>>   #include <linux/memblock.h>
>> +#include <linux/highmem.h>
>>   
>>   #include <asm/processor.h>
>>   #include <asm/hardirq.h>
>> @@ -397,7 +398,18 @@ int crash_load_segments(struct kimage *image)
>>   	image->elf_headers = kbuf.buffer;
>>   	image->elf_headers_sz = kbuf.bufsz;
>>   
>> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
>> +	/* Ensure elfcorehdr segment large enough for hotplug changes */
>> +	kbuf.memsz =
>> +		(CONFIG_NR_CPUS_DEFAULT + CONFIG_CRASH_MAX_MEMORY_RANGES) *
>> +			sizeof(Elf64_Phdr);
> 
> 
> 	kbuf.memsz  = CONFIG_NR_CPUS_DEFAULT + CONFIG_CRASH_MAX_MEMORY_RANGES;
> 	kbuf.memsz *= sizeof(Elf64_Phdr);
> 
> looks more readable to me.
Done.

> 
> 
>> +	/* Mark as usable to crash kernel, else crash kernel fails on boot */
>> +	image->elf_headers_sz = kbuf.memsz;
>> +	image->elfcorehdr_index = image->nr_segments;
>> +	image->elfcorehdr_index_valid = true;
>> +#else
>>   	kbuf.memsz = kbuf.bufsz;
> 
> Do that initialization at the top where you declare kbuf and get rid of
> the #else branch.
The kbuf.bufsz value is obtained via a call to prepare_elf_headers(); I can not initialize it at its 
declaration.

> 
>> +#endif
>>   	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
>>   	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>>   	ret = kexec_add_buffer(&kbuf);
>> @@ -412,3 +424,93 @@ int crash_load_segments(struct kimage *image)
>>   	return ret;
>>   }
>>   #endif /* CONFIG_KEXEC_FILE */
>> +
>> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
> 
> This ugly ifdeffery is still here. Why don't you have stubs for the
> !defined() cases in the header so that you can drop those here?
> 

I'm at a loss as to what to do differently here. You've raised this issue before and I went back and 
looked at the suggestions then and I don't see how that applies to this situation. How is this 
situation different than the #ifdef CONFIG_KEXEC_FILE that immediately preceeds it?

I've included a copy of the current state of this section below for additional markup.

>> +/*
>> + * NOTE: The addresses and sizes passed to this routine have
>> + * already been fully aligned on page boundaries. There is no
>> + * need for massaging the address or size.
>> + */
>> +void *arch_map_crash_pages(unsigned long paddr, unsigned long size)
>> +{
>> +	void *ptr = NULL;
>> +
>> +	if (size > 0) {
>> +		struct page *page = pfn_to_page(paddr >> PAGE_SHIFT);
>> +
>> +		ptr = kmap_local_page(page);
>> +	}
>> +
>> +	return ptr;
>> +}
> 
> 	if (size > 0)
> 		return kmap_local_page(pfn_to_page(paddr >> PAGE_SHIFT));
> 	else
> 		return NULL;
> 
> That's it.
Done.

> 
>> +
>> +void arch_unmap_crash_pages(void **ptr)
>> +{
>> +	if (ptr) {
>> +		if (*ptr)
>> +			kunmap_local(*ptr);
>> +		*ptr = NULL;
>> +	}
> 
> Oh wow, this is just nuts. Why does it have to pass in a pointer to
> pointer which you have to carefully check twice? And why is it a void
> **?
A long time ago this made sense, but it no longer makes sense. I've corrected this.

> 
> And why are those called arch_ if all I see is the x86 variants? Are
> there gonna be other arches? And even if, why can't the other arches do
> kmap_local_page() too?
Currently there is a concurrent effort for PPC support by Sourabh Jain, and in that effort 
arch_map_crash_pages() is using __va(paddr).

I do not know the nuances between kmap_local_page() and __va() to answer the question.

If kmap_local_page() works for all archs, then I'm happy to drop these arch_ variants
and use it directly.

> 
>> +}
>> +
>> +/**
>> + * arch_crash_handle_hotplug_event() - Handle hotplug elfcorehdr changes
>> + * @image: the active struct kimage
>> + * @hp_action: the hot un/plug action being handled
>> + *
>> + * To accurately reflect hot un/plug changes, the new elfcorehdr
>> + * is prepared in a kernel buffer, and then it is written on top
>> + * of the existing/old elfcorehdr.
>> + */
>> +void arch_crash_handle_hotplug_event(struct kimage *image,
>> +	unsigned int hp_action)
> 
> Align arguments on the opening brace.
Done.

> 
>> +{
>> +	struct kexec_segment *ksegment;
>> +	unsigned char *ptr = NULL;
>> +	unsigned long elfsz = 0;
>> +	void *elfbuf = NULL;
>> +	unsigned long mem, memsz;
> 
> Please sort function local variables declaration in a reverse christmas
> tree order:
> 
> 	<type A> longest_variable_name;
> 	<type B> shorter_var_name;
> 	<type C> even_shorter;
> 	<type D> i;
> 
Done.

>> +
>> +	/*
>> +	 * Elfcorehdr_index_valid checked in crash_core:handle_hotplug_event()
> 
> Elfcorehdr_index_valid??
Comment reworked.


> 
>> +	 */
>> +	ksegment = &image->segment[image->elfcorehdr_index];
>> +	mem = ksegment->mem;
>> +	memsz = ksegment->memsz;
>> +
>> +	/*
>> +	 * Create the new elfcorehdr reflecting the changes to CPU and/or
>> +	 * memory resources.
>> +	 */
>> +	if (prepare_elf_headers(image, &elfbuf, &elfsz)) {
>> +		pr_err("crash hp: unable to prepare elfcore headers");
> 			^^^^^^^^
> 
> this thing is done with pr_fmt(). Grep the tree for examples.
Done, thanks for pointing that out.

> 
>> +		goto out;
>> +	}
> 
> The three lines above reading ksegment need to be here, where the test
> is done.
Done.

> 
>> +	if (elfsz > memsz) {
>> +		pr_err("crash hp: update elfcorehdr elfsz %lu > memsz %lu",
>> +			elfsz, memsz);
>> +		goto out;
>> +	}
>> +
>> +	/*
>> +	 * At this point, we are all but assured of success.
> 
> Who is "we"?
> 
Comment reworked.


Here is a copy of the current state of this code, for determining how to address the question above.

#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)

#undef pr_fmt
#define pr_fmt(fmt) "crash hp: " fmt

/*
  * NOTE: The addresses and sizes passed to this routine have
  * already been fully aligned on page boundaries. There is no
  * need for massaging the address or size.
  */
void *arch_map_crash_pages(unsigned long paddr, unsigned long size)
{
         if (size > 0)
                 return kmap_local_page(pfn_to_page(paddr >> PAGE_SHIFT));
         else
                 return NULL;
}

void arch_unmap_crash_pages(void *ptr)
{
         if (ptr)
                 kunmap_local(ptr);
}

/**
  * arch_crash_handle_hotplug_event() - Handle hotplug elfcorehdr changes
  * @image: the active struct kimage
  * @hp_action: the hot un/plug action being handled
  *
  * To accurately reflect hot un/plug changes, the new elfcorehdr
  * is prepared in a kernel buffer, and then it is written on top
  * of the existing/old elfcorehdr.
  */
void arch_crash_handle_hotplug_event(struct kimage *image,
                                     unsigned int hp_action)
{
         unsigned long mem, memsz;
         unsigned long elfsz = 0;
         void *elfbuf = NULL;
         void *ptr;

         /*
          * Create the new elfcorehdr reflecting the changes to CPU and/or
          * memory resources.
          */
         if (prepare_elf_headers(image, &elfbuf, &elfsz)) {
                 pr_err("unable to prepare elfcore headers");
                 goto out;
         }

         /*
          * Obtain address and size of the elfcorehdr segment, and
          * check it against the new elfcorehdr buffer.
          */
         mem = image->segment[image->elfcorehdr_index].mem;
         memsz = image->segment[image->elfcorehdr_index].memsz;
         if (elfsz > memsz) {
                 pr_err("update elfcorehdr elfsz %lu > memsz %lu",
                         elfsz, memsz);
                 goto out;
         }

         /*
          * Copy new elfcorehdr over the old elfcorehdr at destination.
          */
         ptr = arch_map_crash_pages(mem, memsz);
         if (ptr) {
                 /*
                  * Temporarily invalidate the crash image while the
                  * elfcorehdr is updated.
                  */
                 xchg(&kexec_crash_image, NULL);
                 memcpy_flushcache(ptr, elfbuf, elfsz);
                 xchg(&kexec_crash_image, image);
         }
         arch_unmap_crash_pages(ptr);
         pr_debug("re-loaded elfcorehdr at 0x%lx\n", mem);

out:
         if (elfbuf)
                 vfree(elfbuf);
}
#endif

