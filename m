Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407FE67FD90
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 09:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbjA2INl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 03:13:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjA2INj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 03:13:39 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2073.outbound.protection.outlook.com [40.107.105.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DE213D4D
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 00:13:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RzbJmJxp7FUiPUfB7kMB8boJdnb2RGkhCmB87av4BPLg2SjKH+X65gMgzulLmt3BRX6zYowV6oMwMdvCAP+yKCQJxWENLmegG8bU2cyZzgnWhtZI9micvXtpzL451qosundgnCpV8u1arxkyv0DPymfWPCSVIUmHYDTybDqPv+/SMHz6QryZCeyMGirPcZlyl20hqUi2zg5B5S0vnf2UPpTwODy1ozjiPNc8JXpn9Y57JEjkkttlhEWoqHcwr6Mf+GGI42k0p20LIhXjIMSurtz72fGPo+uHto6p2DTSlrpu/SVhd+XuaIR7kpnLlvXzE+HkgCsUS6gzFt5J9lUgVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7xayl73m+IOefMPW1tBJijEp3bruFOUpsgJ/Y7dTp2k=;
 b=gEf7RlSJU6iXE0oUNYans6eKQdTUyIDHIbozBABJS+MUYJJERxzro1RL/ayACo48JQ9Yh8k0fh3O9GMPD1cUMZ5n4njy618FzudJ4pdGXNWNxYBbw6C3xOJaAT9E1evyvv95rDvjiI+l32jt8nVjzbIP2kOtK1akmH+yrL+zzRmir7BvU+YFSUhzaQuwJE+TE84gfjQ/TbnRa/ae59+H8RkmWTC+eiFcVgA3x8wgqrQfEn89Qb/ho96IYhpahSkV+2oyQlP4yfssQAUSxJsWIjVu+mYQ9w8NzOTQFU3M0fLu5RyXEZeCi2UiuE58ESHh70QLChJh5fOX6u/o38wR2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7xayl73m+IOefMPW1tBJijEp3bruFOUpsgJ/Y7dTp2k=;
 b=RSzBZ96fTUegsfQ0a18H4xz1/IcUidG27ulB8rJwwsHVC5QXxuQ/7drUSr5glpL/CPmHZOGk54E6Qgs/gb+PJ6UXEkSDdmEv1nRKAvc0Xnp8d024duYYDMYgE1qqefZ+RpxJ7OPD49kNhUrjzLK9Q0yG7rEyPzOYwmcDKFSTUGQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by DB9PR04MB9675.eurprd04.prod.outlook.com (2603:10a6:10:307::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.30; Sun, 29 Jan
 2023 08:13:34 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::5725:92ec:f43e:f5fc]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::5725:92ec:f43e:f5fc%8]) with mapi id 15.20.6043.023; Sun, 29 Jan 2023
 08:13:33 +0000
Message-ID: <2d06468ab1274af3c84e61dbca8d172b9d64cd68.camel@nxp.com>
Subject: Re: [PATCH] driver: bus: simple-pm-bus: Add Freescale i.MX8qm/qxp
 CSR compatible strings
From:   Liu Ying <victor.liu@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-imx@nxp.com, Rob Herring <robh@kernel.org>,
        Lee Jones <lee@kernel.org>, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org
Date:   Sun, 29 Jan 2023 16:13:07 +0800
In-Reply-To: <eea19462-8dfa-8e10-2638-70f6f1ecc193@linaro.org>
References: <20230125083248.1305270-1-victor.liu@nxp.com>
         <CAMuHMdU0KaRyP0qxJLwit1G=7zMr1k5wpCkG-wD31958mrKRWg@mail.gmail.com>
         <7c84cbd1808dc89f9ddaece13f846c4fbd12935a.camel@nxp.com>
         <eea19462-8dfa-8e10-2638-70f6f1ecc193@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP301CA0010.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::13) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|DB9PR04MB9675:EE_
