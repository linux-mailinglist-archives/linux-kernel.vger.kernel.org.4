Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C52F62EDFF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 07:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235227AbiKRG4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 01:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241181AbiKRG41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 01:56:27 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F043378180;
        Thu, 17 Nov 2022 22:55:48 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4ND6xZ4Nbbz4xDK;
        Fri, 18 Nov 2022 17:55:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1668754547;
        bh=zpIJyV/SE/GQuLb+QekPKnaIAyoRHjNCDfnh9lXNTio=;
        h=Date:From:To:Cc:Subject:From;
        b=Tv1YpRazSooRkyzsAEkauY56/t8M+eIeyVg1swjGd24YRaMYZjXg10RCAnL+P05+S
         1TGPRZ0LFHIQS9EQlaE3HmklFRXcn1r8Ofli36/rnLgVTl/r/XsAdkKcfjEE1MqxVR
         hXbccUZTg8ySRZd707nN9IqosV5DxUqLKQwNIs2/mr5D3dEvMwqFx3gh9gyksYjQZT
         KUaqIYp6aDoaFxqlwSUCMh2dZEDSnSoMCnA+y8g9YxvINpRsZegzb7eXDp23iFwaAV
         b1XxDeEvlk2LCKIVJ6wwKTOj1ZB4Xo/3vsUnT9fUiAiWWWv+QRENOoM+Ppb4WKSCWD
         /I/EW1oiWTOjw==
Date:   Fri, 18 Nov 2022 17:55:45 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>,
        Dave Airlie <airlied@redhat.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the amdgpu tree
Message-ID: <20221118175545.762d1a20@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=RzvDKe/gCXtsYIIZ247mm2";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=RzvDKe/gCXtsYIIZ247mm2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the amdgpu tree, today's linux-next build (htmldocs)
produced these warnings:

drivers/gpu/drm/amd/display/dc/dc.h:548: warning: Function parameter or mem=
ber 'dispclk_khz' not described in 'dc_clocks'
drivers/gpu/drm/amd/display/dc/dc.h:548: warning: Function parameter or mem=
ber 'actual_dispclk_khz' not described in 'dc_clocks'
drivers/gpu/drm/amd/display/dc/dc.h:548: warning: Function parameter or mem=
ber 'dppclk_khz' not described in 'dc_clocks'
drivers/gpu/drm/amd/display/dc/dc.h:548: warning: Function parameter or mem=
ber 'actual_dppclk_khz' not described in 'dc_clocks'
drivers/gpu/drm/amd/display/dc/dc.h:548: warning: Function parameter or mem=
ber 'disp_dpp_voltage_level_khz' not described in 'dc_clocks'
drivers/gpu/drm/amd/display/dc/dc.h:548: warning: Function parameter or mem=
ber 'dcfclk_khz' not described in 'dc_clocks'
drivers/gpu/drm/amd/display/dc/dc.h:548: warning: Function parameter or mem=
ber 'socclk_khz' not described in 'dc_clocks'
drivers/gpu/drm/amd/display/dc/dc.h:548: warning: Function parameter or mem=
ber 'dcfclk_deep_sleep_khz' not described in 'dc_clocks'
drivers/gpu/drm/amd/display/dc/dc.h:548: warning: Function parameter or mem=
ber 'fclk_khz' not described in 'dc_clocks'
drivers/gpu/drm/amd/display/dc/dc.h:548: warning: Function parameter or mem=
ber 'phyclk_khz' not described in 'dc_clocks'
drivers/gpu/drm/amd/display/dc/dc.h:548: warning: Function parameter or mem=
ber 'dramclk_khz' not described in 'dc_clocks'
drivers/gpu/drm/amd/display/dc/dc.h:548: warning: Function parameter or mem=
ber 'p_state_change_support' not described in 'dc_clocks'
drivers/gpu/drm/amd/display/dc/dc.h:548: warning: Function parameter or mem=
ber 'zstate_support' not described in 'dc_clocks'
drivers/gpu/drm/amd/display/dc/dc.h:548: warning: Function parameter or mem=
ber 'dtbclk_en' not described in 'dc_clocks'
drivers/gpu/drm/amd/display/dc/dc.h:548: warning: Function parameter or mem=
ber 'ref_dtbclk_khz' not described in 'dc_clocks'
drivers/gpu/drm/amd/display/dc/dc.h:548: warning: Function parameter or mem=
ber 'fclk_p_state_change_support' not described in 'dc_clocks'
drivers/gpu/drm/amd/display/dc/dc.h:548: warning: Function parameter or mem=
ber 'pwr_state' not described in 'dc_clocks'
drivers/gpu/drm/amd/display/dc/dc.h:548: warning: Function parameter or mem=
ber 'prev_p_state_change_support' not described in 'dc_clocks'
drivers/gpu/drm/amd/display/dc/dc.h:548: warning: Function parameter or mem=
ber 'fclk_prev_p_state_change_support' not described in 'dc_clocks'
drivers/gpu/drm/amd/display/dc/dc.h:548: warning: Function parameter or mem=
ber 'num_ways' not described in 'dc_clocks'
drivers/gpu/drm/amd/display/dc/dc.h:548: warning: Function parameter or mem=
ber 'fw_based_mclk_switching' not described in 'dc_clocks'
drivers/gpu/drm/amd/display/dc/dc.h:548: warning: Function parameter or mem=
ber 'fw_based_mclk_switching_shut_down' not described in 'dc_clocks'
drivers/gpu/drm/amd/display/dc/dc.h:548: warning: Function parameter or mem=
ber 'prev_num_ways' not described in 'dc_clocks'
drivers/gpu/drm/amd/display/dc/dc.h:548: warning: Function parameter or mem=
ber 'dtm_level' not described in 'dc_clocks'
drivers/gpu/drm/amd/display/dc/dc.h:548: warning: Function parameter or mem=
ber 'max_supported_dppclk_khz' not described in 'dc_clocks'
drivers/gpu/drm/amd/display/dc/dc.h:548: warning: Function parameter or mem=
ber 'max_supported_dispclk_khz' not described in 'dc_clocks'
drivers/gpu/drm/amd/display/dc/dc.h:548: warning: Function parameter or mem=
ber 'bw_dppclk_khz' not described in 'dc_clocks'
drivers/gpu/drm/amd/display/dc/dc.h:548: warning: Function parameter or mem=
ber 'bw_dispclk_khz' not described in 'dc_clocks'

Introduced by commit

  1682bd1a6b5f ("drm/amd/display: Expand kernel doc for DC")

(now also in the drm tree) but revealed by commit

  ef8d147fd442 ("drm/amd/display: fix kernel-doc issues in dc.h")

--=20
Cheers,
Stephen Rothwell

--Sig_/=RzvDKe/gCXtsYIIZ247mm2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmN3LHEACgkQAVBC80lX
0GxKSgf/SRy14QfQcTmaEOgQhaF8l5iE90BYKkrIxOzZO6bZAcLfl1dneHe3IEQb
8oMWaIAovh/mLDzwYfsHoIKO5gqXir67KVVbFieeeZfxNf3dA+/yxH5dyUDbf4sD
NLrJiPkhg96WKJxEpEasZSkXk/OX9Fi6D+HbEmv7f6kS3Wy4gjZK4CsXrstHf9r+
Wctkf8DHXdq/G2CiqM69UX0Pr6AToCbJXeJbxRqkMRMdANtFmKUU3fIya0UTVu88
MHJ7Nxxd5SWiQAMTrZjJAL5ELLfhNLAJeZDpxZDGv/M+Hbv6Fqtk2Cn704Kf6684
JWoTZS1lUKJCVvlAYHmpX8g4l3Ps8A==
=ITuw
-----END PGP SIGNATURE-----

--Sig_/=RzvDKe/gCXtsYIIZ247mm2--
