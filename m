Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5376A7D09
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 09:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjCBIrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 03:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjCBIrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 03:47:36 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2051.outbound.protection.outlook.com [40.107.7.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051E81515C;
        Thu,  2 Mar 2023 00:47:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZTThbBcvEaSanNmk8kIdGrRAGseOkBnQ3rDI7t/QwU16Hj2mflnjX/50zD1OPCIbQJpxPAPXBOftdZTmb0u9OcBJGMO0h7oNEVf/T6qApTAWSXtdNTiDxv/ADlYpspDzIkTNI3nJFoYP+T7QmSgpbxC0lnLOQm5uuFac9DdloUDQfvk2Fnc0BmXQEDiH5q1SOhma7UCiBw7E8CCdS9XFFITxgQA5qDQ8dRZ+/oSBo3czppcyRQEjsaMypvs99NQqnJ8Kzw3yCpDoKz/I9zQCS2WAsTt7X3z8+CbhFNYKEROGqsfCfHM5RJFKPPZ1IhwfKK0O5rn1vLWT0s3NRvVEAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cHPMPtJl1XVb5CDOd5uBVZ86YvJv0qhWk16Mf9wyQVg=;
 b=G1Z9oCsCixrL1pzTljXrUlANmn3btHrm04jRSYUQ+bouBDd0K+sycrjzEPnX6pB09LWLXeg1uCmMym5ZDV4XJH3eN5OVVzcSMk5xUSW+1gvsIgjuAZIU0ZWS4Efd3ewCD6rd6HoiRwk/jeb4zu8PGiFzMzVqDFM/wiR7wER6Y/j1XyOoFizXIDE+70ZElzKr67TpMpewAA3xxXlcq6d7DlLnefFW9TlDUlLGsCIzj75PnVedVcydrWXoqV0rRC5aSAVJOUpf6HP3ly/lTju4vlbVb9S6fHyrEkPtj3WQ8D2LVpXoe/Z6NEhD82ikI2aN1816cnqNBIKM4kbnKviahA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHPMPtJl1XVb5CDOd5uBVZ86YvJv0qhWk16Mf9wyQVg=;
 b=eabuTSStj3zGU0N50I42NJsxpRrKSp9ARXCKFpBn89Srqoyi1tgde95+15hRAiUT04lh1f01/2A/wPlGetX0FmzA0bIXC3ok4/UyOQC3TgxqKqcQ+q3oajN0xKbhfxANxvQ5nFO5VX8EZ8HYwyX2sZLoqRjKwWcAf8Y9z0iy2caBtNnoARTyxTe3ZJ9OMWGv/BiLSXGSI5QVT1OFdSYBzJNaztIo1zKF336aK1nEXlOiqhUKSY850zR6PZXH2/kCFpvTpqYeC4KwRwgR5kl1OH6fU7WX45NV3rApWdLzRMwfhyr6HObHKYsZLUSaWajJpzz/ph9sBePF3MFxcleZqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by AS2PR10MB7322.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:606::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.6; Thu, 2 Mar
 2023 08:47:32 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ee44:171b:4c40:d42c]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ee44:171b:4c40:d42c%6]) with mapi id 15.20.6156.018; Thu, 2 Mar 2023
 08:47:32 +0000
Date:   Thu, 2 Mar 2023 09:47:28 +0100
From:   Henning Schild <henning.schild@siemens.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2 3/3] leds: simatic-ipc-leds-gpio: introduce more
 Kconfig switches
Message-ID: <20230302094728.563c04ce@md1za8fc.ad001.siemens.net>
In-Reply-To: <a6281345-95e1-3e8d-b6fb-146c1852373f@redhat.com>
References: <20230301170215.23382-1-henning.schild@siemens.com>
        <20230301170215.23382-4-henning.schild@siemens.com>
        <a6281345-95e1-3e8d-b6fb-146c1852373f@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB6PR07CA0168.eurprd07.prod.outlook.com
 (2603:10a6:6:43::22) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5780:EE_|AS2PR10MB7322:EE_
