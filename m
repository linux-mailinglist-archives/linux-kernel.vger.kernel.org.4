Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C65F64B2F2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 11:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234698AbiLMKFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 05:05:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbiLMKFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 05:05:44 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE44E1A22A;
        Tue, 13 Dec 2022 02:05:36 -0800 (PST)
Received: from leknes.fjasle.eu ([46.142.49.245]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M5jA2-1oyzTl1Y2U-007Fcu; Tue, 13 Dec 2022 11:05:07 +0100
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
        id DD9453C0EE; Tue, 13 Dec 2022 11:05:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1670925906; bh=to4bs5gUDbfpV3AAxLoymUvOMM9J2nSWIXUajtMe3Ak=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=5j02RSycBJPPGPbxtCBeEwt4yyAxuZrOOqRD2oH0Iw1iTTnDIExgT4JJ/sdWy79lw
         lWHCtfSYfj5s9oKnFQNrMhFhBmZIrqK98IVoiehPl/qbqje7CID6m1NBLyQ5IipH3e
         sj/zpyRt3ZYo8OmbWJdqdjpyx4S7p14e1+0n9ORI=
Date:   Tue, 13 Dec 2022 11:05:05 +0100
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] kbuild: ensure Make >= 3.82 is used
Message-ID: <Y5hOUYUYmwGioGiP@fjasle.eu>
References: <20221211030352.2622425-1-masahiroy@kernel.org>
 <Y5djBr9rVhSq8+iK@dev-arch.thelio-3990X>
 <Y5f4ZgyK7QlqYu31@bergen.fjasle.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5f4ZgyK7QlqYu31@bergen.fjasle.eu>
X-Provags-ID: V03:K1:TLaud2aU53BM9FaN1X4YF6U22AjkeFuENS6PaJSyONYhiZpyWSI
 z3rS545QbRJmQu8DuRoQ4cz6Be/q1OsgLlbfB9ioN/2iO8NujVmMrAsEFsny70Byf2c3X3b
 VzcEI84J8tiZk8AuF/ogM5ai5qo6vv8YbqJPg6JZgawxRpxvKNcSD0eJ75TDK1WsMB76c2n
 R4925g6nO5Y69AG7GLT1Q==
UI-OutboundReport: notjunk:1;M01:P0:VLghQZ4PUcg=;C6jf9aSg8W4EoQ2iMAIFtRybbSR
 qzh7kRYZUipsDWLRA8JX7K6IDK33MO7xvsptCw9pt7ATTFCRE/kNDqugViJvvl28ZBE1eZ3xy
 ZdiWddwwsJW3x3POZDtEw0FsUY6lTd7kLPeblSEjJJ0Y7NcSbmUts5KUOv9QSYimbriwwX1CV
 wiqoJJ95vE+yR/tYZm+gfcVLP2kKP93BaGCZsksvXfGhXnr8TSPMgWLXzaHKIajM5qWvrsW7R
 I1Ua8XAVHmMIiXNyIm3iG5kJ4SFFbBjrUy09cxPP/wfZENzKhycBl7pg25CZhMq/4Mf4UGDkP
 NiHjg0QPNdZBNCkTLXaXonIxE8vfhmjGW+4wjG/VmJVDp/q5u6IsKkRsLh4TfJhcohz2GJl/E
 3LyRS1UTldvYHCOMhjroiStF8BrNHdoD/DI/RZOHc6vSLvqIj+yT3YfyTrAQTXd6e8y3aU+KN
 C8VPJ+J7UlP45UvninxudPJzoG8p/WXCjwbfqmSloNjIku6OTlG2upFKFbRAGqnhqvVLaa2E7
 AWO9GuQNQE421worVlokf7oIo3JsJ3VLu9FhmJRbE4mj9URski+i3BnLf45B28W5HZ+9VAFTw
 A6Vukr5hkMmrs0ctAiZvFkShoxTQBKleBevlzyzF/LzKtiQXgxyjqySwC9aRcA7FDuOGDuyoe
 3TqzjP3LngZ4BoXZloKK3Ma3dXtud4c2rhDf/8YyPg==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 04:58:30AM +0100 Nicolas Schier wrote:
> On Mon 12 Dec 2022 10:21:10 GMT, Nathan Chancellor wrote:
> > On Sun, Dec 11, 2022 at 12:03:52PM +0900, Masahiro Yamada wrote:
> > > Documentation/process/changes.rst notes the minimal GNU Make version,
> > > but it is not checked anywhere.
> > > 
> > > We could check $(MAKE_VERSION), but another simple way is to check
> > > $(.FEATURES) since the feature list always grows although this way
> > > is not always possible. For example Make 4.0 through 4.2 have the
> > > same set of $(.FEATURES).
> > > 
> > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > 
> > Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> 
> Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
> 
> > > ---
> > > 
> > > Changes in v3:
> > >   - Check the version in a different way
> > > 
> > >  Makefile | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > > 
> > > diff --git a/Makefile b/Makefile
> > > index 2dda1e9a717a..66dfc5751470 100644
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -11,6 +11,11 @@ NAME = Hurr durr I'ma ninja sloth
> > >  # Comments in this file are targeted only to the developer, do not
> > >  # expect to learn how to build the kernel reading this file.
> > >  
> > > +# Ensure Make >= 3.82
> > > +ifeq ($(filter undefine,$(.FEATURES)),)
> > > +$(error Make $(MAKE_VERSION) is too old)
> > 
> > Would it make sense to state what version is needed, similar to the
> > Kconfig checks for compiler and binutils?
> 
> Checking against 'undefine' (introduced in make-3.82~38) is quite a 
> nice way, I think.  Otherwise we needed something like
> $(filter 3.82% 3.9% 4.% 5.% ..., $(MAKE_VERSION)).
> 

Nathan, sorry, I somehow I read your question completely wrong.  I would also
appreciate if the minimum make version would be shown in the error message.

Kind regards,
Nicolas
