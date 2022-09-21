Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA275BFD94
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 14:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiIUMPQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 21 Sep 2022 08:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiIUMPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 08:15:14 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.109.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5F0303C5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 05:15:11 -0700 (PDT)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2047.outbound.protection.outlook.com [104.47.22.47]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-31-GYxk_rdbOl6W6Ke5QUN3ng-2; Wed, 21 Sep 2022 14:15:07 +0200
X-MC-Unique: GYxk_rdbOl6W6Ke5QUN3ng-2
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 GV0P278MB0100.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:1e::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.14; Wed, 21 Sep 2022 12:15:05 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6c6d:333:ab23:3f5b]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6c6d:333:ab23:3f5b%2]) with mapi id 15.20.5632.021; Wed, 21 Sep 2022
 12:15:05 +0000
Date:   Wed, 21 Sep 2022 14:15:05 +0200
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Marcel Ziswiler <marcel@ziswiler.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
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
Message-ID: <20220921121505.GA41442@francesco-nb.int.toradex.com>
References: <20220920092227.286306-1-marcel@ziswiler.com>
 <20220920092227.286306-5-marcel@ziswiler.com>
In-Reply-To: <20220920092227.286306-5-marcel@ziswiler.com>
X-ClientProxiedBy: ZR0P278CA0122.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::19) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRAP278MB0495:EE_|GV0P278MB0100:EE_
X-MS-Office365-Filtering-Correlation-Id: d744c161-387d-49df-8d98-08da9bcaeaff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: iR4YugbDRxavRMb3B+Fcd9L0ZRzBMYhCRtFp4qTMHem5v2zWA4yen2um1UpHN9qAvRFsnhYskN/r9YDi40VB6MWm2i0qUJvr6/K6BUUk59RgwwrZ3aFF2HVF8K7N8smLc9CG7yXrvaQdM9COdWkKQlfrNsMuo/0l9Bp1fvwmPOxBsYG8oFGiIoHRLMvja6SlFcsYGZdfShHEQCsntO11dmmDFrM9CL7UdbF9K09UQFw1JC0rjeeidN0wJRczctvM8OY+zpv+YEE3W05FWDI+UL0tPYAVctNHJezYIHl7s1vukXpWt8lK2TCnc5WNbuQWv6gl9aFmOeWJtH08iW+OM3X89beTmPexncN5zjZea3GtuGY9fOV6+zMhmcIbMY8Jg6FcwKsBPzEXx9Vf3DYD9AcwH061Q78G8ESMtlQKzkxoB/ZHPx3f0m99ymthXizHwPB1gI9/LFsJbTRmJSMgeoMiATJTHmkyLW/VJxBcjd6e2TQs7QvDEJuOXkwkhxEcyk301X6xlAJk1+f01B0NpHx720aWYDOTE3ecdkJoLAJTDDQ4LJeojnh3gKwiFRCrB/xJWrtC7YUF/rP2yRXcQ4NN/GlkvCFAhfBOuOlqWzsnMgBguel1W+MV92/OyVDdK/1NUYzrtaVnx2CCF9xTns2tejUWxvyhqSGgX5Vl0HRE3W89lg7dQiEZYAPQ8pC/ObgRVQ8nbRFRYcqphytaEZdclE/IC9RaEHx/kxDObCfQv+q3Lz6se8I8sIerbJouNLDHDEmV8MkNQODicEAh6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(366004)(39850400004)(136003)(396003)(451199015)(6506007)(52116002)(6512007)(26005)(66476007)(66556008)(110136005)(54906003)(8676002)(4326008)(66946007)(41300700001)(86362001)(33656002)(38350700002)(38100700002)(6486002)(478600001)(186003)(1076003)(2906002)(316002)(5660300002)(44832011)(7416002)(8936002);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VwMcy5PUd7CmfNkEp7zn86HIq4nm4jEO+ZmfCIcFFdx74YNEMrtsoIREWWMk?=
 =?us-ascii?Q?3a6KYcVhW7yX/9akKPVUxECUHYCjrlblCxy6WX91j+pUtV2YOutihI3gnmPT?=
 =?us-ascii?Q?rcU0RqBfhTJK3YWNQPWeDMLdwtdn1FtQpfRProM24DSVEEz91YhkJ5RVPXnA?=
 =?us-ascii?Q?x51jsztoZoe4arXlZ9go403rX4E60nq1D+4QDAqV+d8rGEHbR6eIG2axVKtW?=
 =?us-ascii?Q?QztVGCEofX1oqlkG8iEH0b415s4QOC5wXOUbObVi6Fn36iltBf4szBBfvrEY?=
 =?us-ascii?Q?CxwrKLb6pyrgEgT7c0U9PuraitwqxooA8XM+OUDYU2I3h9qWAAbfFnr86ZIa?=
 =?us-ascii?Q?yDUKLW1wvzZoDNKg8j62vZdvjhYJssTcTAgye7uhHZTU51gJfq+Sbub+3KuR?=
 =?us-ascii?Q?UG94yDkBJTf0JBmukP8S4CGOMxwgtGa9j9lPqPkoWIN3Qjq1acCPDRquPd9V?=
 =?us-ascii?Q?PyGLaM1AHeKAXrTaFzZL31YNvjBvkgSeyhUCr83kulmAiNZ7NpI1CBzjXzRU?=
 =?us-ascii?Q?Lo3Gg6CMaSrppTfczWYjnXUzjmMOit1hsUcqvblHUOJIiTRyC4nAZX+1Oce3?=
 =?us-ascii?Q?0zm8tfwGJukelXEFZnqLjx0Db/y7xqxT4wfHlnfpwYhsepLen1JlWWwZU5/B?=
 =?us-ascii?Q?/gpAq8RvlSq/JMF9oX1OYp5sM2ZEJ4P21GONkHvvUK0URpgCzOc9uSizbQa4?=
 =?us-ascii?Q?tjI0s/1taVAWaR9keseHmT+Znwf6XwAneQrjcZoKkTPF+8INvEhR1pUVaOIj?=
 =?us-ascii?Q?X/jMMqLo6XgG/dTMgUa4g5Pci2NC32t+UxQ6I9wx/JqZ/e7uN1/csv72Fp8K?=
 =?us-ascii?Q?Iuj/Hx9scUiukr5zNArS4eee8n++8oZYy+Bc4kCNPpO7lydNt2npOMaYX7IA?=
 =?us-ascii?Q?yYGuNAguCSYQ3IGuSU5bRm8Uqjbzsgxtq6YxUDyWEaUb1ireDJJsUDgnVkyu?=
 =?us-ascii?Q?IRix+ZzmuDzkOJlOK/ULWtDtV5JRGYxfAcKEdbOWgAed75y/cATUXVM8+zbw?=
 =?us-ascii?Q?cWnigvoyk1NjKTwq9wG3FkiOpG7KPQd9oZMT+hVYoSr+Y0gGFUB087CiFcRO?=
 =?us-ascii?Q?y4yqBmOnJbw7hXnEji1rwYYdjmwyvIJotupp3Cx+froKCiUKW93zQiXjk7IP?=
 =?us-ascii?Q?ibI1UyAe9p6SIP+OIHTPpGhYQLTjeULJ0jcu9sx0oTL1fDsJBTfHV2bNJgyp?=
 =?us-ascii?Q?3z/vXFWLdWrV5we99kOynKHOjNQarx8W1AK941ThAgiHTJy4+n3qx0pxY58g?=
 =?us-ascii?Q?BHbrSp/O4qtzjLVJ14ZW3BJF/WCytB1Uazd0SgJxZ30MsPDy/ftR2y2pEx17?=
 =?us-ascii?Q?eRIlMPlxYI6oqaoEpQVwLxWDbukdUYWNs/rMA8oPzK4Y6ZjJbncOSzDiLbJn?=
 =?us-ascii?Q?jxA+uTVXpxna10Bi3DVc/0kwyd3P0SQZGeEGkz98jBy1m8DLWhS3ZtTij7Er?=
 =?us-ascii?Q?lIsCVhs0p5tYhHwKV10ziXhrwMY2LpfwDSvOndwexoUbcDJ+sMg2Q8u675R1?=
 =?us-ascii?Q?C4rPIKWdVe9OLHZnqL1+RZ20rHqZ3N418tioKvnCrJUyMWrCOqmpQejwm7Lf?=
 =?us-ascii?Q?TMVugJcxASvKV2dUw6swWxH/oWKj+y6Aa4UQnnpVjfy1DlCn2L4NB1V/boM7?=
 =?us-ascii?Q?13SWKAVC6GQ0CcoNkuZGhAE=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d744c161-387d-49df-8d98-08da9bcaeaff
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 12:15:05.5755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hENmIHWGLvTMnkOupFmiPL1mHcRX/uLF5VxLZZXoJ8sMQlCCnBCWQeqBwDv7P4GUGcgdcivntV2Vj0I5VOZmNckssVqSzEwIzTFshTyys44=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0100
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

+Greg, to get an opinion on the fixes tag.

On Tue, Sep 20, 2022 at 11:22:27AM +0200, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Remove spurious debounce property from linux,extcon-usb-gpio.
> 
> Note that debouncing is hard-coded to 20 ms (USB_GPIO_DEBOUNCE_MS
> define).
> 
> Fixes: 0ef1969ea569 ("ARM: dts: imx7-colibri: move aliases, chosen, extcon and gpio-keys")
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Hello all,
we did have some (internal) discussion if this patch should have the
fixes tag or not.

I do personally think it should not have it and should not be backported
to stable tree, since this is not fixing a real bug, it's just a
cleanup.

On the other hand the original patch was not correct, and this change is
making it right.

What is the general opinion on this topic? What do the stable kernel
maintainers would expect?

Documentation/process/stable-kernel-rules.rst is about rules for
backporting, it does not really talk about the fixes tag, but today this
is used to decide if a patch should be backported or not.

Francesco

