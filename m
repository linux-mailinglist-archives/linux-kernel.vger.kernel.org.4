Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE4C67C2F1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 03:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235264AbjAZCzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 21:55:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjAZCzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 21:55:45 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2042.outbound.protection.outlook.com [40.107.22.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36766469A
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 18:55:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NcJnZrt8xs6o05StcblDTycO5cAgCB4fq+GjxzHqRuZlCXft3azaNsRS/0M4LIQrSAR16nGjRh9F/U67BMkZOeuhAIkaISsVv1IxvbmnNOZ8nprr7kR1CIUUVBBfbJDm+8OBNORlQnS32DdYPbzNSqHasMWj/uuUh0yuYJlF4BVmiOpKwGYsgscyU1/CMUbeY1+7rdo+rSFYy9f5v6Z9u5WKPAqRXLRCyEkOCIMLa3PKczNVGoOkKGxb8lcV6CAXVBxGwOZTnqPpFw5LuakfIsiffpo17pd4tEv5ycNe7njAtDo2X/NsIrl6bgeRahRud6iIHnf1xT9fENfwRWNtnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wjA3xzy2PgjABgBMid18P6e4kNrLJcck1oqHyxc5Hgo=;
 b=RSHCtnNv7sLLCHT/OPPYuflnQzOOG6g1wywH/9D6O2pTNkihrc5da9TvQ4T+ZNJ7+/G6tgiaL5mTiUexoxrR2j4sPrs47M6go7H7NYrISJHPFcyx5k/Ae/kT9NFqppeRc/mk6NFE6Nf+nWToVrDIvDZ10wXIzY4O87dIVfxw1AyjtmXEpOLqlo5R8XVeEpbXgNqVUH5q5adP65ro+Axda94ULmESH5ELIkVaqnK2rJlmozshrF/BOcWVAWgFEfUsYwF8hE1GvORjJBxo3Lynio+7XnJpk9h9xuCKaeppAXnc12E2MDPNwBktY3uLrFLLw/0nXUZfavJ4WH06RBa2HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjA3xzy2PgjABgBMid18P6e4kNrLJcck1oqHyxc5Hgo=;
 b=hXjIgHIPBAJr47Gh1xPfa3Umkb2Ft9aGESFGcSywylvTVH1JmS7mXlMXOhBDzgYCWRkJ4TZaY/X8LRX8NGrh5lj0P3eDIragihk1CAFfUe06DUswziyLvhWJdgvCRK9l0N7IUJVv8HTHqNuUIz3MOcVEXM8uVGtQbae0Z6fZvg0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by DU2PR04MB8710.eurprd04.prod.outlook.com (2603:10a6:10:2dd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.17; Thu, 26 Jan
 2023 02:55:41 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::5725:92ec:f43e:f5fc]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::5725:92ec:f43e:f5fc%7]) with mapi id 15.20.6002.028; Thu, 26 Jan 2023
 02:55:41 +0000
Message-ID: <7c84cbd1808dc89f9ddaece13f846c4fbd12935a.camel@nxp.com>
Subject: Re: [PATCH] driver: bus: simple-pm-bus: Add Freescale i.MX8qm/qxp
 CSR compatible strings
From:   Liu Ying <victor.liu@nxp.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-imx@nxp.com, Rob Herring <robh@kernel.org>,
        Lee Jones <lee@kernel.org>, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org
Date:   Thu, 26 Jan 2023 10:54:54 +0800
In-Reply-To: <CAMuHMdU0KaRyP0qxJLwit1G=7zMr1k5wpCkG-wD31958mrKRWg@mail.gmail.com>
References: <20230125083248.1305270-1-victor.liu@nxp.com>
         <CAMuHMdU0KaRyP0qxJLwit1G=7zMr1k5wpCkG-wD31958mrKRWg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0049.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::7) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|DU2PR04MB8710:EE_