X-MS-Office365-Filtering-Correlation-Id: 14043607-06ba-42b8-b55f-08db01d0b69b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2MIawcFHgfEYgEiZ6TZ1AmaMrYo1xzFLgjOMh+4x40GKBjgqDrTcH73jhzZatXvj05sJbc3xCm07dbSryREIlOYt8W/Cn7x+c5AyBLPmlZdmLPcxKGzH9nEO/hFH2JvuCiaBoABdvlqiL3a2rcotecfvSczWGcNzQtnb0FI8o5pSka+VyfHp0nVSN/eSUHPb2ViSxbccQdezHdfv0w5QIum91N0bBmAh/ErxcOw5G4K6ZrHqXNXWv1eJNeQDeasi39jyc4UL6zK4BQOwvl4i4JuirYtVQhSPwVG2GL2G1eLS4YkGGC8xPJU9BC+SYNVaRF5ojedQOtWj6eRbQwWxJctdBbRqntxpgxVA0rqp8BakffR3/GZxRCrb8o3Ktdu22dXXPCvdHFVjrXd7GqLaAYYg3sQWwqwgLUVndgku0nZT2jM8ZJepPXMaVBhPy/Acw9U7CfZpd6FC1SCJFlWJwKcpu5SZNIYfiKfJGaazTJAPRDMvOQjvP4Itzk3bddmBo+0//Q6VE59rStCqmTWCE+qGQtx29vEmcPDFFLaN2CxfmHLtFss9s5QLrHNynsxMXluBu3ovp0SGL5edp9Za+ho20XyKFE09Ts+BmSD9fuw/zElLZcxn34blKpSs23wDzN7K/9PuksQIFEg0PGUR9IXYkaIEC/KhTStepZ1PCSUCQD3BhqAUwmewHethputkeZEeDX+s7P6EAqe3ZnZ95ggTfwdq8qAdnyDm35sdlFmqJreq2a1V6ozt4pvJBbcXHnt3JSTMei/D1keE2rquXs6azeoW9kr+JtjcFvTGH3qYLUo7TERMTBOzfHAHy2ip
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(376002)(346002)(396003)(39850400004)(451199018)(8936002)(478600001)(2906002)(5660300002)(8676002)(4326008)(41300700001)(66946007)(66476007)(66556008)(316002)(110136005)(54906003)(45080400002)(966005)(6486002)(52116002)(6506007)(53546011)(6666004)(83380400001)(186003)(26005)(6512007)(2616005)(36756003)(86362001)(38100700002)(38350700002)(99106002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGVzTk4vWk9qTVNrN0FVSVF5WlJxZlBVZ3FrcFlwWEFvUW81YXVnWnBoeUVp?=
 =?utf-8?B?clI3Q1NhbW9rUG9TSVdMMkNGck1PdnRMMFJHOHZuSDE3Nkl3RGh0YkNsN1ZL?=
 =?utf-8?B?Rm9USUovRXdyNHU4bm5LZVdpWGxrOWtXYjhvQkx2UHV2VTN5cG05SDVkM3A4?=
 =?utf-8?B?N2huTmpDRUtqM2VpbXJDMTI5L1QxcVRYOWM2YzN2OXZWMUJ1cTJRSE1XakxM?=
 =?utf-8?B?OEJYRHd4bi9ZWlNkTzVTMnhBN3ZxTHlXU0R0aGs1MnpqRTBleDhKSEZIUm9X?=
 =?utf-8?B?Q0JHOVlyVExqb3hLdlZ5czhjeVQrT2JtdDVWcndsMFdueGNzMVlwb0JkMWNC?=
 =?utf-8?B?SVlTVU10R253NGZ1R2t2QlVVRXhuUWpOUTB0RnBhT0tyNEFQMUwrcld2cmRt?=
 =?utf-8?B?VjhCL1U0eEF1Y0E1aXZmZURlYThna3VRWWRRNmgreUdsVFNCL3BQeVhtbUFW?=
 =?utf-8?B?VWtkL24xVGJxb0ZmYzBManJZYXBuZlFDMFlqWk5tY05BOVMzekFqL3pOQVJw?=
 =?utf-8?B?UEFrN0pzeXExbmowQnVJYmJnbWJ4NkxVblFPVGg5cm5rK3RudFk3bFBnbmV6?=
 =?utf-8?B?QmFVcWVuRHArcWNrWXRVY3lsampwamdHSzNJTnE3MHZGRkp5VENPYlBkODRF?=
 =?utf-8?B?cldic2Ird2RnNE9hQzRqVnZzVGw5T1g3anh3bGlSb040aUt1OWZVREdqRGVo?=
 =?utf-8?B?OUlFZEd1N2RLeGptKzN4M1RNaTFML21JYzVTM2taSGgxNmJHL3VVSHUvb05p?=
 =?utf-8?B?endaZFppMmVTOVQzRXlscFkzMHNDMHpuK0pxNGpXTUlrRGlBZkRpRmRiNUpT?=
 =?utf-8?B?eHF2RmFrMlgreUwxbW5uWDVSb3E0YS9GT0xvOXQzS25qV2FuWVE4bVlSKzFM?=
 =?utf-8?B?amR1RWlXc1RwZHhNakJ2ZElkSmJIMEl3MDhxb2xjczZOZ24waDY4ZW1vVUk0?=
 =?utf-8?B?SFZIMS9oOHJ2SGNNYjRiVjM3N1dGalk5eGxNdUNmU1FyZ1F0bFVyL2VUbUdX?=
 =?utf-8?B?SXN1WFp6eGZYQ1hXYnlQL3VjNmg1bkZYWE1PdG9MdjhKQVVWeXowL096amFy?=
 =?utf-8?B?Tk9kRzZBMzdhenhPdWNRS3JmbHltMldDRlJpc1JZWVBiY3FjS3lidHJManlT?=
 =?utf-8?B?NUVuYW5mcnBhOWRrcDVXWk1rd0JEN29yeDQxMk1jdDlzMnMrQm03b001L2dw?=
 =?utf-8?B?YjhRSlJBaFZXeW80NS9CdG16OUlneStvVEd1ZUlNekYyWUkzbmNSSnpFSGVm?=
 =?utf-8?B?VGpZZ2lXNCtTYmhHN0hZa3NnMSt6clNjeVg2OEszcVB0ckFBSlJ3cG5XWWNy?=
 =?utf-8?B?L2RnQy9UV29RVDlBOTh1T2pTOXdNb0QwVUVvbk9FWUpPY25VT0h3MTdCUGs4?=
 =?utf-8?B?TEorOUNRV1loMjhXbnlYUldJckRWd1BoOFF2MmdXRkFZdGE1UEliMmluTFMr?=
 =?utf-8?B?VGU4eE5yR1lEdGp2SG5DNjBwZGNiRUwrMUpKUXVKajcrM3BNRGh5NXJBaXNU?=
 =?utf-8?B?YU0zRkpPaVNzS3IyRVpMZWRvQkxqWlFmejdaTDYyNUZXK01jQTZKTHJwSTYv?=
 =?utf-8?B?NngzekdVVThzNGV5dlJYSVlrK0tiQ2h4dXBBQUZ6cFZUVENYakJIRHhhL3k3?=
 =?utf-8?B?ZUdENW5VMllpWGYvUVZnZGY5U3UxdTlMY21PeTVTNzUvcmgweXFjT2loeVVJ?=
 =?utf-8?B?QlhlK09GYml0OHMwc2J6emZzOXRZOUs1NHN2Q3ZUZWt0YjdlTk0zd0taR1Ix?=
 =?utf-8?B?bnBrOVdzSVI1ejVpSDVrM1FPWXBmNzdZNnkxQTVVUmpzd1FXTFUxRmp3cVdy?=
 =?utf-8?B?RXhnVzhKZTFadysycmtvc3BZeDBjL0lrR2JQWkk3MUM4MmhwSGdoSTFUdUZS?=
 =?utf-8?B?UzJKUncwYkgxZlpTZXBXMk5WTnZnNE5iYS8vWnc1WEZ5NlhrT3ViSXFXaVI5?=
 =?utf-8?B?SjgrUndrV2QvTktvWXBwWURYYjVpRjh2b2xlTEVGbU1KWS9MNUdGeDZVSWV0?=
 =?utf-8?B?bzNwNE5QL2hqeXJncWErZk1qY2daZ0lKQ3VKc0N6b0swK2tjY1lqMllZeFlW?=
 =?utf-8?B?MVQrWk4va21uZHIrMWdvQkZxY1pLYjduVWJSWmhEWnh4eElXcUcrbERuWStE?=
 =?utf-8?Q?yCuNpvZEVJuxK3j7jXTBBQyDo?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14043607-06ba-42b8-b55f-08db01d0b69b
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2023 08:13:33.3727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kDeFRFlTPzfbdRoKRx4EXJ362p3kRDrgaUGXqj6CiHnxySAAtAFnz0ys6VQy0MwKoWExV/FcECC+rbCRXSN3tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9675
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-01-26 at 13:45 +0100, Krzysztof Kozlowski wrote:
> On 26/01/2023 03:54, Liu Ying wrote:
> > On Wed, 2023-01-25 at 10:05 +0100, Geert Uytterhoeven wrote:
> > > Hi Liu,
> > 
> > Hi Geert,
> > 
> > > 
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
https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatchwork.kernel.org%2Fproject%2Flinux-arm-kernel%2Fpatch%2F20221017075702.4182846-1-victor.liu%40nxp.com%2F&data=05%7C01%7Cvictor.liu%40nxp.com%7C87515adc8fc3401f410808daff9b3279%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638103339276325657%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=FFz5gSIPc6vyvb1IJ1Umu62WpzjNLIiQIi2sOA3RQGc%3D&reserved=0
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
> 
> I don't think we want to start putting specific compatibles here. We
> don't do it for simple-mfd, syscon and simple-bus, so neither should
> we
> do it here.
> 
> > 
> > This means that i.MX8qm/qxp CSR module dt-binding documentation
> > needs
> > to be changed.  I'd like to know how Rob and Krzysztof think about
> > that.
> 
> The fsl,imx8qxp-csr.yaml bindings are broken anyway... You have
> device
> specific bindings for non-simple device but use simple-mfd. You
> cannot.
> simple-mfd means it is simple and none of the resources are needed
> for
> children, but that binding contradicts it.
> 
> Now you kind of try to extend it even more make it more and more
> broken.
> 
> Rework the bindings keeping them backwards compatible. The
> combination
> with simple-mfd should be deprecated and you can add whatever is
> needed
> for a proper setup.

I did try to rework the bindings and make the combination with simple-
mfd deprecated. However, it reminds me the problem that "simple-pm-bus" 
and "syscon" can not be in compatible string at the same time,
otherwise, nodename should match '^syscon@[0-9a-f]+$' and '^bus@[0-9a-
f]+$' at the same time. I mentioned the problem in the same thread[1]
where Rob and Lee suggest to go with this patch. "syscon" is needed
since i.MX8qxp MIPI DSI/LVDS combo PHY node references the CSR module
through a phandle, so dropping/deprecating "syscon" is a no-go. 

