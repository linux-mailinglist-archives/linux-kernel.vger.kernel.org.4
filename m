Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F027006CD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 13:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240895AbjELL2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 07:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240333AbjELL2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 07:28:21 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1E41701;
        Fri, 12 May 2023 04:28:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gHzSHdxI8l68FL/E8dnI3x4wnhzaTGX6yPwpNfD0gNeaLN+vSqCC0m8UJSiRnyR6EZcUiE85J7WblYLIe/sBb5y9yiWdtZvux4Zf5QUxtpC9jxPRG5A6ywiwWagFd+nmI4NM91ZxgM4rbAmb/JHQz/NZgPN3z06J4Ukpfa/GSC6F4IjbQC+j1nVxK08YwFZAZSf+mrus313RdPc8WxrxIwXgk4J0aLo3M53wcNj/Cs2uNJ0FcQMM/fOh015QBLuRMHm6wzshmA8O8YZPcG6Z4TAP4ppoEmLjW6uJD7nbUEAp7rpjd0SOwdsAsdBb58eeCi3wKkWvettYPRD4anB3bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yqHjEbmOGx845xKcbrbp+MlbSOpDxtgFbgMHreXUfC8=;
 b=UoaZpShK0EvECqdFqvwPJPqwHoiPbZZLIbOOXxOewE5fcTMAqgtLvJep4LtxWahoWoOYYvkQaL3JQEFSNi/7tJlRD6XJldnt6+q2ku0WMmUp6VEBhicM2aipV2uL6PT7sEyJ7sjWGKAqJi7IGIikVB8R0gOjCLL9cek63x6XYP6/JIamhlOGKDE7j6tqqlgHt357/nuko8Tk/clOyX7rTrPtTkhIxWFzNfUUiYTfaciCevRqClyiMVcd/9b256p8oDW/nwVIDbB/SaRYAyAIbbHtKTqaLfEJex53FNrhkYH+YbuHsAa885kF90mMEUU1ypsVBHb+oY2x+1qClvzMLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yqHjEbmOGx845xKcbrbp+MlbSOpDxtgFbgMHreXUfC8=;
 b=FMj+UM1dHpbHezWx9EAvNe875nD+79BigxxgqBgtc+ZTxKPZVYG74sSs66j//Z67qt2exBtkHnlgPZtdoUJpL8qQ95XTrph4L85k1IFnv6jQtF99Ql+7YfSaKTYAI82M7gpE0yUoANOoItDKm1tD9cG0jU/hhEWQ5ECg/vGj88M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by SA0PR12MB7001.namprd12.prod.outlook.com (2603:10b6:806:2c0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.24; Fri, 12 May
 2023 11:28:16 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::e78e:b7da:7b9a:a578]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::e78e:b7da:7b9a:a578%4]) with mapi id 15.20.6387.022; Fri, 12 May 2023
 11:28:16 +0000
Message-ID: <452a60bc-cb8e-b5de-4317-c107521db7c5@amd.com>
Date:   Fri, 12 May 2023 13:28:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] Revert "arm64: dts: zynqmp: Add address-cells property to
 interrupt controllers"
Content-Language: en-US
To:     Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Harini Katakam <harini.katakam@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Tanmay Shah <tanmay.shah@amd.com>,
        Vishal Sagar <vishal.sagar@amd.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <e3312910db0922bb8c24a8e681de41709ca11bdf.1683035456.git.michal.simek@amd.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <e3312910db0922bb8c24a8e681de41709ca11bdf.1683035456.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0068.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::15) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|SA0PR12MB7001:EE_
