Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B32679AAF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 14:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234663AbjAXNzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 08:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234601AbjAXNzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 08:55:13 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2073.outbound.protection.outlook.com [40.107.8.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3722470B8;
        Tue, 24 Jan 2023 05:53:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=arHNzSb992zQbCMG4kbgByrUtI4f84flOtGP6KqtqQllQaGPvs4XphmTi0yIJe0TYEECwl2yD6s2BnRkd3z6/detEmFeH33MRmgmKDg0rVo98e7xEbCe1kcX6F5qDDaPSVTcyWc0JvqhdOWf+uO+SUzEQUp3nFuP8EZ7/gxJfS9cj0XIp04bK0dSYK6tmEA+S7KzOEDCfu/UdDh/qwDE30S9O6m4HE7bPmwGCW72n4zGSF62KKPN/PJZWWRV4BC8SEMKSY6UO2qQCeRZSv05MbwYcVqKi8HQhzwR7fJuWCkyK1lCRbpj9gALiDIfs1dd8oC/UctDU/mTYZxRO+74pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YqmJHjT4E4RPYzpo4BlE80EqZBWyrSVRdX8ZQ+7ga14=;
 b=fDIvOvJ0c3MXAdvx82KDxw1Dwocj4vaMXkkDsj8A6ofBiHDhIP429KWcotuDyaKyxVfW/HsD10tK9BdvN3QJNfYCrwYdgIfy7ZMZ3lmHMPQSPjEkYjSYRKrdQkmwiLcKBTOXD8Z1wOKvM27v4LIgtDgEgQbu960oMuYYcnJzy5YHQ800Xu5I3Ngo39C+m7Pl3/iYgLk+dcTamgUOV2iRJHSChdZqlBbAcz7bR9OyH7ZYWAk5b5ypKSd0BvTi57Q6ickBVI40rpjnzLtoiBUyzLNYil+6rAVaa+YZQobbRXhnlck+HAETcev1Dj5Ikn+en2SUlG+UKijqbOuuc8mF6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YqmJHjT4E4RPYzpo4BlE80EqZBWyrSVRdX8ZQ+7ga14=;
 b=a6zTBdYVuZxY7Mwe3pigTh0gLPOdMzXhGi8gy9TU5673MLBHLYtKCGBTYof0fixdfElMlVIdBqSfGUyhgoTqB0+1jwjXhCYIVSa4jE3aMscjMB1o+51QpdpxzeQ7YU5arRp+2ynf65DfjSZN99Ibz9SH8Ii0kggN6Oyx1wHpAIQvI+EwYsvGq1AaJc2QxCbTtCaVVuXtc1NX0Pf+zMnilBa6HOZXMpTHvlZLTuwjbB0kNS2wfPHcpLpFVtm2+cRAWrOqRTMuvmQo7igi7N1pXeozMHozs9PDe4WnDSsnner7MeOfUzZX7G7DsSucgkW6w2hAZnm3MDE3WS1tAtZipQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by GV1PR10MB8028.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:81::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.27; Tue, 24 Jan
 2023 13:52:55 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bdf0:fdeb:f955:bc79]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bdf0:fdeb:f955:bc79%4]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 13:52:55 +0000
Date:   Tue, 24 Jan 2023 14:52:48 +0100
From:   Henning Schild <henning.schild@siemens.com>
To:     Lee Jones <lee@kernel.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] leds: simatic-ipc-leds-gpio: make sure we have the
 GPIO providing driver
Message-ID: <20230124145248.3fffa6f0@md1za8fc.ad001.siemens.net>
In-Reply-To: <Y8+zD6AxuJVy5b7Y@google.com>
References: <20221007153323.1326-1-henning.schild@siemens.com>
        <Y8mv8PzL1UsP9gNh@google.com>
        <20230123214859.725cd1c3@md1za8fc.ad001.siemens.net>
        <CAHp75VfSHgdikX5=Qba62BwWofVf7gHhS2hq2OuBwHFz9riCWQ@mail.gmail.com>
        <Y8+zD6AxuJVy5b7Y@google.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.35; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0024.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::15) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5780:EE_|GV1PR10MB8028:EE_
