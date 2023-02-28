Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237FF6A5490
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 09:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjB1Il4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 03:41:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjB1Ily (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 03:41:54 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 680602A98D;
        Tue, 28 Feb 2023 00:41:52 -0800 (PST)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1pWvYQ-0004CR-00; Tue, 28 Feb 2023 09:41:46 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id AE544C0F89; Tue, 28 Feb 2023 09:39:20 +0100 (CET)
Date:   Tue, 28 Feb 2023 09:39:20 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
        wim@linux-watchdog.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        arinc.unal@arinc9.com, p.zabel@pengutronix.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org,
        Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v7 2/5] mips: dts: ralink: mt7621: rename watchdog node
 from 'wdt' into 'watchdog'
Message-ID: <20230228083920.GA5801@alpha.franken.de>
References: <20230214103936.1061078-1-sergio.paracuellos@gmail.com>
 <20230214103936.1061078-3-sergio.paracuellos@gmail.com>
 <20230214151101.GB742354@roeck-us.net>
 <CAMhs-H915iSR7TpuXdcg8NKLV8Scv9cwW36SZaXNK839kA4ybg@mail.gmail.com>
 <CAMhs-H_Ce-+MFi5zTMg8v8dSSg5ioaTy+Pw-0QMgK++PVtEViQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMhs-H_Ce-+MFi5zTMg8v8dSSg5ioaTy+Pw-0QMgK++PVtEViQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 05:44:21AM +0100, Sergio Paracuellos wrote:
> On Tue, Feb 14, 2023 at 4:12 PM Sergio Paracuellos
> <sergio.paracuellos@gmail.com> wrote:
> >
> > On Tue, Feb 14, 2023 at 4:11 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > >
> > > On Tue, Feb 14, 2023 at 11:39:33AM +0100, Sergio Paracuellos wrote:
> > > > Watchdog nodes must use 'watchdog' for node name. When a 'make dtbs_check'
> > > > is performed the following warning appears:
> > > >
> > > > wdt@100: $nodename:0: 'wdt@100' does not match '^watchdog(@.*|-[0-9a-f])?$'
> > > >
> > > > Fix this warning up properly renaming the node into 'watchdog'.
> > > >
> > > > Reviewed-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> > > > Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > > > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > >
> > > Acked-by: Guenter Roeck <linux@roeck-us.net>
> > >
> > > Note that we can not apply this and the next patch of the series
> > > through the watchdog tree since it crosses a maintainer boundary.
> >
> > I was expecting Thomas to get these two arch/mips patches or get an
> > Acked-by from him in order for you to apply them.
> 
> Hi Thomas,
> 
> I think you have missed this series since you have started to apply
> newer stuff in mips-next. Are you ok with taking or Acking patches 2
> and 3 of this series?

yes, I sort of missed it. If it's enough to take patch 2/3 I'll do that.
If it's better to keep the series, I'm also ok with acking them.
What's the best way forward ?

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
