Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF626F3300
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 17:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232729AbjEAPhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 11:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232508AbjEAPhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 11:37:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39026FF
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 08:37:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7A8D61BFD
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 15:37:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83D76C433EF;
        Mon,  1 May 2023 15:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682955437;
        bh=KHtzVvhao5lIdEbOTmMfnch0KO5Rs+DtKi0nE8rYGeQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=miwn0zUCFWgK5LmXTT10zLCI7/puvbBYADKXmbWJpJATU/wlQVpFAq2JWE/qFu6qD
         ocmZFNS1bbxkPv8cerrUBXkefJQ3MMUkogpaxI+NJeAEsVQkuTGjUsh4j1yzSLvrRv
         /ODZdGIr40qqZMAIOT4EbRuvF6VgdNeQgnQw5S1foFyRaTwODuF2SiPX8YjmsoPnLk
         tMVxN/BOUhBglPj0xwu+/myrs8eSGIYQ24JBB+UpIJLTCbSwSUj/gwkVmhbnDY+Dc7
         wwreeWlc5F0SNIQEvoP/JDFlm5RLytQP9M7/kMk2Ow2Oe4GylT19MaRYEtkSw71Tfo
         vyToH4ZDDMxxg==
Date:   Mon, 1 May 2023 16:37:13 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Evan Green <evan@rivosinc.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2] RISC-V: fix sifive and thead section mismatches in
 errata
Message-ID: <20230501-slate-headlamp-453304e8864d@spud>
References: <20230429155247.12131-1-rdunlap@infradead.org>
 <CALs-HsuG3EFBs60sgiMcPHoE1dF7mhi3GKt=AWvRPaUHAfA88Q@mail.gmail.com>
 <20230429-outboard-hypocrite-983e977103d2@spud>
 <CALs-HstrR3Cm3jQKt6dmfYiRRVkAVibAZDtFo0wmXz4LEvRf_A@mail.gmail.com>
 <37e6b325-44e4-8e65-68e3-eab2943018ac@infradead.org>
 <CALs-Hss3b86zAqohK9NYEkzn+pnLeMB37qaj1EA6f6bRkFWwCg@mail.gmail.com>
 <20230429-dandy-gush-6f5da93055bc@spud>
 <CALs-HsuP1moOdZQG_Ur3J3cQ1J+j9Zr-tiSgAkvmCsOXaca9ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="QxAgSuPjgLnnYY2e"
Content-Disposition: inline
In-Reply-To: <CALs-HsuP1moOdZQG_Ur3J3cQ1J+j9Zr-tiSgAkvmCsOXaca9ag@mail.gmail.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QxAgSuPjgLnnYY2e
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 01, 2023 at 08:26:19AM -0700, Evan Green wrote:
> On Sat, Apr 29, 2023 at 12:11=E2=80=AFPM Conor Dooley <conor@kernel.org> =
wrote:

> > Ohh man, that's a pretty bad config to try use (if that's your default)
> > for build testing stuff. The k210_mmu defconfig doesn't enable anything
> > other than SOC_CANAAN.
> > I could reproduce Randy's issue on defconfig w/ CONFIG_MODULES disabled.
>=20
> That's the one that caught me before, so I remembered it as being
> "different". I'll try what you describe above next time I'm hunting
> for section mismatches.

By nature of being nommu with lots of stuff disabled, it is a good niche
config to test - the nommu stuff mostly gets forgotten about..
On the other hand, it does skip the errata handling stuff which is what
caught us out here.

Cheers,
Conor.

--QxAgSuPjgLnnYY2e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZE/cqAAKCRB4tDGHoIJi
0gf8AQCJyVILPz8wxSdIrC7f2r/NhPPXJy2BPIJHHNte8eGICQD/Qw61dfip/QUD
cSQ4ka2QSjgqad2+EwxS9Gp292pZtA4=
=G+d+
-----END PGP SIGNATURE-----

--QxAgSuPjgLnnYY2e--
