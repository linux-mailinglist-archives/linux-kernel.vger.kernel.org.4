Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1CA629172
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 06:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbiKOFWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 00:22:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbiKOFWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 00:22:48 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2067.outbound.protection.outlook.com [40.107.104.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F181BE90
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 21:22:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pt5921mS8PguJ+1qV7cdV0GNOh51Z0c9TKD7miWDSHWe566K/nEGxYYN15pAHXe3RazUCC2n88ZGu6uVBWbenZ9qLjoOd49K+oEbbAupst7CuT09V2cTXZlMj4TQnUxvPtyuCqCx9J7v27ws9h/AQQD/My2HWFppWC84XG3UbRj2NiFXMVJhqE50L4h39jc7houxOJ3DJ3tzq/kac8PPIUNp1V8tjIc3aPT1Q2KsooiIqYaN8KZRalYygB2qWdEpdp8wTYEzG9K97GF4ugU8Ld3r4qY2JxlcKs5d0vlhwHPIyFkSGluGMHgaX2BA3++5FQnscGtiYmzLB+h4qLn8RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nJsbuqA1r87rIpqLjCuta7dYt7fGGZtIgd6uBRVHrAo=;
 b=Lv8p0gsXb2R+AVRPW5vYlHsTjSfEBkUWWO9/Wrja3DhPnbZU0wAI5l96+oDOEmO2R62mod2mJQrjtPaD+a0G/wpmdRdrAeldKAyPnXj3BMz69UOvZHAHugClUh+taDZN0/6tvKcWPTnSKWD8kFUfCX5v16H6Xe5rKeMmMJiNIG6+UH0gAH5i2C3F/gc3SE4xLYNHTdYmyVVRrx1yqGERV0Et6NbmqHwix9g9k0Hre3xNqHqlernMxM7IZXE+09KvFaLvU4yyxYsWDTHPMma1L0ZxvrsgHR25n5MiiIk+Fce7JpmsM552dftnNEqVBSUmTmvbrAvpXeX/acbRgsTiog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJsbuqA1r87rIpqLjCuta7dYt7fGGZtIgd6uBRVHrAo=;
 b=qcVaqAuwJdO2iOKG5LExZpaTnZxqWkJFgnLUhoXVcWjRfM+2WUWsLCSg+NchF4OUWwU73LT05edAmXs8dpgfa4vC2kLk3HdMevJIXQ09bk1g5AIDQ5+JWjJiUBkEbko0oBsTnEYS2QfuV2RkReunB7IQnW/Fv2tB94owCRJOscA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by DU2PR04MB9523.eurprd04.prod.outlook.com (2603:10a6:10:2f6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Tue, 15 Nov
 2022 05:22:45 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::dcca:b62f:206b:dcf8]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::dcca:b62f:206b:dcf8%3]) with mapi id 15.20.5813.018; Tue, 15 Nov 2022
 05:22:44 +0000
Message-ID: <c4ae5530acef6b737c2a6a12e4c25aa91b47d077.camel@nxp.com>
Subject: Re: [PATCH RESEND] mfd: Add Freescale i.MX8qxp Control and Status
 Registers (CSR) module driver
From:   Liu Ying <victor.liu@nxp.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com
Date:   Tue, 15 Nov 2022 13:21:58 +0800
In-Reply-To: <CAL_JsqKoJimmbk5KoAs2yetrW4ONDy6-QMvvFdNdHH+HP6rk=w@mail.gmail.com>
References: <20221017075702.4182846-1-victor.liu@nxp.com>
         <Y1/sUfeVy1a6EKZQ@google.com>
         <afa29fcc11436dd957314a4066c9141937f0470c.camel@nxp.com>
         <b7bcc99c006c91871f0518c1a132035d2a148f24.camel@nxp.com>
         <Y2jKRQ8VyauSfXmH@google.com>
         <4dfb7699c33974a682d798071c85b431b87e5432.camel@nxp.com>
         <CAL_JsqKoJimmbk5KoAs2yetrW4ONDy6-QMvvFdNdHH+HP6rk=w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0031.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::11) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|DU2PR04MB9523:EE_
