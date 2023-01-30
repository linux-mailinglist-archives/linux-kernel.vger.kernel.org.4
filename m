Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD255680390
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 02:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235315AbjA3BqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 20:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234004AbjA3BqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 20:46:13 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2062.outbound.protection.outlook.com [40.107.20.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072C21ABC0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 17:46:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gpj7g0cYIq3lGrhXgy6z6zgnzUMTnYSfkJeasaf4wB0DvbKy4PFqXhakBJuMcGZyksDN0/2NsT4PvhCJLWSf54fFNK5arKy6D/nDYJ4K80U16LkBLY7veBqnBrDickQX6fOPIYVI/bjG7uaGGyh+6ubjAkSmiF22rP5ZIjFX+dQDSPhGNSVNVEtC4dHTRCmlziMkBq7F3Eq/0ZlozjPEyW7TJBnzRFG6ZfL2NtH1HTYZWySeGlbvcs+ZuxtGh9V1/hykwg6Jnswtgvfezf9IKAqqF50sSkeStzOM2Nyx+4oX9jBMXuY0G/4MH2OBFYmJSzc9lSP9Q41mS9FgRv3YLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M3CmInIpcAkGwxe7gRFA10PK4MX1TWnzTc+OmHIQOSE=;
 b=YesTWIiPmwXZSz83TbtHdVNpbnHAe8WSnLt07PVRSBVOHmTaT54fvXR45krdVRKb2N/GS6bbyC4QZ8UB+JfXmwRp0fYsw4HpocL1pCRnTQv7gQz68Oq7Zk+eVacXm5UgUjd4d6wgm6NMNJNdokLpmwnOnTp9ejnleHzxh+G/a8oVoABsoUTWByTES6FCr8eofcq8gc5T2df1lSpCXqq8ZBKvBcgtLqI7hWe4JVHyIWuQTfsivs/48DWSMWSPi95NU2t+zKxbhUs/cWpgP25S3LvltjJoiYXjY1864frf1/ZvpzDWb6Jzp1fuDKeXq0MTqK2Frv0S55zAlDGcV9RY1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3CmInIpcAkGwxe7gRFA10PK4MX1TWnzTc+OmHIQOSE=;
 b=Uf+Z+DUDLLAZNNGStWcuysu5/ZnunlFobPNAWTdY2ZHGm5lbP7y8Fp0EknBSUypNFo93307G7N+/3lIcBi7/ApFNQkyjel7zS5q4sr9gEyZieDso7atEzOMtxAH+MK0BwTwoyDTSGeCtzRNLGj72H8jqBYqA1OTZ8gUgexIvBKM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by VI1PR04MB7181.eurprd04.prod.outlook.com (2603:10a6:800:12a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 01:46:08 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::5725:92ec:f43e:f5fc]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::5725:92ec:f43e:f5fc%8]) with mapi id 15.20.6043.023; Mon, 30 Jan 2023
 01:46:08 +0000
Message-ID: <22399c301156a2a15c53a647ea2ec4c871860080.camel@nxp.com>
Subject: Re: [PATCH] driver: bus: simple-pm-bus: Add Freescale i.MX8qm/qxp
 CSR compatible strings
From:   Liu Ying <victor.liu@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-imx@nxp.com, Rob Herring <robh@kernel.org>,
        Lee Jones <lee@kernel.org>, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org
Date:   Mon, 30 Jan 2023 09:45:35 +0800
In-Reply-To: <f551d663-f7b6-5ae3-89a9-af1ae0d6216e@linaro.org>
References: <20230125083248.1305270-1-victor.liu@nxp.com>
         <CAMuHMdU0KaRyP0qxJLwit1G=7zMr1k5wpCkG-wD31958mrKRWg@mail.gmail.com>
         <7c84cbd1808dc89f9ddaece13f846c4fbd12935a.camel@nxp.com>
         <eea19462-8dfa-8e10-2638-70f6f1ecc193@linaro.org>
         <2d06468ab1274af3c84e61dbca8d172b9d64cd68.camel@nxp.com>
         <f551d663-f7b6-5ae3-89a9-af1ae0d6216e@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCPR01CA0053.jpnprd01.prod.outlook.com
 (2603:1096:405:2::17) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|VI1PR04MB7181:EE_
