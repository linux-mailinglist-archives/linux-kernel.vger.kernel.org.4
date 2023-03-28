Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C86D6CC1A8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 16:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbjC1OCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 10:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233060AbjC1OBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 10:01:45 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC62E04A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 07:00:30 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 54AE61BF217;
        Tue, 28 Mar 2023 14:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1680012029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pe8UkDisXrYYXdGuQJ+Czrio2NwMLtL21uYVzi/8p9Q=;
        b=O9lQOw4dpI7Y8EoYM1opImQ58RBCVbFz4qL8h9ADAWgvtcgOyKYCtOKRc48gErUlixj+NL
        o65hhGBWqBD9KheOkuD9TUcVOFApDEzn0hPFfWj+vOzEs71NQQvaN2B5p947ophQ/3hGMd
        hE1rHs+COdXJxY8NTW5zV/4lAkA2P8WjkWPqzlcqv+7yxFFo+sTVxtajCVP36LL0XULMM1
        LS/DKEHQERoWktRrEVGJ1utvOe6giYeDkcMf/vq8jdXqQCrWu5rfl+kFW9vJ61WFoyJgPM
        odrU621R43URI+lld63wnmsdlQpUBbjkMk55EVVz4P7raw7ZsWDt3DB3HJaKyw==
Date:   Tue, 28 Mar 2023 16:00:27 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Richard Weinberger <richard@nod.at>
Cc:     Bang Li <libang.linuxer@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtdblock: tolerate corrected bit-flips
Message-ID: <20230328160027.21b5b340@xps-13>
In-Reply-To: <1785377500.357636.1680009710991.JavaMail.zimbra@nod.at>
References: <20230323140350.69908-1-libang.linuxer@gmail.com>
        <20230328145848.5c7e4f14@xps-13>
        <1785377500.357636.1680009710991.JavaMail.zimbra@nod.at>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

richard@nod.at wrote on Tue, 28 Mar 2023 15:21:50 +0200 (CEST):

> Hi!
>=20
> ----- Urspr=C3=BCngliche Mail -----
> > libang.linuxer@gmail.com wrote on Thu, 23 Mar 2023 22:03:50 +0800:
> >  =20
> >> mtd_read() may return -EUCLEAN in case of corrected bit-flips.This
> >> particular condition should not be treated like an error. =20
> >=20
> > I'm fine with the patch, Richard, are you okay as well? =20
>=20
> Hm yes. I see the bug. I think it broke about 10 years ago
> by e47f68587b82 ("mtd: check for max_bitflips in mtd_read_oob()").
>=20
> In the early day I'd expect someone to hit this bug but I guess
> on the last 10 years mtdblock had no real users.

Right.

Well, anyhow I guess this patch deserves a Fixes/Cc: stable # v3.7+

Li, can you please re-send with the proper tags? Thanks.

Thanks,
Miqu=C3=A8l
