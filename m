Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 195EE5ED577
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 08:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbiI1Gz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 02:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbiI1Gz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 02:55:28 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60040.outbound.protection.outlook.com [40.107.6.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3077326DB;
        Tue, 27 Sep 2022 23:54:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T5PQLfv4uxKcv7/1UF++TvS7xVkARCA/CvAA+3Pue12f8afCR5jOOA3M7gR6WqI3d1fAW90yG4gQ/MLBDAxA+gGLilnzq7bNp09XU0DSNevxJIw51cwGu5PXsRb7fzPp0dlh22BTm6cNVW0Dlzwpz2/Jal4ZJ15L6qBqYY1qiILm6DwuBc4JzC7GugpJrqDJREeNQjeGit1/nGRv1PW0wtbGhDDxJ4gOADNxqTRd4navUk2/nVQZjXndpMLEJOEaRA751lguE+F+FNL4EQ7sZKVseCMSqnUqJ3mmm2JHUOyqXAhcubQS0MyT+2EEgez2/qW1Rvk16qbEP+wNrWJkdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4T0JIaocFblU4Y8enh0teZDNmI4GaqKnGxL8RNgFHL0=;
 b=hmbdAQx4yDV8b7o1t6117fJV0F/MPVAS3JQJ9eAOFE1Yk//YUpRH4FGk2mF7u0+WSGtWj5ROWM3COIqoeP68a0gmJp37rCWxwcmmgVUfQMIqffa1AJTUloecfmVvY5BI29FKpnIwqZF1JhIa/4T5eVHxm7rKtnfHEeT5tECjcGuxFgq+GvK9Q/sAx+QLHryu6WN+MiIqGdTr7KTkvnt/NyYfOVdGciy4Kdi3w4gNFIx3vnWazi/6+8zWp3JwHuzLA3N8i8qTQ9noTalEt8kdHj35233H0k9/WoAES0EE2GFtzu934EL6pFVK4R5dlZMOj8n0jXSmUjxfijfFcfY9JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4T0JIaocFblU4Y8enh0teZDNmI4GaqKnGxL8RNgFHL0=;
 b=S6duoJXR6ra5jOXYU4LYauY6vo3W9uM1p2bcVBJFcHO/rSaoDM3RTvFctlGGByzaIlF9hcdwpRsX6zrp718vUR+AgcMkvYXlbPwnoYSs3TKKKlkONCl6Tr4qZl/wv71HAIs8W9+P+dKy5snlA69vMpH1LI2IqvBOLyxdu5MqHNQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8276.eurprd04.prod.outlook.com (2603:10a6:20b:3e7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Wed, 28 Sep
 2022 06:54:29 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867%5]) with mapi id 15.20.5654.025; Wed, 28 Sep 2022
 06:54:29 +0000
