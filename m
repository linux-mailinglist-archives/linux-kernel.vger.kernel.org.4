Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82DD07006B3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 13:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241108AbjELLYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 07:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240162AbjELLYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 07:24:37 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2056.outbound.protection.outlook.com [40.107.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AF2BD;
        Fri, 12 May 2023 04:24:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aK3kiEHZEyM208l7aH79rNWcKo1TZG5S0hPri5QhJpbJO3SFPqI/gugFJDEgdd/7TF2S+pToElUOi6JafHFCzMoQxv5UNOWtNB1TCj+IR2DOPvNAQ39ZV653Yj6ZHi8S7fGjXnoPocCxEEADx1p6VxEJ2mioQwos8wprVaq74D6sAEniN6drBehPV0CRo2cY2sd8lq/PCezWKcUnZxOo8MILKVz5HNOJKJDW6j6Pvgob101SPlIAut0HitlnTTb+AJRE4rHlzve9Q75ZPnE2rIKkfyaBX6ZPZsBF5NDLQH4AelPMC/zHJQYmxXdpbV3yhNMO86FaeFTSBVKCLF/WXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SomTogk90u0tBmuXe7zke3jCXDudDWOApikHsZi13ss=;
 b=DXMest41SM1amWKVanyvzouPconY/HKszeUDTt8UEgDbq8OC4Vym2cfeZUf5IPyIsvWp92iJpFt37WFxeoWDi5VfkcGVSb2DTm6/TH36p+fQXKUo5KfyjBbDTs+WQSAmjU4b+nF+gJ+NoxgKG/aSeag24yYEgLIUoJnj+ruIVxhmeQ7BhjYDy3aH2jKkTRgG3fDw8enWzx3T/jxL9zCl7ZORdTMS99epHJwCOp3KSei58csYqdqwkVJbPuTG3yirtwAeN4T5V+JOrPYk4KPf8YaM9DCLkW8OuRwNSpQ8pnZAGp5KD/mpd6M6ubep9qwNIGLI+qiSY3L/E9mmLYMHIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SomTogk90u0tBmuXe7zke3jCXDudDWOApikHsZi13ss=;
 b=vScipHKyQHwhIc0r7gwTpzA7tSkhqUoJedb7tnIYRXR0KvaXehseMtV9gEPKW252lzI1PEfekO/3YPRESFK/+kJfERJci9hPY22G+AZ/38UiN1zcea0NDG8SKro2eTpJ+jQuQhLDMH1e4PWrNjqSlfGGkIEQrHDLePI2ahtEz9E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by BY5PR12MB4161.namprd12.prod.outlook.com (2603:10b6:a03:209::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.24; Fri, 12 May
 2023 11:24:33 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::e78e:b7da:7b9a:a578]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::e78e:b7da:7b9a:a578%4]) with mapi id 15.20.6387.022; Fri, 12 May 2023
 11:24:33 +0000
Message-ID: <e77bb07f-57ba-1992-c96f-423c74702f89@amd.com>
Date:   Fri, 12 May 2023 13:24:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: xilinx: Change zc1275 board name
 to zcu1275
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <4ba0eb85629ec5f07902a93fb75d13fff9697eb8.1683099606.git.michal.simek@amd.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <4ba0eb85629ec5f07902a93fb75d13fff9697eb8.1683099606.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR08CA0019.eurprd08.prod.outlook.com
 (2603:10a6:803:104::32) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|BY5PR12MB4161:EE_
