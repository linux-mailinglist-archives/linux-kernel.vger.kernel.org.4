Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679E3615B26
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 04:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbiKBDuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 23:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbiKBDuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 23:50:01 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2043.outbound.protection.outlook.com [40.107.20.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC725275E5
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 20:49:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JGOQHjnfqS/qe8a+j07TCtMcBKutIeQlOLL9MnJF6uoQRTcEB5Vr3e0bmQ4Yuc+4fuezlyGoP07rDMw4/FxjGR0nAToVwcQ4ujPIRGwQm0GZ6yPl1De6AwlJFdQcmBJvAvEvjrl8VF74c6PPT15x4CoMjdF1berCaa1GfIPhdBY4EDDutdbV5tdPUDRrFVIL8YZqDNK8Xc4TkHByI55LGaBAwkT1zI2jAJ/qapYjUxfURifn7e9cEAxYwWw87dHLKkf2MOocR69cQX3LXDkOPNqBWGqvSTthEOxUDQfd+wmiludWPGfv1nBJ7dEdF3d5khiYLyVK6/BCmoj4EGlJeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u2DWeOQ9l+fedp4/SVQg2Tjo6MGed9AOIP86Ww28XXY=;
 b=ktxjfAfpkoyBGTRyMsvKCjS3jzQea93eri1IHRBHk0jjSi9/zStW7vEWKCBcmQC/FfbDHLoEwMqKD+zRYRpWc96/ky/Ag/UMD0w0K7TH/gAsWxSxkdiA19v/PWUfrzuOUxNDFmVGw56Vjvs0onAVOTM2SBun9UoPfmWo1kN41OTjrbmXNs92AKgYf0MBt/baIq2BjY2XxjpHMSBBwgc7+wFssAK8gXHF91ObGQTCU+9H+nkBQl5ppb+6fJH4Ne7RJP8IalQnq/neWjxu0e7KOD4PM2P5+kw6HSR8Rnj/GrfjajRce5S+IFMhJRDVpv0JV4PS2xIA0DWsSluGGSCalA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u2DWeOQ9l+fedp4/SVQg2Tjo6MGed9AOIP86Ww28XXY=;
 b=V0qenlgRm3kKj3zbK4bSUFWQ82tiDB00lQiXgCmhDcOhMNj4Z6LPsI4in+4Yhs31LvIgnZo9UTnnHPlM1HkrDO9l1r+zy32c1DmbuC4KH4yE+MU1nLeArCWVI+OBu/yJoB/QKRWpQWsMusmvupcANbrJ+x5UdNX7tvOse0iO46Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by PAXPR04MB8142.eurprd04.prod.outlook.com (2603:10a6:102:1ce::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Wed, 2 Nov
 2022 03:49:56 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::dcca:b62f:206b:dcf8]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::dcca:b62f:206b:dcf8%3]) with mapi id 15.20.5769.019; Wed, 2 Nov 2022
 03:49:56 +0000
Message-ID: <b7bcc99c006c91871f0518c1a132035d2a148f24.camel@nxp.com>
Subject: Re: [PATCH RESEND] mfd: Add Freescale i.MX8qxp Control and Status
 Registers (CSR) module driver
From:   Liu Ying <victor.liu@nxp.com>
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com
Date:   Wed, 02 Nov 2022 11:49:17 +0800
In-Reply-To: <afa29fcc11436dd957314a4066c9141937f0470c.camel@nxp.com>
References: <20221017075702.4182846-1-victor.liu@nxp.com>
         <Y1/sUfeVy1a6EKZQ@google.com>
         <afa29fcc11436dd957314a4066c9141937f0470c.camel@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0176.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::32) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|PAXPR04MB8142:EE_