Message-ID: <d3a5f173-b27f-85b0-a553-e7673a43d2d2@oss.nxp.com>
Date:   Wed, 28 Sep 2022 14:54:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH v3 01/11] dt-bindings: remoteproc: mediatek: Give the
 subnode a persistent name
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
 <20220927025606.26673-2-tinghan.shen@mediatek.com>
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <20220927025606.26673-2-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0196.apcprd06.prod.outlook.com (2603:1096:4:1::28)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB8276:EE_
X-MS-Office365-Filtering-Correlation-Id: ec5a4054-3a72-4842-9c12-08daa11e4a5d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cXZZ4+Mz9sQf6YPXljj/mOtpb6L1Cu4QRvO4H8yqk3SvUrVCe92NWAjkPJ+kWlWK45tqIZpYxsDCoJkNQbIPe1/d3WSHnRH4liAHKdvPPeN18d3Rs3+mPb62qzE7P1qe3Op/M40sw2e5xgaSmVzmOS7hXb1uo6/AaXiBA3VPTEFePdtPW85hbyzYVoji5qkXnW26dQwIKs06ew2BGEPZDXFqbYdjhR6L783Nb9K0QfnN+A8XGzSPuOUZbGbQT5PVt6Sen+i2JO1Q6Zc8OE/d+rIaW5n57cGZzDfI7ftIL4HKDcpL0zlMuUExD4pvFi9L/OLXAO4y5evPVdKxCd6c3GCuPdV322oMOcjuAX5RTFssEbML0YX9sdZrzKPZgYCzkoPyepA27ma6bWzzYOGSLupHFwRt5FuPyJp6ix7j6BWPYkffSSR8L+VwT2pCoWL7eerDLI4w3N7h4PbOF663K/IGkFZuqdI0Tk711gRJLrMIrkmcw9Xi3qvKso17p14IbLrfebfuG4YQ4QTFZBTcLRKWfRmjOJzysOiwI+tuynfKbG+iKsA2IbLifUVJRX0bXkxm+6Jv0HpocR2yisbRLhzW+Nl/vZ+/hIfCI0w07+NFoQT2Nx5xgNXFXFyT1szi0oePvoIo5fQqsNg7GHoaVtVgYV7HLeJA8jPDZXuNiVj2Ts4d2obsHD7aE+BSCqBWE6ELQf4xrEwdMOKr3DWd7aEcyuJi2dySJxUrgqRR54sn3MD30zdGQE1Xtunx+Mv8vDnz026FyECTHxJ4IQwKMvmTkSmfb+aYJUy5P2e9ewjgdNrR6GvftUyNaxDEZ14T9yBAFJSA82lAJrx1xYnU8jg0h0PP9tHVJMqJuoOUGA4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(451199015)(66556008)(186003)(4326008)(8676002)(6666004)(66476007)(6512007)(83380400001)(26005)(110136005)(921005)(2616005)(316002)(5660300002)(7416002)(2906002)(31696002)(6506007)(38350700002)(44832011)(41300700001)(86362001)(52116002)(53546011)(66946007)(38100700002)(8936002)(31686004)(478600001)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzVHb2FKQ2FvUFZKQkdpL1V0YklrenBUWHJzZVZhWmhRM1p5ZEVGY29DaGp1?=
 =?utf-8?B?NW83ajF6OWxXSFhlOVVMY1RMM2FQWUJWMzBTYWZ6ZWZMYlF5SGhBanU0VGlv?=
 =?utf-8?B?UlhqeUp3Y0s4cE9iNXBhdmVvRU1XYTJrYjVyb1YrVVFrUnBVTUY5bE5KQkg2?=
 =?utf-8?B?SWdjZ1VXY2N0S0FJdE16eFFzRll6Vk5GbmlCbjQ1MHdBL1RydVZ1aTBjY3Bt?=
 =?utf-8?B?byt3bVFvdnhleVFvQ1B4aEg3elVJU2packNKNTRmZTd1U21QZnRUWldLQzhD?=
 =?utf-8?B?UldXejUyWXdaL2FjQTFDb2llWTJkWTJ5VzVOZS95WG5oVzhsSWNPZ3Z1Q09D?=
 =?utf-8?B?eXBzdlZNTFFNeHhPVFZxczZvSFdDRWd4Q09iWEpEQllOcmM0dWZpTnlRWGF6?=
 =?utf-8?B?TUNYZWlDSEM3UE45bHo3NUJEVGpUeXFyamVIU0x3aEhxNUZrb1hvTUVjMlNk?=
 =?utf-8?B?YXBtaFRGUGZtZEVtK3VlS1JNaGl5OW5NeVZFemh5c1dYcXhGWVFqRlVQcUI3?=
 =?utf-8?B?a0tpejc3NTdjUndFYVVCUHltL3NWV291WnBHV3NzSVJSV1lZVWFsbnF1Y2lj?=
 =?utf-8?B?RzcrR2RJZ09yVUQ3R2p0eVUrNHhPMmovWmRWV2NpUlAwZ0pXT3ZhY3ptejVL?=
 =?utf-8?B?aWlpZjBtYkNNZDRIR1RxeStNR0VZeEJmb01EQ2RURjB4WDNPVDN1VGdlZmU4?=
 =?utf-8?B?c0gxeDg1b0RuWTBDWWVWSnBrWVJSSzF3WmpVSE50NERxYlJxQjVwWHBBWGlP?=
 =?utf-8?B?dmxiQTN1TGExbzRVSmU0bSt2eVljOGlsRllwaDBQQUxibGVwekc4aE1kb1A3?=
 =?utf-8?B?dWhJdjhuNmVYYWdLMmg1OXphK09Vbmt0c2o4SVBwRWJNcGJJUU1TZGhsYjN3?=
 =?utf-8?B?NVhreDRkVFpGMHM0UGFoaTRycnNLTkt5bCt6M2syYkFTZ3prcVZOL1MxbmxF?=
 =?utf-8?B?RGhqUW9VY0FaZ2ZuYllTaWI0M3dNUDM3TUU3NG9BVURnajZlbzlWbWhRcW1u?=
 =?utf-8?B?amFLMlYwSUYzT3FxbDgraUpEQ0h5ZFVuVldrbHdySmVOMmRuYkhOUW5oWTh1?=
 =?utf-8?B?ckdRdVdJWEpjbVRhNDdFQytTZ2cxcmU5anZYVkNLY2NONDJCKzdIaEVPTVYv?=
 =?utf-8?B?VGZLRllOc1U1THdaaDRkdGk5L3BUTzc0SWc0Lzl4QU5vVDZkbm5TK0dpMkhl?=
 =?utf-8?B?UFZQMW1wS05EaE4rVlRPcE1MVFJhV3dvZTFmMHRwTkhBc09Xams0VXNzVkRn?=
 =?utf-8?B?NFluNE5pSy9kK0p2c25USFV0QTF5WHp6VkxSN25rek00Q2pRS3NYZTAwR1pR?=
 =?utf-8?B?TEwvR205SHlsMWVuaVlYQk9vcFh6QSsyMm95K1AvRHloektsMXNqeFRqUHJC?=
 =?utf-8?B?RW8vbFljTW8zb0Q5WWVjVEtybkJYYm9OUUVtQkNmWnpYNTNDbk5sdVN1SnFC?=
 =?utf-8?B?Q0lXajhZWllpMDllSG1Vb05OelBTc3FvdXUxZHN3c05jUjJIVFZ0UDVvQmVj?=
 =?utf-8?B?OWVmeGM3elZPZW9MOXhNT0FBUW1FVGdsZzVGSXVNWEo4eEZSOEhtYktxNHdN?=
 =?utf-8?B?TWtkd0tHSlRuZUZaUDZ5REo3bnhld3I5bnlaRXk1ZXY2QWtjQng4aDlaYzFN?=
 =?utf-8?B?cGxkajdRaGtFMWxUSjF1Uld6MHRQSG11R3ZzYXVvM3VwUm14cDBtTTlhTGF2?=
 =?utf-8?B?MFFaMlNaQW9VTDNxWWlyMVozODgzRGxvbmNCcDB2YTV5a3hGcnF2MFh0YTRh?=
 =?utf-8?B?SEJEdW9aYTFyZmI5Zmd4ZW1qQmVwd2RrSUhzcGIrUE9oLzVCSXRmVmhiU3Np?=
 =?utf-8?B?bEF5eXdtV3IvNjhHMlRvME1XL1dwc2JWSjlzWkw3SXoyS2FVdjlwMHlla0wy?=
 =?utf-8?B?RjR4c2kvVzV2M0VxT2UwOEZ3S1kxVnZNYTNGTFV0aENxQk15anRzdTd6TVdX?=
 =?utf-8?B?NWFQV3ZQaFd1VzRHMjMzdi9Ob1dZLzlSN3hzMVhjZ0szVkpmVnluajd5ZXlG?=
 =?utf-8?B?d2g0dk1UTUZIRUJSVzI2RlVuOFgwK3NzeE15WTJoQ3BiN1dld3Y0c2JDQWpG?=
 =?utf-8?B?UElIV1EwV09nc0VqWTZxak5WeXpUYXhjNmVqUDg1RGp1RFkvR1ROemtha2ZE?=
 =?utf-8?Q?AyAc558nBhxKriQKGLrttJ2qj?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec5a4054-3a72-4842-9c12-08daa11e4a5d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 06:54:29.8366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jB/JUZ3suzQ2kZU4gwHyydyURo0Iuu2NIILkgtK7SBkLJHo3+NmbnmSeTm2b3aIoME13uOu+Dg0fHe+YutvQlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8276
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/27/2022 10:55 AM, Tinghan Shen wrote:
> The node name doesn't matter to add the subnode as a cros-ec rpmsg device.
> Give it a clear persistent node name to simplify scp yaml.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>   .../bindings/remoteproc/mtk,scp.yaml          | 35 ++++++++++---------
>   .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi |  2 +-
>   2 files changed, 20 insertions(+), 17 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml b/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
> index 7e091eaffc18..786bed897916 100644
> --- a/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
> @@ -58,6 +58,23 @@ properties:
>     memory-region:
>       maxItems: 1
>   
> +  cros-ec-rpmsg:
> +    type: object
> +    description:
> +      This subnode represents the rpmsg device. The names of the devices
> +      are not important. The properties of this node are defined by the
> +      individual bindings for the rpmsg devices.
> +
> +    properties:
> +      mediatek,rpmsg-name:
> +        $ref: /schemas/types.yaml#/definitions/string-array
> +        description:
> +          Contains the name for the rpmsg device. Used to match
> +          the subnode to rpmsg device announced by SCP.
> +
> +    required:
> +      - mediatek,rpmsg-name
> +
>   required:
>     - compatible
>     - reg
> @@ -89,21 +106,7 @@ allOf:
>           reg-names:
>             maxItems: 2
>   
> -additionalProperties:
> -  type: object
> -  description:
> -    Subnodes of the SCP represent rpmsg devices. The names of the devices
> -    are not important. The properties of these nodes are defined by the
> -    individual bindings for the rpmsg devices.
> -  properties:
> -    mediatek,rpmsg-name:
> -      $ref: /schemas/types.yaml#/definitions/string-array
> -      description:
> -        Contains the name for the rpmsg device. Used to match
> -        the subnode to rpmsg device announced by SCP.
> -
> -  required:
> -    - mediatek,rpmsg-name
> +additionalProperties: false
>   
>   examples:
>     - |
> @@ -118,7 +121,7 @@ examples:
>           clocks = <&infracfg CLK_INFRA_SCPSYS>;
>           clock-names = "main";
>   
> -        cros_ec {
> +        cros-ec-rpmsg {
>               mediatek,rpmsg-name = "cros-ec-rpmsg";
>           };
>       };
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> index b4b86bb1f1a7..693ad5f2a82e 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi

DTS changes should be in separate patch.

Regards,
Peng.

> @@ -816,7 +816,7 @@
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&scp_pins>;
>   
> -	cros_ec {
> +	cros-ec-rpmsg {
>   		compatible = "google,cros-ec-rpmsg";
>   		mediatek,rpmsg-name = "cros-ec-rpmsg";
>   	};