X-MS-Office365-Filtering-Correlation-Id: ddd50165-5bc3-491b-9469-08daff48cf6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0WtNyZQ103q/nPhkPh5MwMI8Zk8tkEn73Nxbha+a/hPPyxue0cqDF/158QbXMB/Y+6SukaAqqYOwCHgZ8fvYNoJwiY9BHJV+xKCQTy5RF2jgcMHC8R3JwxaWmkpUUkTMuJ3s3hKvvMy0AOfb/xdFAM28wJojEm751qXM3eL/57/nsZiZDTc63elj5ccUklC6ZVJxCsF36yD/MOi3eTVl1Tsi329ZQzwYJRgvbkxgtXDOfsR4rJBPyLgdips2F+6zAh7nxBjNE9x3+BeagzHPYr48X+wqNMXm33odd+HOChS/9ma5oL6sr8VR3CKILqIxtyLNjpRdJeIYKQvz5yQFDzoMgoTUSM05hViWciDH3w4AGjum1Q6Al7dkVqp9KluMBFkBVOtBQTEMRzrOkMCGoWTNSRLJGzA22PpyoEQnoljgkAK7PNXGvrb4DkI6lhQg2kBiC1i6q8KA2bKNHdfuG32ykOYR3IxU/LvBgJXCiw1xNTVSlF0LWZxKrtJlLXifKKBlbPpegf2NBJ64ZKmlbXKYaiuCxSHQ2NH7hQIxdVdepzOH3d/h42QheLrbEY6cl2+GiNA6cGdrg52V7B5MfpQKLGfBKKgW/wDactWwaSSH2VYYroTx/PM688RnTTjiY7/n64DPB8tDgOybY7Xh6jmAeoQiRFficK2VOFMkMEquOwQ1j1oR2QTUsD6tzYzPQcaEEZb/a1UsOdBzAqnyaNVmOVYM+/Jfq1VQ5YcYSxplKZ+bTsFHQ2pwxZq2x5fs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(136003)(366004)(39860400002)(396003)(451199018)(36756003)(86362001)(38350700002)(52116002)(2906002)(38100700002)(5660300002)(41300700001)(6916009)(8676002)(4326008)(83380400001)(8936002)(66476007)(66946007)(54906003)(45080400002)(478600001)(6666004)(2616005)(53546011)(966005)(66556008)(186003)(6506007)(6512007)(316002)(6486002)(26005)(99106002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUo3TWw2dnU4VTdZSG0rSWtwbnpFM2h0RG5CVkRocFo1MWtKWXA4bzJiRk1x?=
 =?utf-8?B?S3dobWJqYTZCTzl5aS9UQmdteFAzcTQyUHpVTkdmWDJTZ3RYa0cvcTR4UVVW?=
 =?utf-8?B?Vno3NTk2NDJ4c04vWjBveTFxLzJJd3hqQlVEMGhCenRCbWlSQStPV3Z5bmx2?=
 =?utf-8?B?a0ZqZkpVd28vTlRtKyt4WjlNcU0wajVuRjVwZUJIRHcwZ0RDMWN6dzRlY1Ft?=
 =?utf-8?B?SlViSFdYaUtKbGpFM01kRTE4bDJPRXJlb0pUdlpjeXBXUXFJRndUQVJpQllB?=
 =?utf-8?B?VXpnMmZQbkNCb3BCSWVBaGJ6bHVRUndpOUJkRm9DblpXWmFRMDgzVHBiWTNw?=
 =?utf-8?B?NkFKQ0ZqVzJmc3EzUUtXeWgyTTVFY2xoSjU3SzhodWRtYWtGU1NTa0FlUjZY?=
 =?utf-8?B?QzNtSk9YK1VGZlJoM0NNbEV5Sko5N29YMkpKQUhhejNGclY5Y0FUTHp5SVha?=
 =?utf-8?B?Sm1Od1BxeldzdXpEUnBna3VseXh6UndrSlRRQTRRVjhHaEtPeWZzSkRFanRM?=
 =?utf-8?B?ZWZOOUJJRExYOGQ1ZXZLRXZVV1JQN3dkOE9lWUVPWTRlMlhtTk1MdG5tMGJC?=
 =?utf-8?B?Ny9ucGtnN0ZzU0xRMTVxVGZpUkIwZjFnamwvektwL0gvdnIvS01EVnF3bm84?=
 =?utf-8?B?RHhhdHVBdXhlSTFnKy9zdkhaZEVpMC96MkczMkhqNTVVQXkwa2FUckV4S21o?=
 =?utf-8?B?TG54OXdzcks1WHBTWjl2MVpuRW11MWlzVTNqNkNQSmMwMTVFaDJCdTNPVHND?=
 =?utf-8?B?U1BGT2lDakkwT2xGU0o4M1FHMmFTMmJoYWdWVkpRRno5VmhNOGw0WmxsYVJJ?=
 =?utf-8?B?ZHRncSt3U0xRM0VseXZJVVI5b3NvNVJCcDZyR2lwdDZJdDhzV3pNcXcxcSs5?=
 =?utf-8?B?TGpsV1RPQ2tlMXkxVmFqSTh0MVhYQ1dBV0luNUlSL2VFcWczc2xuSTczNXZz?=
 =?utf-8?B?dHNOY045d01jNzJZQXB5TjJGZC9kakZOWlN6RXExdGFPWVUvN2F3Wk1VN1hD?=
 =?utf-8?B?WEhsSVhXZG15NzBpZVlNMURMSjkzMEMwTzhNLzdmclNHR3RCN3Vvd1VQTUJC?=
 =?utf-8?B?ck9yaXhVODFKbHdka1FuVUxBbndMbkd1NFhWVUhpL1RqamhuZ2FndjEyQjBw?=
 =?utf-8?B?akkxOE1EUGYraWpmZWY4N0FZMWJEUSthSXlUVVJLQ2tGbUNJWnF1UytEd2Ry?=
 =?utf-8?B?SEwweUFqQi9pby9JM1RpU2V3MldvT0NCb0hWcU1MZm1TU2w2ekQvNktXMGhV?=
 =?utf-8?B?S2hYUnBla1N3NjFIbzlHMkh6RFZzOVVOZEp3ZVZOQ1RITmpRNWU1dlZMSCtv?=
 =?utf-8?B?L3ZuNkNIcWdkSzNkeEJmbVdTTlEwOXg1K1RUOTJ1a3hKa2ZvSmtQM1BVZjhC?=
 =?utf-8?B?cmRhbzdabEJndUpsTlc1T1VJSkNHNmhMN2RBK3NMZFhDNFlFKzdaUTJqK2dr?=
 =?utf-8?B?TjhubkxVNndOK1QvTVEzYUM2OG1PZkF1N1VFK0hKSlJkb3cxYmcvWkxvK0dj?=
 =?utf-8?B?TEdpSW5HUVhhZndYMFN2NjcvU2ZVb2tob0FYTzRLR1lraVhjaUpNK0RhbjBk?=
 =?utf-8?B?S2pycU0zSjJsY0J5US9yL1RTTXJxWnF6aEpMOWd4emdLMlZYZXZqNHBaaXJv?=
 =?utf-8?B?S010aVlseHp2eUxnRllZK290a28yWitFbmozZDFlNzVwejhxQ3p0RFpDWXR4?=
 =?utf-8?B?K2gxenhlUFBxaWhjSm5GLzFWaU1CYm9lQmpLQ3FHdXdTNFY4YmYxc3dhYlFY?=
 =?utf-8?B?cEY5YVh6Y2kzVzZLZnRjRHRqRmt5YXRSeVFiQXVnV1RGZFNWTm9UN3lxSlBv?=
 =?utf-8?B?TzdoSmJORHZlMVVSTWI3bEViL2hNcm9iR0FnZ0VXb0hKZVYwZVI4TjJQMXpZ?=
 =?utf-8?B?Y0JaRzdiVlIvVmZ4eFZLS0wySzBGSjI1K3NnY0Q3bHlqaHZmNzc1MmZLdlB1?=
 =?utf-8?B?K3BoWUh0SmUzdlg1dk8rejYwcDJmRHJHVENSSXNmTzVyYmJMY0kzLzVvZkJJ?=
 =?utf-8?B?YkxZNnFpa214dUdjWExnbFVVVnJDYU9yZWZCL2UxM0dXV0ZqVnR3UnRUMG9q?=
 =?utf-8?B?cFpxVUxGbWpYNDBBeWFLTWpQUzVGNC9DVXFsS3dxY1RZWDd5L3VSUHJEWlVP?=
 =?utf-8?Q?XJ05ArFyxA2wJ+yUc8n78v+CK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddd50165-5bc3-491b-9469-08daff48cf6f
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 02:55:41.2408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 37Th3KOQs5qnhiITsIr9DBDkbReAyE6OIBAXxjFPzXK792ChL6CTrabpHlvgomSO3jCYz/iPRlqF4D+cKjxepg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8710
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-01-25 at 10:05 +0100, Geert Uytterhoeven wrote:
> Hi Liu,

Hi Geert,

> 
> On Wed, Jan 25, 2023 at 9:31 AM Liu Ying <victor.liu@nxp.com> wrote:
> > Freescale i.MX8qm/qxp CSR module matches with what the simple power
> > managed bus driver does, considering it needs an IPG clock to be
> > enabled before accessing it's child devices, the child devices need
> > to be populated by the CSR module and the child devices' power
> > management operations need to be propagated to their parent
> > devices.
> > Add the CSR module's compatible strings to simple_pm_bus_of_match[]
> > table to support the CSR module.
> > 
> > Suggested-by: Rob Herring <robh@kernel.org>
> > Suggested-by: Lee Jones <lee@kernel.org>
> > Signed-off-by: Liu Ying <victor.liu@nxp.com>
> 
> Thanks for your patch!

Thanks for your review!

> 
> > ---
> > The CSR module's dt-binding documentation can be found at
> > Documentation/devicetree/bindings/mfd/fsl,imx8qxp-csr.yaml.
> > 
> > Suggested by Rob and Lee in this thread:
> > 
https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatchwork.kernel.org%2Fproject%2Flinux-arm-kernel%2Fpatch%2F20221017075702.4182846-1-victor.liu%40nxp.com%2F&data=05%7C01%7Cvictor.liu%40nxp.com%7C3fa98ff270534078019508dafeb34b10%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638102343312884116%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=zm8Z5gWt9yGXakYlxopUfZKLMUJRWTxq1kWHLyqhyww%3D&reserved=0
> > 
> >  drivers/bus/simple-pm-bus.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/bus/simple-pm-bus.c b/drivers/bus/simple-pm-
> > bus.c
> > index 7afe1947e1c0..4a7575afe6c6 100644
> > --- a/drivers/bus/simple-pm-bus.c
> > +++ b/drivers/bus/simple-pm-bus.c
> > @@ -120,6 +120,8 @@ static const struct of_device_id
> > simple_pm_bus_of_match[] = {
> >         { .compatible = "simple-mfd",   .data = ONLY_BUS },
> >         { .compatible = "isa",          .data = ONLY_BUS },
> >         { .compatible = "arm,amba-bus", .data = ONLY_BUS },
> > +       { .compatible = "fsl,imx8qm-lvds-csr", },
> > +       { .compatible = "fsl,imx8qxp-mipi-lvds-csr", },
> 
> I did read the thread linked above, and I still think you should just
> add "simple-pm-bus" to the compatible value in DTS, so no driver
> change
> is needed, cfr.
> Documentation/devicetree/bindings/bus/renesas,bsc.yaml.

This means that i.MX8qm/qxp CSR module dt-binding documentation needs
to be changed.  I'd like to know how Rob and Krzysztof think about
that.

> 
> If that doesn't work due to DT binding constraints, the latter should
> be fixed.

Adding "simple-pm-bus" to the compatible value in DTS doesn't work,
because "simple-mfd" is matched first and "ONLY_BUS" is set for
"simple-mfd".  s/simple-mfd/simple-pm-bus/ for the compatbile value in
DTS does work, but it means that fsl,imx8qxp-csr.yaml needs to be
changed and moved from mfd directory to bus directory...

Hmm, fsl,imx8qxp-csr.yaml was first written earlier than the below
patch.  Without that patch, child devices of the CSR module can be
populated.

98e96cf80045 ("drivers: bus: simple-pm-bus: Add support for probing
simple bus only devices")

Should I go ahead to fix fsl,imx8qxp-csr.yaml and move it to bus
directory?

Regards,
Liu Ying

> 
> >         { /* sentinel */ }
> >  };
> >  MODULE_DEVICE_TABLE(of, simple_pm_bus_of_match);
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

