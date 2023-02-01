Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 537056860CD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 08:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbjBAHlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 02:41:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjBAHlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 02:41:07 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2043.outbound.protection.outlook.com [40.107.8.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5487451C42
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 23:41:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BKvUW1LW1DECUxyMl4s9IL+GV4k824HjgCDdVvbir1MVsK9h3fFQUjF/6Jnuz48rMban3OCMXT6V/GSnXFza2JqcNmhsEi4ZUGDEVUSS65k6rsSA8Hb28hFxcHot8Z0MPX2DLgsN6ivRZanPt3a1chNq1Txw+E8S9ly/r6ct5X4T7XpizVU46WcKrn+JXjBI7t41Cg7JgnwkaTLn1ZPYU0AGSiLaV9haKZxRUJRtPhGPJTaGqFZfKwzXhYbQWivBOsjv9ASUowwc17kutQLF5RtFoMf9jNYgEi52wHYhx9uh8dLuK72IbjjrhFTIhUlli/C1oaKxK7BH/jmVsAI5DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WKmonRDwA4hb/kwH4c3FFZ+V4hDfhFKtoPqTGL7QaM=;
 b=ndgV8vTcXa8bkpCog7iVkzP54YQVWdZ1n0jYK5jeSXJqsfbYDdWRAHWFrDFJOwmnB6o8f9mN8A+DiN+u5jMh5+rhEY8S0wmxkL1Hgh4TS0iXfxe7xgY2U/V0pODqJhW4Rdv6tRPJpSdVviCoKfOHZkQfiBUSFxWJPstZrKVX9D4MhcjREGtHfgsub9EpRxWVS54LaTIKKwyNa/lzlNB2tMNBgnQvkOQWHCZq3+/CEkn2LSMU4SajrYDMP3SCX5c8Fl9uu7764XiMzE1o9OeA9+JCLjHil+n9QN/j6BAnIUc5O71td1zIKPbi4uYytPqrg5yiqFYuMW4+W0bZb6YL5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/WKmonRDwA4hb/kwH4c3FFZ+V4hDfhFKtoPqTGL7QaM=;
 b=EtT9brmbRgcgW0bleMM97I5g9kANzciUi3MFUvE+KQT/caaTxnQF6/PUF0XY+nz/yQSQgZ7/nLYjWbh0H8QSByeAJZJxUU8114oteyyom4s+Ak+zkTPdKZblojzUX2pzN9XVy43Gj2rSZaaALzbQpwqkH1y/kBmmsjWRGgwEdi0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by AS8PR04MB8118.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22; Wed, 1 Feb
 2023 07:40:59 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::5725:92ec:f43e:f5fc]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::5725:92ec:f43e:f5fc%9]) with mapi id 15.20.6043.038; Wed, 1 Feb 2023
 07:40:59 +0000
Message-ID: <09a7b5c0f674258db2bf32795e182d2523f31d25.camel@nxp.com>
Subject: Re: [PATCH] driver: bus: simple-pm-bus: Add Freescale i.MX8qm/qxp
 CSR compatible strings
From:   Liu Ying <victor.liu@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-imx@nxp.com, Rob Herring <robh@kernel.org>,
        Lee Jones <lee@kernel.org>, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org
Date:   Wed, 01 Feb 2023 15:40:19 +0800
In-Reply-To: <d27188cd-f2ef-23ad-f27a-3fd1ef37018f@linaro.org>
References: <20230125083248.1305270-1-victor.liu@nxp.com>
         <CAMuHMdU0KaRyP0qxJLwit1G=7zMr1k5wpCkG-wD31958mrKRWg@mail.gmail.com>
         <7c84cbd1808dc89f9ddaece13f846c4fbd12935a.camel@nxp.com>
         <eea19462-8dfa-8e10-2638-70f6f1ecc193@linaro.org>
         <2d06468ab1274af3c84e61dbca8d172b9d64cd68.camel@nxp.com>
         <f551d663-f7b6-5ae3-89a9-af1ae0d6216e@linaro.org>
         <22399c301156a2a15c53a647ea2ec4c871860080.camel@nxp.com>
         <d27188cd-f2ef-23ad-f27a-3fd1ef37018f@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0097.apcprd02.prod.outlook.com
 (2603:1096:4:92::13) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|AS8PR04MB8118:EE_
