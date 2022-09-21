Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7336C5BFDD2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 14:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiIUM2k convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 21 Sep 2022 08:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiIUM2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 08:28:37 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.111.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455883D59F
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 05:28:35 -0700 (PDT)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2109.outbound.protection.outlook.com [104.47.22.109]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-54-ACdG82exPDmw7D2lqQ5xdw-2; Wed, 21 Sep 2022 14:28:30 +0200
X-MC-Unique: ACdG82exPDmw7D2lqQ5xdw-2
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 ZRAP278MB0128.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:13::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.16; Wed, 21 Sep 2022 12:28:28 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6c6d:333:ab23:3f5b]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6c6d:333:ab23:3f5b%2]) with mapi id 15.20.5632.021; Wed, 21 Sep 2022
 12:28:28 +0000
Date:   Wed, 21 Sep 2022 14:28:27 +0200
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Marcel Ziswiler <marcel@ziswiler.com>,
        linux-arm-kernel@lists.infradead.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/4] arm: dts: imx7-colibri: remove spurious debounce
 property
Message-ID: <20220921122827.GB41442@francesco-nb.int.toradex.com>
References: <20220920092227.286306-1-marcel@ziswiler.com>
 <20220920092227.286306-5-marcel@ziswiler.com>
 <20220921121505.GA41442@francesco-nb.int.toradex.com>
 <YysCNT2/qOi/BUC4@kroah.com>
