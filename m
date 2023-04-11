Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF78F6DD865
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 12:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjDKKzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 06:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjDKKzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 06:55:41 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2041.outbound.protection.outlook.com [40.107.212.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B981982;
        Tue, 11 Apr 2023 03:55:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nPj6q6IIQ6UPT5RetwctOgooecJg4WNJINEX7ngaRGjYk6lRraQ9b/fZktJtKwpk8p4EQ0tPtPB+ehltuMU3xkwcmyQPoHALrJQQi0MVbB1IH7U3/YmGoIMcAvnicwvIncLhNCk5Ck63m3TOejys85oZajoB9JTmBKhFwoOpUrUfayRGAaFQ37+V/61IaYHTz9Fi8kOquUuM/sHkm7sNwYxs4sztRzvdRqIp+bYgyq8PHDN1q4oewT4/CqpMs7QskxM3TNIfH/10HDV9EdQcyU7/JeFcudN7SedE+iN42Xz/3fng1AC6zvXdy8Q3zM2TxmDpa//3XT+8Wx2p2HkqCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NjOFOznQ3rG0aEuWG0MPZocc0W8Y9KDoilgT1qCS2JA=;
 b=aCgUo8aW/Z9m2p2TmiqYHH3Q+Og9ZnvRuKThMxfbziQTuwjHmIr+ztUBs0g9JTWv5eWD53A9suldzy1lxKyx47PCSq+FZUo0lucGvEvn7mfvcNO65zNTcRF3/E7OS4cCLJPgUmdAI2TtvKcleKUeHIHVfTgjBi+c3CJDhRdt0liI5iXMsZ/6192FnFSi9/MSmE6obKx8bM0zD6+f2YCtgrmUyLxW0NeVtQHqz/4l0o3SiFAHCYSJ5BQAebQWkv1KepZ+8hkP40Qn3TRNouYaP+SJLvAlAfTGdWXik2WVqR9MU/2DcXiPk1QbR3J0MFaEDIHkC2d+9J5rp5NBaP33XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NjOFOznQ3rG0aEuWG0MPZocc0W8Y9KDoilgT1qCS2JA=;
 b=P2e/YXUCXwv2aCzkvsh13mqkncKeCukJbO5EeOatjbm9zhnmxoR7OGMbJjoLV1QUnJEGUrYkN8yJDNLkoWAfQS5Fr71MKkceaSnAROZfMKVh+UjieX5tt6QaiDlgO4G5Z4X8N/M0Oam0g0k4XAfRbA4SmCLJUk6UH6lqIfHHeCs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by DS7PR12MB8419.namprd12.prod.outlook.com (2603:10b6:8:e9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Tue, 11 Apr
 2023 10:55:36 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::42cb:32d6:2502:4cbd]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::42cb:32d6:2502:4cbd%3]) with mapi id 15.20.6277.034; Tue, 11 Apr 2023
 10:55:36 +0000
Message-ID: <0b54618f-ce15-575a-9571-f746e8bc40e2@amd.com>
Date:   Tue, 11 Apr 2023 16:25:23 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 2/2] x86/Documentation: Add documentation about cluster
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        corbet@lwn.net, jgross@suse.com, andrew.cooper3@citrix.com,
        Jason@zx2c4.com, thomas.lendacky@amd.com, puwen@hygon.cn,
        x86@kernel.org, linux-doc@vger.kernel.org
References: <20230410163527.1626-1-kprateek.nayak@amd.com>
 <20230410163527.1626-3-kprateek.nayak@amd.com>
 <20230411082538.GA578657@hirez.programming.kicks-ass.net>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20230411082538.GA578657@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0116.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::31) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|DS7PR12MB8419:EE_
