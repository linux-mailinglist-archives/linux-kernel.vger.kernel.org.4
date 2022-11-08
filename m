Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571896207DF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 04:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbiKHD5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 22:57:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbiKHD5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 22:57:37 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140080.outbound.protection.outlook.com [40.107.14.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C8113FB1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 19:57:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=flUXZGvBzTzaWhr4lFCA623JsaubGIeIgupyu0mzryHxXTWjPoOhdevwjcmVqwi5wx9z5zU1X0y30f09RKjNMloPin7lvAv7mGHh0UU3ww62wqpwJVjQqgCM6Xx33TMk4F3bxns0ZqpJL8rikDxsHGq++CooGolIjZJbSheFAM6ZoeH/psnfb92yqZ4aueCpSqFNQBH3jjuQ/LCjPv7u0o3zloI42CNUHPZRKZ/TB4ob7a6on2hujK1mTE2GnYKAFCZ0wlbWPcFN1lVpPEgciZVba14crgOOISYFW45EM0JDsQv8GX4A6fuivwS8FN/P0rLOyCKgnx0t33Gu2fGfkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ztOtluX6WsrepiI4UWdqiGLQirsWkHvVJ4we1/hkfTw=;
 b=Sov18Q7+UHDUVpBghBTjO0XV6u+2Q4ycHIWPkBgK6hE/vgKmFGCtvhP0cNmPrcwNzGaJ82MWXSdAexJFZ1n69dZbyf7tA9CvSWeiZvJCjguO8oG8tQWnNPMaup+OmxdCRfgnV1e36BpQC1ZsdrWTxGiYSnPVoF7LOQF4Moa6EbNzbXa53Vs+BnHR/0bxap0DAoa+iuumSr+E4n4vT38q40TyjTGXTJmplmS4rkeW0lznvzCfH7P2rf4G3II7CAZONdaccdhoqpYXtwxFK9Q9pbvFmOi7E2ZoWjVYa+etKtdTkECQRUePW7+MMq9U1pGEDKjtPifHylnud6HJ863S7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ztOtluX6WsrepiI4UWdqiGLQirsWkHvVJ4we1/hkfTw=;
 b=MdVuw+rmyQc9b7kSWSurhfJiqVTiYulyDbfqYWHe/MvPjvnbWVgpPUtSU9ET9ki3n4vjKLHiMdDaRbHZ4qrgadPSZL5yDHxKQ+N68uGDf0WUEltbdMGz7lyxYkoEhLSA3IT3FTk5KmsOqyOCSCoOTtEumBpjSgT0CkkSF3QE89A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by PAXPR04MB8302.eurprd04.prod.outlook.com (2603:10a6:102:1ca::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Tue, 8 Nov
 2022 03:57:32 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::dcca:b62f:206b:dcf8]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::dcca:b62f:206b:dcf8%3]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 03:57:31 +0000
Message-ID: <4dfb7699c33974a682d798071c85b431b87e5432.camel@nxp.com>
Subject: Re: [PATCH RESEND] mfd: Add Freescale i.MX8qxp Control and Status
 Registers (CSR) module driver
From:   Liu Ying <victor.liu@nxp.com>
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com
Date:   Tue, 08 Nov 2022 11:56:43 +0800
In-Reply-To: <Y2jKRQ8VyauSfXmH@google.com>
References: <20221017075702.4182846-1-victor.liu@nxp.com>
         <Y1/sUfeVy1a6EKZQ@google.com>
         <afa29fcc11436dd957314a4066c9141937f0470c.camel@nxp.com>
         <b7bcc99c006c91871f0518c1a132035d2a148f24.camel@nxp.com>
         <Y2jKRQ8VyauSfXmH@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::20) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|PAXPR04MB8302:EE_
