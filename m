Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0445C65B41D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 16:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236350AbjABPXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 10:23:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236335AbjABPWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 10:22:38 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2054.outbound.protection.outlook.com [40.107.20.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D126434;
        Mon,  2 Jan 2023 07:22:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DLX8pBOgNw8NFH9Ex8pZrzOJ5ekDSJ7Cy0GOuTjImiw9ZU0kp+pqRGGIrVzDBW4+3thsgu1OtPt9i+OOg5WR42yWHX5rklD9UQp3435A2bKaHMonQCch+5rY3Mfrso5HKzLPbJ3r32wg17olSByJlr+fJV8aZlN5TuYwSQ50ePLYEwFKakJPuoQfJe6qP1APhYuynuQTmbx3Lw1Wv5Uy6tVmiOomSWQL8F4BEhW81NAKyX6em/A5crQuO+aOLI+gBKGIRDW5BEelFltyA0JKr8oOuv3al24affl2YRbi5PhNT07YTw0zLoAyxcpPVBP8Pnz1512IVvm5aC4KTJydnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+2CRUjeWp8g+Sl+6DMZ8zMueGa05FjTssz2mKRmgTM=;
 b=lIa0RYoEeoqpzA7hHovdlDYEMle/ldN/kWw88Fpwz+Ty5CqfgGYlthRnn/5qDByiZ0TJTGmZvwO/8Uh16+mzGV8bYAws1+CZHWYm4NafIU8uAO8FQSoiF9V/JVS++eOc3/Iy5odPD6iHLG7R2MlS1SjvnbtRWNaSuQWe5esclZD5XT4DWM5EE1bOxj63s2UzHEO0igoFduRrclRu0C13eBoyJd6KiFFssKDRtFqy7MtoyI3mDWUrGFkiMmg5O8KxSv+5cIahNEWa6LsivjcTs3lS2BI40aCJ85VdRMaBQhuBEfayulAceBgBQKKXcbj9jv1pGPfgRaOKP0f5uinzDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+2CRUjeWp8g+Sl+6DMZ8zMueGa05FjTssz2mKRmgTM=;
 b=saEAzpL0mAyTAQ2J/5kuXuU9QKJ75MD+Lp20uyuUcLVawzIdkWXpshgoaYpRouFkBfCNqWkiJaeE/PRmfvLkLyUCjvfQQ/G8eMIZKklMwk2tSvuItA2ecMOzHnk3Dyc9vTQmYVL/4nz8CL1P3YbRK1FBiqNu0+xLTKAUBAxpeVZFqtYt+2IPVnLj8cJAvs6MeQa7J0CwzFew0IGxzRlMeHEgGxnwJH/rQ8e/vBrCoDVXUOKMWlFCiu/OSsZPKDKrYPSkORtDUF5KLF1neiv0/BlT9BktP6HHuKPgcSfYdHvaLRax/l532ppSHhX6ocZRTaEkb6x9l4hUUshuD1hhfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by DU0PR10MB5629.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:31b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.18; Mon, 2 Jan
 2023 15:22:33 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bdf0:fdeb:f955:bc79]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bdf0:fdeb:f955:bc79%3]) with mapi id 15.20.5944.019; Mon, 2 Jan 2023
 15:22:32 +0000
Date:   Mon, 2 Jan 2023 16:22:27 +0100
From:   Henning Schild <henning.schild@siemens.com>
To:     Lee Jones <lee@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v4] leds: simatic-ipc-leds-gpio: make sure we have the
 GPIO providing driver
