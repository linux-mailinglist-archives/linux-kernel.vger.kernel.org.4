Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03200702B35
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 13:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240682AbjEOLPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 07:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240350AbjEOLPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 07:15:09 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2042.outbound.protection.outlook.com [40.107.8.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED046172D;
        Mon, 15 May 2023 04:15:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i07JPcARkzlAw6zNU840Tx+x9DXDv9UEHa3/ZmJ2qTa+1q5gM7Z0rolOKre6BhS2p4J7pfLoQypKA2BgY2p/2vQMC67igXBtKeNLkZBW2wumJoXVsjfBWkgo6ZfpS0Mxh5Dy5BzK6/HL2zKxH041orU1VnI0KLeqoO7ymplrnYRiVdFRWcdyHumt7ZWnrDCwAEV/BxFQccwvV8n5+q49IbKQ5/A2P4zJpCLism5wS/e/R9mtVun5Pmhy7NrxPh+amj4pFjQ+mCjh+p2eL1DyBUfY0yeLwwnY7XBKquhRulkBmVNOaI15rKXVC5ey9oSB4ERaNZu/uOuQ9eOUiY/Wgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QAVkdW5sSh61pSTDhHUq75buU12nbKFmoa5EUwJVBxc=;
 b=YMbLVFP8QS4dkGiAtEm3ClgGsV7ZyYg4TqVkJbByZLIZVlimr421wM+eZOLA49TY4o3hiAr+IQ5aV2lW3kDZhS6nhd/eiqvcPAjm5RMS9tJyLhbSlF+OUIAq6APPdpGnI6hKOnQBe49bKAcZ1L2IZifIosVdOZ3XeDiXeoN1UfAHzTSOWBwkXRf1kDQR8EVBvdhXnTLu/rynk1PUmrN6tcO+C0aLu7rJarO0RD1Cr245agx/RQ1IgZF9wI8JZ8aLcu1o5humoWRnVQIj+FkBK8MAOK5fM2meYiM7BLmWVfZAIWvDrUlM9lM3X3++DGYBnHhU5Ljpi3rjc5gFgwCsIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QAVkdW5sSh61pSTDhHUq75buU12nbKFmoa5EUwJVBxc=;
 b=AXz9nV5f365HNqk5bAWexYiaktj5V9LA73+fxpfKpU2WfhSVtahjMgq0REBoFidilu2wT55q66lxUzdiPoxIuN/2UuFBfZllNxhuIXDHq671Lxk7T61ZeDHM0cOGuvXPXtU8ea2MIcZUxTDKGP3F1wU7p5RgS8OD9Id6nZGm7e3otIzLshqyxoO7Suqu31Gc3WURxIDauj5T+J3BK2b3VbjUjcXcbXS3IH4TNLawPRA571chNedjeINQT3wjoHgjU7xXDY0OCqiWhJPqn4iVSvvSq/ktpZZcZlQtTLSJ9nkzWtm4xls7U5rJ2nbMNWu4qKEv7o8KvOe2uu2ha1lJbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by GVXPR10MB5814.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:6c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 11:15:05 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::aa98:fb34:754f:8958]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::aa98:fb34:754f:8958%4]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 11:15:05 +0000
Date:   Mon, 15 May 2023 13:14:56 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2 2/3] leds: simatic-ipc-leds-gpio: split up into
 multiple drivers
