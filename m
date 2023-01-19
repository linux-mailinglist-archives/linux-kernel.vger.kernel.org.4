Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDE6672E20
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 02:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjASBap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 20:30:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbjASB3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 20:29:14 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2066.outbound.protection.outlook.com [40.107.22.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101DE74EA6;
        Wed, 18 Jan 2023 17:24:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RrE1gnJ+/HkEwRUfeDnuimzoUGb5VlLbSg9MmUdxkFKpa3j88/45Gov3xgJniXAifvi+XV1FPxAR5SKK/g4p+oUJcDdbnXha4wBPzRTgqGTEnkQIYB63rdaVE7Wj3z24lNkDPETeVhp6zwQnGUBNIOUpW4FV+8Vs45gqxLbqpO62buVj4tRyy5A5K8x9Fo7nysLkPBDIz/bv7ifgSJCN2HAwHc/1LdyKggWk1f2rAmqTUaiPK1bcSCGVBY4rv7EN/uADb4Qdva/hQRv5uanegjGEgxO6ivfsujUrFvirgMsTGc0Qcf253V0J7JF/4U+m0A1tI/umjHNdkEx57CbxVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q2OcU7yjwSv62nzqAsNGsZwe4BFCRpliAWaoVJgdotI=;
 b=QRCeWBA5+5PffaNrvWpTkO0CviUIgNbGMq7yuMKXu3Fm0fcKcjLEYHUN1ePzdZ9pRAsOYpJgeJ8TA+Lw3f6452dUaWQ2ZKhkjnmC76uKhQ7tSNCaWM7BEpPaFiK0kpzEjU9GZImRAuA1dCuSAqemctBllYXI3zZ8ocovpPpWtfEdH5MKBgRnp7PStaAYma5ph9A2fOteK0geNMpFzU3iae/jvtaw5IIi6nNbBe5RzoZ+CjSZTdgQLwjGBEmke5UUUh9VLZWnKFFkuSRZVC+IiByKcqS94lWJG+m49pTh5bplHjvEkU3MPTVOXQfgDVz7YFgR6uZSATJVBNFpoEzxHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q2OcU7yjwSv62nzqAsNGsZwe4BFCRpliAWaoVJgdotI=;
 b=SbQDSwLFifUrqKCRE8fVm8LzbJvN2w4Iw0wz5T0UJtm+MejMa/HmfeKSA1QdXLnmVdWeeYZRoCG5/4Z3Q+hAF5EcYin03MExyHOCKqmi+uW57uAsEVnpqaxC57qGKut7M2VPH757S8CL7L1wrZql+mhcrKr5w4Ye659RkffZLrg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by AM8PR04MB7220.eurprd04.prod.outlook.com (2603:10a6:20b:1d7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Thu, 19 Jan
 2023 01:24:29 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::5725:92ec:f43e:f5fc]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::5725:92ec:f43e:f5fc%3]) with mapi id 15.20.6002.024; Thu, 19 Jan 2023
 01:24:29 +0000
Message-ID: <53c986fad003be8594e8b69f74558b81b6d9ae80.camel@nxp.com>
Subject: Re: [PATCH v4 05/17] arm64: dts: imx8qm: add pwm_lvds0/1 support
From:   Liu Ying <victor.liu@nxp.com>
To:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc:     "pierre.gondois@arm.com" <pierre.gondois@arm.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "oliver.graute@kococonnector.com" <oliver.graute@kococonnector.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "abelvesa@kernel.org" <abelvesa@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "eagle.zhou@nxp.com" <eagle.zhou@nxp.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "viorel.suman@nxp.com" <viorel.suman@nxp.com>
Date:   Thu, 19 Jan 2023 09:23:55 +0800
In-Reply-To: <d959972f5897f68a468c61bb74cbf89e93efdc5d.camel@toradex.com>
References: <20230118072656.18845-1-marcel@ziswiler.com>
         <20230118072656.18845-6-marcel@ziswiler.com>
         <60f8f656cf466b8fbd8dfe93177119cfa4839b72.camel@nxp.com>
         <d959972f5897f68a468c61bb74cbf89e93efdc5d.camel@toradex.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0007.apcprd06.prod.outlook.com
 (2603:1096:4:186::9) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|AM8PR04MB7220:EE_