X-MS-Office365-Filtering-Correlation-Id: ccd99f76-8b46-44aa-3534-08dac13d5c3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A3gJ5/IW9SgYW9RwPJ1g8GfJ+3A3elJiBo0XYL0KFuQ674axp/NFWYM4CpAs8sMSjOMtgMot59DzVA0otPXXfYHzwJ4bcn6N+s+ttGuQz2GmyEk7Sgf74P/h4ZsF7mYO22345EQkD49GzjLei15CIQgLQ53KjqasCvsoAkNGrTqHrrR3vsDR2ZxMqzG9rXpDzFGU859o1A5DmiRjTe35LgeXCc7a54QJjIuo8si10/oGRcsB1ExNEh4naP/FW+kmympc9cjVGDCcWzaVMlLxIvRci9g5H7wd+fJzY3U4h1Gmm5GEJq7eG+atMQI6YWxRTyShMFcfqzZinndN8ySUIptf7HDEkccW46V5ZIkMUn7jwMlcptkOr4ibceDzBSBJisppim58YRlav1iGzKGDYb2BzCWNYxeT6ik+WQWLu7kIPbNjRZQjphCdsGFbj18/oP4JrVb4E9W2JJFOEWvuYJBPOEbIrpcA5eP48CnHoYfwZ3jXZw7i5nsbB5QhcrURBXYJm0PWenCK/6m1KrlObKP9W0A0aa7SVVXhVxVGeZ5U6b94GHP0goIKcFvO6I+2TY2JuXjfcxUMVg62aIqGcgkeSIhXSbbN0ImQMpaaccqt02f3swLE+jiTCCAX+enJaroRO0g3cmrzqETfTkzACVLap0EaxS9Pxv1psjNQZMlVTEU3bjufTTVXNs7gPRb76NdfeawwuXVGNsWJ5PRigFtg+5DNbiS9suhPjOU0uarEDdq84dGQ4oUie0KSMtOJrKOfqrr608vVUITr3azMQYiWqlrsiYzt7gydi3Sn3KM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(396003)(346002)(366004)(136003)(451199015)(316002)(6916009)(41300700001)(4326008)(66476007)(8676002)(66556008)(66946007)(6486002)(966005)(66899015)(86362001)(36756003)(83380400001)(38350700002)(4001150100001)(5660300002)(8936002)(2906002)(38100700002)(478600001)(2616005)(186003)(26005)(52116002)(6506007)(6512007)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVY1T1VLMHhWcHBtNFpkeVNTSFg3d3JVbVpDRm83QXJqMkRqV0NiM1pmYmVr?=
 =?utf-8?B?aWFodWtoWHYzTURTMm8rMDFiRnpkZDFNbVRoN1pyWFhzZTBSdEFpVlg1K3ow?=
 =?utf-8?B?VXNxSjl0YjMrSTlEeVpJTzNhTWovdU9EaG9sV3dQbFAza2F0bDkxUm1sWlAw?=
 =?utf-8?B?bGhib1JCYzlYdFAvUHlFeU1VTU5yd1FIL1RCbE53K2hKUDJiaWFOYjRlaTNz?=
 =?utf-8?B?ZCtsZm92NDRUREpQVUR4WURNaTkxT1J2VlkwRUxKNVMvN201NG1ZZEdHeFFH?=
 =?utf-8?B?TXYvV0E2Tjl5TStteUJiQ1hzQ1FpZ3dmWEV1NWZBQUtOZ1V5WmdsOVdLY3Yx?=
 =?utf-8?B?WnNobGV1UW1CY21yVS96VndoQzZuOE5GMGlYQU1ZSHQyRmN0S1dPNmdqREVR?=
 =?utf-8?B?QnVXN3Jmbm5zOXNYRytmZ3BFSkx1bEdiWGtiR051UUFuQVR6UWo0M2dTNkdr?=
 =?utf-8?B?dmtWUXBIK01vcU1NLytQcEdnUXdNeEpZSEZKTzAvZ1ZGcnRSQVdOc2RMbjdy?=
 =?utf-8?B?bnBvWHA1WWZBTW5hN1ZrZnJGRWwzMXJyNTFSWmNYeW9JdjVNcVBjRDVkdzhV?=
 =?utf-8?B?anA5d3ZDQVBlY3ZjNUpIKytZbEhYd0tlRlNEMlZTbmt2OXI3emFmdnhuWU9w?=
 =?utf-8?B?NFZQQm5GMkhPQysxQStMSkdiK0dUTG5nYmY5VHJOeXM0a3MwTTB3YTVoT1h0?=
 =?utf-8?B?SkNtOUVzbDIzZFZPazZNLzBjQXdHNVdRRkRvNmMzYVNUM2xKaVRTdGd0T0NL?=
 =?utf-8?B?b0NnNjNiZ2RNcitndWJvY0hkZHcxeitQZGxOTHptK1VGZFpxU1lLMFRRRnZv?=
 =?utf-8?B?NGhodHA0WkpTQWhNeHVROVd6aGg1dkFiUkljZEd0TlpWQitkd2tOMGNuQ1lm?=
 =?utf-8?B?eTZhNis2ZUtaekdGamNIKytDUWdMYjlrVTBEMXpPNjVrWHNDTzRlU1B4cFR4?=
 =?utf-8?B?Uml2WXQ1UXZteldHeWpsQVFGRWgyVnIzeS9waWE2Mng3U2NVUUZjOHQxcHVy?=
 =?utf-8?B?RFNNbjNxb1NRaWNPczdUSlVWUjZzem1WUlBVdC9yNG1GbGNyVnc0cXNNazFE?=
 =?utf-8?B?ejJ0YXBzRUpBMkUvS3prV0RWcVhtUG9rbWx0OG8rZVZqNlpHMjNEQ1o5bU5z?=
 =?utf-8?B?aXo4QVZ2L0I5TWFRcW9GWkxMRmw1Y0o5LzdDOWpjM2ZPUjFkTmZxTUR2WWFy?=
 =?utf-8?B?UW0xQTJERHprMmxvdStGejJnT2JsZ21UR0lrTzZXR2p4d253UmdSbWdwRUlY?=
 =?utf-8?B?bHp3eERXUk5sdloxaEhwb3JwcmIrMVNJZmdGU1pQVyszU1ZUTzIvVjRnU0xU?=
 =?utf-8?B?cXc4K0JYZFZ0clo0WlVYWG1ORnNUVUFqTEFjVkNuYi9XeEV1dGUvTTlTM09t?=
 =?utf-8?B?Um1CRzFtZ0JyUmk1clhhd3F0VmVXekJOSThIMmRTeTRKTythWHBtVmwrcVRB?=
 =?utf-8?B?bXZBVnZydzliS0ZXVDNCT2ZNeHJvdEkyZ1ZTMm9aVjVwc2FTWFZBbkEvQ3di?=
 =?utf-8?B?amhCKzJiMGp6MnNPbW1obHN6TVpiQTdqZTQxbmhkQno3RTdQY0VyalJzZUNV?=
 =?utf-8?B?NHNQcHpxZURGeUhCWndrY1VxTUdBSlM2VEhBZGhLamxxRlB4VjVGSFd2Rkg0?=
 =?utf-8?B?WlpLU0N0ZGxYYVNxVjRCQW90R2hGV0hPd2pRUGZLaVJOWU9ST1Z2bjE3Q0R3?=
 =?utf-8?B?bzRrZWZLcUxJbStFUkp1cnVqTjJsMW5nTTVVVmYyUE9XWU1CclVwZTN1bEdE?=
 =?utf-8?B?UTF0ZS9PZFpXQ3RPL2pyV0Nqa2JPUHdIK3V2c1paOEhrZVFEK3NNWlNXMmZQ?=
 =?utf-8?B?QS95b2hMMzltSGdqQUVrTktyRmxnL0RENWtBd1V1ZWNoaWJKWjBJVlU1VDNl?=
 =?utf-8?B?LzZVOUd0YnZCOUtjN1JJKzdSTCtFZlRaVXhpdW05Ui9ET2czR01PaUlRUng0?=
 =?utf-8?B?SWhIRmxaeW9mSjRmN2EzOWFIY3poYnNUb2o1eEhmQ2N4SlBiY0ZKcm1GSXBV?=
 =?utf-8?B?SDlwVW0zZm55aVMvS1JuWlRWR3Q2THZLU3NVME1Va3IwbUx1MDc0MVB0RURj?=
 =?utf-8?B?T2F0TytoQlcyYlV5SFJpc0l6UHhnVVFwRVAwYnRHbjdUUW01NHp2UWtMTzdy?=
 =?utf-8?Q?Lw34SlRhvdcHLJ+Pd+ZW/A10A?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccd99f76-8b46-44aa-3534-08dac13d5c3c
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 03:57:31.9241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YrYYzQlJ2bTui7VbqJFps4wZKTHoy/7QESy4Yy04SgrjWJaMJQdeZjR3yeCiVK0hj162IMVVVRV4yd94f80vBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8302
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

