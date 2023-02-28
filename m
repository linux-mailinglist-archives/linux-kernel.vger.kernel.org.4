Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7AD6A5F7B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 20:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjB1TRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 14:17:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjB1TRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 14:17:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68AF632CE5;
        Tue, 28 Feb 2023 11:17:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1A41EB80E9E;
        Tue, 28 Feb 2023 19:17:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E12E1C433D2;
        Tue, 28 Feb 2023 19:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677611863;
        bh=tbBHih+BlQpiuWkfDlkNSPDu62Kp0d5C8Z4dXWEYjUw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TAjSWZTuC5WAxV7Y4NIludXkc+t17IiL3M1M+bBcZl0PKSsLpDU2085Pi000XQ2WH
         lMuXT2JerPRtamHKHWVtM9wsyhcYfEgU7YYEZckTAUtRfLuOmRbF0AcdovEx5clJM8
         qCK8RB5gAPzkIrS/ME3ie3UYeJwazoANm7ggGxLcFr7hXLajfS/vcQ1DdoaAA3YBkq
         dvbqQzwRjbAh88WOD3VYqbLJdlsTuU8pWeoBo7cJniavH3Q0dt5hZlCSrXfM6VJOZi
         VRYkaYVuhFJF4tbmr4cZO8dBxB0XyKhLGYPCC3CQ1uL/5e6GnN3+m67JfsaFkWYhkL
         Uu4Iuof3daTOA==
Date:   Tue, 28 Feb 2023 19:17:39 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     mcgrof@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 13/20] reset: remove MODULE_LICENSE in non-modules
Message-ID: <Y/5TU/gxAxfVOedg@spud>
References: <20230228130215.289081-1-nick.alcock@oracle.com>
 <20230228130215.289081-14-nick.alcock@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Au4nMfSCNexqlvKW"
Content-Disposition: inline
In-Reply-To: <20230228130215.289081-14-nick.alcock@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Au4nMfSCNexqlvKW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 28, 2023 at 01:02:08PM +0000, Nick Alcock wrote:
> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
> are used to identify modules. As a consequence, uses of the macro
> in non-modules will cause modprobe to misidentify their containing
> object file as a module when it is not (false positives), and modprobe
> might succeed rather than failing with a suitable error message.
>=20
> So remove it in the files in this commit, none of which can be built as
> modules.
>=20
> Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
> Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: linux-modules@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
> Cc: Conor Dooley <conor.dooley@microchip.com>
> Cc: Daire McNamara <daire.mcnamara@microchip.com>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: linux-riscv@lists.infradead.org
> ---
>  drivers/reset/reset-mpfs.c | 1 -

I assume your script just got confused here w/ $subject, since there's
only a change for this specific file.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.


--Au4nMfSCNexqlvKW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY/5TUwAKCRB4tDGHoIJi
0terAQDSN1HWs/d81DkwGzTWp+TvAGlzI9nhxxsO5lH/XaBLHwD8CXFo5YJnBCXe
/rXkDTfNkUmEq73ZyZrtRNTGoovC/gk=
=GpeS
-----END PGP SIGNATURE-----

--Au4nMfSCNexqlvKW--
