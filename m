Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D36F697B3E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 12:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233843AbjBOL7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 06:59:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjBOL7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 06:59:15 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2105.outbound.protection.outlook.com [40.92.53.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B14A5243;
        Wed, 15 Feb 2023 03:59:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dtvgZU77oG2CRQV0LWRNvMNWnV0mBvFDSX5HM+/pn8P5pLFnWMafAnVIb/R12B9kH2B6GK4Lc7Ii7uufSs7rgf0OBrKO5RrKIpiHUp/iSfS6thFX0EXHjAQO3CaJBWDMp36ZxVF8dQXMXZQritrg7ssFgJRyhCVBiuSnwSiyd5iYQ7NeW7iwWr7YF06KIrMvvGIEf3UZy9vmFc8H8iqTWl6Ac5S7OLJN9ogbFwnc7L7iVi+yN2M26NghIn73kd0H0N7xBTNR+xG6zc7+6BbhLs2ntl/d+RdQ43nB4qFwLDG4qT4iZESgUUh2KFU51oj6epTjzWjXCOreu/18NkbHmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ZFj9EPvcwmqLNbiBBtE1iY3EV4T/skqCRfOPHDs5Fo=;
 b=YhGHF88riCkV8WBJpdDZui0fxFty7LG28qsDrkVOlt95HOGrRS8C+d45s/F8dJf9SZWOA+1kc8B2nRmZHY+/n8pyyC0pXX029wb24MKocCGlsqNaIgzLtQkFcSPq8GFLqo+AemhuwOscxqBWkXLw9/PkYTqvQvafmolyMmHPGNE5aw5qQVJ4fDdnebp+4ytb6xVogZceOwKXy6JPyeRYIJfRqtS+fapVJNqTl0bbWr+tSHwpIOX/HjEYvRSOshqVdUaOycxQlOKxCugiw8FdaNGjsa7QGhoVuKYhwmBPXcU/X8TxV7YCkAtKp6Sq0bebfnqzqQKjVpQlZHAgOpL5Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ZFj9EPvcwmqLNbiBBtE1iY3EV4T/skqCRfOPHDs5Fo=;
 b=YFwCbCJXJmz0Ygb3kmiglNI3+Z633+SpioVg9ww+V2DF1mAstwpJdDORlGE+MIoLypjj9eGT5kdsmcHjQxQhvkgE77tqSwKq0Mi89cX9GFczGo7wFOpWkd0BFiMr8kb9eXWUfJ3kODrUBdctlCTpC4FQclsR1DchPg2qKa2zwuRvQOnPKZInGJeokEfvvp1S1fNQsbsKnrsRK5Mz1IV1l2d/8un8cISFLsHy/CbtgqnG2g/XJ7AB0RgsOyjDk9H4JqdIprCC6I09LDQF1685iyCHCGBNxRQjwSLpFJYPHlGBaeejlsRUbDiZs1fDzv8eWfBHXugtCTQuDRi6lVB+TQ==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:252::12)
 by TYYP286MB1620.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:113::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Wed, 15 Feb
 2023 11:59:09 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cd65:1f1c:ceda:5979]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cd65:1f1c:ceda:5979%6]) with mapi id 15.20.6086.026; Wed, 15 Feb 2023
 11:59:09 +0000
Message-ID: <TY3P286MB26111053410F3F96C9C71D2798A39@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Date:   Wed, 15 Feb 2023 19:59:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
To:     William Qiu <william.qiu@starfivetech.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20230215113249.47727-1-william.qiu@starfivetech.com>
 <20230215113249.47727-2-william.qiu@starfivetech.com>
