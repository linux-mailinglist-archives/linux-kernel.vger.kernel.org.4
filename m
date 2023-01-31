Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3636823FA
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 06:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbjAaF3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 00:29:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbjAaF2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 00:28:43 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on20629.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1a::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1985243461;
        Mon, 30 Jan 2023 21:27:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mI4FwkwMqZvlEfmt1CRiBaiDz+g3zQoF7PyA5YE3udUpl3YN62k8pssHISV431nbYsat63vn0qjBAqy3iU2E2a+bvn72oWpGL3WdOL1XTDsjP2+Pa8uHLQEhEyc58asQVEwNSNim+9XmFUyBQ3A7IBK5hCplvAHdbHIJxU2sEeT2ocLbTgC+idtODpYDa6D3ZeLZ7UqRv/TsE+TdxKEhOTGBtcTa+RJOdimTAAzK4MdITSAAiCt46R9JNrT5vAlO0VAQUZw+xvB6AvirtB9VTAuffdPN2Wc5pWsDD0vNMIWGITE+IGEPaSrn1vXg8cOBbIAhLLPDQt4kQFp1Ry3veA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xqycgPEvyhV+tokrz7OT4gt8V9zG/0934KM+NqLSd+w=;
 b=M+c6137xdkxQhybvNxNZnTpkVRCtr4GWwhmBxPV8ssK4/mEFkH68Bv8VP16idGhNL1CbGIWPmwUboMxzX/nkheu4v8BpWT/qM/56kV+AztuPMwSPdW3FtEcYgihKy0q7T0VbfrvaU5ZFQ5ukL8w627bYa8GMzEeuFztArXgFa7Tlnqo6sYxJrQ+IJz4HhGmhFKlAq9195HGMRdktTetKh/OZfl2f/4OC8bQ7mpMZLGjrOlAmAdEB4p5UAj+/b+Xr3O9oZxPWW75wENyvWLWu+TLHR66a4Vw4YbNfJlpH45i4rmnsksponV/IHzS6WiZ90lC5b2Rl3c7/JD7VbWHhwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqycgPEvyhV+tokrz7OT4gt8V9zG/0934KM+NqLSd+w=;
 b=IH2dIZcgvFgTEtxFQdivi388UXLjGHZdZfjfFFBXWAvE7bN0MgU0VA1Edx5CNitckGs0+EPm4tKSX0wPa3ufyIOe+dWcsnsArG4BaADh5IShZawR309ka9MIo07mxKj+v2AMlkG1Jo70dOj9el0ffkdir6W+3jD0Ed4nrW9/QTk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by DBAPR04MB7477.eurprd04.prod.outlook.com (2603:10a6:10:1a9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Tue, 31 Jan
 2023 05:27:06 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::5725:92ec:f43e:f5fc]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::5725:92ec:f43e:f5fc%9]) with mapi id 15.20.6043.038; Tue, 31 Jan 2023
 05:27:06 +0000
Message-ID: <cb54630ec2cebe6cf4707be2d41bcd93bd7a9c62.camel@nxp.com>
Subject: Re: [PATCH] driver: bus: simple-pm-bus: Add Freescale i.MX8qm/qxp
 CSR compatible strings
From:   Liu Ying <victor.liu@nxp.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        saravanak@google.com
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-imx@nxp.com, Rob Herring <robh@kernel.org>,
        Lee Jones <lee@kernel.org>, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, Linux PM list <linux-pm@vger.kernel.org>
Date:   Tue, 31 Jan 2023 13:26:33 +0800
In-Reply-To: <CAMuHMdV0EJP5UXri3phWsCDRaoXuB=ZWK=ibwd6i-V=9f_bLkA@mail.gmail.com>
References: <20230125083248.1305270-1-victor.liu@nxp.com>
         <CAMuHMdU0KaRyP0qxJLwit1G=7zMr1k5wpCkG-wD31958mrKRWg@mail.gmail.com>
         <7c84cbd1808dc89f9ddaece13f846c4fbd12935a.camel@nxp.com>
         <eea19462-8dfa-8e10-2638-70f6f1ecc193@linaro.org>
         <2d06468ab1274af3c84e61dbca8d172b9d64cd68.camel@nxp.com>
         <f551d663-f7b6-5ae3-89a9-af1ae0d6216e@linaro.org>
         <CAMuHMdV0EJP5UXri3phWsCDRaoXuB=ZWK=ibwd6i-V=9f_bLkA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0214.apcprd06.prod.outlook.com
 (2603:1096:4:68::22) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|DBAPR04MB7477:EE_
