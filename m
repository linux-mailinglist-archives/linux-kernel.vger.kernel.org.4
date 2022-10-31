Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531036131BB
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 09:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiJaIb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 04:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiJaIb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 04:31:57 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2086.outbound.protection.outlook.com [40.107.249.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3185F7D;
        Mon, 31 Oct 2022 01:31:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gHsAcYhdHbgcYiHE92YCrVL7uzMJ1GPa6PfK+HCoznF/wbHGBF0x9GFieFyY5rkvQsrmVvKMc8999GQ2nfnKAoctkhfyigw5c3RHZLGIP9YIdn8Dj6lNyQN8Qh26GbfncKGIjwKwJ9tShnFzw1KtHQLv0U26j8TI87IXEyHrtEbE54H9ecEStpgiDQA4hu7GCjkMXISVQy6ndCg4h7tKitFv+3mgJqERFxNPWF49bZLwAHz+yz27CthJLc8a8JrXxW3BxtbXpusgNOYdPRak0E0NIGtJZq5wrTNLaoA+2pyWW53JMgyV/5CnHOEjeodmQHjpv2988ornm4pSby1kzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YDa6Fvq4iY0XEMxqzjiT8D3wG+8xSAYO8d2vqD1f490=;
 b=AJfqdHU4imFvtma9NMqNz/1xi7N/gmIQbOD2kHuxTSVS/NfaxewimuegsoUHJNBCiLSlRSAT4zI7VFc/jjd0VTLXsxkG/jZBBzkZ9jSNT44rufubq2d2VsKloDp9w3487YOLoCrLmoUhEMiEdD88nYF1fQTnvaBOkxwNIFFXbAVK1HiCJ5tvS2PDBvd//AVzD0QPazWDsBl+y82slFFp52Jn181zgjiDuZcU2lwVKSr0118MZv2iDv0d1WaLTzNaCYP4uDTeCt4MrYBrdS58VefBO8XvBmTJNCmfXqIoR/HWNJWrKDd+Z6n/5F7BLeLmAwGCryJhBGr+mKtD6iYHMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YDa6Fvq4iY0XEMxqzjiT8D3wG+8xSAYO8d2vqD1f490=;
 b=pHBlL8cZAI+xtgAlURjxVmEcymrMu8wOzLlpPAxZLOjZ4I5pyNItuCnFDLAsu+/5REygARKqa4FG+tfjRVCdMkMK3h4NwE4EqrLmdIJDbgzRZ0t7KxndW2bAZK4DFa8YqEvsmfxstCXGhG0QD0Y/tFeFRD78aBlNbnZ4MC0blM4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by DB9PR04MB8463.eurprd04.prod.outlook.com (2603:10a6:10:2c0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Mon, 31 Oct
 2022 08:31:53 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::dcca:b62f:206b:dcf8]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::dcca:b62f:206b:dcf8%3]) with mapi id 15.20.5769.019; Mon, 31 Oct 2022
 08:31:53 +0000
Message-ID: <55b3aaac5085761c2ac274f9faabd252acdd8418.camel@nxp.com>
Subject: Re: [PATCH RESEND v4 0/2] drivers: bus: Add Freescale i.MX8qxp
 pixel link MSI bus support
From:   Liu Ying <victor.liu@nxp.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, saravanak@google.com,
        gregkh@linuxfoundation.org, geert+renesas@glider.be,
        krzysztof.kozlowski@linaro.org, robh@kernel.org
