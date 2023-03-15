Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D595A6BAC2E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 10:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbjCOJaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 05:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232109AbjCOJ3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 05:29:50 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 03DB1591FE;
        Wed, 15 Mar 2023 02:29:45 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1pcNS2-0004H0-00; Wed, 15 Mar 2023 10:29:42 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 4C4A0C1421; Wed, 15 Mar 2023 10:29:10 +0100 (CET)
Date:   Wed, 15 Mar 2023 10:29:10 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Keguang Zhang <keguang.zhang@gmail.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] MIPS: loongson32: Update the clock initialization
Message-ID: <20230315092910.GA8008@alpha.franken.de>
References: <20230210111141.1379645-1-keguang.zhang@gmail.com>
 <a3e6f6038511ad48258627dbf4c335e2.sboyd@kernel.org>
 <CAJhJPsUQN5Lo_rVUbbmGY68gorwkcQT=9AXfcEh371cP97Wj_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJhJPsUQN5Lo_rVUbbmGY68gorwkcQT=9AXfcEh371cP97Wj_A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 11:07:23AM +0800, Keguang Zhang wrote:
> On Sat, Feb 11, 2023 at 7:31 AM Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Quoting Keguang Zhang (2023-02-10 03:11:41)
> > > The Loongson-1 clock driver is under re-implementation
> > > to add DT support. As a result, ls1x_clk_init() will be dropped soon.
> > > Therefore, call of_clk_init() for clock initialization instead.
> > >
> > > Link: https://lore.kernel.org/all/20230209132614.1079198-3-keguang.zhang@gmail.com
> > > Link: https://lore.kernel.org/all/20230209132614.1079198-4-keguang.zhang@gmail.com
> 
> Hi Thomas,
> Sorry to bother you.
> For fear of raising build error, is it possible to merge this patch
> before the above two patches getting applied?
> Or is there anything to improve?
> Thanks very much!

the IMHO best way would be to let this patch go the same way as
the other patch set. So Stephen could you take this into your
tree, too ?

Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