X-MS-Office365-Filtering-Correlation-Id: 691d9471-dcb7-40ff-82ec-08db034bca86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RNvza4T9oS3X/i5HCJVA0tm0SkPBMYMjkqcZrICE8rHQ2gsO0ulq9z7DDFh00WD6/qZB4zwNDd4JQVfM+E3qYSMCI/uOr7UCJ1hi7NDP2uxhWKTGMOZ27RXnEeRPW+zUx7W8GFlnVqdN0RqjkFKxy4sV/n7JIYFifzkQznxxn43Ej5jOO33AfIIGFBxtexDmsiMBYPKiqKQ/uy7OjnmA/v9AkmH9LU0JfhOah6TXDDv8YkoMHF+2kTOsKC/PnWy0x6Ts0jJKt++SumSY/C6G8IUSEH6kI+HBCwTk5ytBdeRSrjYniOy9B/UGGJWvidKG8Kn1wwnOpJ2o3pXjDSFLjUTu/JLP1u5LczRpYZCeVE0FPockPXis98oifVoiuSMIGKM3iWON4GAryM1qGV4lFeSU5Cyq+CJtAfjPee0HGX8hGLr5N3zhNalMNtASLMuRhxbNXRRf5esxsV0orVnUyksr6ZjOh4rW6TnMCqF0lR0zjsRd+3JZxwk2cvRnf8mR1imTEEyYBaiBrwADWn55ipJKspmR41wBjlqX4fej5pKiSIT01R50ijvEsUPu7KwVbOS3lceVPRczPQsWE5wgmWbx8MyHUdovw2FQqHuVNAl60fgfqqXRqdAMN+9VGruPKkZSWq2yvXfx3LQuP25jY/3qeRNM26a0cEiEAeQX2ybIlMgZdJI0TKmgnrbW8FRKi+c0ZLgkNQ6CrWehAr9xb6eYhIxJm7CVod3RsF8Nd9uTlCu6ciYiee67NBCmcJ3ZZ0tsCCAglRljGxH28fzeMvSqfHGMBt6Y81moBmflU8U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(366004)(136003)(346002)(396003)(451199018)(8936002)(41300700001)(86362001)(5660300002)(7416002)(83380400001)(2616005)(110136005)(54906003)(4326008)(316002)(45080400002)(38350700002)(38100700002)(8676002)(66946007)(66476007)(66556008)(6666004)(186003)(6506007)(6512007)(53546011)(52116002)(966005)(36756003)(26005)(478600001)(6486002)(2906002)(99106002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1ErQ2xhSitRNnFmZ3hzL1BiY3JDMTZ2aVlQL2N3M2lMOW9tYXJZbnNlYy9m?=
 =?utf-8?B?Y01NRUlrUkZYVXRBUnQ1dWJLRllCT002Mzc4dFQxY1F2QUZrait3bjcwd0tu?=
 =?utf-8?B?UE4rUkFkYU5ab2xpNXVEWE9MdDVFQ0psSWZWTFRnbTBuWGNWZlFGZ0lHblJO?=
 =?utf-8?B?T1JJcWZEbnFRZmtFYWkzd1FRZE1wYUpKRGlpYm5oRFVxWTBvaDE5Y0EvT2xJ?=
 =?utf-8?B?b3N3a0xSTFdWank0U2JJOEkrUHA4V3BCR3hwMmpRbTlxdEdzVFJOWU5kVjlO?=
 =?utf-8?B?SGhpNXlWVjlnRGpXTFZybThjUkxRcTdCNWdnUmlSV1N2eWhNYXJlUi9RMmhh?=
 =?utf-8?B?dkFtRndIOXI0WW1uUi9pRDM2TWxkS29LYSs4aTZBbUdtaXdzNTc0NkprcFlr?=
 =?utf-8?B?TXBKYkNVdFY1Mi9Uc09RNkpCL0JYcEdPRHBDZ1k4aWkvTEZwcHUxM0Nwektz?=
 =?utf-8?B?UU5yYUxsdUR6QzNNaWxDQmMrL2VlWFk0S0Q1eG5odEhBK0o1K0pVMSt3Zmtq?=
 =?utf-8?B?bExqZmF5Tm1VdGRCRmtTUFhKV1JxSVRnWkcrZGZ3UE4vUk1NOFRadDA3OHFs?=
 =?utf-8?B?a2ZaQWI2L1Ficm5FVGxSdnUvZjU0N3Bkb3RDUklKTEx1cS8yWXlkamV0K245?=
 =?utf-8?B?NEVmbS9sNmhlMi9oMHc2WTZ0clN3THRjZXlNaGZVZW5JRGJwbUtjdUZCYllK?=
 =?utf-8?B?QmNmMG1nT2lwTjNCVG5MNFYzVGQ5R01DL2RJeFZML0ROWHpXMDQwMnlHQUdU?=
 =?utf-8?B?RElpdTVjK3ZKSnNieWdJUXd1eFgzbkFPUnlpNnViMjRXMlVBbERoYjJnRlM3?=
 =?utf-8?B?aFpCOXNnTlVadDN5ZVkrR0FHYlRENnRzcmdmRkxUMXc4NDFzUmxXcmRlTllD?=
 =?utf-8?B?Y0NQMzBpaWNWeEdmZ3RkQXBxU1Y1WWU1YklEKzZXWWJwMSt1cktBcXlHUmw2?=
 =?utf-8?B?YllzWnpqOGFUbm5jZGpiQlhyZ2Y0dUpFVXhNT29GaUFQREwwNTljSUxtMjFD?=
 =?utf-8?B?cEdueklyd3IvRzZqNlBEVFJyRGdNRjQyRXdxb1VyTmRGUlUvNHVhL1pNZ21V?=
 =?utf-8?B?U3A4S3ZXd1NEaG1URjJwVTN4OEY3V1pHeGlJNjV5SkNxVm1PbjJHeThONzhv?=
 =?utf-8?B?bXBabExXMFgrZmNhQVBXVHZwUi91Znhpb2J1allqZXRkbGU1YVROcUttczZW?=
 =?utf-8?B?TGowaENna3pTNjlZQjVkUVFZV2ZtSUFsaVgrdzNjUG5NcUdEem5CdVYwRWNq?=
 =?utf-8?B?bERaTFN5NjJRMzN1cjh2MzdsMUdlR0w0d25CSWVYR0R1M3ZYc1loK0oyVzdi?=
 =?utf-8?B?eVBWSFpZWHBGYmhacktYZFdZUVhFZm81V1ZVVVRWZ0NhZzZ6Sk9VN2NmU1RN?=
 =?utf-8?B?aGs4aDc1cUlibko1KzcyNGcxTDRmMzBra0JJN0lPY1RUdDFralNTTm1yNFUx?=
 =?utf-8?B?T1hsVTR5bitQUnBnMlRSSFpFSExlSW9NQ01ucEJpaTNvZi9JTHRhd1UrYkNm?=
 =?utf-8?B?ZEN3YXM5T0pYUXhEcllRNzdwekRtZ2V2aFpERmxzS05LUGRjSjdpNzFha1ND?=
 =?utf-8?B?cE54VENpcjBjSHVUZFBtY1J3S1RUV0VlRHZ3cXB2SUU4bFZnTGg3NUhnOFNu?=
 =?utf-8?B?Vk1aenp4NHpOd2w5aFZBbW9aeU1Xcm95eDNJWW52eVB1M2lSRWoydHgxd0xG?=
 =?utf-8?B?KzExSzNDTisydktUOWV4bHJENGFMSWdWRzNuQkEvam90alMrRDhGRHlzWEdF?=
 =?utf-8?B?MzlHajZ3YW13RWZPNXNmVjVueWIxUDVxTTdhbjVPWkE2YWtyVVRvQkY5alFY?=
 =?utf-8?B?TndndjIzdGE3TU01V25GSFhQZ2ZuaEgvdGptbzVpcnNicDJNMFU1RmY3L2pT?=
 =?utf-8?B?ZHpQSkQ1dE5IaFkydkVTRDlmMllrbEhnS2JGMWJLVnlka3lVcTVVUlZlb1dK?=
 =?utf-8?B?MEFscGxyN29mbjducE9jckY5ZDhiTnUvc2gzWEtFWkxQTnhwL1RGUHVFVldt?=
 =?utf-8?B?OTl1R0ZZZm03czZFa24zUEs4bjU2a0xPUmhadjYrUUZmN3Zsd1BTNGJ3M1o3?=
 =?utf-8?B?eUhhYWkyUUg2NS9JUjM4am1Tazdub0lJemRYT2swTnkxY0JiTGZuWnF4Vlow?=
 =?utf-8?Q?/j8yS/uu1WhTjZAWDKFhLsrcT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 691d9471-dcb7-40ff-82ec-08db034bca86
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 05:27:06.5622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2H1hIggfle0gQtI/MFED+/rinJVLwit8SpxZ0B8J7rKju//sqn6H9M89UHgT4eUrfldBwiHRTEfbwYndXx3juA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7477
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,T_SPF_PERMERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-01-30 at 09:13 +0100, Geert Uytterhoeven wrote:
> Hi Krzysztof,
> 
> On Sun, Jan 29, 2023 at 11:49 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> > On 29/01/2023 09:13, Liu Ying wrote:
> > > On Thu, 2023-01-26 at 13:45 +0100, Krzysztof Kozlowski wrote:
> > > > On 26/01/2023 03:54, Liu Ying wrote:
> > > > > On Wed, 2023-01-25 at 10:05 +0100, Geert Uytterhoeven wrote:
> > > > > > On Wed, Jan 25, 2023 at 9:31 AM Liu Ying <
> > > > > > victor.liu@nxp.com>
> > > > > > wrote:
> > > > > > > Freescale i.MX8qm/qxp CSR module matches with what the
> > > > > > > simple
> > > > > > > power
> > > > > > > managed bus driver does, considering it needs an IPG
> > > > > > > clock to
> > > > > > > be
> > > > > > > enabled before accessing it's child devices, the child
> > > > > > > devices
> > > > > > > need
> > > > > > > to be populated by the CSR module and the child devices'
> > > > > > > power
> > > > > > > management operations need to be propagated to their
> > > > > > > parent
> > > > > > > devices.
> > > > > > > Add the CSR module's compatible strings to
> > > > > > > simple_pm_bus_of_match[]
> > > > > > > table to support the CSR module.
> > > > > > > 
> > > > > > > Suggested-by: Rob Herring <robh@kernel.org>
> > > > > > > Suggested-by: Lee Jones <lee@kernel.org>
> > > > > > > Signed-off-by: Liu Ying <victor.liu@nxp.com>
> > > > > > > The CSR module's dt-binding documentation can be found at
> > > > > > > Documentation/devicetree/bindings/mfd/fsl,imx8qxp-
> > > > > > > csr.yaml.
> > > > > > > 
> > > > > > > Suggested by Rob and Lee in this thread:
> > > > > 
> > > 
> > > 
https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatchwork.kernel.org%2Fproject%2Flinux-arm-kernel%2Fpatch%2F20221017075702.4182846-1-victor.liu%40nxp.com%2F&data=05%7C01%7Cvictor.liu%40nxp.com%7C721a36c64fab482d5d3908db0299e1d8%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638106632175447990%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=jnxUn2N33xjrmNfGXw02SeG5EN%2Fqluz%2BjZYRk0%2BHlrU%3D&reserved=0
> > > > > > > 
> > > > > > >  drivers/bus/simple-pm-bus.c | 2 ++
> > > > > > >  1 file changed, 2 insertions(+)
> > > > > > > 
> > > > > > > diff --git a/drivers/bus/simple-pm-bus.c
> > > > > > > b/drivers/bus/simple-
> > > > > > > pm-
> > > > > > > bus.c
> > > > > > > index 7afe1947e1c0..4a7575afe6c6 100644
> > > > > > > --- a/drivers/bus/simple-pm-bus.c
> > > > > > > +++ b/drivers/bus/simple-pm-bus.c
> > > > > > > @@ -120,6 +120,8 @@ static const struct of_device_id
> > > > > > > simple_pm_bus_of_match[] = {
> > > > > > >         { .compatible = "simple-mfd",   .data = ONLY_BUS
> > > > > > > },
> > > > > > >         { .compatible = "isa",          .data = ONLY_BUS
> > > > > > > },
> > > > > > >         { .compatible = "arm,amba-bus", .data = ONLY_BUS
> > > > > > > },
> > > > > > > +       { .compatible = "fsl,imx8qm-lvds-csr", },
> > > > > > > +       { .compatible = "fsl,imx8qxp-mipi-lvds-csr", },
> > > > > > 
> > > > > > I did read the thread linked above, and I still think you
> > > > > > should
> > > > > > just
> > > > > > add "simple-pm-bus" to the compatible value in DTS, so no
> > > > > > driver
> > > > > > change
> > > > > > is needed, cfr.
> > > > > > Documentation/devicetree/bindings/bus/renesas,bsc.yaml.
> > > > 
> > > > I don't think we want to start putting specific compatibles
> > > > here. We
> > > > don't do it for simple-mfd, syscon and simple-bus, so neither
> > > > should
> > > > we
> > > > do it here.
> > > > 
> > > > > This means that i.MX8qm/qxp CSR module dt-binding
> > > > > documentation
> > > > > needs
> > > > > to be changed.  I'd like to know how Rob and Krzysztof think
> > > > > about
> > > > > that.
> > > > 
> > > > The fsl,imx8qxp-csr.yaml bindings are broken anyway... You have
> > > > device
> > > > specific bindings for non-simple device but use simple-mfd. You
> > > > cannot.
> > > > simple-mfd means it is simple and none of the resources are
> > > > needed
> > > > for
> > > > children, but that binding contradicts it.
> > > > 
> > > > Now you kind of try to extend it even more make it more and
> > > > more
> > > > broken.
> > > > 
> > > > Rework the bindings keeping them backwards compatible. The
> > > > combination
> > > > with simple-mfd should be deprecated and you can add whatever
> > > > is
> > > > needed
> > > > for a proper setup.
> > > 
> > > I did try to rework the bindings and make the combination with
> > > simple-
> > > mfd deprecated. However, it reminds me the problem that "simple-
> > > pm-bus"
> > > and "syscon" can not be in compatible string at the same time,
> > > otherwise, nodename should match '^syscon@[0-9a-f]+$' and
> > > '^bus@[0-9a-
> > > f]+$' at the same time. I mentioned the problem in the same
> > > thread[1]
> > > where Rob and Lee suggest to go with this patch. "syscon" is
> > > needed
> > > since i.MX8qxp MIPI DSI/LVDS combo PHY node references the CSR
> > > module
> > > through a phandle, so dropping/deprecating "syscon" is a no-go.
> > > 
> > > Also, as Rob mentioned in [1] "if register space is all mixed
> > > together,
> > > then it is the former and an MFD", I think the CSR module should
> > > fall
> > > into the simple-mfd category.
> > 
> > You are now mixing MFD with simple-mfd. If you have clocks there or
> > any
> > other resources, it's not simple-mfd anymore.
> 
> I beg to differ (but not w.r.t. the other resources): if any "glue"
> device
> between parent and child hierarchies does not call
> pm_runtime_enable(),
> Runtime PM (which is a Linux thing, not a DT thing) for the children
> may not work correctly, as it won't propagate correctly to the
> parent.
> So IMHO this is something to fix in Linux, not in DT.
> 
> > > Take i.MX8qxp MIPI DSI/LVDS CSR module as
> > > an example, child device pxl2dpi register offset is 0x40, while
> > > child
> > > device ldb register offsets are 0x20 and 0xe0.
> > > 
> > > Geert, Krzysztof, can you please consider to keep this patch as-
> > > is,
> > > since it seems that there is no other option?
> > 
> > There are other options, why do you say there is no? Making it
> > proper
> > binding/driver for its children without abusing simple bindings.
> > Simple
> > bindings are for simple cases and this turns out not the simple
> > case.
> 
> Or drop the ".data = ONLY_BUS" for "simple-mfd"?

Saravana said it's wrong to deleting ONLY_BUS for "simple-mfd". See
Saravana's comments in [1].

[1] 
https://lore.kernel.org/linux-arm-kernel/CAGETcx_QVaYYHsD9HZmBu404K-oXRCPm4N4GRrYu4pGyw2DHbg@mail.gmail.com/

Regards,
Liu Ying

> (and treat "simple-bus" the same as "simple-pm-bus", too ;-)
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- 
> geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a
> hacker. But
> when I'm talking to journalists I just say "programmer" or something
> like that.
>                                 -- Linus Torvalds

