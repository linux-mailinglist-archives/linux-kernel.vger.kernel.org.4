Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91DAB71664E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 17:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbjE3PLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 11:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjE3PLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 11:11:11 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2058.outbound.protection.outlook.com [40.107.249.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEFF88F;
        Tue, 30 May 2023 08:11:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jTX0PHUZAHNJXLuJxgE5pi6svM989k6wNO9nre7dijsaMNQQUkkyxTk9foiQJQrRkzMMPGaJ2E4FNC1muVxwgVoKxKb8c6+RX2N+xwgc+/Z5YsxAePBtMK8ObHYfHKVOVWWI0cn1z7oSotDMuYVV5c0eB4UXPz7kohVA41Vc4dyXyvSMnOSWn2ZXCTBE7ymm+uuhwKZ7O4qOigF0G1ZEbsoPhxhDVlNUuKagzjNfYiKWtU0o9D1FNBcLSpLcimns59yMHfoQlEWVQDhiIs+SInSfRnWgkreTVObT3Zp9+k2M6lbnN/yEyRcf1pJIZOFA79qIuYsUt0C9BGc/G/PLZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6+hmlbP2DGELuiNJ60ADUpQe7VDNjwogAZfrkGjVpzA=;
 b=P9lj4iW6VZWeOOdjPpcVbg9se+mhr5aE9D7vB4vez75bO+Md5bA4af/ZAB29ZGbW3KAmW7FtGRtgMHgBAaRCMG7C69W2Qdi5gEyd9/GyHwSCOxV5fylVU+v4x00rGi+JvYcZNSO9eF1eHj+BVMgjwsieM2eFeBoLFEsmDVIXCQF9nSivZ1yjKpT3plM/7zOH73xrNQSIAJyeW5IxNc9yyt9ex6q5D6hOIm58EUQA4MXVIH5n35TlKkI/FkZywW37aQwDOgP6Lh40QPyjQqmzG56O1lw6PRPRasBRxEs1uTx/VKwqU1KhuGH9B1oPiaOZKrzO20jYuc5QEgYvDJ00IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6+hmlbP2DGELuiNJ60ADUpQe7VDNjwogAZfrkGjVpzA=;
 b=sOoPI4lbm3Ab7aQZ4OQSTUvv5EOISOzSTZoV1KjzgfDQUFA8OKxGgmqIq8XGK7SDgrpIE7QZgkpLrbjEIQjId/zMIOh8NDlA+SH1MFILn6DXX81OJMEp4HfQqJzitQI52hXwy4wtEPNEpmDrZadWP6xs1W4k6zHIKcN/fTa9azreS1E3nUbDW3fsrMHCV+kaaqkVdVrpxz/RWCEk6RKWd3uQx2HQYdyuhBV5EJHZ3Nx+4I29fQIArPtlXhD/3ESt6pErYLtMrmP5/vWwk1VrbF5s2t8+prTOAMVU2DCfpcUOnDKMFcam+IjRHG54ySFcMXItp76CAxKepHQneVbQ6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by VI1PR10MB3230.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:136::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.21; Tue, 30 May
 2023 15:11:07 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a171:a3f2:99b7:5f29]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a171:a3f2:99b7:5f29%6]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 15:11:07 +0000
Date:   Tue, 30 May 2023 17:11:00 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v4 1/4] leds: simatic-ipc-leds-gpio: add terminating
 entries to gpio tables
Message-ID: <20230530171100.75e5b86c@md1za8fc.ad001.siemens.net>
In-Reply-To: <ZHHFMPEYNz9jBBRd@smile.fi.intel.com>
References: <20230524124628.32295-1-henning.schild@siemens.com>
        <20230524124628.32295-2-henning.schild@siemens.com>
        <ZHHFMPEYNz9jBBRd@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0161.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::8) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5780:EE_|VI1PR10MB3230:EE_