Message-ID: <20230102162227.523d2a73@md1za8fc.ad001.siemens.net>
In-Reply-To: <Y6WX1Y9GZmvxqlCc@google.com>
References: <20221007153323.1326-1-henning.schild@siemens.com>
        <Y6WX1Y9GZmvxqlCc@google.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.35; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0039.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::22) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5780:EE_|DU0PR10MB5629:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b516c15-5837-45e6-2f7b-08daecd52b2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UZVjSsHK6WOk/9PwEQT0vrMaFPgh5tsrmTQPYCAj+zQYJkQQWzNXlKoyN301c1ng/UQHnYO3W6bKEBJW+ccDer2x7+dKXVzpWlmzqPFb98TAXVMhOvCNEfIbTex41IUiaho8YQ40xgO6rQpYVjJzTT2XEwVr3Vr0hLzV3JfrU9mtYVbPp6Fm7PsLYVfmaXY8wb0zGjDaXAu/4i9DF1cVHDkQMSLx2VVirQgeP48UDZAtLXP9oShCQkLCLlLbPjSpEqW/TtBJtxD/ZylHr4GpYQrowL/HNKEto+ip5B7/nV4evW1886vpY/IaQsGxGY1OzST1nj+CYi/W3I/X94OH7vHgkCucvtLY4IRwIYXMjJAKQtXDeKIJTQnq2yRRWHxbEzyh3Nza6ae89vpBWIDhjUGwDBZG4manrs3cworD4slOUL3iW4ST6VTbItqq+Mtq6b8EdFdn6szBtOO8bka89gz46hOk4qOWKhivv/ZKFIn1jQ5kU3Z/OgQaNxNf91nNBtI0zSwHKeWJh8dmaAsnR9zSpI2UYxhlXDrDpnUjwkXS1GP0qHcKeZCiI9ir/7N8Me8SUs+nRcbvPPuNK8gRr5H5NofTII0N3vxYEqP7/Mt2Ox9hHlSvwBpi/Y2XY5I+SokgrwxCJQA8euNbRtlVZnFVmp5+v7Iliio9J4SEX5egZadsgCPb4VXAk2YgNAq5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(376002)(396003)(136003)(39860400002)(451199015)(6506007)(6666004)(6486002)(478600001)(86362001)(82960400001)(38100700002)(1076003)(9686003)(26005)(6512007)(186003)(83380400001)(4326008)(44832011)(5660300002)(8676002)(66476007)(8936002)(66946007)(66556008)(6916009)(54906003)(41300700001)(2906002)(316002)(22166006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wa0Cjpjn8uqW90MHldq13I7cPpYShYXJ2egIU0MYtJP6x1TsdG3EGU6YoJ7T?=
 =?us-ascii?Q?WsJxOSUstzYIAxQ9GbSuI2tk+AK1e6g0ZVMSDZAtLJZ9TXNY153IBVAnHONK?=
 =?us-ascii?Q?SBhZDjkqiW144akvx7nCvb/ABKpXfRZzvUZ6SU7r+OeADoArraQjJBUc7psz?=
 =?us-ascii?Q?eITh/gTQq9jKPrUul2+jvP/mYBRf4SfAmUFGYNFTYDRafypZiNHPj5xwc9yi?=
 =?us-ascii?Q?SJSY2uIE5ckpxKz/aoQ9QH+gEeAk46+mzHj7PrrqstCq1fSAKFW41NqdxEsU?=
 =?us-ascii?Q?1jInLvXowhEz8IznfzgZTOXsftHftWP1gEm7kBT9aw5fQUNHOmO02lQEAV6j?=
 =?us-ascii?Q?MjV7rgsqdRwLoVGo6GQq56xoOQb7M/Tcbh782zs0VsQfApYAPrMd7DFTM3bd?=
 =?us-ascii?Q?YioIMLTLj8BIDSld265guo1BQFlBBxG1mKliwXqcAo6SMXNp/IPVv9u0CZCT?=
 =?us-ascii?Q?xwDwi6yZaiEp2KzEbff4MoBdmPrjhgDA9zAhjferdAv7yujASqFq5iMzLOyB?=
 =?us-ascii?Q?z21PRqOJmKIY3PCLGC01QKwqtnP/gnYxkz3Ocfgpq2vQ0o1D1xMtWcwpKZnA?=
 =?us-ascii?Q?nyrcT8vnldMw/HeagC2wxFtnSlbo8UQg1/xYtTfKNXoilR+SgkLxWhDmjygq?=
 =?us-ascii?Q?RMfw+efV49GrV3u4knGHS0FI6h8NjqXZ9ebxE5Ex9dEgD+d/8dLS568UUoES?=
 =?us-ascii?Q?Mrb5B2qV/60ECOvN7OajoW/IQK1ZOn39nZCVhreGLbHpOHZEtq2OzIztiI4q?=
 =?us-ascii?Q?mlbAsMt5oD144kQV8xpJEeNz2fqxbWCqAyUFz+Ob8P+mazHqo1esit0y4ZvV?=
 =?us-ascii?Q?HNq6E99MV2IfhxT6bBUgbS7lkzcWSxprSE61ONHGafs8xi3F8mWPJdG1uqBS?=
 =?us-ascii?Q?Z1p+ccSnazruQPMTq59P7qB1wEg0YezLEQi7WJ3G08xNgW8iO9Sk2rNUPPR+?=
 =?us-ascii?Q?2gh4bI/hH3banXTdAkklCw1zZP8Tyb4xJb5gZULaB5q34ojxD0o6Lq2A1aAd?=
 =?us-ascii?Q?5lLrHMR+SOKfypV7+D7uOd205KLFekUoTvm6dJOyOFIjzg60K75DWJtDTEJP?=
 =?us-ascii?Q?iVqx+yodr7QfLJqkNsQ2ux4JibSES36vsKSPfgH3na+8VbDRCTrmzKCHKNXt?=
 =?us-ascii?Q?Ftmxcs2P+Ygmg2j7Ho4BE7eA3ewei4aB+h3/pHyWWov/SLYzMuRiPQs3cBo2?=
 =?us-ascii?Q?scPN4ZlDlc2WyPf0p+frXprF6Bdupl0I6kgdm8X7IhdkL5Y+pYxc9GOGmn2y?=
 =?us-ascii?Q?yLFBvBFmEUEwFQY5hTfg48lx0HL8FblTT/DN/0KMqvxOj62wqyWnDz433anO?=
 =?us-ascii?Q?4mLeqJDEBQU3ETAavd5UM0qfsIWX43tfuaxIf5+rDpdKcmwh7dS3pK5djkZZ?=
 =?us-ascii?Q?arUXR0nzwfTFVYT5hrBTdOA5F0vlUGpPx0rK9uy/eP+3qYvRnFQy9N0npBWP?=
 =?us-ascii?Q?xDlZgJAxmvWHRnsYJvfUs4buhckdRHsbqFhXpcP1mLRaYcSMDBtdFYyw+aFL?=
 =?us-ascii?Q?2Bg/0KVigO/md31dyxGSPnIwkrEklt0aEP6AkpWVuYnIliUOs8gscXzjFNcd?=
 =?us-ascii?Q?K3twyM7PdffYYkfLBM7tM8//s8MrKcRZjbIuwaXl7mRQX46yqKms1UXcwsWz?=
 =?us-ascii?Q?Eg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b516c15-5837-45e6-2f7b-08daecd52b2e
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2023 15:22:32.6419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RyUqy/RDI/oL4HtrSPTf6nnJdehxYuozJUkuK/REfn91MURgIWD1wreS+dsWRbey5ePlQs7hx5zgM4vHZvSeBQ5yh0KHJo+QzzJ5fZf/z1Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5629
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Fri, 23 Dec 2022 11:58:13 +0000
schrieb Lee Jones <lee@kernel.org>:

> On Fri, 07 Oct 2022, Henning Schild wrote:
> 
> > If we register a "leds-gpio" platform device for GPIO pins that do
> > not exist we get a -EPROBE_DEFER and the probe will be tried again
> > later. If there is no driver to provide that pin we will poll
> > forever and also create a lot of log messages.
> > 
> > So check if that GPIO driver is configured, if so it will come up
> > eventually. If not, we exit our probe function early and do not even
> > bother registering the "leds-gpio". This method was chosen over
> > "Kconfig depends" since this way we can add support for more
> > devices and GPIO backends more easily without "depends":ing on all
> > GPIO backends.
> > 
> > Fixes: a6c80bec3c93 ("leds: simatic-ipc-leds-gpio: Add GPIO version
> > of Siemens driver") Reviewed-by: Andy Shevchenko
> > <andy.shevchenko@gmail.com> Signed-off-by: Henning Schild
> > <henning.schild@siemens.com> ---  
> 
> What happened in versions 1 through 3?  Please provide a change-log.

Not too much really, but i will write a changelog and cover letter when
sending again. Mostly commit message stuff and later a rebase.

> >  drivers/leds/simple/simatic-ipc-leds-gpio.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/leds/simple/simatic-ipc-leds-gpio.c
> > b/drivers/leds/simple/simatic-ipc-leds-gpio.c index
> > b9eeb8702df0..fb8d427837db 100644 ---
> > a/drivers/leds/simple/simatic-ipc-leds-gpio.c +++
> > b/drivers/leds/simple/simatic-ipc-leds-gpio.c @@ -77,6 +77,8 @@
> > static int simatic_ipc_leds_gpio_probe(struct platform_device
> > *pdev) switch (plat->devmode) {
> >  	case SIMATIC_IPC_DEVICE_127E:
> > +		if (!IS_ENABLED(CONFIG_PINCTRL_BROXTON))
> > +			return -ENODEV;  
> 
> I see that there is an unfortunate precedent for this in the lines
> below.  However, I also see that the commit which added it was not
> reviewed by Pavel.

Right i think that might have been you in the end.

> This is an interesting problem, due to the different devices we're
> attempting to support in this single driver using different
> GPIO/PINCTRL drivers, which is unusual.  We usually resolve these
> kinds of issues as a Kconfig 'depends' line which covers the whole
> driver.

This was tried but the result was not too nice. It is really the same
gpio led driver implemented on top of multiple possible gpio chip
drivers. Making it depend on both pulls in too much in case one wants a
minimal config, writing a new driver for each backend would duplicate
too much code.

But maybe a splitting out a -common or moving stuff into headers could
help with the duplication if we want to go the "one driver for one
device" road. I would not want that and what we currently see was
discussed and approved as part of another series, when i introduced
x27G.
 
> Would 'depends GPIO_F7188X || PINCTRL_BROXTON' be a suitable
> replacement, I wonder?  If it's possible for SIMATIC_IPC_DEVICE_127E
> to be probing when only GPIO_F7188X is enabled?  If so, this would
> result in the same scenario.

No that would not work. Depending on which board we are on we depend on
another pin provider. "&&" would be but it would be kind of overkill
and not allow for a minimal kernel config in case someone wanted a
special minimal kernel for either one.

> It also seems wrong for -EPROBE_DEFER to loop indefinitely.  Surely in
> some valid circumstances dependencies are never satisfied?

Well that is what i would guess as well. But that infinite loop
waiting for a pin to appear endlessly is a part of "leds-gpio". If
"leds-gpio" had some magic to eventually bail out (maybe say we give
it X runs with some sleep back-off) i would not have to do anything
here. I consider that patch a workaround for a shortcoming in
"leds-gpio", which busy loops and fills up your disk quickly with logs
if you mention a pin that never comes. Which i imagine can quickly
happen if you have a typo on your device tree or a kernel config not
enabling a pin provider driver.

I am not sure there are no other valid reasons. And i think that indef
loop needs fixing at some point. Hopefully by a LEDs maintainer or
maybe i will even help out.

Until that day i would like to have the proposed patch merged to not
have users run into a known issue. The pattern is established and has
been discussed before and the patch it rather trivial.

Later we can see about improving and ask fundamental questions again.

Henning

> >  		simatic_ipc_led_gpio_table =
> > &simatic_ipc_led_gpio_table_127e; break;
> >  	case SIMATIC_IPC_DEVICE_227G:
> > -- 
> > 2.35.1
> >   
> 