X-MS-Office365-Filtering-Correlation-Id: b84548f6-e32a-40aa-9ccf-08daf9bbe8c9
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PVt0BIgq0bE0OzEPElfSCOvtO2kdF8eVPAYqcwpuxU+GBB9D5j/hw/l7yY3RB9lB1jKocb8eOcsb1AQ5X+8HMVNHv24+aAFDCxU6kDIXP9ygWahqj2JHbRBeacCtA40Vn8NhyafAxgwh67QihnQ89cGvKGiyCN+U/KIhJtLWS7qZK1d4Yc39r+j6O4CPB+O9V0w1sBenmKC748ax/r2TPDyHYjk49OIxu2uv5HgHnC93/JO8Zx/BP9q7LDx94d23cNQtp2k1g/yigypsEa4DeXk5pzBSqoT7jQVvF8HtKMwLU7fMkFtmw7jz6Hk9i49M42qCvrcxCJoZJjl3HuW8eECTUcxLPxm4k2uu1D5hGBV3ZUGzrXqy1ixJzyQpK354USaMx//XKVK+xFqBzNR+041ICXGJb+iW2ocHiOoMJWHnfhNp6QfA3KTHVlh+38oYG9YYQpsO5aCE+UWiAnwIBUJxyJ9OSgA4OwdUUK1pj837JZ3LZ1yN8m8WCnulWyxjZTXk7pODxlWmWENd1Hi+wUh+FzV1tp+ujk/rPgwiVQsapC/pxRa0pf58Zz7QaopFQAULrweYKSO7QlgQaMMCjM+OqR0/3kxFDgB07GnzfuAyKgIuvtgZoW8zO+WRT78l9h0Cj7Cw8kdFk6A4aurnWGgCW+dWFJeAFfpLqEQGzzaFnf0sQ52vVySpvJIB2CPKAOWgDcU17js0KoVml2OP26RgHqRNLI/9jzx0xsXG8O10JyhQDwnHsVuMVXLOli6Fcwm92m87t50T567BjJtrP8JkkJkn63EH0eR2Ekv2nBuQXr2cSAkTxRSHoHKa06mq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(396003)(376002)(346002)(366004)(451199015)(38350700002)(66946007)(38100700002)(66556008)(8936002)(2906002)(5660300002)(66476007)(7416002)(4326008)(41300700001)(8676002)(2616005)(186003)(26005)(83380400001)(6512007)(316002)(45080400002)(110136005)(52116002)(54906003)(6666004)(6486002)(478600001)(966005)(36756003)(6506007)(86362001)(99106002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3dXQzRSYVZEakdxVUI4dTFNRzlLeHhoNVhQT0tkZllTYThkb2cxRzZyaFJM?=
 =?utf-8?B?ZW12UlF5UnZOcWh0TEkrNkdUOHZtbFQrUlJ0ZVlKVk9RUk1IdzU2SGJaWWgw?=
 =?utf-8?B?ZG8xQWh3K3I3Uk1yMnA0VlZXVVN2a1JrV2MxUTkxdnpwWVVGb3d0VGpoWjNj?=
 =?utf-8?B?dXhvdTI2TXVCeTlFT1FKRVVFbFVCTkUrYXk4OHVCUWlqdEVOVWJoZVZEOUs0?=
 =?utf-8?B?Ui8zS0FzTStHeTNKSVl2ZHZNMVRFVDIxWjhCWHlsY2wvVjlEdDN6MFErcTkw?=
 =?utf-8?B?cFZSS2R5eWhVVmJ1MTRzZnc2a29CT2RhUllyZkppc3g3dnlIcGpINFlqQ2xz?=
 =?utf-8?B?WUtmZHlyajlnalBFR2NnbWh0YlB1T0Nkem5Nc2hNM2dtR28xa2pQTVZGZ0hy?=
 =?utf-8?B?aXcrR2JLZlVZOTZYT3Q4M0kwNzB6NHUyWjE1bVE5NnhGZmpJakg5eXIzUEln?=
 =?utf-8?B?V2xhcFhtTXE3WjQvYkdxUmN2U0lZbkFDK1BETk10KzlrOWFMZzRjTXViRXdr?=
 =?utf-8?B?VGtaS1lsRXpuQlVCeXQ5eFNUUCtFalZDVkNwa0RMVmIzRForTzc3Z21PRVR2?=
 =?utf-8?B?cXdwWHAwWFFobU9KdlJudzVoRitsWjhSSWs4VkRlalQ2M1Nqandnb0lwS0hZ?=
 =?utf-8?B?OU1wOXB5Q3JlTXVjRE9QeGxReGV2WHJBT0JJak4vQmc1MExweEZ3d3NKRWwz?=
 =?utf-8?B?K1lOZVNGbWdqVjhmTHZrRVZsbEZMYkZvMFdKYWh5M2NZMHlTQVh5V1E1UmJI?=
 =?utf-8?B?V0dGYUd0Y1BzNm5LYm0rZkpLZWtLTGhOZzlRNVhTOEdOYUozdHg1WUIvcExU?=
 =?utf-8?B?dGdDR1V6NXgvYkhMbGZxTmR0MkM3d29Nb1pQU0Rha29wSjU5alpacmxYOWIy?=
 =?utf-8?B?azhCQTJ6UjdmZXNVSm9FbEs5SlFmNWVZaDJCVmpOalJnM0dBVEJBOUlWZ3RV?=
 =?utf-8?B?T0FxbXBvSUZ5dDVmblk1WDlObGVITnhoS0hRb3g5TE50RCtMLzRiM2IzSkpz?=
 =?utf-8?B?Ungrb0J1ejRPSFdnMXlzZ0NzZlNQVzBXMkhSVWI5b1VUSzdiMWVycFdLeCtV?=
 =?utf-8?B?aW5SUmFKM0piWS9Ld3I0WWJBN1A1b2VvTVlwOXgzbUdmWnJyc1RWbFlUSHE2?=
 =?utf-8?B?ZWpSRXc4R1lnNmJKbWQ4ZTVKUjU2OThpZjZpdnFiNTJucE1BSzQvdGg2bEcy?=
 =?utf-8?B?cmMybTUxRlJydlM3dzJRWGVuQjNaWmdYNVdkTW9tWmJ6TWk4K1NaVlZDdzNt?=
 =?utf-8?B?RXIxY1Rtb2loSDVFUmhyd1FMaTBsZThFc0lld0k2NEhKWXBkMENiaXY3SHVD?=
 =?utf-8?B?YzZqOWRFOWV1MTBnak53VE1mc2p2TkYvN1p2RUlsRnN5VTA5dGdGNDVOR0pv?=
 =?utf-8?B?THJwSGZqQXM2UUw0aWtXT09Id2VoTm5Nd3Z4TUR5Z1F0YWRsT2lXM0ROTXAr?=
 =?utf-8?B?L3QxRk56K2ZNeHdZVnNOTXhHOGtwb0FCVEVTYVRmbzVBVk5IekVPTC8yVTBC?=
 =?utf-8?B?MHllZ1hNY1FONnlCZEx2TWh3czRIMzYrZ29RbFFEV2ordFp5N2FFQWlDdVlE?=
 =?utf-8?B?VEt5azZ2QkFkbm1lQVpGa1cvRFM1eGZ0akZBZjQzOXE4bVgrVFk3NmJEMHNO?=
 =?utf-8?B?RVZ6K013TGhtdGN2UmhlbkszVjdMWTF0Z1JlclByRWlUd2pYRXBkRlVSRTVM?=
 =?utf-8?B?K20xbEtvRGR5M2daa0w2a3RaYTdTSFNhNW1FSm9QZUwyOHlvN3dnb29rdXhQ?=
 =?utf-8?B?NlJydXJJRldkdVlkeHdiMVBvbFpKQlQvT1JRelVDNUVkRnQ1UE9FTnREYmE0?=
 =?utf-8?B?MUJRdmpPdUVvd081YmExSXpyemtyMEo4NGs5bmI3Y1lqWktZZUhlWnJLZ0dm?=
 =?utf-8?B?aGNWRFpIRTBWb3lHMDE2MHVXQk5Od291dXJBTjdGY2lMOHNNa1VDWER6Q3Vu?=
 =?utf-8?B?YUNlV2MzaTBSZy8xR1hDbXoxY09PQlBPVzJqUkJCTS9zY3hBK2YyZG1Sc1Za?=
 =?utf-8?B?NFRlSkl3K0NldUVUOXBaK2d1M00yU3FnRG5WK09abTJYdlBhQWo5TDh0QU9p?=
 =?utf-8?B?anVVZFVTRlhkWG1USHNuSVh4REZGeWllRGRqVXZwbGh6VHlueDduSEJTVUEx?=
 =?utf-8?Q?s2ScbrrxdEj6q1xefiSQFpByk?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b84548f6-e32a-40aa-9ccf-08daf9bbe8c9
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 01:24:29.2323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HlLCpx+TZqYEZ+jPVhnIs26Xzrb06dWdr7QthCzbpPH8SA2HBJAi81Qu/KoTpS9ZrTBHPE4e2TuUF33izfjEjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7220
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,

