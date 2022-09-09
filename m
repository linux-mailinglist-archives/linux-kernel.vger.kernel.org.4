Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962045B3A9F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 16:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiIIOXE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 9 Sep 2022 10:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbiIIOW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 10:22:57 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.109.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4C0134C0A
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 07:22:54 -0700 (PDT)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2047.outbound.protection.outlook.com [104.47.22.47]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-31-Fz9ZJPNUMoe3m95_SQ814A-3; Fri, 09 Sep 2022 16:22:50 +0200
X-MC-Unique: Fz9ZJPNUMoe3m95_SQ814A-3
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 GV0P278MB0131.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:1c::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.12; Fri, 9 Sep 2022 14:22:48 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6c6d:333:ab23:3f5b]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6c6d:333:ab23:3f5b%3]) with mapi id 15.20.5612.020; Fri, 9 Sep 2022
 14:22:48 +0000
Date:   Fri, 9 Sep 2022 16:22:47 +0200
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Max Krummenacher <max.oss.09@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Will Deacon <will@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 0/5] power: domain: Add driver for a PM domain
 provider which controls
Message-ID: <20220909142247.GA238001@francesco-nb.int.toradex.com>
References: <20220609150851.23084-1-max.oss.09@gmail.com>
 <CACRpkdZ0=8poNcFaCYSmMyg1GBfkHLAr3QvvzFKweLPr3UM2vg@mail.gmail.com>
 <CAEHkU3Wya0nRhaBDisAQBm5kf=2YcdJYzz2jKiL___mZQzL_Sw@mail.gmail.com>
 <CAPDyKFrEYCx3L94gz27Pk_=HdwA4GNGE9Lvz+HGUW0P7Qt-mBw@mail.gmail.com>
 <20220726160337.GA41736@francesco-nb.int.toradex.com>
 <CAPDyKFqGFjywJ-Vmmn9=-NOzJX=24mH9A03H9djS=nJotKWK8A@mail.gmail.com>
 <20220728112146.GA97654@francesco-nb.int.toradex.com>
 <CAPDyKFqtCxrjALeCmhuqQ2VmmUHhi-DjXO30uHChTPFeDbp+JQ@mail.gmail.com>
