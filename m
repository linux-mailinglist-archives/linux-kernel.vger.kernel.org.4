Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60DDF66728E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 13:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjALMtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 07:49:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbjALMs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 07:48:27 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A973BB;
        Thu, 12 Jan 2023 04:48:24 -0800 (PST)
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30CCBJWY012092;
        Thu, 12 Jan 2023 12:47:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pps0720; bh=L8iC2zg9+OngFwlLIH8ppqMlPM8sWWaK/+EsT/9njpw=;
 b=edENNV/ObMhZV7S3gf2svLiO+obFY0yl78pZ9n0Yqus2vsfPL4GaqZo5tLqRruBPPFb0
 iUf9BmyKoo5xItimYf/7oDijpA0d2Q6mX2TA4i8g2NG1tWEWCrVdE7MO+lt8iSENtbG6
 Z4cmgICxOR81RGtiPhdTW/7C2MB48PqcdsA6Qua07GoL1faeS43dNpKAxThAkq5zMooY
 gGUtEu+H058Hrbt3WCtIHwlyle9pnMFRjpMWIdKNjWDGfY9DEPfrjvDVMcwhdSPJ7GJB
 Q6IRV0rJqcm2iuAdTq6t1cJghwtrSkNmO3O+OutREjRcNBn9zWkvXox8tQZRkX/IZp++ Kw== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3n2hn00fac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 12:47:18 +0000
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 0C6248085F4;
        Thu, 12 Jan 2023 12:47:16 +0000 (UTC)
Received: from p1wg14924.americas.hpqcorp.net (10.119.18.113) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 12 Jan 2023 00:47:10 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Thu, 12 Jan 2023 00:47:10 -1200
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 12 Jan 2023 00:46:54 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hl25vHYykf+HweAiPtwiefyapP3BGtjJyS4wp2zqGFSuru83K5ygQ2EBSx33CfaQla3lpcD83aJM0hN3EPkwVoYygBDOhjbtLL3Je6j8uiU0HfSmLUmx2GoM4bkstaLa8lM1z0CtX/JnlwsZw3ce24Lz9tWO9/6k8kbu2djYcNUztmPQsHA+5h1BqXRsu00cDiil9JWOFDPVS7xO7HF1VGF2M9d9kEzZ7ZnJv/MRWQ83mFnK0EWUvB6UzK5baYbvaWBb8FdrZLZ/n13lBO4jHzKQrKlJrrH+truoYNJOZ3b2/+5UvS0j2tsEhY0JAqfNcpU5AzkrZEagQbT+Kf7g5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8iC2zg9+OngFwlLIH8ppqMlPM8sWWaK/+EsT/9njpw=;
 b=K79ArfuMK5TBoCzpaeXkmJ0JU9dO/dY1Z/DESe839VyGaB2MYP/Udx7t5vsqyxtY2LsdZ4p4JhG8QRJT1RcllIXIA4xUXBTTJbuz8mgAzPvCiCYxh97pIK0mL1z924Awsf4ABbwt7rgseYQj4BSSEygkQ6HzRDskWWa96zQrYN45Dr2QC6GoZ/Ma2esATjlEOJQWRKXZmBNsgbD0BFu0m1EPHolw8g3vf6R+pxMWDJWFqNujoyo5TOhA1GWOZlbgSYzoaEwQW+sSOIdzQH+zRBzkeIv8h417Dru1gu+BDgAvXobVMmPWCPglPa8pNXte0Xysppe8LGrOxeP4C47lGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH0PR84MB1480.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:173::21)
 by SJ0PR84MB1673.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:430::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Thu, 12 Jan
 2023 12:46:52 +0000
Received: from PH0PR84MB1480.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::337:c28a:4e41:d735]) by PH0PR84MB1480.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::337:c28a:4e41:d735%7]) with mapi id 15.20.5986.018; Thu, 12 Jan 2023
 12:46:52 +0000
Date:   Thu, 12 Jan 2023 20:46:43 +0800
From:   Clay Chang <clayc@hpe.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <soc@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <verdun@hpe.com>,
        <nick.hawkins@hpe.com>, <arnd@arndb.de>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux@armlinux.org.uk>,
        <olof@lixom.net>
Subject: Re: [PATCH 1/5] soc: hpe: Add GXP SROM Control Register Driver
Message-ID: <Y8ABM1XNcyeSh7iZ@enigma.ccjz.io>
References: <20230110042533.12894-1-clayc@hpe.com>
 <20230110042533.12894-2-clayc@hpe.com>
 <34191e6f-9a00-114e-4fd8-15ccaec3535b@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34191e6f-9a00-114e-4fd8-15ccaec3535b@linaro.org>