Also, as Rob mentioned in [1] "if register space is all mixed together,
then it is the former and an MFD", I think the CSR module should fall
into the simple-mfd category. Take i.MX8qxp MIPI DSI/LVDS CSR module as
an example, child device pxl2dpi register offset is 0x40, while child
device ldb register offsets are 0x20 and 0xe0.

Geert, Krzysztof, can you please consider to keep this patch as-is,
since it seems that there is no other option?

[1] 
https://patchwork.kernel.org/project/linux-arm-kernel/patch/20221017075702.4182846-1-victor.liu@nxp.com/

Regards,
Liu Ying

> 
> > 
> > > 
> > > If that doesn't work due to DT binding constraints, the latter
> > > should
> > > be fixed.
> > 
> > Adding "simple-pm-bus" to the compatible value in DTS doesn't work,
> > because "simple-mfd" is matched first and "ONLY_BUS" is set for
> > "simple-mfd".  s/simple-mfd/simple-pm-bus/ for the compatbile value
> > in
> > DTS does work, but it means that fsl,imx8qxp-csr.yaml needs to be
> > changed and moved from mfd directory to bus directory...
> 
> Because the device is not simple-mfd and should have never been made
> that. I am surprised it passed Rob's review, I guess it slipped
> through
> the cracks.
> 
> Now you have to live with borken bindings. You have a lesson for
> future
> - put some effort to design them correctly from the beginning, so you
> won't have problems. Bindings should be complete from the beginning,
> not
> "I'll develop whatever is needed to match my driver and I will not
> care
> about future".
> 
> Best regards,
> Krzysztof
> 

