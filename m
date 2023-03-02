Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 169696A7CF7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 09:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjCBIk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 03:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjCBIkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 03:40:19 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2060.outbound.protection.outlook.com [40.107.21.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909753B0E0;
        Thu,  2 Mar 2023 00:40:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D446t+nbtdiy4Jgc8zMJLBDYPIH4WoFLFFqkZWJ4DwH2wnyLI8O7UKKQEUy2/9D0MTaAKU1h/dfq9fIeDBmFgRYqNOAdp+GGIbIWw4IWVnUaTNNI6vvmBlWB5aCbijPqChvugY+y5lXITITiJhsi1uvjji8lCzXWFrDXZQjhNANw+lVCazYvS84Ba09IPlmIzJgWLinQVBJFCJhHan4ms8SnJ41WQA4ZtxvbmWxjFnRwz1wkiYGUQDhv+ZRCddgxZmhHltp8ZEziCFQLm4ohsqs3x1LCyq/D3wymWR5I1GWUsinZ4+R6MfbCQjT3n/WZC+E7itGaMnsEUykRDQbToQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d3DpwPTNM40XgRbgdzfYIOYufDTqrx4Gsyb8ECz1dzQ=;
 b=Iv7g+7dXFPJkM77Fkf+jCevpE9XXw7A/aTwSnZGFjrC5f1Js54teOYcrjeuIuvLuHGP+cBPeUIyNr883wCSvwr0+pZYafIl3Hqr/96TMxFOzM1iE8CGEKdPh/ipEWQazpKnTqhLUN9ZqoEVKAi5/luTLFPE0yY0JxX7NOnc4H69z8aPVYPDtZbTep5YPeEymtJ9I/jYqbHA1TILlETyIgbSyj7pnen7LF2207jL2mHvUbQBPMbxz5jOOcuhGOVj6p6N6zQrVoSsWQeBvrmYJ1z8b8poNv7gC6QiJcGIUNrY4bCW7xzTiyTeael/1nz1cKqQf3w6JU449fQAHaNrMfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d3DpwPTNM40XgRbgdzfYIOYufDTqrx4Gsyb8ECz1dzQ=;
 b=okZrXtK9117n9UhiaoHxO8xZhAbWljGM2c9TQY/He+VC25AZO5t7+R8exsfaqbuT+stqn15DOo4jGX1qAMUTfU1fMcp7XA06yNN4raR5TQ88f1wFsj4YT+I+xyfFMNHc4y/58tG22n5hcOeoAiYCKO7ypv0pbGUPbrblUnNJ5nGf4e5TqXmw+59ijNygwb7xf0FL4gVinJOO4Jq6IdzVi9gDFFc6iNNsxw2/9sRDTeu28FSq82xKkKGxjl7rmcuRvoUrd4H8fkxHqrfrd/zkkpNUKoSZfW3q/2Xnw381FyWTA+n4vBvHq19QOrZDvz8f36ycP8O4+NuWaTVfeT5o5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by AM8PR10MB4065.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1e3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.6; Thu, 2 Mar
 2023 08:40:13 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ee44:171b:4c40:d42c]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ee44:171b:4c40:d42c%6]) with mapi id 15.20.6156.018; Thu, 2 Mar 2023
 08:40:12 +0000
Date:   Thu, 2 Mar 2023 09:40:09 +0100
From:   Henning Schild <henning.schild@siemens.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2 2/3] leds: simatic-ipc-leds-gpio: split up into
 multiple drivers
Message-ID: <20230302094009.74b5d368@md1za8fc.ad001.siemens.net>
In-Reply-To: <Y/+LLICwh3T25IGv@smile.fi.intel.com>
References: <20230301170215.23382-1-henning.schild@siemens.com>
        <20230301170215.23382-3-henning.schild@siemens.com>
        <Y/+LLICwh3T25IGv@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0007.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::12) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5780:EE_|AM8PR10MB4065:EE_
