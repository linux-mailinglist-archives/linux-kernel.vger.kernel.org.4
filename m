Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4026F16DF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 13:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345909AbjD1Lf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 07:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345678AbjD1Lfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 07:35:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A015FCF
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 04:35:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BAF5964322
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 11:35:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CD70C433EF;
        Fri, 28 Apr 2023 11:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682681747;
        bh=0kSWpQkRsDZ+pmfGKO8UDJNIyW0xzM6cUGxy1UTf/UE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QAcXMR/q4XLqtV0fkBIySl1ru/GJkwrtzw4GW2S9pIS6Bqvv27nt9NID1OxrlE8bU
         g/3BuXHCpK/hN1GcyARadoEJLPTFKtWnWnWLaTVoM3+vF9aQa0knHiSQJ+6BmQyCV6
         Qwehlyko9119eGJ7s7JgvbywrflVBTm333KZfTThH0Hnxtl6YBwz2+RV/oBB5WHoMS
         1fLelL5rYW7HG2SKRuSQiHb2e1I7xpiT/Ay84VyheHCYfd6f2FGOBoSLv1nSOFMjRe
         IWu5pVYjKSQpejtvsqYL2Yuj3DyecPl7LfQoYDucWaeKWdV5htFbzKZITTBV1LxeF4
         qLPdG2TKe6MLg==
Date:   Fri, 28 Apr 2023 12:35:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] regmap: force update_bits() to write to HW when reg
 is volatile
Message-ID: <14d81f72-ab34-4405-b826-b52636d2be18@sirena.org.uk>
References: <ZEtdJtlbmDCvZuAc@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AfGEgsfhV+xzX2KV"
Content-Disposition: inline
In-Reply-To: <ZEtdJtlbmDCvZuAc@fedora>
X-Cookie: Love means nothing to a tennis player.
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AfGEgsfhV+xzX2KV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 28, 2023 at 08:44:06AM +0300, Matti Vaittinen wrote:
> In many cases the volatile registers are expected to be written to
> regardless of the existing value (because, the value of a volatile
> register can't be trusted to stay the same during RMW cycle). In fact, it
> is questionable if the volatile registers and regmap_update_bits()
> conceptually make sense without device specific map->reg_update_bits.

I think you're looking for regmap_write_bits() here.

--AfGEgsfhV+xzX2KV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRLr40ACgkQJNaLcl1U
h9BxAQf/aWO4/AAtXLmJLtlvlqGPN00e6gJ8qqJEwtN3JzA37KJf84dw01nFog6U
lotf6fxdrmGzJwUXSOTAwPseJsvh6PZoQFqCTrUzFJ3xFKT6fjrvlmjTz34dnviR
39Rj7p9vetv3/mtg3L1u1i12YTpIcgQg/XdwUDfQcsBLd8HfTbA0cVlc17Rb0O3s
612M4zM+r895LFgBKxuX60DJGYES8Fqa5ErJEUNdDOMdUrR5J1Vdut/jim+Hukuu
iHtDN2JExZNgoVNEycb5vHVI6FSj1gAUtgwHiNdI1DQDOB1LetXN61PgAeTMnnxK
SjfV1gZxfhwfs1Q3Ubp7KQWhjvHqBw==
=kQgC
-----END PGP SIGNATURE-----

--AfGEgsfhV+xzX2KV--
