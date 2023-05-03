Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596816F5283
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 10:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjECICf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 04:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjECICd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 04:02:33 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010BC1BEB;
        Wed,  3 May 2023 01:02:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l98KESq1ccQG+cIJYM0jD3HhDYcxORH0wHNUyxokAziS5odHFB/NDS59i49FrNRht7U8izQp6AlO6FQYfCEaDQlpnoqmiVvfRoPUqJ2T1uNoZzcY1FHMylr/NWUtdlCcR2owIXMm4UQAWbZSp4ktZGOkl4PhWbY/IC0/fu/DGcjMR20tpnZWpVjfo2p9gqhidJZrt8NPKwDIVnTTLd5XtzF5LSDvMQJvvo43puZgF9Wm+Y2sY76i8CeU3y5HiEqIRyCJvPiwTFioiQvDd6YeyeyEiUGLu5Bktd98ou36JhDTYPiM7WDRY1zuh0l+m7qbP3crE/Sj/OEFbkYXFm+9KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7VOMbP30k0jaqGqVoTs+wvlj4S683xsCEPxwz6x/esk=;
 b=SVRZmG1pqzo0rE3Fo6HVRTqw+NNkdxPTgzwBHg7OAPy6V3wU92QKBor8kMTFgl/7ZSgQLZTWjpPtZHCjynGG2FErM9H5wZI+UgXUDjdiP34RtUdotn1zOrsvLHrSd+SyXj+uo0hR9HOCKFY/BoqtqWAkGIPHKb5SAnD3F6mw31vLdd1i+sjAHC1nuWZRvjM8/yA9khCTETHmscO/WmWVyKEShXyV/ccBvmMglnwPcOWjavxRIYTn9jzj4i8BFwKP0d+4lMxNTHMMijSVJI453Ri0OO/dsMiZWYrON3R0oNz/TvkKuxIDZIPGx6asKv8jMvKluG+Ya8IptdZRSVCyCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7VOMbP30k0jaqGqVoTs+wvlj4S683xsCEPxwz6x/esk=;
 b=vkOdkrBShMJRHF1EErMOr635hFFFBWTEFfXscWqmTOmc5qv7NCmtn0h6TAdy0QBLcadwLqasiQr6+9CkU+vLAig2oL6Iy0xI8kuS2O7ZL/28cbrLlJMW5Uso0W0PWSsPIizVEPaUBFEPA+HMEBMifqYJVKdagl3lW4J6BjVBolo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by DM4PR12MB7576.namprd12.prod.outlook.com (2603:10b6:8:10c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Wed, 3 May
 2023 08:02:29 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::20b9:d472:1981:cf94]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::20b9:d472:1981:cf94%4]) with mapi id 15.20.6340.031; Wed, 3 May 2023
 08:02:29 +0000
Message-ID: <bfc2c9f9-a8cb-84a8-0800-fc90f6ec2eda@amd.com>
Date:   Wed, 3 May 2023 10:02:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] ARM: zynq: dts: Setting default i2c clock frequency to
 400kHz
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Varalaxmi Bingi <varalaxmi.bingi@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <4dde5d1eb8e4572dae4295a19a4c83002a58e5da.1683035611.git.michal.simek@amd.com>
 <e0b50ae1-b501-cb41-829f-736903e5794f@linaro.org>
 <958f4336-8c38-4cc1-4313-06a54e397d42@amd.com>
 <89276de5-ded8-2f38-bcea-708fdd35ca6d@linaro.org>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <89276de5-ded8-2f38-bcea-708fdd35ca6d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0053.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::30) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|DM4PR12MB7576:EE_
