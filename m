Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4796E79C4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 14:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233219AbjDSM3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 08:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232880AbjDSM3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 08:29:06 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2079.outbound.protection.outlook.com [40.107.105.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C9515628;
        Wed, 19 Apr 2023 05:28:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R3Z52F1gRPNvySTu5M3mUTJpFHQSW2ZzZMGVsDmiXIJKHJVJonq60mXZk7QDYR2M25USp9yk1frAp+IYxwat5HTTh4IVy4Z08s1XDx/G3vBpjO+XTYOVyRaW8PMErSU1DJ1tBHB6m/FzBohrDDMc2zOJEtVXU7b4RWhCCsM6DKTUxlYePp2ncuzYlYHBmOqNOpJwHBBxK3JWBHxrcaAPZ2wFjuV5LUR8C5OsAllCVzA3f9zKtJlaAfmO3XIhE5EZtWCuaqT90CFoVugQ1Ovlp+GVHo5hYQZko3d/RDFi6h8kAbx0PVw+ahxRy+5te8Z+CkdR4E2UFQNSUuWTvnDrzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t9GFFHYOM+ITyK+gAObkdlPegYU7H1euoPXYQG0dGzo=;
 b=Y77CWQUMxti4a7gsAa0lqAzzFc7J/1ikTZiPikkLPCXgeresJYTo84z8Obbq/zj0P6hqZaErxGXwx5Ehv+wiEeduO35vQgB4nUnV8h9NCW210rZIgDnAouWo3Z9Vx10qpBLpC7eERzF3BE9MlLZLEyjZf0D4RGH0jz21uSXNyGrjsjFLy7MgCtHhT6FiZUjHB8Anu4dvI2Vu8hMJN6LGR//H4ulb+1GaEmQr2o55sZJQUVUOvuU7LwPgxMCwkOr7C6Ap2V9OjPuUIiG+7N6cq7J4IAnpyEk4AbpKdd63aJbKvGSzHI1CC2snd2i7ppXkrMMooY8UHW/hLdAzi34jCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9GFFHYOM+ITyK+gAObkdlPegYU7H1euoPXYQG0dGzo=;
 b=rsu4pyB0CipIjfMYQs5i5EeQE6bccH3bRw5BekudFuvGr3qEuvIFVnGiPg/Pt+SwcTPalnAGm8iW435nVXwlayY6JzJV3p/zGGu2wmHFdVncfWwFPloMKPyb6B3eJAVTOejOw9Z8EqSvY6GOyyP5/+Dz1T8pE45NoWYJaRRAh9ObDChpwKyYFQ9yAXJSkWAOrpI9gjNzY/r47Fs3Q+VM6/46jB4c2lSmUBI3I+iragPnHSLJICC0Ebuk+zCXiiDticKmbvMWpbFktAoBcEH6TBRCIl1r0n0LSx5kVJf8czKpbwFmf+CMqIC8UM4h3Uh2KZdrSOQ7Qv/zA8y4xHTKJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3682.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:15e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.21; Wed, 19 Apr
 2023 12:28:25 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e%5]) with mapi id 15.20.6319.021; Wed, 19 Apr 2023
 12:28:25 +0000
Message-ID: <78072f5f-9bbd-971f-f57d-1cc86c0168c9@siemens.com>
Date:   Wed, 19 Apr 2023 14:28:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 2/5] arm64: dts: ti: k3-am65*: Drop bootargs
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Tero Kristo <kristo@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20230418165212.1456415-1-nm@ti.com>
 <20230418165212.1456415-3-nm@ti.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230418165212.1456415-3-nm@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0P190CA0004.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3682:EE_