Message-ID: <20230515131456.5aaabb4c@md1za8fc.ad001.siemens.net>
In-Reply-To: <Y/+LLICwh3T25IGv@smile.fi.intel.com>
References: <20230301170215.23382-1-henning.schild@siemens.com>
        <20230301170215.23382-3-henning.schild@siemens.com>
        <Y/+LLICwh3T25IGv@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0136.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::18) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5780:EE_|GVXPR10MB5814:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cc00c33-5b60-44f7-7886-08db5535a247
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zZypH8VmDnkbqLZlPbQ0lbXnrQ+u2yBNdCj67wEQ+lAYPro1md6ZOAITn1a1DzpMpPe8ptpInEHcU/yYah5yM1lE49a5vAfwFSUKIDQSrybfSTyDXeen07D8j63xkwzyIGAYrjtCw5//kmjZLfi9h4jE5izOMPPRGqXSPKtTdpaRDpDyavfCxly01qQPyTTG8HvTWXjL6C7wy1MU40Oi5QO4EAVyErN5/bCh/9PLWAv/OgWAFULXMuAU/2B1ucUzLNwd9F002GMg/um75p3yuS8y6djKzO9vOHKSwz6BNXlv8AKX028OF7+n8zvp81iFc7X7SPofnY6y60LBkKi+1xsooRMacPxuXP5oVrkqXqtbXdHuo1OgUzFadPe7Tpwh7bh6PFPcIuinFtCWYIfApe9fWrWb69OqruJTnGjbQpVOjhsWsXQ8b1E3WdbkVxqaTy7i0NkN5HVo6UbqNT3MJN2483ZWiL6gT6X57HSSdVP1jpZlDBUrgvZ/KsB6rrsWARjjp37mj1zpXwx5teTUtkGyE1A/VUDAIe+S38DwxntSEguYdXDi/RFHPR3KjTIa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(376002)(39860400002)(366004)(451199021)(6916009)(4326008)(6666004)(8936002)(8676002)(66476007)(82960400001)(66556008)(316002)(41300700001)(478600001)(66946007)(54906003)(38100700002)(186003)(9686003)(6506007)(1076003)(2906002)(83380400001)(6512007)(86362001)(44832011)(5660300002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8xNTmUzwKPTvZEypXIcM/c7eszo6j+cxlSXKWllTL65HhEfA9GVn0HcOyxug?=
 =?us-ascii?Q?r+/h+uUB5lYZrJHGGqCjrDHxRy2rlPM+0FhXGKk98atmudJh9FZFCN9OWWfY?=
 =?us-ascii?Q?iQVCWVD3eF1AtWUVIe2F6Mo/uxuc8iz0H8DSCbqG8uRT4GsrX0bCqzKviLDI?=
 =?us-ascii?Q?zHRxsmHbPgM6pZSIDn5nP+j5R7XeZ98SxFzIQYQCT+N8MiophYx3z+UWIzYl?=
 =?us-ascii?Q?HS8SAM8LZGgZp7pv6zm0GzRzeU34f7KGQiR+/4JtPtxwpvTvDKxNxgGiHPk8?=
 =?us-ascii?Q?8MX75rpN+MWAD4sytAqKmC5sKtyEkuOdZQKB1xrF5pob4mvVdqyE1X/B+ru/?=
 =?us-ascii?Q?W6ZXA2I02HakMVL9Cyj4I9KuJbfBrg1rpvBSU6KK47svVAVIWieJpSYzsaLq?=
 =?us-ascii?Q?AdNaVKxwoYFNl0hLx701kLVjcuekSYXXKKh463yzsOXqYkgd+kUw0sz2110S?=
 =?us-ascii?Q?f5IwwDujLstzUbAPWjY4wufBrSB3vw5JOgZuQtnwyXgFni5tV3A0LjYC4Cxa?=
 =?us-ascii?Q?DYOICeGRAMlyGJYyMhWapYkNPQgThi4D87c5Rhva9A+keqk5PE3bfTadQO/7?=
 =?us-ascii?Q?d+qwQk3dtnFrKx7HvD3HPmULWClecEvvvMoJmJ3cznB+39rRux6vLULI+6wY?=
 =?us-ascii?Q?azHpLqrwjtXR46PHrhood5FMgaiukNzYJlHUnV0xc/UdZDn50eZ0upATeB31?=
 =?us-ascii?Q?uTezE7J3gXoz3DDSJwplQwG6AGe6uz4lHcO/5TDP2bimM6H1eggqriFCyxd4?=
 =?us-ascii?Q?nRjtwmqnD42xEU4LDkZGAoF8hOhLpb6qqbwcsKzlP14rFBUy1kLZatyWyT8D?=
 =?us-ascii?Q?HdL9WoRcJsnthIhK/c/mAkRZf/6lfJ+P3SXsl8Gx+69Uc4ThZ2pv0sCG6otC?=
 =?us-ascii?Q?ovTpQ6Dx5cjd++tsLKJAULtUxKN43kKmJQ78D/8q4jVoVAOEBDv4JzWN+wmw?=
 =?us-ascii?Q?RlXt62EauVlW9ZdBc6aIZ0XecWU8A6ZEkpOH4ylzY7NOQvOIrwJjlPPqs3Gc?=
 =?us-ascii?Q?Ffk9+kjBpAayMaj2aaVw0MlbE7B6z9M3OH9Sn1uga20LQYf/iPaUTwRYCKdt?=
 =?us-ascii?Q?1U10gNvATIAtfaIUCSDj1pcH+9BxPkkNbD8O35v15LyTRFLqDyHWjaz9WZUL?=
 =?us-ascii?Q?swyLufxpGhTfyZjXQImXC4JjkIgYH2Ib/Xt6rdPrOFokkmO9rIHIFmudhae2?=
 =?us-ascii?Q?/I9nOEjmg/q9pbbxQcDCWMnPIYPb2RY2fX1RcdaHwle+ZwHgMSipDlz4F7AN?=
 =?us-ascii?Q?+dNNmfIGKFnuADMIwDBIePDNC1Ede6d+hBLobZz1/jTlS0Czq1br4ByVCQLt?=
 =?us-ascii?Q?D7Vyfrw6Ej8rpzNXHW6olmQqWLKoksN5tUN/pZJ13y0mUphYNzOiuWUwHTPU?=
 =?us-ascii?Q?ijfOTGmtMJ5i4Tep7nYcwSNUZfmkJ8vGF0gZ7ozGFzpoKKvSMCPCSlAhf8DD?=
 =?us-ascii?Q?b1t6okxS8e4nBe9bKRriAyhVpN0dwHKUbw1AgmGD7xmV/kwf/gFoaOzjGJUg?=
 =?us-ascii?Q?o3oz9nz3rF6f8oRPhjps8chcRh38wH5ZqtxgdPS//aQTm/VYZncWllhszynp?=
 =?us-ascii?Q?MsUdFgETmmPiDVHb0WkYwyAY2Z6xUuglUy9T9kKMERCBD+dwEV+5bjjLKusq?=
 =?us-ascii?Q?ksxRUmIXvYc/ZQ/hhNKG47pLcDlbgFHl5sYHOKytMK4S2WeUvlOHZ/K3Nous?=
 =?us-ascii?Q?aiS4rA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cc00c33-5b60-44f7-7886-08db5535a247
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 11:15:05.1724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T051sMd+G5jVLjVLW/6cKIx24Y1UV3EFuhKXlhF+Ued8K/zg16gZAIpen/NzR5tikFLtL9XmeqAvK47ky1FMM2CMmDWadk8CHKHOSOlcoxA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB5814
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
> > two drivers and a common header.  
> 
> ...
> 
> >  .../simple/simatic-ipc-leds-gpio-apollolake.c |  64 +++++++
> >  .../leds/simple/simatic-ipc-leds-gpio-core.c  | 103 ++++++++++++
> >  .../simple/simatic-ipc-leds-gpio-f7188x.c     |  64 +++++++
> >  drivers/leds/simple/simatic-ipc-leds-gpio.c   | 159
> > ------------------  
> 
> I'm wondering if you have used -M -C when creating this patch.
> 
> ...
> 
> > +#include <linux/gpio/machine.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/leds.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/platform_data/x86/simatic-ipc-base.h>  
> 
> + Blank line?