X-MS-Office365-Filtering-Correlation-Id: 904e55de-9bab-4e09-cdc3-08dafe124b4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cbw8K84Ej7xwSThR75scOwnQZABx0J23tJlMg7rK4Tu1CXS12MuCX6qwYG/3hXKexwPMU1htVqgD2or+IY9l88XTgKg0E2iN9AoHVP8BWGGvO0nM9L+8zvNYml9Ks0B00UYw1TIkndLXuSyeHUEKb1px6UuPjZGJsHdQp76slLRCvBaQP+1051xMmdVKNIlNFJYc3pvqvtJEwJukR+2NOY6SCZ9S4HyGev/q+31HwsRCk2t+ICO4B2QaaI8GvgXLEqoXPpCiZfbMoa0xuaCwgxetXLzjibfcWXpGct9pRjaThNaAg35h5oJtxygCp8RyjGTWBczYL+KiSSi8mHomD4jtqO89N5gaSi0YD1TD1wj34GSU2bGijNF+D6BgZ8LDZvWHHP562G0WGwxhYAcpjFM7yboYaMysAbqs+J3HVcwdGPMHNbxYKVGYseWYpfqJ1Po6TKdC7OsjvIZr3uSe7hekOO8MR9IV6YzI8aSR3vTM0keTUShOwt0t2a9HG/7WS+J/hTdALT64KWk8RgxuxEvij/C/7o0HGIYyHLT0GmWS2mUJWz7qAuKpimCSimyaDmvkBFmOXAzcgNAdn+JniE5jlqLsRApzdSrZRagoOH/8DecrH+CkQYJouAaO/ZjBKZBlMKakyU4YCt3CQEZB4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(39860400002)(366004)(346002)(136003)(451199015)(9686003)(186003)(6512007)(86362001)(1076003)(6506007)(53546011)(478600001)(6486002)(6666004)(82960400001)(83380400001)(2906002)(316002)(54906003)(38100700002)(6916009)(8676002)(4326008)(66476007)(66556008)(66946007)(44832011)(41300700001)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pfcfGeg/GRtoRcDe/8Ga2VfNdPsRNDeO0BiZoG0H3qx6b6kP1bee6/eYf/5a?=
 =?us-ascii?Q?xmZf3BtsTjWN6hlWmCDOmfxNE6DS0IKKoFUsw6+lmviExz0Zl4bGxbhh9gQ6?=
 =?us-ascii?Q?XGyBHqzgsn8H0dyQfEIL7pphx0VQ/Xa4ik7j5a13awiYcRLzsJbFQAwfnFr+?=
 =?us-ascii?Q?cd4K5wEBU446k0ADqP9SG1+CAoFJ5xMZQG8GtmWz8NgCDeuQdGz5H/t7F1yB?=
 =?us-ascii?Q?ht0LVl1SOHlfHZX+1VU6ZS9JfGZiJc10omPDjw/wXcJvgVv4eh9tpHCSVl9Y?=
 =?us-ascii?Q?Mi4IZwsJrIkj508iC1QDgNNytzuZLbGCuc6VXMbOPNXxKwW/znv9pC2dAUNL?=
 =?us-ascii?Q?3ddMqHNz1tBvIWFF839jEBmq7+FXXvL6WSW7Opixc8ZUbWbCRPhiQduC5xTV?=
 =?us-ascii?Q?NT7xeiKYKQ609AY+n+IPaE66huznuy1bWzd768IWMWKPV90oe670ZgPK3SA7?=
 =?us-ascii?Q?xLS5Fxns8xgs1mWdIeyH0O0dSE6rKzmHx0An39okTENewy5iBF7fKoDoG/rN?=
 =?us-ascii?Q?KVSH/6HI+yF2dkfJ3v9vLra0in0C6ORrt0we0ooXYRhLr8kCOWjnmVJixseT?=
 =?us-ascii?Q?O+ny2uzfCT/lUMbKq2Q1xQt35DNG4uNLCNzqjCVbwbEKredAuGuw6kbRZ1pJ?=
 =?us-ascii?Q?7cKcvXWhAkDX+9vV7B5BENbnFKcU5Qe55oVf6tH3KQ3QV4Pb4k30+RBdfpot?=
 =?us-ascii?Q?3RQ85V3CpO/zrsw0KVQO+Etv1Fcd4FMN4GnkkLmf6npdasoEvfrzQOBK6JGc?=
 =?us-ascii?Q?G06CbtNr5a8hzsaMJggxHUWvSSHYejUPP22Qy3K/IdbinP0U9EIAlYfquURc?=
 =?us-ascii?Q?LuJN+ou6U2H9ybn34KmV8J9cpVF7l/1dqajeYpW6z9ZOx7739xWMbRFoL6Vv?=
 =?us-ascii?Q?lhvYb2CmF8UC1FYW4+JWStWFQhom9DIo30wWLHMl/nYLGGkdMDqtaksNFvdU?=
 =?us-ascii?Q?IRNvzHlleyd2CM4nr9PR1JPcLt5/7/8lE9WTveZFUQwvw4cO3aLaITgCKz2v?=
 =?us-ascii?Q?W7JnmNkYwLf3ZdV8uazuUa75bXpWP0OqWU66udTCKxUmme6PnSwf4es7ZEkD?=
 =?us-ascii?Q?y2GiAqe6NGdeJz3puNx6i39NQnDL/L2sddj+VMTawgpu62oS3DzVlm1SPFN3?=
 =?us-ascii?Q?RpQ7z07+8U2CC0uCqq6gIk2dRDDKs7HFivbPqBiYW6eOaR4709Q0e0R0z0FL?=
 =?us-ascii?Q?chujq1o9/bQZoky6eb/NJ945I8k9hl7OFFlZp/6T72eiuUix8M2NX8oSDDi8?=
 =?us-ascii?Q?nupIPnmFs8rfxeZx6r2Pq9+jpqbkadmdBcVRsuWfQX8QGkqGHVdMHd4zGgwF?=
 =?us-ascii?Q?Z5uc8yKRsKYZhjm8Y40V14BxyR3/wMGRsq/WdLrpJCLKgw8YhFIf5G9/3kV8?=
 =?us-ascii?Q?IbdjqMja7rYuSSvLQWeopYVbn22htX+l+jUkK/BQpf8a6P4fuIDRK2NMqM70?=
 =?us-ascii?Q?lpwUdMZo/GZ7knbQ0b5jRfzGvv8qziLI6b7B3Zim+smqVteZjs7doVUBbWZJ?=
 =?us-ascii?Q?QJWzPsm+CB54Ss5s59N9DzqG5TtwiIOCFW6dzXl1rRvtsZPYCubXYZpKymHL?=
 =?us-ascii?Q?ektGNXhhFzCI45QdOGAIzisXTLhH1dP5eTeesfSe1vL/XfWHgOQRNIO9cwke?=
 =?us-ascii?Q?5wDVclECtRnUsCafE80aQloTabSb3AfVEwIhOBRGDJhyucXyVbQisS2WowYW?=
 =?us-ascii?Q?Ei/y/A=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 904e55de-9bab-4e09-cdc3-08dafe124b4f
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 13:52:55.6483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DkP518/k0Rfd17B1/INwkLWZY56a3NkyjmyvVKEkPRiURlgnWfvUoFMkIO+8MkHHoLtyKsQyVi0jhjs8Xk1uVWPdJ/S0mY9vu/NMPn8alo0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8028
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Tue, 24 Jan 2023 10:29:35 +0000
schrieb Lee Jones <lee@kernel.org>:

> On Tue, 24 Jan 2023, Andy Shevchenko wrote:
> 
> > On Mon, Jan 23, 2023 at 10:49 PM Henning Schild
> > <henning.schild@siemens.com> wrote:  
> > > Am Thu, 19 Jan 2023 21:02:40 +0000
> > > schrieb Lee Jones <lee@kernel.org>:  
> > > > On Fri, 07 Oct 2022, Henning Schild wrote:  
> >   
> > > > > If we register a "leds-gpio" platform device for GPIO pins
> > > > > that do not exist we get a -EPROBE_DEFER and the probe will
> > > > > be tried again later. If there is no driver to provide that
> > > > > pin we will poll forever and also create a lot of log
> > > > > messages.
> > > > >
> > > > > So check if that GPIO driver is configured, if so it will
> > > > > come up eventually. If not, we exit our probe function early
> > > > > and do not even bother registering the "leds-gpio". This
> > > > > method was chosen over "Kconfig depends" since this way we
> > > > > can add support for more devices and GPIO backends more
> > > > > easily without "depends":ing on all GPIO backends.
> > > > >
> > > > > Fixes: a6c80bec3c93 ("leds: simatic-ipc-leds-gpio: Add GPIO
> > > > > version of Siemens driver") Reviewed-by: Andy Shevchenko
> > > > > <andy.shevchenko@gmail.com> Signed-off-by: Henning Schild
> > > > > <henning.schild@siemens.com> ---
> > > > >  drivers/leds/simple/simatic-ipc-leds-gpio.c | 2 ++
> > > > >  1 file changed, 2 insertions(+)  
> > > >
> > > > FYI: I'm going to try my best not to take another one like
> > > > this.  
> > >
> > > understood!
> > >  
> > > > Please try to improve the whole situation for you next
> > > > submission.  
> > >
> > > When i have to touch this again, which i will, i will propose
> > > either "depend on all possible GPIO drivers" or introduce "#ifdef
> > > CONFIG"s. Caring most about big configs as seen in distros like
> > > debian, even for embedded systems ... i think i would prefer the
> > > first option, as it will also be easier to maintain.
> > >
> > > I do not see the whole infinite loop story on my plate, but if
> > > that got fixed i would follow up taking the fix into account.  
> 
> I still don't really know what you mean by this.  Probe deferring
> should not work this way.  Do you know why the loop is infinite on
> your platform?  What keeps triggering the re-probe?  Are you
> continually binding and unbinding drivers, forever?  Also, what is
> printing out the failure?  Maybe it should be silent?

It has been a while and i would have to reproduce this. But basically
what happened is that i registered a leds-gpio platform device with a
lookup table, no errors returned and my "driver" would be done and
leds-gpio takes over.

All GPIO_LOOKUP_IDXs point to not yet exisiting pins, potentially never
existing when the providing driver never comes up. Now leds-gpio
internally tries again and again with a high frequency (busy?) and
printing stuff (would have to try again to see what).

I think one could modifiy any other leds-gpio and totally invalidate
the lookup table by introducing typos in the chip name of each entry.

But i will rty again and get back with a better description. Maybe the
bug was fixed in the meantime or i am doing something wrong when
registering that platform-device.

Henning

> > AFAICS another possible (not sure if it's preferable) solution is to
> > split this driver to subdrivers and each of them will be dependent
> > on the corresponding pin control in Kconfig. It will satisfy both
> > of your requirements, right? Something like
> > 
> > simatic-leds-core.c
> > simatic-leds-127e.c (config ..._127E depends on PINCTRL_BROXTON)  
> 
> In theory, yes it would.  You could also introduce a core driver to
> contain all of the shared code.  Duplication would also be a travesty.
> 

