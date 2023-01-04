Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6710165DCC2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 20:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240033AbjADTam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 14:30:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240105AbjADTaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 14:30:23 -0500
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2061.outbound.protection.outlook.com [40.107.249.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30E33D1C4;
        Wed,  4 Jan 2023 11:30:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iQJOg90xHFMpVf/zu0YUU7QgRjfraHNqkvDOo1iylljsMkBnle42cf6BxEQPnlJpoRjjgHeTG42W5d3wM9WkJUwW9ujX9P2JqjRaSYg+Ee5HPerCzfF0vFWNppKjH85/vyBbLDdU9NlhEqBZ6xsyXoVlj7X18wCqUv9YwcZCHArwMFIWTyLeTT7BMSZf2/gUh8F3fAHQCYnS8mHUdJHA3gaqn8LGKpi53XJOqXWLky7DWWF/cr7JKABL9BS4d8sxS2vcHPbQUjDS9NkZFrcphwpoaUftTQG+KXcVZNwePWGoPyubq+7Fc2v1R7WG8vLOio7ebZHXQBaGJy908M/OeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hs/se2CgbcGh5fr2MsI1oylaaFViucQLFQGUsq1Gwsc=;
 b=XkqvOLbhmhVpHdCN/2/7+zHAbE8A29UFmj0AnRLH8YDBSO/7kHfPP3areqC+ngsO/MWjozYTl/fwxpsSfkaiRCR0JDKVeZj20J+coV3ldfQSn4tUPQWxILXhOXgDk/ItFcKqWIdGN23UyAOaA5jurJab7jiW9VlrkP9cDbU4J2t/ccbUWLahgCSrGPfQ9efA9PUJcH8Q2YjYQRpWpf0DbRkXVv176aTCPG7SAuKF4b0FaWa+Euu+FETCukLWwRIk0H49Ha1f6HrRLC/65MFNuwGWnmPIYqYn0X1QTMvN2HG/RhgneLzzmNrQhOaaire34loS4JPskkrOAq6F7h4JgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hs/se2CgbcGh5fr2MsI1oylaaFViucQLFQGUsq1Gwsc=;
 b=gNdorgqW8mb3rN5U8dZrE4zMlh+LLIRKnK5RCDNzNfa+Tfnl+xMUpyGo6L2Votg0YdtmT43HAMVSj/I2kxJ84HwApaC4yb9ILyVfWnGszHHcDf3sSwg3vih6Cr0khY7kCl1prCTDo4Gx1cccM7JckAgEtacW6SXwQWfHpF3B8Ls0Dcru2xWRwHpI1EWV1rVpEZGjE1MzTdwskzyBoZw3xPEp8+bcQfqF5HbmTp5OfMAzgck2aTOfgrlttp/SukJRxLA82E2KHDaPIHUsCS52/FKwEEkYreywhvnuVDmYqBlBqe/SgizI4azNCRRw05IHQC2RZCK7RciolQb5hOsNtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by DU0PR10MB5312.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:34f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 19:30:16 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bdf0:fdeb:f955:bc79]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bdf0:fdeb:f955:bc79%3]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 19:30:16 +0000
Date:   Wed, 4 Jan 2023 20:30:05 +0100
From:   Henning Schild <henning.schild@siemens.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Lee Jones <lee@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] leds: simatic-ipc-leds-gpio: make sure we have the
 GPIO providing driver
Message-ID: <20230104203005.5654f3bc@md1za8fc.ad001.siemens.net>
In-Reply-To: <Y7WghcaWPpCHh6Wz@smile.fi.intel.com>
References: <20221007153323.1326-1-henning.schild@siemens.com>
        <Y6WX1Y9GZmvxqlCc@google.com>
        <20230102162227.523d2a73@md1za8fc.ad001.siemens.net>
        <20230103212059.5c80fecb@md1za8fc.ad001.siemens.net>
        <Y7WMHl1Mv1alXadG@google.com>
        <20230104153924.0b92c52c@md1za8fc.ad001.siemens.net>
        <Y7WghcaWPpCHh6Wz@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.35; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR07CA0035.namprd07.prod.outlook.com
 (2603:10b6:610:20::48) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5780:EE_|DU0PR10MB5312:EE_
