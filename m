Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452426A718F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 17:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjCAQxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 11:53:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCAQxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 11:53:11 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2063.outbound.protection.outlook.com [40.107.104.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8454DF953;
        Wed,  1 Mar 2023 08:53:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UkF7ww4b+4gNdtWgrIGksOKsBDnpUk7UW30On21rdyTYh2mYrtmJirObDzJP8mL9X6s28VqXPvHp27ETlhZtsx7IndsECBLrsmeaEfq7Gd6m9fhDY6uu9Ldr0JpI0oDMGZAjz9B/tkyxwv0KiWLfq5dDaEiBKMCpSHhg+UqcFW1qOk5ooVvGbN6CW5gbekdIUC5k7jth8II1OVGOWTMOmuSz/gWXa3NryUT4KLezGR2ThtKp9oT+CW0Ubk2Up3MQJ7vMiv7RyDiFLIKs6gPTmxmIumtK8/MDD+wpF9E2tBtGV1Jo9FITQ0DFeQLUX7eKb/Vh+/39XvDKpid7DjpZnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HOEP7d+rTg8CpkTZXtXW8Tv4Bqp+KtoHw72BHubSB90=;
 b=L4xsIWppN7Vb/MwDcca5JdYZcWoEu+oItYj/X8ABlaglLblLEN0iXhNT8ZVWjWH/YdLkN8qNiAm9/An7tK6aI7QDChZQ/+O7sA8/ClWQRLxWb4eXjVMkkaDH1qDUGs9m3kmvVBW4qSfUbCnLNtb2/hBFi06gJTOyllYvy8NbpJ+JvJf8xIgquVaWvd2+zfFGvSA4VzsCzMKWTICVwn5c7bqpXW7M6fNjfQB4r/KdcXWsdzDf6TThKTyEkM1bJJQD5duiu2/0nPjz+krxOV+UyzBzjJiG2EhRrho+HO2E31j+A1E3E+63S1Q7DhC1LVZs5BUB6jItH9/Q9kkCWbU1Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HOEP7d+rTg8CpkTZXtXW8Tv4Bqp+KtoHw72BHubSB90=;
 b=KuR+5Aizi/yJMJyJo7B9Uh+6f0f9J7yaXJQnutt2eX9lupVVhpCX5hmLcad1aEW2pOrKxUaT4ykGu4i6/4csRMMemmsQBZmRWG5WWYET34fYQM/E7OflTC8VPOxcOoKFUnteQzyTqeWnwSStGgv7RM6qKK4QvpC0i6UyDEGY2xXvo7rVu+r4UTzvMiw2zKggva6d79WW1MGkLS57kHGXiG83v5S1K9duKkwK0amfxwj8cm4uFhJiqOJZ/r3jsj/pqNL7AMgCUD6V0InY1m2j/pfH/PU1Wwd+XYVdUN99hzwA+6ufWHFMg2FhhUtYBvtUQDVpspA0Bg64z9fzR4iPOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by AS8PR10MB7972.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:567::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Wed, 1 Mar
 2023 16:53:05 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ee44:171b:4c40:d42c]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ee44:171b:4c40:d42c%6]) with mapi id 15.20.6156.018; Wed, 1 Mar 2023
 16:53:04 +0000
Date:   Wed, 1 Mar 2023 17:53:01 +0100
From:   Henning Schild <henning.schild@siemens.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Mark Gross <markgross@kernel.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 2/3] leds: simatic-ipc-leds-gpio: split up into multiple
 drivers
Message-ID: <20230301175301.6c7fefda@md1za8fc.ad001.siemens.net>
In-Reply-To: <bf678bc5-9615-31a3-3039-5d013f9c9f25@redhat.com>
References: <20230221122414.24874-1-henning.schild@siemens.com>
        <20230221122414.24874-3-henning.schild@siemens.com>
        <Y/TMR0GBUr69KiQ5@smile.fi.intel.com>
        <20230221154354.290ae938@md1za8fc.ad001.siemens.net>
        <Y/TaftuNMABevCWV@smile.fi.intel.com>
        <bf678bc5-9615-31a3-3039-5d013f9c9f25@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0057.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::17) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5780:EE_|AS8PR10MB7972:EE_
