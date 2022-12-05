Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBBAA642D15
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 17:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbiLEQii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 11:38:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232849AbiLEQiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 11:38:13 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F5B209BF;
        Mon,  5 Dec 2022 08:36:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lcW3kJOYxnFxPxBSUY9ORd2pQUUVPDBasu2uE6FvzUiolhxZkAUgkgMJ+m7OM6+SbwOz7/mgcvQDtx1NpcfP5nLKOy0rm4Gag/Y4gPOYeOU4zRB2wK1rWFEr0K8nHN7skogcv3kyEaSB+r/QSJo3Ap/GnZRitM4hnB9DxHn8C6b2a52AB2QyrvqPbuu1JupDhGjlYVZHrbAFDeV7rqnWbgUG/Wx4UsWKU/aFyvuCa6J5SWeRzaHk1Isqat9DDRGf2dzQixFJyQKNXpLL8P59Tar57nim0/xXreS9Q4zJz2K4YYJd4vwNHvSFyWSIt3Jte9dYKc+8ubwZ/DyK22qKFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vqsohskPssaDUTq5I83mr5skMe4Og12KGVWpJPVnabw=;
 b=n/HqSDr/ynx7qe4FvDKFE/bE/aZF2fKSZ1t+vNWvXvK7sSm8WR12IA81N6N9vQE8U6MUpezwlWVQ1qRo9pGiiV43TLVHG1qwXysoUWuYY0563gUybQEOLvBvZNWlsh3Ll96gHMnecbK+wZUKv9c3/PT2wdmrWLnGyhJdY49FSgoh+uT+M4rGwdNjvOINLeu9y/1mT5apC/vpGrICUipP7rprm4a9N3GqTejoiJG5oapzq/9g0ytRDSopOrEhn1iFlpNUUSkd/OJdwif17zUTJeCUVnbOYg7MlNvM6uzkwJg+pcYhoNQgq7qO9rEKdcX0LXWpI498lNH/3nzqhlkVYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqsohskPssaDUTq5I83mr5skMe4Og12KGVWpJPVnabw=;
 b=ilkurI8E0dhDJite48omCaIDZ/x9ceokecsTAjP3k03M6jJ7kxkVW20JsqdjfHm4U68Y0IC2hrNInlDrfCqOk778cBF6Qv2sanZcCFV74r2Jg3CgAXQD+5Fd4j3lyImRmqW0WeC2Gdf3cwUkE+a/K1/IS03ZkEW5s2vasx+HAy0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by PH7PR12MB7331.namprd12.prod.outlook.com (2603:10b6:510:20e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.13; Mon, 5 Dec
 2022 16:36:13 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::45b1:34fb:e14d:96e4]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::45b1:34fb:e14d:96e4%5]) with mapi id 15.20.5880.013; Mon, 5 Dec 2022
 16:36:13 +0000
Message-ID: <dd0a67d6-0ba3-66e2-851c-7498b0bc99d1@amd.com>
Date:   Mon, 5 Dec 2022 10:36:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] docs: Integrate rustdoc into Rust documentation
Content-Language: en-US
To:     Akira Yokosawa <akiyks@gmail.com>, ojeda@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        bilbao@vt.edu, corbet@lwn.net, konstantin@linuxfoundation.org
References: <20221130220825.1545758-1-carlos.bilbao@amd.com>
 <20221201204814.2141401-1-carlos.bilbao@amd.com>
 <a019a3f1-7ff1-15b2-d930-e1d722847e0c@gmail.com>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <a019a3f1-7ff1-15b2-d930-e1d722847e0c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR10CA0020.namprd10.prod.outlook.com
 (2603:10b6:610:4c::30) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|PH7PR12MB7331:EE_
