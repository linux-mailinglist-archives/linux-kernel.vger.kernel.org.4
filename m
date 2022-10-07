Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB91D5F7B8C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 18:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiJGQeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 12:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiJGQeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 12:34:10 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70081.outbound.protection.outlook.com [40.107.7.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D66273C04;
        Fri,  7 Oct 2022 09:34:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UYJBbrDlifIuRjIVAKG6TR89lu2OvJJgLl0Q1kE/OYRKhU53rrbkNqd4gAvYasmpT3MkWMIRO4e3T6KoIaenDfHHXNZW3j9X6R+PMt8CyzuGLCSd2UWoXoPjxfmcpM+zTQpJyoXe1c4mDeiyYXHBsFpvOEisnpt8GjKhlwCvIBPC4syCPklhwXxZQmEOOtRryzzpavpz5YwK118nerzTcjeKi3rH1+J2wbxA2nTr1nw1OOywVtlamHb13sW5eEi75myKt82yQG5tCQyAztX5JBchiNy9czdG+2B5K+4mLXKlQx0waEbggJwRJgERlsvH7I1MdvTm3kj1PzQh7kc0gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tgBM046byPMhhpY5qNi3Uhu1BwOqsRlU/xLMv3pzs0I=;
 b=SbDSVvty6FRwGw/xUZ8CJkCK3/dhLsckmLbD+D77d3NKziFRVJ4ATh+rViIhmuOZFYfkosIk2Y4cM/ULw62Gr8FGh071FJ96JUq+/FcaGNquBhje7z2qsMHHDXKgI2453VeU9Ij6C9VY6yfm678kbi40IxLY4i4weOG4eP9dZUULuPTUV+0Aw76+djMXK/CM/l9BCfVKxd/TfBd1sG3/M3huoZksh/h4QZGUA+bS9dcUNqZmDCwzzqhycscX2nSfGDO+omGCi/AreTaX996ShGEku+IsLjQVIsHdHXEHpFWl8XvIFVDlkjB6THMw0o5VMaCKPiYds8oYNWakCPqSCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgBM046byPMhhpY5qNi3Uhu1BwOqsRlU/xLMv3pzs0I=;
 b=XerY57LnUhmh4DlMIbppt06pQ8tLFKUkiRb+/JZYo8bj7kt8UvDNc9QtzILSnAamSIaf8lOuxbA7onfgZpyryXDLcD1H3O2xI8j4/UOdoGOk6oytNrrZKb0pAUMxLYajFLr6uiRSABr4NcX1OHNzyXASgjo/HINv7qCA056Qelv91T7SoJksGVkTOy3nt+DEFX7zl3GuYImIA5v+0eF9FUqyYUKIZuouaDl/VyZ3eMorz75N71T+wnYGkUXEUV9Mi81KbVY7MkifxFtKAQbGlDUO/few9EanqmtFRoSvQOsOEgY6jfbbskweLO7xhHlKvmaGT5IptJpCayEoUspNtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by DB8PR10MB3912.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:169::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Fri, 7 Oct
 2022 16:34:06 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1cd8:9066:48b1:b1c2]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1cd8:9066:48b1:b1c2%7]) with mapi id 15.20.5709.015; Fri, 7 Oct 2022
 16:34:06 +0000
