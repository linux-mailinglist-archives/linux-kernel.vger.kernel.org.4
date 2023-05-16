Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6802705133
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 16:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbjEPOrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 10:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234039AbjEPOrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 10:47:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9997630E6
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 07:47:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 352FA62E1E
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 14:47:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37E40C433EF;
        Tue, 16 May 2023 14:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684248432;
        bh=rw01jFzWE+dBQpKmkiy9pElSCaXqj2ETacLAGV1l9oo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uHPkdJH2fkM20Qy/X/CKY36SBlgoEEA7fx/nrNx4VWH9MW31yTTVmeHG4WUdwLBMs
         8Ucb3uxPgVPgum5XQ9kXVLJiNdRBGIP55mGU92ptmegHd0hApTjuVEbTaGVE9bezHH
         esNhPto0FyvH6GHzVgSDCmVQadPuWH+XRiVZ8VVwPNnc4qrMbkV5GQjAUUOkqkovX1
         LPopTHzxVUs/X4S5hjM7N/C9uUswJmfS+YAGMXWDpZtO0hITsqxyO4Un1SVZjDSEg8
         zu27hUNLHQjAyIOgopHqu6CElVMRjx+htCYnLxxbOK0UuF855y+du2H9xxWmaq8BCv
         tutB19X1NTY6w==
Date:   Tue, 16 May 2023 23:47:09 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Baluta <daniel.baluta@oss.nxp.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
        peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        daniel.baluta@gmail.com
Subject: Re: [RESEND PATCH 0/2] Improve support for sof_ipc{3|4}_bytes_ext_put
Message-ID: <ZGOXbaq7jILy2a39@finisterre.sirena.org.uk>
References: <20230516132401.205563-1-daniel.baluta@oss.nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="j9f+YHhPoyVZmHLb"
Content-Disposition: inline
In-Reply-To: <20230516132401.205563-1-daniel.baluta@oss.nxp.com>
X-Cookie: Avoid contact with eyes.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--j9f+YHhPoyVZmHLb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 16, 2023 at 04:23:59PM +0300, Daniel Baluta wrote:
> From: Daniel Baluta <daniel.baluta@nxp.com>
>=20
> This patch series provides better handling of cases where sending
> a data blob to FW results in a validation error.

Please allow a reasonable time for review, we're only at -rc1.

--j9f+YHhPoyVZmHLb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRjl20ACgkQJNaLcl1U
h9D8aQf+I5WsLa82cUh8ITXa9tQK1ma83k9JpIwd68KZvIPSDmH/1RbVUGv87fHz
Q39FdEpGarPImVJBaOS+tUa1m+dlAKrR3fAqbMl54JrdZ25ikLksXcAoLU2x1//s
oTpSzE3iHBDI6/e0E44oM19x8Up57q2cbn6Dk7olzALVrwVHJRHZDW94Mb0qVffz
D2tflhza/w8FRLvv1xcibl+uGTNy8g4E11ZdAPIkqrS2W/DZwwRC3Ds4gMA2NOdX
Yy6EiddmmS8MRvHirk4q8VCRMGrIILaJZTguLEwNDukwZuP3uhsaHpXVMNsiPbJc
6gWEKLHYvnUPyqtLf0MBuVFcEhGagQ==
=R6fk
-----END PGP SIGNATURE-----

--j9f+YHhPoyVZmHLb--
