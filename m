Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0D5608445
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 06:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiJVEZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 00:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiJVEZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 00:25:56 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2066.outbound.protection.outlook.com [40.107.212.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D650E224A8C;
        Fri, 21 Oct 2022 21:25:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KvoD94ZtbzZABcDaoXEEnW2SK0g5z5YapYUgDvNSoarmsowxUz5pdJz3fWuyw5cTg1nja0gOQiTLeFgQznSte6xR/zEf3V5cpqJRmaOmN2e0TRX9647zj0fHjMk+0k0FjnGHHh+zDX3wyWo0li58PxjzhzwF3mPM6SyDoJXdXkszJfQkRhGzkfpkNqWcMY2b1qaKu/Li5KIzPOHCm9PONweDSl8y5qGoXsS9fRhYX7VGSqPcSnvbR7DzB92XJRkcdA5ymoA5+eDccoFWPCcz+dD/5nd+4c9m9RyUznOukgJCoxDKulF15mZRcXOGZHUvyigorHcb5TTZjqLjC38q7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lDC9UwmxUbSp8YRmd6egCG8dnmLKJEmCL4ydwEBsSRM=;
 b=TfQZwtI4ZkLYdfHBdN0+qi4Qc4o+R8NxCCaq8y+aBd1hlY4Mar408+/IWvkdh13T38rXgj6uzSetISLPWHVS1ixBi474TAVGXwYceHdPcvFVuasM6FUkFzsLHNULbJFXMUIy7fKGCi6QnaQEhegvZBpclUBKfS26Rag/mpZYBQlf+UxKLiygb1C3b+hBENFZo8VYt0XaUnvNcTJieABS4Xdlf1+zhztliw7JjhgaG6Xdlw1re86ugEEZ+8jgnxT8CQH5W6ZhzO76+/TIqXsrLobQUALrE2P4MPvO+gPPgx7SceaLFY7DUnwr/Jos048PJlLVKi8B3jCF4BzwbUewWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDC9UwmxUbSp8YRmd6egCG8dnmLKJEmCL4ydwEBsSRM=;
 b=ODLHQhmm4AXqMcg1HhPJoDcteXLRz5xvnaSC041of2c8+m4i7DL8HLc/vY2PbftWMoC5iLl3JSq2DhzBJK1Iq3RmuxWhIt+sT7z9eNGMMtIRRGFGfYOLG/oXZFboZOAYVLAqrHMZPzjoTz6/LJzU4Dy5Inqk6dAIa0SdiirJeiw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by BYAPR08MB4871.namprd08.prod.outlook.com
 (2603:10b6:a03:71::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Sat, 22 Oct
 2022 04:25:47 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::afa7:70e3:c2c9:b680]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::afa7:70e3:c2c9:b680%7]) with mapi id 15.20.5723.034; Sat, 22 Oct 2022
 04:25:47 +0000
Date:   Fri, 21 Oct 2022 23:25:41 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Job Noorman <job@noorman.info>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Luca Weiss <luca@z3ntu.xyz>, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH v4 2/3] Input: add driver for Himax hx83112b touchscreen
 devices
Message-ID: <Y1NwxQ5DbusemrFc@nixie71>
References: <20221017100409.189293-1-job@noorman.info>
 <20221017100409.189293-3-job@noorman.info>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017100409.189293-3-job@noorman.info>