X-MS-Office365-Filtering-Correlation-Id: 5725dee1-4ad5-431e-029b-08dad6ded2af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HAhQP+3FkQiMhg1ZdnrQSDAmtUtfyAqmog7hGxGiEc9412a/WDIvcyKxOtCbijDpdSsNV4NGJklrQNBG4iIkd+wJixns6+qmNlRkM0rhTU4xWLJqHLv4fhz29pjtsQbowZi6KI8uyrP/mc4OETBbZJVtgA+EIoerJ9tX9twGeuQs9rT7BaSVadT6XXFbN5GOTre72YS9YXRZBhkIopUOirNmkZVclTNet7iyaaEheBFmH1UBR34tqt+yHgySpdDOou9HgtoLlUkCJk8zHxTrRT72OigcIMHAV/3Z7ypLv7/7NcJPUMqIVz+iZsReZuSeFWc8vbvPkfz5Tmmx3GLBTNG2QCtCw/du4vS7FI5r7ZrAdRMadjPdZvGW/F2F0dOT1qBU6JJ/Gs3/8ACF6AA+1hnp8fHZjGNjW0TKWhB0ZdiDOOawQplz+N+ZKHG67n7hfQow7VubpmjGpscxEAB+xVsuUeYOoWvC26YYNvsaj/7ZZ+b1PjPX4RvV5/6rgvS4TxXjhSdKzdn5d2Mhq2BGrek1dHVcmtnOt+YU0aB4EkFbLQCr11FEtiyP2bcaTSJkbOX2b3OKqubV+6nYKbmAmXFlPxHdC0H4xb8AzM/3uadVfT3Auz475UnRPcM8szK6PEc6in+CPBbuWeziLWJCxKbXe3KDRVbj8GYAobUYiMuAK6NcfzWMjS3VzcY4Ap8YmvyvmYzD7PRZvVJTOScrRN8cEoixEuGYMu9hWByJbEv+LN9Iy1DNMG7GRJQu4npq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(366004)(39860400002)(396003)(376002)(451199015)(36756003)(316002)(966005)(45080400002)(83380400001)(6486002)(53546011)(6512007)(6506007)(26005)(186003)(2906002)(31696002)(86362001)(66476007)(66556008)(31686004)(4326008)(8676002)(38100700002)(66946007)(478600001)(2616005)(8936002)(41300700001)(5660300002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXlsbWpwVDQ0ZC9KSjIxS2NyLzdRc20xUnkxT0N5ZVdHd1VJcWhEOTM5TElV?=
 =?utf-8?B?cERUWC9GdXJXTDhIbGd6TW1kOXdrbTkwR0tTa3lwSHRsb2NpWGlYUElqVFJM?=
 =?utf-8?B?UDhGOFFERXl4Y0FBalVObnlsSEdBakd0and5N0hzZDJzZGw3d1FZQXRvK1Vk?=
 =?utf-8?B?NEY1Q0F6MU1lQzdhWE40MXkvOUNxS1pYeEFWTk94UkIxOWRKRENTdTd6Qngv?=
 =?utf-8?B?dDVsbGtKZmJhSS82eU5UR0JTeHppTzBvR2FqbGRmelBLMGNvUTBQM0pYVE15?=
 =?utf-8?B?RDlrbjRUVERIeGUycHpGWCtLb2dCc1F4ZHdpNE1kcHhKTEZNVVlrK1FPemE4?=
 =?utf-8?B?a1JYUGNZN0czT0ZkQVB0bmJ4bHhFZ0lpeWtHcVJKWUdNZTh1VzJFZ2U0Um04?=
 =?utf-8?B?K2l2U29yT2pLVkkrZTVxb3NzOGo2STVsK01qRGMzUGdpV3pyQk5BMENZVndr?=
 =?utf-8?B?OWZvWXo2Q2NGaXFPM1kzRThiOEF5R1kyamEzK3BqMFNWOGJETjIyd1Q0L3BG?=
 =?utf-8?B?ODhoVjROMXdldGE4ckQ3WkJuWmJJdXAzaVZLaHJlcU9rUW1WK2ZTQ25nck8y?=
 =?utf-8?B?VHR5Zy94U2JhaUpFQXVxZEhFWllQcjZTaVpBRm5aRkpmTVVqVXdpL2diVVBB?=
 =?utf-8?B?NmR0WFVab3RIQzdIMmNVeFI3Q3RyY3ZGeFIyQmxQaW9ZaHUzSXo1V0NDMnA2?=
 =?utf-8?B?bVVCV29halhJZTJSK1RneEdBQUl4UnFCNWpPVUZ3T3Bud0dxeXpQSjNGRE82?=
 =?utf-8?B?L2kzQXliWmJ3c21RT3JBZE9vaVJ6QUYrZmNLY0dmVDdQR3lBNU5nY1N1amxa?=
 =?utf-8?B?bGp2TUdhbDVpUHlpWGdzV0NHMVllWXA4ZjdxNHFCTUVoNTExVHc4WVZWR0JM?=
 =?utf-8?B?Z0R0WWg3d0VjVXhUQ3FSNVBrQWgzVTdMM3NJR25NZVFDLytJdWRHODJYSGwr?=
 =?utf-8?B?SFJIS1lCRG9ySExkL3lnc2dtaTlmMjU1eWEwdWFqMmNCUWVrN3MwTm1CaDhx?=
 =?utf-8?B?SU4zYk1wNytYbFhnZ3JsQWtUOXE5bVFnM3hwL1lER3RjVTFrRnJHdTR4N2Rp?=
 =?utf-8?B?aUpGOVlURjFtNjdNa2JmUi81Q0tyZkdDRFIvR1FTRXRjSk44NkRCUjZJdmdk?=
 =?utf-8?B?OGhPeFVoNGV1ODFURDN6ekxmU2tiZFo2azcyMVRhb01HSzM1TytRdWxxKzJU?=
 =?utf-8?B?UnRRa2xuTFp1N1FBeWNSWUp6YmNmQ256TkRReDEycVhxWEk2bG1lWGFIalhw?=
 =?utf-8?B?MHIrRlpwUlJVMGI5RWJXTkFqQVRZME9rczdBYy8zeU1BSFl2akkzQnlkbGNa?=
 =?utf-8?B?MU1YclZqVWV6aGJ0cXNIWEdHUnNNZldkLzc4VEZUcnlNR0pwTUViL1hsNnBT?=
 =?utf-8?B?Q0c2bW9Sd3pYRFVyVVBmRFRpNGNxclFJWWxOVndSYWZDbjRXSm02a0hoeEw0?=
 =?utf-8?B?a3pSN2k2UklxZDVFZzZxL1NXSW5mQml2UGNreHZpYmEvQ2dsT2xzR0FhbHRn?=
 =?utf-8?B?ZE1GYko4em5sa3RvREZKRmxMaXp2dE95YUFJTDMrZ1JWRGppUWlzSHVMTVl0?=
 =?utf-8?B?aWhqbnU3dWhYUGhJWCttRFlDQlduRjBHRWRFMWZQbjhYVDliLzRTeFpMQXlk?=
 =?utf-8?B?YTk3cUtIVGp0T2RlZ291OWU1REwyK2NQc3NrQm1DSENnc1JxVFpqTVdyZVlK?=
 =?utf-8?B?VEU3VlA2UFpQSTBTRHQxMW1WejArTU1lNkFqaVBqRnBweUw3dHhybE5RN1M3?=
 =?utf-8?B?WGhlczFDKzE4WmwySmZYNTBTR3dZUnpMQ2pBdGFuTndFOEhTYnVHZ3FKVURJ?=
 =?utf-8?B?d1hGYXJTanRBaHpDQzh6YnRENllrYTZkenlHeTdIdXB1TXZnWEs1RVJIVXJj?=
 =?utf-8?B?dnFxV3UvWmZZSWlhQ2h2cTlvdFAxUVdoeTVOS0lMUzdQT1FHd0d1dzJ5dWxh?=
 =?utf-8?B?UUhUU2ZtbEkvaUZzclhNVWFpbjBGSXNvV2ZBTERMWXBNTkdZWEdxM21MdUFT?=
 =?utf-8?B?dml1NXlBM1JidFNzUFdpV3FYYm1EcXJoeStaOStmYXRXY0JTK2FNRFZ5ZVZL?=
 =?utf-8?B?ZnBSK1p2N0ZuRUpzdXM2WTg2Qi9JUEo2WTVJUStIWmFQUzd5K09wQ0Y1QkR0?=
 =?utf-8?Q?WuF/MXL75cDvnu9LwU/karQTY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5725dee1-4ad5-431e-029b-08dad6ded2af
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 16:36:13.6489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e98JtQwlrhDEq5FoE2GFzTVmko3S7J3NUMlP89uGarwKG5g1zizd9KYXXwO9ItMfKaDs4mj6KRSdsxHbSUhQkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7331
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/22 19:06, Akira Yokosawa wrote:

> Hi,
>
> On Thu, 1 Dec 2022 14:48:14 -0600, Carlos Bilbao wrote:
>> Include HTML output generated with rustdoc into the Linux kernel
>> documentation on Rust. Change target `make htmldocs` to combine RST Sphinx
>> and the generation of Rust documentation, when support is available.
>>
>> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
>> ---
>>
>> Changes since V1:
>>   - Work on top of v6.1-rc1.
> Thank you for the rebase.
>
>>   - Don't use rustdoc.rst, instead add link to Documentation/rust/index.rst.
>>   - In Documentation/Makefile, replace @make rustdoc for $(Q)$(MAKE) rustdoc.
>>   - Don't do LLVM=1 for all rustdoc generation within `make htmldocs`.
>>   - Add spaces on definition of RUSTDOC_OUTPUT, for consistency.
>>
>> ---
>>   Documentation/Makefile       |  4 ++++
>>   Documentation/rust/index.rst |  3 +++
>>   rust/Makefile                | 15 +++++++++------
>>   3 files changed, 16 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/Makefile b/Documentation/Makefile
>> index 64d44c1ecad3..f537cf558af6 100644
>> --- a/Documentation/Makefile
>> +++ b/Documentation/Makefile
>> @@ -92,6 +92,10 @@ quiet_cmd_sphinx = SPHINX  $@ --> file://$(abspath $(BUILDDIR)/$3/$4)
>>   	fi
>>   
>>   htmldocs:
>> +# If Rust support is available, add rustdoc generated contents
>> +ifdef CONFIG_RUST
>> +	$(Q)$(MAKE) rustdoc
>> +endif
>>   	@$(srctree)/scripts/sphinx-pre-install --version-check
>>   	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,html,$(var),,$(var)))
> So, this means "make htmldocs" will require kernel .config if CONFIG_RUST=y.
> I'm not sure this new requirement is acceptable for kernel documentation
> testers who just want to build kernel documentation.


