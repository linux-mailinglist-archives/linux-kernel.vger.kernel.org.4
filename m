Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4027463F94B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 21:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiLAUk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 15:40:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiLAUki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 15:40:38 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2058.outbound.protection.outlook.com [40.107.101.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52B7C055B;
        Thu,  1 Dec 2022 12:40:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GbmEbEUfVLX8dueJVPzxY+aPBpiqvX7IClxrLQHSk7gFqnPtCvaBSB8bJUKVyYN8LeZEoeDMnXZHu6ODG1ouFMOp3kSBanX7GRMiKQYZn+fCNL4iZTkwgrEl62gUONZTac0Tt3EaON47KUiwPt1PfiZkT7FKpjxpt3xnz9X7U3u0ouJZKGgnXTQ+rTEyb+hdqF2yxfeOC/DMFZ7dOLiJephviBBKhmiqi1HvCIMYF5qiEJ4iZWTe7EbgHK4PMw5Mctymglr+/Or9CVUjVB/mKRRXYOxbTTdnXSZ/MwLqRoDtUPnyWinuR+WqPTobIR/9ZwVKt0EmuaISgxmNLxf67Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q7iVEDabZQXhnqFwqWLhKJF97cGFqwAp3rxvkSegEpM=;
 b=npS+N3K8WiY8OBWYECAzdLJ+/I41QsqzJxGki3CKtCRGZnugrOuiPPqQpF0kfoy2SjwCpt4vvhcgtPNdNkblaERFKGRcwCD0t8jmPW41bWR15LbpGm9n7pYvHbysxfNsILZbbJvfCMZnm93LDQV5dAxQHUwzICxX1BQnrx1b0kmR5ql4SqmVdbL2qvuBbEKR9lLVTJirN/m0vc+aXJseYsgAenyX5akDxHPJttSb5f7ZoCtd8z7iOf+50VFUq877fX3jQTTjJaoM9Qx10btOUsD72gpb5eP/NUtYZta7ym9cu9YblSwtBt52nfLT0qBdUccrQ4hz5a0fjLN7vXieUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7iVEDabZQXhnqFwqWLhKJF97cGFqwAp3rxvkSegEpM=;
 b=ADMBZg46LOQzRUh/e72IsgtIuzD3co5Np4KM962bVvm/QC7dRvr8xfPja0rf2n7A3yHLVKDwdNQHxVE8DoZlwUR2DnKi28ItsIxYJrCUrP4uuwkfR7yrd+4NlHHEZsjKqTXkpwjBXG6iERyKPcyAOPZPM6vqqecljklosnMtjZs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by BL1PR12MB5780.namprd12.prod.outlook.com (2603:10b6:208:393::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Thu, 1 Dec
 2022 20:40:36 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::45b1:34fb:e14d:96e4]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::45b1:34fb:e14d:96e4%4]) with mapi id 15.20.5880.008; Thu, 1 Dec 2022
 20:40:35 +0000
Message-ID: <15942593-5ec7-77a6-8637-61ca495d7528@amd.com>
Date:   Thu, 1 Dec 2022 14:40:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] docs: Integrate rustdoc into Rust documentation
Content-Language: en-US
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     corbet@lwn.net, ojeda@kernel.org, bilbao@vt.edu,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        konstantin@linuxfoundation.org, Akira Yokosawa <akiyks@gmail.com>
References: <20221130220825.1545758-1-carlos.bilbao@amd.com>
 <CANiq72nMY5f85tJJFg7AFsh4YRrKObhurhT8TVawYqoZU+J-Fg@mail.gmail.com>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <CANiq72nMY5f85tJJFg7AFsh4YRrKObhurhT8TVawYqoZU+J-Fg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P223CA0029.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::11) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|BL1PR12MB5780:EE_