X-ClientProxiedBy: SN6PR01CA0019.prod.exchangelabs.com (2603:10b6:805:b6::32)
 To SN4PR0801MB3774.namprd08.prod.outlook.com (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|BYAPR08MB4871:EE_
X-MS-Office365-Filtering-Correlation-Id: 50f7cd50-d1a6-432c-fb3f-08dab3e57e2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gSsGtzGpNZCN0M5X18rF7rx/Sl3EXuZsC961lzweR4P3FfDyA2xYSrQOlLDx1/rRRbOcXrc8CeGldCVhDxLdH6hJ6d74IKXJBNZDxOaP8bAVrn4f+y/zs1O+N3snUCiknl3BkklmcF+VUZjxahfu5fYnBtnEQ6iTZApNsqY+JyHJxekE/vpRBmnYNXx+6DzWfFGIyMxVXpNUIOt0Q/ZUyOCp4XhkxYAqtW0k6MtAJbadH8bWdxFEvi26P6TLCLi8w8+L+J9jz17QOolW7m7xXc5CmbxsKIZz0PzqzuKHizeEN6gXjjRL7vXsfIZpPNgThCLRrTBGDwiiIFXWg2IhI373o+tkTAxDNrEq9VOiPHC9x22NtJt/imWd/2X6ehbsUEtME1DOhv3jl2JPb7ZZm8F9zsdkmNt/FzOE6o4wWYxFO9oRhiEEgi4iBVIq212A6Y0ePXQS06xwMlsR2EVXUDgiqjxtM9jwCuUA5sVWgQUcv9QMVLHc6Y1GhVNdm9xDxct3bq7Ah5ZaNCYcKN2TMP7ni39mvXAHxrelqSbb2G24l3PWVPt6KOlrWWEpEAXuCAn/4AGqcZMJOqDPvxSt8JYNFVequkx5ZZ7f7KaZmMGCXpHVR1jRoAFV6RZR8/r/PHtXqD48ixOz5lqFjYJVFFBAm0yqrlYFN0UPqy3ykmdVBHzZggvCPQNdYYPIAqebU02KWzTnDzB87j16CD/gMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39830400003)(366004)(396003)(136003)(346002)(376002)(451199015)(66476007)(66556008)(8676002)(66946007)(4326008)(9686003)(478600001)(6666004)(2906002)(6486002)(6506007)(6512007)(26005)(6916009)(316002)(86362001)(54906003)(186003)(83380400001)(33716001)(8936002)(30864003)(38100700002)(5660300002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cqD4HZk6JGtpsgxGl8rAjO3SP2fh1/13KXaaFkPMSK5cs35XLQ08UY792Uk5?=
 =?us-ascii?Q?WRoP1wL6tHelnpoVMtKQoFG4boTpmeY95rj86bL/K/367nvSR5T31oA/WfwP?=
 =?us-ascii?Q?ADOkfNmWbMmtzoHC3CNtQatAwcT/tlilAENYoH6UhZC5BhisTXcAjx5/mxoO?=
 =?us-ascii?Q?kYcdO47pwYSwL/7Vt3FEp35jqAYCviH4mxcH8SoFEcANEf6OFSc7pXWEuDpI?=
 =?us-ascii?Q?V4Y0BPiz3fONjWVjQximRjU2d+EcL4WL1Zm3LThwE0dYxmCCX/na5QfmYbIu?=
 =?us-ascii?Q?7RAje5LefEUi1EYGtQBhe664D4pbzv99v8rz9lVCVFshDUF5S91oFFEpwFJj?=
 =?us-ascii?Q?G4y45Y5rcGS/Za9hYD5IETiUnDKcXLssaC0eCR5yE/4REJ59rzdE2rG1Rt/m?=
 =?us-ascii?Q?K+yEmUy5aOoJXtii3yXflovw/2d3tdNa40s4mB6+qb4roIcUJHGQc4SgS0xF?=
 =?us-ascii?Q?W8SubYobFZOJKjlKkk/KQg0tmiVj25tm5z8aRaTu6JYYXuDb77HExDEOMraq?=
 =?us-ascii?Q?xYgmUOmg0XTJYOILeuwHcKSQNYPlNu7Xh4mKFJmT1OHfIPrVExgqE8negC4u?=
 =?us-ascii?Q?PY4Z9ULn0p5fxEUVLR2YfNqqSUXCMDvlALupyYIJnLyL+lEJ4BdfwZsbutlm?=
 =?us-ascii?Q?NSiqHqE8Z2C8M/t/wvHpRPCdaNBPz7S52wrqsyTqzQJ6oh82VqvfK9PV+SQa?=
 =?us-ascii?Q?C3OTvbtFQU45sAIAWS0wecFxcEZ9R79J0eONpgbRpIt4Y40uj/qNImrAIL0O?=
 =?us-ascii?Q?F1x7XsnknFItrB8vojm2LkrWNvaB5GM8JrHw8+OcZZEojArgdFso66Ylny8D?=
 =?us-ascii?Q?trs+NwIpCvu6UtnZsUD4AhyOjHmeTLoNlBuxgnc0X1jkAXt78SK+zZMh0u9h?=
 =?us-ascii?Q?0rN/WAuTXyllz/v3ANjt5Sa/laxTrUZXrVcx/HnFJugb+y+YcF/ciqb527r7?=
 =?us-ascii?Q?r5f+qWDx4dHNCnBhyGryAd6h5ET8hehkBot5/NvuxPfCh0Oex+4RNp9mE08a?=
 =?us-ascii?Q?WntpDEWE394L9nmFOn5QOUOUZZWvfeepyuZVZU7hYOEEJfg9OWGWpYIcGdc4?=
 =?us-ascii?Q?ziAeAArOkOdiOYadB1zMUHDmgIJxTQRYdfU0p5rRNyiGaI7FXPE8gm9XuZz4?=
 =?us-ascii?Q?4QT7RApFg2FLiSQxMtnURwF8d8P47cqD2ftmT1GkVzH8N51vywxjoOPopAwN?=
 =?us-ascii?Q?hQTKAGpDuvgNBxBchXY2LzgPofA2ThO72BJe9fwqGiXxhwNoDz05njMhpZPj?=
 =?us-ascii?Q?6aMriTQaW5V3wey7flOUz7ZEs8qC0nzpu+su8cau1OmNaMyrbJfsIhp3x1Wg?=
 =?us-ascii?Q?EP7w+rUCnjtsnLslrw6wgWXiydHnCvM5Iidx/wQE+4brjYs5UcHsrb7RSF9h?=
 =?us-ascii?Q?5LuXirUEW9IVnremHEB+v+WlLsSLhEKUVN0c3o6zLdTcu0of0Kds5sQQIc55?=
 =?us-ascii?Q?7QTizNSrIPPVZ1Uo0d0T2QRptzssO5HLFHcZr1+C3E4X5d73WGIx1DmfK/fF?=
 =?us-ascii?Q?AOyWfRmI4KWBAbU7Jok32Mk6xcsbsrVRIHA2S/CObKXyJIHCLYCHOfNWPOFF?=
 =?us-ascii?Q?vViCDgBlRr1oi8/r+iyHPUjqZmgtHFISbmTGkkBK?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50f7cd50-d1a6-432c-fb3f-08dab3e57e2e
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2022 04:25:47.5830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aWtdzeRgWvoB6eLlkMN6ISKdu6KqTwM6/qzXz2pDY7AlAUnsVPi3TejUJHHgtsSfwKP/XcvMkw5QV+78C0HgLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4871
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Job,

Great work so far, just a few remaining comments.

On Mon, Oct 17, 2022 at 12:04:07PM +0200, Job Noorman wrote:
> This patch adds support for Himax hx83112b touchscreen devices. As there
> are no publicly available data sheets for these devices, the
> implementation is based on the driver of the downstream Android kernel
> used in the Fairphone 3. This patch is a complete rewrite, though, and
> the code bears no resemblence to the original implementation.
> 
> The driver has been tested on the aforementioned phone.
> 
> Signed-off-by: Job Noorman <job@noorman.info>
> ---
>  MAINTAINERS                                |   1 +
>  drivers/input/touchscreen/Kconfig          |  11 +
>  drivers/input/touchscreen/Makefile         |   1 +
>  drivers/input/touchscreen/himax_hx83112b.c | 367 +++++++++++++++++++++
>  4 files changed, 380 insertions(+)
>  create mode 100644 drivers/input/touchscreen/himax_hx83112b.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2418bffe9187..51a03f9586f1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9099,6 +9099,7 @@ M:	Job Noorman <job@noorman.info>
>  L:	linux-input@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/input/touchscreen/himax,hx83112b.yaml
> +F:	drivers/input/touchscreen/himax_hx83112b.c
>  
>  HIPPI
>  M:	Jes Sorensen <jes@trained-monkey.org>
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index dc90a3ea51ee..113b7dd7da2f 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -1379,4 +1379,15 @@ config TOUCHSCREEN_ZINITIX
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called zinitix.
>  
> +config TOUCHSCREEN_HIMAX_HX83112B
> +	tristate "Himax hx83112b touchscreen driver"
> +	depends on REGMAP_I2C

I think there was a misunderstanding here. You need to depend on I2C as
you did before, but additionally select REGMAP_I2C. See TSC2004 for one
such example.

> +	help
> +	  Say Y here to enable support for Himax hx83112b touchscreens.
> +
> +	  If unsure, say N.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called himax_hx83112b.
> +
>  endif
> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
> index 557f84fd2075..0f8bf79e01fe 100644
> --- a/drivers/input/touchscreen/Makefile
> +++ b/drivers/input/touchscreen/Makefile
> @@ -116,3 +116,4 @@ obj-$(CONFIG_TOUCHSCREEN_ROHM_BU21023)	+= rohm_bu21023.o
>  obj-$(CONFIG_TOUCHSCREEN_RASPBERRYPI_FW)	+= raspberrypi-ts.o
>  obj-$(CONFIG_TOUCHSCREEN_IQS5XX)	+= iqs5xx.o
>  obj-$(CONFIG_TOUCHSCREEN_ZINITIX)	+= zinitix.o
> +obj-$(CONFIG_TOUCHSCREEN_HIMAX_HX83112B)	+= himax_hx83112b.o
> diff --git a/drivers/input/touchscreen/himax_hx83112b.c b/drivers/input/touchscreen/himax_hx83112b.c
> new file mode 100644
> index 000000000000..6f76fe48cfdd
> --- /dev/null
> +++ b/drivers/input/touchscreen/himax_hx83112b.c
> @@ -0,0 +1,367 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Driver for Himax hx83112b touchscreens
> + *
> + * Copyright (C) 2022 Job Noorman <job@noorman.info>
> + *
> + * This code is based on "Himax Android Driver Sample Code for QCT platform":
> + *
> + * Copyright (C) 2017 Himax Corporation.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/i2c.h>
> +#include <linux/input.h>
> +#include <linux/input/mt.h>
> +#include <linux/input/touchscreen.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/regmap.h>
> +
> +#define HIMAX_ID_83112B 0x83112b
> +
> +#define HIMAX_MAX_POINTS 10
> +

Nit: extraneous NL.

> +
> +#define HIMAX_REG_CFG_SET_ADDR	 0x00
> +#define HIMAX_REG_CFG_INIT_READ	 0x0c
> +#define HIMAX_REG_CFG_READ_VALUE 0x08
> +#define HIMAX_REG_READ_EVENT	 0x30
> +
> +#define HIMAX_CFG_PRODUCT_ID 0x900000d0
> +
> +#define HIMAX_INVALID_COORD 0xffff

As I mention, I personally find #defines easier to read when aligned.
However, I do not feel strongly about it.

> +
> +struct himax_event_point {
> +	__be16 x;
> +	__be16 y;
> +} __packed;
> +
> +struct himax_event {
> +	struct himax_event_point points[HIMAX_MAX_POINTS];
> +	u8 majors[HIMAX_MAX_POINTS];
> +	u8 pad0[2];
> +	u8 num_points;
> +	u8 pad1[2];
> +	u8 checksum_fix;
> +} __packed;
> +
> +static_assert(sizeof(struct himax_event) == 56);
> +
> +struct himax_ts_data {
> +	struct gpio_desc *gpiod_rst;
> +	struct input_dev *input_dev;
> +	struct i2c_client *client;
> +	struct regmap *regmap;
> +	struct touchscreen_properties props;
> +};
> +
> +static const struct regmap_config himax_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 32,
> +	.val_format_endian = REGMAP_ENDIAN_LITTLE,
> +};
> +
> +static int himax_read_config(struct himax_ts_data *ts, u32 address, u32 *dst)
> +{
> +	int error;
> +
> +	error = regmap_write(ts->regmap, HIMAX_REG_CFG_SET_ADDR, address);
> +	if (error)
> +		return error;
> +
> +	error = regmap_write(ts->regmap, HIMAX_REG_CFG_INIT_READ, 0x0);
> +	if (error)
> +		return error;
> +
> +	error = regmap_read(ts->regmap, HIMAX_REG_CFG_READ_VALUE, dst);
> +	if (error)
> +		return error;
> +
> +	return 0;
> +}
> +
> +static void himax_reset(struct himax_ts_data *ts)
> +{
> +	gpiod_set_value_cansleep(ts->gpiod_rst, 1);
> +
> +	/* Delay copied from downstream driver */
> +	msleep(20);
> +	gpiod_set_value_cansleep(ts->gpiod_rst, 0);
> +
> +	/*
> +	 * The downstream driver doesn't contain this delay but is seems safer
> +	 * to include it. The range is just a guess that seems to work well.
> +	 */
> +	usleep_range(1000, 1100);
> +}
> +
> +static int himax_read_product_id(struct himax_ts_data *ts, u32 *product_id)
> +{
> +	int error;
> +
> +	error = himax_read_config(ts, HIMAX_CFG_PRODUCT_ID, product_id);
> +	if (error)
> +		return error;
> +
> +	*product_id >>= 8;
> +	return 0;
> +}
> +
> +static int himax_check_product_id(struct himax_ts_data *ts)
> +{
> +	int error;
> +	u32 product_id;
> +
> +	error = himax_read_product_id(ts, &product_id);
> +	if (error)
> +		return error;
> +
> +	dev_dbg(&ts->client->dev, "Product id: %x\n", product_id);
> +
> +	switch (product_id) {
> +	case HIMAX_ID_83112B:
> +		return 0;
> +
> +	default:
> +		dev_err(&ts->client->dev,
> +			"Unknown product id: %x\n", product_id);
> +		return -EINVAL;
> +	}
> +}
> +
> +static int himax_input_register(struct himax_ts_data *ts)
> +{
> +	int error;
> +
> +	ts->input_dev = devm_input_allocate_device(&ts->client->dev);
> +	if (!ts->input_dev) {
> +		dev_err(&ts->client->dev, "Failed to allocate input device\n");
> +		return -ENOMEM;
> +	}
> +
> +	ts->input_dev->name = "Himax Touchscreen";
> +
> +	input_set_capability(ts->input_dev, EV_ABS, ABS_MT_POSITION_X);
> +	input_set_capability(ts->input_dev, EV_ABS, ABS_MT_POSITION_Y);
> +	input_set_abs_params(ts->input_dev, ABS_MT_WIDTH_MAJOR, 0, 200, 0, 0);
> +	input_set_abs_params(ts->input_dev, ABS_MT_TOUCH_MAJOR, 0, 200, 0, 0);
> +
> +	touchscreen_parse_properties(ts->input_dev, true, &ts->props);
> +
> +	error = input_mt_init_slots(ts->input_dev, HIMAX_MAX_POINTS,
> +				    INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED);
> +	if (error) {
> +		dev_err(&ts->client->dev,
> +			"Failed to initialize MT slots: %d\n", error);
> +		return error;
> +	}
> +
> +	error = input_register_device(ts->input_dev);
> +	if (error) {
> +		dev_err(&ts->client->dev,
> +			"Failed to register input device: %d\n", error);
> +		return error;
> +	}
> +
> +	return 0;
> +}
> +
> +static u8 himax_event_get_num_points(const struct himax_event *event)
> +{
> +	if (event->num_points == 0xff)
> +		return 0;
> +	else
> +		return event->num_points & 0x0f;
> +}
> +
> +static bool himax_process_event_point(struct himax_ts_data *ts,
> +				      const struct himax_event *event,
> +				      int point_index)
> +{
> +	const struct himax_event_point *point = &event->points[point_index];
> +	u16 x = be16_to_cpu(point->x);
> +	u16 y = be16_to_cpu(point->y);
> +	u8 w = event->majors[point_index];
> +
> +	if (x == HIMAX_INVALID_COORD || y == HIMAX_INVALID_COORD)
> +		return false;
> +
> +	input_mt_slot(ts->input_dev, point_index);
> +	input_mt_report_slot_state(ts->input_dev, MT_TOOL_FINGER, true);
> +	touchscreen_report_pos(ts->input_dev, &ts->props, x, y, true);
> +	input_report_abs(ts->input_dev, ABS_MT_TOUCH_MAJOR, w);
> +	input_report_abs(ts->input_dev, ABS_MT_WIDTH_MAJOR, w);
> +	return true;
> +}
> +
> +static void himax_process_event(struct himax_ts_data *ts,
> +				const struct himax_event *event)
> +{
> +	int i;
> +	int num_points_left = himax_event_get_num_points(event);
> +
> +	for (i = 0; i < HIMAX_MAX_POINTS && num_points_left > 0; i++) {
> +		if (himax_process_event_point(ts, event, i))
> +			num_points_left--;
> +	}
> +
> +	input_mt_sync_frame(ts->input_dev);
> +	input_sync(ts->input_dev);
> +}
> +
> +static bool himax_verify_checksum(struct himax_ts_data *ts,
> +				  const struct himax_event *event)
> +{
> +	u8 *data = (u8 *)event;
> +	int i;
> +	u16 checksum = 0;
> +
> +	for (i = 0; i < sizeof(*event); i++)
> +		checksum += data[i];
> +
> +	if ((checksum & 0x00ff) != 0) {
> +		dev_err(&ts->client->dev, "Wrong event checksum: %04x\n",
> +			checksum);
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> +static int himax_handle_input(struct himax_ts_data *ts)
> +{
> +	int error;
> +	struct himax_event event;
> +
> +	error = regmap_raw_read(ts->regmap, HIMAX_REG_READ_EVENT, &event,
> +				sizeof(event));
> +	if (error) {
> +		dev_err(&ts->client->dev, "Failed to read input event: %d\n",
> +			error);
> +		return error;
> +	}
> +
> +	if (!himax_verify_checksum(ts, &event)) {
> +		/*
> +		 * We cannot process the current event when it has an invalid
> +		 * checksum but we don't consider this a fatal error.
> +		 */
> +		return 0;
> +	}
> +
> +	himax_process_event(ts, &event);
> +	return 0;

This seems a bit cleaner as:

        /* optional helpful comment */
        if (himax_verify_checksum(...))
                himax_process_event(...);

        return 0;

> +}
> +
> +static irqreturn_t himax_irq_handler(int irq, void *dev_id)
> +{
> +	struct himax_ts_data *ts = dev_id;
> +	int error = himax_handle_input(ts);

Similar to what was suggested elsewhere in the last revision:

        int error;

        error = himax_handle_input(...);

> +
> +	if (error)
> +		return IRQ_NONE;
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int himax_probe(struct i2c_client *client,
> +		       const struct i2c_device_id *id)
> +{
> +	int error;
> +	struct device *dev = &client->dev;
> +	struct himax_ts_data *ts;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
> +		dev_err(dev, "I2C check functionality failed\n");
> +		return -ENXIO;
> +	}
> +
> +	ts = devm_kzalloc(dev, sizeof(*ts), GFP_KERNEL);
> +	if (!ts)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(client, ts);
> +	ts->client = client;
> +
> +	ts->regmap = devm_regmap_init_i2c(client, &himax_regmap_config);
> +	error = PTR_ERR_OR_ZERO(ts->regmap);
> +	if (error) {
> +		dev_err(&client->dev,
> +			"Failed to initialize regmap: %d\n", error);
> +		return error;
> +	}
> +
> +	ts->gpiod_rst = devm_gpiod_get(&ts->client->dev, "reset",
> +				       GPIOD_OUT_HIGH);
> +	error = PTR_ERR_OR_ZERO(ts->gpiod_rst);
> +	if (error) {
> +		if (error != -EPROBE_DEFER)
> +			dev_err(&ts->client->dev,
> +				"Failed to get reset GPIO: %d\n", error);
> +		return error;
> +	}

This is just my $.02, but I do not think we need to conditionally
squelch the error message here.

> +
> +	himax_reset(ts);
> +
> +	error = himax_check_product_id(ts);
> +	if (error)
> +		return error;
> +
> +	error = himax_input_register(ts);
> +	if (error)
> +		return error;
> +
> +	return devm_request_threaded_irq(&client->dev, client->irq, NULL,
> +					 himax_irq_handler, IRQF_ONESHOT,
> +					 client->name, ts);
> +}
> +
> +static int himax_suspend(struct device *dev)
> +{
> +	struct himax_ts_data *ts = dev_get_drvdata(dev);
> +
> +	disable_irq(ts->client->irq);
> +	return 0;
> +}
> +
> +static int himax_resume(struct device *dev)
> +{
> +	struct himax_ts_data *ts = dev_get_drvdata(dev);
> +
> +	enable_irq(ts->client->irq);
> +	return 0;
> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(himax_pm_ops, himax_suspend, himax_resume);
> +
> +static const struct i2c_device_id himax_ts_id[] = {
> +	{ "hx83112b", 0 },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(i2c, himax_ts_id);
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id himax_of_match[] = {
> +	{ .compatible = "himax,hx83112b" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, himax_of_match);
> +#endif
> +
> +static struct i2c_driver himax_ts_driver = {
> +	.probe = himax_probe,
> +	.id_table = himax_ts_id,
> +	.driver = {
> +		.name = "Himax-hx83112b-TS",
> +		.of_match_table = of_match_ptr(himax_of_match),
> +		.pm = pm_sleep_ptr(&himax_pm_ops),
> +	},
> +};
> +module_i2c_driver(himax_ts_driver);
> +
> +MODULE_AUTHOR("Job Noorman <job@noorman.info>");
> +MODULE_DESCRIPTION("Himax hx83112b touchscreen driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.38.0
> 

Kind regards,
Jeff LaBundy
