Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFC35F5F6E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 05:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiJFDTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 23:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiJFDTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 23:19:32 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20056.outbound.protection.outlook.com [40.107.2.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916AA89925;
        Wed,  5 Oct 2022 20:19:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hP291Eo868bHOwSe74xThkTKlF9De10ci4dN+rjQAzsosiHJDGfDqEnBls1ip3Lr7OL7rFfEsUAcIitnGfGmfv0GSCwaRedt2VZM5alw8SnaTHWi1Pvf3BmWKSCyD0P0PGdVf3gSjhUr0W2L1mltoMmmUYsQJmxIkzyQidXtBLYWgfjdBbzC9kPEB67Z2L2axzNK1fjJ/JQ6Cz5VPSfYhvJKuWkkJdvH2ReNSccFZr6UXJtu0eVUdha/NqukCRFUWvTtoQAKX1oGnQddlKF9kKao/g9p2kJcdQ7wHfDS2+jvzPWzuLELJcAoaZYozEJHs3RZuAyRJXn0FWKnWdVo1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0KZdXS6CjGosjKKNIwjjR2EoHfMERw4URnQ5naL2BEg=;
 b=PV5aaa/71QN/x1TsDV9TVQzE6VoZNxGTki8/FU/XeNFy2SUuUdZVPzIBBz1ScOon43kjZgUT8YdVK3q8e4PmlsvAGxwK8K9W+KJq8pXxRNa8fNjxpeFzgYKRf001395GziTKnltmarUBh+eQnlG3fdL7ziFKFe7AEBU3CRKXeZ+LHNfiefJOruPRhRfdFqDFnJsTEVflqEGPXZjsNsCkfbBfkr43qPq37JLq3zieoLKvZmXWa20IhTkhCjwVfoZBQqJWO4vryaAKmrDy8f2W4EJoTMNUJPOpXduQJTzxtrdIjOSTShUJjmL8cAFniu47K8Fx/Dbs6LwS3Epl38zroQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0KZdXS6CjGosjKKNIwjjR2EoHfMERw4URnQ5naL2BEg=;
 b=HpuOwDV5lSnfprwXuFXmfm5I3V8OCyV7iFLeFn9V936uUZBMljYHW+A2EzZQJ+hwFSrsvjx0Hj8TRqYUStJo4mBoiuorq6YstTaflVRNz4YjO5xF5bLgKP8xJF75Xu+84xtgRnOsa5l6zbF+JNs9ZuAZllZYFB9jEeGzYu4+WGc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.32; Thu, 6 Oct
 2022 03:19:15 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::181b:75f7:dbc8:b4bc]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::181b:75f7:dbc8:b4bc%7]) with mapi id 15.20.5676.031; Thu, 6 Oct 2022
 03:19:09 +0000
Message-ID: <b19fcc887b8a6fbc4b7d68cf03aa6626dc2a6fcc.camel@nxp.com>
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
Date:   Thu, 06 Oct 2022 11:18:06 +0800
In-Reply-To: <20220822060323.3481384-1-victor.liu@nxp.com>
References: <20220822060323.3481384-1-victor.liu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0015.apcprd04.prod.outlook.com
 (2603:1096:4:197::21) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|AS8PR04MB8198:EE_
