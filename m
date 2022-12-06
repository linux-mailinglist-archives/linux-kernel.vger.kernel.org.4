Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C39644757
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 16:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233742AbiLFPC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 10:02:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiLFPBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 10:01:46 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132322F037;
        Tue,  6 Dec 2022 06:55:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cmfFmTcFYpnBGFJkzBrFdYrrHr216Ip/2F5hGotABAo61QvHe267ShE11kpAs+dMWo3Y7DsWlRyq/dXxMRVCMMw3vSjDazVikgz6z2NQ1OkAb4hh4bERaWBM8xl7aZmNoW2tpdCLK6tHBeolBsdbbvrPcKj+GWTztQ2PcUw9DTWebEA5H6aB5IK7SGY9CH42l1v9uhUTBVYK/plTaZZolxfgSEY2SD9KiLnGFu3D7bcB/sDJrtUw1LzGxTeTczv2aXR/HacykhMG6CIN+U0nWDyYOJdSUlCILSwmotatEiptERHrRfcxS9xo4p42i3ztQoQzOK9gtp0bN84ol2cFOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8pYc+OCbB/9cmR8xsguG+2j1c6sCm8GlrycJ1ZhpxC0=;
 b=M4mzMKLQo8kSRq96aij6qL6UpxtEQmj4N6m3LdDt3fZ52XuZksU9/dP5RQOpNhTgbDN82po5kZtjL16QO9dR/WSGpkUQRANO91lAaVKDUjynttpi5OWEhA2PdKY+yBn+MtH36udQ7iSZbHevYy6nxAOP4gqYFpLJSDXqSP+nbtRFDMk9kubkgT1pxS9lUe5Z4o7hH8dDoN4hqh4bttWqQqfYirBv4wpIHEP6pkZH7MHyBOO8bogwVeik3MEuRk7r0WH0RfpTCkG04kCic9TNHUk2cZ17oa5fT28tykRhfo54WRXxG7pN4yRwscgpLyhawqemeeyW1a1vDRJlt135DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8pYc+OCbB/9cmR8xsguG+2j1c6sCm8GlrycJ1ZhpxC0=;
 b=EAfiJudw20og/Hv6Jxf+V8IkRwF7maSipwysUB3mCTbDWM23gnnmzMqOj67U9NSOZ5xNP4U/OvFkrlldPSwP+P/roWbO6pio3J8zGiB0VnqUBJqMxkJ0eLlfL0N85nflvt9SLCeqgUkwhf5BSAvTTSexbOvrd+Q22JLsDCx1okE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by DS0PR12MB6606.namprd12.prod.outlook.com (2603:10b6:8:d2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Tue, 6 Dec
 2022 14:55:05 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::45b1:34fb:e14d:96e4]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::45b1:34fb:e14d:96e4%5]) with mapi id 15.20.5880.013; Tue, 6 Dec 2022
 14:55:05 +0000
Message-ID: <ca4912ca-a774-6d0e-5464-5adfd12268da@amd.com>
Date:   Tue, 6 Dec 2022 08:55:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] docs: Integrate rustdoc into Rust documentation
Content-Language: en-US
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        bilbao@vt.edu, corbet@lwn.net, konstantin@linuxfoundation.org,
        ojeda@kernel.org
