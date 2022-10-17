Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6A3600865
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 10:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiJQILb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 04:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbiJQILZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 04:11:25 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2052.outbound.protection.outlook.com [40.107.249.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36785B53A
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 01:11:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OjTzgPxtCQ/qKc+Xju+PLZHvJ3JU58Vy+4qP0Ui5pf/9/KY8LGPUu1OudXSPZ5f0ze9g0so4ap62M18SVn7oCJbRpYRN1JWkPhkGunO/jXpR3cEvOBT7rTo6azPtKuU7aJeS7QRiBUTtCtPdz/Yk5mUhJBI+89oPmd76LU5Nb0IGprhXbqNdV5zZ+/A7JV2pADey4xTKFUUR+Jg5EeoeOHenxLlMiBHX59LTEXOILLWJ3WfOeakwxm+Em0MpqvzNVK/BFHEyrPTIue/GXCsX/8asQLez/FgDfsGXaBrHeeybye8x9F9EzA94q9hlWXh0robe6f04kqqnURB0hV3v/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0dRIsWBMet+7IHjXFEvZshov0850SM1LeuFS1O+Tgs=;
 b=AzjBsGhSEIoACHp8zv07cViY8HGJdVJQpltJfhRd7/NUIlZYQDH/yVXcyn0yj90Qz7g89ajeVgU3B+if12hokKMV+dcRwk594HJLlIPD4BEFY5NFlZYFqqZmH5eZnRIPF5586qi4c8FQMlQ/xUqgDfHtkWDRMPOLFOvOolRmo256XOeuFH2XDJPOoRsQvfTTe1XiqQTpYYme3AUXXgGZ8sbkAVDVxqa+3WRrW3kUit2cOoL57CX6lHdP/H2c7szv44HQ0xXn2iO54f2cNA9L/vKC0ZfiSBY2VjzZlCw6niEijHo17UeWMUfIe937f5oOyGO9whiq3AJvqcCa1qf/6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0dRIsWBMet+7IHjXFEvZshov0850SM1LeuFS1O+Tgs=;
 b=BMNaFIN4lld0gSx9omfnUTTR+SWNG3d4nDp61vXZnwqSbalDHb2PXbRCgYAeioeL81RiJfHdgJulM4ozjiOmv/wEnPAhDkqgS23K3VzOYXJK973MoFk0WC4X9Jyo0KTM5aQ2TevBs4eWARYuezu5MjIt4vaD6HyFHYLv3WKOsQU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB7180.eurprd04.prod.outlook.com (2603:10a6:10:12c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.28; Mon, 17 Oct
 2022 08:11:21 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed%6]) with mapi id 15.20.5723.032; Mon, 17 Oct 2022
 08:11:21 +0000
Message-ID: <5a2e060b-5e97-a1b2-f910-655483b69800@oss.nxp.com>
Date:   Mon, 17 Oct 2022 16:11:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH v3] soc: imx: imx8m-blk-ctrl: Defer probe if 'bus' genpd
 is not yet ready