Date:   Mon, 31 Oct 2022 16:30:57 +0800
In-Reply-To: <20221017074039.4181843-1-victor.liu@nxp.com>
References: <20221017074039.4181843-1-victor.liu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0086.apcprd03.prod.outlook.com
 (2603:1096:4:7c::14) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|DB9PR04MB8463:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c2ccd15-93cd-4cdd-de61-08dabb1a5ce7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uKHKJOAkFKQdU0X06+rwq/xxoJbvPnX/QnPsolkY+HqV9yoAsPftgdsbOMc7JCevqaRwRMRz0ybRAF2mFZpm6H5p0cCs7COvXbKOr9Jb+2FcD0i+Se/XuE/RSgAeP68C+YRVGRV8s7tp6FREkltj9dgxwpSue+1M6zZvlHEKbRzU31GlYEPqqBDzl+oxyAixqumdjp8tEQLRYh/H11cIwCL5sAnJGRqkEOxclc8SA7AcPLhDly093lMabcBlXHZV5sN9BBdmEovJjh64YE5EQRmk62ANYHHEhqc6tMi7KitKDxuelZoYxy9gCOeB9nJWUDQG2K0FiUx43H1xba54vM7uaTCbIMH6zVsoI4qQkKqwVl2cxrxjUz/mREekXCpF274r/bYim4x9EflNHhmFw4zmGUogUOKje7+/KvwUeXaU0SM5chB6Q0XPLlfODTtoRwh6xoI/+o+nXplgOuMBa+ZVvAaeefRJhsUST3S2UwzDNuuk138UaaESWW+D1K9hhpahQzVc8LxFUpk2gliQb6YqdhKQDahmi6jNTLk9h8seWL4trFQ4Vb/jYTj6EU/va2QOid0PI0fBwDbQMXh2AhkS1BpFwJVOpqGxkBK7xqU9Vi5lcZJ06UwMMnmBaj1T0/HahK23g1qjpHDnTNtliGqWBUWZPOr1Yqg6oyjPQwK4+lNdOFwBPR/zA77hmD0nWwpf5EwNh3wpH47H6Eac5/kM3Mk9inqxL4buMBFhk2CjHTl1YGr0UJkn1KtrfSmacp5TSZGjwvSri7KwCDbMBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(39860400002)(376002)(396003)(366004)(451199015)(26005)(41300700001)(6512007)(2906002)(4001150100001)(36756003)(83380400001)(7416002)(5660300002)(186003)(38100700002)(38350700002)(2616005)(8936002)(86362001)(6486002)(478600001)(52116002)(8676002)(66946007)(4326008)(66476007)(6506007)(66556008)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTRaOFl1ZGdJUGJQSkxBWUFFVE1VRnRtZXdYTVZtcnVKTmJZUFBCRGlSeFJi?=
 =?utf-8?B?cDB3R3VXcmFOWHAveTFDMWNmMVpmQUJaK2sxdC9VREorV0h0SjZuQXdBZk4z?=
 =?utf-8?B?eXNrWExYNnNIRUI0WGtNMUtRbFp5VWNaeWhKM2hMcGVKRExpRXpEUTdnajB5?=
 =?utf-8?B?UHgvQ0xQZnExbHhtSTZiTVpVeGt6TTF3TUFFdnFxenJzdHF2bGxTeDJHSU5K?=
 =?utf-8?B?OEgwMzAzMnp3NDRhWkVFRkRDZUQxempWengvemY5RU84QjJkK0lZTUdXSHlC?=
 =?utf-8?B?VEt6OUpjdEVYT2h6OGRpa3NrMVh3NHZxZ29kKzJzRnk0Q1ozYzV0ajR0bEIv?=
 =?utf-8?B?ZHJudjhaVGNJd3hmR1IxcC9RazVuNVJvcVpia3Fac2JsalJuMHo4QjNFaThs?=
 =?utf-8?B?Um5LbmxpUE0vMTBnYlY3UjJkM0t2NUNpalZnNS9mVktMYzUvTTl4ZVdZdFhK?=
 =?utf-8?B?QWJOMW1nT1VGcndTVVF1YWc2aitRVm5hWlVGaVJwak1Xc3RxZHNac0g4T0Z6?=
 =?utf-8?B?bHBPdVlleEZ4eHdBNy9JcW4vUHdTc2tPcUlWZzlkQXg1SWFESTNvelUxYU11?=
 =?utf-8?B?Qk9SdzhkZDNoTGdPMWpCdytEQ2M5MmEvdnJmdzJ1WmE1VFRycEVJRlZEdmEr?=
 =?utf-8?B?TExLVk83cERPTzUvSTY0RjRyWFNETzh2M25yS09HTjFzVXNZZjFSQU9HSVds?=
 =?utf-8?B?dGdSbTQ1OElxOU16TTBsVW5Xd2J4Q2RrdkhXbTY0MnA3K2ErZXp4NEVIMUR3?=
 =?utf-8?B?dXEweWw1aUFhNjZIQXhSYU9oZFgvL0MrTWNWNW1TYzBTSWtJbC9QSFppVWZi?=
 =?utf-8?B?dXFabDFlRThEK09MYWIvYzRkNXR4V0paeDcrQXRzNVJ5UTQ4c3hZSFNaRTNj?=
 =?utf-8?B?QXliNTJSMWlxd0R0b3NGRU9pMHpvUi9xZFc2RGZXZDliVXpwOXUxb3lQTnNX?=
 =?utf-8?B?SDZrekpoL2VrcEZxdTRqVER6cHZ5OUlsanpHbHNXQ21hTThVWWxVRTJCQUNk?=
 =?utf-8?B?dXZYUHNnV3VsZ3BJVll4THBUN2M2OFNGWGZQN0xyZmZkNWtFczV5RzBWVlV1?=
 =?utf-8?B?KzV5VndPQytBL3I4STJtRUpiMUt2R09nZjBjcTAyK0JVbGw1VjR1clAwWmlP?=
 =?utf-8?B?OVBQbmg5Q1lTcEdRU1VyV0kxSnBaZHFEWllnQnhhWkFCTGpQWHRjVUxoK3Jj?=
 =?utf-8?B?S2pmMFZ2NWxFT2Z4bytwRTRWSTJYWUxKZFp4Zmtrczg5VXZTK0hTdzk3TXpR?=
 =?utf-8?B?TFdBdGxVekpza0N0YkVnVk8vQVpTT3lNUmFLbDlzK0NBOU8xRUlvUHpCenli?=
 =?utf-8?B?REpIbko3SThRcUMxNCtlUUlhYnJjeWxQa0E2NU9lMVloTVJEZG1MQ1VwL0M0?=
 =?utf-8?B?VlVRVUZ6UVI1Rlo2WmQ2aDBaelo1WTBOMngzVEVFOGZDZHZtMEdTMkxrNytG?=
 =?utf-8?B?Qm04YUlNdVRRbjR5a2krSCtrWXBib1pjVllQRUhLVFBKN2FOczQzRUlCRWZx?=
 =?utf-8?B?NkdTby83b21Jc3F3NzNrVmhZY2ZtR3Zsb3R3YmhmUU1WYXNEeVNHWU9yd2Ru?=
 =?utf-8?B?OFY1Vm5wZTVKNDhTT3Roa0N1TlY5bnVtT0hGQVpjY2RCNFBJTUJRblhEdnp4?=
 =?utf-8?B?UW9aUVRFYUtJZTMydit1Sy9JMVRkcmFYcG4weHNlaFhBdnRTbnFzdmVobjJn?=
 =?utf-8?B?d09xZ1FQTlN1WFFoeXd4V2RxdS9uSGlpTlFBZ1E3c1g4UDlrbmp0NWgrNXJC?=
 =?utf-8?B?NmxZMzVFVHpwMjhPMytVVkJZWERqcTk5amJ6WmpTRE4xajhXTm9XSTh1Y3V6?=
 =?utf-8?B?LzJ5bzMwOEVDUWVsYXpuVDVWMGVCRDZkR1I5YXY2R015bFd2TmY0UGVndXIz?=
 =?utf-8?B?d0R2UkIrMU12Mm5oVVRBMy83ZEVNK1NsckNydU44MWh3WTZ4eUtXbDRMWCtP?=
 =?utf-8?B?V1EzR1BEMnhiUTMrWHFzSWtYV0JtU3hkZmsxV2s4YlJ2K2p1dU9JUnRuYzdN?=
 =?utf-8?B?c2kvTDVmVDhrRGF2a2Z4TDREd3U1U2JqTmZqNWYvVkRJeW1EdWw2YWVOY2J1?=
 =?utf-8?B?L3dGSzFhZzVQTlRKOFQvakc4RE1jVkRNUk9UUkRQSkttNS9GUS8wL3AwWFcy?=
 =?utf-8?Q?rk92fdmq7+w+uiMoRrmozA/jp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c2ccd15-93cd-4cdd-de61-08dabb1a5ce7
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 08:31:53.1245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VfrNZvCobqHEuH75Y9MaWs2YfKxxQsGXlRvzFJ6yFnBZb3qHkcMhC6hOWUZnV45E5rs/0PUGEBlVRPgLy4c4Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8463
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-10-17 at 15:40 +0800, Liu Ying wrote:
> Hi,
> 
> This series aims to add Freescale i.MX8qxp pixel link MSI bus support
> by using the existing simple-pm-bus driver. A power domain and two input
> clocks need to be enabled before the MSI bus accesses it's child devices,
> which matches what a simple power-managed bus is(See simple-pm-bus.yaml).
> 
> Patch 1 enables/disables functional clock(s) as a bulk in the
> simple-pm-bus driver when the simple-pm-bus is being power managed,
> since the MSI bus takes the two input clocks as functional clocks.
> 
> Patch 2 adds dt-bindings for the MSI bus.
> 
> v3->v4:
> * Drop patch 1 in v3, because simple-bus/simple-mfd devices probed by the
>   simple-pm-bus driver should not be child nodes of simple-pm-bus at all,
>   as simple-bus/simple-mfd's child devices PM operations cannot be propagated
>   to simple-pm-bus. Those simple-bus/simple-mfd devices needs dedicated drivers.
> * Drop unnecessary 'bus == NULL' check from simple_pm_bus_runtime_{suspend,resume}.
>   for patch 1 in v4. (Geert)
> * Add Geert's R-b tag on patch 1 in v4.
> * Add child nodes in the example MSI bus node of the MSI bus dt-binding. (Krzysztof)
> * Resend v4 to imply this series is based on v6.0-rc1 so that there are not any
>   dependencies for the MSI bus dt-binding. (Rob)
> * Resend v4 based on v6.1-rc1. (Greg)
> * Add Rob's R-b tag on patch 2 in v4.
> 
> v2->v3:
> * Add a pattern property to allow child nodes in the MSI bus dt-binding. (Rob)
> 
> v1->v2:
> Address Krzysztof's comments on patch 3:
> * Add a select to explicitly select the MSI bus dt-binding.
> * List 'simple-pm-bus' explicitly as one item of compatible strings.
> * Require compatible and reg properties.
> * Put reg property just after compatible property in example.
> 
> Liu Ying (2):
>   drivers: bus: simple-pm-bus: Use clocks
>   dt-bindings: bus: Add Freescale i.MX8qxp pixel link MSI bus binding
> 
>  .../bus/fsl,imx8qxp-pixel-link-msi-bus.yaml   | 232 ++++++++++++++++++
>  drivers/bus/simple-pm-bus.c                   |  48 ++++
>  2 files changed, 280 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/bus/fsl,imx8qxp-pixel-link-msi-bus.yaml

Gentle ping...

If there is no more comments on this series, can someone pick it up
please?

Regards,
Liu Ying