X-MS-Office365-Filtering-Correlation-Id: 01139ab7-bd4e-4ebf-dcd2-08db4bacbcf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qWlGI+XjAAgjEtCW2LkS1gLcLmfIAe/h6vN9QZLGZscYNIYG8OKPtgzULqg9gZEd5l2pPXM0k1OywP0bHZnHIlM3dvdfDZe245CTLUBJJX599zaCpECcsWeVXMWfEjXSK+L0JaIUBC9HJZP9ByIclNr/PG49BALqOXJEshIqa+hoyTFABHTcBWKOWNF7d4eX02+7C1jmkXIKOCy+Rj1d0DTvUbGMy0A7sG15v7IK4HjiTSo/xFH7SrxdSu47Hb9MoROn0rSh+1fYPeqXFYxPwx1FmrUCURVdNE6f11FDlUsVlPZRixqraST3k9q34mXLty6CKDjSZAOjEVrg9bbvUOKWTZVmKr0MNjo4nsUiiivXhUFDsaMZEFr93e0M4I9ugC6M48rFyqn6PB7Zk6ck2nue7ESaJZyYPtNvChkpMvBbMECwTpm8ZXI1QIq32xZYgLf0S2P64/Y7iXNLQIwUqE4aAATRUv5cGSYw4xK3OicURJFAvWvhxI0BOB1WVfw4/f1FC67+CD3kIzDvzRWlaLix6jvDcJfrcJU4SBcvzSgB7fxH3zNG171/KySeV7ohVd1Spj56fJcn/E1HRGrBx9Lu9NySVSikLQXsShb3X8nPOcqWnr6ke0pEbsI/LmLx0DwMuXGaR2VKcC4Xfplt2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(346002)(136003)(39860400002)(376002)(451199021)(83380400001)(31686004)(6486002)(6666004)(44832011)(966005)(86362001)(26005)(53546011)(6512007)(6506007)(36756003)(2616005)(186003)(66946007)(66476007)(41300700001)(66556008)(38100700002)(478600001)(2906002)(4326008)(316002)(5660300002)(31696002)(8676002)(54906003)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sm9sZXZjbG5rSDAveUNYS2trZXQ2eEhOL0pCazErQ29DZ1R4bVJDZjlhOE13?=
 =?utf-8?B?dUF2aDF0a2RqMWVjaWhzSzFrd2s3RGdyVEtFdFh3ZnBaWjQvdGM0SkxjKzF3?=
 =?utf-8?B?aEpqTWRrOGFsaHY2dXppTkp6NGlzL0FZRFBJYy91VjV5TnJjMGlmSVF5TTBF?=
 =?utf-8?B?ZldCMURVQ2ZnZVFySU11THQ2TEdXMTNzOGRxQzBpTHF4OFM5V2hybUxBdnlG?=
 =?utf-8?B?RDh2L0d4aDFVMGxQSUI4WlhWeTI4Q2xqc3NJNTRFaFhGOWJXVWdpSTVlY2JF?=
 =?utf-8?B?aDN3Q2JrRWJ4L1ZySGFsVHFKK1czNWdBd0pPNVZYamhiVkNKRXJMZGdITUM1?=
 =?utf-8?B?TXo5Y2JUNUI3enNTT3FBWlFOcVdJZ1FRM1Uwd2tKTjhob2dKd3ZZRCtCcVN3?=
 =?utf-8?B?RDZYb3lDbFNVSFNITytyZU9KbC93bmpCU2hnNjNRL0Y0RHBaOVpyVmpNS3Az?=
 =?utf-8?B?NmdqWSt0SEpoWjBlbysxTHp0cHhOYkFvLzhweG5VdllpSWdFM0pSK1BRVnpI?=
 =?utf-8?B?QTYxd0JYSVZEb3ExL3gxYlhXYi8zdlZJQmNpd3JXSDJ1bVlieEgva291enRY?=
 =?utf-8?B?bUlOZHJHaWFZU1VTQXAwVU1iWlFwSDFLa0ZhTGRuN1R5ak5oUVBZMkZzRTh3?=
 =?utf-8?B?TTBXMlg5MFN5RnQyekRMOE9PNU1FWnozd2s0Q2U3QjJwSEduYVlIZkFzWFM0?=
 =?utf-8?B?WllaM3QwaS9wOVdyVFF0SmdmZFFoUzRER0I4OGZGUndSZnMrTlpSU1V1bzBQ?=
 =?utf-8?B?L25JNVZNL0E4Qm8wUHE1Z2d5MlZJTDJrOXFHTytseENPaTFGeEM5WmR2bDZw?=
 =?utf-8?B?SFNTOTc4QjJmVDM0bXpsSTZQLy9wanJNemFMc2NJSjJzd3FHS3FIdTlGelg5?=
 =?utf-8?B?L3M5TFlIYTNmbEpmYi96clFwUzFPemQ0NnlITmV3anRpbkZ4ajNKcmtTU2p4?=
 =?utf-8?B?b044bnZPUURrVjdLYnVIVUNEOGhTUzRNSFZpajRyRE12MHgzMDREMktXeHlv?=
 =?utf-8?B?eEF1bUp5a0JjWjFTVGFKNVlrUWNTNWNXbFpZc2JjSzEyY3hBVHhhcURjR2sv?=
 =?utf-8?B?Q0MyWW4vOHI3bzZWTFJhYk9tbEZHUUcxUTBGRWFQaVJPT1R0OHpVYmRGTlgz?=
 =?utf-8?B?QlNJbzdaSmNob0FmT1YzcHE4VlpsMFBNZFlUbGZSUlMvcHRuZG9BdW5rd3E2?=
 =?utf-8?B?R1NHa1hrb0s2Qkw2ckdYQlY4Yk1IQkdrNzMwcG9CZGZlSnVmQUZ6WVpieEY0?=
 =?utf-8?B?UnFvUTBCS0l4U2QxVVFYaFN4SXVFNDkyaVFxSUdxWHYzR01FelhoS3BnUVh6?=
 =?utf-8?B?NjJzVms4a2ZWZ2dFMlZmZklFZlNvL0g0WkYxOTFFd2RUOERNNmovaTc4aWdj?=
 =?utf-8?B?L21BZjgwSDdmdnJyVDJ0ZE16UVVCTzQ0aUEyVzBQQW5wVXNkNmJINUJNaTdn?=
 =?utf-8?B?ZW9BamwvZlU0cGpvcE1iY0RFcURHSUdqVERuaGc2aEdPR3VzaEZGTGUwd0xV?=
 =?utf-8?B?Z3dLR1JkTjdmV3VXTGpDMGdYdHIrOVB0NEtBNllhVkZMWDV5eFRhNU5GKzJm?=
 =?utf-8?B?RTlqZHVhMUI4RFZnaVlCZ1cxUjZXWnJYVEhpazZLT2lBOFZ6cGlXbWdUdjFy?=
 =?utf-8?B?ZWlmWlgwVktlMVpCY2Z4cGd5V2FkcWg5bzNCeXh2dXd2NnpPQnppS2hwVWdP?=
 =?utf-8?B?aXBjakZ4SmRYcS92RGIwc2NtRnRHTlFxYzRsZ2dJV1Q4VWlKdEhTcjQ2ZWpx?=
 =?utf-8?B?ZnJZaStscVFPQXZMakMwSTRMWms1RGRROGppWU1sWmRGL2htbTdlVEcwU0Nl?=
 =?utf-8?B?emVTUkUvbCtSWm9UQ0N3eWZDZEtvR2o3MmptWmNqNFZmZG5SVkRzNzVHZ0c4?=
 =?utf-8?B?cGlGdVBIbnl1ODIxcTNjZ0ZaM0pJMk5Cd0UyTzdkczRVRUhoZGMxRW9qazBu?=
 =?utf-8?B?UTJsOXphY1JqK1o1VERpa3pSbjg3Qm1USDBicG5lVFd5aW91SjlRc3ZWeTVW?=
 =?utf-8?B?c1NROEZEVnJaVTJLRUUvdS9KVEhsNlFrZ1Q0eEZvNVRlVG9SakVXVVhpNEFR?=
 =?utf-8?B?aWZsZWh6WFRlbzBua2prd09NdUpTbk5FMFZVTDhETllLS1BvREszQWQwMWRp?=
 =?utf-8?Q?GvjMrdZ+LCECC97qsRObhDyId?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01139ab7-bd4e-4ebf-dcd2-08db4bacbcf3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 08:02:28.8184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7asEv5hkMQ8VSJsrzkepgWBvSdz25tGQhsEL3JrNSrj12U3tikKMl4rgtcZcd3lv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7576
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



