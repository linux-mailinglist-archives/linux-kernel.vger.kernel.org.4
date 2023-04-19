Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF6C6E7ABF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 15:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233481AbjDSN3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 09:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbjDSN3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 09:29:46 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2052.outbound.protection.outlook.com [40.92.53.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527721544C;
        Wed, 19 Apr 2023 06:29:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MwkaxYNHukXj7gbfaBaV2Qh04a+NAZbLgAQcsWP9aDkwCvlpQAsUexhx63DBP+Ul2cW6BD6rRBNSyXKfCU2P4oVFR+Axzx8Gap7lI3yw0gxXr5HuvO25fIL1v9MtKELpxPXXDkIyBapplv3/q4BbYqvkKDrhgnytBUQo3Eknr0RzPAGwgbbveZmJ31h3AGAEmo/VOav/jxZCj6Wv+THTSpKfQ5fPTY/5MGis1yxUA+6E98zfQLTAeoHzXfVDhEVa+B8vTX1zBZO30knGu3O4b1tnxzxcySNmqHc0VrjzN3VQouOTz6+1mcdCsptWiBbpXomWmg2lx8gSJr+7JuLjGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=33GUqICiCnkF6JRlgP5XU19Spt09i0olFYBr0mpwcFA=;
 b=iTA0UU0SCMSmHBg3oACh3PG1WA9c47coOTpsjrNRTE9vhOse6RJR73kh/BlZT7NONqp+Lq2FunNtAq3Y+rCv2KBT4af0qQWKjyAjzNuNggri7I4HnaX0KG+vFY4vcmnKAmeu6qpxrFwEM8c8zP82spHsTrrb4dGxJaOkFeEPYlFTNkuAif5htp7HDMNmXVqpDqciEapi82RfEe873qgSh8k8bfFOHzR9CCCLhHgPpj3So60vqzory5AJ0Xfx4qYq0Imt2UJgzSvRfzZMTjtopsAm8NbaG4c/U5utEYFhZR1/BWCHXyr0xJUtYHzgDI0m7GBRFVtkRyntFv7wy9jczA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=33GUqICiCnkF6JRlgP5XU19Spt09i0olFYBr0mpwcFA=;
 b=LenzCRyItFX1/vGqrvubQDZXRIdUIASGDGGNBSLn0wp9dQrP4ytIjCUhrN/0SiGrg4nQu2opM9Qki4YElIpOeYh3y6bla+/1WbGAswDFd5j4Ytnkrv4kmruA38a8FRf+Chn6yuLNaKQ7JdYY/t+SDOHTbGc8xcgEo/Qs5zbYVNEbrOeRItxRviPG3lgdOfWl47iujsgy44P1Vow+GsRkaAUFgnsg9PFREFXHb6l7ZisHmrcOupfwyEqsU8MKp5ez1e6rgVeILWmHczUi0/HDjx6u7gwxBTFbU8+6kRFJq3Oqaxt1Nn+QChXHnaNX5FZtjOn6rX1PgWsNtHXQh3PliA==
Received: from TYZPR04MB6321.apcprd04.prod.outlook.com (2603:1096:400:28a::14)
 by TYZPR04MB6428.apcprd04.prod.outlook.com (2603:1096:400:28e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Wed, 19 Apr
 2023 13:28:37 +0000
Received: from TYZPR04MB6321.apcprd04.prod.outlook.com
 ([fe80::4705:d219:7cf0:46f4]) by TYZPR04MB6321.apcprd04.prod.outlook.com
 ([fe80::4705:d219:7cf0:46f4%3]) with mapi id 15.20.6298.045; Wed, 19 Apr 2023
 13:28:37 +0000
Message-ID: <TYZPR04MB6321F7B16354AD78B491C20096629@TYZPR04MB6321.apcprd04.prod.outlook.com>
Date:   Wed, 19 Apr 2023 21:28:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH RFC v4 0/4] mmc: add support for the dw-mmc controller on
 Hi3798MV200
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     tianshuliang <tianshuliang@hisilicon.com>,
        Jiancheng Xue <xuejiancheng@hisilicon.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        David Yang <mmyangfl@gmail.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230415-mmc-hi3798mv200-v4-0-44096e187f53@outlook.com>
Content-Language: en-US
From:   Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <20230415-mmc-hi3798mv200-v4-0-44096e187f53@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN:  [ZwYAkDZUZNeEqZ90XtI4mprkTeL4Yp9tmoR4x4y2bXXXWqMYHCtohU5CNpWAudCe]
X-ClientProxiedBy: SJ0PR03CA0208.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::33) To TYZPR04MB6321.apcprd04.prod.outlook.com
 (2603:1096:400:28a::14)