X-MS-Office365-Filtering-Correlation-Id: a1c26870-7af5-4eb8-c72a-08db1afac32a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EhRIsl4Li2Gkm4v7H/j9j/dolKAvWiJbmdjk3z1sW7h4+OqvQ+iZD6H3aKK1EfR2T3nYNktyQWQlUBxAxq8Yp5BzqQAZo8HCkZ6tBXHTad8i4YA9p//6+6MVq+VSmA6XAnTrWPt8KZ2I12hQ5LvyQrDiMbPY+zxgrDN4geyP9RxrY+44DOMT1SKUdJcpcX/xJK1dIvAADCqJHcuNS20AF8oRXnLV2BR2UsBihKvhIJwhlc8YFATiMGvwkZG027WaumMTiRBlgWnB5KfFSk0/TKGjlPK7yqwFfHJ8zG49plI9/LWeec+9pZMFmlDojRuYm1ev4tmbiVj65pJw5RJk03E93McHp5kWUZajs5dbnn8VDddB3YQLJi1gvllZPFXTH+i42gtPzQQJJ0gGRk8mu3IqY3e1ZSrPZTNCFZP6Z18t2GP8+i6Ptf4PkC37qQbNl3+FRjJqHb4mmqiNhF56xBQfeiLC1xPjsScL1n2Rx44G8YBJYk5GE+ErBOz/q5MCSkWKdtdqctkpthVqxKW//XRt6XEp1o0u/JyDzzeLFEo25vHl/YFkLtu/DOd4ulYeaIzFeAFyHFAdjbWyrjUfYud2WYzHT9efGWMozeTnsYJs7gdvE862Kzpu8/+7fviE8HGHIYuffUcn7FqUO6EADA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(366004)(376002)(346002)(39860400002)(451199018)(83380400001)(6666004)(38100700002)(5660300002)(8936002)(82960400001)(478600001)(86362001)(26005)(186003)(9686003)(1076003)(6486002)(53546011)(6512007)(6506007)(66476007)(66556008)(66946007)(2906002)(44832011)(8676002)(6916009)(316002)(41300700001)(4326008)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GGs24hYaEzzFp9XkY5dYtGu+N1fUDggGSmcaQF2+tqeAIF1oEJum/tqu2gkl?=
 =?us-ascii?Q?a0Y1JgoYMfA0nEn0wg+D9HiiQnTQ8ORjPukPBe7c+rTMVXvI64XLOQ2jwce5?=
 =?us-ascii?Q?TCrruA9g7lGyZhWQReRVy4CiFEdZ3AMkxPUQ8pW35DnQajqGWHsmzaBnQtwz?=
 =?us-ascii?Q?aI1A7/gmnnveC6jeI4eQLgXF0XshkKGtW4ucR1QDPudEu9PlcDM94031QF9k?=
 =?us-ascii?Q?0gQEoeY1TjwCc0AvQmZfO0s8K5binWsOHJVqFPBxBhA5V4uIQjv3nDswx09x?=
 =?us-ascii?Q?fAx4XuWtQdjBJJGAlQoaLkqszlFqExIf78LpioF+zunY/TG9XOERB3gbwbQ7?=
 =?us-ascii?Q?pSEA+7jL/HyiERVET+lFsZbTlJK/9iMjy/opVVhw9tlb8+0ik2GqH1aIsciE?=
 =?us-ascii?Q?34lRs+Ich5GTqZfepG0aFG1TCH9shBVdZFV45IU8Rf/PWRRKYdkV9UA/aqWO?=
 =?us-ascii?Q?Mu5NYL7m3dOeRDp8egdQpqQxp1nd3SDrVLLx6O5pUnog9gJNaGGUmeLl8JLe?=
 =?us-ascii?Q?xtdUaY9Wgugu9NOU7PL+ELYr6cKO4qvE50Z00vgdFPThJdFZz0iOSWL/jqGR?=
 =?us-ascii?Q?GzrKJ5mReyJDIC/0Jvxs1sKEyMi4Om9Dmttol5lDYTKH2CHMbcRcNJgquO8d?=
 =?us-ascii?Q?agyi1/lhtuahcZLQz/FNVnkEE+miRoeMBz4Z6lfECWwbelJ7YoPsEvKVCdSC?=
 =?us-ascii?Q?DAXa6iRWDn5/KbKUQBjpl35r4MEDwMDFrJEOQoF7Cp7Qw8AGDi4MnntKUAUC?=
 =?us-ascii?Q?nHz/BPvNWJmE+5UZqvij6QwvvMpNKaKk/OH4OaAZ6ihkmw4fUrjxNQqJvJ6V?=
 =?us-ascii?Q?ZzNDcLrcIqjNaE4P+YGt2mFPo37lnLTO3qBIn5V9PbAjCDV1zO+aKmyH+CM5?=
 =?us-ascii?Q?qD1pMVSU0sHZ18XrI6cmjw1i9OMhGhH5LA8K24XMEXRk8M88118G0LX6fG45?=
 =?us-ascii?Q?DA37X91CnSqtjRm0TXxBs5dv6weDtNau4o6fhRuZYtDk37m684BADI1U9hQ5?=
 =?us-ascii?Q?0A3DlruUv18w3Q3QzS7n3BRtxWBnpnAKWYBHQR3pAFDAA5WiNIZtcQzxndNA?=
 =?us-ascii?Q?c03RezcNCbYsue/yGctALopnHl96rOIfpcFtHCrSe04+0/M0Gh4gpwKT8PA0?=
 =?us-ascii?Q?R27Br0u/RvTKLIjUmRnu+Knc/fQTPt+vuyUpgpTizfVQCKd6vcTnSznU/Iz+?=
 =?us-ascii?Q?hvPpg/AtUJ57rtTtPxBlC9bq7Gyueq8GpRgyMh4NO9uTiqrW0+KmoAyqqV4Z?=
 =?us-ascii?Q?LVOzvATTMd8paZdrFe3CpQE2hy3cwErdrQxwoGiz9hhsz5csThjyqjUwe1U+?=
 =?us-ascii?Q?W/yUNopi0RC+FDibEwO+LcJ6eozK5gfRXNiYfVtk9tqrn4QI/lKpzAzgY3A+?=
 =?us-ascii?Q?kmNg2/k02u5G1v80fFgPzJLoyBxjln/zpFyhINRPGrAzMckjIHoswm1l2cS3?=
 =?us-ascii?Q?2iZsRj0IRdBlmpF348iKpu1Zr193W8PkFIk21rCTCUUq+ZGq1gDHrM2WKBC1?=
 =?us-ascii?Q?Y+kT42AMGRH4aQ2iuvKHFgHIk6+W5fDvE112odYgcIR9MiVl9oJOgM+d3WhY?=
 =?us-ascii?Q?wDLxEVdWT3acqcEDVXGXvkdaC6v4q4knXkM7pJfkhlRlWV+xphGKsC154cCg?=
 =?us-ascii?Q?Gw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1c26870-7af5-4eb8-c72a-08db1afac32a
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 08:47:32.3126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MZsxNep7KvAvcVvDI0IEbNyhYZjnZrcam5ct4EBJ8OoYO/WgzfEchfhWjr/uzqeuKHrzrP3JcEKQG5nC4HTIu5McTu6anCshXW5hGTQW+v4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7322
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Wed, 1 Mar 2023 19:04:01 +0100
schrieb Hans de Goede <hdegoede@redhat.com>:

> Hi,
> 
> On 3/1/23 18:02, Henning Schild wrote:
> > To describe the dependency chain better and allow for potential
> > fine-grained config tuning, introduce Kconfig switch for the
> > individual GPIO based drivers.
> > 
> > Signed-off-by: Henning Schild <henning.schild@siemens.com>
> > ---
> >  drivers/leds/simple/Kconfig  | 31 ++++++++++++++++++++++++++++---
> >  drivers/leds/simple/Makefile |  7 +++----
> >  2 files changed, 31 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/leds/simple/Kconfig
> > b/drivers/leds/simple/Kconfig index fd2b8225d926..44fa0f93cb3b
> > 100644 --- a/drivers/leds/simple/Kconfig
> > +++ b/drivers/leds/simple/Kconfig
> > @@ -1,11 +1,36 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> >  config LEDS_SIEMENS_SIMATIC_IPC
> >  	tristate "LED driver for Siemens Simatic IPCs"
> > -	depends on LEDS_GPIO  
> 
> Since it is simatic-ipc-leds-gpio-core.c which actually registers
> the LEDs GPIO platform device, this one should stay IMHO.

No this one is now only for the port-IO based driver. The GPIO core is
built under the two new switches only.

> 
> >  	depends on SIEMENS_SIMATIC_IPC
> >  	help
> >  	  This option enables support for the LEDs of several
> > Industrial PCs from Siemens.
> >  
> > -	  To compile this driver as a module, choose M here: the
> > modules
> > -	  will be called simatic-ipc-leds and
> > simatic-ipc-leds-gpio.
> > +	  To compile this driver as a module, choose M here: the
> > module
> > +	  will be called simatic-ipc-leds.
> > +
> > +config LEDS_SIEMENS_SIMATIC_IPC_APOLLOLAKE
> > +	tristate "LED driver for Siemens Simatic IPCs based on
> > Intel Apollo Lake GPIO"
> > +	depends on LEDS_GPIO  
> 
> And then it can be dropped here.
> 
> > +	depends on PINCTRL_BROXTON  
> 
> > +	depends on SIEMENS_SIMATIC_IPC  
> 
> This should be "depends on LEDS_SIEMENS_SIMATIC_IPC" since it
> actually uses symbol from that module.