References: <20221130220825.1545758-1-carlos.bilbao@amd.com>
 <20221201204814.2141401-1-carlos.bilbao@amd.com>
 <a019a3f1-7ff1-15b2-d930-e1d722847e0c@gmail.com>
 <dd0a67d6-0ba3-66e2-851c-7498b0bc99d1@amd.com>
 <3e5f2b84-a351-2e6d-f620-421876908aba@gmail.com>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <3e5f2b84-a351-2e6d-f620-421876908aba@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0044.namprd03.prod.outlook.com
 (2603:10b6:208:32d::19) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|DS0PR12MB6606:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e8a5e8e-1d44-46f3-7ba0-08dad799dc0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 55Yg3iMBremLFsKBhSyU/+TFNwpRfa1mSXMh+A8atA1eb3yHoQGXW4Mt+PEA1mdvFrZUA4ljGy3RMjMOtjLVyUPTeobT9Jkgc6rfknZihYNgMHMZsDpwttI91kDiVpvHE478wmsQYew2N2UwToTyOKQdXmLZnxVJpZnWjrDxOAKnZoKTJbCi/8RuVarwTyuEHvOHLj149s0IXK0hGWxWYFSy+dRx7aJ+wz1wmLuhXDd59aQAiFrPHx6hukcNL9hm5bK6yRadJ+zdSTXS5yGlGmYtAnT2uHrrV9Ju59MtII64HBhm6cNl53bsrPCfc2mtOZ3btZoEFpBhHdwPSKGhBhHjHkFsgCREYsICRrLwMmvlazceJsXAcDl039fe8D0DaLac+vKLJIQc7FUMtZwV4F8HxBPAPcsaHRib3SdjWGYCZoCo+GC3lCMVj6nYnVeDV188SvVrv3tjLp/W2xRFQsv09ZULpN1CarN4kF4uxw+jNwYDnrTRr9tZq4eqPSKwdO5MYh2Cif0DIn5qPa2uzoZJiH2FlYugtOUxx64dU9APnVDJ8keoU/2Vn8othD2V4SBdmsFTPUNfvW/2xx/2ScaMk9BgG3uFhVTEn4414rrk6iDcuywZcyNShVvdU+Kt/T9WaYEpCIW3ah6yV/6Y17buVG+lm9xHut2iTOfvOzvagCLjnneHHp/MCNtw6MR0N2iNyeDfbe9WgtUYtIOwdU6wE33GEtPncyMAph6f9CiX2QzkB9S8+r00MpwV1P97
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(346002)(366004)(396003)(451199015)(186003)(26005)(8936002)(53546011)(6512007)(478600001)(6666004)(6486002)(966005)(5660300002)(41300700001)(38100700002)(6916009)(83380400001)(44832011)(86362001)(2616005)(31696002)(6506007)(31686004)(66946007)(2906002)(36756003)(45080400002)(66476007)(66556008)(316002)(8676002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHQ4OXJ0TVdtV1MrM3h2WC9BYWppY1RwUFRIc1hPMlk3bGU3TGpWZm4zVVB4?=
 =?utf-8?B?VHE2RjN4RHpPSHE5Z0xZREtFL09Bb1k0YXN4K2dZZWVMLzBxOUYzZ2tIbmpE?=
 =?utf-8?B?dmZwWUUwN0gvR0wxSkJvNmFnY1BoNGZod2Q4ekNIMzhYdTBoQXJOTGdTTEx0?=
 =?utf-8?B?VGkvdm85K3A1RnVBdXJvR3RzcXJjU0JGNmhhbml5enVtQmZRMHZYUWFqRDA2?=
 =?utf-8?B?WG80YmlSTkZEeW8yT0VXVWsxaWZ3YWtJZGRpN29lY1dMWVBZMVdzdzNsNGhV?=
 =?utf-8?B?WHU4ZXlxQTdpM1EvYUlNYnpRdWdRZVRyN3NQSncveUx6N1hWc05hUXF6Ukpm?=
 =?utf-8?B?S1gzZGhXK2N0Q2xNeVkyUHZwV2NOWWVMYkJHb2RyM2hvbXZDajlTbHdmRUww?=
 =?utf-8?B?aGQxUHpIaEtEek1OdDNWNWZWdy8rckNudHZzVDBYSTYzcE81WVJyWS9DUUdF?=
 =?utf-8?B?RFJYUmxQN2M5YXFCb2MzWXlzMW9MYTc4YU0wV01LV0RJZ2ZObkJVSnZQYjBO?=
 =?utf-8?B?RER1MVdsRGM0REdaREZsczBiZ0krMUU4UGpTTURUWjNzek96bWVFUWlWdTBH?=
 =?utf-8?B?ZnJ2YjVWbUVraEVrQjMrZGtnRU03eFQwaEpTZ1hES1g4dnBQM0Z1dlVVa0k2?=
 =?utf-8?B?NVU1a1dmelpaMDFteHFOV2lwQVVvSEdCOE8zMWQrTDh3WVlzRE5pY2g4d1RM?=
 =?utf-8?B?Q1FLUTFMcWdjelBZK1VmaytpWG9mcjR6eVJHcklBSWJMazBDOEw0R3VtMjZQ?=
 =?utf-8?B?cFNidnpSQ2NiQ2tRTFFoeVRyS1poT2hpZ2tTbFRFN0NDWkxtekV3bUhUM21L?=
 =?utf-8?B?K3hiV0FXblN5ZlVvNFMrYTd4QUs3b1BpRWY3Y3JPelZGdmpHVXJNN1Brd0J3?=
 =?utf-8?B?eDdKVnRUM28vdzlFc2EyOERNcG5QL3NHNlFacG10UHNxTW41WXY1ZEVFT1M0?=
 =?utf-8?B?TkxPMG5TSzNHNTlkbERaUUhrazVBeHVFTWtCemVlY0YrWktqaEFyN2EzeC9Y?=
 =?utf-8?B?WTFiUlVTdHlGTFd3b1IrL1VhQmpnSDF5Q2hPVmw2bUdpdnAxaWFZbmo1dDFj?=
 =?utf-8?B?d3NDbUNRbFhtSkNGRWR5SEtacUVQQXluSkI2SS9JRHAyNWMrUisrV3BTZVFM?=
 =?utf-8?B?bnYrT3cxQ253Um1WQnE0MXpIeG1HUmtEMFhpd09YVkRGSm1nNlhvWGYrbXRO?=
 =?utf-8?B?NytNQVZpTG5KMkVTdXZuT0E5c3F3UDJZVGF6bFNpTkZIeDREdGxaWFpzT2Fv?=
 =?utf-8?B?RmRzOGVRZytDTFpzZWNHRVBlc05SSzdiemFnblI2OXpldVFwKzIvMXQzakpD?=
 =?utf-8?B?VzBRVm9VVmNkWTZ1TGFjN21Nd1VxQm90dDNJSGl4REtVTGVTWU82ZS93Ymw4?=
 =?utf-8?B?KzM0UG92UE4yQ2pjUUMzVUxmRm11RUxtd0gxSUlYNytIUk1wa0dJRUNOcG85?=
 =?utf-8?B?MkNiSnFoNXRwcjBkVE1uUHR0UGxXYkx0SGhrNWwwSXBTMWJ5RGVKOU5Scno4?=
 =?utf-8?B?R3pzczRKR1A2WGFpejZSc3lVOUM0bXE2cE5mSmkwQ3A1MW1jSUhXek02N2FX?=
 =?utf-8?B?YnB3Uk1TelFsbkUvcVJDM0ZKU0lUQWNCVFJTcXRXOHovS1pLTkxHbWFFVGxS?=
 =?utf-8?B?TTlMY3BJMkErcnlOVWNlYlBCbmNtczg4bzI1bk1JWEN4Y3IzdGpwem50UHA0?=
 =?utf-8?B?Q1lqSi9BRkorWi82QkRodWtsb3h0RkpYNXFmTEt3UUFyd280ZXVpUEQwZ1pl?=
 =?utf-8?B?WHhGVFJjYk42RDVsVGN3U04wRkFMOWFnMWJVTTk1MHY3NHhtR3NmYmlYS1k1?=
 =?utf-8?B?aE5tMjkrWWo0ZnAwNFlwemdmeFA1UnhMeTdPV3JVUWFhc2dQTk4xbnZzY2hM?=
 =?utf-8?B?SEg5THB6VVdWcUhnOUZpWENlaE1QR0kyZ1NGc1d2N0txaDczb244VVlsSmhR?=
 =?utf-8?B?cWFpeHo4UmJrQjcyelYyWkpHaGZrOEM2UzlKall0STFSWGFXOGlSZS91MTZu?=
 =?utf-8?B?QXFvWlBxNW5XR0RNY0JRL1pBWXhvT0EralFFNUZJZFpyaHZGSWRHdG1uMkE4?=
 =?utf-8?B?ZnltODB5K2hrcHgyMllFbVZKWG5tYmFDUUptWS9sUHJqWHBBeDZnVGFNTmQ3?=
 =?utf-8?Q?WHvPcAmh36LaJl2ZQT5T2pKQ0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e8a5e8e-1d44-46f3-7ba0-08dad799dc0d
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2022 14:55:04.9435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xep6k/Ww/mvvyD6pICksEn6BHB/WXY7O6mQQkfSneQTteMO2VlHW5GiOXGiF/q22SLTSR6qFcfnN3zd0XAY/+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6606
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/22 08:22, Akira Yokosawa wrote:

> On Mon, 5 Dec 2022 10:36:11 -0600, Carlos Bilbao wrote:
>> On 12/4/22 19:06, Akira Yokosawa wrote:
>>
>>> Hi,
>>>
>>> On Thu, 1 Dec 2022 14:48:14 -0600, Carlos Bilbao wrote:
>>>> Include HTML output generated with rustdoc into the Linux kernel
>>>> documentation on Rust. Change target `make htmldocs` to combine RST Sphinx
>>>> and the generation of Rust documentation, when support is available.
>>>>
>>>> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
>>>> ---
>>>>
>>>> Changes since V1:
>>>>    - Work on top of v6.1-rc1.
>>> Thank you for the rebase.
>>>
>>>>    - Don't use rustdoc.rst, instead add link to Documentation/rust/index.rst.
>>>>    - In Documentation/Makefile, replace @make rustdoc for $(Q)$(MAKE) rustdoc.
>>>>    - Don't do LLVM=1 for all rustdoc generation within `make htmldocs`.
>>>>    - Add spaces on definition of RUSTDOC_OUTPUT, for consistency.
>>>>
>>>> ---
>>>>    Documentation/Makefile       |  4 ++++
>>>>    Documentation/rust/index.rst |  3 +++
>>>>    rust/Makefile                | 15 +++++++++------
>>>>    3 files changed, 16 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/Documentation/Makefile b/Documentation/Makefile
>>>> index 64d44c1ecad3..f537cf558af6 100644
>>>> --- a/Documentation/Makefile
>>>> +++ b/Documentation/Makefile
>>>> @@ -92,6 +92,10 @@ quiet_cmd_sphinx = SPHINX  $@ --> file://$(abspath $(BUILDDIR)/$3/$4)
>>>>        fi
>>>>      htmldocs:
>>>> +# If Rust support is available, add rustdoc generated contents
>>>> +ifdef CONFIG_RUST
>>>> +    $(Q)$(MAKE) rustdoc
>>>> +endif
>>>>        @$(srctree)/scripts/sphinx-pre-install --version-check
>>>>        @+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,html,$(var),,$(var)))
>>> So, this means "make htmldocs" will require kernel .config if CONFIG_RUST=y.
>>> I'm not sure this new requirement is acceptable for kernel documentation
>>> testers who just want to build kernel documentation.
>>
>> This is already kind of the case for Rust-related business.
>>
>>
>>> You are doing three things in this patch.
>>>
>>>    1) Change the destination of rustdoc to under Documentation/output/
>>>    2) Add a cross reference to the generated rustdoc in
>>>       Documentation/rust/index.rst.
>>>    3) Integrate rustdoc generation into htmldocs.
>>>
>>> I'm OK with 1) and 2).
>>> Can you separate 3) into another patch and respin?
>>
>> Glad we can agree on 1) and 2). Why moving 3)? This is a small patch with
>> one overall purpose (Integrate rustdoc into website).
> Yes, I agree that 3) is a small change. I understand what you want to
> do. But there are a couple of options for _how_ to do it.
> My current position is that Documentation/Makefile is _not_ the right
> place for the change, as mentioned in my reply to Miguel.
>
>>
>>> By the way, is rustdoc's requirement of .config only for CONFIG_RUST?
>>> In other words, are contents of rustdoc affected by other config settings?
>>>
>>> If not, I think rustdoc can be generated regardless of config settings as
>>> far as necessary tools (rustc, bindgen, etc.) are available.
>>
>> Yes, but someone with the tools may not want to use them. Keep in mind that
>> generating rustdoc takes a few extra seconds.
> As mentioned in another reply, I'm convinced of the dependency on .config.
>
>>
>>>>    diff --git a/Documentation/rust/index.rst b/Documentation/rust/index.rst
>>>> index 4ae8c66b94fa..4005326c3ba9 100644
>>>> --- a/Documentation/rust/index.rst
>>>> +++ b/Documentation/rust/index.rst
>>>> @@ -6,6 +6,9 @@ Rust
>>>>    Documentation related to Rust within the kernel. To start using Rust
>>>>    in the kernel, please read the quick-start.rst guide.
>>>>    +If this documentation includes rustdoc-generated HTML, the entry point can
>>>> +be found `here. <rustdoc/kernel/index.html>`_
>>> This cross reference will only make sense in htmldocs build.
>>> Perhaps, you can use the "only::" directive [1] as follows:
>>>
>>> .. only:: html
>>
>> This I can gladly do on a V3. I will wait for an answer on issues above.
> OK.
>
> So if you split this into a two-patch series, 1/2 for 1) and 2), and 2/2
> for 3) (or an updated one), I'm glad to give my RB tag to 1/2 for Miguel
> to be able take it for v6.2 (timing is tight!). 2/2 will need at least
> a couple of respins, I guess.


