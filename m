Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3A05ED59F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 09:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbiI1HCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 03:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233020AbiI1HCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 03:02:01 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2052.outbound.protection.outlook.com [40.107.22.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930A16B64C;
        Wed, 28 Sep 2022 00:02:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=noUMVAcz6X01pfTGSCAVCZkmVGKJDXScZCLQsX8ItVTJ+b6TD/D1MD9I35t4EyFP0UftNwXApdlm129Povh0ma7UT97kI2OXNx8xWGXhQ3rzgE6rD5gXHpabAnLxsGAIhIFkNCvc+KLC4axmyzg7nUciTQdRXakoXykAooh+TCzFZq88t54b3qmYQTKfta6waiD7psXfwoC1z1L9jWxgD5/4i+RvrG3qfIB0+eEdrpNVjOAYYEHiK7WvD6tQcnVwxA9sim8MXJA+gmldavWlUMlumgFVlvqBL2jV2iq9yB5YlO5IDQGyRHg5cmfntJaDSZA+TPehmPR8LZGHLWUNaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FS7d2KWUQYmvq+iEHQs+IDZjBV8r3QSVqbUyam6r0LE=;
 b=F/JNJlO1EKm8Jo2J9zPyu4wUqZvFgtx5HHyM8qEq7MU7RO5RhcXvoZe9DPjRKOlV+TETZCYBdS6SYsIZw2Vo+CjSZOJ1loNAieQI3dP2+5FPCs4ni/nGKJjklXgxIUOtZADkH+tBHx+Hs/m4Ave8Vca7HPIIRKDfnEQKj3sWMfdBmpihb+MVvYYCZTYRUZnns5je7UXdDZ1kWB2Ye8Ax6qdDBL+OQ7n/kcWNpwK+bUNgIYSBvULal1RQCbKMkBIFA7DBnvWrm81iX9jqmbg6B7G1jMm1pdGvkN85TuXSoS9TuidWukgM7Xvbyk8UVahesQ7tvVIfvGH8nM+/IjaQMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FS7d2KWUQYmvq+iEHQs+IDZjBV8r3QSVqbUyam6r0LE=;
 b=lZGlnacc59BfZjyxBCQEmlfafi4b9GtwKzjCTscxjn5aZp+LglDSsFRqe2WfXQU0p+kHXy8DPUU8InM5wC4JuEjp7zQuO+T2n2zumByqqdUhj3TPnT8viEgG7D+z71LFoU82ULmYotFBUQbCeq5dqWOA7g7DvlNqYly9y9D9Aac=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8505.eurprd04.prod.outlook.com (2603:10a6:20b:40a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 28 Sep
 2022 07:01:58 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867%5]) with mapi id 15.20.5654.025; Wed, 28 Sep 2022
 07:01:57 +0000
