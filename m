Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF424612C1D
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 18:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiJ3R6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 13:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJ3R62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 13:58:28 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C84B4AD;
        Sun, 30 Oct 2022 10:58:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oO//KnHPkHJZvqir5mURJq+wyOmQVhONcvoSaDyLRPwN3Z5k/675ERh4G+QYaXaay84bBrIykx4+zlTe3GTinocZ3AMM2VjhkLBtm0/SZQHuZiRDhxsENEtANIH7zer/aSIKj3QO2DiyPnxkF8B6cbYlV/g5YW+uMJ2/luzA+sPOCS5/UcUstMkPKlLYmpADzIkT0e13v6Vb2XDRXqrehoEPzNMebjU6wLRjfCw2AG/Y+/wyFX+6B7Q/iS27l0StF/M5aziJPAp5UPs2u7NvZZWbBeyYI9iXDYmWmJaZGWg9bVIUluoZ+7F4SPj9byTfPS37YJV0jcecqIh5z9Sdfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ymrdIUvifsC9KJtz12JKJio7OGAuPA89S+QssFEu820=;
 b=MKGDTRYvybCp1GNvL/2UHPZJdgPSXL50rmwerdyq5fEusMz8XUQIw3I3xLca8syMS2DacAoQ1ySszmFs12Ca19grMk+EJ1J3nuwaA9RSdou0y6GKFzsAEkSqIO0nOyhXBqyOSNC/Lp9aKi67mCdpO9En3HHsRINciFPHvOx/nEtAGX68HKyBem5osrNC3Y4EohQ2DYeXML2QcvZfDJdlbexrOgoF4/n4gKbBEiuD6T2sQ/gUgVDjzQjwK0Rws3louh9kmz9RdHZRq70tcS/RxJJ8ZddnOJtwYCtZReZ7TN4EVf2+g9bfz94Y7VKHti/aE3YqgeVekQTXVz8G7pAVOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ymrdIUvifsC9KJtz12JKJio7OGAuPA89S+QssFEu820=;
 b=zTzJCYmSPcFKkfiKpd5rI/RyeNGdgWpkp9H6xyS0Ov9m4+edERYeSVK04DlSougFH/v3bRJVkz23Z5WaUOUnKqNCTYZyP0yZAHF5RG/sHOp8RwyW2RRmfE9B1zx/f9yJEvKbrJppVrqH7bt+Ehq5wOGP8S7Bjrz40GNohYM30m8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3683.namprd12.prod.outlook.com (2603:10b6:a03:1a5::16)
 by DS7PR12MB5792.namprd12.prod.outlook.com (2603:10b6:8:77::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Sun, 30 Oct
 2022 17:58:24 +0000
Received: from BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::9886:d3ca:f03:18c6]) by BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::9886:d3ca:f03:18c6%3]) with mapi id 15.20.5769.018; Sun, 30 Oct 2022
 17:58:24 +0000
Message-ID: <0a9e9a6a-71f6-0cff-b7c5-9270273d7747@amd.com>
Date:   Sun, 30 Oct 2022 10:58:22 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH v5 3/3] remoteproc: Add AVM WASP driver
To:     Daniel Kestrel <kestrelseventyfour@gmail.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220804210806.4053-1-kestrelseventyfour@gmail.com>
 <20220804210806.4053-4-kestrelseventyfour@gmail.com>
