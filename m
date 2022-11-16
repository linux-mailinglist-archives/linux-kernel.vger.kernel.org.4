Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D419962B1B7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 04:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbiKPDNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 22:13:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbiKPDNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 22:13:00 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2048.outbound.protection.outlook.com [40.107.247.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97442610D
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 19:12:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dhh00VXB9scX44CRxluvClxEd8KfY2NrtTTgkGyOKvHMsBRfBlKXGOoPUXqrKV/NLx/IwKVndRPO0lesJ5mzkdm+5V56LQQx3vfR++gcxlWrLkIK5edP9+sh1ymc6qopXjmS1nsWDShxtFObaJaffIk7V9rG91rNEWkpYsIFO+teWpdeIBdMBLmbA7Vfoh+pTAzUUswiOVhsaJ61joXQpip/pTWF8/t1huBFRYGhmfK09olCa/L2/jnJLklhPJjfJuM4lLbtw5cTKJ1H5CKLDaXcyvF1UVnUK2eeUo1SZulCYVn1cYvQEEXRmmUuyUzqlLW4sXs15rXqqWv5u3/XIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UI+u7FjAjyrkvak1gsJNQ1wOT+RoCH+pU3Wu6CkMCi4=;
 b=I3hy+ITv2umF4uTlHJYBejKFp8VbdwMnRA61Ai6ooomJ5yVk1XFlY/mn22HEdlVcZRYuKCpKPxAvPRllMozVnnZJAOxc40WBOqHvMfMQKqBaEds1CCKlJnsBAYSj8rn+vzPrzxvpvi/j/dq5KJGW/89ZJqFyBTpqrzkbql878skdd8SoMLQJcaYya2c6mIf7MLAmLxeHuAMV4/wJsBmRxKV2i69MpQzP3VkDhXGP1lJbpBz3mwjMG6CqvcCnhF0PkfZzDFN1UsvvI9pvifOIBApaP4DuKbAXcbl9p1tg/rDAadWakvmm9RNQdryAM4VphMJhqwkuTejqKMKDqEEWNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UI+u7FjAjyrkvak1gsJNQ1wOT+RoCH+pU3Wu6CkMCi4=;
 b=mV6dp/ba6QmytwxAiNSF4+GbmLI1CcGort0a0CFUoXEgwQmHMIiTT005H9FrLnQyrbL4yxTdM7erJOonhpyCB90YzLjlEbBntqQYL2PifjHFCg8tfaRearsdlUvKHQwb1vuVqJM0EjxmV8K+Lu8prgLCW0ZQ5/Vf9p4FUD6Lhmg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by DU2PR04MB8661.eurprd04.prod.outlook.com (2603:10a6:10:2dc::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Wed, 16 Nov
 2022 03:12:50 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::dcca:b62f:206b:dcf8]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::dcca:b62f:206b:dcf8%3]) with mapi id 15.20.5813.018; Wed, 16 Nov 2022
 03:12:50 +0000
Message-ID: <de9c49d33e4a90863e309190a27cd46bef47df07.camel@nxp.com>
Subject: Re: [PATCH RESEND] mfd: Add Freescale i.MX8qxp Control and Status
 Registers (CSR) module driver
From:   Liu Ying <victor.liu@nxp.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com
Date:   Wed, 16 Nov 2022 11:12:04 +0800
In-Reply-To: <CAL_JsqKiKgQ31gjihWs5HR_Bc7j=D7-QDn=jhoy6E5mnMSk-kA@mail.gmail.com>
References: <20221017075702.4182846-1-victor.liu@nxp.com>
         <Y1/sUfeVy1a6EKZQ@google.com>
         <afa29fcc11436dd957314a4066c9141937f0470c.camel@nxp.com>
         <b7bcc99c006c91871f0518c1a132035d2a148f24.camel@nxp.com>
         <Y2jKRQ8VyauSfXmH@google.com>
         <4dfb7699c33974a682d798071c85b431b87e5432.camel@nxp.com>
         <CAL_JsqKoJimmbk5KoAs2yetrW4ONDy6-QMvvFdNdHH+HP6rk=w@mail.gmail.com>
         <c4ae5530acef6b737c2a6a12e4c25aa91b47d077.camel@nxp.com>
         <CAL_JsqKiKgQ31gjihWs5HR_Bc7j=D7-QDn=jhoy6E5mnMSk-kA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0044.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::8) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|DU2PR04MB8661:EE_