X-MS-Office365-Filtering-Correlation-Id: d40fd252-a612-4c70-2399-08dac6c96cde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Abwtv5ix+WCL/3b5mYcCuTU6tmkSYshN4P1z6gxTfZ8QG3rIX0w91E9oCnRjT+JFKpRuQipU3oZLxa3cYaRLDtQ5k1TimQlKTn6B6jLS3K9wSA02uX8BZsC/NDgfdPZmyP0IoHqxfIRAPlAUgWPHgLP7C9kxinRDbhqZYuhm/Umpc8qQ6jsTd4++belTk5OWSXOAvY7iZjJUm4eOCO2rva3lXxN58tsfQPlMiEAtrbKsw1RH/wGK3rv/itMq07mu+mf9VYafZEP/cDPMFTy6VzyCWpT/l7b/b4UelE25FktYTFNGjvr4mm22lGrgdPf2GkmK/ttxIHKXbzbHlelQhyY54W/VuSBTJSs4LAnzBEUvhyyjJ2pGlBJ9KoHLqQy8Emc2dv1tYFQ6fZ2YU97+/tz4l4sJbNIJJBXMN+btqi7be5djfXnol6JeGAyG4FtRoea8OPlhm2Sn47Fcf7bgYewRYO1oJaGe/anLyr6vAQhT0FErQyczenydB1pRkU2XsAPdlIPzLyuKFCtO2KF5sAAypdOKLZZ/9aoaqTok5iv1b5JuVubwfawmSurt570EWKXGeyfWYPcJR4VLgto9yV29dK6jnaK2VgMwFE7hJW0Z879dJ78+H3HNm4Tht4Y/LnlF4PP4vHTGgfSYsDu0VmIaIOEqnyA5odIHUC9mJDfYJKW45YMssfFcWKVZ3pE6YTEzhCdJiRtUneYaCts7lTpNQvDZCw7ADu5LWWsEVBiRldVWlrStAdul6/rlZVMX8yP+2exMajU4Z51US/HCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(451199015)(83380400001)(5660300002)(186003)(41300700001)(2616005)(4326008)(6506007)(36756003)(8676002)(66556008)(66476007)(26005)(66946007)(52116002)(6512007)(53546011)(6486002)(8936002)(478600001)(6916009)(316002)(38350700002)(38100700002)(2906002)(6666004)(86362001)(4001150100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZktQa3FaMmU4b0tWcHlRZ1d5OUswQXlybHBlOEVNaWJ5N21HWWFDSndVRGhu?=
 =?utf-8?B?VmtaUVMxaitqREtvYzVqcmJxWmJWaHp5aE0yUFhNK2ZMMDJNUE1LZ3RCN0VT?=
 =?utf-8?B?ZU1GaDNEN1VEdzdDa0NHcVhMb1ZMYk5wc3QwaWRXN1pWVWtFN0V6MldiMDYw?=
 =?utf-8?B?bmU3czBZaUtSc3NJVURjZm85YzJydG5wVG52bG9rcUlLejBINm5lazJZRzcv?=
 =?utf-8?B?Nk5IcWxxNU9iVUY4VUNDVGUwWmJZenFia3VIc21qNEZkK2M1TExEYjJzZzVr?=
 =?utf-8?B?WVF0RDYvWjJhV1NHUXg3WWpnY25BZFRwUC9FZ3pWeElYVUZ0cDIvV1dScEEx?=
 =?utf-8?B?SC9SUk9LYUhRQVU1NXF2QTgvWTJKdFBUS3ZIU0V4MlJWeWY5MXFibVNpcVlY?=
 =?utf-8?B?U1A5eE9jMG9RVGJ1UVZob2ovMHdTWDlORmIrSVhjMHRTT0ROZVdIbDVvYW5i?=
 =?utf-8?B?WTE0MnhFVnp6aVpRMW1adS9yWExYTzJFRnd3bmMxOG5QZm5rVjlaYmF4aWpo?=
 =?utf-8?B?Z2MxZ0FkdjJVbncxR0x0a3lJN2VaTUphVmZPbDRUdHFrN3BweDNkcExJOXB6?=
 =?utf-8?B?TVArejhFdXF2M2xZWVFYeXlKNUw2QzE0UFJtNHoyaytLOUxSTkp0ZGxHdkJV?=
 =?utf-8?B?aW9TWEt3RHNtbDJ3YzhTSXVmS29qa2Z0eGxYQ0VGdjh0TXhRc0VBS01QYmZE?=
 =?utf-8?B?QzMrdTdjbUxIeGJwUkVlQk02aEN6NmVFWDgwdFV0d0czV0QrQUEzQkNxZ1U4?=
 =?utf-8?B?bkh4cVhCaE4xWjhxN1V3eGkvTXRjY3ZicGcyeTcvOGx4S3JiSGRxRThqeHhP?=
 =?utf-8?B?OU83TDNMVmE5YkM4U0t5WDZNeTlHcmJkMlljVlgyNmJPb2dkM2ZJeUU2UDkv?=
 =?utf-8?B?UnBoQ3VEbWFpZ3NnYU8xSXRHaHJsTkxKcmFHU1prTVlmWHhSVGtHQTNXbHBl?=
 =?utf-8?B?VVp0U2FtSXFsUHZ6Szl4M0xleklsMmp4Z3FEYUErdFVCZXJLQkMydE5BZmk3?=
 =?utf-8?B?RjJvT3JTUndvT082TktwRFZjYzZ3VmFVUVhuSHdmR1hSK1ZXTStUaGlzMkFS?=
 =?utf-8?B?VTdkaTVXejdMWUVvcHFBL0xHNDE0Snk3VHJJZmk1TkIrQ00rdFFQWW81ZGFY?=
 =?utf-8?B?YXZVWUdEOVVtK0s2MWFUeEFuRG9iVFppbm5rWm83SkFFVHQzQ3ZwZmRvYWJO?=
 =?utf-8?B?RDNIUjcxbEsxQ2pEaDRocTBlV0ZLeHBRajI5dmxlUC90RlJYMXc5L2J1bzNC?=
 =?utf-8?B?cWFhU1V3U0dhUEpEZURKazdXSXhxTDR2UzMwWENxeEZtaVB5WWVoUTVtUHRj?=
 =?utf-8?B?SDVBd2xCckdyWEVtYlRLOGZTM3I3V05QRXRERWtZL3VYdXp3Sk1NUU1sTDZC?=
 =?utf-8?B?RG1uVktSZW9DNTdTQUpTdWFLQ0dCRjUxMlFqT2tWbzIvT1FpTzFFWTlEdmxp?=
 =?utf-8?B?Zzh5ZWhQQkhXRHRMMnpBNEpFbVpycEE2YVRTb09DN01tWVNQdnB5Mk81VlNU?=
 =?utf-8?B?Z2UzbjBMbEgyZi9DaXlQdG11ZExybU1DcFRUZTZqMkNKdEl2ajZqTHdoOVBH?=
 =?utf-8?B?djlNT1FpWnNOSTlGejlIR3dIK3pVOWtOak5lRWkvdFg5QmRCSWYrOE9CSDJB?=
 =?utf-8?B?Q0RwS3lGWFhWbUNWcGE3QnNrVXhlSFZWNWszVnE5eDlma0hVTnpNOW5mNWpv?=
 =?utf-8?B?MHVPYVVLbHNyMmQ3UnBsSjBrSXdkSHl4OTF6bm10NVdSb3BOQ3VhUENSQ1h3?=
 =?utf-8?B?UUpLelpYSGVwalNUTXRWdm1uWnRQLy9USHJHOEcxSWpwNnNpNTdjMXFNb0xE?=
 =?utf-8?B?MVB4SGFBMktaU29hc1ZWRFJucXovR2lIZm1vNHJpaFlQRTBsb3l1ODJUUXMy?=
 =?utf-8?B?dzFqR285eEhvQ2d2d1ZFQ2VKd3prMWlYKzBadGphUU8rdlRSYUgvUnA0Sms4?=
 =?utf-8?B?ZlhGcWExQnpXVW45bjVYMUlCM2RqRHdRQmJTa0VrNjI3bEg4YUdRV1VjblFv?=
 =?utf-8?B?WDVkL2hxYnVPY1lJTmZuMW03U3ZYdXJSUkNxb1N3eFFucktDQmZsVkh6OHll?=
 =?utf-8?B?bGVmSEZLWWNTUDc3QlhiNDZ2dlNLdkpITnR5Z0V2cGV6K256ZXhGVEQrZzdu?=
 =?utf-8?Q?+/aSKhjXWyKV0TstLWphKGk2l?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d40fd252-a612-4c70-2399-08dac6c96cde
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 05:22:44.6550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N5mAs29NG+x3wv8N3oAe90cBHI8wD7SHCdBBYH/ecHBgxR5MokeWMXiTDz5hxNr++XsN1B6ibG4cJhrZROn0Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9523
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-11-14 at 14:54 -0600, Rob Herring wrote:
> On Mon, Nov 7, 2022 at 9:58 PM Liu Ying <victor.liu@nxp.com> wrote:
> > Hi Lee,
> > 
> > On Mon, 2022-11-07 at 09:05 +0000, Lee Jones wrote:
> > > On Wed, 02 Nov 2022, Liu Ying wrote:
> > > 
> > > > Hi Lee,
> > > > 
> > > > On Tue, 2022-11-01 at 13:53 +0800, Liu Ying wrote:
> > > > > Hi Lee,
> > > > > 
> > > > > On Mon, 2022-10-31 at 15:40 +0000, Lee Jones wrote:
> > > > > > On Mon, 17 Oct 2022, Liu Ying wrote:
> > > > > > 
> > > > > > > Freescale i.MX8qxp Control and Status Registers (CSR) module is a
> > > > > > > system
> > > > > > > controller. It represents a set of miscellaneous registers of a
> > > > > > > specific
> > > > > > > subsystem. It may provide control and/or status report interfaces
> > > > > > > to a
> > > > > > > mix of standalone hardware devices within that subsystem.
> > > > > > > 
> > > > > > > The CSR module in i.MX8qm/qxp SoCs is a child node of a simple
> > > > > > > power-managed
> > > > > > > bus(i.MX8qxp pixel link MSI bus). To propagate power management
> > > > > > > operations
> > > > > > > of the CSR module's child devices to that simple power-managed
> > > > > > > bus, add a
> > > > > > > dedicated driver for the CSR module. Also, the driver would
> > > > > > > populate the CSR
> > > > > > > module's child devices.
> > > > > > > 
> > > > > > > Signed-off-by: Liu Ying <victor.liu@nxp.com>
> > > > > > > ---
> > > > > > > The Freescale i.MX8qxp CSR DT bindings is at
> > > > > > > Documentation/devicetree/bindings/mfd/fsl,imx8qxp-csr.yaml.
> > > > > > > 
> > > > > > > Resend the patch based on v6.1-rc1.
> > > > > > > 
> > > > > > >  drivers/mfd/Kconfig           | 10 +++++++
> > > > > > >  drivers/mfd/Makefile          |  1 +
> > > > > > >  drivers/mfd/fsl-imx8qxp-csr.c | 53
> > > > > > > +++++++++++++++++++++++++++++++++++
> > > > > > >  3 files changed, 64 insertions(+)
> > > > > > >  create mode 100644 drivers/mfd/fsl-imx8qxp-csr.c
> > > > > 
> > > > > [...]
> > > > > 
> > > > > > > diff --git a/drivers/mfd/fsl-imx8qxp-csr.c b/drivers/mfd/fsl-
> > > > > > > imx8qxp-csr.c
> > > > > > > new file mode 100644
> > > > > > > index 000000000000..3915d3d6ca65
> > > > > > > --- /dev/null
> > > > > > > +++ b/drivers/mfd/fsl-imx8qxp-csr.c
> > > > > > > @@ -0,0 +1,53 @@
> > > > > > > +// SPDX-License-Identifier: GPL-2.0+
> > > > > > > +
> > > > > > > +/*
> > > > > > > + * Copyright 2022 NXP
> > > > > > > + */
> > > > > > > +
> > > > > > > +#include <linux/module.h>
> > > > > > > +#include <linux/of_platform.h>
> > > > > > > +#include <linux/platform_device.h>
> > > > > > > +#include <linux/pm_runtime.h>
> > > > > > > +
> > > > > > > +static int imx8qxp_csr_probe(struct platform_device *pdev)
> > > > > > > +{
> > > > > > > +     int ret;
> > > > > > > +
> > > > > > > +     pm_runtime_enable(&pdev->dev);
> > > > > > > +
> > > > > > > +     ret = devm_of_platform_populate(&pdev->dev);
> > > > > > 
> > > > > > The use of this API does not constitute a MFD.
> > > > > > 
> > > > > > Please use "simple-mfd" instead.
> > > > > 
> > > > > simple-mfd devices have "ONLY_BUS" set in simple-pm-bus.c, so the
> > > > > simple-pm-bus driver would not populate child devices of simple-mfd
> > > > > devices.
> > > 
> > > Right, simple-pm-bus will not populate child devices, because:
> > 
> > simple-pm-bus.c may populate child devices of simple-pm-bus devices
> > because "ONLY_BUS" is _not_ set for simple-pm-bus devices.
> > 
> > simple-pm-bus.c would _not_ populate child devices of simple-mfd
> > devices because "ONLY_BUS" is set for simple-mfd devices.
> > 
> > >   /*
> > >    * These are transparent bus devices (not simple-pm-bus matches) that
> > >    * have their child nodes populated automatically.  So, don't need to
> > >    * do anything more. We only match with the device if this driver is
> > >    * the most specific match because we don't want to incorrectly bind to
> > >    * a device that has a more specific driver.
> > >    */
> > > 
> > > So "simple-mfd" must be populated elsewhere i.e. drivers/of/platform.c.
> > 
> > If simple-mfd device is a child device of one device listed in
> > of_default_bus_match_table[], then it may be populated by
> > drivers/of/platform.c.  But, in my case, simple-mfd device is a child
> > device of simple-pm-bus device(not listed in that table), so it will
> > not be populated by drivers/of/platform.c.  Instead,
> > drivers/bus/simple-pm-bus.c would populate the simple-mfd device.
> > 
> > > > > Also, the simple-pm-bus driver would not enable runtime
> > > > > power management for simple-mfd devices due to "ONLY_BUS", which
> > > > > means it would not propagate power management operations from child
> > > > > devices of simple-mfd devices to parent devices of simple-mfd
> > > > > devices.  That's why a dedicated fsl-imx8qxp-csr driver is needed.
> > > 
> > > This is more of an issue.
> > > 
> > > Why can't this device use "simple-pm-bus" to have support for both
> > > auto-registration AND Runtime PM?
> > 
> > If I change the compatible string of the CSR module from
> > "fsl,imx8qxp-mipi-lvds-csr", "syscon", "simple-mfd"
> > to
> > "fsl,imx8qxp-mipi-lvds-csr", "syscon", "simple-pm-bus",
> > all devices I'm interested in are populated and all relevant drivers
> > can probe.  But, this change makes 'make dt_binding_check' for the
> > existing fsl,imx8qxp-csr.yaml fail:
> 
> As 'simple-bus' is for MMIO devices, so is 'simple-pm-bus' with the
> addition of PM capabilities. That means you have registers defined
> (reg), but you don't.
> 
> Either you have a block with mixed functions or you have separate
> blocks. If the register space is all mixed together, then it is the
> former and an MFD. Don't be designing your binding based on Linux
> behavior.

Thanks for clarifying how to differetiate MFD and 'simple-bus'/'simple-
pm-bus'.  I would say the register space of the CSR module is mixed
together, e.g., LVDS PHY child device has a register offset 0x00,
PXL2DPI child device has a register offset 0x40 and LDB child device
has register offsets 0x20 and 0xe0 in i.MX8qxp MIPI DSI/LVDS combo
subsystem CSR module register space.  So, it appears to be a MFD.

Lee, what do you think?  If it is indeed an MFD, a new MFD driver for
the CSR module is needed then.

Regards,
Liu Ying