On Mon, 2022-11-07 at 09:05 +0000, Lee Jones wrote:
> On Wed, 02 Nov 2022, Liu Ying wrote:
> 
> > Hi Lee,
> > 
> > On Tue, 2022-11-01 at 13:53 +0800, Liu Ying wrote:
> > > Hi Lee,
> > > 
> > > On Mon, 2022-10-31 at 15:40 +0000, Lee Jones wrote:
> > > > On Mon, 17 Oct 2022, Liu Ying wrote:
> > > > 
> > > > > Freescale i.MX8qxp Control and Status Registers (CSR) module is a
> > > > > system
> > > > > controller. It represents a set of miscellaneous registers of a
> > > > > specific
> > > > > subsystem. It may provide control and/or status report interfaces
> > > > > to a
> > > > > mix of standalone hardware devices within that subsystem.
> > > > > 
> > > > > The CSR module in i.MX8qm/qxp SoCs is a child node of a simple
> > > > > power-managed
> > > > > bus(i.MX8qxp pixel link MSI bus). To propagate power management
> > > > > operations
> > > > > of the CSR module's child devices to that simple power-managed
> > > > > bus, add a
> > > > > dedicated driver for the CSR module. Also, the driver would
> > > > > populate the CSR
> > > > > module's child devices.
> > > > > 
> > > > > Signed-off-by: Liu Ying <victor.liu@nxp.com>
> > > > > ---
> > > > > The Freescale i.MX8qxp CSR DT bindings is at
> > > > > Documentation/devicetree/bindings/mfd/fsl,imx8qxp-csr.yaml.
> > > > > 
> > > > > Resend the patch based on v6.1-rc1.
> > > > > 
> > > > >  drivers/mfd/Kconfig           | 10 +++++++
> > > > >  drivers/mfd/Makefile          |  1 +
> > > > >  drivers/mfd/fsl-imx8qxp-csr.c | 53
> > > > > +++++++++++++++++++++++++++++++++++
> > > > >  3 files changed, 64 insertions(+)
> > > > >  create mode 100644 drivers/mfd/fsl-imx8qxp-csr.c
> > > 
> > > [...]
> > > 
> > > > > diff --git a/drivers/mfd/fsl-imx8qxp-csr.c b/drivers/mfd/fsl-
> > > > > imx8qxp-csr.c
> > > > > new file mode 100644
> > > > > index 000000000000..3915d3d6ca65
> > > > > --- /dev/null
> > > > > +++ b/drivers/mfd/fsl-imx8qxp-csr.c
> > > > > @@ -0,0 +1,53 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0+
> > > > > +
> > > > > +/*
> > > > > + * Copyright 2022 NXP
> > > > > + */
> > > > > +
> > > > > +#include <linux/module.h>
> > > > > +#include <linux/of_platform.h>
> > > > > +#include <linux/platform_device.h>
> > > > > +#include <linux/pm_runtime.h>
> > > > > +
> > > > > +static int imx8qxp_csr_probe(struct platform_device *pdev)
> > > > > +{
> > > > > +	int ret;
> > > > > +
> > > > > +	pm_runtime_enable(&pdev->dev);
> > > > > +
> > > > > +	ret = devm_of_platform_populate(&pdev->dev);
> > > > 
> > > > The use of this API does not constitute a MFD.
> > > > 
> > > > Please use "simple-mfd" instead.
> > > 
> > > simple-mfd devices have "ONLY_BUS" set in simple-pm-bus.c, so the
> > > simple-pm-bus driver would not populate child devices of simple-mfd
> > > devices.
> 
> Right, simple-pm-bus will not populate child devices, because:

simple-pm-bus.c may populate child devices of simple-pm-bus devices
because "ONLY_BUS" is _not_ set for simple-pm-bus devices.

simple-pm-bus.c would _not_ populate child devices of simple-mfd
devices because "ONLY_BUS" is set for simple-mfd devices.

> 
>   /*                                                                     
>    * These are transparent bus devices (not simple-pm-bus matches) that  
>    * have their child nodes populated automatically.  So, don't need to  
>    * do anything more. We only match with the device if this driver is   
>    * the most specific match because we don't want to incorrectly bind to
>    * a device that has a more specific driver.                           
>    */                                                                    
> 
> So "simple-mfd" must be populated elsewhere i.e. drivers/of/platform.c.

If simple-mfd device is a child device of one device listed in
of_default_bus_match_table[], then it may be populated by
drivers/of/platform.c.  But, in my case, simple-mfd device is a child
device of simple-pm-bus device(not listed in that table), so it will
not be populated by drivers/of/platform.c.  Instead,
drivers/bus/simple-pm-bus.c would populate the simple-mfd device.

> 
> > > Also, the simple-pm-bus driver would not enable runtime
> > > power management for simple-mfd devices due to "ONLY_BUS", which
> > > means it would not propagate power management operations from child
> > > devices of simple-mfd devices to parent devices of simple-mfd
> > > devices.  That's why a dedicated fsl-imx8qxp-csr driver is needed. 
> 
> This is more of an issue.
> 
> Why can't this device use "simple-pm-bus" to have support for both
> auto-registration AND Runtime PM?

If I change the compatible string of the CSR module from
"fsl,imx8qxp-mipi-lvds-csr", "syscon", "simple-mfd"
to
"fsl,imx8qxp-mipi-lvds-csr", "syscon", "simple-pm-bus",
all devices I'm interested in are populated and all relevant drivers
can probe.  But, this change makes 'make dt_binding_check' for the
existing fsl,imx8qxp-csr.yaml fail:

--------------------------------8<------------------------------------
/kernel/linux/Documentation/devicetree/bindings/mfd/fsl,imx8qxp-
csr.example.dtb: syscon@56221000: $nodename:0: 'syscon@56221000' does
not match '^bus(@[0-9a-f]+)?$'
	From schema:
/kernel/linux/Documentation/devicetree/bindings/bus/simple-pm-bus.yaml
/kernel/linux/Documentation/devicetree/bindings/mfd/fsl,imx8qxp-
csr.example.dtb: syscon@56221000: '#address-cells' is a required
property
	From schema:
/kernel/linux/Documentation/devicetree/bindings/bus/simple-pm-bus.yaml
/kernel/linux/Documentation/devicetree/bindings/mfd/fsl,imx8qxp-
csr.example.dtb: syscon@56221000: '#size-cells' is a required property
	From schema:
/kernel/linux/Documentation/devicetree/bindings/bus/simple-pm-bus.yaml
/kernel/linux/Documentation/devicetree/bindings/mfd/fsl,imx8qxp-
csr.example.dtb: syscon@56221000: 'ranges' is a required property
	From schema:
/kernel/linux/Documentation/devicetree/bindings/bus/simple-pm-bus.yaml
--------------------------------8<------------------------------------

The error log basically complains two things:
1) The example nodename 'syscon@56221000' should match
'^bus(@[0-9a-f]+)?$'.
2) Missing '#address-cells', '#size-cells' and 'ranges' properties as
required by simple-pm-bus.