From:   Shengyu Qu <wiagn233@outlook.com>
Subject: Re: [PATCH v4 1/4] dt-bindings: mmc: Add StarFive MMC module
In-Reply-To: <20230215113249.47727-2-william.qiu@starfivetech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:  [66UNmE9ydAT2S9fAzU7upqQEYzoxHKB+ygarNKDTJHPrI5x+5wBJCB6vi02PrWEZ]
X-ClientProxiedBy: SG2PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:3:18::15) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:252::12)
X-Microsoft-Original-Message-ID: <a7b51602-3ba4-d822-4da0-f6e51e7dddea@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|TYYP286MB1620:EE_
X-MS-Office365-Filtering-Correlation-Id: 67be4b3d-c5e2-4ef7-9ef7-08db0f4c0b86
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wHoOVsd3eHVL61NTZ1h4rsKqVmDdEKaUxa+Iu9Yw9Q1TP6vpxnwS/ndgX+njNe+36C0f6+mJNztdMpavs8NJL96tJ3MWFiqRMJfpzmHNC7HRZS4vmzDTu5Nf2wQOTbDVmcHh9wuBaLtrAI4LZSfPrUWz3U40rRvJA7COEYUovhyAuD01qEsmArs6M4arN6Degx2VQS3BPlv+8LoQjHSWn/AmcBd9ZG+QNdJ/JHUnAudf8fJuxxZK/E+EWdZm6nJ3YpmwGN4F9S8m7t3kZIoa3/NKNcuha6dv6jOQvin7PhFqyqDYSK1w3CJNQXOebNdoxKczbSzI5AM9b2SqrWywSNgWywwhngibIm62IbjEnYeq1HJwucPTUfaJz1netFPQpod++P+e+ueLvGA1CmBIRCsOjmGcwRgldUvxIx9nJ4ngOtSWF9ltsxdmNFawNFJLwL0shKVezR0GkTYEjKQFHIEombmtDO5OYy20VsAaGyaKFBH+meL9JxGa76onkWoMgIFD3u/R/bCG2BrbGsDay80UqF/HCRcIvBESXHOOQVs5N3bdrxSb7mOi2mZwo5HZvvaRTN3NN6T2pYRvQ2btJSggIt5pLrayAq2Anbu4K/RGJx8qFsADF9bPdAki6JlR
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0l3YzlDdk1LTFE4OWdzZWZKclNkbmFPWGhKVWNHdUYwRFphL1h5YzJ2MVBO?=
 =?utf-8?B?UHJPSHFvT0YzQjlnTFhiTTIyMEtxOVl3ZjFOWDYxOFJYVlk3YWpsZW56VnZy?=
 =?utf-8?B?Y2FGSGYrajdSRHRkQlJtL203T1YyV2xhcERTTnRlY05aTHhCTTU1QWR0elZI?=
 =?utf-8?B?V1lqRTM5YjVYQ0QzYlAzb3FwdE9RSzUvVDBHdXNHYWFZcEVPZkxETnpwb3E5?=
 =?utf-8?B?QlVRc3lKVHd2QU5tZ085WlRBRXB4aUF3TDlwT3huZ2lXWlNLVW55OFloQStS?=
 =?utf-8?B?NXJWQm4za1ZpMHdpSSt2QXZyWVRGZTdDTFNGUFZsM1NyZm5nRFB4ZHBuYnR5?=
 =?utf-8?B?K01EVm5qdkxSSVJ2L2tTdXRnUGxTNDcxb2RLNWFJL1d6SExHSVp1cXVRamdh?=
 =?utf-8?B?eUpXQThrL3J5TFlyYjlTdzRqd25SeVNpQTZCaWRlS2hlUWRVTlA0YkJFM090?=
 =?utf-8?B?M0VHR1dya1YvdVByeDJ6WnA1WnNjT1FwNWZOdmM0RUdjZFpZZ2Y1S251d2J6?=
 =?utf-8?B?RUx3WHlvdUVCNE9DOC82QnZHdlFocDdXazlJeXVrSEhDd0ZObENTVzFBcU9J?=
 =?utf-8?B?QVhucE1WdHF2bG9HbTByQTFLMUpZME1PbXBMNCtOWEE2L1dpMnVMTjF0OFMv?=
 =?utf-8?B?TTArNjVvKzJyemZWa2VQZDlwb3Z6Z3dodUlncGppakhDalRCNU40RlpHZlow?=
 =?utf-8?B?czJDQmhtTWdyUWZBUWowQndzeitiN24xS0U0ZVY2Ny9XMy9MUUVHb2ZxSmd4?=
 =?utf-8?B?TzV0dncyREo3QnFJNGU2cU9pdUJpVHpxUFd0R1ZoUnFDRmx4UktEUW5PU2Yx?=
 =?utf-8?B?NVNMM1N3NDVDa09ORU9nc3Vrd1RXTDk1NVc2Z3Jra3Z3SG92SWVKSnFEMlFw?=
 =?utf-8?B?Z3NKWjkzWUR5OTNtSENMQk5taG5CeDVUVG9wd3BRRXZPbm1XcjE2SGpmcEFr?=
 =?utf-8?B?RGVNbVZzR0pZWSsraElIcDNHYTBidzBJYWVTalBKTitBMFFxbFVMbFRLb0JW?=
 =?utf-8?B?alZNOExuYldVWkVGMFZoc2F5SlVXcVkvYjF1WmVUY1hYQ3EzY3ZRZFFveDdI?=
 =?utf-8?B?S21rcGFnUlVoU0ViNmJkenNGRk81R3U2TVlVcE82MjRpbk1mQ0dnS3A4NW43?=
 =?utf-8?B?V01PVTNhejdkUWtsYWV3akpiUTllaU5IRjF4V2VLU29CTCtSUDZsV1YwazJP?=
 =?utf-8?B?S2tSb2t5WkJXb01MbmNQVVZqSGZLRWVUVTZRdWMyTGZkaE5MWkUwSjhYbkx6?=
 =?utf-8?B?RzBoQVlHeXZvcTRpRnlmeUlIN2dEcTNhNklBNWJPQThjeU5hK3JzN0ExUVZh?=
 =?utf-8?B?WVRlWVV0QkhMUE8zR210dUxOdDJ2N205SkpOZElCajdlUXhtMFhNd3VXMnBM?=
 =?utf-8?B?b2JEL0VmR3RKOXN3d3dITEt1RThNbUhIWWNOc2Nqby9hV2VaMlBtV29FQVgw?=
 =?utf-8?B?UUhCUThSN1FQSldteDNjL1FhTG9rYW9YYURta3RvSDRKS2VTNnFDdTJGT3Mw?=
 =?utf-8?B?VmdOY3Q1UHFxSU0yQjY3eFhCam4zZWp2ZGlwb2pYSUlQdzIxZm5nOGxBWjRs?=
 =?utf-8?B?VTVKSTdvK0VrVzA5U0h2bjVkRG1uV3JpQTRucThSNHY0amFZVExLMnplWTVk?=
 =?utf-8?B?WXhZNnZkMWErODBhNnE2Mks3NUYvR1dLMllad2Y5OWR2YkVjZWxjYkYxdFBh?=
 =?utf-8?B?MEs1bUloSFJzVGpteTNONmJZRVhCT2w1d2RCMGpSRm82U29EZHZlbjZNWG5X?=
 =?utf-8?B?a0VLUHZ5empVaHg3aFFjRlpvNHZIOGtqVkhaVkdHUnVlTUxSZFRoYncvbmE1?=
 =?utf-8?B?SkQ2L0ppZVJxV1NsbEo0Zz09?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67be4b3d-c5e2-4ef7-9ef7-08db0f4c0b86
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 11:59:09.1484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB1620
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello William,