X-MS-Office365-Filtering-Correlation-Id: 322c6e3c-eac8-4ff7-9fbf-08daa749881f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MXJFC2ncfXLUWsqyPYY1AQbSwHaWQ6mIxVkDHTygic9sXy+vNCAe9TG8PHnUNINmDOK+RRoxfSal7EmeEsKm72Ku5BkLaMYKry9kIDgFMa/5Ua9fuM3FbCs76TPasEhqBUU4R/KBVdiIAyiHjSnNedNOYcSGfRwCcj7izDfZeZLnb04Dou6AxTMwRylNj8y2f5buIyrwwLE9krJv45Wb96xeZ4Xn58FhM+LZbTRdOROywsf+i9puEGxGIpxgmQfoXEDKp7KnzaJTXwdsRMv+mS4XmvCoz96vxwjO5Iivwee03NbhI3hvPyYOZh/T2CqO9mIlCjtM3NNHaujHe0MqwfsFUbhAXYB+6yQK9lM8tOP2uVb+BEI1A6kc/Nt3Bv8N3zDiREGTGeAwIkuy9am+d7iD+Z8nrZ9plpqkxexezo+MfDRGT1ktNiOTM8l+0jEo14+7+dSjObJQGekYqg+ZvAzxoc/B6TO576cRw3FXy24hssQclsxVW08iqWpJgmv5qgaNLhNk+KbyKL2FG3LAvtUKr8hajOLyK1V2u0sfV2+JVuRLWDjvuG80Rff5uebpFrzsecMhb9Rr0E+pmohmjYesjUAyvzM3TdWOaMN5lwcb+L02tmvq/FA7lZDz7X3vzcj05QkDLBvDBppinZ2KTiOn0LwcCbBlUhvX7T46zB09FO0UAxVPDl0HWQqAyddJFCXdv9mZW33WXQnSTChVGEoV4Ms0wmlFBMBLk7bTAKYYCq/rwGjFgw3rtUrixmzQD8B5YyPgw0/V5InT7ATkGCtPUPGrLVbzTMnMQP28IgQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(396003)(39860400002)(136003)(376002)(451199015)(4326008)(8676002)(66556008)(66946007)(66476007)(478600001)(6486002)(36756003)(38350700002)(38100700002)(6666004)(41300700001)(6512007)(6506007)(52116002)(26005)(2906002)(7416002)(83380400001)(2616005)(316002)(86362001)(5660300002)(8936002)(186003)(99106002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1ljMjA0Q3pzQ3EwdkhaNEZ6emtQcWFIbmtJaHJEOEU4NjVpTTRtbUpNZ0ph?=
 =?utf-8?B?aS9GeHhVOHpxd3pnUFNGZkt3REU3TnN5aGY0SEs0cFdLQTlYT0FGMG5LQi9D?=
 =?utf-8?B?NXRsOUhDVEVpdDM5WE1ZRlFSNlRUZ0FERm5zL0VJNTRMZ0VVb0JTQmM1Nmc3?=
 =?utf-8?B?UTZYVnFQcEdvbzBLNGJOUzExZlRIcmtvZUVrVEFMelJyYmlHb2dla1BkcUhD?=
 =?utf-8?B?Q0Z4M2w0TnpMNVBLbGdsU09iM0JuQ2xpeVphM3RIVnZlVTE3Q2tucmc1NlpR?=
 =?utf-8?B?eGVJbll2MTZ3YXM4ZFVycTZzUXdpbmxNSFpNaU90d2VxNk9Od2NwYzlPd25Q?=
 =?utf-8?B?NUpxSzd1eXFuMUlHdUIzOEo1TUduTmEwM2ZRSHcvWGwzM29SS0hQUkF2bFI4?=
 =?utf-8?B?UWRpMWtQeEpaU2ZGdjJoV2N3ZGM5M1NxUXlTLzBXM1NqdmIwdThpMUhYUWJy?=
 =?utf-8?B?a3YyM0s2aWhPUFBCeTZuaEh3SlN0MldNREhZK0xhR1hzQzJ2V2ZyVHVVdlpi?=
 =?utf-8?B?ZGMwTkJIUVMwa3Exd0JKS05JTDU5YzZsOVlaT3VLZ2R4NHdpamZVMHZoVXA0?=
 =?utf-8?B?NGluYXhiZjdDOHgxVEMxYjZFV1pwUHVYQnN6SFdvbnc2elFPczBhWGxRQ2VG?=
 =?utf-8?B?Y3lzM0xXRGVQWHVqWXpCLzFDRDJIdUJ4aUJqT1JBcU50UC96SkwvcDFNdjFo?=
 =?utf-8?B?Q2JhSWRYM0VyVkxyY29wSGFESmJTblkvTllyaU05R0hwUVFtOUZBR3oycHBi?=
 =?utf-8?B?RjVydkdSYy81L0JudElldVJFSjZuK0I1RHV3OHRlL2NxaEp5ZzV5dnpXVGtX?=
 =?utf-8?B?czBzVGUyNGpTMDJieTFIaElOOWI3Wmw1c1hLZVZUaFdkVFVtbjdBZ3hLdUNz?=
 =?utf-8?B?WTNvTzE4RWttWGNvMzNVSys4eFUyMVdzU0ZQTU9uNzlXU0pJMkRMVHJBZW5P?=
 =?utf-8?B?VjZDdkNlWHkvV08yZEhGSTRnNzZ1SkV5cmFkeFo1c09xR3ZWd01xSE8zYjFt?=
 =?utf-8?B?RkNCODNxS2NzYjlESjBLMjhSRW53SmVsY0FabWc3K2NBamc3ZHpLYXp4c0Vy?=
 =?utf-8?B?Z2xKZ1hLMmVaNjlmNHJDdE95QjlOVUN2aXRvc1p1ajB4Tm4xYStQTTRSYmRY?=
 =?utf-8?B?NEowalkvNlhud2RXOFhGRkcraklRclU5bGVrWTE1bG1lSzRMQVA2Q1NaQWsv?=
 =?utf-8?B?dzZERDRrNm9vSk9xK01SMnZ5KytaekFuLzBTREMrNm1vVEJ4a3RPQlZBb1l0?=
 =?utf-8?B?ZUFCUlFxY0J0c0FreFo5MjROZEpxalJLRDMxRnh2d3FZbFFwaGdoS3MyZmRD?=
 =?utf-8?B?OHFQQ0NHTWltdk1wOW9BRksvR1NmdXRIdXJPT3BmcW5taUhXOWY4ZnV0alJZ?=
 =?utf-8?B?a1lDN0ZLT25lWUNRU0gxUEZOL2dRNFFnNkhsZUhWSjZ6SEJtVlVQL0JTWDJq?=
 =?utf-8?B?elNwT1IrbytqQlVadjJBWWRCTUFTZDRxejYxL1k3TzNHdzNqNXdYeC9tT3RN?=
 =?utf-8?B?SWkzb295NzVucm5teWtHaTNiQ1NVZXBDU2N0MHF0RzBQNENna2t6enE4MXVW?=
 =?utf-8?B?VnlPSlM1Z2thdHQwV2xEekwxcHBOWmFRbnkvRHR2MDVIMWxKTElpMTZZc2tv?=
 =?utf-8?B?dzBjVktONDhpOGw0aWZObjJWdjlCTHhTZnZYckRwZ1Y2aDJrM3dQYjZRZUVn?=
 =?utf-8?B?S1haaisxbzVHUjdEOG5EWmRkbzJmWmhsMTFwTmI3Sk45aEl3Tmt2QnRTblFz?=
 =?utf-8?B?SWxrMWJHWTRCV09hbTFNK1hJUFN2aUNNTkxxSTdLR1JJWlV0aTRTNFdhYzBV?=
 =?utf-8?B?clQ4cnNYS0NKL0hDc1RYSHV1bHg5MWZxU3hUWUc1dGVRM0htRWVzOWNDQ2dx?=
 =?utf-8?B?MUFwVktIOWg2NWNjMzBHUERwVDRVOWRDMkxyZ1FlRHdFSjZrRk8xNktWZDZW?=
 =?utf-8?B?TW5CT2hXd1MzaGhaY3BjU21ud0FkU2dqNHdQNFN5eVl0UVpDSnhiSk5vN0Z1?=
 =?utf-8?B?SHpIMExNUFFYZjROTkZJM1FBbnIwZTRJMWhwWVBabGFWMUlEYnNVSXFTaUtz?=
 =?utf-8?B?K0gxVVAyNkFtMlFXU2FUMDNvWHJxZFVKQk1lVXVpU2hXNTVhNVVhK2ExVWZq?=
 =?utf-8?Q?uoLIyCfIGCExEwelVBwkm14qr?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 322c6e3c-eac8-4ff7-9fbf-08daa749881f
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 03:19:09.4569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S8HwltzmmobH07v0HrFK9X96Kipc0KdXjUIG9kbd36feq8+tNxy7OImVjmpe4UOQJMSyKYIAkDeHLNBMtF8pxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8198
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2022-08-22 at 14:03 +0800, Liu Ying wrote:
> Hi,
> 
> This series aims to add Freescale i.MX8qxp pixel link MSI bus support
> by using the existing simple-pm-bus driver. A power domain and two
> input
> clocks need to be enabled before the MSI bus accesses it's child
> devices,
> which matches what a simple power-managed bus is(See simple-pm-
> bus.yaml).
> 
> Patch 1 enables/disables functional clock(s) as a bulk in the
> simple-pm-bus driver when the simple-pm-bus is being power managed,
> since the MSI bus takes the two input clocks as functional clocks.
> 
> Patch 2 adds dt-bindings for the MSI bus.
> 
> v3->v4:
> * Drop patch 1 in v3, because simple-bus/simple-mfd devices probed by
> the
>   simple-pm-bus driver should not be child nodes of simple-pm-bus at
> all,
>   as simple-bus/simple-mfd's child devices PM operations cannot be
> propagated
>   to simple-pm-bus. Those simple-bus/simple-mfd devices needs
> dedicated drivers.
> * Drop unnecessary 'bus == NULL' check from
> simple_pm_bus_runtime_{suspend,resume}.
>   for patch 1 in v4. (Geert)
> * Add Geert's R-b tag on patch 1 in v4.
> * Add child nodes in the example MSI bus node of the MSI bus dt-
> binding. (Krzysztof)
> * Resend v4 to imply this series is based on v6.0-rc1 so that there
> are not any
>   dependencies for the MSI bus dt-binding. (Rob)
> 
> v2->v3:
> * Add a pattern property to allow child nodes in the MSI bus dt-
> binding. (Rob)
> 
> v1->v2:
> Address Krzysztof's comments on patch 3:
> * Add a select to explicitly select the MSI bus dt-binding.
> * List 'simple-pm-bus' explicitly as one item of compatible strings.
> * Require compatible and reg properties.
> * Put reg property just after compatible property in example.
> 
> 
> Liu Ying (2):
>   drivers: bus: simple-pm-bus: Use clocks
>   dt-bindings: bus: Add Freescale i.MX8qxp pixel link MSI bus binding
> 
>  .../bus/fsl,imx8qxp-pixel-link-msi-bus.yaml   | 232
> ++++++++++++++++++
>  drivers/bus/simple-pm-bus.c                   |  48 ++++
>  2 files changed, 280 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/bus/fsl,imx8qxp-pixel-link-msi-
> bus.yaml
> 

I don't see any more comments on this patch series.  Can it be picked
up please?

Regards,
Liu Ying