X-MS-Office365-Filtering-Correlation-Id: ab327c23-bbc6-48b6-30b7-08db3a7b47dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pxU5Kq9Xf0fIv2tsbJUoxmxs3bOmcdArJfpPpdEbgnu85WKS0okKutc6FsTzPTiHxJIfwUzq/5vweKutJ9fwNiy+mn5mP+oPdWLDFCb1Vu5l94mge8wCH66IFUiysZ8+WDa02mtsdr6ojKaDRhjxOpIgAgzVMTBykVCQEhEw4/EYOhsOCbhgXXdVDjhapLetKnahAHL2oWuIRV09+n7OVYRe5kLOD2gjxkOGJ9zpRVQww2Oe+vgg4y0lj/ujz2Ihmc3uzkukEL42gkSeW9xULkHITuGhxaQS3C0TJYxiifWjKDAYbnYPJB4Puij6e/I9gD2E0ojOKLASHQ7wLhUbz1SNqGopPk0INF090dmlAHokLbGY0S8wvAjT1PYoejsfvdTXtCN+mA1wI6A1kCS72xzxdUXnG9Td735z2rDSux4RQzd7hvwNQ494DaFlHxVTsf1BJvuyiqtN1ezl7XtV2NwxX0Y007+lYeDMLT2/1jUE9F1XWXuT/CjLc8snCfpxDrIUm534eIBy4Jjggl+mvsfrPatSft9hSryuNOo6TOtrffseSEt+UwU3dhwqteqb3F3tQpcXZ+i7tTiOQNcBzrKteyQwEl0vT6blHFpm5nrdWjB/aFqcSB/Ioz8ZcJkLDl8tDH5Vkw2ijTH+O3lO4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(39860400002)(136003)(346002)(451199021)(8936002)(6666004)(7416002)(6486002)(5660300002)(6916009)(86362001)(31696002)(4326008)(8676002)(66556008)(66476007)(66946007)(478600001)(38100700002)(31686004)(316002)(53546011)(2906002)(6506007)(6512007)(186003)(2616005)(41300700001)(36756003)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkpUbENsbm9WemlWS2ZtdFFXMFdpLzVNQitsVllmRGVrK2plZDJOMmgrNjVM?=
 =?utf-8?B?NzZCVFA0OVpTMnJxSXlibUIzSnBzL3pkN1kvejM5VVc1M0pVMUxTK3VTZGgr?=
 =?utf-8?B?UEJVazMyaE1TZ3lIa1dSRG5FN1R2aE4rUUNteU8xeWFMb0R2citIZXJaeHJx?=
 =?utf-8?B?bWs2cElNMjhJcWVIcG1mK1VCU3N2T2FDbXVyTmV5QjJjdG9wTjRkNm1NWFpY?=
 =?utf-8?B?Uk4zMHlRWkpzcTBuS0ZqZCtjQnJnUk1HSmF1ODEvdWN2ajBKWHdLcGtKQlUw?=
 =?utf-8?B?RGw2Ri9wWjlSemhMSFEvRHFOa0pzdytXVEFSNEJMTDQ5RVhNNktabU52L3dP?=
 =?utf-8?B?T05wdWhJVThNYktXYVZJczd6eFAwZktnaDIwSEdjZVBoQTZNelNpNk85NGYr?=
 =?utf-8?B?clNXTU52MHlUTzJRcmJhYTMvWFo1MjZIL2QwcmxJVUNmK1ptcjVhL0JuTmxw?=
 =?utf-8?B?UFBBRUNKTXhFcVZ5YVBSc214WnBYVDlTOHozVmRjOEI4eWZmSUtnWHE2RlBC?=
 =?utf-8?B?WWNZcktHM0ZqSDk5RUxzU2hOUEpCSnFHalBCTEI5Zmc1dTRzdStsNVQ2dGlp?=
 =?utf-8?B?KzBCZ1R4UTdqRU5sRGhqdlZLUHpJYlhGcEgvbi8wNU9VM2FNL2ZEWXYyUEZQ?=
 =?utf-8?B?VWpCUkRyd2xpV0V0SzdlbVRRMkRlZlZFb0FySlZibUhWTkw0eHBtOG5KVG1q?=
 =?utf-8?B?dzZDenJ4SDdTMUVSQmpCeXppekR4WWZuSTMzR1Y3RDArRTJGNXF1SFdHV0pt?=
 =?utf-8?B?ODhoMXVXS3FNbStDU3VWbHVNdTQrWHpFSjFMNzJUSDFVNlFrUHhqNUQxcmk2?=
 =?utf-8?B?Q21kdHlKSVR3MG9QTHZMZEJhcTFQL0psWGZKR0lCb1VMcERKTnYxT011SEhF?=
 =?utf-8?B?RHVtQ05lbmVsQmQ1eVd5RCtma3MyZUhJdk5YSEVQWDFQWFkzdDJNQWVCU3FB?=
 =?utf-8?B?ZS95M0d2MTJ5K1AwTWdPZVNoQWR0VjdFTFNEWmZka0d4UmZHcitQd0FzdW5Y?=
 =?utf-8?B?M21GeWZaTFV0NmRRTVRubEhCQlMrR1JibzREY09pZ2M3Y0h0R1dSUGdjeHJ5?=
 =?utf-8?B?ellLRkhoZTVyYSs3ZkpmTHRZTmtOdDhOUGNDQm54elYxZlV0eXdwZGI2RkY1?=
 =?utf-8?B?TFhONUdMdHVtQ2xCRDZ2a2pJNUlMNFRXSm1pYmc1TTBqNWNrVlV6NXhWMk0r?=
 =?utf-8?B?RXR0SHcrNHllQUo4dm01aE8wcUZhUnlDVVNvSkhvK3RzMlNqbFFwaEZtZnhh?=
 =?utf-8?B?NXo4R2hNalNiLzR4Slhjak9RSTlPeDgrV1I0bUozV0VCa0JtTG9tbVdPRm5w?=
 =?utf-8?B?WnlOYjJReE5jaHFqeFptTFVpUnZNSWhNekc0TEJXa3RiZEp4S1Q0VzVLWURS?=
 =?utf-8?B?KzAvUllwcFF6ZXNzdytZcnkxZVpLU0J4alhUVG92UGl4c1pCNXFGWTdSNzJm?=
 =?utf-8?B?R0RCdVRHTHpKUFpXa0lUVDJQWHJ6Yjd6bzR2QmNNbmxHNWtnUTZYdm1ORHBv?=
 =?utf-8?B?RlJXL0JLbTRCTXI3U2lKZjROY2k0bEFBUHVvK2cycmtiU0lOSWpWTUJDK2s3?=
 =?utf-8?B?YW5FazI2cG1oYjYyWnNDVVV1a3hONXRMN1oxdWIzRHhHOXpiY2VuWlVjaGlm?=
 =?utf-8?B?OE5teVF5RWVqMHp6amNXMnRTcEFhb3dCOFFkR1lOOXgzcDdjREhsUUtkM1hw?=
 =?utf-8?B?a1ZPNmlrbGRZNkNhZFF2NWRydGNUQll3alBKL3o5RDRYQ3FPcFRNTTZMNHl6?=
 =?utf-8?B?L3Zoc1RLbDB6eU9sakhVbG9xWEVqYTAxRkIrV0hYV3JqSGYxR2dpWGwwZlFm?=
 =?utf-8?B?OVpsUmRZK2NOWUtBZnFMdEQ0SFNkUVJ4azRoZ0hLRGVUNlZHT25pQm5Lc2JM?=
 =?utf-8?B?bDloRUR1YWtkSFZ3d0N0SkE4S0I0QnBqL2pEaDFNdUFqaHFNYS9XZklVUmhB?=
 =?utf-8?B?SUZFUUpHVFNzelkvYUpTQ0xVVVdBT0o1aUtadWNvN0xaWGpZVlNVWUFwcjJV?=
 =?utf-8?B?M24wa2Z5MElSQ1ZMUzJnVEhqVXYwOFZpUHdlYkxhWDRmNlhsUmZVUGJib0pP?=
 =?utf-8?B?RnNJcEtzMUlXZnc2d3FDZ0wwNktFTlk2aEZPWEFmV1ZhVzdjNUt0Z2hDTjdi?=
 =?utf-8?Q?lRhQZJ5Rq320Kha0R4knCyABb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab327c23-bbc6-48b6-30b7-08db3a7b47dc
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 10:55:36.6826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 39xx9UMdYJEthPgY8slrHSFdqyYCsmnV2Q4meXssmEv+pVvoT4AEqYerlrnvQn3OfgIVPswlZgEnjMkzPukj/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8419
X-Spam-Status: No, score=-1.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Peter,