In-Reply-To: <CAPDyKFqtCxrjALeCmhuqQ2VmmUHhi-DjXO30uHChTPFeDbp+JQ@mail.gmail.com>
X-ClientProxiedBy: MR1P264CA0202.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:57::19) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRAP278MB0495:EE_|GV0P278MB0131:EE_
X-MS-Office365-Filtering-Correlation-Id: eac0751f-bd6e-4bec-7c61-08da926ec595
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: aAj2rigwqGGfl/fTnUvujiT+0W8z/mYkTb0I5XDoqigy5u7nhABiuPcWc/5bF3RBLwcBL2GpTNqiPD81U+UnTwgFuoX2ruM5N+A5vk4Vy0M7Oez+SMA5oRqi9nvYj/iApP9Qe92p81UIRPtnfZM3G6wYNBvF4tar3PSPt+/FkQ5nXROOL6MtoUnpR3deMSoYfhKslQkFsKwbcMsISGNphS3Nmpoym2oAezPQ7J/sFjzwq7Oh4hYgm3P+yekKsUnYABL/ctDa69wQJPZuZq+XfC3X9FjOpi9X1bT1Cws/Rbch0RgFKy/ygC8IkGppzaoF9FxDfrLiHv8oIRKirj6pRouR/TKd1wu+e3efgZxeHZQOGFmZAGxFOQUMhx0ojwfRnJVmbpKtm9X597bbpFmaX2q2/qg9olBqEQxcNoHSbjsdUrYAtDQbfX5KxZuCy9KTtjIbayMG9nreso+FpMNmApR7Yn5rFooNsFQeevXIb60F157/KkMU5J4CUij+CykZcjdJsicu7gCWvI0592lqhO478yJFhaFmMptXXrX96KwUKsJ9M4ZpGF0W5/RunoLnlQ8JpxVph0Z+WYvYHGUVP7l3vM0W7vzJWQ9JfkPkERP9dvM9Wkn2MsFyvJb0WXnEZkC7Zs7M4Tk4eW1dyaL2x8f3ki/etK2yIZWaIMyEkKRmyzaqoiSQIrLG90nxgNe7QZ5ZKaTq09P2R/GSLCAcfl2FCZhLvr3uSHoujiNyEfF3JMd2uaAWZczCJwQMMww2ixuPujpA8CkdIpEt2LJ7iiRgnAoG7HnuwrOEe1/eKJs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(376002)(136003)(39840400004)(346002)(44832011)(38350700002)(83380400001)(186003)(1076003)(33656002)(7416002)(316002)(54906003)(2906002)(6916009)(8936002)(8676002)(66556008)(66946007)(4326008)(38100700002)(66476007)(5660300002)(966005)(478600001)(6486002)(41300700001)(6512007)(26005)(86362001)(52116002)(6506007);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q1SYc1moejR5DBMT0TvRuDuf2XAcW3Cwflh7cwUrJ8KclNOcntoWn4BDy4Ku?=
 =?us-ascii?Q?Du985vd1ipIBrZu9ddfYOMmgE58jIwpQdjRjhJs8Bwrx5V8t8nXwcIzSMmSG?=
 =?us-ascii?Q?Y2ybb8OrOTqls4172XqMY/79RfKsHroLWKKUYrpxmosYWDyEsGJl52U4X5Jt?=
 =?us-ascii?Q?WVjNDfBF0tDK2wtlT318ljrkbaAmQMY37GqSeoI+ugTG0Tukl38xDlorM5/b?=
 =?us-ascii?Q?8597AcZJjD4k0OR7+iuQNnOFk9dVNOrGSC0gVvvVs0V6Fhv2H1KRZOy75j3h?=
 =?us-ascii?Q?gVJDTj+tqLJVRgZrzOO6ahxGI1x9q7yzwzTnxywJyN2kA6n5iOYSFf89xXM5?=
 =?us-ascii?Q?HZQjtfl8PUoF6PGGIVzKGsUrK1N2b965HEiFF38t3Z5vrlfPB4R7hFEaNEGF?=
 =?us-ascii?Q?Ufi+z53NmksOYsN0jXtZnqo6hJEgsPq/oUCDFmuJ9nnr/XbFMw1/3cHBIawq?=
 =?us-ascii?Q?f+AbZpHKWYtuFfCj8MGMY2Kkgol9nY4tHvUZf2z+GWxvx1+IUB/h3izl1ceY?=
 =?us-ascii?Q?440yHOKfYDCtzzWW982T0AWwTFPS8vXFFj8cPvgxsMivENsO1VX5JZtOSkn2?=
 =?us-ascii?Q?M1moBXqgMRS6e1XX84KHAJwFkypyFrGspwGcPvlr2IgIRczZ9ujL/RrW44te?=
 =?us-ascii?Q?hbbKj9odIhsP2mLYUQpXoljJAr6giMpQtGZ/rUAGWRfnEVbchRXodNXNrwSi?=
 =?us-ascii?Q?Wx1SprFoM0E9LnH4LEWAiP5Te9eXsPPYIn29orIHL7MSeL9cOO5jcywREYLU?=
 =?us-ascii?Q?6WNC4jAIJ5rT9aN/Ve9Nr46BXEP3dgHf4vYEgbFuzd+5qUwBLqJ8NuoZD6p8?=
 =?us-ascii?Q?3DAs9CTE80uGE4q22Clo4mYze4BVF/M06ZAsr24fPpgw7gVvFo6WTWXQ3ZFX?=
 =?us-ascii?Q?4RN0TzYWZK4vzyfrnK3eNMTadAt4oQdylNokzdCGFHlfXuXWNOwmYw+13X9m?=
 =?us-ascii?Q?B4ZdBi1LmgMcyfsnJS6g1WcWa5makbK6n8ckVgfjSDxy7Qz/reJjQnaf6xvH?=
 =?us-ascii?Q?QpzxcuFebaDoW9FxOOL8BlaoB71+asceWXnTsBTNVEe+pzPZ224JVcex9VD4?=
 =?us-ascii?Q?3SI5VUw2FV2XDl4ksdJ8oXnzqKde8qiDdFFvC8CU1D/XKN4zGHbj8UibeNJN?=
 =?us-ascii?Q?Sst0+iIlD3cYGUBuuAhe3RVtJgYxtu7Tv1Z3O1y8v9S/OIVoqz8qTYHySyPk?=
 =?us-ascii?Q?GFZm/6JMxsvL4NwFRM23mOXykekrwkqtfxNT8g7+MLHX9ku17FSvq3pDRAJE?=
 =?us-ascii?Q?bjpMUhAAklFW0NfJsXteRzVuN8BRCAZHT4b6ZzN2LZ74PegQ+txvf39NcGve?=
 =?us-ascii?Q?24EgKTvO95lNoLNkS3WHineZt/KDDvtK+ni5UADDQuBfVa/EmHisTnQFfZKF?=
 =?us-ascii?Q?OiZkhTkOiZRK9FeaIjQaPUQ0cKLLrbOSrxB/dqdaK2aA4DG4LjdkMPB0jg0w?=
 =?us-ascii?Q?CzAVfW8xQrxoLW5jbe0UtHMUfXEsH8oVIizpWiNHWU/p6JlFqkcyKIGRPgJu?=
 =?us-ascii?Q?ElRjXjPsKJuSN30urLJ8uAM9o5NnmiuGcHXywbYXoZ6hvmL0AqSuA6yPqbaR?=
 =?us-ascii?Q?HphWQ9FaT+7sV3jqcl8jpZNIatM4LOIe4WVhw5X+AzlbXlKjGzZh+fHvZ1ig?=
 =?us-ascii?Q?Lw=3D=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eac0751f-bd6e-4bec-7c61-08da926ec595
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 14:22:48.6650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wmfj01+x3q9JUylafiVzIAo3JSFvhR1bgiCqS3ijZqdtfTs+liw9Qa/yW21oBMWZQHWj2oZAIrMIq0X93A1NUZTGlX/xuerb9O9CBgB8ImI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0131
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ulf,

