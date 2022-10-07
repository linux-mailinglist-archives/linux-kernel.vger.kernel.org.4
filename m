Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9F15F7AA0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 17:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbiJGPgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 11:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiJGPgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 11:36:13 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70075.outbound.protection.outlook.com [40.107.7.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D564BCB93;
        Fri,  7 Oct 2022 08:36:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IO81BhfNUnQMbThqwyGwlk5o5UBtUfCcNbgq4TLAk093vm2JKt2+FYLqlGXTy9wdrQrGl9A3ivhtqi38+YizPXMUz1SnVQcUDHO8Ep4dD25CFfaiD6+Ad3CCFoF+89m2mbz3kgHkIC0gZkLnPMDUCvJL+RAcgJGhwjE34TzYlr1MA6euibDjsVqnRmVUES+dRcfeq1mwU0AfwvNXmY/0Boq6R5HMScQRP6L2oOLSHyaggithVmeV2wt7WlNLcfdIcMpPF9jPDcGbHhtj72yccVY9DjSxppl/MVw4pF0vMi+6KiSSmIISuqs0Rb0RpdA695F1j26trlBVm8I+byzo5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKQeO4kGYAHZsdOOYzppribBeKQUhkrn3bqaMe0cNIM=;
 b=ayt47weFT5tJ+6xYLAG02ym+xR/2q9o1SNxlqkE4EdrHdGLTfCWV2NOescqmZcO+8crF0bt0ccZaPKnlG/13tupZVxLXiVdhRJrFSIxJaOhpyecuLnwG4oEXj5zxoJF/g1t0qVydURYIjgM6UsHj7DCPTKI6Pg5rnb3e+Q0LQ61QdWV+ai7CnaPGldUGpLIxxtmIlUA5xHDttklr6/Dn83vMQ+AuJnEsyxjtV6swdJPewAaVjBm5Tit7yfi8fCSHRLtKBZ+nA3gaZc6GtAZA2jL/rtcFC0Yavw3Ag9lzJEayrVmi4bY4xB59yAm0ng9ARXuLycQqffj8vNWzab+fRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKQeO4kGYAHZsdOOYzppribBeKQUhkrn3bqaMe0cNIM=;
 b=c81Dp4GKBxLWuDxa2AR8ngrXbaB1AKB5itkBMpVbqDFP1M8sLSE/ZD9qjN6spK/b1hLyL1RlB789lumDGeyWryogWbO4oS04hYQWBHuGxUIJELqDbb/zFXqneRpwbjMGZsq91g63Eqrfov7C5Xk4B8NaUG0VYdBPMvs2nbbZ4s3z2KMnOO5DgsnmpeAdnbdkQnPh+7eOXuy6H77q76vaUUHDMaSMP8IDDu/zxzbDB/quRFr6oVUMvpkSCyqNiQt2pTuTruC1z3SmjNM7m7cREZe2LvT5GjR+A9ZWwjOyMudxD7xuaUcYlCYWzsSr1hx2NDvrDOPUuGGDQq+rPB7u0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB9PR10MB5762.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2ed::13)
 by AS1PR10MB5554.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:475::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Fri, 7 Oct
 2022 15:36:09 +0000
Received: from DB9PR10MB5762.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c40a:ec9f:8396:f514]) by DB9PR10MB5762.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c40a:ec9f:8396:f514%4]) with mapi id 15.20.5676.031; Fri, 7 Oct 2022
 15:36:09 +0000
