Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C406F58CA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 15:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjECNPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 09:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjECNPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 09:15:36 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C60510E5;
        Wed,  3 May 2023 06:15:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H0LLqvVVHyO8S9Apy1eALWBe5ahQlMVlpuuZch59cZauIO6kjBu9Xcyvhnw0QEgS73mNT9usxI18eGA0vdVJnfQy1zBZ8DzMv7KP0YUz7C8XN1mWPDAJQwOn2P/9ikZAPd3lDAKEuRs0aw373EXFmX14mwNnWRzzpQq+dl7bZy0+E9cANWvmIM7sQC4WhhNPd9HL2bFLw3fbGwpx9Ecys/yb2vcT/fFQ6U5ap7wQtHDvSl1Mkm1dqtMmEdc2BnzMNJ1A1c+f9zUthDGgaH9j2B+Lk4d/4G2qRAD3S9lxRwcP8MxEDXqd7rbCGHsjLgSukb/z1X7D47Xkoyy4dggMQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nC4Cbej6pbFznv402wyFLm9XQIHOs1Mga0Kj7B70sPY=;
 b=h8IzDAhjKKTPClxpkAib4EwIce0wdEKnHk2tEcHpDBLTcLsIAfYboAlAtXWfyfZnUoV4PBuahf9quxqPdEW9NKm/sorKDhoH5kMnSvtoRLlQDotuEHQzonNF1yWRdjR02VIF0s8SOvbDwk3Y+iPRVQEfXIkU0fW4+oUvB+e+GV4IxEUI0ujoFdUwoZlIDd/kcvLZJPQNiNmBtKjolXgG/EiWMxlFKaUolSdiofis3A+uwWfthja9168QNqqYOt07OHaF43BbVCyv++GM0TuTv1uohueeiGNrdY7WaFw1AZRP3LPFbMZbENAgcBazs/aLuictzjXgLzhooWM3QVX3Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nC4Cbej6pbFznv402wyFLm9XQIHOs1Mga0Kj7B70sPY=;
 b=VBEO8c+DQ0IT72c/8izDUXJtQGZINyf/OxYQyc4ptpaaTzXuwEmrt1/D8ltjBGAnlQc/Izr9qNwSvFLpuRtFF8eprLIjaoRlzs51H88gGrwxqfxAXAMdkp5bqEQ9jx85QZ6aB7oLbgxE+pO9kouHs8a/ZA2CzMVH9k/llhdRDzY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by IA0PR12MB7676.namprd12.prod.outlook.com (2603:10b6:208:432::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Wed, 3 May
 2023 13:15:32 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::fcfe:62dd:e938:3a84]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::fcfe:62dd:e938:3a84%7]) with mapi id 15.20.6340.031; Wed, 3 May 2023
 13:15:32 +0000
Message-ID: <8e1a3ff0-937e-fcd8-bc8c-802fb79c8017@amd.com>
Date:   Wed, 3 May 2023 08:15:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] docs/sp_SP: Add translation of process/adding-syscalls
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        mauriciofb@gmail.com
References: <20230315143526.1213813-1-carlos.bilbao@amd.com>
 <fc88992d-dfda-0265-5199-d6cae3ba3260@amd.com> <87ilda7iy0.fsf@meer.lwn.net>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <87ilda7iy0.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0229.namprd03.prod.outlook.com
 (2603:10b6:610:e7::24) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|IA0PR12MB7676:EE_
