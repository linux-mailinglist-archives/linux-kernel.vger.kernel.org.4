Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 447EA65E9CD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 12:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbjAELYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 06:24:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232933AbjAELYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 06:24:05 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2080.outbound.protection.outlook.com [40.107.8.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0425004E;
        Thu,  5 Jan 2023 03:24:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XogO9wKKKBxYXjGkKgTpiFt6Ujg74z3vVnHB0cMWekQRjhdtTHSnAzcIVsEZK/96aGIIIWvieWYK5MlRi8nd682Q+JOsmnoMhP5w0n6Ko3z1kd9ODlj/kyt82AMjyvwXylySC9S9cNsnAMkUdCnoQJ4tyuWPltQEH1fOecweVkIxKIRuSLxV57pyK8QtYYdPfpkqXsdev36Ifv6I+K53NJD0hqxLDNcvWTinMO5pPPinLx5m/DzMPh9IsI2izO2Zr2J5YEDbGdvtdso5JvrHKYxXD4kb65wbqfLjlHahZ7EssyvyEZW+mHrK3Fmt0h4Jy0riU1ImYoI6cHfZZDn9HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qa6mNwcE+A88Jgxebdvh8tXnWWDkUUCMrP6XGLkeMsw=;
 b=KuT6GW2rv+Ui7JUSBFmv/rRD8P479CjND3eJce6o6gB1qf2m0cPCR7UqlPGWage3B39hP9+sfuC3/VHVtb38bdaFnUdin29iI0zd/A8G0MEHXWvXgnN5zRLpYTYQH8slv3nKeSE1Y11iK9NwYpfxfOwQoP4pqxiKamrvz4nVkX3+/ijc4pi5KXl1KWazVs0DULk4xnG0Equ0Oe0lhLYjPmtfN2cmhiQJVzGsDcCrK/UVPUK7rxadxp+kWKpcXWXZQPAEZgPB6uUQgrwxUlhJ7YTqUhggoHLkGu5B4NYLAyHCNznk5QoaGX9m3r7qFz65o08db+f2zTQgfL+P28y1RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qa6mNwcE+A88Jgxebdvh8tXnWWDkUUCMrP6XGLkeMsw=;
 b=FAktcRZWSOqX1NU1zFrfb4K854ckZNLqgKah2VpP4EPG0ju+L4ti6+qy56IT0KoIrOzknM0DQtHVQoK8tD7oLUcYt9Uw8gr3m6o9OTlmbkDf+emk/y4fJ/RPBUlmtXPtl9CINFwFZ/qmA4Z7PlXt3dF5pqLN9gskG40LitOb4HUa6SHmmK9fiJjTlDrzyHzTowlhN7AIsg0pcduT5IXNL/B5Gov8gmRPWWoL9kZU6g8npk5U+JHspzahZ1zOzWZQzePa3qmmrkmANuulDL9PZAnyNWDNzNwvuVL3UQUa9Uj33Ogy8uLp8summH7VeYrQBJPsurMXm3B+ShhtyAsZ9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by GV2PR10MB6041.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:ac::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 11:24:02 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bdf0:fdeb:f955:bc79]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bdf0:fdeb:f955:bc79%3]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 11:24:02 +0000
Date:   Thu, 5 Jan 2023 12:23:57 +0100
From:   Henning Schild <henning.schild@siemens.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Lee Jones <lee@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] leds: simatic-ipc-leds-gpio: make sure we have the
 GPIO providing driver
Message-ID: <20230105122357.6711ad0c@md1za8fc.ad001.siemens.net>
In-Reply-To: <Y7aZ9Mmm16HVUnnu@smile.fi.intel.com>
References: <20221007153323.1326-1-henning.schild@siemens.com>
        <Y6WX1Y9GZmvxqlCc@google.com>
        <20230102162227.523d2a73@md1za8fc.ad001.siemens.net>
        <20230103212059.5c80fecb@md1za8fc.ad001.siemens.net>
        <Y7WMHl1Mv1alXadG@google.com>
        <20230104153924.0b92c52c@md1za8fc.ad001.siemens.net>
        <Y7WghcaWPpCHh6Wz@smile.fi.intel.com>
        <20230104203005.5654f3bc@md1za8fc.ad001.siemens.net>
        <Y7aZ9Mmm16HVUnnu@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.35; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0147.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::11) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5780:EE_|GV2PR10MB6041:EE_
