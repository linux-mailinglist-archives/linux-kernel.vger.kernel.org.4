Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646A167F730
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 11:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234208AbjA1Kjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 05:39:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234150AbjA1Kjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 05:39:41 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D8377DE7;
        Sat, 28 Jan 2023 02:39:37 -0800 (PST)
Received: from fabians-envy.localnet ([217.252.157.184]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N5W4y-1obnrm1Ha6-016tD7; Sat, 28 Jan 2023 11:39:20 +0100
From:   Fabian Vogt <fabian@ritter-vogt.de>
To:     Andrew Davis <afd@ti.com>, Daniel Tang <dt.tangr@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/9] TI-Nspire cleanups
Date:   Sat, 28 Jan 2023 12:24:16 +0100
Message-ID: <12156339.O9o76ZdvQC@fabians-envy>
In-Reply-To: <CAPnH9dnGZxbMGy7c_7PFqw6R1PSVba00XWK8rUN4MEsWU7=9=g@mail.gmail.com>
References: <20230123214924.27476-1-afd@ti.com>
 <3ab320ef-dfbb-eee4-f895-6f1caa6cc66f@ti.com>
 <CAPnH9dnGZxbMGy7c_7PFqw6R1PSVba00XWK8rUN4MEsWU7=9=g@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:nqY5ceX8lNmFiC2wgzSgJ5kryUFWnUpgSxxqSZaClMQBF618Ha7
 +TO6vI8wC23Wa9PDegXwwWg4IRRkj/NlADTq8wq9JRPL7ovdQKELgbHFACbu9WlSanJR6Zm
 zlLGhUFZW+g+Zgum4o4joU5wLVLIEJ3SIWhXGgiwW+zAjuKisz2RVKAexdOmGPF4lYS0iMp
 lo9GMPmm9dE1VuKVM7Eaw==
UI-OutboundReport: notjunk:1;M01:P0:rRHQRaZ5h2M=;UwzaUknYANHX1nn46FcVMzJYOl2
 jbnIbRQVEm30GlIWMmr8YEzvN9FmYOpfhNyrHD+QMbdWqQyLKK21pJD6XH7xR6ZZntbVQSjbr
 arKP6VPp1XAHN9Q94R7l4/KBGNCmTUZbES7Bff0P/aUCkHQxY3lq9D6jf43SfgRvYDFmzA5x4
 HgGte8hpxfaezstOeQvrjKz+bb4CmJoRztIJSuliPdlRLw1AYi9z7KSXpwS5VOYn5pkRIc+v4
 3XWzxOlRJFBGGxZnR90YC9Sv3PIoXWPMj2SFIshvrHdf5U1a70zUaLrTJj6qGoaZc/yIiq7+D
 4khu/kYz+RCCDv7p3V9xnpJfxc7l1L+OY+g6JPRd97f5BGgb2Jwud8IkIsn4MjwkqMdSGd3FN
 vG52teIZGcVOA/2p1GDE7iUi9B/zynatSl8Z/KA+IWjvBDK0beQnh0fniMDzuPLaI86oGoQoF
 3cfxEj/c8gvBYRbn5yyx5CV8P/tULQmlGYe64LHvD2ywp97gXvvwDWyCLE12O/s0FmndWzEjq
 SZB4yX3oAa8py2VSBOcPOIR6Rs/Bh6BY2IEB6lVc0wGVxsVgBV77n2KGV93HZRElVEEGXhh0C
 +W/ebjsPfetGVaN3fe/leisL4TwyXyv0vQDCh3e0hdJ9eVzUvZv7BpYcXZbgeos3SQmoucRaX
 tNgclBDpqYASV0SNUyO4Kp+44Pi7jvyCQLOl+06w/Q==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Samstag, 28. Januar 2023, 03:00:49 CET schrieb Daniel Tang:
> On Tue, 24 Jan 2023 at 10:56, Andrew Davis <afd@ti.com> wrote:
> >
> > On 1/23/23 3:57 PM, Arnd Bergmann wrote:
> > > On Mon, Jan 23, 2023, at 22:49, Andrew Davis wrote:
> > >> Hello all,
> > >>
> > >> This series is an extended version of the series started here[0]
> > >> and here[1].
> > >>
> > >> We break out what was the first patch into one for DTS change and
> > >> one for code changes as suggested by Krzysztof. Those are now patches
> > >> 2 and 8 of this series (I kept the ACKs, hope that is okay).
> > >>
> > >> As also pointed out by Krzysztof syscon nodes need a specific
> > >> compatible, add that as patch 1.
> > >>
> > >> While I was adding that, I noticed some other dtbs_check issues,
> > >> so while here fixed some of those up too (patches 3-6).
> > >
> > > Looks all good to me, if there are no final comments within the
> > > next few days, can you send this all to:soc@kernel.org, either as
> > > separate patches or as two pull requests (dts and code) based
> > > on 6.2-rc-1?
> > >
> >
> > Sure thing.
> >
> > > I think I previously commented on the lack of an entry in
> > > the MAINTAINERS. It would be nice to have one more patch to
> > > add this, whichever way you want to split this with Daniel,
> > > adding one or both of you as maintainer and/or reviewer.
> > > I'd keep that separate from this series though, to not hold
> > > it up any longer.
> > >
> >
> > Daniel,
> >
> > Do you want to do this? If not I can add myself as a reviewer, the
> > point of this series is to boil down the support to just the DTS file,
> > at which point hopefully we won't need too much maintenance.
> >
> > Andrew
> >
> 
> I would prefer that someone who is more active in this project be the
> maintainer (I've not been working on this platform for many years now,
> and don't currently have the means to test changes).
> 
> Fabian, would you be OK being listed as a maintainer for now? If not,
> I'll get in touch with some other project team members to find a
> maintainer.

Sure.

Cheers,
Fabian

> Cheers,
> Daniel
> 
> > >       Arnd