Date:   Fri, 7 Oct 2022 17:36:07 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] watchdog: w83627hf_wdt: add bootstatus support
Message-ID: <20221007173607.5c15c18f@md1za8fc.ad001.siemens.net>
In-Reply-To: <20220824152448.7736-1-henning.schild@siemens.com>
References: <20220824152448.7736-1-henning.schild@siemens.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P194CA0009.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:90::22) To DB9PR10MB5762.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:2ed::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB5762:EE_|AS1PR10MB5554:EE_
X-MS-Office365-Filtering-Correlation-Id: 95d1bf3f-2aef-48db-74a8-08daa879a843
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WRxSn4VPTwYf3YIpbiRX2xabfELjgfMlhSNAKqMnId6eJ65dqIwAmc3lKVFGYnB/mkHXkRI+m8vw2H6RG9/PNVXPz6E5w+mGTQk8Q/dN8icde62wXG5wYF6vmeIpIQRv4b80mk8IfF9G4l6eZpmqoRSHpq4gE/be3ZYEZjUMmscd6GqN9u+PrcYfoeFRUm0WWNAnLke36BqLWDCPf587PtIoScC5qTMdBm/8/5zAWwv7EV94TAfgQQNwv6+CFfiven8TO1Hzd6Ah/KdxhCMTxUp8LiLaAEem9RI2nrYeTaYqJmZwah82p0VEbyPFV1iqLDhBh7NtI4DjutOD5e7U5c6d++BXgudE51uXBLgqxFfaCGU747UaoUhjJLpCgZxscvbUEf8+po672KS0ESC7/M8c8Bb52mIBjX5Iiw92W2IscUFF1Su9eoBVjLwLBa1Jj9TFNaZG90k7KABv2rT5bKSUzt5rosvbtpzErt77Z9gPtqh8Rre3IlS/H+vzkhEn0IVAt0T1TKXTn5FTOCyb1cfEfdcgCvBEiOnJXOcAq83CrPZZ52J6tTrPzQ0jCRvtXzy7JRyiEltT8GnMZxNPBNqNJWEFTB8X2n6Q/jNMwVzRPCh5V9PsVyQ2wQr7gF7rNzXU6mPhrvnXqMAgG9NReEUS63beGh8aNDuPXD7+lG44oVs7uWR2ysn/Zl67xtxrrdJNz1ZWCIdYAotpyvraBMT9BnlivC8a6A/pcPmGYSqpoWEEnbGa0nvRTkDamJyb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB5762.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(366004)(346002)(39860400002)(136003)(451199015)(41300700001)(44832011)(5660300002)(2906002)(8936002)(6506007)(186003)(1076003)(316002)(66946007)(66476007)(9686003)(66556008)(8676002)(82960400001)(38100700002)(110136005)(83380400001)(6486002)(26005)(6512007)(478600001)(86362001)(2101003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KybOlkbLEKrL9RR844rKlug0MQL62ORQ+hLCVvUrYrT+1Y/P9F7e0IIZ4hcF?=
 =?us-ascii?Q?rECXQKTuqQk6jBPnVyldy8y49UsVCU7b8FXnlnxBywuiOCV4lY1TW4TNuDbF?=
 =?us-ascii?Q?KFKRqNxr0yELR9OEvi4lTcvbq8i3WHiHbGTg7zRwTeubFDtyvgHMVrvt/UnB?=
 =?us-ascii?Q?mNOyeJ689kY4ONH9QSgj4Iqgtkw6Lp51s7BAJexwtnhQ6Z8qlt0v4pnH45ZE?=
 =?us-ascii?Q?2w28Z5g7qwDsFnIt2IdRfzWcfYB3X9z1rJQmooxC5gvea7+cZIaf06TZdEmE?=
 =?us-ascii?Q?k5o4Uot95InuRTEN1wf/jMJoI7JuP3U0PVEM6x8eEA3SGiA4TDS3bJgyZ7ps?=
 =?us-ascii?Q?FDF0qYLtOmdMgDL3QPt5+3UWzXHQlovMwZSUsqP0kSVN3+T8k+Y9PHqqlWXT?=
 =?us-ascii?Q?DpZaAqqJoDF+1QxAzFPOEmOQUTPVDhYYbpTp5sSLTMlF/nVFs2FQBbQfpsvB?=
 =?us-ascii?Q?wIRcSwR82S3NJ0lP7C4RC2eebc4Dz4Zci3ZNZfxt8Fexo7ztiNA9JUGfW1Zb?=
 =?us-ascii?Q?t831mep72Rv2tGfsRTK+hrkQeq11IJFNo0VFPgMGQ3dmEXWCgF4xC4AsxjpR?=
 =?us-ascii?Q?MilCso8PKxgVq5m3ts0V2TAxE0ygRz6koBanJ16xs56GYKRKYamVVBW/dTQB?=
 =?us-ascii?Q?uV0D9IlJb8H2LCWzjTfBjNbSzIUX8OCb+n5+znPgvsyIhHwTiHHTYBbnM4Ea?=
 =?us-ascii?Q?3dHhhryezeb3OjeykH8MGeKXUtVl20AJiSiApH2QxJ1umlxCaQcyhWULEv01?=
 =?us-ascii?Q?bLlpp8F9jm1X7HB0shNKGid1Fs44omHDVbKdBo9EScV/tcdmnArEeaf9BOpw?=
 =?us-ascii?Q?kZxXQsSPekfwfoX9/j+XG/zYTK+eNBcIZ79iQEF6ZVl9+8UgLihM7gZNBpt5?=
 =?us-ascii?Q?u0gYBXfvKcdtApqWGpwH+6AqppX5ULRmLBNhpkg4Yy+8fZg9y7M4AF10DlFH?=
 =?us-ascii?Q?QXGKMBpO+bmpDPu/iUjeWqFfmjCv/BMy3y1TshwRx/CwRgx6+ci4MGPAvpsh?=
 =?us-ascii?Q?JGwL79gWHj3gmRyYUqQ+u7eWuvmH0jir8mtIDbGJWFPF7w5+dglk9x7IaSji?=
 =?us-ascii?Q?6oIOZhv0iWKfcOdd9q/jxZJ4uNhHZ0YOTkhIH1ZXk7Whb1azBwFT05URoLy1?=
 =?us-ascii?Q?whyXoAYhHnUZAde7/O5F6IPcnnuHN/PfT6gE+Y+p44HSlJqxmq/qiHXmSeag?=
 =?us-ascii?Q?NNk6s/J4XgSWh79Pg6VFYV1/RrDKKqUjNMdrlntEXsO09bbmRBUgHoQz2ik8?=
 =?us-ascii?Q?HXu+kUEX/jxfDwc//VeKW7quM6E+9G4v5klBp5FgpC1iRAb0/ipdbHlSqLMY?=
 =?us-ascii?Q?3OSygA1DyjOu6zp5Uc5xMT55JVf8cJm0jx1ZEIP7wMVTMRkZJ/tDVQI1Ss+r?=
 =?us-ascii?Q?NS9ONXHuvhoH1YlF3lfBd8ADW7p/XX0raReohTU5gsO1PuHp+dH+9g5NhCC8?=
 =?us-ascii?Q?3N6WIRevnejaKLk4Veg1RkiD905pe2j8lB3HaK6dPq97msSz7iX2m4n5lblB?=
 =?us-ascii?Q?X8ekeWKnijMAyZV6jz+iGIt+n67581VFF7Y+edpswyjS2BrAQTI7ltGqljWg?=
 =?us-ascii?Q?QijuxXlgSJzEGQIQKiOSpbSbwjaLKKrtN7ViMYmdcwn/oJzmbRPWac+qBpP3?=
 =?us-ascii?Q?IA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95d1bf3f-2aef-48db-74a8-08daa879a843
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5762.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 15:36:09.4786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V3E2VA6Y5VL5gn+7g7SlUpeQ/B0WGTJ5L/VT3cTMVxBZCTJAJoVdQ5YyEDcydDRGVFEuXKe8XCS77Ha/DoqaBVLfCLft/vlh45eh/JFTeqs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5554
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping.

Henning

Am Wed, 24 Aug 2022 17:24:48 +0200
schrieb Henning Schild <henning.schild@siemens.com>:

> The status bit in the status and control register can tell us whether
> the last reboot was caused by the watchdog. Make sure to take that
> into the bootstatus before clearing it.
> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> ---
>  drivers/watchdog/w83627hf_wdt.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/w83627hf_wdt.c
> b/drivers/watchdog/w83627hf_wdt.c index 56a4a4030ca9..bc33b63c5a5d
> 100644 --- a/drivers/watchdog/w83627hf_wdt.c
> +++ b/drivers/watchdog/w83627hf_wdt.c
> @@ -113,6 +113,10 @@ MODULE_PARM_DESC(early_disable, "Disable
> watchdog at boot time (default=0)"); #define W836X7HF_WDT_CSR
> 0xf7 #define NCT6102D_WDT_CSR	0xf2
>  
> +#define WDT_CSR_STATUS		0x10
> +#define WDT_CSR_KBD		0x40
> +#define WDT_CSR_MOUSE		0x80
> +
>  static void superio_outb(int reg, int val)
>  {
>  	outb(reg, WDT_EFER);
> @@ -244,8 +248,12 @@ static int w83627hf_init(struct watchdog_device
> *wdog, enum chips chip) t = superio_inb(cr_wdt_control) & ~0x0C;
>  	superio_outb(cr_wdt_control, t);
>  
> -	/* reset trigger, disable keyboard & mouse turning off
> watchdog */
> -	t = superio_inb(cr_wdt_csr) & ~0xD0;
> +	t = superio_inb(cr_wdt_csr);
> +	if (t & WDT_CSR_STATUS)
> +		wdog->bootstatus |= WDIOF_CARDRESET;
> +
> +	/* reset status, disable keyboard & mouse turning off
> watchdog */
> +	t &= ~(WDT_CSR_STATUS | WDT_CSR_KBD | WDT_CSR_MOUSE);
>  	superio_outb(cr_wdt_csr, t);
>  
>  	superio_exit();