Same as above, the GPIO based drivers do not depend on the port-IO
based driver.

Henning

> > +	default LEDS_SIEMENS_SIMATIC_IPC
> > +	help
> > +	  This option enables support for the LEDs of several
> > Industrial PCs
> > +	  from Siemens based on Apollo Lake GPIO i.e. IPC127E.
> > +
> > +	  To compile this driver as a module, choose M here: the
> > module
> > +	  will be called simatic-ipc-leds-gpio-apollolake.
> > +
> > +config LEDS_SIEMENS_SIMATIC_IPC_F7188X
> > +	tristate "LED driver for Siemens Simatic IPCs based on
> > Nuvoton GPIO"
> > +	depends on LEDS_GPIO  
> 
> Idem.
> 
> > +	depends on GPIO_F7188X
> > +	depends on SIEMENS_SIMATIC_IPC  
> 
> Idem.
> 
> > +	default LEDS_SIEMENS_SIMATIC_IPC
> > +	help
> > +	  This option enables support for the LEDs of several
> > Industrial PCs
> > +	  from Siemens based on Nuvoton GPIO i.e. IPC227G.
> > +
> > +	  To compile this driver as a module, choose M here: the
> > module
> > +	  will be called simatic-ipc-leds-gpio-f7188x.
> > diff --git a/drivers/leds/simple/Makefile
> > b/drivers/leds/simple/Makefile index ed9057f7b6da..e3e840cea275
> > 100644 --- a/drivers/leds/simple/Makefile
> > +++ b/drivers/leds/simple/Makefile
> > @@ -1,5 +1,4 @@
> >  # SPDX-License-Identifier: GPL-2.0
> > -obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC)	+= simatic-ipc-leds.o
> > -obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC)  +=
> > simatic-ipc-leds-gpio-core.o
> > -obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC)	+=
> > simatic-ipc-leds-gpio-apollolake.o
> > -obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC)	+=
> > simatic-ipc-leds-gpio-f7188x.o
> > +obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC)			+=
> > simatic-ipc-leds.o
> > +obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC_APOLLOLAKE)	+=
> > simatic-ipc-leds-gpio-core.o simatic-ipc-leds-gpio-apollolake.o
> > +obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC_F7188X)		+=
> > simatic-ipc-leds-gpio-core.o simatic-ipc-leds-gpio-f7188x.o  
> 
> Regards,
> 
> Hans
> 