X-Microsoft-Original-Message-ID: <3cd40781-fd8b-c9c8-e8e6-ffc6b274a31e@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR04MB6321:EE_|TYZPR04MB6428:EE_
X-MS-Office365-Filtering-Correlation-Id: 39d18946-109b-4b26-d3f4-08db40d9fb85
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aUcBwpMdV+nT2YNhfEb0z7O5K1ab0zSqcYfBLX7O3N3ySOQnEWRa00ecjANREd6haQHhaLW+CPoKYpcq/7BAfkrBEzdGfZGNYplphurELqvnS9NgcCf6+Ll1TseLZEKn9nq6jouPTFQnH4+1erD8WSx4YjbAcEafyEoKVbVFCnIPpR7MRnpLrOmeE6NYfIYeLX2hBuVP2rkl0WmZeNAtq7wO/vloDcAxLjV2LJZg2h9LN98TOnInsMge8lx64GX96seIuItv8KkushAIMbpdVzKy2+JmHjXPcySD1c/q4ZTjcKu7J9WMWOgNJqULaBj/D3orJZ2i1w2kSQ29fSslt2LK9wiUS8sfggAZhyU9ghLF7aytk2+jnSSh2VzNEukHfPDF3xyFlWOgBDR5KqKxnkkWzAaZt0XL4bwkoSq55/QJZSkVfyTMgd5fyXyeWfxuuZhKX4ysMZaMRiNZIH3ntNR9QdWb4naBbTC+LdlsqU5Op1LLOVzEuLiQMadhCEOCciyRz0BJnKbwkakbE2ewh/BDXAFMkFUMmsDYoIea5Ee+Vlm77ZlTkbWV6q/anhBv5wYrxe9xdp71UMRvWpcofi7l2mIFHPlIMaMYR3GNh5d34thgYk+5YgPB2UR8jjUcCByGFzzlwZv9VKvyocsYpw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDR3YW81dDRJZU9iYTcyUEJZTFZRRllrZzFjZU1UWS8yb0JYMzlLZ1ZMcTdS?=
 =?utf-8?B?THVRUUZtNzVCZXFjdHZMMGROMmdzdFUzb3BGQXlLUEJJaTVXNDJpR3BKS0Zz?=
 =?utf-8?B?UjNVQ1pzQXBOdG02L1dQemxqM3FKQnhXSUd0UU1keWhJL1NWYnNjR21LdC9J?=
 =?utf-8?B?U0NxZGNRMFFkZ1U0ajFKVUthYXREelNNM2pybWdxdXBhMlBrYVNoQ1JFQ2gw?=
 =?utf-8?B?NEtNTFJRT2dKSktyQmR6NDVZeUdFMXBLeE51UHpNZUhGWlRqOEM1WlIvWUtQ?=
 =?utf-8?B?OEllN3pZZ1g0OENUSWNwcHRQYjRHM0M1Y2FTMy9LSXMyOUVDbWxlcVJQWjlV?=
 =?utf-8?B?QThzbHJiZmhXNi9uV0xFTHFreS84SFZsY3EyVnZIQy9Edk45S2ZxVnhxUVpX?=
 =?utf-8?B?RUZCMXFoekEwWm9vbGdRU3p1L3ZNR211VGxiQU1RdXZIMzVKdGY0ME9ES3N0?=
 =?utf-8?B?RE1zZmxKM2VKT2JhZW1GVERQaWtuMDZqemlyWisrTXFNb0lnSmFoYklZMElN?=
 =?utf-8?B?YW1uV0xiN1ZxQzNYeXZLb3RTS1Nnc3JKYmtJSHhEd2xTUXVnNWdEV21RTWxK?=
 =?utf-8?B?ejJEQ3lwbCs3ZlgzYVU3NXhocmdjeEJqRDBVVE5WR29CZXg5SDM1dG5UMUFn?=
 =?utf-8?B?VFUwaHdiMkpRWGxRb3FSd1N6Q3BXQjRPbTlWVnYwRHRuRS84Ui83bHNQMTVL?=
 =?utf-8?B?WlFIV1VwWWFDZHFGNy9ZUGF0VDEwN1FLVThhamxjUTV6TG5xa005aHYxRllP?=
 =?utf-8?B?RithWnNIR2QvY2NLTnJWenllU2FDcktLYWsyTys0WWZmMUF6QVhsSmJZOWlr?=
 =?utf-8?B?QjlMemUydk9acytCaThoL0tjcm96NjdVNUs0Mmt0VXhHdGNEOFNoSVlQSVlw?=
 =?utf-8?B?dXdFTkR5cUpPWHZYbUJ3S2k0NWNzaGtOVlEzdzArY05zYnZoOHh4NUNaVXVM?=
 =?utf-8?B?UHJ4SkdmQURWcW92bW0rZXlXbUZUSGFDVjJpR3lLdjFNUnl1YVk5MldRQXA5?=
 =?utf-8?B?TW1TMGNWREQyQTNMaEJrckpjalRFYjhRb3dSdFhHTVgrTGxkNXI4RWRFTWJ0?=
 =?utf-8?B?ZFMvMmEzR0dHd2MvK3M2ZDRHMGxVMTVRVW0vSHh6Nzg0d3dRWGtTM2VYejZz?=
 =?utf-8?B?VnhsdGNJRlF6UHRoTmU4bFhEcWRKbHJWMkM1Zm1jc1UyTlhyNEtUbmxacE5h?=
 =?utf-8?B?TFBuOGhJL1l5OVNOZzh1ZXJ4c3RNeWI5Y3p6amxkdDF5d213N0NDcU1JMG1X?=
 =?utf-8?B?WmQyVlVFRkRsRjIwak5RNHhDY1pyeFJndHFZRUZwOW14YTBQM3pTbVQ5ODA2?=
 =?utf-8?B?Unc0cVZMVnF5bGUraEhqcS9vRXVkNnNkSm9FR2dTbkRQMWhlNmJ3aEpGWDF1?=
 =?utf-8?B?MDUwNlFBRjFLME1wcXdGMTU2b0NtamUzYmlXamVDa0x6UndpSDJ3TmhxVUxG?=
 =?utf-8?B?V1NUbS9GUDdkUThPVXdvVXVkak5MMktnSWo2dXZXQnJUZ3NsZGM0ZzU0dVdZ?=
 =?utf-8?B?SFZSMzNQT1kvSVZMb05Tc0grQ1JCTW11a0tTOGkwNTA2cXJZcGdkQThEWWdF?=
 =?utf-8?B?Q202T2dkcTQ0d2tDQlhPY2ZNYVNIdGZBRTRRUHM4THJVMnpQTUZUWFdzZWZG?=
 =?utf-8?B?ZXUvZExzQjNqRW9wK0hDMEc4c1FPS29IMUNXTDA5Z2VpZzNkZVVuR1hMS1dQ?=
 =?utf-8?B?RXZEdi9idFgzRFRMZTc3dWorOFh5eCt6eXZ4S3RYUWVEMnVHUVRkcGRlQmxX?=
 =?utf-8?Q?wo3gTDWHAyoT+JyHdw=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39d18946-109b-4b26-d3f4-08db40d9fb85