Date:   Fri, 7 Oct 2022 18:33:44 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] watchdog: w83627hf_wdt: add bootstatus support
Message-ID: <20221007183344.3c5be2fd@md1za8fc.ad001.siemens.net>
In-Reply-To: <5262ef1c-ca81-f25e-e072-d39e9f5c9e53@roeck-us.net>
References: <20220824152448.7736-1-henning.schild@siemens.com>
        <20221007173607.5c15c18f@md1za8fc.ad001.siemens.net>
        <5262ef1c-ca81-f25e-e072-d39e9f5c9e53@roeck-us.net>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0098.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::14) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5780:EE_|DB8PR10MB3912:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aa84620-68f0-4b24-03a4-08daa881c07e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wFMgpF0InTGEzXQ+BFv0eETwLEEX0Owm16yA1gox3wQXRt136EOl9JYEF5QGB6VuRn5e9JSh4xZ2G4jM2vTdaSGz6XNZ7zlEoWeLr02pUlsAl3jLN7ezDg+jjXoMeuUTPhEGVPWi12p3uFH6HnRBIuFKF+6/d/k5H2rG71UTCfYwcs2TMF/0O8D+9TqSB+zZ6wC54ZS72qJKRi6v4+hEbWXohE4pW8mH7jTuQW0DW6uSGFLerMnv3syyrYaGwiKU954j6v0b5Ls5sE2hNXVUIiEr33HiWUvLg4kLDGs8LrJv/r6uCPaKFnzlCN3QiYUPhg+IVFbAk2ewy0Kwu3EbmHXX4o9aznT+7QasVi9Rpus6gLsyWGzlzLdmhQKmZCa868EW21MLy1wd372c5TeUJtq6tlC3397objHJ2F9KiqcOWTFRpSxINzyi5UXF2RvNorPqhzl87atPASdwmiSUCJ6RmTGLD5rHrzREtbvVQalg7j0NlMzstFZcfltqpE9FsQaQNS58YEi9EFV2FoqMsZCYuYja0OpMmTEtFs/erdXiXbhxut/WIOWddLLrzEfdtFshkgXTIR0LNZ2snwUcfe9EFBJCFz4mMVYq0VXglpV1Fz2nJCw+xOtMucJUxZ5Qw+dG6sxyakGiGeXJG5V6Zu2tlt8E7j1kHQBvNiqXpF6r8BC+RFRTh/7K44BLk/iAM8HC2QJ5yiRh+BlIqmrVLQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(346002)(136003)(366004)(376002)(451199015)(1076003)(186003)(83380400001)(82960400001)(38100700002)(44832011)(41300700001)(2906002)(8936002)(5660300002)(53546011)(6486002)(6666004)(26005)(316002)(9686003)(66946007)(478600001)(8676002)(66476007)(6506007)(4326008)(66556008)(6916009)(6512007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FYMRRESc7FQvJx2dYdb+E1GqkR3U9Pnb7wdJHO1jdkPRaJ+uPVsLknlhRr1d?=
 =?us-ascii?Q?OQr42UP1NhCoWOJkkI55a+8JDnK1qmv8vMgHBnyWF22dlmso5MdcgnfxlMWY?=
 =?us-ascii?Q?ArAEk8ZRPynNLh/3XMf0Ty9dM4BA/QI8UGvwCWlbdjaRJrgZecnNxehaz3Hq?=
 =?us-ascii?Q?6RGc7PfLGwtar7waQ4MbbedHPdthGmlEBmooHTRXOH1MYcMUsUyXIZetfWDG?=
 =?us-ascii?Q?MxZCp78EJnMahOAvvHq/7yNton6swwoia+UcKr72hUARovm8GxMQJIis9AIQ?=
 =?us-ascii?Q?iE3ULs/5Q9wz+V9PeR5sjDWq6OJPThIzo2QjFR0AEf9Pq6NOEoVC1H1KKGFt?=
 =?us-ascii?Q?qtHZFf1hg1O9jNjTdtpKPot7h5vCbFIJFGvvWft5zARUv2+XjdjXCV1rwTTp?=
 =?us-ascii?Q?tKuYkIpwlJa8aRl7RsRfXSHPQw+1I9GzM4dLPw9fu09AH0gs8j5iL4StAiT4?=
 =?us-ascii?Q?EG42cXxmrOCWaIzo3pk1WQplcg6zGzVnoEpi+Bu1o5aT0Mc8mSaeSWd98o5h?=
 =?us-ascii?Q?T2BnamjMRYogRzXCA6cOlnGhvFSXtKQG5qNefP0xhZuG760CCxxtT2QMV6kZ?=
 =?us-ascii?Q?+0gz/H4GMTEC3y/1kP7vjED7Awn39TiFs56o+OkO7oHr7jlQvTQjcujyI16F?=
 =?us-ascii?Q?vGC31eVP4LlJfUcU39Vtrrns4klSe1me8IFACaN/3kKSRnsWeayZpXYb9zlm?=
 =?us-ascii?Q?L1BHwK5uZ0dRBpnszagueKGr99kpqpxQtHKzSaxzMOAuGwKl3hxrWAowvodd?=
 =?us-ascii?Q?LuX5EAdZ33QuNTsHSVmBOnbHq27Y9TF2jBrz87bxBRiLqfsDtamEfWAr8NMu?=
 =?us-ascii?Q?QMakno6hDPwvahRejOY9/Em+tQo+kHYSgGnbAnBFaKAR+rE4RNryPn6TMLx4?=
 =?us-ascii?Q?/wD4V9p4KwG+Y1fyqGAqw96uI6Yzhfe/qGZUyghcmKV0hu+oT4ph32D7u12j?=
 =?us-ascii?Q?66Mq2fvhhej5evOMX2HE8Zy3APNep9Qx3Fgi2nehtjnfJqw4e/6CteoPtQeO?=
 =?us-ascii?Q?5hBMCZs9kR4eal4BLJuMW08E545EoqefMMHq0sp0uqqqZgpCPtzWqelfai8M?=
 =?us-ascii?Q?fDnr7c3qWmZjLjma0tJ8T0Fuq6lsLBi8rpEBTUB2FQtMNYRNSjGZCBz8RFAd?=
 =?us-ascii?Q?iiIyYhcupdXhuJEA95uCqmUK4ZpjoJkVcKgDRQ5mAvzMigKtVhsMy11xujrS?=
 =?us-ascii?Q?HdRfXriOzdy9UkNZI162R+peoFMxh4ovNDwYxV/dbQUC7beHmKr3e9IqBJ/e?=
 =?us-ascii?Q?J60z3BCv/UjobprTCaS0zC6nHlFCpk5MDZxiCus0V1E5lVXV8sTtTq1jnrQO?=
 =?us-ascii?Q?CwLbG5l4R0Vuz5FFqxKYhlOIXX+k7E/YsHuKjyq/gPoFR6xMJQzOnLf/ObhG?=
 =?us-ascii?Q?o3JpIisAd3gZrmt4sPxI5dVVr7fTbAOS6DvC7E/P4hnXNQGwGj2PfT2JmBvx?=
 =?us-ascii?Q?4MD2hWzTzJxyBUzP5xlPyA0/37NgxaUTAegAP8c1qdyHPRdhTHsjaUtnrET0?=
 =?us-ascii?Q?dilCT7h21PvPQ9ca9x0pv0WXsERrzhe9DAKOqGYoAzuSXBz108h4wMDkbcc8?=
 =?us-ascii?Q?i7srfl+eZnI8zQWaxNXN2RkSjkbVELD/jtYB3TNLIkNR/36hIO5URXYZlIiK?=
 =?us-ascii?Q?mw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aa84620-68f0-4b24-03a4-08daa881c07e
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 16:34:06.1327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zfKiU3M/NWbk7hhgEG0sWefO1PYq1ourvNskno1yfTUjDaF5B6h4FX9xS+zkunnIuK9fgBOSdRHC+UlPh3tLw7BWBhys3h4xd1C3nlkpGmY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3912
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Fri, 7 Oct 2022 08:51:05 -0700
schrieb Guenter Roeck <linux@roeck-us.net>:

> On 10/7/22 08:36, Henning Schild wrote:
> > Ping.
> >   
> 
> The patch is queued in my watchdog-next branch. We'll see
> if Wim will pick it up in his pull request for 6.1. If not,
> try again after the commit window closes.

Thanks for the update.

regards,
Henning

> Guenter
> 
> > Henning
> > 
> > Am Wed, 24 Aug 2022 17:24:48 +0200
> > schrieb Henning Schild <henning.schild@siemens.com>:
> >   
> >> The status bit in the status and control register can tell us
> >> whether the last reboot was caused by the watchdog. Make sure to
> >> take that into the bootstatus before clearing it.
> >>
> >> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> >> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> >> ---
> >>   drivers/watchdog/w83627hf_wdt.c | 12 ++++++++++--
> >>   1 file changed, 10 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/watchdog/w83627hf_wdt.c
> >> b/drivers/watchdog/w83627hf_wdt.c index 56a4a4030ca9..bc33b63c5a5d
> >> 100644 --- a/drivers/watchdog/w83627hf_wdt.c
> >> +++ b/drivers/watchdog/w83627hf_wdt.c
> >> @@ -113,6 +113,10 @@ MODULE_PARM_DESC(early_disable, "Disable
> >> watchdog at boot time (default=0)"); #define W836X7HF_WDT_CSR
> >> 0xf7 #define NCT6102D_WDT_CSR	0xf2
> >>   
> >> +#define WDT_CSR_STATUS		0x10
> >> +#define WDT_CSR_KBD		0x40
> >> +#define WDT_CSR_MOUSE		0x80
> >> +
> >>   static void superio_outb(int reg, int val)
> >>   {
> >>   	outb(reg, WDT_EFER);
> >> @@ -244,8 +248,12 @@ static int w83627hf_init(struct
> >> watchdog_device *wdog, enum chips chip) t =
> >> superio_inb(cr_wdt_control) & ~0x0C; superio_outb(cr_wdt_control,
> >> t); 
> >> -	/* reset trigger, disable keyboard & mouse turning off
> >> watchdog */
> >> -	t = superio_inb(cr_wdt_csr) & ~0xD0;
> >> +	t = superio_inb(cr_wdt_csr);
> >> +	if (t & WDT_CSR_STATUS)
> >> +		wdog->bootstatus |= WDIOF_CARDRESET;
> >> +
> >> +	/* reset status, disable keyboard & mouse turning off
> >> watchdog */
> >> +	t &= ~(WDT_CSR_STATUS | WDT_CSR_KBD | WDT_CSR_MOUSE);
> >>   	superio_outb(cr_wdt_csr, t);
> >>   
> >>   	superio_exit();  
> >   
> 