On Fri, Aug 26, 2022 at 03:50:46PM +0200, Ulf Hansson wrote:
> On Thu, 28 Jul 2022 at 13:21, Francesco Dolcini
> <francesco.dolcini@toradex.com> wrote:
> >
> > On Thu, Jul 28, 2022 at 11:37:07AM +0200, Ulf Hansson wrote:
> > > On Tue, 26 Jul 2022 at 18:03, Francesco Dolcini
> > > <francesco.dolcini@toradex.com> wrote:
> > > >
> > > > Hello Ulf and everybody,
> > > >
> > > > On Wed, Jul 13, 2022 at 01:43:28PM +0200, Ulf Hansson wrote:
> > > > > On Thu, 23 Jun 2022 at 18:14, Max Krummenacher <max.oss.09@gmail.com> wrote:
> > > > > > So our plan is to explicitly handle a (shared) regulator in every
> > > > > > driver involved, adding that regulator capability for drivers not
> > > > > > already having one.
> > > > >
> > > > > Please don't! I have recently rejected a similar approach for Tegra
> > > > > platforms, which now have been converted into using the power domain
> > > > > approach.
> > > >
> > > > Just to quickly re-iterate how our hardware design looks like, we do
> > > > have a single gpio that control the power of a whole board area that is
> > > > supposed to be powered-off in suspend mode, this area could contains
> > > > devices that have a proper Linux driver and some passive driver-less
> > > > components (e.g. level shifter) - the exact mix varies.
> > > >
> > > > Our proposal in this series was to model this as a power domain that
> > > > could be controlled with a regulator. Krzysztof, Robin and others
> > > > clearly argued against this idea.
> > >
> > > Well, historically we haven't modelled these kinds of power-rails
> > > other than through power-domains. And this is exactly what genpd and
> > > PM domains in Linux are there to help us with.
> > >
> > > Moreover, on another SoC/platform, maybe the power-rails are deployed
> > > differently and maybe those have the ability to scale performance too.
> > > Then it doesn't really fit well with the regulator model anymore.
> > >
> > > If we want to continue to keep drivers portable, I don't see any
> > > better option than continuing to model these power-rails as
> > > power-domains.
> > >
> > > >
> > > > The other approach would be to have a single regulator shared with the
> > > > multiple devices we have there (still not clear how that would work in
> > > > case we have only driver-less passive components). This is just a
> > > > device-tree matter, maybe we would need to add support for a supply to
> > > > some device drivers.
> > > >
> > > > Honestly my conclusion from this discussion is that the only viable
> > > > option is this second one, do I miss something?
> > >
> > > No thanks!
> > >
> > > Well, unless you can convince me there are benefits to this approach
> > > over the power-domain approach.
> >
> > I'm fine with our current power-domain proposal here, I do not need to
> > convince you, I have the other problem to convince someone to merge
> > it :-)
> >
> > Maybe Krzysztof, Robin or Mark can comment again after you explained
> > your view on this topic.
> 
> To move things forward, I suggest you re-start with the power domain approach.
> 
> Moreover, to avoid any churns, just implement it as another new SoC
> specific genpd provider and let the provider deal with the regulator.
I'm sorry, but I was not able to understand what you mean, can you
provide some additional hint on the topic? Some reference driver we can
look at?

The driver we implemented and proposed with this patch is just
connecting a power-domain to a regulator, it's something at the board
level, not at the SoC one.
We do not have a (existing) SoC driver were we could add the power
domain provider as an additional functionality.

> In this way, you don't need to invent any new types of DT bindings,
> but can re-use existing ones.
The only new binding would be a new "compatible" to have a place to
tie the regulator instance used in the device tree, but I do not think
that this is an issue at all.

The main concern that was raised on this topic was that we have to
somehow link the power-domain to the specific peripherals (the power
domain consumer) in the device tree.

Adding the power-domain property there will trigger validation errors
unless we do explicitly add the power-domains to the schema for each
peripheral we need this. To me this does not really work, but maybe I'm
not understanding something.

This is what Rob wrote on the topic [1]:
  > No. For 'power-domains' bindings have to define how many there are and
  > what each one is.

Just as an example from patch [2]:

  can1: can@0 {
    compatible = "microchip,mcp251xfd";
    power-domains = <&pd_sleep_moci>;
  };

leads to:

  imx8mm-verdin-nonwifi-dahlia.dtb: can@0: 'power-domains' does not match any of the regexes: 'pinctrl-[0-9]+'
          From schema: .../bindings/net/can/microchip,mcp251xfd.yaml

> If you post a new version, please keep me cced, then I will help to review it.
Thanks!

Francesco

[1] https://lore.kernel.org/all/20220613191549.GA4092455-robh@kernel.org/
[2] https://lore.kernel.org/all/20220609150851.23084-6-max.oss.09@gmail.com/