X-MS-Office365-Filtering-Correlation-Id: 25ee246a-4158-4a46-a9a4-08daef0f58bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nh5gwAHIGFduIKAUuwUdhdSCGkIbe3gG5hsDSEXA6keFzx2raz+AuS5L6UTyd+fp/BWsnoLfCmPL8z8s0KTTs7UA03GXmKN8ZKjnD3ngxQFTymJnBwrJfMTgC7Qo9I3BsO12EGjxtWm3oKRUTelyxU8hVVqj+DuSB6ZS4VuNZNZXhHIzJZlFvAxE7H06Gaknq6jxr1NqDAcE/0QZ0wZooqLoaoaP+yoIbIuV/aV2/kHD3HvxeZZu7PQPdM0IasYz+QBNX/JsjUnoaiJ/MF585n4QoXx1bfV+XVYYPbboW8iongisgLZsF9bdyH+ACfoKRJJlhdqurIsmxAQqX/RGS0Kajjj6BIsbM5u6hq8zv4neUqV35+wd4FIzPLlyHkiOWWhNHsM9cb01VqjzAZkjetHGOIVwgMbiE0vzQE11v/na0fpFOOXbJe3efBDQveYa9dB+jyjR0RXjCzKFmvy+TxQtmN8QROk9J4S4l6vNYDNW+o6i5cPECl/Fe/7qSABXRON5g8u+8okQH+BuBlTGQErtANROeiqz/tXP4rw8fzk7KpPgdTDGK+C8dPkAlx9+xnjHDUidCluzDNLaolc7CQnwoOeiCAzkP/uuN0IU26NNRNtewhvwsUYHfPxzgU9xEnps2v/TpToLaH9vf9wWpDNR8QUtarq5tamXwm30wGc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(451199015)(1076003)(6512007)(186003)(9686003)(82960400001)(38100700002)(83380400001)(86362001)(44832011)(316002)(41300700001)(8936002)(5660300002)(8676002)(6916009)(66946007)(66556008)(4326008)(66476007)(6666004)(6506007)(966005)(478600001)(54906003)(2906002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RtGiyx4q/AtzpM/62pjUVPLjTL57sbtbDSnyJJPZVVQgC8xU5q6/5v8IWey6?=
 =?us-ascii?Q?d3tKS8EIDXTIoJPzJ1I7C6cnfLlfELi++v7ocLCSPjkmyNSBrJ5bkKLweWtW?=
 =?us-ascii?Q?E/2LvOL3noJCDKATIOXdPvJ6/yvkRkps28tkl+wJNBUhX+ocdyIdZuyTS87q?=
 =?us-ascii?Q?VfsXGYqi1gtXJCvXNbqJaIVE6YkuIbl/a6zmCCpgweRe9qkpWHWY2UMnC9M0?=
 =?us-ascii?Q?N2VGePC8LQFmC3yGYGzSxbfez3uWwdXapK6uM3SD8ErzHeaRwWidiBs8Q8cR?=
 =?us-ascii?Q?kGj30lmZvv8bkMa/EYSWw7Q9a1C8TzXE78UkXohwhsUsxHVI7pt7BBfNNClu?=
 =?us-ascii?Q?VaGRn3cUUqFVACfUUZtssu1oDBesIrGb5V2zMLBPECeCHDvJya7uvelDNMfg?=
 =?us-ascii?Q?8DccfmNjpIWB+0BbbgVKrP8sA6OYhffPg3wsczSUKRnqq65XMfuVqz2+dKIm?=
 =?us-ascii?Q?tfOCWxzcX1JvZQ/Ne4z/6sgOU4cqEbxD/3ukfhdfnGIXYXIxgkiTDks2qWSX?=
 =?us-ascii?Q?RMr6/LZRmfwrKdSy8k4ReYyaRZ+UzQZJsgRaXGYoIi7H2PpGoXwM6oawAgJb?=
 =?us-ascii?Q?4JJmEN4DbmcDsoL7DxXBfBkSkSBwvnfHmX+bFqEcs8oFr6XLzUi+naR6Ffu8?=
 =?us-ascii?Q?HiSoZWLXAIi3HpdbjWjW/ndB+82V5fkmI1SvBMMEfha1oj4X+dD1W8Jw1DG4?=
 =?us-ascii?Q?mSAeD4Z43A9d/iWwVzADB0DDAk8GVUXM9nFNPz+G0gz/6JZiRgWNuVpYlFdy?=
 =?us-ascii?Q?Jgl1Tpqhp+bLYQsNdX9GQi9wt+ERRuk08WpDcFvFkqwdX3U0UxP2vgx/TcK6?=
 =?us-ascii?Q?c1VFwQ0wwkAy7bGaytoDn4wktZ/5YTv2hEFhVpeSZksQWAcR8nGbmE4C36dF?=
 =?us-ascii?Q?mCQYQKKHAl47W9UIKG2WzvJV2dVBSKHTEqkyYh1x0ljihUZD5MUkHJJAzI9L?=
 =?us-ascii?Q?86QwB0Mszlu5N7pese4i+HHZ77RCZsQ73EzoVqGtyf2Twd8ahGvYy6n5XYXC?=
 =?us-ascii?Q?twylFQVkfwqfNpa89W7pC7QjnrMIyU7jslHjEcDEwG4WFrmvTAtzlLENbAC2?=
 =?us-ascii?Q?S7e3sU3up0e5TlxbvWr8GMZ1N/95sixK4HZr+D9jhVwhh0xDkimig2CtFWr9?=
 =?us-ascii?Q?UmWW8Iy2Yiay3nAr6M+0NPe6zxwgsQcIJe8cVzzn7t+2S6K55ZZin1xr46Si?=
 =?us-ascii?Q?GhedWVE5oEH6gJl8DQvlYnwMhm+56i2FKqeodo9CN68Gw/65lVjCCixdZwvP?=
 =?us-ascii?Q?G5pejkLpTKyvStFZA9uoQW52bXfEcjgT6RVItgnESOknclypyENt3QJKMBXk?=
 =?us-ascii?Q?B1CaER+UZmvBqvl90Z/NK/k7Iop92rDdAWCmpZlg8dyLNeS8sDoB3KjQkWvD?=
 =?us-ascii?Q?yQZXpYYSz07w2QVUtRoUvfrWJNeIlOcIiJqWmWEDtQm436PLSqTXCgJ3pNYa?=
 =?us-ascii?Q?ugEorzmZmm/hBb/IpQxTgaF0Vn56kQJzbAC8K1MtmKyZPtZVgmXdWeZh0QFO?=
 =?us-ascii?Q?ClFdG14SIRz6eRNAyc+6hZRkCpW10kYJwoNbRvWJxsgL4UFmWNBVLwMwg++p?=
 =?us-ascii?Q?svBJFYc7i7dIQaJ5qJaxvaSuzYlsOIYTf2Mt94NooFFcKib1vbHKNSmepoxE?=
 =?us-ascii?Q?AtYKr3QbHw0KeetdG0N+sEYg2jbFjmUn2qeABqyvdS3jDI4AAaiw9DI7Eg6Y?=
 =?us-ascii?Q?ECCSbw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25ee246a-4158-4a46-a9a4-08daef0f58bb
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 11:24:02.0775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OnRLx67uUwpJUjsV83+ZTy6CByzEFH3GInhucObmE9Ubd1XoK12SgMQ/RwEmI1MX2+1oLOhgMKVGhokWg5uItmkfXojryczGKEXl+MP5Yss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6041
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Thu, 5 Jan 2023 11:35:48 +0200
schrieb Andy Shevchenko <andriy.shevchenko@linux.intel.com>:

> On Wed, Jan 04, 2023 at 08:30:05PM +0100, Henning Schild wrote:
> > Am Wed, 4 Jan 2023 17:51:33 +0200
> > schrieb Andy Shevchenko <andriy.shevchenko@linux.intel.com>:  
> > > On Wed, Jan 04, 2023 at 03:39:24PM +0100, Henning Schild wrote:  
> > > > Am Wed, 4 Jan 2023 14:24:30 +0000
> > > > schrieb Lee Jones <lee@kernel.org>:    
> 
> ...
> 
> > > > As we speak i already have the third box to eventually support,
> > > > which will likely be similar but this time around with
> > > > PINCTRL_ELKHARTLAKE    
> > > 
> > > A bit of offtopic here.
> > > 
> > > Are you able to get / fix / ... the firmware to work with the
> > > upstreamed version of pin control driver for Intel Elkhart Lake?
> > > 
> > > (I'm asking this in terms of the
> > > https://bugzilla.kernel.org/show_bug.cgi?id=213365)
> > >   
> > 
> > I can not tell. At the moment i am in a Siemens internal review
> > where i see code that is not even close to being ready for
> > upstream. Somewhat open-coded again from what it looks like.
> > 
> > And i do not have the machine the code is for.
> > 
> > Let me say "it is complicated" but some point in time a device with
> > LEDs attached to PINCTRL_ELKHARTLAKE will be proposed. Likely by me,
> > when i hopefully have such a device on my desk.  
> 
> Thanks for the information.
> 
> Consider above just as a point to be aware of when you come to
> the productization, so we won't need another pin control driver for
> the same chip.

IIRC we talked about this before in some other thread and the solution
was taking a newer BIOS base version. And since i never heard about
this again i hope people did the right thing.

Henning