X-MS-Office365-Filtering-Correlation-Id: 458e9cb5-8bad-4243-644c-08db1a756cee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KscpSEbwIu+9ZB7Li/nWimRx4iGTqyQzoIYyno5/X0Uk5fO4dYnd8Fl5Fs0mrtz0xso8Qp5zUwmCGx1GIVZStsNmCEZos2Li4SFC8ovAu+4vjIeDoC8N8OjUeApZQ7bCE76d0Jw7R9+dBP7XC2jKC0jaX/U6iCd10tr6Tf7IS086+AxwEFm5BjSX+yQ/+L+gkA/POqZLh7T5Ebm2k2XQaClsR0ky2UfJ7mi8ZOyUsUG8C4NjqZG7HBxDRf55wTbSp6p+ltViZt/2Q8yS675udKmaCAkpBn2pCEMvtrq/5u3+vQs5sY4c/qxpE/XmLTsLFT/L75pFLebfuNzLWa07VN6bzC3ZcoxozLM9iRvhdUOXhmYLC2Sdq1/VoqmngwVblA62s5E+yc5UlY7UTeyDQkw7aViRecADy/EF/Zcj0Z6CsEgo9Ao+NI7EFZD8M8jk1FgMaXths47bv2aqtHJBozInMm9LdJT/Vm/ahXmZurxD8mQKkLt4qca9guw13/w9j4sf74U7tAcSwgr9cCXOd1q3m853wzsyaCrqdkv/Oh2HM5dBZGu9Aw6jER4x5tIPxcNuNBM4KzOuLAJcRwRIJ4MCPA/Nmpf7SalBU1T3bg3NtzO4YMkoJCDfG1sJ+caRBNWb7Xzn5ywq2scqiWiaDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(451199018)(83380400001)(53546011)(6512007)(41300700001)(9686003)(26005)(2906002)(6486002)(186003)(1076003)(6666004)(5660300002)(86362001)(6916009)(66946007)(8676002)(4326008)(66556008)(66476007)(38100700002)(8936002)(44832011)(82960400001)(478600001)(54906003)(6506007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L4zn5vDE8XpGmZYiVrIcUy7wEnnkfibcFNbE/K0L6FHKLngkFBzAaH5iE1wi?=
 =?us-ascii?Q?Zv0YMadFVLG/prCwqFhHIzWStYBMend3EvfNKIkOoF0w2OWX9r8nQ1mAElG1?=
 =?us-ascii?Q?Y84zNV1eEy6UW3/EKf476D4d/gd2Cfnkd7bqxdaBKhJEdaeJfzYMiod9qEY3?=
 =?us-ascii?Q?NmBN2th0jC4RMk4y8vFNEvPcpKpWsxBsF58Pb4mm3PKSPYhtgs36S2gvpVLH?=
 =?us-ascii?Q?bGfpfHXH3CpG4xxFez1Uz0xPuOJs0ht8XWcmm0re61SU3YO8LICV8NZcfD6U?=
 =?us-ascii?Q?NihaYpag3Gjpu4Y54x2GG5+z8aPmI5NMPaM7pdJuyD7l5pU1TvX9hNeFo9hG?=
 =?us-ascii?Q?SM96kuYc6Loqy0tK/ehIsQzKQZgH73+PxK9VoIMMwMAUB3VLPUeRQ/KrWa6n?=
 =?us-ascii?Q?ibl62vbBRRma0JNtHkORNFBdXPK8n87pmwPXkjQrEQS36sTV964hN2MkoD1Q?=
 =?us-ascii?Q?sIwOYrhsPXuw4msqe5q3zpqHVeOSpQFYEhgUtTbyJ6xsUHTD/h3sKJXYOrOG?=
 =?us-ascii?Q?UDwYmdqePMpvoGmHogWyH5Oh/BFb6KLAKjT9VOlalWNjnbBntpN5jnh791BH?=
 =?us-ascii?Q?NAw/hL/YIPPGJ1GnSo0COCn/c0RWi6gFnELYYiS86BgFKZvTtBes8bEOaS59?=
 =?us-ascii?Q?ozl33AybmHjRvqXe46ec6xhUqWSEsEsnIOhXqtxaA6Ql4SL2hrcftxLCuui8?=
 =?us-ascii?Q?MZ/URA9VuNX9BUPo3JmxZ4UNhC3DHfhjZ2DR+3l+WSrKfo6ocIcJEtuhyHJB?=
 =?us-ascii?Q?qcuDWEpreGdxp1bXfRRKmWPzWQEx5gWrwJb/ojptl6xwrEU+3cGEg5rCmZN1?=
 =?us-ascii?Q?x8TGSiZscGaZbxJiwxp8oawcQhpRl8gCmZmeB9G3xkxsr1zfSmhjVV4F8XYG?=
 =?us-ascii?Q?cVW9l9fPJWLHkqq60Nx0HPG8hzmgOE3BeDrcizmbabGLMdeltpkgl8iZG4lc?=
 =?us-ascii?Q?1NFdb62IdbOBScav/5YLvfv2LBWMEBCffzax5j5ooJN+RQeOnK/+EgFNoGxK?=
 =?us-ascii?Q?KNPy5ZrU0MMCUmKl6UCo3GmtRZy+C3b5BvRLKi9qL+iTB1Uvy1vlZKQ6Q9/H?=
 =?us-ascii?Q?KNZiup7R8QTvJDJ0KoKcON1DiZmtSRTp3/UKlIN5Xle9MnM4d5OZPzXswCo2?=
 =?us-ascii?Q?XQSMN8kN/ss8exMsPBQn0YYNbo6Ekom0U3TU/X3z7DYFA5ArNuk28MVts5f4?=
 =?us-ascii?Q?26nHcXV3hc0Z+xpUxMRQAvgu6jYROZGrssJUs48eJGpIn4kAo/itE9DJk35s?=
 =?us-ascii?Q?fJ2IVLbI3unKKKDUcUSWwstZkPsP3typVXtXbllZ9i/YG+hydk84VimK8wdS?=
 =?us-ascii?Q?gHxJnVgmwIYizg+t+fn0/C4RRIDPlrpuyecpr0FeVSDSIeiPd3LHPYnxjpt/?=
 =?us-ascii?Q?4e+tDMCmv/WuSbJpWqnLiAupJ4fjwaJN3qumpkwHaWaX6zOih/r2DMTtxMym?=
 =?us-ascii?Q?RY67rj7UnHFKT/HpEgaB/4OYbiXKoUnRn9tuYa5qt2LQg50vUqYfLv7EtSiW?=
 =?us-ascii?Q?hzR3xBRUvaDBi4yWQX9SVGsbBjgpV6lYQ0Ve+ozmzL2j2QomGbEJLKE7Sqra?=
 =?us-ascii?Q?e574czBpAhKv1XnEmoaVp4OrvQBOfhTOa/BaVZXKOUehbrOf9YvrR4Nq8uag?=
 =?us-ascii?Q?nQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 458e9cb5-8bad-4243-644c-08db1a756cee
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 16:53:04.5365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HnnJtS6iWcJLZCjhUfKONrHk3M0mf8uV1FQRJoZZQCjYEdQLzB9KzM6WfBm+mGoW/Mu8LuhCgaIHv4Omw7csaId0+3wsgAwKGAwQmcL+6qk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7972
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Wed, 1 Mar 2023 15:53:04 +0100
schrieb Hans de Goede <hdegoede@redhat.com>:

> Hi,
> 
> On 2/21/23 15:51, Andy Shevchenko wrote:
> > On Tue, Feb 21, 2023 at 03:43:54PM +0100, Henning Schild wrote:  
> >> Am Tue, 21 Feb 2023 15:51:03 +0200
> >> schrieb Andy Shevchenko <andriy.shevchenko@linux.intel.com>:  
> >>> On Tue, Feb 21, 2023 at 01:24:13PM +0100, Henning Schild wrote:  
> >>>> In order to clearly describe the dependencies between the gpio
> >>>>  
> > 
> > ...
> >   
> >>>> +#ifndef __DRIVERS_LEDS_SIMPLE_SIMATIC_IPC_LEDS_GPIO
> >>>> +#define __DRIVERS_LEDS_SIMPLE_SIMATIC_IPC_LEDS_GPIO    
> >>>  
> >>>> +#endif /* __DRIVERS_LEDS_SIMPLE_SIMATIC_IPC_LEDS_GPIO */    
> >>>
> >>> This header doesn't look right.
> >>>
> >>> Have you run `make W=1 ...` against your patches?  
> >>
> >> No reports.
> >>  
> >>> Even if it doesn't show defined but unused errors
> >>> the idea is that this should be a C-file, called,
> >>> let's say, ...-core.c.  
> >>
> >> When i started i kind of had a -common.c in mind as well. But then
> >> the header idea came and i gave it a try, expecting questions in
> >> the review.
> >>
> >> It might be a bit unconventional but it seems to do the trick
> >> pretty well. Do you see a concrete problem or a violation of a
> >> rule?  
> > 
> > Exactly as described above. The header approach means that *all*
> > static definitions must be used by each user of that file.
> > Otherwise you will get "defined but not used" compiler warning.
> > 
> > And approach itself is considered (at least by me) as a hackish way
> > to achieve what usually should be done via C-file.
> > 
> > So, if maintainers are okay, I wouldn't have objections, but again
> > I do not think it's a correct approach.  
> 
> I agree with Andy here, please add a -common.o file with a shared
> probe() helper which gets the 2 different gpiod_lookup_table-s
> as parameter and then put the actual probe() function calling
> the helper inside the 2 different .c files.
> 
> And all the:
> 
> +static struct platform_driver simatic_ipc_led_gpio_driver = {
> +	.probe = simatic_ipc_leds_gpio_probe,
> +	.remove = simatic_ipc_leds_gpio_remove,
> +	.driver = {
> +		.name = KBUILD_MODNAME,
> +	},
> +};
> +
> +module_platform_driver(simatic_ipc_led_gpio_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:" KBUILD_MODNAME);
> 
> bits should then also go into the 2 different .c file files.
> 
> Really putting something like module_platform_driver() or
> MODULE_LICENSE() / MODULE_ALIAS() inside a .h file is
> just wrong IMHO.

Thanks for getting back, after Andys review i happen to have just that
already prepared for v2 as "likely needed". Will send that v2 soon.

Henning

> Regards,
> 
> Hans
> 