On Wed, 2023-01-18 at 13:31 +0000, Marcel Ziswiler wrote:
> Hi Liu
> 
> Thank you very much for your valuable feedback.
> 
> On Wed, 2023-01-18 at 16:47 +0800, Liu Ying wrote:
> > Hi Marcel,
> > 
> > On Wed, 2023-01-18 at 08:26 +0100, Marcel Ziswiler wrote:
> > > From: Liu Ying <victor.liu@nxp.com>
> > > 
> > > This patch adds pwm_lvds0/1 support together with a
> > > i.MX 8QM LVDS subsystem device tree.
> > > 
> > > Signed-off-by: Liu Ying <victor.liu@nxp.com>
> > > Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > > 
> > > ---
> > > 
> > > Changes in v4:
> > > - New patch combining the following downstream patches limitted
> > > to
> > > LVDS
> > >   PWM functionality for now:
> > >   commit 036c6b28a186 ("arm64: imx8qm.dtsi: Add LVDS0/1
> > > subsystems
> > > support")
> > >   commit c3d29611d9d4 ("arm64: imx8qm-ss-lvds.dtsi: Add
> > > pwm_lvds0/1
> > > support")
> > >   commit baf1b0f22f8a ("LF-882-1 arm64: imx8qm-ss-lvds.dtsi:
> > > Separate
> > > ipg clock for lvds0/1 subsystems")
> > 
> > Sorry, I don't think the downstream patches are doing things
> > correct.
> > The biggest problem is that the lvds related devices should be
> > child
> > devices of display subsystem pixel link MSI bus device(See below
> > comments).
> 
> Remember, I even inquired about this [1] but did not get any feedback
> (yet).
> 
> > I have local patches to add some lvds related devices which haven't
> > been submitted.
> 
> As mentioned before, I would be very interested in actually testing
> such and giving hopefully valuable
> feedback.

We don't have any official public git for sharing local patches like I
mentioned earlier.  That's not convenient.  I'll see if I can share my
local patches/changes to you in some way, or please wait until they are
submitted for review.

> 
> > >  .../boot/dts/freescale/imx8qm-ss-lvds.dtsi    | 83
> > > +++++++++++++++++++
> > >  arch/arm64/boot/dts/freescale/imx8qm.dtsi     |  1 +
> > >  2 files changed, 84 insertions(+)
> > >  create mode 100644 arch/arm64/boot/dts/freescale/imx8qm-ss-
> > > lvds.dtsi
> > > 
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-lvds.dtsi
> > > b/arch/arm64/boot/dts/freescale/imx8qm-ss-lvds.dtsi
> > > new file mode 100644
> > > index 000000000000..4b940fc3c890
> > > --- /dev/null
> > > +++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-lvds.dtsi
> > > @@ -0,0 +1,83 @@
> > > +// SPDX-License-Identifier: GPL-2.0+
> > > +/*
> > > + * Copyright 2023 NXP
> > > + */
> > > +
> > > +/ {
> > > +       lvds1_subsys: bus@56240000 {
> > > +               compatible = "simple-bus";
> > 
> > In my local patches, there is no 'lvds{0,1}_subsys'. Instead, lvds
> > related devices are child devices of 'dc{0,1}_pl_msi_bus' buses,
> > something like this:
> > 
> > In imx8qm-ss-dc.dtsi:
> > &dc0_subsys {
> >         dc0_pl_msi_bus: bus@56200000 {
> >                 compatible = "fsl,imx8qm-display-pixel-link-msi-
> > bus",
> > "simple-pm-bus";
> >                 #address-cells = <1>;
> >                 #size-cells = <1>;
> >                 reg = <0x56200000 0x20000>;
> >                 interrupt-parent = <&dc0_irqsteer>;
> 
> Concerning irqsteer I was unsure about whether or not all this is
> already upstream. At least the device tree
> parts seem missing.

Dt-binding documentation and driver were upstreamed:
Documentation/devicetree/bindings/interrupt-
controller/fsl,irqsteer.yaml
drivers/irqchip/irq-imx-irqsteer.c

'dc{0,1}_irqsteer' is not yet upstreamed in device tree.

> 
> >                 interrupts = <320>;
> >                 ranges;
> >                 clocks = <&dc0_disp_ctrl_link_mst0_lpcg
> > IMX_LPCG_CLK_4>,
> 
> I believe those IMX_LPCG_CLK_ are indices only. But more on that
> further below.

Yes, they should be indices and an IMX_LPCG_CLK_ index should be used
here to specify the consumed clock according to imx8qxp-lpcg.yaml.

> 
> >                          <&dc0_disp_ctrl_link_mst0_lpcg
> > IMX_LPCG_CLK_4>;
> >                 clock-names = "msi", "ahb";
> >                 power-domains = <&pd IMX_SC_R_DC_0>;
> >                 status = "disabled";
> >         };
> > };
> > 
> > In imx8qm-ss-lvds.dtsi:
> > &dc0_pl_msi_bus {
> >         lvds0_irqsteer: interrupt-controller@56240000 {
> >                 compatible = "fsl,imx-irqsteer";
> >                 ...
> >         };
> > 
> >         lvds0_csr: bus@56241000 {
> >                 compatible = "fsl,imx8qm-lvds-csr", "syscon",
> > "simple-
> > pm-bus";
> >                 ...
> >         };
> > 
> >         lvds0_pwm_lpcg: clock-controller@5624300c {
> >                 compatible = "fsl,imx8qm-lpcg", "fsl,imx8qxp-lpcg";
> >                 ...
> >         };
> > 
> >         lvds0_pwm: pwm@56244000 {
> >                 compatible = "fsl,imx8qm-pwm", "fsl,imx27-pwm";
> >                 ...
> >         };
> > };
> > 
> > The below patch is needed to use clocks for pixel link MSI bus as a
> > simple-pm-bus.
> > 
> > 
> > 
https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flkml%2F20221226031417.1056745-1-victor.liu%40nxp.com%2Ft%2F&data=05%7C01%7Cvictor.liu%40nxp.com%7Cc85f20a3212c4da6178f08daf9585749%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638096455062491606%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=SR5g4yuJ14y3tqRNM3QdlF7gmWeup74D6Q69F8gJhlU%3D&reserved=0
> > 
> > "fsl,imx8qm-lvds-csr" needs to be added into
> > simple_pm_bus_of_match[]
> > in simple-pm-bus.c.
> 
> Okay, I was not aware of that.
> 
> > > +               #address-cells = <1>;
> > > +               #size-cells = <1>;
> > > +               ranges = <0x56240000 0x0 0x56240000 0x10000>;
> > > +
> > > +               lvds0_ipg_clk: clock-lvds-ipg {
> > > +                       compatible = "fixed-clock";
> > > +                       #clock-cells = <0>;
> > > +                       clock-frequency = <24000000>;
> > > +                       clock-output-names = "lvds0_ipg_clk";
> > > +               };
> > > +
> > > +               lvds0_pwm_lpcg: clock-controller@5624300c {
> > > +                       compatible = "fsl,imx8qm-lpcg";
> > 
> > Should list "fsl,imx8qxp-lpcg" as one item as well, since imx8qxp-
> > lpcg.yaml mentions it.
> 
> Agreed.
> 
> > > +                       reg = <0x5624300c 0x4>;
> > > +                       #clock-cells = <1>;
> > > +                       clocks = <&clk IMX_SC_R_LVDS_0_PWM_0
> > > IMX_SC_PM_CLK_PER>,
> > > +                                <&lvds0_ipg_clk>;
> > > +                       clock-indices = <IMX_LPCG_CLK_0>,
> > > <IMX_LPCG_CLK_4>;
> > > +                       clock-output-names =
> > > "lvds0_pwm_lpcg_clk",
> > > +                                           
> > > "lvds0_pwm_lpcg_ipg_clk";
> > > +                       power-domains = <&pd
> > > IMX_SC_R_LVDS_0_PWM_0>;
> > > +               };
> > > +
> > > +               pwm_lvds0: pwm@56244000 {
> > > +                       compatible = "fsl,imx27-pwm";
> > 
> > Need to document "fsl,imx8qm-pwm" in imx-pwm.yaml and list it in
> > the
> > compatible sting here.
> 
> But so far no such "fsl,imx8qm-pwm" exists anywhere. Is it really
> required?

Yes, I think it is required. See imx-pwm.yaml, there are quite a few
"fsl,soc-pwm" compatible strings listed as one item together with
"fsl,imx27-pwm".

> 
> > > +                       reg = <0x56244000 0x1000>;
> > > +                       clocks = <&lvds0_pwm_lpcg 0>,
> > > +                                <&lvds0_pwm_lpcg 1>;
> > 
> > In my local patches, I set the clocks property as:
> >                 clocks = <&lvds0_pwm_lpcg IMX_LPCG_CLK_0>,
> >                          <&lvds0_pwm_lpcg IMX_LPCG_CLK_4>;
> > 
> > I'm not sure if it is correct now.
> 
> I doubt as those IMX_LPCG_CLK_ are defines for the indices e.g.
> IMX_LPCG_CLK_4 actually is 16 and not 1 (or 4)
> (;-p).

IMX_LPCG_CLK_ should be used here.

Like I mentioned above, imx8qxp-lpcg.yaml explicitly said "The clock
consumer should specify the desired clock by having the clock ID in its
"clocks" phandle cell. See the full list of clock IDs from:
include/dt-bindings/clock/imx8-lpcg.h".

> 
> > > +                       clock-names = "per", "ipg";
> > > +                       assigned-clocks = <&clk
> > > IMX_SC_R_LVDS_0_PWM_0
> > > IMX_SC_PM_CLK_PER>;
> > > +                       assigned-clock-rates = <24000000>;
> > > +                       #pwm-cells = <2>;
> > > +                       power-domains = <&pd
> > > IMX_SC_R_LVDS_0_PWM_0>;
> > > +                       status = "disabled";
> > 
> > In my local patches, this node has the below interrupt related
> > properties:
> >                 interrupt-parent = <&lvds0_irqsteer>;
> >                 interrupts = <12>;
> 
> As mentioned above my familiarity with irqsteer is far from complete.
> Plus interestingly for me this LVDS PWM
> actually really works without interrupts. Not sure whether or not or
> what exactly might not "fully" work
> without.

Device tree describes hardware, which doesn't bind with
software/operating systems.  If an IP generates interrupts to an
interrupt controller, then the interrupts property should be documented
in dt-binding documentation and device tree should list the property.

imx-pwm.yaml actually requires the interrupts property.

Regards,
Liu Ying

> 
> > > +               };
> > > +       };
> > > +
> > > +       lvds2_subsys: bus@57240000 {
> > 
> > Above comments apply for 'lvds2_subsys' similarly.
> > 
> > [...]
> > 
> > Regards,
> > Liu Ying
> 
> [1] 
> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fall%2F549bf1f26b8212de2d4890a27e396250257aa027.camel%40toradex.com%2F&data=05%7C01%7Cvictor.liu%40nxp.com%7Cc85f20a3212c4da6178f08daf9585749%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638096455062491606%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=9VyU3y7%2BCbmNNvtfWIXK4p1xaDpCEIh9q2crZNmzgO0%3D&reserved=0
> 
> Cheers
> 
> Marcel