X-MS-Office365-Filtering-Correlation-Id: b99b9be9-2b57-4ceb-2ef9-08daee8a1b3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uo11sWuEnEIrDGeUTiHGFVu/uvmSyz3VhgSaogN7BGdxD4aLBw3wsKKmYFKoZOxAOj7DI1JyvD4BQF7Q6cBq57YDxgeAZ84ayxp0vTN/m2Y73cenYnGFN3dCpGdbAGbGeFr6/p4G8zbTO36WwU4AGo0SHlMcGF5x14IUDt71iSCUzXrdLMl4UQZeKKzDqT/npdXfiLWUZRVNsXhDE0zMyZl7U13QBhcxR7BPDS+U9PsOcsDBqqcKwRE01mtT6lwNwYS+GuIiCN2BMLXOBtNxTygGqZV+Wwn6cWYEb/+qSILo5hTMUzvsoKT8VocFWUdMZkWEnawR2vYCyXbcFxBcLXb5beMG0NsjQBRRnWmofDvJHD/3qxGWrWoAgse/fcgCtF1tt1SGZ5guj+irbvR51jopeab6JgFRyZpNSK2FyNrxyXre+2fBnGLHnqPACtdblg1y5qyv0dritADu/n7hQaI9Llgb2Xx/ul7pqPyQM9HBvxb0nejTs8EY9XnyTOPdt/1XkYXuZtXQKtHMfiXGI5SK5/e+MKbQgOxxGX2TipKtrOEcsV02fpdAv6qxdLyx0wzK3Clm8s0veUK/dxRhQ3AbWeNWw+XB5gSzjP/uFEnV/6neoVHTRHVtT92ndLjlapEUK090n9kkHjxxSluCoDjEUK01gBX7BS/TKuTHWqo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(376002)(136003)(346002)(396003)(451199015)(8676002)(66556008)(66946007)(4326008)(1076003)(66476007)(41300700001)(316002)(54906003)(6916009)(38100700002)(82960400001)(2906002)(86362001)(5660300002)(44832011)(6486002)(83380400001)(8936002)(6506007)(478600001)(186003)(6512007)(9686003)(6666004)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ms6YTrLwKNMuV4X0gkS3oDq4HjBLQZOlObcXtpZ66aVexrOTikAi4ZfhGeUk?=
 =?us-ascii?Q?aoWiXL2345bJG0hBpKWD/HxjYxznWKE46SK4z/YiQx2vH6YdXkZwdNqFmUVM?=
 =?us-ascii?Q?AUyGKnwMlnRR32Y820s79p3NPBydAhpwzSs70uDzpZWAxgS4fmTII3hpFGqT?=
 =?us-ascii?Q?5+FYO8VCC1KAzY9iVnuem4UYYOMV6l8gMUdbkEFteHHkiHxl2AMuupRKC+Oz?=
 =?us-ascii?Q?twcHKXdtPNYOppr6OZ3d6dk17TPNMhw1A7o5dFWyZoi1TaUfsbj+/UWqa3ix?=
 =?us-ascii?Q?cZecClmFCuzjFgwgxqEvKC9AH7b+nZ6E5ASUjohW2gWzqfigKJt0wsdqhN1x?=
 =?us-ascii?Q?aGGBI9tDxidYxrwkIogm59btniDMm4kDuubH6IDf38g/L5yLmsR0L97Z4hMR?=
 =?us-ascii?Q?2YtYloijyNaiOITQ/7a04+lSrL8IDoGn+wvsAgtDOOu56fTZ5vxf+IrxUlri?=
 =?us-ascii?Q?stcK4ff4prtMaVWsT84gtxiSR5IQd3eagx/hOxVphGAAeV0ZxzwpiEez0a4w?=
 =?us-ascii?Q?CrgpsqNCd4AqFM4xq7hqcbj+vHo6MbtNlusa70aNF4VbHZJjSK+4UnfSL+4U?=
 =?us-ascii?Q?1TWWWewcwDHo1cndoGoFT1KCJtcAUt8gWf2FA8Bg26aMtGDuvR8RYifK4UCh?=
 =?us-ascii?Q?0/tbbMovt8J7/bS4WxNdphpLuGgG+r9jD6mdt5qDmpagq5sUPcDXWTIEQJYB?=
 =?us-ascii?Q?uyBSj6t7NBj6Pc0Gw855RMBhUE/PSPpzh/NmXp3Gj/IN3LtosieW4XVAc1gX?=
 =?us-ascii?Q?wIWLs/aVRyM9uigjFH7VvDzDElGUAs5fHAImxapgmfqFD71LJaOYqrCfrLv0?=
 =?us-ascii?Q?rBb1qzMQwuCNMRWvGevLBFQ5f3zqT1kth9DTlXu+kIELopVcO5wLJPhn4DMx?=
 =?us-ascii?Q?Uw0MPTGF2QudscMdwi7ai7LRpLkISsUc4V+s8fFe4Tlhg6TTfhcuWWaftIbY?=
 =?us-ascii?Q?eCByXxwO0nhFnc48bkGOcu6HMWFot4iQSMYMjqmnI5n58mFKv0tBHgMsgwQm?=
 =?us-ascii?Q?Cmi8yWD7kNX8eRhiCsBNqQdoAK4ycT9wOelE/Yn4uahJWzUhudVtnpn9U6sn?=
 =?us-ascii?Q?aPThUf7551hYIcQGCbnYvogWLl49jyp1c/J6gYHxXAF4NRZh864pzfi4zGXh?=
 =?us-ascii?Q?Qcgywx7rg2ES/4C7h0b+Piaj2Tc5Apk62AsyWRitBZEKl5MWBtI2YjTG5S/r?=
 =?us-ascii?Q?k95qaO9WSclMjlRO63DgW9FXeKufhbJP8HbTQy5dsXR/Lhse0kPoNuWL4aKT?=
 =?us-ascii?Q?ADyds2XtyZT5vsb5TzYg7zvJ6E+9pKC9GfsSLXMhDhwJzDz+Nirt9Qj7GxmV?=
 =?us-ascii?Q?G+uZbCdMlDpDmb5MKya+cxlg4iL1XtTFclECM/E35RRGglVVrS1O83JH5u+B?=
 =?us-ascii?Q?tSdrgpNhBxHL0plfdkpMD3J8e9GuZhyFaU69y0KOU10WOZgctIIlGscaVkM8?=
 =?us-ascii?Q?29rMvBk7iQ9Ehjvm9IYEe564CbAumPTYenvjQ0GcEMM8uCmGGyRndBCMi6eR?=
 =?us-ascii?Q?AucnjSoskQROYYBFVmoC+VTAkjgf5X8FXCjs3RifIM8ReEdmXBRDkYJ7aG/D?=
 =?us-ascii?Q?8/Y1c3EKNPIdorWBMLivRFfEjZnbGoogtx0h6eWJAU4kQnJNiTd/niOl0ls5?=
 =?us-ascii?Q?zCa2QfihxTkTo7ClfHXpsLE9rDmPzRmhxHIzOijXwsPThW5/ez1Z1PtKKOs4?=
 =?us-ascii?Q?CQ+29Q=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b99b9be9-2b57-4ceb-2ef9-08daee8a1b3a
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 19:30:15.8865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n3gqCTsaRuCHzwd8Ym0JO+IiSwSSd6xkSypZtUyL9z9GLWr10PcXbHIMq94w8O0Imdvpoi4UAY37bT+lXcjltdgGHEfCKjntIUTdU/evAcg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5312
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Wed, 4 Jan 2023 17:51:33 +0200
schrieb Andy Shevchenko <andriy.shevchenko@linux.intel.com>:

> On Wed, Jan 04, 2023 at 03:39:24PM +0100, Henning Schild wrote:
> > Am Wed, 4 Jan 2023 14:24:30 +0000
> > schrieb Lee Jones <lee@kernel.org>:  
> 
> ...
> 
> > As we speak i already have the third box to eventually support,
> > which will likely be similar but this time around with
> > PINCTRL_ELKHARTLAKE  
> 
> A bit of offtopic here.
> 
> Are you able to get / fix / ... the firmware to work with the
> upstreamed version of pin control driver for Intel Elkhart Lake?
> 
> (I'm asking this in terms of the
> https://bugzilla.kernel.org/show_bug.cgi?id=213365)
> 

I can not tell. At the moment i am in a Siemens internal review where i
see code that is not even close to being ready for upstream. Somewhat
open-coded again from what it looks like.

And i do not have the machine the code is for.

Let me say "it is complicated" but some point in time a device with
LEDs attached to PINCTRL_ELKHARTLAKE will be proposed. Likely by me,
when i hopefully have such a device on my desk.

Henning