X-MS-Office365-Filtering-Correlation-Id: 042c8b17-1a11-4d67-b5ac-08db52db7607
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xs9ziVNO6Yn/HHgiqReE13IgXRY8zszPpuO5i5AVp8cONzZ5pYLkMYX9zbxA8jUWLSndW5CVlMAedAxHgbPx+Oz4OnkMlMDr+RgM5+BZHZBdgbCgir/Do733pKK9fVQ40aDDYWX917JaeIaZVh77oTWRG+Xnaygfgqevue63/2zsqHbKYCvms1QpEve5cBDAhkDA2rAI991PLinTsXKdQrpmtUEfZklu9iyDU5Io1nWedWzrrQvN6//8ZgTsA9Dx5aFXPFmZPNOHZ0IIZkCDCPJG27FaXL0QW6ZCRfTxVAZ4n5fd39uh3jLTKCCIxoyGw1RPW1CNxXVGXSLrAVdQxoqIbEJwTlNzbwNnQ4tlRjsiin/BwEeqiqQCC5U3VnR46ak6hruL9XT9Q38MKStfiaVPNc/LlroVpHZW6OuZZoXSE+9zCYICylz8tiP7AKxOb79lSxdEt/bIQDSeR2ZjfFhRI1F3T6zchlKrA3izSqbIjDAdvpIO2oiUa0xZYiGVP/gaXs5zv4yL/olBF/mcho6r8REUij4PusoA/EB/s2FHG3ycWjlSco9ZHXGxRs6WfXrkYJTxHrjfCqc5QwivCrJSZYAT6g0tIoNfCYGHqLjty68JM+7MT+gPrPLhPISyWo1i/f8XghAGjThZEA3l3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(451199021)(38100700002)(36756003)(86362001)(31696002)(31686004)(6486002)(8936002)(8676002)(44832011)(5660300002)(478600001)(6506007)(6512007)(26005)(186003)(2616005)(2906002)(53546011)(83380400001)(316002)(66946007)(66476007)(66556008)(6666004)(54906003)(41300700001)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXpSanJwUWVROWxScWJMSTJ3TGFOYStjbDZDejhCRFhzdFVDOXl2UngydEV3?=
 =?utf-8?B?WnlFWVU3YVE4dHc4VlM4ZmhRaVBTQmNzeCtyUGNqdlZ2SU15TC9zNUtFellz?=
 =?utf-8?B?eW42TEJlUFZjdWF4eXFNY3haaDZKelRvYUZDMkdXc2NmaVdxN0VuaUFuKzFu?=
 =?utf-8?B?bGkrL1hvYlAxYnNJWjUvbzQ4dTdncS9TZ0Q0V1E1ZDl3Y0dhWEhuT1ZDSUVN?=
 =?utf-8?B?N2NhWGl5RGJRRnBnOEpUakxVVlY1YVVtYVY2emJ1THBQOHQyd3dld3E2cHYr?=
 =?utf-8?B?c2xXVDZNVXQxdnZLNWRicE9mSVdHL1RWaXh1UTVYMFg1TVlSaUdWR2ZRbTBs?=
 =?utf-8?B?NmUwcmR6enl3SlVrSW9WRi82ejhGaVIxUnFESnEvdGhkeThtRWNwWXg5RWR0?=
 =?utf-8?B?YlpYem8vdUZwbktpWjRrdVdNejhPQ1orUmZESkRoU1pObllIeDFxeXlMSWFB?=
 =?utf-8?B?OUtCb2NpTHVud2VQOC9Mby83OU42a2ltWXRYOFNoS0p1eWliODBobjRHWmJK?=
 =?utf-8?B?ZEZDRVcwNzh3REhFNTgrU1NEcFVPTEhBZU1Ydk1BMk12ZDVVVFRCb2xJSnVp?=
 =?utf-8?B?YXlqWDR6cHptNHJvU3VuV2xBY0xvR0dhV0JCc0tlelFIOG5pSW5pM3R4LzJw?=
 =?utf-8?B?OXhObzI4Z2NHUXpibnovck54QXVteE5kS1hJcGwzK29TcDNsckEwVEh0Uk5C?=
 =?utf-8?B?Y1hndC93VWlkdERCRUFGRWNRMWQza1JRcGJOa21YSVBkRSt4WWtTbGt6VkY3?=
 =?utf-8?B?WFZRZG5vV2x3eGJrbVZ2cExPWVBUQlBZSllETkVTOEwwMUJqZG9nRWJxcFR2?=
 =?utf-8?B?NzRjekM0Z3hmTlR4eWJyblkyVVp0cytsVkpuZDd2SXlCV2MzZWY1QlVNb3da?=
 =?utf-8?B?NUJYVmFJYkhKYlF0QVJzL055RTJ3MzhwY3JZWjdFNUZlbUV6RXh0QXlaNVI4?=
 =?utf-8?B?bC93OGN0QUNDRjZ6Znh6VVJocHdCZHN5WG1BRDI5MlRMVGJ2czNXZ1JETjdF?=
 =?utf-8?B?Y1dGOERWQ0FLTkh1S1RNdndGSU03VFlTMGY3RGpqcUJtN3VTcjlyUHlXbVk1?=
 =?utf-8?B?NVlXbWtYZmxHM3d6dlIzd0tZRk41Q2VXM0VZd1lXVmNqOGg3MnFRZjVjL1dw?=
 =?utf-8?B?WkdOZjJEUndTNmFKNnhiYy9oVEFHQUFrcGM1d1NuMFJiaHZWZFB6UFZEcjFR?=
 =?utf-8?B?cDNlSS9PWmhXM1pISHc5M29WTm5zZ3ZCY1NnZVNPSFFBSU5KUlgyV29YaXN0?=
 =?utf-8?B?RkJLcFd1U05TN0h5TndCWGM2Q1NXbGczcVQ0aWxFMnRKUW91Yjk4K2xUQmdF?=
 =?utf-8?B?NnlCVXdYMnNIdDVzVzZIZzhRU3BjM2xqMW1FTWZxbWtvN0ZCWjBxdDhzR2Zp?=
 =?utf-8?B?SWFSQ2VEK1lrTHRtMm85RWVxS2dKRXFJSjZQQnZyTHY2Y0JrSzhhUEFPaFJm?=
 =?utf-8?B?eTdvSi93SEZnS2dwTDg5bHB1YldHUWxPdFUxa0ZJM0hCWmtoVldKQWZHR3Js?=
 =?utf-8?B?cDd5S2VqSnB3TnFaSUV3RDhobzJuNTg1V2x3eXIwS0hJZ3ZSUS85cEJ6ZWNM?=
 =?utf-8?B?YVlkOXhnWFlEeFFYT09OZEExZ1RWa3NNK2k3ZnZqcS84ODBFS1ZDRXRYL2d5?=
 =?utf-8?B?bkpzWHRNTFgvYitsdXE0N3BEWDd3SXhxME1LL1RmNDhSd3hzQVZyUm9VdVI2?=
 =?utf-8?B?YWtFejNCb2w3aXk4Q1N5U3RkOGlDdVdXYXBaTnMyWVcvWUdFdlB1QndDVGVm?=
 =?utf-8?B?cTQxY1EvTWhDTFMzallrRm1yaUppOTlha1FoQ2lxT0FUN095NFM0RVBHMEZJ?=
 =?utf-8?B?bjdZU1ZVV0w1ZUpCYnQ2UnFOZU5NRkVCcjZNam45d3RUd0xScXZFTmF3TWc0?=
 =?utf-8?B?ZndkU3ZFRXZkVWM5T3Z0dnBxSlRZUlBURDgzYXhlS2pmdTFIQUN6VU9mUmc2?=
 =?utf-8?B?aVN3eW4rbXAvZmhFdGlFeXNscW1mblU1ZmNaelA2cHFwZzFxYmZoa0FFVnlk?=
 =?utf-8?B?dW83TnpjbGlaMjV2dUZRU3ZLb3VrbUxDb2E5ZkpoUFZrMVh1NkZaNE9BMmg0?=
 =?utf-8?B?SXh3b0puTlh0clptNXgwY3IxYnNEY3FYWUJBVURRNlVXR0hwczJHeWFsOU9h?=
 =?utf-8?Q?vW8/4omYwgOktRO0Oz2ZjaJvb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 042c8b17-1a11-4d67-b5ac-08db52db7607
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 11:24:33.6337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eIqzxZZEwrQtwtAv4ckk7p0A3oW+pf28nAnGGIIxzvKONzgqVClhtW4EqNyEGFRD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4161
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/3/23 09:40, Michal Simek wrote:
> Internal board zc1275 was released also to public which ends up with adding
> missing 'u' to board name. Reflect this change by renaming DT files.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> Changes in v2:
> - Separate binding from DT/Makefile change - requested by Krzysztof
> 
>   Documentation/devicetree/bindings/arm/xilinx.yaml | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/xilinx.yaml b/Documentation/devicetree/bindings/arm/xilinx.yaml
> index 969cfe6dc434..b3071d10ea65 100644
> --- a/Documentation/devicetree/bindings/arm/xilinx.yaml
> +++ b/Documentation/devicetree/bindings/arm/xilinx.yaml
> @@ -61,10 +61,10 @@ properties:
>             - const: xlnx,zynqmp-zc1254
>             - const: xlnx,zynqmp
>   
> -      - description: Xilinx internal board zc1275
> +      - description: Xilinx evaluation board zcu1275
>           items:
> -          - const: xlnx,zynqmp-zc1275-revA
> -          - const: xlnx,zynqmp-zc1275
> +          - const: xlnx,zynqmp-zcu1275-revA
> +          - const: xlnx,zynqmp-zcu1275
>             - const: xlnx,zynqmp
>   
>         - description: Xilinx 96boards compatible board zcu100

Applied.
M