X-MS-Office365-Filtering-Correlation-Id: 526ec08e-f536-4026-7fd6-08db0263c1d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MrWUZ/96YHVTj74NDtVkJbkUg6SP6OFUciWZ6o0eNrLvNr5lvI10HBF2vWv26ksxvhBESKtPpMzeQ2Lb/9FcOfkmTMJLQOCwExcO7i8NWwz3yMUzUMN5uXhapEIYvb454n1BipEDj5JfIVdXi6VtbDRFGUUu2giHOWJ7BTvt1xG/TDjb/Ey2tV7sNIrAUPwmR1ePPAlMxJYJ/ydhCt6zLJq42bvmz6L85o/nqONl0yoK5l/4krWI3JZQll0/cfsaWDM92L21s8zx36XycoMf++Mcbqs82TqPiDeAX1bsmO5lYbx9bQO4xH4Frao8MKD0S7irb+OtYef7NKCKm2gU3n+Jps8V8RDpn4BR7WIYUSPtU5zA6QZ45DMJu+hti0k8BLk3VZ/UzPDWCgU44AY1Y+VxyZDDxf8UNwMhP/2x+FD6dU0iDaeY/tfGbXIYtDkZ4mCGpgE+bsLdawLwWnTsHUgqC7DnzPZhxWkBddPFKyizbBFPdrvsF8iSMHM+/70WxYtq9rVnXbnlqwYIzKCNFdV64EP3KrIWs1uxwvI7S2KjDDyhqzfLbNOIwywchQ9KWceX2RxCgP6BXzSXQD24zYBWfrGDOzBI5XR8rSjztLQ4RWzL/OOsULrt1wHlQ0JXlLthzP1oJtx/bZWNDOrxE4blE8gTBhi1PpxQzDWQQT0wwYocEgZ7BxJjqAJYfbNQPViH7ly9NpCg3ipVVi7GMMHQdLROGeBBNpLqVbdsPWUBYuVFWVJkmEStwlHNwyM0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(376002)(136003)(39850400004)(366004)(451199018)(52116002)(6666004)(41300700001)(6486002)(966005)(2616005)(6506007)(53546011)(478600001)(6512007)(26005)(186003)(54906003)(110136005)(316002)(45080400002)(66556008)(38100700002)(38350700002)(8676002)(66476007)(4326008)(83380400001)(66946007)(36756003)(5660300002)(2906002)(86362001)(8936002)(99106002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnZBWnhuaS9kUG5tRzMyVlVwMnhGZmhmc2ttbGxUWUdLdytLU2t6Q1plU2hQ?=
 =?utf-8?B?M01DZTEzZGQ3Mm5yL2lpd0t1R0twb3piVUhuL2kxNGMvbmJMOXpYZUV3ZVNZ?=
 =?utf-8?B?ZFJoNVBYVzI3aXo2OXB3TmdqMHR0Q0h0azZlNmFQTFhWQTFRWDZRV3BicjVJ?=
 =?utf-8?B?TGZiSWNNMUpObTk3UEcwWllzb2FQcTh5VEtYZEI5eFZIbVhrNGxJZXlzWFZr?=
 =?utf-8?B?T2svcC9KaEFnd2RHMndaV05TL0N4ZW9OOTdHRmphenFrMitmWUoxMkwzVytB?=
 =?utf-8?B?eDdCNGRpOEIxNFpwcC9IR25sKy9iZmg0WXY4Q0hDQklMMHIzZEVxbnAwbGs2?=
 =?utf-8?B?UlBIQlk0RENHVUlrckoxanhCRExWeDN1SjRoSTF0Mmc2WDZZYWtiZFYzS2pu?=
 =?utf-8?B?WTYraXJNblJRMFkyM3ZoUE0wUzBYUWw2b2VZc2M2SS9CbGkrRWlnYmxlOTlO?=
 =?utf-8?B?TnZkeVQ5cEJrVkJKYWM0a2x2UGNuRVFXQTlQaXpibXo1M3k2RkdxeG9IbWRF?=
 =?utf-8?B?VlRlRktITFgvYi9HRXB2MGFyVStYVEVWOGdtaFNQMjFsYlhPWCs4WkZrYkxG?=
 =?utf-8?B?ajcwT0x4N0pkNHJSQjhDQ0Y2QmJkUi9sWXZVa0JHVHRHOWdZQnE5aUVSbWRK?=
 =?utf-8?B?N2REMlB0N0k3VTgyYjh3TENqRW5ERHVEMzB3MVB5M1M5SmlEdFdJQlFseTdu?=
 =?utf-8?B?SE81VXBHZWczZ2VhZFh0Z0I5Qm4rMTdlQU5GUXZ6NXRjdVBtSmlMcG9RYUJP?=
 =?utf-8?B?QllTOVp4d3NiWTBxYUFoeVEvZy9halVWVlArU3pMU21iTEtDNFJCS3dEaFdS?=
 =?utf-8?B?UGhMTVlxVXVsRjNBbkNWQXk0bVovZUVaYWlHMFp1eVBzNzkvMG15djdZcURU?=
 =?utf-8?B?RWFuR2F2VWoveGVjNFJqTFBpOWF5ZkF5cTZYcy9MbGtDcW5lR0dWYnFUZFBI?=
 =?utf-8?B?OHRSdmlzaGV4bnhpT2tjeG1wMVAzRGhtSXQvdEJXenhwdWxDMUwwOHJRZlZZ?=
 =?utf-8?B?eHN0RnBiVWg5ZkkvQVVla2pHWktmaTN6c1AvbkZUYVBjZU9OeHFGQURRWFpN?=
 =?utf-8?B?SW4zSkpNZVRQQlZNbUVjTUFzRnZOY3pQMU9SdFdzVW14M2pUeVNDUExqUGgv?=
 =?utf-8?B?cGdIKzBHZitta1c0R1I2NmQxUWdBazB6VDM2cnlxREhycjRWM29LWm5GamQv?=
 =?utf-8?B?di9qOUxNWXlZU1Y2M2lyUFV6ci9aTFZSMFU4RE9OOTNzUXRjTzNaa1VzMlRq?=
 =?utf-8?B?MGlodDd2RTk3TUt1RTVlbm5JbFVKRUwxcW5DT0hSMHdpNjJBRG04cEp5L01x?=
 =?utf-8?B?TVpESUxwdW56ekNGUWJmMmRFSzZjN295MlQvc3cwUjR2QjFzS3g4YTZvK3JF?=
 =?utf-8?B?VjJ5R09sRlZlV3hpOXpTNExCaEZYK2lVbFZ4djBKSENKMEkweWhNK2x1QjBF?=
 =?utf-8?B?c3d0aHNQRWJRb3ovMnNiYkljL2V1Qk1zMGNSeHRxaCt5dTl0TDZkaXVxb3Iw?=
 =?utf-8?B?OTJiNHdHUEVCZEI5cStkTlB4NXF2SXIxUkg5ZlozS1VmWnAwaTVLUDA4bDIv?=
 =?utf-8?B?d29YVXFZemsxeStzanlHc29IQ3hqNk9DUlZkeEVFL0NYOG8xci8wN3I5K0hz?=
 =?utf-8?B?OUZIbHFlU1pOMFJtZmJQbVg4MzRIa0JoMnUvYS9mQ3hqWUVOUC9NcjRTdUty?=
 =?utf-8?B?b1E4TXl0dDdCdmkyenlmeHRXejhycWxaN0tNejVDMFdIcUFXakIzcDU4MktH?=
 =?utf-8?B?ZDR0bFRINDNwOURlQzFLcStWOURBVkFiUHZXSUQ4dko5Y05BSjVrUmJyYVZG?=
 =?utf-8?B?ZE9NQzVTL0JXUkh3TU9xWmR2NmQ4ejlRZFlVQ1ZiOHp5dk4zay9XVy9PbUJz?=
 =?utf-8?B?YlJWWHhZcnR6eGJGb2RXVE8vdTd0YTZwQ3JYNFZjeG4yL0dZaWJsMEpRM0RD?=
 =?utf-8?B?R1EzNmt6K1pUOUtITmJuOXZpM05mNTJiOXdGMjdLZnNxVTI3Q0kyN0ZJZ3d1?=
 =?utf-8?B?ZW1aTVZBeTdVRFZzaWJ5ekFYd2tFNDU0ZmkzWmFEczJVeUllYnprWnhFQm16?=
 =?utf-8?B?ekFQV2xpTGxFNXVIeWk3clN5SGZvcE9LR2NSNDdlcmkydzI2Vkx4NjdCbmxO?=
 =?utf-8?Q?uqd2G0Q7ZVi0bvFQSMYBvv0PK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 526ec08e-f536-4026-7fd6-08db0263c1d9
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 01:46:08.3456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aLqn5FOm939b1oItvPhNNqIZkRkWp3fZSLR4USIL0CPw8NNuYq2fYGGKe1xidsHKCqGn30BEDgqBzkAe8AJj5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7181
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2023-01-29 at 11:49 +0100, Krzysztof Kozlowski wrote:
> On 29/01/2023 09:13, Liu Ying wrote:
> > On Thu, 2023-01-26 at 13:45 +0100, Krzysztof Kozlowski wrote:
> > > On 26/01/2023 03:54, Liu Ying wrote:
> > > > On Wed, 2023-01-25 at 10:05 +0100, Geert Uytterhoeven wrote:
> > > > > Hi Liu,
> > > > 
> > > > Hi Geert,
> > > > 
> > > > > 
> > > > > On Wed, Jan 25, 2023 at 9:31 AM Liu Ying <victor.liu@nxp.com>
> > > > > wrote:
> > > > > > Freescale i.MX8qm/qxp CSR module matches with what the
> > > > > > simple
> > > > > > power
> > > > > > managed bus driver does, considering it needs an IPG clock
> > > > > > to
> > > > > > be
> > > > > > enabled before accessing it's child devices, the child
> > > > > > devices
> > > > > > need
> > > > > > to be populated by the CSR module and the child devices'
> > > > > > power
> > > > > > management operations need to be propagated to their parent
> > > > > > devices.
> > > > > > Add the CSR module's compatible strings to
> > > > > > simple_pm_bus_of_match[]
> > > > > > table to support the CSR module.
> > > > > > 
> > > > > > Suggested-by: Rob Herring <robh@kernel.org>
> > > > > > Suggested-by: Lee Jones <lee@kernel.org>
> > > > > > Signed-off-by: Liu Ying <victor.liu@nxp.com>
> > > > > 
> > > > > Thanks for your patch!
> > > > 
> > > > Thanks for your review!
> > > > 
> > > > > 
> > > > > > ---
> > > > > > The CSR module's dt-binding documentation can be found at
> > > > > > Documentation/devicetree/bindings/mfd/fsl,imx8qxp-csr.yaml.
> > > > > > 
> > > > > > Suggested by Rob and Lee in this thread:
> > > > > > 
> > > > 
> > > > 
> > 
> > 
https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatchwork.kernel.org%2Fproject%2Flinux-arm-kernel%2Fpatch%2F20221017075702.4182846-1-victor.liu%40nxp.com%2F&data=05%7C01%7Cvictor.liu%40nxp.com%7C58af8a86f0134b6bde3408db01e68522%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638105861813147063%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=mHv%2BTAHMAR8coxDmXucoMbxv%2BuMEdHWHTyLz16OUY50%3D&reserved=0
> > > > > > 
> > > > > >  drivers/bus/simple-pm-bus.c | 2 ++
> > > > > >  1 file changed, 2 insertions(+)
> > > > > > 
> > > > > > diff --git a/drivers/bus/simple-pm-bus.c
> > > > > > b/drivers/bus/simple-
> > > > > > pm-
> > > > > > bus.c
> > > > > > index 7afe1947e1c0..4a7575afe6c6 100644
> > > > > > --- a/drivers/bus/simple-pm-bus.c
> > > > > > +++ b/drivers/bus/simple-pm-bus.c
> > > > > > @@ -120,6 +120,8 @@ static const struct of_device_id
> > > > > > simple_pm_bus_of_match[] = {
> > > > > >         { .compatible = "simple-mfd",   .data = ONLY_BUS },
> > > > > >         { .compatible = "isa",          .data = ONLY_BUS },
> > > > > >         { .compatible = "arm,amba-bus", .data = ONLY_BUS },
> > > > > > +       { .compatible = "fsl,imx8qm-lvds-csr", },
> > > > > > +       { .compatible = "fsl,imx8qxp-mipi-lvds-csr", },
> > > > > 
> > > > > I did read the thread linked above, and I still think you
> > > > > should
> > > > > just
> > > > > add "simple-pm-bus" to the compatible value in DTS, so no
> > > > > driver
> > > > > change
> > > > > is needed, cfr.
> > > > > Documentation/devicetree/bindings/bus/renesas,bsc.yaml.
> > > 
> > > I don't think we want to start putting specific compatibles here.
> > > We
> > > don't do it for simple-mfd, syscon and simple-bus, so neither
> > > should
> > > we
> > > do it here.
> > > 
> > > > 
> > > > This means that i.MX8qm/qxp CSR module dt-binding documentation
> > > > needs
> > > > to be changed.  I'd like to know how Rob and Krzysztof think
> > > > about
> > > > that.
> > > 
> > > The fsl,imx8qxp-csr.yaml bindings are broken anyway... You have
> > > device
> > > specific bindings for non-simple device but use simple-mfd. You
> > > cannot.
> > > simple-mfd means it is simple and none of the resources are
> > > needed
> > > for
> > > children, but that binding contradicts it.
> > > 
> > > Now you kind of try to extend it even more make it more and more
> > > broken.
> > > 
> > > Rework the bindings keeping them backwards compatible. The
> > > combination
> > > with simple-mfd should be deprecated and you can add whatever is
> > > needed
> > > for a proper setup.
> > 
> > I did try to rework the bindings and make the combination with
> > simple-
> > mfd deprecated. However, it reminds me the problem that "simple-pm-
> > bus" 
> > and "syscon" can not be in compatible string at the same time,
> > otherwise, nodename should match '^syscon@[0-9a-f]+$' and '^bus@[0-
> > 9a-
> > f]+$' at the same time. I mentioned the problem in the same
> > thread[1]
> > where Rob and Lee suggest to go with this patch. "syscon" is needed
> > since i.MX8qxp MIPI DSI/LVDS combo PHY node references the CSR
> > module
> > through a phandle, so dropping/deprecating "syscon" is a no-go. 
> > 
> > Also, as Rob mentioned in [1] "if register space is all mixed
> > together,
> > then it is the former and an MFD", I think the CSR module should
> > fall
> > into the simple-mfd category. 
> 
> You are now mixing MFD with simple-mfd. If you have clocks there or
> any
> other resources, it's not simple-mfd anymore.

I may try to make the combination with simple-mfd deprecated and add
another combination with i.MX8qm/qxp CSR compatible strings and syscon
only. Then, it will be a MFD, not simple-mfd.

> 
> > Take i.MX8qxp MIPI DSI/LVDS CSR module as
> > an example, child device pxl2dpi register offset is 0x40, while
> > child
> > device ldb register offsets are 0x20 and 0xe0.
> > 
> > Geert, Krzysztof, can you please consider to keep this patch as-is,
> > since it seems that there is no other option?
> 
> There are other options, why do you say there is no? Making it proper
> binding/driver for its children without abusing simple bindings.

I don't quite understand your comment here, sorry. Here are the 3
options I know:

1) Add a new MFD driver for the CSR module
I sent out a MFD driver[1] for the CSR module for review, but Rob and
Lee provided comments there and suggested to use this patch.

2) Use "simple-pm-bus" compatible string in the CSR module's compatbile
property
As mentioned before, "simple-pm-bus" contradicts with "syscon".

3) Add the CSR module's specific compatible strings in
simple_pm_bus_of_match[]
This is what this patch does and suggested by Rob and Lee.

Looks like 3) is the only feasible option.

Geert, Krzysztof, any objections to keep this patch as-is?

[1] 
https://patchwork.kernel.org/project/linux-arm-kernel/patch/20221017075702.4182846-1-victor.liu@nxp.com/


Regards,
Liu Ying


> Simple
> bindings are for simple cases and this turns out not the simple case.
> 
> Best regards,
> Krzysztof
> 