Sounds good, I will divide for v3.


>
>          Thanks, Akira
>>
>>>       If this documentation includes rustdoc-generated HTML, the entry point can
>>>       be found `here. <rustdoc/kernel/index.html>`_
>>>
>>> [1]: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.sphinx-doc.org%2Fen%2Fmaster%2Fusage%2Frestructuredtext%2Fdirectives.html%23directive-only&amp;data=05%7C01%7Ccarlos.bilbao%40amd.com%7Cbed091b8fae74b3d314408dad7954fc2%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638059333550278394%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=xGbmhYsge%2BoPo%2BRrsc6fCW8htY3yh0dHk4E8gQBQV9o%3D&amp;reserved=0
>>>
>>>           Thanks, Akira
>>>
>>>> +
>>>>    .. toctree::
>>>>        :maxdepth: 1
>>>>    diff --git a/rust/Makefile b/rust/Makefile
>>>> index 7700d3853404..080c07048065 100644
>>>> --- a/rust/Makefile
>>>> +++ b/rust/Makefile
>>>> @@ -1,5 +1,8 @@
>>>>    # SPDX-License-Identifier: GPL-2.0
>>>>    +# Where to place rustdoc generated documentation
>>>> +RUSTDOC_OUTPUT = $(objtree)/Documentation/output/rust/rustdoc
>>>> +
>>>>    always-$(CONFIG_RUST) += target.json
>>>>    no-clean-files += target.json
>>>>    @@ -58,7 +61,7 @@ quiet_cmd_rustdoc = RUSTDOC $(if $(rustdoc_host),H, ) $<
>>>>        OBJTREE=$(abspath $(objtree)) \
>>>>        $(RUSTDOC) $(if $(rustdoc_host),$(rust_common_flags),$(rust_flags)) \
>>>>            $(rustc_target_flags) -L$(objtree)/$(obj) \
>>>> -        --output $(objtree)/$(obj)/doc \
>>>> +        --output $(RUSTDOC_OUTPUT) \
>>>>            --crate-name $(subst rustdoc-,,$@) \
>>>>            @$(objtree)/include/generated/rustc_cfg $<
>>>>    @@ -75,15 +78,15 @@ quiet_cmd_rustdoc = RUSTDOC $(if $(rustdoc_host),H, ) $<
>>>>    # and then retouch the generated files.
>>>>    rustdoc: rustdoc-core rustdoc-macros rustdoc-compiler_builtins \
>>>>        rustdoc-alloc rustdoc-kernel
>>>> -    $(Q)cp $(srctree)/Documentation/images/logo.svg $(objtree)/$(obj)/doc
>>>> -    $(Q)cp $(srctree)/Documentation/images/COPYING-logo $(objtree)/$(obj)/doc
>>>> -    $(Q)find $(objtree)/$(obj)/doc -name '*.html' -type f -print0 | xargs -0 sed -Ei \
>>>> +    $(Q)cp $(srctree)/Documentation/images/logo.svg $(RUSTDOC_OUTPUT)
>>>> +    $(Q)cp $(srctree)/Documentation/images/COPYING-logo $(RUSTDOC_OUTPUT)
>>>> +    $(Q)find $(RUSTDOC_OUTPUT) -name '*.html' -type f -print0 | xargs -0 sed -Ei \
>>>>            -e 's:rust-logo\.svg:logo.svg:g' \
>>>>            -e 's:rust-logo\.png:logo.svg:g' \
>>>>            -e 's:favicon\.svg:logo.svg:g' \
>>>>            -e 's:<link rel="alternate icon" type="image/png" href="[./]*favicon-(16x16|32x32)\.png">::g'
>>>>        $(Q)echo '.logo-container > img { object-fit: contain; }' \
>>>> -        >> $(objtree)/$(obj)/doc/rustdoc.css
>>>> +        >> $(RUSTDOC_OUTPUT)/rustdoc.css
>>>>      rustdoc-macros: private rustdoc_host = yes
>>>>    rustdoc-macros: private rustc_target_flags = --crate-type proc-macro \
>>>> @@ -141,7 +144,7 @@ quiet_cmd_rustdoc_test = RUSTDOC T $<
>>>>            @$(objtree)/include/generated/rustc_cfg \
>>>>            $(rustc_target_flags) $(rustdoc_test_target_flags) \
>>>>            --sysroot $(objtree)/$(obj)/test/sysroot $(rustdoc_test_quiet) \
>>>> -        -L$(objtree)/$(obj)/test --output $(objtree)/$(obj)/doc \
>>>> +        -L$(objtree)/$(obj)/test --output $(RUSTDOC_OUTPUT) \
>>>>            --crate-name $(subst rusttest-,,$@) $<
>>>>      # We cannot use `-Zpanic-abort-tests` because some tests are dynamic,
>>>>
>>>> base-commit: 9abf2313adc1ca1b6180c508c25f22f9395cc780
>>
>> Thanks,
>> Carlos