This is already kind of the case for Rust-related business.


>
> You are doing three things in this patch.
>
>   1) Change the destination of rustdoc to under Documentation/output/
>   2) Add a cross reference to the generated rustdoc in
>      Documentation/rust/index.rst.
>   3) Integrate rustdoc generation into htmldocs.
>
> I'm OK with 1) and 2).
> Can you separate 3) into another patch and respin?


Glad we can agree on 1) and 2). Why moving 3)? This is a small patch with
one overall purpose (Integrate rustdoc into website).


>
> By the way, is rustdoc's requirement of .config only for CONFIG_RUST?
> In other words, are contents of rustdoc affected by other config settings?
>
> If not, I think rustdoc can be generated regardless of config settings as
> far as necessary tools (rustc, bindgen, etc.) are available.


Yes, but someone with the tools may not want to use them. Keep in mind that
generating rustdoc takes a few extra seconds.


>
>>   
>> diff --git a/Documentation/rust/index.rst b/Documentation/rust/index.rst
>> index 4ae8c66b94fa..4005326c3ba9 100644
>> --- a/Documentation/rust/index.rst
>> +++ b/Documentation/rust/index.rst
>> @@ -6,6 +6,9 @@ Rust
>>   Documentation related to Rust within the kernel. To start using Rust
>>   in the kernel, please read the quick-start.rst guide.
>>   
>> +If this documentation includes rustdoc-generated HTML, the entry point can
>> +be found `here. <rustdoc/kernel/index.html>`_
> This cross reference will only make sense in htmldocs build.
> Perhaps, you can use the "only::" directive [1] as follows:
>
> .. only:: html