X-MS-Office365-Filtering-Correlation-Id: 449043f9-e7ff-43c3-8bfc-08dabc854e75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DML3f3hAaRccVrlXTVv/hRm8N8bvcSuH0Xr1pCcrnpH82OJLRt54wZhKxrfAqUxWCHrJHXiX7LIpyh5n7tcsc6WMAQN72bGkCewCQtd+ocNsiJ8+axdSyQrZDJh0clhCysn/OS6aNG019zxKBQwi5zBcg4fS1+I2KJULqLFKz41+QhQ3Sani3VoDF5bUunht+QK0dkSyLitqwzAzoSEoX7ABHZ8jQknsx9ABSxID7Z7O5t1keKFMkcFsITElaRteY+wn2c+FlRa4PZ9tBj5uOoae6pLn/PtFOWjFgbUIObXi+Bi0vgNruxrzYBtSVeWFfLoZlWIp2JVcfGWZEA144OvP4u7aYcnCMIsXfZsbDogM03ymUnTg1PI1kudyud6WpozMJM4cgUGc+9wYLfEwLZMhoNYqGKVQTJyOp9b7/Rve306CrHHpMtrKtdXcYm9JawesS53w4VbVRsDuxKGQ5r0reGGFXMCFfopzmEZK4XvU1XiyDw+vNjUGt7iT6+hLB5iZ46tUH4TZhqiLbCl4cHOylmJVDwe8HTCSIueyloELOymHLwUfXkNtkoyhEWJMFxyEntdyT5jBJU7hVo4PmRjWYmV65FZxhsKy2Y14thV8UGb4xYgzE/7kOkPcQ/50WeCSf9fk7KRBSflxjpbC8fTcnJs4NyKXsND3ZTUeoLE0iCd9sBkg3tsEyYx8MpgO2A9v20DFCziNHDOVS22JM3+rV4j+nYPdGrm7xW6trtmWIIINQsPBJbuPMRRP1ua2jLkXiYiLnquloBlyNm6M5jSy7RG4cjJc0JgJxRBC062how4MaHca/OoHRbu3dEq9EBmgvAluH22z+dBXySY9Hg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(39860400002)(136003)(396003)(376002)(451199015)(83380400001)(38100700002)(38350700002)(86362001)(5660300002)(8936002)(2906002)(4001150100001)(8676002)(4326008)(66476007)(66556008)(66946007)(41300700001)(52116002)(26005)(6512007)(6666004)(6506007)(186003)(2616005)(6916009)(316002)(478600001)(6486002)(966005)(36756003)(99106002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHppT3BwS3hTRTdVMlJBd2hXTWVmdW5LVEJwVjhVNFZrSE5iZWZIVjdtMXJ1?=
 =?utf-8?B?ak4vUWVMSTQyK2JNTmlQaGRNWjdzdXQxclozMmlGdWswTE9TM0MrK2NVM2lo?=
 =?utf-8?B?ZTlJRUlXbm5DdDJuMnhyWkN6WThPbGZ3dWRIajJsUWtOWS9kUitmR3RxdzJk?=
 =?utf-8?B?NkE3WWxBa2FxR1h1aXh6V2NRdTg5aUNuYXVkeS9makQ3NnN0RXhqZyt1UmRx?=
 =?utf-8?B?UU1ua2hYZnVsMkQrOEZMakJMaGJBNFMrVkFTVEozeFBQSTRsMFZJM1phWTJP?=
 =?utf-8?B?R2JzN1h3ZWNVMDAzYnhuV0tiajEzcXBKS2x0Q0oydFhXa0g4cDMzTUcwTDNo?=
 =?utf-8?B?elpZUHNLbEo4dTF4R1NQQmluZzVLbVNRa0pvTHRrNjVYR0orTU9Rc200dGd1?=
 =?utf-8?B?UFBqVGtpcDhBa1dRUC9ua2J3djhCWG5idFlkeUdEOC9kSnY2a0JIZmdTWllt?=
 =?utf-8?B?cjk5aUpWUjYrRGhHZzAyYlFCSklwekZmSHN4eXg2ald4NW4vZ3Y4cDB2dmt2?=
 =?utf-8?B?RndHK0JRVGVUb2o4c1QxRHRFdnhQeFZ4VkU0QjBROGx2Z3JoQmZJT2lqVjdI?=
 =?utf-8?B?ZjcrLzFlSVorVEZtaGRUNEJEVE1qMUtSQXhEN0oybE1zTklTcGl1aGUxcjJI?=
 =?utf-8?B?dlhHa3FpazBOY2ZWRE1MR3dwbm5yOTFVa0JBbEdmN2pJNUpaTkxxVUhBNUhN?=
 =?utf-8?B?R25LejVzaUFOYWw2Rm43Zitaa0k3OVUzVWYzL3QrVnd0eEZ4NW95bVpFYzFF?=
 =?utf-8?B?WUhlWnc1eTFyNTEwdE9FZWNTTTI4bWV4a2I3cFVqbDIvUk9OSGVDbGlTbEVw?=
 =?utf-8?B?MzEwbG9Bc0lJS0M4M3kxYm00QWhCSFA4OVFHNzU3OSt0VjV1T3hPNGNnNDc2?=
 =?utf-8?B?eGxBV05zNXZiSzNBVmpLWVpqOGJxdE85YkIvSWZMTS9mck9ON1UxcGd0aXNa?=
 =?utf-8?B?UVhacmhKNDl2aGlxWnBDbGtyRW1pV2U3ZUJnWld2REdlcDNFTlNhOVNBdFpj?=
 =?utf-8?B?YWtHOGhweDRSd3AxeWptSGgrbVlWQ0FHZ0xhaE1XZFZHenB3eGxkTWQrU2Qr?=
 =?utf-8?B?Q0tlSTVPRUpubjlKYWxONFpta3FLaG5WUkpaaXFFRWRhdlFudFgvMDU1YXpW?=
 =?utf-8?B?U2tMald1UnZ5Ynk5M0xPN1FUUjk1UkxCUEJ4cTBTa2lNcHF4VXVGUllURnI2?=
 =?utf-8?B?djNVVmJCbU4zejdFOHVVU3NVbWFDS0FjYlRBanE4WkM0WWE1MUd4T01zT0ts?=
 =?utf-8?B?dVlLV3pQa1ZrQXFOVUE5T0xwRmJTaG45Y3htL2Z4T1JFcVFPdkYrUjNxVlVB?=
 =?utf-8?B?ZUg2blNBb29ENFFvYnZnT3gyQjdwOHpCcFhXSEN6VCtVVzc2K2ZKbFpxOWtZ?=
 =?utf-8?B?S2xzWDBaMTQ4enNZdkduNnBxbkhObngwdlVYS1R3djU5M2VsY25WOExMTUI4?=
 =?utf-8?B?WjN5bEh3akFiMXN2bkpYNGNhQ3pYbHR3NVI4SWtRdDVsMWxJYjBPOWpqanZ5?=
 =?utf-8?B?WjNaWWNkdWY3NW5TUTc3QThxK0pvaXBaNWUyODh0UiszMktFYmQwb29WYlRY?=
 =?utf-8?B?cWhvaDZ3dWNlalV3V2hzSFNueEJOQURpT1N5UlpIQUpGQWdaaGZPd3F5Tk1B?=
 =?utf-8?B?SUY1K3BnMmd1aWMySTYrTWRKZGdVNEdlUU0xZzd3VjFTdFA3K0NERnFpWmEy?=
 =?utf-8?B?cC9pb1Z4OWpEWUtDRUtwTTZxYXVLUmNOS0QwYXB5ejB6aWlsMEEzbURHVGkw?=
 =?utf-8?B?SUZuYzEzam1tNUlNcUMxMWQ2dkFBc040elNDUFNCOERQZTRLRjVLeTVnSHNz?=
 =?utf-8?B?TWhFTlc3UTlSeXRNV1lSeEo1c2N4Wi9QNkdqTWNuTUE0NjJQYzNVY2pydkFP?=
 =?utf-8?B?VnIrbGczdlk1blIzb0hhUnBpdnpnZE1MVmhMNXhSUk5pQVduK0crcGpzMG5w?=
 =?utf-8?B?cC9Wcy9SdjU5Q3YwNWhITURLaCtoNGM4WFpqbVg0ay9jOHJPN3NPSmdHcC8r?=
 =?utf-8?B?NElkVk1PLzU5UllMK1o4SDFOams1dlFrWWFPcmJCclpFMnhjbjdHbUtWbU1M?=
 =?utf-8?B?L0JDa0IrWnVFZnlBZmxaM2ZZRzJEZUoxd2k0K05BTUVFTHJockF0UTgveHh0?=
 =?utf-8?Q?4eIZq/H0WKI+Zs+O98RF/jxNI?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 449043f9-e7ff-43c3-8bfc-08dabc854e75
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 03:49:56.2313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Nxp4UE2qLajy0zrqToHGUezGV2JAm6ZnD6YGvsFoKv0nr9rq3S0pgpohEetu2gc0GBxCGfWgwPytqaRHWfB0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8142
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

On Tue, 2022-11-01 at 13:53 +0800, Liu Ying wrote:
> Hi Lee,
> 
> On Mon, 2022-10-31 at 15:40 +0000, Lee Jones wrote:
> > On Mon, 17 Oct 2022, Liu Ying wrote:
> > 
> > > Freescale i.MX8qxp Control and Status Registers (CSR) module is a
> > > system
> > > controller. It represents a set of miscellaneous registers of a
> > > specific
> > > subsystem. It may provide control and/or status report interfaces
> > > to a
> > > mix of standalone hardware devices within that subsystem.
> > > 
> > > The CSR module in i.MX8qm/qxp SoCs is a child node of a simple
> > > power-managed
> > > bus(i.MX8qxp pixel link MSI bus). To propagate power management
> > > operations
> > > of the CSR module's child devices to that simple power-managed
> > > bus, add a
> > > dedicated driver for the CSR module. Also, the driver would
> > > populate the CSR
> > > module's child devices.
> > > 
> > > Signed-off-by: Liu Ying <victor.liu@nxp.com>
> > > ---
> > > The Freescale i.MX8qxp CSR DT bindings is at
> > > Documentation/devicetree/bindings/mfd/fsl,imx8qxp-csr.yaml.
> > > 
> > > Resend the patch based on v6.1-rc1.
> > > 
> > >  drivers/mfd/Kconfig           | 10 +++++++
> > >  drivers/mfd/Makefile          |  1 +
> > >  drivers/mfd/fsl-imx8qxp-csr.c | 53
> > > +++++++++++++++++++++++++++++++++++
> > >  3 files changed, 64 insertions(+)
> > >  create mode 100644 drivers/mfd/fsl-imx8qxp-csr.c
> 
> [...]
> 
> > > diff --git a/drivers/mfd/fsl-imx8qxp-csr.c b/drivers/mfd/fsl-
> > > imx8qxp-csr.c
> > > new file mode 100644
> > > index 000000000000..3915d3d6ca65
> > > --- /dev/null
> > > +++ b/drivers/mfd/fsl-imx8qxp-csr.c
> > > @@ -0,0 +1,53 @@
> > > +// SPDX-License-Identifier: GPL-2.0+
> > > +
> > > +/*
> > > + * Copyright 2022 NXP
> > > + */
> > > +
> > > +#include <linux/module.h>
> > > +#include <linux/of_platform.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/pm_runtime.h>
> > > +
> > > +static int imx8qxp_csr_probe(struct platform_device *pdev)
> > > +{
> > > +	int ret;
> > > +
> > > +	pm_runtime_enable(&pdev->dev);
> > > +
> > > +	ret = devm_of_platform_populate(&pdev->dev);
> > 
> > The use of this API does not constitute a MFD.
> > 
> > Please use "simple-mfd" instead.
> 
> simple-mfd devices have "ONLY_BUS" set in simple-pm-bus.c, so the
> simple-pm-bus driver would not populate child devices of simple-mfd
> devices.  Also, the simple-pm-bus driver would not enable runtime
> power management for simple-mfd devices due to "ONLY_BUS", which
> means it would not propagate power management operations from child
> devices of simple-mfd devices to parent devices of simple-mfd
> devices.  That's why a dedicated fsl-imx8qxp-csr driver is needed. 

One more point which might be overlooked - as mentioned in commit
message, the CSR module is a child node of a simple power-managed
bus(i.MX8qxp pixel link MSI bus), which means the child devices of the
CSR module(as a simple-mfd device) won't be populated by
of_platform_default_populate() from of_platform_default_populate_init()
because "simple-pm-bus" is not listed in of_default_bus_match_table[]
and hence recursion of of_platform_bus_create() will stop at the
simple-pm-bus. This is also a reason why a dedicated fsl-imx8qxp-csr
driver is needed to populated those child devices of the CSR module.

The patch set to support i.MX8qxp pixel link MSI bus can be found at:

https://lore.kernel.org/lkml/20221017074039.4181843-1-victor.liu@nxp.com/

Regards,
Liu Ying