X-MS-Office365-Filtering-Correlation-Id: 70fce28b-5524-4684-ab12-08db1af9bd3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hlCIZ521JEo670Kl2/nQbf94/wGoKtvzub2AAoh1k9O0EMFTbSaBNiuO/PR+s4JH6aWWDnsEqyGg2JOOhZfR4CJjde6X6yEHyxQ/u9PR9XYYr0J+cWeJni6yA021IEa6vKVRuSdq18i9GN5KZs+u/3tBu5Mx1H8ANpITgqDZWQg7ehsZmGaDtF7RRMp5wW2ZTLBoLjPLSm9zj6TyfiHjqNOcMvcr1A5hBvC4OUyOKxkcQU6PWrS0jzOLpLx4UUvoEdDL/2hW57JH/HkSmKih5+THPWW48Hk80ta3L3zW+Z9KTbg+wUkRf8AKX/Pg0TnvC8wqz6W6NdqiObCWlSApmfRwRqn7z53jzbC2ce9W5fNCdJOQufSYlpjggcmVSrm+eUlltESxaZh27sS4XtHZJNBSJ5srsfPgbtahsBGGUynt6YbyNtJZRxJ6qpf9q6ytBE1t+Rkxzai90ENh2Gky6oqp1xSmJOd2+GjUDVjHu9NNcBS313qO1AJk7/woLTAZw1dF6LSesnxa1yjoHAWJ0d82j5Kfna+CTe/UwYlHxM7IslK/DNG0rVZ0WjnmoWbYAK/2tgxG/c0lCKVJA0UoQ2+dCmJimN9HoLcD9TDDWRFyTqQmDfHJy+aWOjEZS+MBPGS/CEnX0ATQWdGWAjn/ig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(396003)(376002)(39860400002)(346002)(451199018)(83380400001)(6666004)(38100700002)(5660300002)(478600001)(8936002)(82960400001)(66946007)(86362001)(26005)(186003)(9686003)(6512007)(1076003)(6506007)(6486002)(66476007)(66556008)(2906002)(44832011)(8676002)(316002)(6916009)(41300700001)(4326008)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWMwaWlrUXZucTZRUHlUb3Y0cXNXaUNYMUZxN1hWZGtVMmNyUGZuRGdaWERy?=
 =?utf-8?B?aXgrbGU2ditLSmd1SFhBMFFDTE1SVzZOZlVNaWFPcFhQZ1hDWFRtVUVsN0Nw?=
 =?utf-8?B?WnJtR0hwTVJ3Sk9aeHBBbUJCMTZFb0tJOTRwd1RzY2c5Yk1hcFpJaG9sSVow?=
 =?utf-8?B?bCtCOVFha1UwL05SSjZMcFZCZmFtaHhleEZnaG10TlhjcDNkeWtyNlhpMDBR?=
 =?utf-8?B?Y3V1NUNYdVdzbXVxNEdEaXdmZWdjcU5xMFNaQW95RFpJVUdwdWhxaHpteXlC?=
 =?utf-8?B?dUE3Vm1Nb0tneE5jcEpuREVlTmZUSitodTdudlJSelQwQ2JnMDFveGlRRGVO?=
 =?utf-8?B?UWFQSlkydlNIS2s0YUY3UzVpaVNTQ2c2YjlEWU9KTy9IcElXZUJjMmhIa3kz?=
 =?utf-8?B?TGU4K0dwc040WUNQai9LWERIa28xZit3MTcwbm5FNG1yQzF6VjRPV1BYMXh6?=
 =?utf-8?B?azIzYm0rQUVnM0FxdHN5eWpZVHlFbWZQYlZxOE5QdlNhb1BtWXVpWWRXSDkz?=
 =?utf-8?B?NXZkM0tFOUtOV25lc1FvZEdpY0RSU24vOTl2RC9wYmlwWVdna0xqSkNPSndN?=
 =?utf-8?B?Z2x5VDdBOUEwRUV1a2RoQnh6a3VnWFgyZkdFSnkwSFE3YWFlajZYUzBGU3F6?=
 =?utf-8?B?R29wVDJYZEUwMm1pY2ZqM3dUUjFNeXhCcXRCbXk3MmFncnoydmMzc0tRVWov?=
 =?utf-8?B?Y1JibG5XM2JCeGd1cEtJRkoyQVhTRWZhWTlxZUFTRkRjM2E1MUNlMWk1SzBR?=
 =?utf-8?B?S2NkVS8xN1AvSTJGVUJzL0REWG9LOEZna2U1bVJaV2l2TGU3MUF6TlpqVlFP?=
 =?utf-8?B?czNRYzJ0TWQxVml6L251UnZ4WFo0L0dpeWpSeHRUOXlpOGFkSVpwQ3llL3dn?=
 =?utf-8?B?OGZPWm5WekVzdlJOYjl6bzg4UGtQWGdjN3pzdFlabGNxQzNldENyMFFzK3Yz?=
 =?utf-8?B?dWxpK0M1TjlzTkdwQ2phR1Yzdm1YTHhraXBvR3MrNFBwRUYrNDJDbkNXWUdH?=
 =?utf-8?B?MmFjUTFpeTY4T0l4UUhFMFBvSUVPdk8vT05UTlJ4Q21kUjBkSTBuSU80VEtC?=
 =?utf-8?B?UzdYUFFrVFZRUmh0UWVFV28wUGY3WjV6UzdvZ2xjMmNhbkxqQlpxNCtvL3dn?=
 =?utf-8?B?ZWZOQ3hmMUd1ditZY1BUYy9zZDc1Y3NKL3RLNzZWaUxHaXpuOTdkcFUvR1VE?=
 =?utf-8?B?cEwxQU1vcS9nSE81SVNwOUFZeUpUU2RjM3p6QXNuZnR3WjRYTDFOVXlNaWJR?=
 =?utf-8?B?NW1STW1Mc1doZzJkVEQ4dXBXVlBPODBCQXFoa0lvYjlqNjJWTGNEY2ZtdFFJ?=
 =?utf-8?B?bjNNTmFEdHFtMEFneWFoVWFUT0J0aW5JRHdEV0VKMFptZXpMVXNBLzExcXl6?=
 =?utf-8?B?UWV5emJ5bjJCeExCeVlxbkhEc3E2alRnSVpLbjg3aWhHSlF1R3lHRUZhdi9K?=
 =?utf-8?B?NDBYS2NyaUtNdFIvWkhjQ1owYTZ4L0o1amVaK0tjZ2k1S3UvUFFwTFFnZjRT?=
 =?utf-8?B?RnJrbm1WWkVjaEVnMWY2UFBoOHZQc0lzdDFmTzV3YXh2NGYxR2xKVGNHQ21s?=
 =?utf-8?B?eUh4cENaMVFSdUNTSE9iNitTRklGZndBdzlTWmJDZ3dzVUJXVHh5ODZuSHN4?=
 =?utf-8?B?dTl0MzhDRzJrbUo2eUxEVTZ1bksyREloWFVQQ2FEUTJZVWxqd2pRQ2F6ZTdz?=
 =?utf-8?B?Yityazc1b0FvNUpKY0l4RnZ1WXVWOEZkUWhub1YrV0lCTlp1dmNybm1BZFRZ?=
 =?utf-8?B?QjAxVHRWem9mbS96dkV2bno1ZDlIcEttM0luT2FoY1QvRXc2NmxORWtWSkJ4?=
 =?utf-8?B?UExBNXhnbVR2OVpGSmFwSVo5eEFvMDNwb2RkWkZlK0tqTmN3TnVaMkZ2aUUz?=
 =?utf-8?B?NGh0WnVVRkNWdnA4RXN1UmREYzNXZUNTNU4wUVU1UWg1dFQ2WWJpMlFGcC95?=
 =?utf-8?B?THRLbUhhRXlBZzc1WVJlYVFzWXBBZXhtcWFkSXpNMThkUWc4NHdDYVVlb3M1?=
 =?utf-8?B?T1NieitCU3oxSTdmNUFXakMvU1FJanQ5eUdDQ3FQd0pJd0Rodm1oYmNFUFFp?=
 =?utf-8?B?eEdQRGNLOVhvSmtteHpYaVpBNDd1MzRXZ1BsZUZKajFKVVhYbDVSN0dPUjBW?=
 =?utf-8?B?Vm42Q05WMWtOYis4aFp2L24waERhaWxOMDlIcDRVeFBzbVQyNloxdEtFVG5Q?=
 =?utf-8?B?MUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70fce28b-5524-4684-ab12-08db1af9bd3e
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 08:40:12.8642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FsKXuBMNOozotp4HDnXW/iG7K0RsYkYya230lDoz9Z+soEZjqryu09oSPYlSwVJfRrKejH+x81ywGsOsMvt3bSCausGUlmssV1OxJUajb18=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4065
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Wed, 1 Mar 2023 19:28:12 +0200
schrieb Andy Shevchenko <andriy.shevchenko@linux.intel.com>:

> On Wed, Mar 01, 2023 at 06:02:14PM +0100, Henning Schild wrote:
> > In order to clearly describe the dependencies between the GPIO
> > controller drivers and the users the driver is split up into a core,
> > two drivers and a common header. =20
>=20
> ...
>=20
> >  .../simple/simatic-ipc-leds-gpio-apollolake.c |  64 +++++++
> >  .../leds/simple/simatic-ipc-leds-gpio-core.c  | 103 ++++++++++++
> >  .../simple/simatic-ipc-leds-gpio-f7188x.c     |  64 +++++++
> >  drivers/leds/simple/simatic-ipc-leds-gpio.c   | 159
> > ------------------ =20
>=20
> I'm wondering if you have used -M -C when creating this patch.
>=20
> ...
>=20
> > +#include <linux/gpio/machine.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/leds.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/platform_data/x86/simatic-ipc-base.h> =20
>=20
> + Blank line?
>=20
> > +#include "simatic-ipc-leds-gpio.h" =20
>=20
> ...
>=20
> > +	.table =3D {
> > +		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 52, NULL,
> > 0, GPIO_ACTIVE_LOW),
> > +		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 53, NULL,
> > 1, GPIO_ACTIVE_LOW),
> > +		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 57, NULL,
> > 2, GPIO_ACTIVE_LOW),
> > +		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 58, NULL,
> > 3, GPIO_ACTIVE_LOW),
> > +		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 60, NULL,
> > 4, GPIO_ACTIVE_LOW),
> > +		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 51, NULL,
> > 5, GPIO_ACTIVE_LOW),
> > +	}, =20
>=20
> Shouldn't this have the terminator entry?
>=20
> ...
>=20
> > +static struct gpiod_lookup_table simatic_ipc_led_gpio_table_extra
> > =3D {
> > +	.dev_id =3D NULL, =20
>=20
> As per previous patch.
>=20
> > +	.table =3D {
> > +		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 56, NULL,
> > 6, GPIO_ACTIVE_LOW),
> > +		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 59, NULL,
> > 7, GPIO_ACTIVE_HIGH),
> > +	}, =20
>=20
> As per above.
>=20
> > +}; =20
>=20
> ...
>=20
> > +	.driver =3D {
> > +		.name =3D KBUILD_MODNAME, =20
>=20
> Strictly speaking this is an ABI (as something may instantiate the
> driver from the user space or elsewhere by this name. At the same
> time this may change with the file name change.
>=20
> Personally I prefer explicit string literal here.

Switching from one module to three the names have to change. People who
explicitly loaded the old module which supported multiple machines,
will now how to load either both o=C5=95 know which one to load.

I personally think the ABI change is acceptable, the assumption would
be that the drivers load automatically anyhow. And since there are no
params i doubt users will have /etc/modprobe.d/ or /sys/module/ stuff
around.

And with the split i guess an ABI change can not be fully avoided.
Whether the names is explicit or implicit is another discussion and
just a matter of style. I prefer to stay with the currently used
pattern, it is not un-common in the kernel.

> > +	}, =20
>=20
> ...
>=20
> > + =20
>=20
> Redundant blank line.
>=20
> > +module_platform_driver(simatic_ipc_led_gpio_apollolake_driver); =20
>=20
> ...
>=20
> > +MODULE_ALIAS("platform:" KBUILD_MODNAME); =20
>=20
> Why? HAve you missed MODULE_DEVICE_TABLE()?

I do not know what that is, but i will have a look.

Henning

> ...
>=20
> > +++ b/drivers/leds/simple/simatic-ipc-leds-gpio-f7188x.c =20
>=20
> Similar comments as per above.
>=20

