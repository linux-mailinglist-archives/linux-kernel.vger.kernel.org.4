Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7DA633B60
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 12:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbiKVLbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 06:31:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232864AbiKVLaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 06:30:17 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140049.outbound.protection.outlook.com [40.107.14.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977FF5F87F;
        Tue, 22 Nov 2022 03:23:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c5GL3d2l4Yjb3MT/t/qrZ4YaHrbYpm9J6LN+14utKxTPO6dUfOVilJtiMxKckTeH6aIkG/n3vG1rwpg7vvE+WPN/ZHpG9UOiqjASpDeE5kA+xUyx4YjzeW7vkh2H69YiVhn9fa6oFhkbH6MPAbRm+Bbcvcs4yE194bQe4cPXxUJzSFG5z7dTfOzd6bFn0772v+dZHw6DY8ZjlmP0r5kMbo53pFi7hbWQPV0DkEdF5o5BAL0M5RAmFViGYyv3icMMNFfTmnHnqKvdBeCAPlyz/yDjxeaFCBqfHK9zNBp4OC+5kyXXj2UDtRGesOOocTzi+zCLipobHP2EvC64Dz1crQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cV+HllAfhkX7s9u6Vm6NySyPcu37NyZBleChj1ndV2w=;
 b=R/dSDgtI+eUi2GxQ9cPenZi90Zfxnbdx6GePFQAqiVOl85t2FLTBoADeXNiz01SeE8G0LjU3FpDkNrK45F4xTfRSSpqmuzfaMT+ijiP1HZuhIGx73rEYv+BLB1fLgh8c3nHoXwIEkOKjy75v1Yns/eybe9Zx0soa8DGxgNZdq6JcsZJdtC2FPm3cQuA2dM3on5Mzx+EkUilN974BWD/fhOQR3HPvkvbrRdc+vnDWLZvxkuOZqwqwRU1nrnBh9+05Qu9k9rD05g6HgYZ5AS4bDxoG5Dm+PMpQkjsyft0FV0Y2KyLRoeDP0YpPrORAz2VlS7dNAZepgkQTczG6HMwFBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cV+HllAfhkX7s9u6Vm6NySyPcu37NyZBleChj1ndV2w=;
 b=ScyCy54T//7NbACn4nzsrBU0q1KZmts/K4GqC35RQSBb/X8ZdMDhgmwGoPoE0R2nBtmpYbnOfr1R3F9C5OPiBaegqm99lzctV0TV+eXFdJ7MvZwUedWfziqFxqTKXLtHAnkEvj24E+Ywd+pgb/wfjTILurubYcJQEw8KMmvLpLc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by PA4PR08MB5888.eurprd08.prod.outlook.com (2603:10a6:102:e8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.17; Tue, 22 Nov
 2022 11:23:38 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::3643:6226:28c:e637]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::3643:6226:28c:e637%3]) with mapi id 15.20.5857.017; Tue, 22 Nov 2022
 11:23:38 +0000
Message-ID: <ca0d8320-21f1-6c54-87b9-a34d077e6473@wolfvision.net>
Date:   Tue, 22 Nov 2022 12:23:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [linux-next-v2 3/5] arm64: dts: rockchip: Add support of
 regulator for ethernet node on Rock 3A SBC
Content-Language: en-US
To:     Anand Moon <linux.amoon@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Chukun Pan <amadeus@jmu.edu.cn>, Peter Geis <pgwipeout@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221116200150.4657-1-linux.amoon@gmail.com>
 <20221116200150.4657-4-linux.amoon@gmail.com>