Thank you for reviewing the patches.

On 4/11/2023 1:55 PM, Peter Zijlstra wrote:
> On Mon, Apr 10, 2023 at 10:05:27PM +0530, K Prateek Nayak wrote:
>> x86 processors map cluster to the L2 cache. Add documentation stating
>> the same, and provide more information on the values and API related to
>> CPU clusters exposed by the kernel.
>>
>> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
>> ---
>>  Documentation/x86/topology.rst | 31 +++++++++++++++++++++++++++++++
>>  1 file changed, 31 insertions(+)
>>
>> diff --git a/Documentation/x86/topology.rst b/Documentation/x86/topology.rst
>> index 7f58010ea86a..35991d8cdef1 100644
>> --- a/Documentation/x86/topology.rst
>> +++ b/Documentation/x86/topology.rst
>> @@ -33,6 +33,7 @@ historical nature and should be cleaned up.
>>  The topology of a system is described in the units of:
>>  
>>      - packages
>> +    - cluster
>>      - cores
>>      - threads
>>  
>> @@ -90,6 +91,27 @@ Package-related topology information in the kernel:
>>          Cache. In general, it is a number identifying an LLC uniquely on the
>>          system.
>>  
>> +
>> +Clusters
>> +========
>> +A cluster consists of 1 or more threads. It does not matter whether the threads
>> +are SMT- or CMT-type threads. All the threads of a cluster share the same L2
>> +cache.
> 
> I'm not quite sure that's a correct discription of what a cluster is.
> 
> Yes, SMT will fundamentally share core-level caches (and should we not
> always have SMT share all cache topoligies?)

I can reword the cluster description as follows:

"A cluster consists of threads of one or more cores sharing the same
L2 cache."

> 
> But there is also x86 where L2 is shared between multiple cores -- while
> the above seems to suggest L2 is single core only.

I hope the above rewording solves this confusion. Let me know otherwise.
--
Thanks and Regards,
Prateek