Content-Language: en-US
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20220919121302.597993-1-benjamin.gaignard@collabora.com>
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <20220919121302.597993-1-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0003.apcprd04.prod.outlook.com
 (2603:1096:4:197::23) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB8PR04MB7180:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d1a0c17-a25d-43a9-7687-08dab0172cbf
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kYwFs5jeqHezeOuEsVpayxMJa0Y11JTZ2Uv5ktiQPDGZnHFX+4Aj6GYPnW4SzZSxHyRvKIWaqSsiRTPV6CRQyeI/gSEVeoDn5ybytOXJRaUlLlTYWD905pyCGda8ydVDW0NvxA8uPoLwbF1z1CCJK0B0wNqF8olpSXzcA41vMcWAtn7b77nXh0G3bD9DC+urbAj3aednukzwnhWMaoOFI7QAkBBsIfqAQQyyLZE20liPbxoA9aTADmkbz1RC5uw1qgwPLzNgf3t022qc7VVEQksQVouvVss+854AncLabiBhFYwyo8toxtkotapo2sg8AHdKrZaRI19uAuzR7b4nQLOaHu0afkNrYjtq8qNUEg1nWJUhmwISllir27s3vg/js1DxDFTZWHIcXewQ+1QBL+a+5Vr4vQHj4M4hga3LDk/B9jafXQCtS7xeOjD/tqGVXCj9OXi+NcXDcFcyZEOEn4f0Ija40Lv8uFmJ8LZR2K3i+EzoOY9VqA2IM2kHFVIFupLgOn4PrnfXC71Jq30tL4WIe7Y4ApZzT0Dhh+UUTAV8D968JKo9ZGqNha+bww/SZFV3+xYuZfsgjj/NfEeXlIeCiyNuNfR2+yi7jKYJID77K1ZHcnM09I2sYH84TueWfhGGB2qtomvzgXeqb8qlIQ7SxlhaTlLE12sofjMjry8xTPxjm9VfKDpz1N5qe4bGV+39X5lTTewlP6gFpRVIzIcVRmh/9fRSiDUeLL8+5dw2wVflcCSXWLSq2ovgtb/XbqT9KnQk+ttS6H+E0t5EJoyIbQjatpx0VzY9HuJVcJJzyNl7qIZEGIysmEPujJ2i6hjV7dTOUCSlmt3vgGCLILX4fkblFouzMofHc4KTDpM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199015)(31686004)(38350700002)(6486002)(478600001)(38100700002)(8936002)(6512007)(83380400001)(31696002)(316002)(6666004)(41300700001)(53546011)(52116002)(6506007)(4326008)(2906002)(186003)(2616005)(26005)(66476007)(66556008)(66946007)(86362001)(8676002)(5660300002)(44832011)(32563001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWJOckx6cDJHRkM5blVkbFNnbDhJejUyUXBWV1QzbVlXQlFVajhUeklQY0Ns?=
 =?utf-8?B?STVzSy9XOGtCaE9RMEY3MW5Cd2NsUGJ4RlhLditGTEUrQit1NTlvOTY0TUxR?=
 =?utf-8?B?cGN3akkrV2kydG9rZVlONEtYSWFEWU5RenFpZ1RGQzBobXdneWd3c2hibjNV?=
 =?utf-8?B?QVkzR2xKa3RUZkpvcXNRNUMxYzNjTzRjWmdOM2NYUmhQWXRqODV0YUpKUHNZ?=
 =?utf-8?B?QVJPdjVuQkxBY3JaZ2VyMEhKU0VWRVQwb2orMFZtaGM2STJuUjJjRTRQWlYr?=
 =?utf-8?B?RzA0b3QvVFBMdTNEbVk5SjBTeUE2RWZXVUNOQzRtbml1SGw2SnlORHdUUzRY?=
 =?utf-8?B?VFl5T20weHV1M3VLWGkzQklWUVBlVHJvS25yWHl0WEJtNDhOUU81aWRGWXU3?=
 =?utf-8?B?QjZSRWRSQ2NsNStISzgwYnQzelBob0t5VTAwYWZmRkcweFFsZ0Q3SmpJSHZN?=
 =?utf-8?B?T3BsaXRwaEkwbkRJWmlLeDUyQldaUkZ4NmdXYzhxL3Z0NWVpa0szS2xucVNz?=
 =?utf-8?B?UVltRy9UbUNGUEEyOUF6M1dIV1RWNXduWFRsc2RLandkWk1hYUk5eDUvczZ3?=
 =?utf-8?B?YXQvRStiT3Y5dXVyTTFpcXVGMUNFNFRRVE1hUHFyTGQ3Z01LbE9FdmJaenlN?=
 =?utf-8?B?KzB2YUJJdTdodGVtQXpVL1BQMHpNeWJleVcxMWNmdWpYakJZSnBoT2FKQytH?=
 =?utf-8?B?bXZ6YStkNnJTWEtzd295QTYwY1V6MllsMVpZWWIyWlpCU0RpbEphTTcrSllo?=
 =?utf-8?B?UDJvRTNxamNqV1FvS282c1lUeTFFazc4SlR6V2IySjhob05BbmRvTGNCanZu?=
 =?utf-8?B?UkN2QituVjEvL3dWQU9FbEZPcTQwN1N6YUw4ZkN6RlE2VjFLK2F5SExhcnRn?=
 =?utf-8?B?MWZQUXM0czk5dU5TY0RQd3NMZ2ZDRnFJd0V6ZjJsQStUY0VzMkNqTlRSbVdp?=
 =?utf-8?B?Rmd2dlBOSno3RHlxcHdvejZ5c0dTVnFrM0xVcFAzc2JSeTZUdk5BaTBCT3Y2?=
 =?utf-8?B?NkpFUzRnck14TjhDalQwWEVxU1JvbzFFL25MK3prU3hobm5Pd1Z0Skg2Z2hp?=
 =?utf-8?B?d3YvUHNwZUpUNzdtQlpqM1lpOXpsd015KzhPd3Y0OWFCeTNYNFNZa28yUy84?=
 =?utf-8?B?cHZRQ1hDa3Q5RDJYdzQ1cmF3dG1GSjRoK3V1bi9MK2tWTGxsVjFja3VuOTJN?=
 =?utf-8?B?Nm9CNmpmVjZoRzdZZ2hNNHJ3ZWhRTUpDTjl5OWtTeGpCL01ZdHVnOHA4Y3pm?=
 =?utf-8?B?V2IzZGZTQTJkRXVnWG84MFoxSjR1bEczd0FCZlA4M0ZYcFliN2dwQUxVSklN?=
 =?utf-8?B?UUdCR1g2bVhDU1FVb1hRYTlmNlV2TVYxNVRydHNHMnJiV29IVlQwdmZnRCs5?=
 =?utf-8?B?azVTcWdlM0MraHRyQTMvWFZoMjJUTlgyNzRXaUlPMXM2cFpjSHp5dXNKSlVY?=
 =?utf-8?B?b0NCL1o5MUR4WG56cnVEdFhsWXpxWlJ1MkhXeUdYaFMxU0xUM1FQSVBicUFx?=
 =?utf-8?B?NEdMUjhhemR0dGZCZXYybGhRZ3BhZzV2eHZNSi9hNjFiekQ5Qkg1MWZFOW1z?=
 =?utf-8?B?ZUw4dUx6SUp0QWRENUd1TVI5b0dER2duTzI3ZWNqcjRFSUtFZ1VGd3VQd1pT?=
 =?utf-8?B?QzZkNUxKcDlJWGY2LzIrTnRFd1B0TTN5U2xBdndUMlFXdzdMSGVtNDZ0aTBt?=
 =?utf-8?B?elVvUEpJeFRBL29Ob2xUc3o1Zk1LcjFwZmZrRFE0Y0dTeGE4ZkdPZnVBbWdP?=
 =?utf-8?B?QzN3ZXdMZTkwNGpjdmFzaFMzcTRXRXYzWi83bkZWU3JjSmViUzRoY21EMERN?=
 =?utf-8?B?d3NYSWR4S2J2V0d1MHZCWC82R0czaU5keEtES1FhRER2QnIwRjFKd0FxZzhx?=
 =?utf-8?B?cmlJZzN0STl1NGp2TFFkUzBDNlMxelJUKzJjM2x4cndueXAzaDdmMXVOdmtM?=
 =?utf-8?B?dkQyMnZIb3dLNmdUczMvVncrYUQxejdENjJZZjFLQ0xSa0JUQ1FNT0JpbURX?=
 =?utf-8?B?djdlcHdQdHViVXh0OVhKSWoxL0ZZNXIxVnNzQ1NzOHc3VG9tTUtwdmQ2MktK?=
 =?utf-8?B?Njc0UHp4U0FXWWxkanVOOHFQNk0rcDRqZ0lKZXBnc09Xdlhhb1BXOTdsZSs4?=
 =?utf-8?Q?3VStKRL4aGwed2BL9B0Pyat3A?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d1a0c17-a25d-43a9-7687-08dab0172cbf
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 08:11:21.0810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R0IEQD/PlH5hHv05P2IEN0TcKzzZq/25/m0tW0RmC1f8PDyiIGq5tJP1z4bP+i3OfZ0XOjSqT+h0WzzC1K42VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7180
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/19/2022 8:13 PM, Benjamin Gaignard wrote:
> Depending of the boot sequence 'bus' genpd could be probed after imx8m-blk-ctrl
> which led driver probe to fail. Change the returned error to allow
> to defer the probe in this case.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
> v3:
> - only return -EPROBE_DEFER if 'bus' device hasn't be found.
> 
> v2:
> - keep dev_err_probe only change the return value.
> 
>   drivers/soc/imx/imx8m-blk-ctrl.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/soc/imx/imx8m-blk-ctrl.c b/drivers/soc/imx/imx8m-blk-ctrl.c
> index dff7529268e4..1c195e9e8895 100644
> --- a/drivers/soc/imx/imx8m-blk-ctrl.c
> +++ b/drivers/soc/imx/imx8m-blk-ctrl.c
> @@ -214,9 +214,14 @@ static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
>   		return -ENOMEM;
>   
>   	bc->bus_power_dev = genpd_dev_pm_attach_by_name(dev, "bus");
> -	if (IS_ERR(bc->bus_power_dev))
> -		return dev_err_probe(dev, PTR_ERR(bc->bus_power_dev),
> -				     "failed to attach power domain \"bus\"\n");
> +	if (IS_ERR(bc->bus_power_dev)) {
> +		if (PTR_ERR(bc->bus_power_dev) == -ENODEV)
> +			return dev_err_probe(dev, -EPROBE_DEFER,
> +					     "failed to attach power domain \"bus\"\n");
> +		else
> +			return dev_err_probe(dev, PTR_ERR(bc->bus_power_dev),
> +					     "failed to attach power domain \"bus\"\n");
> +	}
>   
>   	for (i = 0; i < bc_data->num_domains; i++) {
>   		const struct imx8m_blk_ctrl_domain_data *data = &bc_data->domains[i];

Reviewed-by: Peng Fan <peng.fan@nxp.com>