X-MS-Office365-Filtering-Correlation-Id: a7fc396e-0b1b-46a7-7829-08db0427a92c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KLCalo5uCxtZubwZHibJ16wr/BpVdpj/Jsgjnn25WwhVAWMoxbb/nrg6g0JoZOtpchORYQRCvEBxegot40LwMRIid6Cc/+2+rxO6tSaZG5lX03QM8z240IGV9VY54bZAur94l7q31u8RvkTLW69yKFYBg7WU4/SXx/5drAp4v74wTiq1fpJ5lTeTgHwA/uugLyCK42Mi5Y/3CNXFzgOgPRXYNEvJWgwUKhjVQ7xbHsGaPDUEkZqyz53bRMKfv6iC2t/92B2/OUxjOU4LokupthKd7aOMzxV7F1D5nubIxtz3oCTCnXC8kDTbcwowHZLGb20+ZKBYgpb+/+fySYHk08e1Gs0/4v6/Xh5qEETL1IflLnSCjU7QR6kb/EcukvDCd54NEVrANY2wZ9oeEqmSJZ+DqXMdhS1CJrQjp8MIsJdqpl4JtiOjw2nVhx32JxvoENSPqyJr0N6yUnlDOZ4xYIHCJl4WRnr05DECt9gUtays077smZ8v3ebvvkaYKS1QGSk4+bTaBnkdV/SO3XtGY8lIF1IVo7OopFFtZsgx6x455wtB4tXfQ1fQmcte+Q1Y5sbPSe7RqF4VxJDIWqyCI5USmc7V9ozZ+vp8hVtCKXfvGHf8MfPlrnzqVHjqjQ7C2haks016H4wMj3QB0Ff/G6QO/954WpN6ol+RGPlj61pwarFhRGdGytIFlKmqsecajMTTChTW1wSU58n9VgNTpjaajlDoUJJFR0pNx0LkRPA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(451199018)(45080400002)(54906003)(316002)(8676002)(4326008)(66946007)(110136005)(8936002)(41300700001)(66476007)(66556008)(38350700002)(38100700002)(86362001)(36756003)(6506007)(53546011)(6512007)(186003)(52116002)(26005)(5660300002)(6486002)(2906002)(966005)(6666004)(478600001)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUhuTFhJUEJrUUFhTEhTN284NmdpclNnOCs4N0o2eGU1TUpNSVV3VUxPRDVz?=
 =?utf-8?B?bXZxWm1JQXBJUjk4Q2s3QXhuNmxCcXR0VXU4VHQxVmZld0Z4UVN4OUZ0WVFM?=
 =?utf-8?B?SUtPU1RLNm5tRFBUSlRRdVYrTS9PcjU5RzU0eHp4bEFpWHdEMUZoa0RkTTh0?=
 =?utf-8?B?S005TlE4UWRSaEE3STVwaFJLVTFzN2h2MjZxb3h1UGRsalVJYktJekNYQzB4?=
 =?utf-8?B?clR3RjFsMllSL1g3dXkzcE9tbFFobjgzbHRoeVN5cHNzNmd4bmx1VTU2bzNL?=
 =?utf-8?B?UUs4eEU4UnAyZHpLMFF0L1Q1MERQWllibGhKSzhybW1HNkFiTDhocjE1THlr?=
 =?utf-8?B?ZDJnYXkwaVpuRlBqTW9ycUh3cE5JL3pwd3k1KzhSdjVsUUd1bCtGS01sQ2Vu?=
 =?utf-8?B?Z1JLNUJGMjExRE5pcjZuS0F6NlVHN1FSODEzVk9ueHV5VW5mRUZHdzRPemFj?=
 =?utf-8?B?Vm1uT201ei9ISVBGZzBRMHlpRHJjSG5oaDR6Mkc0dVJHKzFUdlBiZm1PcUgz?=
 =?utf-8?B?OHVPSGl0ek5uMDdPOEFZQUtXK21sTE45TUQ2ckZ5L3BQcEpHNU12VjQ5Y1hh?=
 =?utf-8?B?cnoycDlyWDdldjREQktlWFB2bHRGa3ZBWU9XSUY5cjgrSWJLUmtvWE5YU05J?=
 =?utf-8?B?ZFA0OXM3Q2hXNXpjM1RDQ1hGRjF3TkVoZW1KcXV6cjc5Y3pGOThXZjFJUVB0?=
 =?utf-8?B?NjZDTVNUcW5JeW5Ib0hGem1jSFFiZFhPditxQ3ZHTkRVVzZkbWFuQjRqQU5Q?=
 =?utf-8?B?Wks1bmRROGphYlVtM2E5MW8zQkExaE1YNEVnV1dyQUZhSk5mU0pJZk52MFNq?=
 =?utf-8?B?dHFSemwvVDhWUk1obUQ4a0QxajB4TWxWeHpjbmd5NWFZSjFGRzJtMjlDUnM0?=
 =?utf-8?B?NjI4WGp1TnE2ZThIalBONlRSV2pqalZQWWY4eWlPbFIvOTFpVUFURmRWVmtT?=
 =?utf-8?B?dS91Smp1TmZtWWF0SS8vcUlSbmg4NWNVVjBFTW9FVlRCLzl0bjVVd1BBVE5h?=
 =?utf-8?B?MkhXcjM2dS9zWTk0bW5wWnkxdmxPNXI0Ny80YkpucVdKamdlYjV1T042anc5?=
 =?utf-8?B?ZjJ1N3NSWE1TVjJ6QVoreVVHdFloWWtkOUNweHZZcmVTNUxZWkNpd3IzbjZF?=
 =?utf-8?B?RkRRY1dmdTVnTjdaem5paDI2cG9pOGdIVW4wbWUxMkFoVEdGZUh0MFM0WmhR?=
 =?utf-8?B?azZMcFRlT3NmUmRVeFlpbG5JeDFldHo1ZTg5Z1hJZzdhbGRNM1pzUys5RVJn?=
 =?utf-8?B?WmZYS3dzWTkvaTlialdreENneHJtQlVWRno5WkxFTHhtL3orcVVJUldKd29x?=
 =?utf-8?B?NjhOc1I0aUZFeFRxL0hscko1MjFPd3pocXlndUhlamFuT0dVeDJXYTQ5TkE3?=
 =?utf-8?B?UVpjeEtYWVV1WVMzVitHWEdLTnpQdG1kblBwTG5zZFR3dGloZkZBSHRielZi?=
 =?utf-8?B?TWFWRnA1QlNObWtVcXBqVHpDN2NzMVhZSzF0b05GTmFTNURyR0RBZVZoZkFY?=
 =?utf-8?B?eFNGMGZoV1p0dW9wOXE3bjJaaUEzbUFXQzlvTzI5KzFMd2dTdllBZU9pVGJJ?=
 =?utf-8?B?WjZqdFdQWUtvbGVteW5DWUhyMGxlb2UwcEJjL09HUVE3TEIyYW9EVmxpcy9T?=
 =?utf-8?B?UStabXNjeklGNjlKK0t5bWQ4dWgrQ1A1aGswWU1ZMGRGaG11Nk9LSTBxVmpR?=
 =?utf-8?B?UW5nYjhCRWRmNU5tcGltL082WWdmU3JpYTZnYU15SVgyenpXQmpxTm1jWVM5?=
 =?utf-8?B?RDlXM3BaM0M3SkpHbEhsQWhUUWNodUdBam9xVktzbGdKakJCTnlkMkt6OXEy?=
 =?utf-8?B?alBHbDh5UndpcnhHUGJvanhXTGsrZTZpRnBvbWZoeldxTlgxRC9hYmtPRGRj?=
 =?utf-8?B?dERvYmREeEhrbmd3YkVkMXVhTnkyVjRLRUwxT3JtQVJwamtaZk4wdmkvSWZB?=
 =?utf-8?B?N2ZKTjlwc09lb1VFVkc0bE12M0ZjY3dubU5EMURBanU0b1Y4aTEvTUY4UTRv?=
 =?utf-8?B?ODFpcEh5Yk5hcTQ5REZleCtrRldITWQyOHc3S0I5RFhMazFlS3lCaTE3a09z?=
 =?utf-8?B?SkVuUzBsRWJHbDYzZE1ndGFabkpJYjJ3UjI4bmJYWVBNbWpBczVmWjljU3hB?=
 =?utf-8?Q?NgXJRIEmmZZJAFNU4iLkmqAgS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7fc396e-0b1b-46a7-7829-08db0427a92c
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 07:40:59.3743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3P4SbbJ+vKsudyHrw7Xe0aR+/ZmCLwcGGCNnnPW6Wgpykav5QJqQCG/Kd/LzfHiPPSHNQDF1GLiq6ZiNKg9khg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8118
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-02-01 at 08:31 +0100, Krzysztof Kozlowski wrote:
> On 30/01/2023 02:45, Liu Ying wrote:
> > On Sun, 2023-01-29 at 11:49 +0100, Krzysztof Kozlowski wrote:
> > > On 29/01/2023 09:13, Liu Ying wrote:
> > > > On Thu, 2023-01-26 at 13:45 +0100, Krzysztof Kozlowski wrote:
> > > > > On 26/01/2023 03:54, Liu Ying wrote:
> > > > > > On Wed, 2023-01-25 at 10:05 +0100, Geert Uytterhoeven wrote:
> > > > > > > Hi Liu,
> > > > > > 
> > > > > > Hi Geert,
> > > > > > 
> > > > > > > On Wed, Jan 25, 2023 at 9:31 AM Liu Ying <victor.liu@nxp.com>
> > > > > > > wrote:
> > > > > > > > Freescale i.MX8qm/qxp CSR module matches with what the
> > > > > > > > simple
> > > > > > > > power
> > > > > > > > managed bus driver does, considering it needs an IPG clock
> > > > > > > > to
> > > > > > > > be
> > > > > > > > enabled before accessing it's child devices, the child
> > > > > > > > devices
> > > > > > > > need
> > > > > > > > to be populated by the CSR module and the child devices'
> > > > > > > > power
> > > > > > > > management operations need to be propagated to their parent
> > > > > > > > devices.
> > > > > > > > Add the CSR module's compatible strings to
> > > > > > > > simple_pm_bus_of_match[]
> > > > > > > > table to support the CSR module.
> > > > > > > > 
> > > > > > > > Suggested-by: Rob Herring <robh@kernel.org>
> > > > > > > > Suggested-by: Lee Jones <lee@kernel.org>
> > > > > > > > Signed-off-by: Liu Ying <victor.liu@nxp.com>
> > > > > > > 
> > > > > > > Thanks for your patch!
> > > > > > 
> > > > > > Thanks for your review!
> > > > > > 
> > > > > > > > ---
> > > > > > > > The CSR module's dt-binding documentation can be found at
> > > > > > > > Documentation/devicetree/bindings/mfd/fsl,imx8qxp-csr.yaml.
> > > > > > > > 
> > > > > > > > Suggested by Rob and Lee in this thread:
> > > > > > > > 
> > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatchwork.kernel.org%2Fproject%2Flinux-arm-kernel%2Fpatch%2F20221017075702.4182846-1-victor.liu%40nxp.com%2F&data=05%7C01%7Cvictor.liu%40nxp.com%7C32a4c39e47ec4fc834ae08db04264e35%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638108334805268216%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=M2SddU7wPx465kB%2F5p2r6j3%2FAotcVvMiPORPzh%2BC%2FxY%3D&reserved=0
> > > > > > > >  drivers/bus/simple-pm-bus.c | 2 ++
> > > > > > > >  1 file changed, 2 insertions(+)
> > > > > > > > 
> > > > > > > > diff --git a/drivers/bus/simple-pm-bus.c
> > > > > > > > b/drivers/bus/simple-
> > > > > > > > pm-
> > > > > > > > bus.c
> > > > > > > > index 7afe1947e1c0..4a7575afe6c6 100644
> > > > > > > > --- a/drivers/bus/simple-pm-bus.c
> > > > > > > > +++ b/drivers/bus/simple-pm-bus.c
> > > > > > > > @@ -120,6 +120,8 @@ static const struct of_device_id
> > > > > > > > simple_pm_bus_of_match[] = {
> > > > > > > >         { .compatible = "simple-mfd",   .data = ONLY_BUS },
> > > > > > > >         { .compatible = "isa",          .data = ONLY_BUS },
> > > > > > > >         { .compatible = "arm,amba-bus", .data = ONLY_BUS },
> > > > > > > > +       { .compatible = "fsl,imx8qm-lvds-csr", },
> > > > > > > > +       { .compatible = "fsl,imx8qxp-mipi-lvds-csr", },
> > > > > > > 
> > > > > > > I did read the thread linked above, and I still think you
> > > > > > > should
> > > > > > > just
> > > > > > > add "simple-pm-bus" to the compatible value in DTS, so no
> > > > > > > driver
> > > > > > > change
> > > > > > > is needed, cfr.
> > > > > > > Documentation/devicetree/bindings/bus/renesas,bsc.yaml.
> > > > > 
> > > > > I don't think we want to start putting specific compatibles here.
> > > > > We
> > > > > don't do it for simple-mfd, syscon and simple-bus, so neither
> > > > > should
> > > > > we
> > > > > do it here.
> > > > > 
> > > > > > This means that i.MX8qm/qxp CSR module dt-binding documentation
> > > > > > needs
> > > > > > to be changed.  I'd like to know how Rob and Krzysztof think
> > > > > > about
> > > > > > that.
> > > > > 
> > > > > The fsl,imx8qxp-csr.yaml bindings are broken anyway... You have
> > > > > device
> > > > > specific bindings for non-simple device but use simple-mfd. You
> > > > > cannot.
> > > > > simple-mfd means it is simple and none of the resources are
> > > > > needed
> > > > > for
> > > > > children, but that binding contradicts it.
> > > > > 
> > > > > Now you kind of try to extend it even more make it more and more
> > > > > broken.
> > > > > 
> > > > > Rework the bindings keeping them backwards compatible. The
> > > > > combination
> > > > > with simple-mfd should be deprecated and you can add whatever is
> > > > > needed
> > > > > for a proper setup.
> > > > 
> > > > I did try to rework the bindings and make the combination with
> > > > simple-
> > > > mfd deprecated. However, it reminds me the problem that "simple-pm-
> > > > bus" 
> > > > and "syscon" can not be in compatible string at the same time,
> > > > otherwise, nodename should match '^syscon@[0-9a-f]+$' and '^bus@[0-
> > > > 9a-
> > > > f]+$' at the same time. I mentioned the problem in the same
> > > > thread[1]
> > > > where Rob and Lee suggest to go with this patch. "syscon" is needed
> > > > since i.MX8qxp MIPI DSI/LVDS combo PHY node references the CSR
> > > > module
> > > > through a phandle, so dropping/deprecating "syscon" is a no-go. 
> > > > 
> > > > Also, as Rob mentioned in [1] "if register space is all mixed
> > > > together,
> > > > then it is the former and an MFD", I think the CSR module should
> > > > fall
> > > > into the simple-mfd category. 
> > > 
> > > You are now mixing MFD with simple-mfd. If you have clocks there or
> > > any
> > > other resources, it's not simple-mfd anymore.
> > 
> > I may try to make the combination with simple-mfd deprecated and add
> > another combination with i.MX8qm/qxp CSR compatible strings and syscon
> > only. Then, it will be a MFD, not simple-mfd.
> > 
> > > > Take i.MX8qxp MIPI DSI/LVDS CSR module as
> > > > an example, child device pxl2dpi register offset is 0x40, while
> > > > child
> > > > device ldb register offsets are 0x20 and 0xe0.
> > > > 
> > > > Geert, Krzysztof, can you please consider to keep this patch as-is,
> > > > since it seems that there is no other option?
> > > 
> > > There are other options, why do you say there is no? Making it proper
> > > binding/driver for its children without abusing simple bindings.
> > 
> > I don't quite understand your comment here, sorry. Here are the 3
> > options I know:
> > 
> > 1) Add a new MFD driver for the CSR module
> > I sent out a MFD driver[1] for the CSR module for review, but Rob and
> > Lee provided comments there and suggested to use this patch.
> 
> Where are the clocks in that driver? Having MFD for something without

The clocks are missed in that driver. But simple-pm-bus.c in linux-next 
uses the clocks.

Regards,
Liu Ying 

> resources does not make any sense - this is why we have simple-mfd.
> 
> But I see in your [1] Rob's suggestion about adding the compatible to
> simple-pm-bus.c, therefore it looks correct approach.
> 
> Best regards,
> Krzysztof
> 

