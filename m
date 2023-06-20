Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0032E736433
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 09:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjFTHOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 03:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjFTHOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 03:14:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF568102;
        Tue, 20 Jun 2023 00:13:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 647E161028;
        Tue, 20 Jun 2023 07:13:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCDF6C433C8;
        Tue, 20 Jun 2023 07:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687245212;
        bh=1y+VtNLwJrKLT2Xro2f2tenE0VQo9dHi5xHhGsddYlQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bl5TreKUpa+fXzZt0n1tpSyKHR6jOHOTURRggzdbcWPlonOsy/eKLy3//lc1waU6v
         pilOjY8NDGmwgd/rybuOQB6veUFp/AOeXcC14ugH8egtZekJN/phoFiNMp8VawVnXz
         ZhVWUR5HNyR8IOAMyEzdbYQQBZ/rdZ3JsOI0Kqz9waK/f/O1CC3/ppE/Eda0qmzBnD
         AbHIyVKCNHH+ik65l7t3VexJ4eiwRAXH9SN9X9wNJgSRHMKxAN12kOljEOWeTh1AnA
         SeWs/QVj9zs0oepj+fb5ctl9MWxQnBvumnyXikvZAfrB9TIA30pTVYji9CIw0d4ptt
         Rgozg7fQ6SFXg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1qBVYS-0006rW-KE; Tue, 20 Jun 2023 09:13:32 +0200
Date:   Tue, 20 Jun 2023 09:13:32 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/5] WIP: gnss: merge MTK driver into UBX driver
Message-ID: <ZJFRnIFUokVvV-pY@hovoldconsulting.com>
References: <20230523064310.3005-1-wsa+renesas@sang-engineering.com>
 <20230523064310.3005-2-wsa+renesas@sang-engineering.com>
 <ZIcC/sg59Ti+lL1N@ninjato>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RdwJSyFfD4ZQu4X2"
Content-Disposition: inline
In-Reply-To: <ZIcC/sg59Ti+lL1N@ninjato>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RdwJSyFfD4ZQu4X2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Wolfram,

and sorry about the late feedback on this. Didn't have time to process
my queue before some holiday last week.

On Mon, Jun 12, 2023 at 01:35:26PM +0200, Wolfram Sang wrote:
> On Tue, May 23, 2023 at 08:43:06AM +0200, Wolfram Sang wrote:
> > This is a proof-of-concept how easy it is to merge those two drivers as
> > they are extremly similar. The differences can be abstracted away
> > easily. Further work (renaming from 'ubx' to something more generic,
> > removing the MTK driver, ...) is postponed until there is agrement that
> > merging these drivers is actually wanted. I vote for it, though. I have
> > updates to the UBX driver which do make sense for the MTK driver as
> > well. Code saving is also a plus. We can always fork into a specific
> > driver again if we'd ever need that.
> >=20
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
> Johan, just from a gut feeling or a hi level glimpse: is this merging of
> the driver worth pursuing?

No, sorry, keeping separate drivers per vendor was a deliberate choice.

First, some of these devices support vendor specific protocols which we
may add driver support for at some point beyond currently just exporting
this information to user space (e.g. to change line speed from the
driver).

Second, device families are expected to share at least some common
properties like reset signalling and supplies, which are better kept
separate.

Johan

--RdwJSyFfD4ZQu4X2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQHbPq+cpGvN/peuzMLxc3C7H1lCAUCZJFRlgAKCRALxc3C7H1l
CE9uAPoDOCcslpVdVXfiZsutfx48VGXLPsn0tJ/5/XK/7jMUYwEA6GPIuiDENUs/
9TuPGlvdlKZwIYmCayAQGGLeAL59rgk=
=9MKc
-----END PGP SIGNATURE-----

--RdwJSyFfD4ZQu4X2--
