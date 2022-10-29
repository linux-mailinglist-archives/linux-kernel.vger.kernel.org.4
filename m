Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD6E611F4C
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 04:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiJ2CZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 22:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiJ2CZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 22:25:17 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2040.outbound.protection.outlook.com [40.92.18.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF2259E9D;
        Fri, 28 Oct 2022 19:25:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F9LmTL1iVR28dDVu76tzFCgpia75arNccfY7xKJCS5tBeHTkVN5jkrx103iNwaTbD+G1Abi2hU3ABGK5MTXU67GDHHSMtotAVdR3suKg8Y3F5z0y+C4xCUXCboqXP98ccMJc6OId0UXE5+6riH9Vqytl1Zkkun5JFERDZHrmVwTaUU0XRFXREU195F7xkgLTPEy312Fxoub9sYrTDkmfbwHc6LBQyagQ7GDkRFdTMVToEn5aeEIveogVvtwxY8VolE4GkNfPCsB6b9c3qEwVgbQcqgiwzFdvLvMffbracC/i+itpnXRvT1Xb4U9r3oPwtJPPLjx86D7QiLbHXggdrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2wm4Kxc9XJTWMnGsOHr1386ThOyCKT2OHdDT2Vzx3MM=;
 b=BIB0CCjURngDIu9pAFQe2uY9X0mwiLUftJQm5EpRFYcqkVtor3NCIQPkZIm4zixGrvqLzXYm/s7eRsddOtNaik3uqTlE5mtnRJFoqc6nS1M0GMmLlik1TkgpEfTGKTW+rmGKhv+2XxmonslL3jy6bo5nMufuWVrA0FxpLNPjnn+v9iBEYuheeyQ0TgC4PRLURlnQgSZA655t4px4pF31HMWYmGjMn7FLkBXMqvH3J59QvBgyTCDKfeJmRqaaGuQQd4VVKFwdsvhMaUg3S7HZz4GD6mZhGs0wQBMBAPU7CRxR40t9FLPcQ7ZiVGTNJzBeqLlZGVZvADCbuNMnVgPRmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wm4Kxc9XJTWMnGsOHr1386ThOyCKT2OHdDT2Vzx3MM=;
 b=NMGuio5OzaM+iLMasb8ptVxK3MT3MpOzLLdqavZd0N2DjG5dwEeyPWxXOmIe3bhxAIaq8qPCIYGNdOhcfWHfsuJ7rtNvTjIX6Dc0m2QwGuT1yiH9adVGYW/GC/DJiCd34zYVRMmvgOoPXJE+J0YTlPrEfJoLUxPNV6w80HRQicPyNsGhA53WBZ1u8boPHTimX0sRb+RX1DyOgCAvcoX/VVcMM6H4P/C18a4HYsWolVk95peuL12flx90XhYh33hvfH6lKjwPyfJk0X0x5ZdHspnO6rk1Jw5iRwX15NT7PyK0IcnrJVpIhCvdJuQiI/+5vO+njU/NqBmrluYIrCZBeQ==
Received: from SN6PR06MB5342.namprd06.prod.outlook.com (2603:10b6:805:f9::31)
 by MW4PR06MB8332.namprd06.prod.outlook.com (2603:10b6:303:12b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.14; Sat, 29 Oct
 2022 02:25:14 +0000
Received: from SN6PR06MB5342.namprd06.prod.outlook.com
 ([fe80::b849:682e:6222:2b2d]) by SN6PR06MB5342.namprd06.prod.outlook.com
 ([fe80::b849:682e:6222:2b2d%5]) with mapi id 15.20.5746.021; Sat, 29 Oct 2022
 02:25:14 +0000
Date:   Fri, 28 Oct 2022 21:25:09 -0500
From:   Chris Morgan <macromorgan@hotmail.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com, kernel-janitors@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maya Matuszczyk <maccraft123mc@gmail.com>
Subject: Re: [PATCH] power: supply: remove less-than-zero comparison of
 unsigned variables
Message-ID: <SN6PR06MB534244907609468217F4AAFBA5359@SN6PR06MB5342.namprd06.prod.outlook.com>
References: <20221004064521.498510-1-usama.anjum@collabora.com>
 <20221029001708.fxu6he7pbv7voiy2@mercury.elektranox.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221029001708.fxu6he7pbv7voiy2@mercury.elektranox.org>
X-TMN:  [f5cgaOjPN0Oyq5uZNUbqiS9tslfHjEjP]
X-ClientProxiedBy: SA9PR13CA0170.namprd13.prod.outlook.com
 (2603:10b6:806:28::25) To SN6PR06MB5342.namprd06.prod.outlook.com
 (2603:10b6:805:f9::31)
X-Microsoft-Original-Message-ID: <20221029022509.GA25353@wintermute.localdomain>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR06MB5342:EE_|MW4PR06MB8332:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bc37ff7-ee2d-4045-8da3-08dab954cf90
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q+gDfMMA3I3ehqJhfeM8i/YlGFa8Jv92565Y51IcI6lY+WlXZ0Jv5Fnk2+iLTZrktwcJ5znZgfR5xk3GlkkoXzXGb1LWxZzeys8kEUq2po22HvhPTGlasI+xni2lepIdtn1GhmULVqdMhrJLbCQLiVQO0HSCbu+CjVfzdL/Jp9sobzxoRxUpOqX4YUD9whUnYT+QpOLshxrmkskcqab0yIc9rSMvL8fIHR/bl/b5ygqxZ6aFW3s9MuJMbn/zuTorh5N0+d48dy7L4BXUQeOFYhKnjofrnfpG/4HYcV38HIWq3vwbadcOPGdIQ+A7OZxGq0MBaOXIDqqKj9UTCVN4ci8+eAX/8ouq6lv8Y7GRWjfHb4zEWgEtRE6Sb7eB81Je5QjhaHiiCWWUaVtHy/7YarSIx3DRiRxXfRmCEvPvdQzuD6mzQSsLOq4JQF2LCwkhzkG1yKmm22ycPn3kw2iWcb0kigjH6O4QJ6X/Q+cWwpc34bykZ9itHDRw5JyrKjH8Pee39308cABqTOxYWX2TDPV4+hwF+t79fTazUsh5YN07DtsBjGLJvQS4ln3y7K4eQbRnPNoEV/3D2vqcQy07UljPnMyKl40QGy6u+Swl9BT6r/U0q1+S3x5xZBP90D7O+A4+GSF2yj/UvNOqytFdErQ/ouv6xE4w8Q5ME4ODfZvMiRtUDbnn1+JX8JmoqR6L
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ik/Q+3Np2+pqoSi3RCJIl+xPp17W++widsf2WwNkG+w3dBGnfkxc+NRdedfy?=
 =?us-ascii?Q?V+xjJEU/bTIlE1S6gNVHoSRzqwHHhpzK3395KsvlI9llUSC+ChhyU5BQ02GC?=
 =?us-ascii?Q?+kae+2jS/mIO12Ptc8dEmnZOpMU52Jr8gLq1XpOQYjvMjhlKZJ+yvAgj0pkP?=
 =?us-ascii?Q?X6hun2QMOFvxskA3GzyBWQPYbvJ1lIGDxfJzB7QJ+4Nga/kFbE8BinlhYVlS?=
 =?us-ascii?Q?asqoiPP5d+ebUa0q6zIm2grJ5L025C2lB/G4bKuGgL9hUrLEIFb9rn3ka+PS?=
 =?us-ascii?Q?sQteQ46ptDkeDLhQytoqEn+NIU3rVbVjJlVFendPwWslxkENdIASzR2Mjtvf?=
 =?us-ascii?Q?Au6TQxDXTCU31FsUO/krz3sYEurXfhnp/75iZYL9eIT0J1jjQE3sURo0HIOV?=
 =?us-ascii?Q?/8xX5obam8G4DFcU31q4wU+NJvdOq/uPTGUO2dCf5CSPTLYhBX6gHAzoe2fL?=
 =?us-ascii?Q?UexX6xRgEqWzJKJCQIIWlMewyMKmD0Y+Sy584oMUI0/4Q1uL8mzWlSwlak9V?=
 =?us-ascii?Q?gNidSgPKqKweHvfwyNlR51iVEA9adqHusH3ASd+w+bgSPLclIV1vbZdcvVeE?=
 =?us-ascii?Q?gukvkZmT2o/SP2Z7WHThWLk2MrEI4BB0u4ItBN7nuyErqC/ZypPovEQk8VzO?=
 =?us-ascii?Q?h5mLc45yqgQBwyWZpf4J4yhMwpLoDtJTv4wb3pwPrhV2brY7FzK9ku69FqMX?=
 =?us-ascii?Q?R9rdJOmHvPIT7pmoJxzx8Z3MMwJG4Up5wjH23YNjRDjqGsX+NamI+egx/fvb?=
 =?us-ascii?Q?CXSScIjdT3wnyFzOPcBYe/WAGZ/V4aCHK2r/5AZMbZOKnqRqiocSX7FTeGSC?=
 =?us-ascii?Q?qKOkAJVluvBn1BEG9+hx6HLcQhR9OMk0wOEqHZc3B13km2XowXMwSXXjh0aT?=
 =?us-ascii?Q?bfoaC8bHqNS0VDK/1qaOFWvoHg2xjEO924fqt6TUOI0otC+gbMmZYfejRH+v?=
 =?us-ascii?Q?z0cPALxvHNE8a9gEgPU7sjeWGQRz7erir8LkJJ4fgZbQgDgI8mggmsNX2fga?=
 =?us-ascii?Q?7J4UBMoFmv+sJSdwz9XReC4w38MCtW/0RIUKSa6lWYOrcLjHuC9nXsiaSveA?=
 =?us-ascii?Q?He/JAHHP9k+hg9dlS3JnaNe1jQYi8sM7JwrtM+AXXHEK2n41bzdVW9+t/lz9?=
 =?us-ascii?Q?gtZAqVlI7s3jQNE7iMZLEs1/B4cieuJPRrYDtTrJIeibSfCXjBkoXtl1/8Z5?=
 =?us-ascii?Q?jOGHuETLH9zDw+xUm9YO0Ctd4quZ85OsDSo8ykdra10lzYWyCKd1cJmFtgoI?=
 =?us-ascii?Q?iFRdOKE4v89WEt8Cop4nTjrCa2W07WsRGd5l4rR6Sg=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-89723.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bc37ff7-ee2d-4045-8da3-08dab954cf90
X-MS-Exchange-CrossTenant-AuthSource: SN6PR06MB5342.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2022 02:25:14.1782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR06MB8332
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 29, 2022 at 02:17:08AM +0200, Sebastian Reichel wrote:
> Hi,
> 
> On Tue, Oct 04, 2022 at 11:45:21AM +0500, Muhammad Usama Anjum wrote:
> > max_chg_vol_reg and max_chg_cur_reg are unsigned variables. The
> > less-than-zero comparison of an unsigned value is never true. Remove
> > these checks.
> > 
> > Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> > ---
> 
> I'm a bit hesitant to apply this. While the analysis is correct
> max_chg_cur_reg is sourced from rk817_chg_cur_to_reg(). That has
> has a 'u8' return value as function signature, but tries to return
> -EINVAL. I think it makes sense to either fix this at the same
> time or change the variable type to signed. Also please Cc the
> driver author (done now).

I think this fixes it, can you confirm?

https://lore.kernel.org/linux-pm/20221019234505.5viojwmk6ksqr4gb@mercury.elektranox.org/

Thank you.

> 
> -- Sebastian
> 
> >  drivers/power/supply/rk817_charger.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/power/supply/rk817_charger.c b/drivers/power/supply/rk817_charger.c
> > index 635f051b0821..aa4b33f1bb83 100644
> > --- a/drivers/power/supply/rk817_charger.c
> > +++ b/drivers/power/supply/rk817_charger.c
> > @@ -951,12 +951,12 @@ static int rk817_battery_init(struct rk817_charger *charger,
> >  
> >  	max_chg_cur_reg = rk817_chg_cur_to_reg(max_chg_cur_ma);
> >  
> > -	if (max_chg_vol_reg < 0 || max_chg_vol_reg > 7) {
> > +	if (max_chg_vol_reg > 7) {
> >  		return dev_err_probe(charger->dev, -EINVAL,
> >  		       "invalid max charger voltage, value %u unsupported\n",
> >  		       max_chg_vol_mv * 1000);
> >  	}
> > -	if (max_chg_cur_reg < 0 || max_chg_cur_reg > 7) {
> > +	if (max_chg_cur_reg > 7) {
> >  		return dev_err_probe(charger->dev, -EINVAL,
> >  		       "invalid max charger current, value %u unsupported\n",
> >  		       max_chg_cur_ma * 1000);
> > -- 
> > 2.30.2
> > 