In-Reply-To: <YysCNT2/qOi/BUC4@kroah.com>
X-ClientProxiedBy: ZR0P278CA0084.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::17) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRAP278MB0495:EE_|ZRAP278MB0128:EE_
X-MS-Office365-Filtering-Correlation-Id: c17aa327-49e0-4d6d-f5bd-08da9bccc96b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: RZ+F9U0g6GKz4PbPbGUqPpWToCYkLf+j5DZOSQb9PkMStWHnrNXdGhQkrSvmrxMfH+gPCd+zgW8L/xicDxjrBBVqV2q9DNfMp8Esn4jdN0mOmgYW2v84Hu1pTq3ksWXCFvdxpWVFWKvgefA9ZXnab5dmbA0bQEnW9EolCg3dDUDG15V4tSy4I9TsyYBUzwIE7Veqqj0d4KXVL+FM9FHrQCVJmlzxzVE+PyVwL4N7ivDyFfT4dSQ8JRJelG9tmP/5/Fcr1Stdj+u9smowOGPJ0p8bcQWp6dvruPmG88pD1PfGm0b8LXmqqaLkIgBjt0q/5/9hxy9qUmwUQjj8CUPA9FKQF0GAKG7BG5dQTZE7suM7dHJK34IFuws4bvPRQDdHxqu1ERk9vSQdgZuQIRMjM72Sc6z0euU2OKrCerIhFsTx7wNy9KDt0ghow1GnsPMK/7oXyiXPF0/Ra4uRKGluw5JJxpDokeMlBvWdPWsA7CpE+nC2yea3Vs/arw6Vtw+XYAT4txMp4ZONvw8OAZsOCVDEMW1Zx3Lvh0MOB4aYsyNys0oXaZ2wMWw1UL2WHbhjAJfl9OxUXd8ZdV1alkDvUzbUTWZ6eh/lR2FPCRxnLpj0jvI7H5hMQUfYfCFKPxpmrGieeavmJED/8hFcOV7zHA6rfCodfrYdJDXimBgLaRR0ExtJDf7SY6M2u0AaXIyq5uzUEkQ86ARobQmwljE/PKaBkf1/NZ5vUt7GMkpIPQ9BXG+rRsL909OfmsTfM5HQzzvcLpcOhum3lnyWJqFGdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(39850400004)(376002)(346002)(396003)(451199015)(44832011)(186003)(33656002)(6916009)(8936002)(54906003)(7416002)(316002)(86362001)(66946007)(66476007)(8676002)(4326008)(66556008)(5660300002)(41300700001)(83380400001)(6486002)(6506007)(478600001)(1076003)(38100700002)(38350700002)(52116002)(6512007)(26005)(2906002);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ym1LywUC6rcjPaK2JXP3E8Dfp8JHZKKn0weRUpxcnJ1mim2stR/wDLs9ZiA6?=
 =?us-ascii?Q?S1ScDs/d7huJ8w5SMSOALPzlCe2pFr0jim3l2+U+uCCB3VVTvHCiUdBc1vtv?=
 =?us-ascii?Q?rCwrE+vT9XGTR2wey/1tTgfd8ZUvzlnAtiOzl+4y2v4osMo5A3vdR7lHh/0O?=
 =?us-ascii?Q?OMw4WU8BY17WEX5P1bvrptV37drdxbFAR+OvARp5tVLsydt/qNaGxlZmGiPk?=
 =?us-ascii?Q?X8eKzGHqNDJsK6R9nV+uA5Eitfw5QJe0EEW4ZSaNZ1iYSzBMflPDEzHl9ySD?=
 =?us-ascii?Q?TNp9fS+fT784bfeGt0v1X6ibhjWuzTL6gDcqA7X/brx/KXbXHzQg9vL1Q3cP?=
 =?us-ascii?Q?GUnAYTRg+GTKFV1yde8OP2SSAwwV8H4yVzp4QiJ7C2qIrSs8L1ympkZurK0c?=
 =?us-ascii?Q?gvHzFNnbONEeafTh/FDIi8mt67NEN3KxFIHESGXUK5KYuUzn5i0Ou+t81/LE?=
 =?us-ascii?Q?CjZ7YSYfQOZNE3s2eac5DP+J/g1JNREzGaJZdOYM/c8cihvEphZsWjoqvBYF?=
 =?us-ascii?Q?h2FWUhpDFjWNUvnlt8tydgFHRL3zptJlmDMWSKZfjWfsqWqnWBCMb5c/90g7?=
 =?us-ascii?Q?h50ovSnMIjtdXeULrSxjhsw9FXIQ3Q/V5UiKwMeJSJD41iFREAYIzKpIZYYS?=
 =?us-ascii?Q?GK4J8O4w88iE/kcrERbmsN84k79ls8lJdV7P7GcYNCplXErlEIBqxAizelk9?=
 =?us-ascii?Q?09o0RIaghwXrsJmj/OPgisiIiZWLvua/VWSIcy2V0Q1qNE78bCsZHqLA0GdU?=
 =?us-ascii?Q?JVyjM+KuBKrjV7O5sJlhrm/eBfrkOX/e4Z8Qg3cEbvn1WZOwxxjlcyRaPsdR?=
 =?us-ascii?Q?woM6am2qRQp1fMLiqV/70NIorSogo1rmTK9ApBbRqhVaQCRoes6EA5Ci4PDn?=
 =?us-ascii?Q?DIaWBf36/pnQWHTLvmYmCYGvTzNU9M3Fc8rNT7V5ahSaMufDOHO76WRs5S2I?=
 =?us-ascii?Q?Z65uIrc4GzQCJ3Az1Cf+I2DHAqxeMqj/lV5TVtaxKbhWJrgWA7R/iV79/IXD?=
 =?us-ascii?Q?ziOcZiZwQjtwuSvZZErPdVXaN6hl/vNxeOJIVgfUq3n66KPxJjGabArZanPJ?=
 =?us-ascii?Q?fE6Etjs+aZtdFLA1wlw0oRx/c2R43dCdbI9kuxUxUa1DIowY9ocRCcCo2rlA?=
 =?us-ascii?Q?v3xoUiTshNvJKUu0XIOzZvAoRWYEO9gvpCIBdGeTIe8PHThx0YxXxY4ViPCB?=
 =?us-ascii?Q?uQiQaeXyA1EkczOy1lKHUImpiIOgWrsfHZuMaPxQApmVaPKYL2jr3d9cEhKV?=
 =?us-ascii?Q?MbzB9ElkU4VW3bwzyVHXiTo7vwMRr9NjMJse3uRPzP2qKvGcu9mpBlp57zFm?=
 =?us-ascii?Q?dn9xoK3u1V4gToUJYb9O/0+ti6S7GQ05Dm6/zDV5GOiLHz4LJwv8Zrava7Jc?=
 =?us-ascii?Q?urqDF1/325HK7vL6oKC2GUWlrjDAyPWn7aDzQya3tziT7LKXwHOsNyw5y5lU?=
 =?us-ascii?Q?JVwru/tAyXelnZ077IhOLDf8AzGW/y9I4Dob2GG95Lft2OTJ/WkXPJ63qiz4?=
 =?us-ascii?Q?Hh399GY9T9OL2Iv1Vv/soGVJ42quFmPGKXa2EXfc1yYJ7k9wCVe3BrGGOAGI?=
 =?us-ascii?Q?d37LO++pOR87JIPHe2STVeQNRVQheN2Q6gXI1yEkcfXwibzfcOq3obVqQQ8J?=
 =?us-ascii?Q?dGbfarn73/ko5ZqdfY1DrWQ=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c17aa327-49e0-4d6d-f5bd-08da9bccc96b
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 12:28:28.2056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dKdhZvh1WRHOrVektjnIgpnSrcuOgPPtlX8QgRhXoxp6SO1AbJPnFINjaZ5O08pBbBW3thmN/rQjSFEDiS8+zdpEw51fzWcZAppASzaHZUc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0128
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 02:23:17PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Sep 21, 2022 at 02:15:05PM +0200, Francesco Dolcini wrote:
> > +Greg, to get an opinion on the fixes tag.
> > 
> > On Tue, Sep 20, 2022 at 11:22:27AM +0200, Marcel Ziswiler wrote:
> > > From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > > 
> > > Remove spurious debounce property from linux,extcon-usb-gpio.
> > > 
> > > Note that debouncing is hard-coded to 20 ms (USB_GPIO_DEBOUNCE_MS
> > > define).
> > > 
> > > Fixes: 0ef1969ea569 ("ARM: dts: imx7-colibri: move aliases, chosen, extcon and gpio-keys")
> > > Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > 
> > Hello all,
> > we did have some (internal) discussion if this patch should have the
> > fixes tag or not.
> > 
> > I do personally think it should not have it and should not be backported
> > to stable tree, since this is not fixing a real bug, it's just a
> > cleanup.
> 
> If it's not a real bug, why would you have a Fixes: tag on the commit?
> 
> > On the other hand the original patch was not correct, and this change is
> > making it right.
> 
> Ah, so it is a bugfix.

The DTS file should not contain this unknown property, however having
this property present does not change the behavior of the code.

It's more like an unused variable kind of error that could trigger a
warning in the compiler.

Francesco