Regarding 1), if I change 'syscon@56221000' to 'bus@56221000', then the
below error comes along:
--------------------------------8<------------------------------------
/kernel/linux/Documentation/devicetree/bindings/mfd/fsl,imx8qxp-
csr.example.dtb: bus@56221000: $nodename:0: 'bus@56221000' does not
match '^syscon@[0-9a-f]+$'
	From schema:
/kernel/linux/Documentation/devicetree/bindings/mfd/fsl,imx8qxp-
csr.yaml
--------------------------------8<------------------------------------
So, it looks like "syscon" and "simple-pm-bus" can not be in compatbile
string at the same time.  Note that "syscon" is needed because other
device nodes may reference the CSR module through a phandle, like the
"fsl,imx8qxp-mipi-dphy" device.

Regarding 2), I may try to add those required properties, but it would
break the existing schemas of the child devices of the CSR module, like
the "fsl,imx8qxp-ldb" device, because "reg" property is not allowed.

So, it looks like the CSR module still should be simple-mfd device but
not simple-pm-bus device, right?

> 
> > One more point which might be overlooked - as mentioned in commit
> > message, the CSR module is a child node of a simple power-managed
> > bus(i.MX8qxp pixel link MSI bus), which means the child devices of the
> > CSR module(as a simple-mfd device) won't be populated by
> > of_platform_default_populate() from of_platform_default_populate_init()
> > because "simple-pm-bus" is not listed in of_default_bus_match_table[]
> > and hence recursion of of_platform_bus_create() will stop at the
> > simple-pm-bus. This is also a reason why a dedicated fsl-imx8qxp-csr
> > driver is needed to populated those child devices of the CSR module.
> 
> Not sure I know the semantics well enough (anymore) to get a
> meaningful picture of what you're trying to explain, and I do not have
> any suitable H/W here to mock-up a real-world test-bed / concept
> demonstrator to debug this for you.

I understand you have no hardware to debug this directly.  But, the
example in dt-binding doc for the i.MX8qxp pixel link MSI bus(a simple-
pm-bus) may give you a kinda full picture of what the relevant devices
look like.  I mentioned the patch set to add the MSI bus previously,
however, you may find the binding doc directly here -
https://lore.kernel.org/lkml/20221017074039.4181843-3-victor.liu@nxp.com/

> 
> The long and the short of it is; we have a bunch of automatic
> child-device-registering helpers in the kernel.  One of the mechanisms
> is bound to work for you if you structure your code appropriately.
> 
> Introducing an empty, meaningless driver, simply to call a single
> function it not acceptable.  Please make the infrastructure already
> offered specifically to solve this category of issue work for your
> use-case.

Yeah, I tried to not to introduce a new driver for the CSR module, but
it seems that it is needed.

Regards,
Liu Ying