X-MS-Office365-Filtering-Correlation-Id: f35ab46e-fcf3-42a8-fdb3-08dad3dc4c76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yXFwFK8bu15X2LPRUwmhDZlu3c/VYl8t9GXAF+QESgjR33B1fu+b9OkMsO9AmTMucyO3CfAoG1M8UJbUCJzFqsRe0HZm1Eyw21euXZACSiaLWvlrlygfiI7TDvk8bR2sx48rMJUstJJHHqrhyVAbfJGF4AZjGz7NWlnpUJL7tXlwfNc1n3sEX4nZzJlBVb8raBJDiyHiC/NErHHugwHBowQMGiiLi3WiDjd8hSdqShls5sebV9ZeWHgfPyj/arBDIAQNKX6OCMBOcKCZoAFbUhCxJj9yQnByVl6U2xC2wANB6dw7wuTGXmdf1vTXgIT1zBXMCtZeQS8qb8ZD+FR90qRpI6LtT26au5b5nd3rAUBm4aZD04EsOXQHB1l550XFZyELiw6RpAYwDRS0oiSrl2o4B9rD5mS5kjMKbviNxs7ZVyfyIvA8tapwoEj7BgDoFpKcpQhkvyt7Th5jRsw9ATE8S8N2gEETY2aMJZYYuZ8j3ZLCIHly+rrbPFN3fwThaGmf3GopzxNTxzXa5U5Vk1+AmBSZcsr5l/3S+BpXIPC0LuyCrkWd7C1i/ib/g188NUeja9qTrY+flNaVmiY4aZmsRo1IPysnu+/fCbxulPV9XmQPr0CTuIbfoWpM3mpLxdji9sNq8x1OEraBIKnm35N7ZS4KGXe90CGgdxhXoqYkaXXIsFeKoKEa3UlpkpClnFFnTjXxI6gxAoOkcOTuIOny3+Alrp4YcP/Po3GJhYQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(39860400002)(366004)(396003)(451199015)(36756003)(316002)(83380400001)(6916009)(5660300002)(44832011)(8936002)(2906002)(66556008)(41300700001)(66476007)(4326008)(66946007)(8676002)(38100700002)(31686004)(478600001)(53546011)(31696002)(6486002)(86362001)(2616005)(186003)(6512007)(6506007)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTUyVnp2WlJOcTRab2ZxWGU2Vm9HajEya0NNTEdhQnViaTRzQjNCS3EwU2p5?=
 =?utf-8?B?WnRzd0IzVTRkYTZjU1MvcVp5Zm4yK1hUcVhiQXZNblFKTFRIWStlNGFaZ2li?=
 =?utf-8?B?YUxHdDJicHJiMVFYVFl3cHA2QWE2a250NllEcE5QQjQwRC81c0xZdEdrdXZH?=
 =?utf-8?B?ajQ3QzdmU09FMEpTcyt4MkRkVUYvNzJWUlRaaXBFWXJXSzdJRUFENFczanNI?=
 =?utf-8?B?VTY2ZENidGhPUGFkTkIrWURFZ1RrRXptb2JySXMxTnZoNG5JQW5DZXg1eTB1?=
 =?utf-8?B?bjJ3TDBoNWFJTy9VYzEzdWhETmhWa1p6U1UzUzVhWjRsdWMwMCswNEdQU3ha?=
 =?utf-8?B?SmJUdVU2azBPTFo0UTFhTUgweGllMzE3VzVBNDF3YmJCa1hIWm9mb04yTWta?=
 =?utf-8?B?QjRHNCtBNlJac1pwcTdvdjIvWXlhQ1hCRVUxRC84NTZQQ2J2cXJpTkdjaG9V?=
 =?utf-8?B?WXQrMngzNHNjUU1TQVlNckdkcnA3SUl2UVNidTNuSjM0SUtZZUJDRUxvR0pE?=
 =?utf-8?B?TGpaM0FQWFF3SmZWR1lBaHJEZ2picCtFY2pJWU5TeHl4ZFVwSzlpamJsVDhj?=
 =?utf-8?B?RXkvNUNlSE9sZVRrYXpvbGMwOVVUWWltamI2MFlSN3E5WUQ2ZXM1TjMydWtN?=
 =?utf-8?B?TzlKMHgzd3dlakRsVlExc0hPLzdNZ3kvaGgrUUdTSTR6T2tUVlZwTURrU1lH?=
 =?utf-8?B?NG91QitlbFN6ZTVBdTFldXpyYjI2K1d5dnp1OCtCcjlCOU81dmxJa2s5R1RP?=
 =?utf-8?B?c3NqUEFhaWNqSi9CZVhvVzV5dUdyeHF6aUNEdVE2UmN2bDdVaUdKenROeWNM?=
 =?utf-8?B?aWZzaWhUR2dodnF6bytTMStraHZ1eGt0ZUNJbHBUUEx1c3M1a2drcXBaM1dP?=
 =?utf-8?B?N0ttYWtKamNvQ1llZWZCZjZWVEtQSEZ3bTg3YldmV3hQL2VrRmRGUUNBOUkv?=
 =?utf-8?B?WU1ZYkJjSTdFUlFDTU14dmdIQTJwUFZZMVVFeUtJUWh5d0hWeG1VVFRFcHpp?=
 =?utf-8?B?UTEvVkdaUnFucFhFWWorV3lDOWVTZTBMbkUxL1ZpWi9hNzV1UFZsK0JrVWVL?=
 =?utf-8?B?OGw4R2ZRQyttMDI5K3AwUUl4OHlMbVZ2M28vRE5XYVVEOExCNS9MOXVSbUVE?=
 =?utf-8?B?U0NESlFxdmVvUHUwYU5NUGZhQTI1a0FZL1RZOHBGcVZYeWg4Y1dKNzJPWEZ4?=
 =?utf-8?B?UUwrODczVnp6NUUrejVHM0hvd0xGZTBkTmRiSkprLzJlQjFNVDBBK0JuV1px?=
 =?utf-8?B?TVlMbEUwcUVvWE94VE1RcHY2azlsNEpVWVd5cmFiRTBCWnA3cTFEZWFKdWhI?=
 =?utf-8?B?ZzI1ekpuM3orQkF1N2tlZmFodis4TDczNjRjSytjdzlGejdCdG9XNFlLZ1Fx?=
 =?utf-8?B?a0pLMFI4N2c4VjlSTSs4eHJ6eFRmTnhmMHhMUzFQRmgvdWhLb2pFVjM4Wm4y?=
 =?utf-8?B?SVZMWEIvK0h1cmtrQWEzdEdKS2Q1RHg4bW8yU0lHUnk2VTRDaCtIN1ZOWEs0?=
 =?utf-8?B?RjdWcUxaYkRJV1hobk1rVzg1OUU5dGMramtCS0lsbDhMbDlJUXp5WHlSUy9O?=
 =?utf-8?B?dGI4ajRYNWlQMmlTR0dkSm5GUjBVT3NaWWF0QWV1dW9aN3ozdVZyL3VKa1lV?=
 =?utf-8?B?R0gyZU81ZXREWU1rZzhqTzU4UTMzemlhZGUyZXAyVzJ4YjQ2YmdodDNFWSt2?=
 =?utf-8?B?Z1NzYzYwWTAvMWFmOTRXbDlHUkkvUHI3VmZGVThOZ2hwbmZ2SHY4WEZBS1FG?=
 =?utf-8?B?R3hLb2FkSkU1eUNGV2JHYzJwT3ZXTXNvZCs5enBKcTR4N24xaVJtNFFhLy9U?=
 =?utf-8?B?dTBLbFNzSHJ5eCtpMTE1eTlBeVZFc2cwK3o0S3VwbCt3RXJrT1V5cmlKdzEw?=
 =?utf-8?B?Yy9OMU1pc3RlQnd4VXVUUUFhMW4wYm9HQ2tXdWVCNEtFYkpadFZENzlpUXRD?=
 =?utf-8?B?RWcrZ2xFQVU0eUFCemFkc2l1SzlrVzJUSW5QTk5LS1ArYmVjbkRkMHE3eW5a?=
 =?utf-8?B?TUkxTG84NWNRZ0E2U0d5UmY4TDhoUVlpWFhwVHAvQm1BRGFERWNUem5Ob3dU?=
 =?utf-8?B?RlNpTWp3TDZpaGdLSEtySVpqWXo0c29raXFUZnJzYzhsY3dnSjlLd3o5WW5X?=
 =?utf-8?Q?K7GHLWI3nGJI1q7oqxlYfsU6h?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f35ab46e-fcf3-42a8-fdb3-08dad3dc4c76
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 20:40:35.6884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ec5W+ECTeSjsFG+x1l8RXfuam04ZGZgNnNH3/+IIIO/TgTv5o9tBbVO+t5h0BC+mxC8uhuPAlwxfs/oMkrqzwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5780
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/22 06:42, Miguel Ojeda wrote:

> On Wed, Nov 30, 2022 at 11:08 PM Carlos Bilbao <carlos.bilbao@amd.com> wrote:
>
>> +ifdef CONFIG_RUST
>> +       @make LLVM=1 rustdoc
>> +endif
> The Rust docs should probably be built with the build
> system/config/... as given, whether it is GCC, LLVM, etc. This should
> probably use `$(MAKE)` too; and if you intended to remove the command
> line definitions, `MAKEOVERRIDES` too.


Sounds good.


> By the way, while checking this, I noticed we use some `CONFIG_`s in
> this `Makefile`, but we do not perform a config sync for the `*docs`
> targets, so one needs to do so manually, i.e. it can be a pitfall for
> e.g. `CONFIG_WARN_MISSING_DOCUMENTS` and ` as well as a potential
> `CONFIG_RUST`. Should this be fixed orthogonally, or is it intended?
> (some targets do not need the sync, and the ones that need are
> probably less used, so I guess that could be the reason?).


I don't understand config sync. Perhaps that, e.g. Documentation/Makefile
checks for broken docs, for CONFIG_WARN_MISSING_DOCUMENTS, but we don't
do that for rust/Makefile? I'm not sure, but it does sound orthogonal, yes.


>
>> +Rustdoc output
>> +==============
>> +
>> +If this documentation includes rustdoc-generated HTML, the entry point
>> +can be found `here. <rustdoc/kernel/index.html>`_
> Perhaps this sentence could be moved to the top of the index file, so
> that users do not need two clicks when visiting "Rust"? That way we
> avoid one more file too.


Yes, that will be better :)


>
>> +RUSTDOC_OUTPUT=$(objtree)/Documentation/output/rust/rustdoc
> Please add a space around the equal sign to be consistent with (most)
> of the rest of the file.


Ack


>
> Cheers,
> Miguel


Thanks,
Carlos

