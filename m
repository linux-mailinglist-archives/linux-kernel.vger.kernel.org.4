Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6CF467A047
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 18:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234012AbjAXRgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 12:36:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbjAXRgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 12:36:09 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335FC4B776;
        Tue, 24 Jan 2023 09:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=P0UVVZ/T20C+FbphTkl6yWazQ/wHn2ipLQ/Uu2/aGjU=; b=V+zU+rnXkFyARYvB30wRXlaD6k
        mjgxQYZl8jahXZn+6uSXGFzw8fnxRpQj0BEJxlkV9cT2ZKoGDto+BUZ6AR5i9K5ZYe99rbDkUjAT1
        SmU3PX7YsUwgTbTVmT/eYAKB+X/hsz3lkZTZf9zng+l1DnZPj+04exZcgb3wZNPodkiTplhsV2dSE
        DIDtDHcNA8U0ULPUdvwyjldirdcsOtKjxc1bcaccaFgfsZry45/p1INOBK9wNYkmwMOUFtHU6ojHS
        N4Ti1nsN5vCvl+RpQzeejCCOHDNmo2ksidkalhwCYUYnAHxDDEnubT3dXjXppKuV9tglte4xzK1Gd
        G1UaJWpw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKNDH-004qKN-J9; Tue, 24 Jan 2023 17:36:03 +0000
Date:   Tue, 24 Jan 2023 09:36:03 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Diederik de Haas <didi.debian@cknow.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "open list:MODULE SUPPORT" <linux-modules@vger.kernel.org>,
        "open list:MODULE SUPPORT" <linux-kernel@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH] module.h: Fix full name of the GPL
Message-ID: <Y9AXA/d+7wK5U5YA@bombadil.infradead.org>
References: <20230122193443.60267-1-didi.debian@cknow.org>
 <Y89HHtQQ4/pvsOut@debian.me>
 <3145585.5fSG56mABF@bagend>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <3145585.5fSG56mABF@bagend>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 02:32:26PM +0100, Diederik de Haas wrote:
> On Tuesday, 24 January 2023 03:49:02 CET Bagas Sanjaya wrote:
> > On Sun, Jan 22, 2023 at 08:34:43PM +0100, Diederik de Haas wrote:
> > > Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
> >=20
> > No patch description, really?
>=20

<some odd rationale to describe why your commit log is empty>

> So I could've added "The full name of the GPL is not GNU Public License, =
but=20
> GNU *General* Public License." to/as the explanation body, but I didn't=
=20
> consider that to provide extra (needed) info which wasn't clear from the=
=20
> Subject and diff.
>=20
> My only previous patch submission (to the linux kernel) did contain a ful=
l=20
> explanation body: 7074b39d83f5d71fa4f0521b28bd4fb3a22152c1
>=20
> *) I made a clusterfsck of similar patch submissions where I replaced "GN=
U=20
> Public License" with "GNU General Public License", and got the exact same=
=20
> comment from Bagas to several of them.
> I've (now) retracted all of those patches, except this one. In those othe=
r=20
> ones, I later realized I would actually be changing the license, not mere=
ly=20
> fixing a spelling error.
> See https://lore.kernel.org/lkml/2281101.Yu7Ql3qPJb@prancing-pony/

We use SPDX for precise langauges for the license used. Patches like
these and the one you just sent are otherwise not adding more.

> AFAICT, for this patch I'm not changing the actual license, only referenc=
es to=20
> that license, so that can still be considered spelling fixes.
> That's why I haven't requested to ignore this patch (too).

The only reference we care for is the SPDX one and that work is already don=
e.
As such minor fixes in spelling like yours won't do any good but just
noise at this point. That's exactly why SPDX license tags were
embraced, to make this simple and let us move on with life while having
one simple codified reference to the license so we don't need to deal
with redundant patches fixing grammar on license many times.

As such this changes is not needed.

  Luis