X-MS-Office365-Filtering-Correlation-Id: b11148a8-c012-4b25-c508-08db52dbfae6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B6rgwSYr8FlKSYo7PzJ/KJHX2OX1+ULJIxTVKrQFxlwP/8+C+aXSewvy1VlT4nNnYFeOkwPcPaqVmBORJRS8vTx5wkw6XTc+k3eKEkaSl0A/4fn+mZkdvCGoRRlCFq6w3QUp5GSPLhljF89jtHEG9xGZvNyM4gXE6K8TWvAfy87ae2FVBVvDjbjJj2qP7uyD6pYsqiFpGauOLImEqnmHb1+RdsvaEnv9ge1tnRC/+kSsEcdQKCqWN2Vo03F6R/Zo0HepXbyfwfzAj8e7d2rfk9tiRufdFieIJWBNWTyPOQQJh9gBNWeOut9IMidzBmTnO2vhsCaX4wQpz6A1ntRRkeUkJqqISfIbmUMWdZsjjF0GgY0iXFm8IF7Ni/L6zRaOyF6XHjZVYnmVdXS8EvExQaGc5ZUkU62BTHiU0Lpuf2K9xNZcU19WsOGXE6gVya5jBClmOY4k010rCosTW5pkmgdNO5GdL8jSiTxxi5+ibcWsj7+bjhbWiBoBLHTtXh3tWRr3uW5K7WVu2KZB3mQQT3EHFB5BVfDpyA1fRXHmSkA0FkO5ppqKLnCv6Xuz6dL8TcJIXsEYtcYw6ZXZXUGVb/ZGXIvCauIO04qg2mv77WKz/qXQRIH7NApFiP+SAwI82NBK1lT9LyiLUkMJPDparg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39860400002)(396003)(376002)(136003)(451199021)(31696002)(86362001)(36756003)(966005)(54906003)(316002)(66476007)(66946007)(66556008)(4326008)(478600001)(6486002)(41300700001)(5660300002)(8676002)(8936002)(6666004)(2906002)(44832011)(7416002)(38100700002)(186003)(2616005)(26005)(6512007)(6506007)(53546011)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Uk1DN3d6WG1rRWNSY0tIampEeEQ5UlZBU1hPbXVWTXhvcHgxM2pSc1ZYQjc2?=
 =?utf-8?B?bE9GMXZhQ2syZFE5Q2YwQVdXNXpnaW5YbWl6cWIva1h6K1lyTE9XWVZUbmRs?=
 =?utf-8?B?VTBPZlViTkpHMTlkUlh1SFdDSkVhek9MUmFxbmh5Q3E0VForWVg1THovWUZl?=
 =?utf-8?B?d0FIaUFEZGNGb2ZHTHJSZjdUNFBFSXhEVVp6NGZNT3hTWDZGMkJZZkZJU2o0?=
 =?utf-8?B?ei9ZNG9aQllxTXFTc1VTb2ZqdGwzRmdjQituWjhMUFFkN1duZmFIbHlxWGJB?=
 =?utf-8?B?MXBrQ3ZHMGZHNm8vd3docUdXVjM4a1FUb3BiUnJNMW1mQW4yd0gwVTB2TkVG?=
 =?utf-8?B?Q0R6K3BmVXVibmlXelBybzIxNXBwaW9LRmV6V2pHVW5jWm83NjN0NzJkTlFs?=
 =?utf-8?B?akRSQzUrR0hheDFuNE1hbWRlR1B6cGxWUmZQV3J3TFQ0U2lrbXVieDRqNWFo?=
 =?utf-8?B?Mlh6dXZFcnV5dndOQy9JL2dwREt3Q0JZOS9mbllDL203UmlPbXh6SGI1RGhU?=
 =?utf-8?B?ZGNlS3hoMXQvbHg1Tnpva1o0a0M5RTVoeHovbUt0eHNydklZMm5VS3FBWTJj?=
 =?utf-8?B?cDdYY2IvMk5DOXhzSzhWZXA0cWJSWC9BSkdCQ3UrVGU5d29WZGZ5V0VtaElO?=
 =?utf-8?B?WE1SaUJqUlRERTk2Z0M4b3RsR0wrUXFObmJBbjhNdS9uRGYwUDFBL0l6cUlH?=
 =?utf-8?B?QWNGSXplVXFVUDBDaGVlWndpZllZOUR1c3g0NzNnYmNqd0k1cUJ2SWJPTEN0?=
 =?utf-8?B?d1BiLzU5bFh3QWord0dNcFdPUCt5Qzg1b3VzNkdFaWgzbDJ0TlNQeTFoVDg1?=
 =?utf-8?B?VUFMaFlQSDdTQ2NxMHNWZWs1cG1vMmZlKzQvZldVc0ZhUnVRTHExTkhKSkRC?=
 =?utf-8?B?cko0S2hNVkZUMVlzWmt5MXVWY1R6RkJQQVJ4T0FsS2JxZjJqUkhVaFNRbld5?=
 =?utf-8?B?NEUzcVY4Vlc4R3lPVVZkY1lFTDRWMUdLaEhsYjdCMkV1UzZEOXU5Vml0RkVF?=
 =?utf-8?B?cXNPc2lGcmd4TTFydWdxbThEUTVXajJROFU5WURjZzhiRzUyb0JmY21WRlFX?=
 =?utf-8?B?dWZHUERmd0p5SkxZOE1uN3NKd05QSjB2TmtiRHBTVjQyY2gwZjdSM2x1Z3lO?=
 =?utf-8?B?cmtZWGRUbi93MDd4bTJ3T0dZbzhWVlJ4RVRxOUpScDBscmdNb1BwY3dVMnVi?=
 =?utf-8?B?dXUxQlBodXpBRmtEdkYrUVJwMHRUVCtVUDE0YmVSeVFuSnI3a1B0RDJvLzlq?=
 =?utf-8?B?aHlIZzhIWWxpSU4rWm55SW9jTEhmRnYzSjBXTDNhMjFWNml5Mk5weEVFU1VQ?=
 =?utf-8?B?U3lFblhNRFpNN0MvQmV4K0xPcHRyRnIzK1ZncEIyWHNQTGJGOHVqeDMxcWp6?=
 =?utf-8?B?ckZPUWFqaCt6NGh3dU1iUkpqSGVYNVcwK2tUd3J0anVhWXI3dnBFbk5FKzFQ?=
 =?utf-8?B?ZXdzNWxScTZnTEhZVk9WaXY5dVNuRFVHTWZ2QkM1NUVHREFZRGhubFJxUjk5?=
 =?utf-8?B?MTRQeXE4QWR1VXJjc2Q2QnBGdUl0NUwrWTBpZ01wWXFJWFNmMHd1ZlA1UVE2?=
 =?utf-8?B?bU5qaU5Pd3NiZ2FvSGkxNFoxVDJ6SEhYN2w0enpxZllFb0hpNDk1MHZHSHll?=
 =?utf-8?B?dm1TL0FWemlrZm82aThhaEdveU8waG5jYXJCUzhQVFhYUHJFQVV1d3BYa21M?=
 =?utf-8?B?RlVLQ2U3ZTZvODUzUXNlb2gxRzNzY2M3S3JEak1JRlUyUUVtRVpXMUhDLzcv?=
 =?utf-8?B?aWVyNGlHeU5RVHR0d3NFS09wWXJLWVk5U3QvRGZ0V3dmUkIyQ25yS1prQXB4?=
 =?utf-8?B?SW1kdEhTWWJWSHg1Y3RRcEY4c2NLL3NoU2M1eTFhQnVRM01jeDZmTjJJVVVt?=
 =?utf-8?B?WDNNREcrNzJKRlgyNkRZaC93Q2N5R1krYUlqUTBZdDBpbWd3ajl3KzFSOG9Y?=
 =?utf-8?B?OXFLWCtWU3ROOUtUdlRvYWFRcUdRWnRXRzZWek84Um91ZjExUCtWREJsQjVB?=
 =?utf-8?B?Zko4NnJVQU5OQzVFVGxQMS93T2pETXJXMjNhUzRIazNobTFZSEFzQWEwQkcv?=
 =?utf-8?B?aGg0MDkwVndkQlNGdXlhNW83aWttZTd3NWxSaDVmZStROG1VaDdlNkhDTmYy?=
 =?utf-8?Q?9QB3iYkaLJ5x9qL4p51mUPe3H?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b11148a8-c012-4b25-c508-08db52dbfae6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 11:28:16.7540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NpeYV4Wy3S5V97TrsuU67asYtm8VVmpA+SrAxqw1ncHY0/M32zaMaGmRrtGO7vSQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7001
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