X-MS-Office365-Filtering-Correlation-Id: 6171f370-f7c8-41f2-f84c-08db612017e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dbKYJujlQ9dR1b5wARMS4JwpU6JWpvIc78EHXIAjk0SI0Sa4jlgUlvPpDsoLuo6wAuYbftbXN9BNdytyzhNvM4NX2QmcDxM8UmiKhfgs+3+i3GzZIx5QcvkMA/EAg4dGqgAI7x3+/EWQ5nAHoUiDhNBlCCoWyEKb7PfEsCZ4xRvUcJgsIGIVuvT5EM+aBC+UePdZMZiLmXjnpGafmEhOerH7VRESj3DtQr6I2osUU9KthE3/iMafMxL972VmtifR5Ay/yJldZdQzgVKdA5Kw1brlqK7Fx0sBXxyILWDnICKFXHYs2DqNlDJXbeVrqazkKLrzf1oIceKecPTUkgSl07DZ1ZPQgQORy4d7+s5hcsXDtD4brYff852xxFryYFdwDq8AxajzGvkGkEodYeTrTampWKA4jVCyPnqnS0bDhZoYPYUdwNmEZGNUlm8mrKAbp6LuWvCCrxU01VcwlonBGOoMgHURU7GsmerU4oblFLPadVK0nLYslvzCK6pd0s9/fmRsphg3fUJEtU5qcAtz30CykDlGQZOe6QzElcu6tOd1TVqLjsvgjk2HF26QaCi2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(396003)(39860400002)(136003)(376002)(451199021)(6506007)(9686003)(6512007)(186003)(2906002)(54906003)(478600001)(1076003)(44832011)(86362001)(38100700002)(8676002)(82960400001)(41300700001)(6486002)(8936002)(5660300002)(66556008)(66946007)(66476007)(316002)(6666004)(6916009)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TVg8pPzogruTFM14+q1G2KB96YBm2EBTJ3iYuFzyu7ENMN8B0EHRr+CQgiXX?=
 =?us-ascii?Q?7bc6Q8B4bnXWn8dwt4emVa0i38qLACbkkHOqdIKwO5W7Qb90ReLKnU/erbPx?=
 =?us-ascii?Q?brHHwR634s9ryqOD0g0B5m8hjEje5NMvJupX4+NUFTFjEFi7DML7sCabQ/f9?=
 =?us-ascii?Q?Dt/JtcV30c/uH9LAF3IbQGTbYodF0jfulWTwVDsTpDJy/9eKLDwN56MmGkAs?=
 =?us-ascii?Q?IGIh8Ugfi07+GbJUF+Ebj05UAvEPs9U2giIj0d9f0GeghvYGpbkhe4sJ1Qs6?=
 =?us-ascii?Q?XxmAwXYC51/Kwsy2RBU130Vv4ryMW56eJy66+FWVTttf/as/CzDb3+X8TjVf?=
 =?us-ascii?Q?sx1QT7bQ2e7p14QxoGSCHZ3U5rbliYCAoJ8iyasa3xfbi1+V6nH5Dv5dc30V?=
 =?us-ascii?Q?MOG4JtqoDO+gMwscvO2BJ4TGHumRyyaVVBwaojeJ7TVykSG8ABbCmCmUKu1+?=
 =?us-ascii?Q?AGS6wGaJP9zYeZQlCHp5e3clYKzs/ajsmqefKsW78RNcrXDdcrsZXqbdWXYu?=
 =?us-ascii?Q?dZFNoxU2xalPM9gUsix4lh+9wurH5+DRHHmDlQJ9eem3YL4rDXasi2mWHyRA?=
 =?us-ascii?Q?MPriIJCiJgMw0/a+wnmyofz3xycjOauDj7mrwn9jbKzaOAa23zWIW3yqlDRc?=
 =?us-ascii?Q?oD4mKBgVXUuEHeG4zcmZMqXNt0+KxxkQrWANxi01oW/dq90xt6NUQCIaUJPb?=
 =?us-ascii?Q?aknyfschXDrw+Z+XYB31Q5sMRaXDNSdqxs/Qxga8eKIHdp7iGjuRefBHbBvE?=
 =?us-ascii?Q?NukKWWHOn1uJQOJl0Pn7NI+uCY6xTZ5W7Y6N+/FoijGWNBsgUZpQebtolPvC?=
 =?us-ascii?Q?9JMKfB1MbjMRSIwez9fJq27rZx6sM52nSaYhtCfdfGK1u5WqGidAjjoUOQWT?=
 =?us-ascii?Q?wL7EqXicci1O9Iq3CLOujd5OlLk/O/6HQpcnliaxpNfQg/00ni68bH+pLglt?=
 =?us-ascii?Q?zMdWK9p3rFyZDfIJfiJAZIEU4MQIe8F9dMlwcxoOq+62CaFUhvcXkUOvW1Ua?=
 =?us-ascii?Q?h1FrkvNDHqlxwZHhg+7YLWdFzqyj352Lcn3+LeSIaHsMe5ylD5I99vlrFwHQ?=
 =?us-ascii?Q?LnvftoePtCxGOmnKeB/6AgiRXDNzyDvFbopv60Z95Tl1gZ+D2KY8K5DaLkdN?=
 =?us-ascii?Q?4KAwMwaH4ljwGTJGA+hS5OWfJSJi+mDu+5lfNoz8vhlQz1tv8aCfwaKWAlZF?=
 =?us-ascii?Q?E7/kwY8g6TSfKpDcpEDEAtVQG4RVRfTbPGanqFh0Q2KtVQW+pMYUGjTS3IJd?=
 =?us-ascii?Q?iqmALwRhxOr0wBD/BN+KfvM26imklOzE/QR0PHxz4y4c6FsofO0ukIeNvmyC?=
 =?us-ascii?Q?AHarlYsgCQwfhtEZawNGFkwoGdadEh8O5Gzi7swtyRsfCN+7HRT4AdEGKWdH?=
 =?us-ascii?Q?7j8Sljw5/hfcu6bAhoqc68GhJIClcjjZjXJLzdd0fkFsnWiN+kBGYW1Pmtd+?=
 =?us-ascii?Q?4A81a3hHgPKDmmNZkuJgli/tI2TKrYYSmc3Io02FL/eDqr7PN7XPwtL4WRrH?=
 =?us-ascii?Q?bEtckxcfoJEPnUqr6g+NcnByBTEHmm9JPav8qAeKqOoaeGdMUdzwJZSSH90g?=
 =?us-ascii?Q?bDD3TGmrT3+szC6fQb/I6NqAMDtYPCr3L3fewMkn/AcQtW4mrEJ3qG1wYVBc?=
 =?us-ascii?Q?Uj9ojq5hL1jMbaEwgsc01Qa0ZtGu3d83IRmGyDT/DOevPUIxqytizKqu1YWc?=
 =?us-ascii?Q?qAEhCw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6171f370-f7c8-41f2-f84c-08db612017e2
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 15:11:07.2011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WTgaFeyCBDACKQ7qT3kNPFjALl1GVH1PuNw+pM8piaOz0OKHIJsUaojoOsbsi1ejuW7cQ4AEXpFJ7CId8KCyTmZVLu47rPFxKVklKdhDE9c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3230
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sat, 27 May 2023 11:54:08 +0300
schrieb Andy Shevchenko <andriy.shevchenko@linux.intel.com>:

> On Wed, May 24, 2023 at 02:46:25PM +0200, Henning Schild wrote:
> > The entries do not seem to be stricly needed when the number of
> > entries is given via the number of LEDs. But adding them is a
> > safeguard should anyone ever iterate over the tables to their end,
> > it also gets us in line with other drivers that register
> > "leds-gpio" tables.  
> 
> Reported-by?
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I think we could do

Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

on merge. But i would not want to send the whole series again for that
one line.

Thanks!
Henning

> > Signed-off-by: Henning Schild <henning.schild@siemens.com>
> > ---
> >  drivers/leds/simple/simatic-ipc-leds-gpio.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/leds/simple/simatic-ipc-leds-gpio.c
> > b/drivers/leds/simple/simatic-ipc-leds-gpio.c index
> > e8d329b5a68c..1a1cfdad6218 100644 ---
> > a/drivers/leds/simple/simatic-ipc-leds-gpio.c +++
> > b/drivers/leds/simple/simatic-ipc-leds-gpio.c @@ -28,6 +28,7 @@
> > static struct gpiod_lookup_table simatic_ipc_led_gpio_table_127e =
> > { GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 51, NULL, 5,
> > GPIO_ACTIVE_LOW), GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 56, NULL,
> > 6, GPIO_ACTIVE_LOW), GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 59,
> > NULL, 7, GPIO_ACTIVE_HIGH),
> > +		{} /* Terminating entry */
> >  	},
> >  };
> >  
> > @@ -42,6 +43,7 @@ static struct gpiod_lookup_table
> > simatic_ipc_led_gpio_table_227g = {
> > GPIO_LOOKUP_IDX("gpio-f7188x-2", 5, NULL, 5, GPIO_ACTIVE_LOW),
> > GPIO_LOOKUP_IDX("gpio-f7188x-3", 6, NULL, 6, GPIO_ACTIVE_HIGH),
> > GPIO_LOOKUP_IDX("gpio-f7188x-3", 7, NULL, 7, GPIO_ACTIVE_HIGH),
> > +		{} /* Terminating entry */
> >  	}
> >  };
> >  
> > -- 
> > 2.39.3
> >   
> 