Will be added in 3 files in v3.

> > +#include "simatic-ipc-leds-gpio.h"  
> 
> ...
> 
> > +	.table = {
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
> > +	},  
> 
> Shouldn't this have the terminator entry?
> 
> ...
> 
> > +static struct gpiod_lookup_table simatic_ipc_led_gpio_table_extra
> > = {
> > +	.dev_id = NULL,  
> 
> As per previous patch.

comment will be added in p1 and p2 and be in v3.

> > +	.table = {
> > +		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 56, NULL,
> > 6, GPIO_ACTIVE_LOW),
> > +		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 59, NULL,
> > 7, GPIO_ACTIVE_HIGH),
> > +	},  
> 
> As per above.
> 
> > +};  
> 
> ...
> 
> > +	.driver = {
> > +		.name = KBUILD_MODNAME,  
> 
> Strictly speaking this is an ABI (as something may instantiate the
> driver from the user space or elsewhere by this name. At the same
> time this may change with the file name change.
> 
> Personally I prefer explicit string literal here.
> 
> > +	},  
> 
> ...
> 
> > +  
> 
> Redundant blank line.

Will be removed in v3 in 3 files.

Henning

> > +module_platform_driver(simatic_ipc_led_gpio_apollolake_driver);  
> 
> ...
> 
> > +MODULE_ALIAS("platform:" KBUILD_MODNAME);  
> 
> Why? HAve you missed MODULE_DEVICE_TABLE()?
> 
> ...
> 
> > +++ b/drivers/leds/simple/simatic-ipc-leds-gpio-f7188x.c  
> 
> Similar comments as per above.
> 