Are you sure changing driver is better than changing yaml bindings? All

previous version sent was syscon and sysreg seems not consistent with

other codes.

Best regards,

Shengyu

> Add documentation to describe StarFive designware mobile storage
> host controller driver.
>
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   .../bindings/mmc/starfive,jh7110-mmc.yaml     | 77 +++++++++++++++++++
>   1 file changed, 77 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/mmc/starfive,jh7110-mmc.yaml
>
> diff --git a/Documentation/devicetree/bindings/mmc/starfive,jh7110-mmc.yaml b/Documentation/devicetree/bindings/mmc/starfive,jh7110-mmc.yaml
> new file mode 100644
> index 000000000000..51e1b04e799f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/starfive,jh7110-mmc.yaml
> @@ -0,0 +1,77 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/starfive,jh7110-mmc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: StarFive Designware Mobile Storage Host Controller
> +
> +description:
> +  StarFive uses the Synopsys designware mobile storage host controller
> +  to interface a SoC with storage medium such as eMMC or SD/MMC cards.
> +
> +allOf:
> +  - $ref: synopsys-dw-mshc-common.yaml#
> +
> +maintainers:
> +  - William Qiu <william.qiu@starfivetech.com>
> +
> +properties:
> +  compatible:
> +    const: starfive,jh7110-mmc
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: biu clock
> +      - description: ciu clock
> +
> +  clock-names:
> +    items:
> +      - const: biu
> +      - const: ciu
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  starfive,sysreg:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      - items:
> +          - description: phandle to System Register Controller syscon node
> +          - description: offset of SYS_SYSCONSAIF__SYSCFG register for MMC controller
> +          - description: shift of SYS_SYSCONSAIF__SYSCFG register for MMC controller
> +          - description: mask of SYS_SYSCONSAIF__SYSCFG register for MMC controller
> +    description:
> +      Should be four parameters, the phandle to System Register Controller
> +      syscon node and the offset/shift/mask of SYS_SYSCONSAIF__SYSCFG register
> +      for MMC controller.
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - interrupts
> +  - starfive,sysreg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    mmc@16010000 {
> +        compatible = "starfive,jh7110-mmc";
> +        reg = <0x16010000 0x10000>;
> +        clocks = <&syscrg 91>,
> +                 <&syscrg 93>;
> +        clock-names = "biu","ciu";
> +        resets = <&syscrg 64>;
> +        reset-names = "reset";
> +        interrupts = <74>;
> +        fifo-depth = <32>;
> +        fifo-watermark-aligned;
> +        data-addr = <0>;
> +        starfive,sysreg = <&sys_syscon 0x14 0x1a 0x7c000000>;
> +    };