X-MS-Exchange-CrossTenant-AuthSource: TYZPR04MB6321.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 13:28:37.8756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB6428
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/16/2023 5:19 PM, Yang Xiwen via B4 Relay wrote:
> The dw-mmc controller found on Hi3798MV200 is like the one found on
> Hi3798CV200, but has some tweaks.
> Also refreshed the dt-binding and converted it to YAML.
> 
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
> Changes in v4:
> - fix license of dt-binding document.
> - some other fixes to dt-binding document.
> - Link to v3: https://lore.kernel.org/r/20230415-mmc-hi3798mv200-v3-0-00e2368c0709@outlook.com
> 
> Changes in v3:
> - split dt-binding commit into 2 parts, one for renaming, the other for
>   new compatible string.
> - some other fixes to dt-binding document.
> - Link to v2: https://lore.kernel.org/r/20230415-mmc-hi3798mv200-v2-0-1d274f9b71da@outlook.com
> 
> Changes in v2:
> - add DDR52 support
> - edit dt-binding, substitude all hi3798cv200 with histb
> - send email to more people
> - Link to v1: https://lore.kernel.org/r/20230415-mmc-hi3798mv200-v1-0-db5b91d939d4@outlook.com
> 
> ---
> Yang Xiwen (4):
>       mmc: dw_mmc: hi3798cv200: rename to dw_mmc-histb
>       mmc: dw_mmc: histb: add support for hi3798mv200
>       dt-binding: mmc: hi3798cv200-dw-mshc: convert to YAML and rename to histb-dw-mshc
>       dt-binding: mmc: histb-dw-mshc: Add Hi3798MV200 compatible string
> 
>  .../bindings/mmc/hi3798cv200-dw-mshc.txt           |  40 ---
>  .../bindings/mmc/hisilicon,histb-dw-mshc.yaml      |  93 ++++++
>  drivers/mmc/host/Kconfig                           |   8 +-
>  drivers/mmc/host/Makefile                          |   2 +-
>  drivers/mmc/host/dw_mmc-hi3798cv200.c              | 206 -------------
>  drivers/mmc/host/dw_mmc-histb.c                    | 339 +++++++++++++++++++++
>  6 files changed, 437 insertions(+), 251 deletions(-)
> ---
> base-commit: 76f598ba7d8e2bfb4855b5298caedd5af0c374a8
> change-id: 20230415-mmc-hi3798mv200-ce15e9b96866
> 
> Best regards,
Sorry for wasting your time, but please don't review this patchset
anymore. I decided to rewrite it.
-- 
Best regards,
Yang Xiwen