X-MS-Office365-Filtering-Correlation-Id: 733f2dba-9409-42ad-968f-08db40d19238
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KKF1OQ8hbc3Ai9YPB3PeaBqA/5uiilk/8ene1H7njhXDgbqBbIa2CSkD9lXA18DvjDraqM05JnU8EAetvfnUxqnMLOO+Ln0fNMTxZQ4YVHIGLUeEISU1Nr20OuENhscS6l7vi5rU/FUKMhB9lBGo1UyHl14ArImBU7E3jnP3wpB4GAxEx4nB4XNGH3MRvgSsn2vlABEhLZwdkhZKDci1Lh4uvBJG7sbyoZ5x1jgsTFNswgrzXUgqXt+vZa9cghmAHmIEE7XAjd14DslblX7K3bQbHHxA9x++n4n59bV19tSQ0SzOY6k53pNFYYNtIVBDG3lmra/xV36ewGw1T7lZ3uPErYXgm7DQv8PucltE1817YUYC6AAQQkI+WlJObOmKypajDPOQPyubOaAXNNwWhKvvvrD2n10m3PK2goAb60HbO6vJXo392w9jjBT+mjScH1HU+1HT61q6I6LmmvkiItNB3V7REmw7KAOi97ZP56THA2Zp9vE4U+qlauOyIrgZN51+CMPfuyCiav6+4IVOAfPsaOQvfGyf4AK/Gbc74MvUd1m8LIt5OIxNfYZYs621bmRWMxCmI6D+KMO7Nvc5D6fg2edHDv4vU5lsQRS4Imw5pnHFmwx6D/wmES5gi5mflCGlG2RW8O8v2kNVn2U23w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(396003)(346002)(366004)(451199021)(478600001)(4326008)(316002)(6666004)(6486002)(41300700001)(66476007)(66946007)(66556008)(54906003)(110136005)(36756003)(38100700002)(5660300002)(8936002)(8676002)(44832011)(83380400001)(2616005)(31686004)(186003)(6506007)(26005)(6512007)(86362001)(53546011)(31696002)(966005)(2906002)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkZobG9ZSnhSeE1jTDZ3WVFQaG5FV1dwUVh0N0RDYkZRKzhyYjJENEU0ZFA1?=
 =?utf-8?B?cjhHTC84ZEpkWEpGbDk1WjJkT0tGYloxazh1TnF3d2plbXJsOWthR25SQURR?=
 =?utf-8?B?UDJQNm9kMmxTS1BDQTdVN1poTjVyYm9MN1FEbG9sVXNVeGpJSkNRUXJackNw?=
 =?utf-8?B?aWFISnpHRHQ3cG9RazdWcHhlcDRBWmh0bEZ4SVJBcHZXMGF4OVhzSlR0Qmx2?=
 =?utf-8?B?TXdhYmhYdEsvNEJCbVBaUHVJQ0hnWlMvTWMzSjlTRzJzTG5MZkoyT3VtK29B?=
 =?utf-8?B?MlAyaUI1WU4xZjRzNDI2R0VxaXVEVk4zU1RrRnBpVFE2Qi8zcVFXM2taVFEy?=
 =?utf-8?B?YTU3SlBvT1VmVDZkVzE3N2dDdE5ObkVHWS9EUlc0OG0xekpzc0k4cTJxUmJa?=
 =?utf-8?B?MkU5MkZXUkZidG00R1hzQU9YaUhEZWdqeTdzalROb2hzNFpZVGxIZksyS01J?=
 =?utf-8?B?TlNtUkIvMEp0U2FreEtDR2d5R0dYbmZ4ZjN3Mm15a0lLejY1VFpqNEI2VmQx?=
 =?utf-8?B?dmk5ZXpPaDFVWEtiLzZlL2Y5OGVTSEVVd2FiVHd5a0NrNGRNRHNrT3FhQ2lY?=
 =?utf-8?B?cWlKM0RBTnRZL0laVUVyckZyZ1g5MUN2cTVVdXVIQTBvMU0rOTdrWFdqdkVo?=
 =?utf-8?B?TWZJK2JONU1nYVk1THBlZmdVQno5TGY0T09MczhESXpYRFptNzZ5eWNqSndS?=
 =?utf-8?B?TExLNGZ3VU0xTHdhbmhQTy9YQy84ZmVlNzZoWWZxdVVKZytnU1lPL3pXRy9v?=
 =?utf-8?B?STg1RGtydVo3RjBnNHoxcnZ3VzhzLzEvelpiVGh1R3FTWGdXZFlDTkxQTkw4?=
 =?utf-8?B?bkNrbEtmbDVOcUJ5bmxHNmhPREloc3dYTlNYc0QvTmZVdkZyKzduTC9RTFdj?=
 =?utf-8?B?ZWRmeHJ3Vko2OTVBYWVncUhiTC9abDNkcktUdVJyUjVyU2l6YlNrL1oyY08v?=
 =?utf-8?B?ZTEwWHFWZG1KY3JGQ08xTDVjaUkzYVBPU0daZ2tmMUNZWXVOZmhzcFp5YWV6?=
 =?utf-8?B?RmlrZXhVVTlPQmhTVzRPZEF6RjhTaTc2MUlVYmZ2M3N1YndtNkhVbThvYmE4?=
 =?utf-8?B?dXZCY0xNdWIxRFhSTVdoMkdVU2FRSWRrcWorcWo3ckNNN3RYMWJ0V3JnY2ky?=
 =?utf-8?B?V09RVXVSUnVCemFxMFhrdHBOUS85cDQ4RUdWTFYrSm9pVHc1SHlCWUo0V1hX?=
 =?utf-8?B?cG0xT3R0WGdKRDQvbEhOcnJybEx6VWF0cWNmOUpkcDNjS3Q0Tkg1akI3WDRP?=
 =?utf-8?B?Nk9DY0thS09hbHJENFRHZit6NEd4QlJLM1BkNG5ZUmxnOGVsR0x1R3FzdFBk?=
 =?utf-8?B?RzhyR1k5SE5vNDI5VkF2QkxRL1lYTlRLWldhOWlIWWZ1bFR3THpWLyt1NGp4?=
 =?utf-8?B?TFRmUDgyUmJHcEkvMzZOSkEyY3RrWE9VSUxqaXBoSWpFVEZLY0p0d3pHRjZU?=
 =?utf-8?B?UHNGSFl2eGg5dDN4N0JDdWVRYnFjTkZrWEF1bElBeDI2UHBQKzVxL2dNWkxH?=
 =?utf-8?B?NmxOcm82OEtUSmxGT1lwdk05MEhhbVhIZWVnWVJtNzJOMnlOTC96MG5hZk5p?=
 =?utf-8?B?Y216aE14K2VHM3pibU5uSDNTdEw3OHVMcUk3TkNIMUFmSTc4Y2lPUEtMRUs1?=
 =?utf-8?B?bTR2eU93YUpMMTdxTGFSVUhsY01lMVZwRHVNT2ZmWDBzL0l0eEJKNzVqdHNp?=
 =?utf-8?B?NFFvbFlsTzR4ZU5rUG1iclJhMFl1MVI5SHdSbGhTSmhaRlhEdDRsRURHR2lU?=
 =?utf-8?B?ZzRQcEd3YVJMb1NKZ3ptVVRQMWNPek5Rd0h6OGVvUXU5cXRmK0o2dzBQZks5?=
 =?utf-8?B?dE93c2Fvc2lUM1g1UG5GUTNUczl6bkNQcG13THd5Vk9SVnhEN0hQN1hLNDIz?=
 =?utf-8?B?QzNMbUhHMGZuNlh4NXg4bG9XZFRneFF2L0xzeXEyMGdlUm93YUJPRWtCV3ZH?=
 =?utf-8?B?cyt0Wi9yb3NRWGVCcXJSd2dPRTFHaENGVll4RHlvSzFndGxkNGhoVlZya2Vr?=
 =?utf-8?B?NGZnWjBFSkR6ZUxZejRLMEtLTEpHd04yZWNlZXlWOHMvTHpmZHgzbDhIVVp0?=
 =?utf-8?B?YnpNUHdqTldJQmZ5RjFVbTlrRmlqZy9oclBNSURla3hTWUFscnJIaFIxSUQz?=
 =?utf-8?Q?cRwfjW1ovweMDxXucVxFyaSM1?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 733f2dba-9409-42ad-968f-08db40d19238
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 12:28:25.0433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LsLKNSszQ9kukcucrEuqWgLN3i4cyx/gh0QPcuHt2tpr1gT2IBi/mmKHJCsKvEJEuzv0Xjhkm2Z/nxcDoYshvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3682
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.04.23 18:52, Nishanth Menon wrote:
> Drop bootargs from the dts
> 

No reasoning provided, apparently also in the other patches of this
series. Given that these DTS here are not the last ones using bootargs
in upstream, that seems reasonable to state here.

Jan

> Cc: Jan Kiszka <jan.kiszka@siemens.com>
> Link: https://lore.kernel.org/linux-arm-kernel/81134eb9-2b7d-05bc-3035-a47f020861a8@linaro.org/
> Suggested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi | 1 -
>  arch/arm64/boot/dts/ti/k3-am654-base-board.dts     | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
> index 96ac2b476b11..7d256a1638ff 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
> @@ -21,7 +21,6 @@ aliases {
>  
>  	chosen {
>  		stdout-path = "serial3:115200n8";
> -		bootargs = "earlycon=ns16550a,mmio32,0x02810000";
>  	};
>  
>  	reserved-memory {
> diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> index 592ab2b54cb3..0d6fc89eba7a 100644
> --- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> @@ -15,7 +15,6 @@ / {
>  
>  	chosen {
>  		stdout-path = "serial2:115200n8";
> -		bootargs = "earlycon=ns16550a,mmio32,0x02800000";
>  	};
>  
>  	memory@80000000 {

-- 
Siemens AG, Technology
Competence Center Embedded Linux