Content-Language: en-US
From:   Tanmay Shah <tanmays@amd.com>
In-Reply-To: <20220804210806.4053-4-kestrelseventyfour@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR02CA0043.namprd02.prod.outlook.com
 (2603:10b6:a03:54::20) To BY5PR12MB3683.namprd12.prod.outlook.com
 (2603:10b6:a03:1a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3683:EE_|DS7PR12MB5792:EE_
X-MS-Office365-Filtering-Correlation-Id: b7e56311-63d8-436f-a225-08dabaa0569c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +v1poFTZQh3MQnUowS0LSUyLA+BEBXpJEtDD/+QoZTLPRDk8dlDPMv/F1JCJBYCoUfkrPKZYlNrMHlb+Js95cQ1wyx+4vKEIFy5ewhf/s1ZV6c5Y+x8fdk73MWCwnIvZUBbdq+A7H8pOo6kHD7Q2YYrwQGosHQz8xtV8RMg4YTN3bRTjIOCka3bLIMZEqun4yWWSdzZgaC4VOPVU4/5caYlJ8igsyDkE74j4fFERpFajwyRZFQdQchL6zmk34oKXoJoHYDYpIn0R0tMvm1d7Y1ugIzPBR8ghsGGG3CaXB33Nz481yCWltwryLfpt/KiURIrqubm/JKyp10c9xdkDa9uRCG+IFr4X3L6ZW9mjX2mVXqeUZWdqN7bcwo9uC4wKR5iuAtmdDs6i65JmqT0gxNf7F2A/GuURLGpk2s1t+aGJX5xBk2dufbF6gN5Pv/Ke4MmP4/Vc5ppSwGqEVSqoDw5QEzEixVOixtu46dKTlk0P0UHOesTngJ6lcGZ+XX8tTYCXplMgOE4vc+xM0KMH5svdLi6ZGjrJQ0LhVR/x2DX2era4LL0mbIjEJxrVcyHxDp7cTF91FnzcTMNSqAaluLUzrV7WrPgywQZIXS/IGbq8yRKWEsXdoYC+9IFT7bbtlpfQYFPY63WdBJdc/VIAQI97WMU4KTFfKbm+Cfi07y6ZwehkscCkjyuwq+5QpaUyQ5VTznr4EbfhduDKW3SAieQgQefOfBThr24mqQ8zpCk6yhQKtA6ippA5OgjEDDfNYQyyJlqYvKyHMUHVDOHsEaSIEXAW9k6Fng3uYlmwdS4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3683.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(376002)(39860400002)(346002)(396003)(451199015)(83380400001)(4326008)(66476007)(66556008)(66946007)(186003)(8676002)(2616005)(316002)(41300700001)(66574015)(2906002)(6512007)(6486002)(38100700002)(8936002)(478600001)(6916009)(54906003)(36756003)(6506007)(31686004)(53546011)(5660300002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUg4VCs1TkpFU1I4bDYrbU9yOTl4Skx4Wmo3ZGlUR0ZGbHNONVc4cjdhaUtj?=
 =?utf-8?B?UVYvV3JFVVpOdWRiTFo2NWcvb0k1WGw0SUZQMk5GRHlsNDE1a0xhc2VWSHlN?=
 =?utf-8?B?NjhaRkEyUmtVL2p0b0hZV3hqeENuNmw1eVZ4aGZvRHpnb2M1anl1L0ZleTU2?=
 =?utf-8?B?cVJoNlNPZ2xFRldiNFViNCtJTzAxZlJYMEFJaytXbm04Rmd2WWsrMmxXNGRo?=
 =?utf-8?B?RU9kcE4vdDVlV2hDYm8vVVBSaG56OGxocWZUQkJ4QVpSQktGaUZhY3pPNy94?=
 =?utf-8?B?U3Rvdm5ZR1VWS3lSOS8wdVNHYmhpUUVsbkIvOG9YS1kyVUxlSC9qZjdLbmtk?=
 =?utf-8?B?ckRhUWFFdmNGaFJnZ1NpOUkzMmFUL2ZYTElxc1J1bS9paDdsRmpIZm05T1Zs?=
 =?utf-8?B?cDFSMlYreXFXTWtjdlhzVGZna20wSDVoLytQZ2VqbURla2x3dm16QkFWSklZ?=
 =?utf-8?B?eHN6YjV2bmRLeXNrQWk5dklLT2EwL2ljajlsN3ZEamJwc3YyMFl1YVpUOUJ6?=
 =?utf-8?B?Y0gydGR0bS9ncm0yVUJ1RS9MSkxvQmdMaXpwU040bFBVWll4VkFoY2preGVS?=
 =?utf-8?B?NDQ0b04xSW1rQkdrVUZKVXJWNURJVmREcWxONVhJbGVRNmRHVzFHSnJVK09X?=
 =?utf-8?B?aWxSeFc0ZE5SRVVZZ1lZdDE2MUtWbU1xenZiTHVUdEMvQ242SndCUW1rNi92?=
 =?utf-8?B?YUszcXJLSHB6SDMvdWpzTFMzaldab2FYSmtzeGRlY1lzWDh4a01iTzBSRFJm?=
 =?utf-8?B?RGpjMk5XbjU4OHhuYTZJK0F5MUptNndSWlpTVjRwVG1MeFNySTBIOUtmSDhw?=
 =?utf-8?B?YUNUc1FxSlhBenFjc3ZhU295M2tpc014anY0ak1KZ05CenFDQmhrazd6eUVt?=
 =?utf-8?B?RzQrZS9tcVpmWnRqMk1zbGlJbFVTS1Y3VmtKTy85dWg0QkJ2MDFWK1I0Ly9T?=
 =?utf-8?B?NVhNMFB2dU14OUlqUzZ1M3h6V2hTVDZUVGw4ZU5KRjNYRGJ1RzlnVk14c1Vs?=
 =?utf-8?B?M2tJVDVBVXhLemF6SmNzaVBOeDZxRzd0UklSVisyQ3IxYUxLWEd6MW5iQ3Jt?=
 =?utf-8?B?R091TDdYTFpMaE1YeHZEeW1sTGNUWXp5eFVaUy9XV2Z2a1ZmWU1pSW5oRzFK?=
 =?utf-8?B?eEd4QUI0SVVHSVN5b3VpYVNjL2tyV2FTNmJ1S2J6dEp4RFB1ZUk3YVUxcUR4?=
 =?utf-8?B?MmVpUTE2a1B6L1BTUi9xYzM3bVg3ZjBLcnZiUS9iOHpsK0JETkhCRnVLMGpT?=
 =?utf-8?B?TGc5SEVrM3dFaWtWeXcyWGNRaUVYVVBJa1k3bmM3aWp0endISE5GNGF1Znp0?=
 =?utf-8?B?dGZyMVZVUi9yOXJ6RjFoUmNsVk1GbFA1S2hhWTJKanpzeWg4Y3ZhcVlpSVJa?=
 =?utf-8?B?T05ZejUvd3MySlZrdUJweWRST1dSTHplZjJFd2RlWUdncXFaaGtPRldJbkZt?=
 =?utf-8?B?c0dUeFNBNS9ESHVFdEVUUnhxbWxYYUcvNGVGdTh3NkYraWFkcG55TDFnbW1k?=
 =?utf-8?B?RXArSFZ3ZFBlUitqNlloVWtRSEZML2FkSHNXdXNtV20xY1dObmFWQTBXcE43?=
 =?utf-8?B?UWd5djBhd3AvUUlVUWVUUmdkWENUTU9lNXEvTGdJTWNLNGhyMCtpMlRPUnRx?=
 =?utf-8?B?ZzNNMnlHOGM1SEZFWUUyRzlLMUJWQ0ZYQlJzZ21ncjdmRytUV1RPU2E0VmJu?=
 =?utf-8?B?TkEySHVYeHZQWEdHZk5pV004T3UvbHU2ZzBBNXQrcnlsZU16ZkhzcURsTlB0?=
 =?utf-8?B?UTE1eklybzEyNC9sMG5Ncm81UmRRUTR5TFdRbmJXOTFJWHlDeHJ2ZHhWRW0v?=
 =?utf-8?B?MUdrclRXMVZVdWN3VC9pODVEa3FVWW00Z1J5TFVKQzVXbHNMMEw1aWEyZ3dw?=
 =?utf-8?B?QWRVdW9pWHJ2bWFYNTZ5SXNZUXRmN2pLMUcxWjNWRGhUbFZ5dEE4cE9zRkNo?=
 =?utf-8?B?ZE1KcFhSZHBFUE1LZ3hEUDN2NU1iOEV3Ulp3MmtCRlk2Nk95b0VTU0dqWk8v?=
 =?utf-8?B?ZDAxSWtQelErSkhHU0JmOGprU25ybUY4dmladEM5cEdJdVZKc0FmNXpvdC9F?=
 =?utf-8?B?RUR6NEdQVzltQlV0Q2FSSis3MC9xM2NkTHRsOWdURVdCVGVmbG54OTB0aTR2?=
 =?utf-8?B?akVybEY2RVYzbjBzdUlxMTRxMmpZWGg5empEM2FsSXpwSEpZSDBwYlJhcHB6?=
 =?utf-8?Q?/xKsIssrc/H5u6/nfT89AUFSmBvkQapbPDaz5xRGdjmw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7e56311-63d8-436f-a225-08dabaa0569c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3683.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2022 17:58:23.8235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: emFr023nUi2QEw9ap0biZtWBnEC/m0dV91KumGx5BGFw8/HLQT0oAHam7JPkkMxo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5792
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Thanks for your patch. Please find my comments below.

On 8/4/22 2:08 PM, Daniel Kestrel wrote:
> CAUTION: This message has originated from an External Source. Please use proper judgment and caution when opening attachments, clicking links, or responding to this email.
>
>
> Some AVM Fritzbox router boards (3390, 3490, 5490, 5491, 7490),
> that are Lantiq XRX200 based, have a memory only ATH79 based
> WASP (Wireless Assistant Support Processor) SoC that has wifi
> cards connected to it. It does not share anything with the
> Lantiq host and has no persistent storage. It has an mdio based
> connection for bringing up a small network boot firmware and is
> connected to the Lantiq GSWIP switch via gigabit ethernet. This
> is used to load an initramfs linux image to it, after the
> network boot firmware was started.
>
> In order to initialize this remote processor we need to:
> - power on the SoC using power gpio
> - reset the SoC using the reset gpio
> - send the network boot firmware using mdio
> - send the linux image using raw ethernet frames
>
> This driver allows to start and stop the WASP SoC.
>
> Signed-off-by: Daniel Kestrel <kestrelseventyfour@gmail.com>
> Tested-by: Timo Dorfner <timo.capa@gmail.com> # tested on Fritzbox 7490
> ---
>   drivers/remoteproc/Kconfig    |   10 +
>   drivers/remoteproc/Makefile   |    1 +
>   drivers/remoteproc/avm_wasp.c | 1051 +++++++++++++++++++++++++++++++++
>   3 files changed, 1062 insertions(+)
>   create mode 100644 drivers/remoteproc/avm_wasp.c
>
> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> index 166019786653..a761186c5171 100644
> --- a/drivers/remoteproc/Kconfig
> +++ b/drivers/remoteproc/Kconfig
> @@ -23,6 +23,16 @@ config REMOTEPROC_CDEV
>
>            It's safe to say N if you don't want to use this interface.
>
> +config AVM_WASP_REMOTEPROC
> +       tristate "AVM WASP remoteproc support"
> +       depends on NET_DSA_LANTIQ_GSWIP
> +       help
> +         Say y here to support booting the secondary SoC ATH79 target
> +         called Wireless Assistant Support Processor (WASP) that some
> +         AVM Fritzbox devices (3390, 3490, 5490, 5491, 7490) have built in.
> +
> +         It's safe to say N here.
> +
>   config IMX_REMOTEPROC
>          tristate "i.MX remoteproc support"
>          depends on ARCH_MXC
> diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
> index 5478c7cb9e07..0ae175c6722f 100644
> --- a/drivers/remoteproc/Makefile
> +++ b/drivers/remoteproc/Makefile
> @@ -11,6 +11,7 @@ remoteproc-y                          += remoteproc_sysfs.o
>   remoteproc-y                           += remoteproc_virtio.o
>   remoteproc-y                           += remoteproc_elf_loader.o
>   obj-$(CONFIG_REMOTEPROC_CDEV)          += remoteproc_cdev.o
> +obj-$(CONFIG_AVM_WASP_REMOTEPROC)      += avm_wasp.o
>   obj-$(CONFIG_IMX_REMOTEPROC)           += imx_rproc.o
>   obj-$(CONFIG_IMX_DSP_REMOTEPROC)       += imx_dsp_rproc.o
>   obj-$(CONFIG_INGENIC_VPU_RPROC)                += ingenic_rproc.o
> diff --git a/drivers/remoteproc/avm_wasp.c b/drivers/remoteproc/avm_wasp.c
> new file mode 100644
> index 000000000000..6eda4db5cf4d
> --- /dev/null
> +++ b/drivers/remoteproc/avm_wasp.c
> @@ -0,0 +1,1051 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * AVM WASP Remote Processor driver
> + *
> + * Copyright (c) 2019-2020 Andreas Böhler
> + * Copyright (c) 2021-2022 Daniel Kestrel
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/of_mdio.h>
> +#include <linux/of_gpio.h>
> +#include <linux/platform_device.h>
> +#include <linux/remoteproc.h>
> +#include <linux/timekeeping.h>
> +#include <net/sock.h>
> +#include <asm-generic/gpio.h>
> +
> +#include "remoteproc_internal.h"
> [...]
> +
> +module_platform_driver(avm_wasp_rproc_driver);
> +
> +MODULE_LICENSE("GPL v2");

Recently I ran into issue where checkpatch.pl script complained about 
keeping MODULE_LICENSE("GPL v2").

In such case, It is completely fine to keep MODULE_LICENSE("GPL") and 
SPDX-License-Identifier: GPL-2.0-only


> +MODULE_DESCRIPTION("AVM WASP remote processor boot driver");
> +MODULE_AUTHOR("Daniel Kestrel <kestrelseventyfour@gmail.com>");
> --
> 2.17.1
>