On 5/2/23 15:51, Michal Simek wrote:
> This reverts commit c6badbd2d321c19d4f55ee56b0ef12bb3352feac.
> 
> Long time ago this was discussed with Rob at link below that there is no
> need to add address-cells to gpio and interrupt nodes that's why reverting
> this patch for ZynqMP.
> Also there is no visible DTC warning which was seen in past.
> 
> Link: https://lore.kernel.org/r/91e3405245c89f134676449cf3822285798d2ed2.1612189652.git.michal.simek@xilinx.com
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> index 51b8349dcacd..2d564ba7e9e4 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -419,7 +419,6 @@ fpd_dma_chan8: dma-controller@fd570000 {
>   
>   		gic: interrupt-controller@f9010000 {
>   			compatible = "arm,gic-400";
> -			#address-cells = <0>;
>   			#interrupt-cells = <3>;
>   			reg = <0x0 0xf9010000 0x0 0x10000>,
>   			      <0x0 0xf9020000 0x0 0x20000>,
> @@ -633,7 +632,6 @@ gem3: ethernet@ff0e0000 {
>   		gpio: gpio@ff0a0000 {
>   			compatible = "xlnx,zynqmp-gpio-1.0";
>   			status = "disabled";
> -			#address-cells = <0>;
>   			#gpio-cells = <0x2>;
>   			gpio-controller;
>   			interrupt-parent = <&gic>;

Applied.
M
