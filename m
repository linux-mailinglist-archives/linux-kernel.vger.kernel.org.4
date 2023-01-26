Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8090B67C69E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 10:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236179AbjAZJGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 04:06:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbjAZJGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 04:06:51 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2072.outbound.protection.outlook.com [40.107.247.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8051420D
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 01:06:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AEaJpce9S6TBItKBYXrnZHWRRoA9KI5Uftg6+0adgBeZvcUxhD+MIvEeOfnvDzEF0ZVxO2/qoHUGF8kWb/pwXEKpG4a3uUfNjIpCSKAhosjgrHWQBAxxZ2Z25DbnpWGYPyfm5Wn+59+MR2KnDbfm3oz8YaRKeTRO3oVbWRfHymEKQOzpncMyJAlpH7SjIaxP36O44slWDVq/AtesAE6knjhs5bujG021FrvfRlbPU1ndKeTjvvCu/CO8MBRJcb3tBKHHunFpietoUaCW5A2zEPWzL9Z8z71wbjNfxb8H0HXp485bnYHoY7x4Dpa2M4eWXAO0Ue7oiugTYe1D7LfQ0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3lP5NtImSTmS+skDco4sth0j84cS5Wb7jOAc2MrVnyc=;
 b=N2BRC6iSn01/L15dSkLTnlIxoYW7r1/Dzwxbol86NSxWMBy0SrH7RUbz2FiiAI2MGPeNn6fxD2igtu2Q/bYebtt00UP8UWm/s6pMshoipvvtFfVgmdXC3tZePP1fRWU+VlRrcTgBZ/9ixCQUhLu8LXJS/WhA84k55xb463u+Y4I/2z7Tc0ihekZKy5XorKMfa46WJGxcRGPAE4jvWKuNlPOSPWyRByC0FOHm5Ycx5+JtAvAjfGm+RUzcB71b2exrvNOPS6Ux9xPaFvGBTPcihNCxjvFFoTvilDgaoT0Sben/QqPL5YIYgPELfPcbRn0I7Rp4rSHT/9frwBmyP3KEJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3lP5NtImSTmS+skDco4sth0j84cS5Wb7jOAc2MrVnyc=;
 b=G5wGqeNM/IPQXh0yvA3ZqP+rEz9UcPDo9cpNHc1WGFkeCkUqmFehLLwFCOUlL1HFK/ER+vkQIXy+CzzdNbWe93KwHlHLmt5aRRWg7NqSpjVASkZJf5Yjc0f8TAk2UskqJlx0uxCRSmyu/X0RRr3kYbL5tUl5ZQEII72oZJFsz5o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by DU2PR04MB9051.eurprd04.prod.outlook.com (2603:10a6:10:2e6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.21; Thu, 26 Jan
 2023 09:06:46 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::5725:92ec:f43e:f5fc]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::5725:92ec:f43e:f5fc%7]) with mapi id 15.20.6002.028; Thu, 26 Jan 2023
 09:06:46 +0000
Message-ID: <22a6001c66493aa221f65000fb1880e3cc936ff0.camel@nxp.com>
Subject: Re: [PATCH] driver: bus: simple-pm-bus: Add Freescale i.MX8qm/qxp
 CSR compatible strings
From:   Liu Ying <victor.liu@nxp.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-imx@nxp.com, Rob Herring <robh@kernel.org>,
        Lee Jones <lee@kernel.org>, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org
Date:   Thu, 26 Jan 2023 17:06:19 +0800
In-Reply-To: <CAMuHMdWCBNctQq8Bg0DQFC-Ap_JRzoMtAFozfaB1OssE7Lr6Bg@mail.gmail.com>
References: <20230125083248.1305270-1-victor.liu@nxp.com>
         <CAMuHMdU0KaRyP0qxJLwit1G=7zMr1k5wpCkG-wD31958mrKRWg@mail.gmail.com>
         <7c84cbd1808dc89f9ddaece13f846c4fbd12935a.camel@nxp.com>
         <CAMuHMdWCBNctQq8Bg0DQFC-Ap_JRzoMtAFozfaB1OssE7Lr6Bg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0075.apcprd02.prod.outlook.com
 (2603:1096:4:90::15) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|DU2PR04MB9051:EE_