X-MS-Office365-Filtering-Correlation-Id: ea314ac4-d2b9-4195-f8c4-08db4bd878ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6waF6nmoAeSS4Zq46atNoyIJWnIzwA6+jW+miJS/n9fbwhBLFvdT+hgQoMbr6rHUmMsDHe8pZMGamzzbCSR+Kk+10c1+ADzCj2YQorDehCh65x1re2/fYg7ypj0f5r5XF8d7MCgUzwgbnFHQN/oSqT09R+Z2PLb5JGZHC9vugL5PXoFWWzjjUgmKO2G4kpsV0E1p0+/wKSFMIt1CggsOlm7utgUVBQR1ht5PkjJs3L6ywftpPkmsywdD79e/lap7tNjDM3QlMfBQEDzDwm4lktsAmGPIsBVeIABALGvqgLOJy9JPjB95IYw9VMQaijpLWy8moqyWFitGk/ZDlT7NW7AfBqZ9sPV5VrGbEJaYs429DGjLUnYLMvnkddhUoBA5OTdkb59u9GMdLlIpuVGqXT3D2cf+iGFtBBspw/RZBf2R7k4At/I4e/cinllcE3sMUNLZnqklDlYNO9vgI2Vapaj2sQ+ADjFZb7LQ1VdJMGKGsAw29tQrot48MgWwFPMamILVVeeLVpzwbnBc0T6bI8b+p1rg6i9g6PTw+166xHGMPqw2PBQkaWBWm2RrEySRJj0RTFmh36bSdJdn8ePBooXv31oI//hq5lHbH0iz1SUyBfbBBTYNUXTBVj7X4k8MO8//8Gkd84Y/+QbuDq7p3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(451199021)(2906002)(38100700002)(83380400001)(2616005)(26005)(6506007)(6512007)(53546011)(186003)(36756003)(8676002)(8936002)(5660300002)(44832011)(66476007)(86362001)(31696002)(478600001)(316002)(6486002)(4326008)(6916009)(6666004)(41300700001)(66946007)(66556008)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkdaUVNQSjlKSkJBa0NMTWFmZXliNUY5QmxrSGZGcnNHVVQ5ZG5yczFWKzN6?=
 =?utf-8?B?NzZ6VXo4ZUlwR1RvT21vUEhVS2o0cFkzUkwrbERXaFlDeWkwWU5IT2lkZTgw?=
 =?utf-8?B?dTNhTElGT3ZneDcrdWFWZnlHemsvYnNaQTFSVXNxQ1VLRmVQYU4zQkplMXZM?=
 =?utf-8?B?U3E2ZnhxSVgzZ0ZLYlk0R0RIL1ZyYmRUQUpEUHJudStFdUxXWHBXV2dXV1Az?=
 =?utf-8?B?bzdqTi85WGhaa2txUDNxaXFKWUoxSDJJK3BYZklzc095MTlDRzY1VThLL2tC?=
 =?utf-8?B?WmlLVHZTKy9mRlRrNWwvaVRpcGwzKzVLUXBZc2ZvbTArbHZwVVhtQXYwU0cw?=
 =?utf-8?B?RDc5RUpSa3FzWDJYTGZSMTYxZWFiY2k4M0lqbm9ua0cvV0ZMUHluZ2dUYkxw?=
 =?utf-8?B?SFBSaS9EWEpleWs3dzF2bEdsbG95Z0FwbUdMaXJwRHFuSWJQUzlQVzBkV2Nq?=
 =?utf-8?B?SGl2ZVZqVTdZUmhJYVllaWNNRmk5RGtjMkppUzB4aXlWdHJHUVpaaUJQOWdy?=
 =?utf-8?B?bSsvaEcxZ3BuRDJoemRad2pCNXVNUkhPUStNL1M3ZnQzenZ3TE1uaVNicjBE?=
 =?utf-8?B?cjdKZnYycHJvNWk5c043NUZhTit0aDkra2RSSkI5N1pKaGFibmU0UDQ1alps?=
 =?utf-8?B?Vis5T0o0N0dhR1VndVlqckw2ZmQ1RmpvZjc4Undjb0cxekFUQUNwdmpkK3JN?=
 =?utf-8?B?N2hoM0lNcUhISXRrRFVMY1VkamNJcVBnQ3FMd242VjJiQnlxL2VjaUtQc1ZN?=
 =?utf-8?B?R0pNckdsVCtpM2lmc3M3Q0czMXJHYkhDeHN4WldrbXc0NmhuRUZLaE0xQkRx?=
 =?utf-8?B?UGZTQk56UmJZZHgxd3dMQ29Ed3lUVFZOZEUrRWZOZ2NYUkdoK0J5OVFaMjVN?=
 =?utf-8?B?WXc0UUYycFF4NmR6bG95eWNTcDBVaHcvb1oyOHJtQy9NajhOZE9ma3JGVFJJ?=
 =?utf-8?B?cU8wbVRkZWVRaE56TUFqMFZ6aHcwbGlhODBjb2g2eXBhUEJZNGV6Y1V0STZB?=
 =?utf-8?B?dmpnOTFYb1NaK05Hc3h0WkNtNUx3ZGZUMlFPMFZZT0diQVJ0RnJ3ZTNiclZC?=
 =?utf-8?B?M1ZrUWJrU1Y2czhGYW1BcXVJK2RpakYvRTJHaGE0OXRpK1o3Tlp1V2pCemdW?=
 =?utf-8?B?SWZIaFI5aFhSY1dCcDB1WjlVK3lqaXpTR01DeTlRS0NlWnlPWFpVRkpiRXhL?=
 =?utf-8?B?YS9UR1NkamwwNjVQWW5Ma2E5ZmhYMFA4Y3E0b2w4Ri95UGZObkZlYXl4Zk80?=
 =?utf-8?B?Wk1CdDhLMXBIL09yWExnNzFLb0RVTWpPL3R1SDNPbXdLWVo2Y0tnVTkvOHRP?=
 =?utf-8?B?STJuRDUvQjlSTFczeUw2bXRIdzlqRUg1elZWd3hST1JPTHpDS0ROenRGUERO?=
 =?utf-8?B?Y0lsejliMm9KVGtEbDBpZ1NKNmtWcFlFRWNqZ0xwRzczQzQ2TU9aRERMUmFj?=
 =?utf-8?B?bEpwZi9EVFE0bFdCNVFFN1A3S0FFQ0ovM0dDcDBJam55bm1rVy9vV2JWZVhR?=
 =?utf-8?B?aTk4a3RrSk9YOFVTZnBzVmN4dnhWUm9meVVtRzFueFFKY3NqdTJuWXorTHdT?=
 =?utf-8?B?ZHpaRFJBWnh0VmEydHpoV3dpVkVrc0k2OFBSVVRHTmZrcGZNNkZreFZzbjNj?=
 =?utf-8?B?eStUMEQzL1E3VnEwVjcvV0dGTG9JOGE4R1lNMlBhUnQ2aHhoSUJZZXJFYmNu?=
 =?utf-8?B?VEZ3ZUl6MlhZczZQTlZsazlVRS9tNWcyMHdITWs2MWRlNUtjMXNkUTlWZEls?=
 =?utf-8?B?bm44cGF1UjFnRXc4b1hhdGUvcWR0MjQxZ2FCaU8wamRrWUNUQ0hUSktuYm1q?=
 =?utf-8?B?R3l4Znl6anpYZ3lhRTdnYlo1MmY5YXhBU2U0Smpkd081OTRxZlN3dWRlRnR3?=
 =?utf-8?B?eTlqckl3RWYrMWE4S05DSGhja3VmNHozdTgrc25NYWpIZTNKKzU4RVdlUU1Z?=
 =?utf-8?B?ZjZRSHdaWnJBSmxpNjYxWk9xV083OHgxMkhRdmhlRlBWdHNPRmlWTDd4TU54?=
 =?utf-8?B?T3JHSDdHR01pTkhZZFpVdzhBc2NVVEgxZGNnTEFTNFNod3VQNEJVSWJXUUJ6?=
 =?utf-8?B?eExLeHFnRDJwbFV3amdkVnFENGJkNUNSZzNHWTBIYktMeVZoanBaZHlzVHFp?=
 =?utf-8?Q?cq48H5Hc4c8XnQIdj/bi4onDj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea314ac4-d2b9-4195-f8c4-08db4bd878ff
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 13:15:32.4051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vy2TjppceNMdc0Al6J5O8O5newu9GgaHZAnjneC1elFlJLEHVHXDJzBHpTaJKMdh/hF7mh23uzFVQGqcQPhvsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7676
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/2/23 12:16, Jonathan Corbet wrote:
> Carlos Bilbao <carlos.bilbao@amd.com> writes:
> 
>> Hello Jon,
>>
>> I applied on top of my most recent docs-next version:
>>
>> 0b656310bfc33c5e044df9cf6013df8280ec69cc ("docs/admin-guide/mm/ksm.rst fix
>> intraface -> interface typo")
>>
>> and it worked, and make htmldocs too. Could you please tell me what errors
>> or warnings are you experiencing?
> 
> How did you try to apply it?  I get the dreaded:
> 
>    Applying: docs/sp_SP: Add translation of process/adding-syscalls
>    error: patch failed: Documentation/translations/sp_SP/process/index.rst:18
>    error: Documentation/translations/sp_SP/process/index.rst: patch does not apply
>    Patch failed at 0001 docs/sp_SP: Add translation of process/adding-syscalls
> 
> The problem was this hunk:
> 
> diff --git a/Documentation/translations/sp_SP/process/index.rst
> b/Documentation/translations/sp_SP/process/index.rst
> index 351bcd3921ba..a0ff2e132c54 100644
> --- a/Documentation/translations/sp_SP/process/index.rst
> +++ b/Documentation/translations/sp_SP/process/index.rst
> @@ -18,3 +18,4 @@
>      email-clients
>      programming-language
>      deprecated
> +   adding-syscalls
> 
> I have your addition of magic-number.rst applied, you seemingly did not
> when the patch was generated.
> 
> Figuring these things out takes time.  Next time something like this
> happens, can you just regenerate the patch against the current tree and
> resend?

I definitely will, thank you Jon.

> 
> Anyway, I've applied it.
> 
> Thanks,
> 
> jon

Best,
Carlos