X-ClientProxiedBy: TY2PR0101CA0009.apcprd01.prod.exchangelabs.com
 (2603:1096:404:92::21) To PH0PR84MB1480.NAMPRD84.PROD.OUTLOOK.COM
 (2603:10b6:510:173::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR84MB1480:EE_|SJ0PR84MB1673:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b1d49ea-dc14-42fa-9736-08daf49b13cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RGw3s07wi0oxFFSLxTRmQOe+0R7GwKZWrlA61JV/3jnJmmbTdj3iGuX7Yr6qQ9kjMa2dvLw5dTT7qoa87rtLCD3HvRNiOlr/gxM+SmUCbGF5QIk6IPG5u5wzcV6PO8qngK07hTl+7E4p38+xbhvszXMQYewBPRWcVae98qSa6pqRN4VQ8JGCd6CEZN0usqzsYzTQBB95PJOGmhtlX8YaYQcT0lTu3RqrG6KGJwy3+wEiujiM/bZzXfyHKGkCcHRORLcplC0l8Lr6nhp7Nfy467X+n/Wt7EeP0UPakztUWNzUSqULgOCfwsSMBB87gcpVmBuOuGsTD3SpExCU4+VMkJ3GwDUI5CQ9Go0mtCv/wY5LXN53k/otsVHEk7DDXTbLwLv24oDoggAv+J8dzfxVfPz35iSQH5qReoNTErs2812gBEG2gj3hKUrB8V6L5z4mfUpmNtmyRdsJZmwlxXuVumVuldHzrtBIwZ5W1cK0Sy/iexASoxwRfI37M7biL/e26bOuDr9TaVRXzKkxXNa3oQGePUr5yAW6j/ehdp78JABayfudkXD9S2CQY11/IW15+82F0BCtfK1e2+O/lfmZbYENF+USUtOSjT1N4ASESmwfS4uwNS+kH1OqYnKXdcVdvwkUaEQGEX6fuxSuTtnzdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR84MB1480.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(39860400002)(396003)(366004)(346002)(451199015)(82960400001)(38100700002)(83380400001)(86362001)(41300700001)(6916009)(66556008)(4326008)(8676002)(66476007)(316002)(66946007)(2906002)(8936002)(5660300002)(7416002)(9686003)(6512007)(186003)(6486002)(478600001)(53546011)(6666004)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VbwxreAm3HmdyB/US3dpLJmJDg/jdbN2hCPAHXdw8S79HM2XliW77W/nnwGD?=
 =?us-ascii?Q?sPrEjlMcpzTYixO8pQ3lHC1YRgm2n2tf+ALdb/0fzaM+gt02tmZLyK5hsF3i?=
 =?us-ascii?Q?bkf7ToTddvyD904wqY11IcbstXQL/z7TldTbm0Vj/Wytr/JVHY+GWrOD+qQ7?=
 =?us-ascii?Q?xb3zDz8ntmMm97hYseDs3kHg725buHUlcs6Hg/R25WqA5de/VCxoY396T9Sz?=
 =?us-ascii?Q?SN+WGr94i2G7FLzESP8Z5P5If1h8xZoW3TJD0+f+KhyUemb6cunRFAVMAI/O?=
 =?us-ascii?Q?0E2+EBw4Q/aw27QfQ9wo/trzREC1dKzLUvvmmKJeAyWKYntis2tTKkzTPooH?=
 =?us-ascii?Q?swXegdA5+bNqC1Zgf0KYmM9xWLUzEOgbKHGo89AitA5qcc09yzF6C07VeHph?=
 =?us-ascii?Q?/WoLdGmPLOSkUWBYgBc4SuacOx4jeQlpmBLaHbg5ibVpUSOh2TMn1jVyCprU?=
 =?us-ascii?Q?miP/CovaHnVBVUPtqQUSabJAfC6iy5+20NLDLuz4+sDAwqJMz0QY1V9KB2fS?=
 =?us-ascii?Q?RmrvHI6WltrhKbEHB/FNno4kyKF5TmmJkRLEduI15JlujbPJ80Jqzuusywaf?=
 =?us-ascii?Q?Et8lMpAT05G2v4++YGiyHXTc3hzOjbe2cjtB4GB+NvtArYXwdshpeza41Mvc?=
 =?us-ascii?Q?1R25/4SpQqJb7wtRV5DrtFss58HGz6LRrAChZf8xCRst2ZzWrlivUhapA6nK?=
 =?us-ascii?Q?cgBOtQ+6REXVQUGlczw7LcysijK3u1OlYQfbZw3mqXgtCf9miVrO/Msw8u+W?=
 =?us-ascii?Q?J7YN+cthj3PgAxCws+fCF/Fe0ElieMVnfjw+2sAbmsDWJkaSKY+LH1SuvFKh?=
 =?us-ascii?Q?EOi+8TPhw3T7FpJVP4irRVxB1IZJ6++lGR5f4/VRtsVoZXjw06cfo0S8z3Jn?=
 =?us-ascii?Q?AakNtuwNeN+v3PNPjFvf32fbj2Lg0kLD2s7XJWgYJLuW2923B6GZZ7aoswfR?=
 =?us-ascii?Q?H4hGYWbkpDUgblX87m/ZCM7q3UuHARX9WtZPa58mLc343HFvGURZYnQXMzZI?=
 =?us-ascii?Q?p4MiAzeU3bjY6zRk5IrKx/35aA0RGtH6fHkDGXmw8QSrOQzN4GnlfTiiDqIq?=
 =?us-ascii?Q?Y1YBlJkwvbgeUO4Jq56+feXPij0wr4tHjK+zEsdGKwvGjHOQa9fv4XSnFIsH?=
 =?us-ascii?Q?AvVpsp8+PunsdhbkxuOVAFiKIKfi9N7h/2u6xmgh1q/eRGkY/stcnbATiWXj?=
 =?us-ascii?Q?rI4+SzU0Vg8vccGEGdCAJbdS/+54ZCYkDWClYRg8XbT35R3ypu2Oh6SlpomQ?=
 =?us-ascii?Q?pryC7XgyHIZrc1ow0Obq1pzkFBKjiyPq38OUIuvRUekOLtrgj4s3j2c6nJnc?=
 =?us-ascii?Q?WmIepCb96HqQCkROufrRFTvg0TnW3Ol3rbytcZoQdX4I0VqGu9NbMdgilQJw?=
 =?us-ascii?Q?LWjqM7KBSqO72ZpLDvO6IT+YBFdWF0JUB2cSwHBcUGCqlmcHoKHM3K0T2xQU?=
 =?us-ascii?Q?gIcP2XzG4AklQ095zHBHXJD7dX/ZTDssPls0+XMo1gYz0EmNnnt3oL0hQO8c?=
 =?us-ascii?Q?rLBr8myHqIVHyMUxnEaYJLr8JFfGF36X2D6rHpnOg/8zNyFPJ8lOJrfg34K9?=
 =?us-ascii?Q?QYixdh1jhdTcsjtbKN+R6JkaGcUkdWz7T5P2HS68ZedM8BPi0Hdu0OkO9unR?=
 =?us-ascii?Q?Mw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b1d49ea-dc14-42fa-9736-08daf49b13cc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR84MB1480.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 12:46:51.8521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +noYIk4YiVVIJHeqv8HyXBiRSw2nW46YBF8txDKK6ycPWIvI6/88q6aLXmL5t+iJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR84MB1673
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: 1-5fxM5HL8t_bgtPDXp_1CO-yqrr3xDm
X-Proofpoint-ORIG-GUID: 1-5fxM5HL8t_bgtPDXp_1CO-yqrr3xDm
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-12_07,2023-01-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 mlxscore=0
 malwarescore=0 clxscore=1011 adultscore=0 impostorscore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301120091
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thank you for the time to review my code.

On Tue, Jan 10, 2023 at 10:46:57AM +0100, Krzysztof Kozlowski wrote:
> On 10/01/2023 05:25, clayc@hpe.com wrote:
> > From: Clay Chang <clayc@hpe.com>
> > 
> > The GXP SROM control register can be used to configure LPC related
> > legacy I/O registers. Currently only the SROM RAM Offset Register
> > (vromoff) is exported.
> > 
> > The GXP SOCLIB is a common library used for creating the common
> > "soc" class in the kernel.
> > 
> > Signed-off-by: Clay Chang <clayc@hpe.com>
> > ---
> >  drivers/soc/Kconfig          |   1 +
> >  drivers/soc/Makefile         |   1 +
> >  drivers/soc/hpe/Kconfig      |  29 +++++++
> >  drivers/soc/hpe/Makefile     |   2 +
> >  drivers/soc/hpe/gxp-soclib.c |  17 +++++
> >  drivers/soc/hpe/gxp-soclib.h |   9 +++
> >  drivers/soc/hpe/gxp-srom.c   | 141 +++++++++++++++++++++++++++++++++++
> >  7 files changed, 200 insertions(+)
> >  create mode 100644 drivers/soc/hpe/Kconfig
> >  create mode 100644 drivers/soc/hpe/Makefile
> >  create mode 100644 drivers/soc/hpe/gxp-soclib.c
> >  create mode 100644 drivers/soc/hpe/gxp-soclib.h
> >  create mode 100644 drivers/soc/hpe/gxp-srom.c
> > 
> > diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
> > index 5dbb09f843f7..faff0f036b61 100644
> > --- a/drivers/soc/Kconfig
> > +++ b/drivers/soc/Kconfig
> > @@ -10,6 +10,7 @@ source "drivers/soc/bcm/Kconfig"
> >  source "drivers/soc/canaan/Kconfig"
> >  source "drivers/soc/fsl/Kconfig"
> >  source "drivers/soc/fujitsu/Kconfig"
> > +source "drivers/soc/hpe/Kconfig"
> >  source "drivers/soc/imx/Kconfig"
> >  source "drivers/soc/ixp4xx/Kconfig"
> >  source "drivers/soc/litex/Kconfig"
> > diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
> > index fff513bd522d..d257b9d654b3 100644
> > --- a/drivers/soc/Makefile
> > +++ b/drivers/soc/Makefile
> > @@ -14,6 +14,7 @@ obj-$(CONFIG_MACH_DOVE)		+= dove/
> >  obj-y				+= fsl/
> >  obj-y				+= fujitsu/
> >  obj-$(CONFIG_ARCH_GEMINI)	+= gemini/
> > +obj-$(CONFIG_ARCH_HPE)		+= hpe/
> >  obj-y				+= imx/
> >  obj-y				+= ixp4xx/
> >  obj-$(CONFIG_SOC_XWAY)		+= lantiq/
> > diff --git a/drivers/soc/hpe/Kconfig b/drivers/soc/hpe/Kconfig
> > new file mode 100644
> > index 000000000000..88f5d46b06b6
> > --- /dev/null
> > +++ b/drivers/soc/hpe/Kconfig
> > @@ -0,0 +1,29 @@
> > +#
> > +# HPE GXP SoC drivers
> > +#
> > +menu "HPE GXP SoC drivers"
> > +	depends on ARCH_HPE || COMPILE_TEST
> > +
> > +config HPE_GXP_SOCLIB
> > +	bool "GXP Common SoC Library"
> > +	default y
> > +	depends on ARCH_HPE_GXP || COMPILE_TEST
> > +	help
> > +	  This is for the common library for all HPE SoC drivers. It
> > +	  creates the root soc class (/sys/class/soc) for all GXP SoC
> > +	  drivers. It must be yes if any one of the GXP SoC drivers were
> > +	  added, so the config of all GXP SoC drivers must select this.
> 
> Don't open-code Kconfig dependencies in free-form text. IOW, drop last
> sentence.

Understood, I will correct this part in the next revision.

> 
> > +
> > +
> > +config HPE_GXP_SROM
> > +	bool "GXP SROM Configuration Driver"
> > +	default y
> > +	depends on ARCH_HPE_GXP || COMPILE_TEST
> > +	select HPE_GXP_SOCLIB
> > +	help
> > +	  Say yes here to add support for SROM Configuration. The GXP SROM
> > +	  control register can be used to configure LPC related legacy I/O
> > +	  registers. Currently only the SROM RAM Offset Register (vromoff)
> > +	  is exported.
> > +
> > +endmenu
> > diff --git a/drivers/soc/hpe/Makefile b/drivers/soc/hpe/Makefile
> > new file mode 100644
> > index 000000000000..78de24ecb606
> > --- /dev/null
> > +++ b/drivers/soc/hpe/Makefile
> > @@ -0,0 +1,2 @@
> > +obj-$(CONFIG_HPE_GXP_SOCLIB) += gxp-soclib.o
> > +obj-$(CONFIG_HPE_GXP_SROM) += gxp-srom.o
> > diff --git a/drivers/soc/hpe/gxp-soclib.c b/drivers/soc/hpe/gxp-soclib.c
> > new file mode 100644
> > index 000000000000..11b0afe09070
> > --- /dev/null
> > +++ b/drivers/soc/hpe/gxp-soclib.c
> > @@ -0,0 +1,17 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/* Copyright (C) 2023 Hewlett Packard Enteprise Development Company, L.P. */
> > +
> > +#include <linux/device.h>
> > +#include <linux/module.h>
> > +
> > +struct class *soc_class;
> > +
> > +static int __init gxp_soclib_init(void)
> > +{
> > +	soc_class = class_create(THIS_MODULE, "soc");
> > +	if (IS_ERR(soc_class))
> > +		return PTR_ERR(soc_class);
> > +	return 0;
> > +}
> > +
> > +module_init(gxp_soclib_init);
> 
> I don't see a point of making it a shared object and a "kernel library".
> Module inits are not libraries. Drop entire file.

Sure, I will re-write this part in the next revision.

> 
> > diff --git a/drivers/soc/hpe/gxp-soclib.h b/drivers/soc/hpe/gxp-soclib.h
> > new file mode 100644
> > index 000000000000..eb0e72b67aee
> > --- /dev/null
> > +++ b/drivers/soc/hpe/gxp-soclib.h
> > @@ -0,0 +1,9 @@
> 
> 
> > +
> > +static int sysfs_register(struct device *parent,
> > +			  struct gxp_srom_drvdata *drvdata)
> > +{
> > +	struct device *dev;
> > +
> > +	dev = device_create_with_groups(soc_class, parent, 0,
> > +					drvdata, srom_groups, "srom");
> > +	if (IS_ERR(dev))
> > +		return PTR_ERR(dev);
> > +	drvdata->dev = dev;
> > +	return 0;
> > +}
> > +
> > +static int gxp_srom_probe(struct platform_device *pdev)
> > +{
> > +	struct gxp_srom_drvdata *drvdata;
> > +	struct resource *res;
> > +	int ret;
> > +
> > +	drvdata = devm_kzalloc(&pdev->dev, sizeof(struct gxp_srom_drvdata),
> 
> sizeof(*)

Ok, I will correct this in the next.

> 
> > +				GFP_KERNEL);
> > +	if (!drvdata)
> > +		return -ENOMEM;
> > +
> > +	drvdata->pdev = pdev;
> > +	platform_set_drvdata(pdev, drvdata);
> > +
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	if (!res) {
> > +		dev_err(&pdev->dev, "no srom resource defined\n");
> > +		ret = -ENODEV;
> > +		goto out;
> > +	}
> > +
> > +	drvdata->base = devm_ioremap_resource(&pdev->dev, res);
> 
> Combine these two. There is a helper for this.
> 

Sure, I will combine these two with devm_platform_ioremap_resource.

> > +	if (IS_ERR(drvdata->base)) {
> > +		dev_err(&pdev->dev, "ioremap_resource error\n");
> > +		ret = PTR_ERR(drvdata->base);
> 
> return dev_err_probe().
> > +		goto ioremap_err;
> > +	}
> > +
> > +	mutex_init(&drvdata->mutex);
> > +
> > +	ret = sysfs_register(&pdev->dev, drvdata);
> 
> Missing ABI documentation.

Ok, I will provide with the proper ABI documentation in the next revision.

> 
> > +	if (ret != 0) {
> > +		dev_err(&pdev->dev, "sysfs error\n");
> 
> return dev_err_probe

Ok, will correct this in the next.

> 
> > +		goto sysfs_err;
> > +	}
> > +
> > +	dev_info(&pdev->dev, "initialized\n");
> 
> Drop silly probe successes.

Sure, will drop this in the next revision.

> 
> > +	return 0;
> > +
> > +sysfs_err:
> > +ioremap_err:
> > +	platform_set_drvdata(pdev, NULL);
> > +out:
> > +	if (drvdata)
> > +		devm_kfree(&pdev->dev, (void *)drvdata);
> 
> 1. Why? if it is here, it must be in remove() callback. If it is invalid
> (because it is really not correct) for remove(), it cannot be here, right?
> 2. Why cast?

Ok, sorry for my mis-understanding about the error handling path in
device probing. I will re-write this part in the next revision.

> 
> > +	return ret;
> > +}
> > +
> > +static const struct of_device_id gxp_srom_of_match[] = {
> > +	{ .compatible = "hpe,gxp-srom" },
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(of, gxp_srom_of_match);
> > +
> > +static struct platform_driver gxp_srom_driver = {
> > +	.probe = gxp_srom_probe,
> > +	.driver = {
> > +		.name = "gxp-srom",
> > +		.of_match_table = of_match_ptr(gxp_srom_of_match),
> 
> That will cause a warning. Drop of_match_ptr.

Got it!

> 
> > +	},
> > +};
> > +module_platform_driver(gxp_srom_driver);
> > +
> > +MODULE_AUTHOR("Clay Chang <clayc@hpe.com>");
> > +MODULE_DESCRIPTION("HPE GXP SROM Configuration Driver");
> > +MODULE_LICENSE("GPL");
> 
> Best regards,
> Krzysztof
> 

Thanks,
Clay