X-MS-Office365-Filtering-Correlation-Id: 997a1b0f-0656-405e-97a8-08daff7ca6ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9g07PNWEM0xse/NrZy5QqV0kVrHUWdcsGXbRVJAbWjUyqcS0p362SJZlWR6I1rBiN8zJ8T2SWoL1mcfL+j7TlOMC98jjzQtwsK6n2l0pgwIlPYCOCgC0HF9zKRaBZXlAxaPyLGJ9BaxBpgGfSIQK/IFISI9iGTQB4mZ38HgW7TL5SvYIXA/Lxd0CqO0ak821BdxUlNrMCqg0FfTLTSlX/GH/4OoZO95ppAFchSooRNbuNUXOfxa5dx9W8bCpnj+hjVA3bVi9LOiUaZjbUzX/PBBWjKZOUfX/WkjUBIS2ETARBxec2GbKSSQAp9U1TIH9MScK+++M6pdUxtqHWDMGx7ERY9CtYa2YQgrF1hXZq6QHWMU7Vk0wjNKtkEFLlsGrEJ1OwuYAq8wV26p4wFqNm0xNeCC6RRX08CwroFBrqEJ1A4TQxlPQpuXnD2xypE1WTS8gpVv34YR1UR+p9XWP/40TmzLetEbvuLnIUunR2/HbtOTGzfvqXZYwdh7wOuuSEJEhYoY3jS1p5yuou2xJzS03sc6iSUwEnUvi3a0gqm4XROg0gj17jPNZnPpYDS9ErjAhgkY4v06gxEwipQ1ljxJlaVvGuwJQe1TskzvhffVKVzis20VLL70ASTx5CvDRmKMeRYorR9RznTAJ98BWgI8E7qxCQxtxmlU1zSJ5fH8ggsQKr06r/xeJNmnjgmazAXk8nLm9zFBX3NToHbKkZeqBjPXE3BTlFdE5FX6en7uLe3VwNZ8NKmf3nN0mq/Th
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(366004)(376002)(346002)(396003)(451199018)(8936002)(2616005)(83380400001)(36756003)(2906002)(5660300002)(6666004)(66556008)(26005)(186003)(6512007)(66476007)(66946007)(52116002)(45080400002)(53546011)(8676002)(6506007)(4326008)(6916009)(86362001)(6486002)(478600001)(966005)(38100700002)(54906003)(41300700001)(38350700002)(316002)(99106002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aU9xd2Z4SzdnQlkvT216bU1rTVZIcVBSNnVyalJBWkZsenVETWJGNm50bG9B?=
 =?utf-8?B?WTJPZUZ5aGtyZG1RakxnZVE2eVB6dTBPTHhZb1hVNE5ybUh1OU5rUGdlNjNB?=
 =?utf-8?B?Wno2NWxQV2RBR3BRbzNYMmNGTisrQ1lVTEpTS0QvRllkUkM2YUJHaE9vbFI4?=
 =?utf-8?B?bVpGRFRIanZ0eW52WlFZTUt0ZFYwK0RVWEUrQ0FhcVNZTUtVOGNDMjZ6T014?=
 =?utf-8?B?V3NRdjlIdDB6ZGJ5Z1RQNEtqOE8xWk4yMFdWQ3JzL3FsNWtoeEp4anJRRmph?=
 =?utf-8?B?dnZsWHkxTXpVV29QNGFKM1pJaVNPcmYwbEQ4ZmxtMVc1Y1plcDl6M0ZhQnAv?=
 =?utf-8?B?eGtxbitRQWgvWXlHL1dleFl1VnVDMHhkOU9QMGlldHBweFo0TkdrRnIzaS9X?=
 =?utf-8?B?SmYxV0tkSHNCUWFLZTB3ZjAzYlRZcmNTSjdVVjArQ3ZxTWs1RXh3a01YVEM2?=
 =?utf-8?B?ZVNhV1hsaWVZenhMeW16SU1PanpFQnM0QnJPZnZydGpveXlIdTZCc0hRRG9v?=
 =?utf-8?B?WU9jaTlPaTZuL3ZncURLcGYxQTdyVFBmeGg3OUdjeGswUExoZjFnakdCS1Nx?=
 =?utf-8?B?VU5hLzhBZHdIRU5idCsvT2Y1blhKcjFjOWVLNGZWQ1BYaUdWbG5sdUtzVG5H?=
 =?utf-8?B?TjZhMklOU3dQTEZQZFh1YkU5YWJaaWc1NUJYdDhVNE11aUpWTm4wdXNtd0lh?=
 =?utf-8?B?S1FQU0txZnJWQnFsWngwNVJOSFZ3ZFR4M0JRZHArOWdxOVlObmFla25mamk4?=
 =?utf-8?B?OE1yT2Vhc3JvK3hNS1lhVG96R1ZVQTFMYmhEUzA5NlhmWmxLYVFCTkdsSDNY?=
 =?utf-8?B?Umh0bmZlMTBhbGx6MVJtRkFVOXpQMmsyQ1I1bXlDR2U3ampkc3FyM1UwN0Zz?=
 =?utf-8?B?cDRCVFdLbHdqcldNUWNzakNzRzZBUURYYjkwWm5jdjMxa3lKajc4SVdmS0VU?=
 =?utf-8?B?Q3FJSEtHMnpTbTFtZ3ZZcDRKSkYrRWZVcEFXNUNlRmRKS1U5SWo5RlRVaDFX?=
 =?utf-8?B?SitBT2xDZUJrWDlJR2FCMWZQeWU2VjJubENWSFk0UVFRSjFycUxYZXlKaEF6?=
 =?utf-8?B?MWNpWlU1WkprZEZGUjhLUFhQVkh1L1ZlMlA2M1h3bG9TZ0lKT3VmSkoydHhI?=
 =?utf-8?B?QklQaDBsWTJNcThmcDhQb0hMN1d5NTJqQ0ZCZXhFSmdDeUo3S0gwUzczRGFx?=
 =?utf-8?B?bEdRbmNVR3Fzd3JrWGVjSjVPVzMyYytCb3JucXFqdlVYbmxjcTlnOUVrYWhs?=
 =?utf-8?B?Q0I1YzRnTVllTUZ2NjRQNk04UksrdDJnRHZJd0M5NHNwOHpwdGFMeGIydWxP?=
 =?utf-8?B?SCt1aTFHZUVBb0dydGI3OWx1RUZFZnoyYS8vckFJVHJnQ2pheDZ5UmFOWHNQ?=
 =?utf-8?B?dFAxa0pOcjJPZi9jZ0pTRkF4eDZUTEp1RFl5dUdzbllPelBDUkRyZ3R1T3U0?=
 =?utf-8?B?NTExeDFTY215ZmlyTGtRaHFvY1cvT3VUMHZESnZib3o0NEpaWFBPMEJiTVl4?=
 =?utf-8?B?NUFBYjlESkZXRjhONnBHdGwxNGxaWU1ya3lYNHVwKzBEaUhUeFpEdW54SVpn?=
 =?utf-8?B?cnhYVjNBYWVSU3BjOC9SNVhES1VPU0lHK3dDY2RWL2t6ZHI1Y0N0QXNWNE5t?=
 =?utf-8?B?Mk8zVFUxemJScUwrNFQrajUzTDgrNDhLZkhWb2owYXJkZHRGdytUeTZzMDRw?=
 =?utf-8?B?dldadUpiZ2ViaVMzbWdrekpKOERRU0JQaktERndJa2lJbklMN0RtTVkrYndS?=
 =?utf-8?B?Mzh1c2dqYXlubDdJdFUzbUl4T1k2cmRZWXNyY2Yza21DNXdHSkJZVFpVRGFo?=
 =?utf-8?B?OEV3ZUtHVDFtQmVPK284Zmx0Rjg2UVJBYThmR3EwMDJzQ2JFM29hVGpibFk0?=
 =?utf-8?B?d0l0QlRiTVdhN1BsYTZEM2ZCYzloN0U1YVY1bjNPZ2thRlczVWdvUDdYVlNj?=
 =?utf-8?B?dEZ0STViRUlVd0ozZWxYNmtQUFBMQ3J0QUxlK3N5R0NJQUNqOFp0YWprZU05?=
 =?utf-8?B?UnkzRnBJSkVQeUYrR0IyajhCZkg5S2FPU0NHbGhwSjZDTmdBZzMrekNJWWEr?=
 =?utf-8?B?UzgySjJNNXk4amxTcTlIbitabDlNbklGMUxvYnNMWjVYRGtrcUFZZTVsYm5Z?=
 =?utf-8?Q?bUY6xoGSZ2X1PwiCIJTTvNyy1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 997a1b0f-0656-405e-97a8-08daff7ca6ae
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 09:06:46.7583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8tbpnBbLdh5+Hj5idH6ulpJWM2247mWRY+1rTjfqaQbAgzspns7pK7MccqfwqccjyWelgzvx3lJ1iiTK88GNUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9051
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-01-26 at 09:30 +0100, Geert Uytterhoeven wrote:
> Hi Liu,

Hi Geert,

> 
> On Thu, Jan 26, 2023 at 3:55 AM Liu Ying <victor.liu@nxp.com> wrote:
> > On Wed, 2023-01-25 at 10:05 +0100, Geert Uytterhoeven wrote:
> > > On Wed, Jan 25, 2023 at 9:31 AM Liu Ying <victor.liu@nxp.com>
> > > wrote:
> > > > Freescale i.MX8qm/qxp CSR module matches with what the simple
> > > > power
> > > > managed bus driver does, considering it needs an IPG clock to
> > > > be
> > > > enabled before accessing it's child devices, the child devices
> > > > need
> > > > to be populated by the CSR module and the child devices' power
> > > > management operations need to be propagated to their parent
> > > > devices.
> > > > Add the CSR module's compatible strings to
> > > > simple_pm_bus_of_match[]
> > > > table to support the CSR module.
> > > > 
> > > > Suggested-by: Rob Herring <robh@kernel.org>
> > > > Suggested-by: Lee Jones <lee@kernel.org>
> > > > Signed-off-by: Liu Ying <victor.liu@nxp.com>
> > > 
> > > Thanks for your patch!
> > 
> > Thanks for your review!
> > 
> > > 
> > > > ---
> > > > The CSR module's dt-binding documentation can be found at
> > > > Documentation/devicetree/bindings/mfd/fsl,imx8qxp-csr.yaml.
> > > > 
> > > > Suggested by Rob and Lee in this thread:
> > > > 
> > 
> > 
https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatchwork.kernel.org%2Fproject%2Flinux-arm-kernel%2Fpatch%2F20221017075702.4182846-1-victor.liu%40nxp.com%2F&data=05%7C01%7Cvictor.liu%40nxp.com%7C5121c05b779f4003da7b08daff77a9ac%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638103186659610847%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=yyYJNJcWwDjZESJ%2FiAqkEhKbz2jRdDbgmQ%2Bm%2FWwdWZs%3D&reserved=0
> > > > 
> > > >  drivers/bus/simple-pm-bus.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > > 
> > > > diff --git a/drivers/bus/simple-pm-bus.c b/drivers/bus/simple-
> > > > pm-
> > > > bus.c
> > > > index 7afe1947e1c0..4a7575afe6c6 100644
> > > > --- a/drivers/bus/simple-pm-bus.c
> > > > +++ b/drivers/bus/simple-pm-bus.c
> > > > @@ -120,6 +120,8 @@ static const struct of_device_id
> > > > simple_pm_bus_of_match[] = {
> > > >         { .compatible = "simple-mfd",   .data = ONLY_BUS },
> > > >         { .compatible = "isa",          .data = ONLY_BUS },
> > > >         { .compatible = "arm,amba-bus", .data = ONLY_BUS },
> > > > +       { .compatible = "fsl,imx8qm-lvds-csr", },
> > > > +       { .compatible = "fsl,imx8qxp-mipi-lvds-csr", },
> > > 
> > > I did read the thread linked above, and I still think you should
> > > just
> > > add "simple-pm-bus" to the compatible value in DTS, so no driver
> > > change
> > > is needed, cfr.
> > > Documentation/devicetree/bindings/bus/renesas,bsc.yaml.
> > 
> > This means that i.MX8qm/qxp CSR module dt-binding documentation
> > needs
> > to be changed.  I'd like to know how Rob and Krzysztof think about
> > that.
> > 
> > > 
> > > If that doesn't work due to DT binding constraints, the latter
> > > should
> > > be fixed.
> > 
> > Adding "simple-pm-bus" to the compatible value in DTS doesn't work,
> > because "simple-mfd" is matched first and "ONLY_BUS" is set for
> 
> Is that because you have both "simple-mfd" and "simple-pm-bus",
> and the former is listed first in DTS?

Yes. For example, compatible is set as below for CSR module in i.MX8qm
LVDS subsystem.

compatible = "fsl,imx8qm-lvds-csr", "syscon", "simple-mfd", "simple-pm-
bus";

> Does it work if you change the order?

Yes, it works if I swap the positions of "simple-mfd" and "simple-pm-
bus".

Device tree specification says the compatible strings should be listed
from most specific to most general.  "simple-mfd" and "simple-pm-bus"
sound like two different things, so I don't have good idea about the
order.  Replacing "simple-mfd" with "simple-pm-bus" and moving
fsl,imx8qxp-csr.yaml to bus directory look more reasonable to me.  But,
I'd like to know how do device tree folks think.

Regards,
Liu Ying

> 
> > "simple-mfd".  s/simple-mfd/simple-pm-bus/ for the compatbile value
> > in
> > DTS does work, but it means that fsl,imx8qxp-csr.yaml needs to be
> > changed and moved from mfd directory to bus directory...
> 
> BTW, originally I didn't want to introduce "simple-pm-bus" at all,
> and make it just call pm_runtime_enable() for "simple-bus" (PM is
> everywhere anyway), but that was rejected...
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