X-MS-Office365-Filtering-Correlation-Id: 0de958b6-f05d-4b62-439b-08dac7807033
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R0J+8zIiOdt7V5izRjF1XE+fg7FZPlxJL+m/2mQpbjMaAsQntnSknBOsC6QcHjrAK+BKRoi6VCaWt4IiPr07LrVQpyzKMDn2rfvJ1rWM+Nqj5v4O+e+I1QpiS25vHKPHT4zmkfHLlCNfjneN+rvjl5PpRw+ivccFvqH8GGJjKJNZip0OTI9J6Dht1j1YIyIkwUaA5725267YgOCxVC/ttTJFVDcpqINl4nOiEyHB/9vOY8GJwEFV3KL5REQCbNdAhnKpu9qVywGSrNSr8qR614ablNpjNQkOQp4ThZcpAoPWY/NSC3uqTWfiTkB1MM4tm8WAD2ah18RTRTGRU2WhUmQFkWbvM3NY9ISndXMo7A0oxCd30PessSWVNB+GgkUEeT78qt+1kzpoxR8WHLZfZUEs9cQPuZF6JUq4YBZuyEfLngef4vYXBGfbpqNC4UuoJr5tH1gGQQflJxdAI7nRps8s8CLtZyaeGfGoINpfwFiqHQZuzBWqK3sfu4Qzza7clZGPtEXjEZ7H902rR5lZaFLNMz4CVAlvMonWjnHNTcEkXxE6U71RfEMWnbd2J5+UvBV9yYW2xgYkBxuRbqkHoewJ/lhfDhFBsdFvPkjd15yFWY3v/hhzRy2dWQ0uGKHnCc3wxC24sfZdUKpygsQD8Qp0kFrvGnfbRB1bipP5JmhUzAhTfj2AlVBQUrcBzUY442Nh4z8kys4zvclgEXZY/5nJc4aZSYmz7R+vmsxZF34uqdKTJYTgyBZxLBk6fcgRvdILZHaM4DKeqfhIqrbbfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(346002)(366004)(136003)(396003)(451199015)(52116002)(6916009)(53546011)(186003)(316002)(2906002)(4326008)(8676002)(66946007)(66476007)(66556008)(5660300002)(4001150100001)(36756003)(2616005)(8936002)(41300700001)(38350700002)(38100700002)(86362001)(26005)(478600001)(6486002)(83380400001)(6666004)(6506007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnFaTkNtTWtiOG5DRmU5Q1FEdm1hb3pvNThHTUZneEZFVXJOc2NvVzRqOHhl?=
 =?utf-8?B?Zm1mamZabWhibDJlWnY0WGxkTjYzdWNTL3BMOFVsc0tGZ1RURWFYeHRBWllJ?=
 =?utf-8?B?VkZvZGdrcmcrRFpIWjQrT2pBbW1IdzVsa2lycVdkQ2h6MTZkQTc1N25SOTRl?=
 =?utf-8?B?ZHZMN2cwNlFvOUdjQnNNNmFpeW9QRVhTU2R4RXVpNjJpNEFIVU9uYzYzQlB1?=
 =?utf-8?B?SlpZKzVvU0pFOU5BYVJxYUZaT0xFMElpTm9Hd0lwRFlzOXJ5SXNIWThDMTRN?=
 =?utf-8?B?MmNSM3RtZkJCcU1ubkdXSGk2VFJETS9JbHVvcytPREhjZm90T256ZGkzaFAx?=
 =?utf-8?B?UzJ6UDRYbm8zbFdSSURZQUVNaW9EOHhDYWxtT3AzSU9XbU1vZXk1R1kzeTBa?=
 =?utf-8?B?dTE4YmlRcUdQaEt1ZDcvQmo5c09EVUxoekMwT2dVdFV6QmdoVXNjMHBaMHJR?=
 =?utf-8?B?R2pKZ0FRVVM2N0Y0eTIxaEFueFkyaVVPWFBCOG80V3ZMRFRQdjVLSFpxdCs2?=
 =?utf-8?B?bGpWZUZkTExsYm9MOG5xUUViUDNxVG02cTMzODRlZUR1YmtTQnQ0dkZpeDVX?=
 =?utf-8?B?ck1HMUpTOW9KbGNBQmE3SjFyeG9VNG5qWWNJbjJhNDdEeDdNa1YzdXUrZTVO?=
 =?utf-8?B?STNMc1Nmd2E1andVMXF2bmxjUWZnTVVPaDdINExiSHNOWEpFOTdWWEVPSFY4?=
 =?utf-8?B?M0lva05JZE9oZ1JDSHFxeVBJRGdzcEVKVlZNS1NDU29PeGRYdXYzS0hreEFO?=
 =?utf-8?B?cDE4UHB3Y0dmM09CbG9tV1dNbmhEZkU4dWVvOGtVdW9pNHNuZGhOek9DTGZV?=
 =?utf-8?B?Uy9BUTMvTVRFRFh0NXp0MzNaUzVpek9tQmZ0VDJDdkdSS3Q5dTErV0Q0amNs?=
 =?utf-8?B?Y3dHcFhFTG1SbUYxeDNZNlNlSVVLZjJPRGhFYlhaTityLzU1YTF3ellXTGNT?=
 =?utf-8?B?Mm5Ya3BWeDVXNHZXVm96YklSK1lLVXowL0N3aSs1QUFjZXoyTEtNRkhLd2RI?=
 =?utf-8?B?alBNc0lWODJsZHJmNGNVZ05uejFZYndHZjlSMml5ZmJHN3NZMXBZZzJHQkl1?=
 =?utf-8?B?RTJ1U2dDQmViNXlwZkIzd3IzcmtYcDQ0UDFOdFJ5aDd6TXNGdThLYjRpOGlS?=
 =?utf-8?B?QjRQaUdwK1BNZWw0Z1YraTgwYytCVVQrUmQ0Qm1qVlpWMFkxUTRpWE1SbGFR?=
 =?utf-8?B?Q0MrVEc0alhjMm5CeUJyM241THh6a1BQSGNOOU56VS9Ub3JTQXJVYVg5elhL?=
 =?utf-8?B?U1R1Q25FU1IrRWYyWTFnb3c3aVRGSjFWZDFlNmtmV09xejVhUmpuKzBJZGhv?=
 =?utf-8?B?UkFzeERqV2FSZERhUmRuazhld3dMd3E4T3ZrRVc5WkZ3VUo4aUNobERWYWpK?=
 =?utf-8?B?dVNMdkcyQmlWSjJTTGhCNkV1anBGa1lYd2E0SFBMRi92bjcxS3VGOFZxdndo?=
 =?utf-8?B?cEJuSkRSL1hPU0R5TGNTejRxTlRZNmFrVTN2Z2kzS0NCTFh3YkhLV3VMQitq?=
 =?utf-8?B?YlZ2WTh2TVl5M1d0eUZVVDZRL29MV2l0QlErRzlSUldDbjRaNXR5SW82VVdB?=
 =?utf-8?B?TWZQRnFOcHYraFpkOEVqUVVIK0E0VUkzWGgzUCtISDI4blI1elhlKzFJLzZS?=
 =?utf-8?B?VE55UjY0THF0bHUvQVRtRzRJUVJZQmF2Q2UxbTNRMURzMVBCc2xJTWVXd2hl?=
 =?utf-8?B?SWttWmtmV0swVjF5ZXZ2b3ZUVTdVd3VPTnl2VkM2bFNydDJqNjVTVGpyd0JD?=
 =?utf-8?B?MUoyT2Nud2JZMSsyb0x5MXg5SHZFQkliUm9sRCtNUXZ5S050MmpPY2pJeDRt?=
 =?utf-8?B?V3NqZGhjMDJORDVrQi8xMUdLMU56aUpnMzlYWGlxR0tRTUNRTERrTmovVzdo?=
 =?utf-8?B?L2RUQm90YlhRT3FsbktvVzFoZ1lobXprdUFpbkhENU1idTV6aERraDBFNy9N?=
 =?utf-8?B?QXNIQnk1R3NnYnJyV0UvT0Q4ZmhqRm0vbHU3alVJRk12VFh3dFdoZk9xSHF1?=
 =?utf-8?B?TDFCeWVGRG81UURlK0w4M1dVRlFMbzdEaTNYMjEyZ0xOcXJSaXBoZ0kvcUNl?=
 =?utf-8?B?ZDhMZUlpbkthdVRkakV6Q3J1ZTI1R0FDZlV1d2xabGQ2RkM2ZjlBcDY0WTI3?=
 =?utf-8?Q?wCUrJNbuEk0+3xKzkn8iMJjzx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0de958b6-f05d-4b62-439b-08dac7807033
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 03:12:50.1310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ojSp6s7qtD2DWwj/XI9T676wnUOO0CcqvW6zvYaxqvnwu2Xzmw5ffhzx6XEEN2CZQ7CTSED+Sw5dbIvALwdABw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8661
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-11-15 at 07:33 -0600, Rob Herring wrote:
> On Mon, Nov 14, 2022 at 11:22 PM Liu Ying <victor.liu@nxp.com> wrote:
> > On Mon, 2022-11-14 at 14:54 -0600, Rob Herring wrote:
> > > On Mon, Nov 7, 2022 at 9:58 PM Liu Ying <victor.liu@nxp.com> wrote:
> > > > Hi Lee,
> > > > 
> > > > On Mon, 2022-11-07 at 09:05 +0000, Lee Jones wrote:
> > > > > On Wed, 02 Nov 2022, Liu Ying wrote:
> > > > > 
> > > > > > Hi Lee,
> > > > > > 
> > > > > > On Tue, 2022-11-01 at 13:53 +0800, Liu Ying wrote:
> > > > > > > Hi Lee,
> > > > > > > 
> > > > > > > On Mon, 2022-10-31 at 15:40 +0000, Lee Jones wrote:
> > > > > > > > On Mon, 17 Oct 2022, Liu Ying wrote:
> > > > > > > > 
> 
> [...]
> 
> > > > > > > > > +     ret = devm_of_platform_populate(&pdev->dev);
> > > > > > > > 
> > > > > > > > The use of this API does not constitute a MFD.
> > > > > > > > 
> > > > > > > > Please use "simple-mfd" instead.
> > > > > > > 
> > > > > > > simple-mfd devices have "ONLY_BUS" set in simple-pm-bus.c, so the
> > > > > > > simple-pm-bus driver would not populate child devices of simple-mfd
> > > > > > > devices.
> > > > > 
> > > > > Right, simple-pm-bus will not populate child devices, because:
> > > > 
> > > > simple-pm-bus.c may populate child devices of simple-pm-bus devices
> > > > because "ONLY_BUS" is _not_ set for simple-pm-bus devices.
> > > > 
> > > > simple-pm-bus.c would _not_ populate child devices of simple-mfd
> > > > devices because "ONLY_BUS" is set for simple-mfd devices.
> > > > 
> > > > >   /*
> > > > >    * These are transparent bus devices (not simple-pm-bus matches) that
> > > > >    * have their child nodes populated automatically.  So, don't need to
> > > > >    * do anything more. We only match with the device if this driver is
> > > > >    * the most specific match because we don't want to incorrectly bind to
> > > > >    * a device that has a more specific driver.
> > > > >    */
> > > > > 
> > > > > So "simple-mfd" must be populated elsewhere i.e. drivers/of/platform.c.
> > > > 
> > > > If simple-mfd device is a child device of one device listed in
> > > > of_default_bus_match_table[], then it may be populated by
> > > > drivers/of/platform.c.  But, in my case, simple-mfd device is a child
> > > > device of simple-pm-bus device(not listed in that table), so it will
> > > > not be populated by drivers/of/platform.c.  Instead,
> > > > drivers/bus/simple-pm-bus.c would populate the simple-mfd device.
> > > > 
> > > > > > > Also, the simple-pm-bus driver would not enable runtime
> > > > > > > power management for simple-mfd devices due to "ONLY_BUS", which
> > > > > > > means it would not propagate power management operations from child
> > > > > > > devices of simple-mfd devices to parent devices of simple-mfd
> > > > > > > devices.  That's why a dedicated fsl-imx8qxp-csr driver is needed.
> > > > > 
> > > > > This is more of an issue.
> > > > > 
> > > > > Why can't this device use "simple-pm-bus" to have support for both
> > > > > auto-registration AND Runtime PM?
> > > > 
> > > > If I change the compatible string of the CSR module from
> > > > "fsl,imx8qxp-mipi-lvds-csr", "syscon", "simple-mfd"
> > > > to
> > > > "fsl,imx8qxp-mipi-lvds-csr", "syscon", "simple-pm-bus",
> > > > all devices I'm interested in are populated and all relevant drivers
> > > > can probe.  But, this change makes 'make dt_binding_check' for the
> > > > existing fsl,imx8qxp-csr.yaml fail:
> > > 
> > > As 'simple-bus' is for MMIO devices, so is 'simple-pm-bus' with the
> > > addition of PM capabilities. That means you have registers defined
> > > (reg), but you don't.
> > > 
> > > Either you have a block with mixed functions or you have separate
> > > blocks. If the register space is all mixed together, then it is the
> > > former and an MFD. Don't be designing your binding based on Linux
> > > behavior.
> > 
> > Thanks for clarifying how to differetiate MFD and 'simple-bus'/'simple-
> > pm-bus'.  I would say the register space of the CSR module is mixed
> > together, e.g., LVDS PHY child device has a register offset 0x00,
> > PXL2DPI child device has a register offset 0x40 and LDB child device
> > has register offsets 0x20 and 0xe0 in i.MX8qxp MIPI DSI/LVDS combo
> > subsystem CSR module register space.  So, it appears to be a MFD.
> > 
> > Lee, what do you think?  If it is indeed an MFD, a new MFD driver for
> > the CSR module is needed then.
> 
> There already exists a driver which does what you need, so why create
> a 2nd one? Just add the "fsl,imx8qxp-mipi-lvds-csr" compatible to the
> simple-pm-bus match table and don't set ONLY_BUS. Isn't that enough?

Adding "fsl,imx8qxp-mipi-lvds-csr" and "fsl,imx8qm-lvds-csr" compatible
strings to the simple-pm-bus match table does work, but it tends to
make people think the CSR module is a bus instead of a MFD.  It's kinka
straightforward if a MFD device driver lives in drivers/mfd directory.
However, since "simple-mfd" compatible is also in that match table, I
would add the CSR module's compatible strings to that match table if no
objections.

Thanks,
Liu Ying