From:   Michael Riesch <michael.riesch@wolfvision.net>
In-Reply-To: <20221116200150.4657-4-linux.amoon@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0008.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::21) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|PA4PR08MB5888:EE_
X-MS-Office365-Filtering-Correlation-Id: 05e492b7-2bb4-4688-b279-08dacc7c0070
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pYk7ggOdemO+l4JrgdfGX1ZI1i7KeQ66i4Wr1HZc7eCuwYn9XNmO+JIXfT1pIG5BbaasD61Ogt4l1WtBcCNYjP60oXbrIABP/PFEjXs0UU58YzKZ44dLTKFH45FiLrVVFG4vnVuTFX+paGRdRWfwGieIBCnQikOdD59cfgRBCjsYvTeh/NUjxwv/3tL/dUaupkubpeRNvIAiieqdVfA02ShZ8CcA8NNNtIQ/elcBuOFh4FlEvzQhY+S/7UiYw+1H7dRLOLMFZ02JxbaDtMSKj1eF8tlJiHBtHeKt16kNNT2WcrFdjjmu4d3kt7M+nEkTyj+xv/eQty5nEfpICqGFPFKprVtCuHx4AelZcxx3AapPwLViHMJqnbe3euUrKgeVGRC8gNx8h38qgu8vB0dqu5g8lpks68sleCEu2riJQeKwzurOzQK2dOsHinGRIQc//kpC2QyFh0uI1ZgFJVlbaUOkL1S5iJpaaehHEsimmr8QLxiHQngZPBjX8mD4ZHByQoHo1B5PE3+U2fEbW3EpHoV/rDLX8MGBhGHFRJW8Erp2DiLiR8dQwq9IUmhwxuxfhgcXMiwuzPyIPNUZRq0eH7I+K+4y1214+3tULwLZXGy3ty2AKG2BnL16jhPF+i9dPRX5d+aV27ihdtvXX1uIDoWF20ebWRKRsq5lgL5BFcWKAL763WRRgkMP4p8F9GhTvfLkqPiOTYv0ZiJ2GFYnCWsoVcGLeDzRPoZu719RjX0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(346002)(136003)(39850400004)(376002)(451199015)(6486002)(478600001)(110136005)(54906003)(53546011)(6506007)(6666004)(52116002)(6512007)(86362001)(31696002)(7416002)(8676002)(44832011)(41300700001)(316002)(66556008)(66476007)(8936002)(5660300002)(4326008)(66946007)(36756003)(4744005)(2906002)(83380400001)(31686004)(38100700002)(2616005)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkQyOEN2QnpaS0wxd2xibUMzM2lGMHg4Ym10V1Fhd2V0SVF0OFVEczRQTWFG?=
 =?utf-8?B?ejZuK0FpMDdiVk1zSGMraUlWRis1ZURIN0lRQUxVazZ1VUc1SnpTZVQ2UWUx?=
 =?utf-8?B?N0lYVTZ6bmlsYzhtc0xSMXZHekR0TkRQbDRmenduYWFPdXNUSk9Ea0tUZS94?=
 =?utf-8?B?Ti9nMlhrdkxaZnBuM2Z6VEM5Tnhqa0FqS0RnOHQ2eWhpVDg2QlB2czRPNGN1?=
 =?utf-8?B?M0NIQmZ1TW4rS0orRW4vcWVmZUxFbXo1RjBTakJaYW5MNFY5YkRUVnY3N01O?=
 =?utf-8?B?KzR2OTlibG9OZWhja3M1NVJqZDA1YkxYT2RWSi9BT1dyWmY4TXRsYjFaaW9L?=
 =?utf-8?B?ZnBZaEVOdVlQS3c0d1JkeEtDd2ZCQktGdWVpcWlGMFN2aE9jUXI2MEN1S2c1?=
 =?utf-8?B?czhNbWFWc0hUdU5UM1ZiVVJrWjhmSVE3dHJrTHptajg3Nit4MWFkN2xpdnhY?=
 =?utf-8?B?QTFuMFhOaGFWc296VDk3cXZQYUlQVmRYdEE5cmJDTHhEM1lPekpvRGRFOE1K?=
 =?utf-8?B?SHByRlpncnJkQmplL3U5MkhaNzcrbDhIVDZla3U2clYwVnZ1czdWZmFVOUky?=
 =?utf-8?B?VWFPSzk0ejVSeis5N1c0TDZiYktKRUV3b29kNG1TcGdyaHIvTWpNV0EyaSts?=
 =?utf-8?B?RVJwNW0wbWZ6UTBpWFdsZTNvZmJleEd2WVltU1dWTllMV2cvL0p4ejM5TVlZ?=
 =?utf-8?B?ekE5VnEvblFodnREaUwycElzdFZ1eUNMaWM5UVprTUd5R2szYjNZb1RRWjVR?=
 =?utf-8?B?TFBscVlzVVM5Q2VkSW1ZS2Fobk1nU3RiY2ZEVzFkRGt2NWFMdTd0WHlTKyt1?=
 =?utf-8?B?RXFWSXJqYWlMN1RVVXJsQllncXlsUFFyMjg1a2N6S05jUks1SVRyVkxMRFBv?=
 =?utf-8?B?Q1hvQmdnMEc2ZE9JakNoalgySFdDdExjdU9TckpuODQrMXk5UExtRXgrZFdO?=
 =?utf-8?B?UC9qZmdNakVaT1IwQ0I2cThTZkxONktheDRSR21jb1NkRENNZ0hZSncwWi91?=
 =?utf-8?B?QlJQait5NWFTVU5DcE1tUVZ4dzRiem54d3FwQzFyTGdISEVicnc3b0xJQXho?=
 =?utf-8?B?Q0h5alkrdXYyM1BycVFIZlU3UkFWWWRsVzJBbkJ2VXBWaXZaelZ2QVJjK2k0?=
 =?utf-8?B?OVJMS2VSK1M3SjgzM2M0OUZJdnNlb2Q5VWk2RDVUS1FjaXJqaHlnVXJoc0ll?=
 =?utf-8?B?SnpNRU5hUHFpTVVvdXNCdUJSSmZhZzBncDMwSXNXeTY5MTZNRTN2SG1wWVVk?=
 =?utf-8?B?WlUrVW9DZmhEZVFEYmUvVWgzVlNrU3RhVVVJR0xXZWZwc2VzK1lraGlCdGto?=
 =?utf-8?B?TGJDelJ5RGwraGcySUxKaGJFOEx6OHlOeXM4Zm5UWjMwWG9rTHBiVEQrZzdC?=
 =?utf-8?B?U1pXMCs2UUQ2SFdjbUZxNk4yVVlHVzhjQVMwZnM2dk9YYkN0dys2NEIyY1dJ?=
 =?utf-8?B?SFVXeG0rR0JzTHB3TDhQYno0NmM0TTZ5TkJ5ODVaRGpHRTFZVTZiNTh4SGVo?=
 =?utf-8?B?MFVTczQxOVF1QklUOTd1bU9Kb0VBV0xieWlTS1p0V2tlZDNrOGxwQWhGQks5?=
 =?utf-8?B?U2pxRmwyRkNDdXM0bVhJaitiZkw1TEcwT1Nza0JjRzVFM1NNbjlVU2VDY1Ri?=
 =?utf-8?B?K2U3T1ZuQlhPcjRjZmJieEF3Wk9CLzl4Ti8wbmxwV2FFcEsyN3RzSXlvRURF?=
 =?utf-8?B?UmhUS1NiRWNXeTJWTi9RbzllZ3JtS0hhQVFzU040Q3lmTGJvWHVoTU1MQ2Fu?=
 =?utf-8?B?ZW9mMWFvQTNXVTZVYWRaQVF4RGZzRmN2UXZNa25ua3FFeFlDdEE4SC9sTWla?=
 =?utf-8?B?UGp4T2Y4SjJzeFZnaWp3U1UrWk51UWhNU3JMaS8zUE5nUlMrTUlENWlQdTZ2?=
 =?utf-8?B?RU14ZFRYNW14UEhzZEV2Wm50Ry9JQWJTZDREclpadVYrNmtNaUJHUFZGRzAz?=
 =?utf-8?B?cHkxd0dvalAzQStnVnQ5dU03bm9UMVBDb1NSeS9XU3NnRDN0SlN5OEx4Q21M?=
 =?utf-8?B?dVpHRG5IWC9BVFVmSE5aUSt0VjNldWcwUUwreGlLS2g1SFdTTnFlU0NBcUk4?=
 =?utf-8?B?YkpFVEQrYVpYNmFPUExVUSszditzRlhqZ2FtN1MwNlMrUS9sRW1zV3ZJV0g4?=
 =?utf-8?B?V0ZuTDAwaHhreGxDV1lGeThvZjR4T01JVjVWVGJyTDl3UnJQMUtuV0phbUdl?=
 =?utf-8?B?ZEV1ZncvUjZIMXJoZnU3ckdmaWNIa2xCblk0Y3Nxd2RWdVNGV0xMenNvNXox?=
 =?utf-8?B?VUJrT0E5L0thajVEYnJ6ZVFtckhBPT0=?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 05e492b7-2bb4-4688-b279-08dacc7c0070
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 11:23:38.2836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iEIc0zjMtysOb2ke72aWUuxMyabkb8dsETI8lp+a1n3tLJMq4zeawfRaf0UbQwALB8qcvj1E0GXH0VhtcR2rIJNazwHlpWwSveX+zFjyERc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB5888
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anand,

On 11/16/22 21:01, Anand Moon wrote:
> Add regulator support for ethernet node
> 
> Fix following warning.
> [    7.365199] rk_gmac-dwmac fe010000.ethernet: no regulator found
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>

Acked-by: Michael Riesch <michael.riesch@wolfvision.net>
Tested-by: Michael Riesch <michael.riesch@wolfvision.net>

Best regards,
Michael

> ---
> v2: new patch added
> ---
>  arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
> index b848282ea005..5378254c57ca 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
> @@ -260,6 +260,7 @@ &gmac1 {
>  	clock_in_out = "input";
>  	phy-handle = <&rgmii_phy1>;
>  	phy-mode = "rgmii";
> +	phy-supply = <&vcc_3v3>;
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&gmac1m1_miim
>  		     &gmac1m1_tx_bus2