On 5/3/23 09:40, Krzysztof Kozlowski wrote:
> On 03/05/2023 09:27, Michal Simek wrote:
>>
>>
>> On 5/2/23 22:13, Krzysztof Kozlowski wrote:
>>> CAUTION: This message has originated from an External Source. Please use proper judgment and caution when opening attachments, clicking links, or responding to this email.
>>>
>>>
>>> On 02/05/2023 15:53, Michal Simek wrote:
>>>> From: Varalaxmi Bingi <varalaxmi.bingi@amd.com>
>>>>
>>>> Setting default i2c clock frequency for Zynq to maximum rate of 400kHz.
>>>> Current default value is 100kHz.
>>>>
>>>> Signed-off-by: Varalaxmi Bingi <varalaxmi.bingi@amd.com>
>>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>>> ---
>>>>
>>>>    arch/arm/boot/dts/zynq-7000.dtsi | 2 ++
>>>>    1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
>>>> index cd9931f6bcbd..a7db3f3009f2 100644
>>>> --- a/arch/arm/boot/dts/zynq-7000.dtsi
>>>> +++ b/arch/arm/boot/dts/zynq-7000.dtsi
>>>> @@ -149,6 +149,7 @@ i2c0: i2c@e0004000 {
>>>>                         clocks = <&clkc 38>;
>>>>                         interrupt-parent = <&intc>;
>>>>                         interrupts = <0 25 4>;
>>>> +                     clock-frequency = <400000>;
>>>
>>> I think this should be rather property of the board, because it depends
>>> on I2C devices, right?
>>
>> We have 15+ boards with i2c connected and from this count I am aware about only
>> one configuration which is not working on 400k.
>> It is a question if make sense to update all boards (except for 1 and not all in
>> kernel yet) to 400k or just say 400k is default and if there is any issue use
>> lower frequency.
>> Obviously this patch is setting up 400k as default and let "problematic" boards
>> to setup lower freq.
>> The same approach was used for modepin description.
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch/arm64/boot/dts/xilinx/zynqmp.dtsi?h=v6.3&id=53ba1b2bdaf7f481fdd878e9c18cd0e54081fac9
>>
>> The next point is that 100k is default in Linux but doesn't mean it is default
>> in other projects.
>>
>> But if you think that it must be board property I think we should setup 100k as
>> default in this file too to make it clear.
> 
> No, if it is conscious choice, it's fine.

Is it Ack then or you want me to extend commit message?

Thanks,
Michal
