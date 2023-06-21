Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895AA738587
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 15:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbjFUNnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 09:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjFUNn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 09:43:28 -0400
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B496E19C;
        Wed, 21 Jun 2023 06:43:26 -0700 (PDT)
Received: from jerom (99-112-204-245.lightspeed.hstntx.sbcglobal.net [99.112.204.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: serge)
        by mail.hallyn.com (Postfix) with ESMTPSA id 0AF18B66;
        Wed, 21 Jun 2023 08:43:23 -0500 (CDT)
Date:   Wed, 21 Jun 2023 08:43:21 -0500
From:   Serge Hallyn <serge@hallyn.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] capabilities: fix sparse warning about __user access
Message-ID: <ZJL+edmv267MHhdQ@jerom>
References: <20230619123535.324632-1-ben.dooks@codethink.co.uk>
 <20230619175710.GA200481@mail.hallyn.com>
 <CAHC9VhRz0Y_D1Q=8xPKVJemYf=KUziC9s1TUJ86F+Lw+OrXdVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhRz0Y_D1Q=8xPKVJemYf=KUziC9s1TUJ86F+Lw+OrXdVg@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2023 at 05:47:54PM -0400, Paul Moore wrote:
> On Mon, Jun 19, 2023 at 1:57 PM Serge E. Hallyn <serge@hallyn.com> wrote:
> >
> > On Mon, Jun 19, 2023 at 01:35:35PM +0100, Ben Dooks wrote:
> > > The two syscalls for capget and capset are producing sparse warnings
> > > as sparse is thinking that the "struct __user_cap_data_struct" is marked
> > > user, which seems to be down to the declaration and typedef at the same
> > > time.
> > >
> > > Fix the following warnings by splutting the struct declaration and then
> > > the user typedef into two:
> >
> > I'm not a fan of making code changes to work around scanners'
> > shortcomings, mainly because eventually I assume the scanners
> > will learn to deal with it.
> >
> > However, I don't like the all-in-one typedef+struct definition
> > either, so let's go with it :)
> >
> > Paul, do you mind picking this up?
> 
> Sure, no problem.  Since we are at -rc7, I'm assuming this can wait
> until after the merge window?

Yeah, it's just fixing a sparse warning, no urgency.

thanks,
-serge