This I can gladly do on a V3. I will wait for an answer on issues above.


>
>      If this documentation includes rustdoc-generated HTML, the entry point can
>      be found `here. <rustdoc/kernel/index.html>`_
>
> [1]: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.sphinx-doc.org%2Fen%2Fmaster%2Fusage%2Frestructuredtext%2Fdirectives.html%23directive-only&amp;data=05%7C01%7Ccarlos.bilbao%40amd.com%7C163763a795284a542e4f08dad65cf4c6%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638057991984040258%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=DU8nmQp7gCCGNMUR6urtHHCz5nXAtomeV17%2BzB%2F4L38%3D&amp;reserved=0
>
>          Thanks, Akira
>
>> +
>>   .. toctree::
>>       :maxdepth: 1
>>   
>> diff --git a/rust/Makefile b/rust/Makefile
>> index 7700d3853404..080c07048065 100644
>> --- a/rust/Makefile
>> +++ b/rust/Makefile
>> @@ -1,5 +1,8 @@
>>   # SPDX-License-Identifier: GPL-2.0
>>   
>> +# Where to place rustdoc generated documentation
>> +RUSTDOC_OUTPUT = $(objtree)/Documentation/output/rust/rustdoc
>> +
>>   always-$(CONFIG_RUST) += target.json
>>   no-clean-files += target.json
>>   
>> @@ -58,7 +61,7 @@ quiet_cmd_rustdoc = RUSTDOC $(if $(rustdoc_host),H, ) $<
>>   	OBJTREE=$(abspath $(objtree)) \
>>   	$(RUSTDOC) $(if $(rustdoc_host),$(rust_common_flags),$(rust_flags)) \
>>   		$(rustc_target_flags) -L$(objtree)/$(obj) \
>> -		--output $(objtree)/$(obj)/doc \
>> +		--output $(RUSTDOC_OUTPUT) \
>>   		--crate-name $(subst rustdoc-,,$@) \
>>   		@$(objtree)/include/generated/rustc_cfg $<
>>   
>> @@ -75,15 +78,15 @@ quiet_cmd_rustdoc = RUSTDOC $(if $(rustdoc_host),H, ) $<
>>   # and then retouch the generated files.
>>   rustdoc: rustdoc-core rustdoc-macros rustdoc-compiler_builtins \
>>       rustdoc-alloc rustdoc-kernel
>> -	$(Q)cp $(srctree)/Documentation/images/logo.svg $(objtree)/$(obj)/doc
>> -	$(Q)cp $(srctree)/Documentation/images/COPYING-logo $(objtree)/$(obj)/doc
>> -	$(Q)find $(objtree)/$(obj)/doc -name '*.html' -type f -print0 | xargs -0 sed -Ei \
>> +	$(Q)cp $(srctree)/Documentation/images/logo.svg $(RUSTDOC_OUTPUT)
>> +	$(Q)cp $(srctree)/Documentation/images/COPYING-logo $(RUSTDOC_OUTPUT)
>> +	$(Q)find $(RUSTDOC_OUTPUT) -name '*.html' -type f -print0 | xargs -0 sed -Ei \
>>   		-e 's:rust-logo\.svg:logo.svg:g' \
>>   		-e 's:rust-logo\.png:logo.svg:g' \
>>   		-e 's:favicon\.svg:logo.svg:g' \
>>   		-e 's:<link rel="alternate icon" type="image/png" href="[./]*favicon-(16x16|32x32)\.png">::g'
>>   	$(Q)echo '.logo-container > img { object-fit: contain; }' \
>> -		>> $(objtree)/$(obj)/doc/rustdoc.css
>> +		>> $(RUSTDOC_OUTPUT)/rustdoc.css
>>   
>>   rustdoc-macros: private rustdoc_host = yes
>>   rustdoc-macros: private rustc_target_flags = --crate-type proc-macro \
>> @@ -141,7 +144,7 @@ quiet_cmd_rustdoc_test = RUSTDOC T $<
>>   		@$(objtree)/include/generated/rustc_cfg \
>>   		$(rustc_target_flags) $(rustdoc_test_target_flags) \
>>   		--sysroot $(objtree)/$(obj)/test/sysroot $(rustdoc_test_quiet) \
>> -		-L$(objtree)/$(obj)/test --output $(objtree)/$(obj)/doc \
>> +		-L$(objtree)/$(obj)/test --output $(RUSTDOC_OUTPUT) \
>>   		--crate-name $(subst rusttest-,,$@) $<
>>   
>>   # We cannot use `-Zpanic-abort-tests` because some tests are dynamic,
>>
>> base-commit: 9abf2313adc1ca1b6180c508c25f22f9395cc780


Thanks,
Carlos