Message-ID: <08abade9-f6f5-77cf-b83d-739b0b81543a@oss.nxp.com>
Date:   Wed, 28 Sep 2022 15:01:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH v3 02/11] dt-bindings: remoteproc: mediatek: Support
 MT8195 dual-core SCP
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
References: <20220927025606.26673-1-tinghan.shen@mediatek.com>
 <20220927025606.26673-3-tinghan.shen@mediatek.com>
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <20220927025606.26673-3-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:196::10) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB8505:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e3bfe10-07b8-465a-c87c-08daa11f553a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x9P9kaTZEv+FaGJkaII8CJmGsijyp9PXFJY7+QO7uxHOLo1avaJDj+jaEbX8fC3y8hJjqOLkDTo2iVdDnsqd9d1xAxV0ihMJVl+o9CVM/nrLah4rqLRAaLHQk+wOaUGwTpS730FmC8shrla83J6xIGeDw+ZK/i1Cc0x8U4aC85QnGJdIHBycOFv+zdybJxk6pU+7T4kRRJAG428RUEfu4Hpq/1xoA6mQ67LiEUisI/lJnWCyX+bxUj1QDQwfAtvCy20NLq8gVbgkD12jYYBXCx6gxUW+ankMiR6/NV4wjv65Aewe6aQyBM1Mnp8c00vyHy6uPIbhsGk64t9CTqWI0LiTHZx1M22XuUkqgSl0j3EBsNZMjm4OR7tH2GGzl9VdAleTbXFdmzvbR9uvY+YhYVRxTKlzeOLjMk6+XxMGwTPpZ10P4wUyF1WL5f3Fw7heuvKwUdI3c98Jj3VJ2kuMOWCSSPxzPVvwaMcF/X3kXW1vtNIDM1SD/9Gn7gG4ndCjiOHZzoCZGeqk1se7boWaiXrMBwL1f5RnqSs2k4bFkRulssQGs7WJFcOJMBB3ryZWT46wBEM8lkuZn22wXyn28ZtizquMbJxvti4Avo44o2qlHc99qum6uj4UyGYxzbLCx9X2aRjFkrkJyDIHazyNcjLQEUvt9EyJe6kmgCXNjDIkoj5LVYVjhBERO66YjodzcrHp0TcLIuhbFdeJWB7bTbvVtfsx/FYGvHcFTK5O65IF54hHbadK4GPcm+W3mOjOs7KTAYKWKSBv8o61YmR4EDujbbmjj4MhHyBUAYIB4NsnIZpUUrm1ir1zrTSSfSvTD3qkXzIZUzK067RklJyIvoGFHibk9ySe20NgLrcv3ks=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(366004)(346002)(396003)(39860400002)(451199015)(6506007)(38350700002)(52116002)(53546011)(316002)(38100700002)(110136005)(186003)(6512007)(2616005)(31696002)(26005)(8936002)(86362001)(2906002)(41300700001)(8676002)(83380400001)(66476007)(4326008)(66946007)(31686004)(66556008)(6486002)(478600001)(7416002)(44832011)(6666004)(5660300002)(921005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXk4VHVzbnppNWRCclNIcGVzWnpiZ051SzJoeFVObVFPck9KeXp1WkR0eTFO?=
 =?utf-8?B?VEsyQ3BBcVM0aGUzY0lKejN0YUdvYW1WdGNIUG5RdVVxMXUzejJoRXZQOVVy?=
 =?utf-8?B?WDZCZXhnV1JYQXpXWkJvemhPcUJlVmJKbVVkemU1OHFSTjBPbGpweVE3QTF2?=
 =?utf-8?B?U3VqaENQWTcyQXE3TEJGaStYb2ZoVXV4a0g0bnNXNklmZGdUN3YwZlp2M0hp?=
 =?utf-8?B?dFVTMzVmSWppZnR6R05leGQzbXduMWdQUU0vQXdqdStLRm1QWDlSb2NtdHlJ?=
 =?utf-8?B?RzAwSlJGRUgzKzJFYVVkT3VEck5Ud1pmcFZFQThvNkxXTGZiQnFJbGxlZnRZ?=
 =?utf-8?B?RGdnV3ZDSDJLb0lOMzhYTTRzekY0U01DN3FTNVNPQ0tpbWdpRHEzZzlGRFgv?=
 =?utf-8?B?MDZZWkpJckJScFNhTDF4QUdibFg4ZjQ0Z1FTaFQwb1QycUVxcjdZSWhjaldh?=
 =?utf-8?B?elBOdURDQ01IejdCQWlIYUJPNjNvWWRrOFV3dm9rOVdIWnZ5K240L21QQ0xz?=
 =?utf-8?B?VkYyZU8rTTU5QnV5WWlqcUtWVG03R3JEeHlMVFVESlFPVGIxdUxYcVZBN1A1?=
 =?utf-8?B?T0NnazVXM2x3TGZUS1B3Nms3RjU3QnorRHVmNlNMa3lxakZVaHU2a3BuQnJF?=
 =?utf-8?B?MC91bEk0elovY2dkU3dlT2dwQ2tTTE1MYzFSaDJNS1BKY1hWbkwvbWxYU0hs?=
 =?utf-8?B?NUpkTFJxNWFEOVZDMEN4elZzNk1mTnJyOHY1MnVjRktDc1pBcStmOFJhaUc3?=
 =?utf-8?B?SzlLTS8reDJJZDZUZGFIb1NkNEQwazF0Wk1VdHR4TXpMZWd0cVFSaFA4ZnVq?=
 =?utf-8?B?VzkxQVNwQm12NG11SGxOR0E3REdBcFNCcW5VTG0zd3VLS0xVR3E2NURQOHl3?=
 =?utf-8?B?aWo0Mlg2aWdqTjlXd0tLc1A5dlE0d2RwR1BsRm54WXBLWitLNzlSenErdXZ3?=
 =?utf-8?B?WlFmWStHU21Wb3UyVW91c0xqU3JUb1BYN0FKN05HcFhtTFRUSTdoc3o2ZWkx?=
 =?utf-8?B?T1piZzlEKys0ay9CdjJFbllpMHRCRTkxUjg2NlpGZDM4dmUrUkkreG8yVWJ1?=
 =?utf-8?B?L3ZNNElsUEYzMXFyNExOUG5QZTM0REdEZFFtNnlkdFRreWlGdzhSemVUalZ3?=
 =?utf-8?B?TVU5eXU5ZEdSVHBDa1NHbWRia1QrSldlZSsybi9nei91RktyeC9hT2lMakUw?=
 =?utf-8?B?bkdEUG9DWWZiMHJzNm9EYW9hN250S1ZWbEFvWUloaHg3cmYyNjVhWjAycEg3?=
 =?utf-8?B?NUFvbUJ6cGlIREFDNmdWNmMvckdoYTdHRGYzQzFZVUtaYUZPTTZxZGM2aXRE?=
 =?utf-8?B?VDhuN0RvY1FDNTNpeFlybmFRek1kbktPNmpFaFgvS0ZFdlhhdGo2M3VQRzV4?=
 =?utf-8?B?N3FtRlZlWmR5N00xTHM0VTdWRWlIdXNrdEh4ZFRxMjZ0SXJqRktUS2QyZ1c2?=
 =?utf-8?B?UDFOS05ROHBjU1p5cjZNM3QwOTFPbHF2REFVcExrS2x3a1NqdTFWbEFTYndE?=
 =?utf-8?B?WnNMN2RMUFU2dWlHYzN1c2hXOEtIb1U3OHVkc01kUnQ4YnJvdVR5eWxOSDBa?=
 =?utf-8?B?K2pPUDNZTmd6c2I0YjZMS3gzR2RFK08xeXhyYVA0WnY4THEvSWJKOFk5VUdR?=
 =?utf-8?B?TG5WVmZHRkhlbEV1eDhPOEtLMUdMSnJLOEVQNFpLcDFqWi9aREFvb1lYUEJJ?=
 =?utf-8?B?K2dsZmwrVU02UGxoYUhmSitkc3BaczdBdERYVlVhdmVSVXNkMVdycUlNaVBR?=
 =?utf-8?B?MVdnSkhKS0wyRFlhclNVTldyalNJY0ttLzgvVjI0L3RWYmp3VE4xUVVybk1i?=
 =?utf-8?B?cGhPUFlLaDkwNStzaE9kZDFic1V5UTFiQ1VEOFlER0V3ek1BWjNnd3VXKzcx?=
 =?utf-8?B?b0FqUzVRaFd2bXQ2eGF3ZXlxc29lRUZMUHN1NWZjcW4rdDlRZG5VODFsa25z?=
 =?utf-8?B?a1ZLc1FnREN6NlEvSmRidFJ4ZUF4UDBjYkZBeWUzNkZlM2VnVElWazVVTUgx?=
 =?utf-8?B?ejBrckI2eFcrY3Y2QUlZOWFDT3JDN2c2TkJIUmMwSFVDVGJDcy82RnFVNUxr?=
 =?utf-8?B?djBGSytLQ2pDVnFQdkZGenZQTlg0VThxaTU3ZU1vV2VTdThBakJsbkJ3RVd2?=
 =?utf-8?Q?zfH0EyuEIsZsSAcebBTqbt3KV?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e3bfe10-07b8-465a-c87c-08daa11f553a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 07:01:57.7944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SQcxS1zOCprgrVDEzXgI2PjPEHc+ScO5TGtAMny6ospNRkAvzOTJP0N/A3sKWr8+sLNqFC5KAZbiyHrYzj2+oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8505
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/27/2022 10:55 AM, Tinghan Shen wrote:
> The MT8195 SCP is a dual-core RISC-V MCU. Extend the yaml file
> to describe the 2nd core as a subnode of the boot core.
> 
> The configuration register is shared by MT8195 SCP core 0
> and core 1. The core 1 can retrieve the information of configuration
> registers from parent node.

I think the commit message would not convince people you put
scp 1 as subnode of scp 0.

Regards,
Peng.

> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>   .../bindings/remoteproc/mtk,scp.yaml          | 97 ++++++++++++++++++-
>   1 file changed, 92 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml b/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
> index 786bed897916..c012265be4eb 100644
> --- a/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
> @@ -75,6 +75,83 @@ properties:
>       required:
>         - mediatek,rpmsg-name
>   
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 1
> +
> +  ranges: true
> +
> +patternProperties:
> +  "^scp-c[0-9]+@[a-f0-9]+$":
> +    type: object
> +    description:
> +      The MediaTek SCP integrated to SoC might be a multi-core version.
> +      The other cores are represented as child nodes of the boot core.
> +      There are some integration differences for the IP like the usage of
> +      address translator for translating SoC bus addresses into address space
> +      for the processor.
> +
> +      Each SCP core has own cache memory. The SRAM and L1TCM are shared by
> +      cores. The power of cache, SRAM and L1TCM power should be enabled
> +      before booting SCP cores. The size of cache, SRAM, and L1TCM are varied
> +      on differnt SoCs.
> +
> +      The SCP cores do not use an MMU, but has a set of registers to
> +      control the translations between 32-bit CPU addresses into system bus
> +      addresses. Cache and memory access settings are provided through a
> +      Memory Protection Unit (MPU), programmable only from the SCP.
> +
> +    properties:
> +      compatible:
> +        enum:
> +          - mediatek,mt8195-scp-core
> +
> +      reg:
> +        description: The base address and size of SRAM.
> +        maxItems: 1
> +
> +      reg-names:
> +        const: sram
> +
> +      interrupts:
> +        maxItems: 1
> +
> +      firmware-name:
> +        $ref: /schemas/types.yaml#/definitions/string
> +        description:
> +          If present, name (or relative path) of the file within the
> +          firmware search path containing the firmware image used when
> +          initializing sub cores of multi-core SCP.
> +
> +      memory-region:
> +        maxItems: 1
> +
> +      cros-ec-rpmsg:
> +        type: object
> +        description:
> +          This subnode represents the rpmsg device. The namesof the devices
> +          are not important. The properties of this node are defined by the
> +          individual bindings for the rpmsg devices.
> +
> +        properties:
> +          mediatek,rpmsg-name:
> +            $ref: /schemas/types.yaml#/definitions/string-array
> +            description:
> +              Contains the name for the rpmsg device. Used to match
> +              the subnode to rpmsg device announced by SCP.
> +
> +        required:
> +          - mediatek,rpmsg-name
> +
> +    required:
> +      - compatible
> +      - reg
> +      - reg-names
> +
> +    additionalProperties: false
> +
>   required:
>     - compatible
>     - reg
> @@ -110,16 +187,26 @@ additionalProperties: false
>   
>   examples:
>     - |
> -    #include <dt-bindings/clock/mt8192-clk.h>
> -
>       scp@10500000 {
> -        compatible = "mediatek,mt8192-scp";
> +        compatible = "mediatek,mt8195-scp";
>           reg = <0x10500000 0x80000>,
>                 <0x10700000 0x8000>,
>                 <0x10720000 0xe0000>;
>           reg-names = "sram", "cfg", "l1tcm";
> -        clocks = <&infracfg CLK_INFRA_SCPSYS>;
> -        clock-names = "main";
> +
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        ranges = <0x105a0000 0x105a0000 0x20000>;
> +
> +        scp-c1@105a0000 {
> +                compatible = "mediatek,mt8195-scp-core";
> +                reg = <0x105a0000 0x20000>;
> +                reg-names = "sram";
> +
> +                cros-ec-rpmsg {
> +                    mediatek,rpmsg-name = "cros-ec-rpmsg";
> +                };
> +        };
>   
>           cros-ec-rpmsg {
>               mediatek,rpmsg-name = "cros-ec-rpmsg";
