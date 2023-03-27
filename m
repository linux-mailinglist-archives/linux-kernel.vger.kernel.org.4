Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7ACD6C98EB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 02:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjC0AGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 20:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjC0AGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 20:06:18 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708A11FC7
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 17:06:17 -0700 (PDT)
Date:   Mon, 27 Mar 2023 00:06:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1679875574;
        bh=jHjpxcedBEzz1656QTLn588+xnSNIb6Y8NrCIkTQtyA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iBV4OpLyQEtZHJzUeo3YaV5COhjMeEa+lf5AiyFUkca1Wv4VqfOBezzhsN4czvQwm
         IBaCRvj5tkmKZ6/Y9NtH961MHXIcPgSOn3/2zgKEjQiBvYmI/os5qkeeyvDW8lUcOq
         FRJ6ROIDlP5f5lebV9KMSW/VjXKdWRYNtZQv+wLo=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
Cc:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] firmware: turris-mox-rwtm: make kobj_type
 structure constant
Message-ID: <ff929507-a1e1-4cf6-a5f8-79d65f3ec608@t-8ch.de>
References: <20230227-kobj_type-firmware-turris-v1-1-e48f65155ec5@weissschuh.net>
 <20230326125759.qhq62wjaeu75rd3j@kandell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230326125759.qhq62wjaeu75rd3j@kandell>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,

On 2023-03-26 14:58:16+0200, Marek Behún wrote:
> Didn't I already give reviewed-by tag?

Yes indeed. Sorry for that oversight.

> Reviewed-by: Marek Behún <kabel@kernel.org>
> 
> On Fri, Mar 24, 2023 at 04:27:50PM +0000, Thomas Weißschuh wrote:
> > Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
> > the driver core allows the usage of const struct kobj_type.
> > 
> > Take advantage of this to constify the structure definition to prevent
> > modification at runtime.
> > 
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> >  drivers/firmware/turris-mox-rwtm.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
