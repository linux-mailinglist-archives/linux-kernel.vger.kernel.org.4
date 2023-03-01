Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2A226A6ED0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 15:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjCAOvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 09:51:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjCAOvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 09:51:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBE23A842
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 06:51:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8FF07B81037
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 14:51:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 064CAC433EF;
        Wed,  1 Mar 2023 14:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677682261;
        bh=IYd+nYCTRLvbFTZKCn2y5PCfeYsbSaKs9D2MoyFSPnE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=awlhdL2wENB7lV7Oq8UH2z+gupeZT7oGPCo9lpSfYn01vYs20KfqsR4CbBik/lEzg
         vTuflDZ+CmM5y0IIYeCYm8p8md1buIOVP29hCOJU6ke3HvFe+RLfG+DJqL4P19+GQv
         kKVyBvEE11VsrwlogLEQXLGJxmH6JXvf62NZB/wA2Z5TaRRRJx9Z9gbuhxfGdw80Rd
         7dn7nYIsaQAMoGDGZQVeuUm4kQqOkbOK1LqZ5b6zFFriI/L3gtGlzQoyQ3dc+i3pcj
         zLgkpQpQmzVtgP3hAQEBZAQySBhfktzJQhVTu0Gh2lKWs914QIo3zQNMx/LWYNA5U9
         orPAdlwjp+8sQ==
Date:   Wed, 1 Mar 2023 14:50:55 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Lucas Tanure <lucas.tanure@collabora.com>
Cc:     David Rhodes <david.rhodes@cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        "Takashi Iwai --cc=alsa-devel @ alsa-project . org" <tiwai@suse.com>,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v3] ASoC: cs35l41: Steam Deck Shared boost properties
 quirk
Message-ID: <Y/9mT2ZVzf/5o4QV@sirena.org.uk>
References: <20230301124447.17672-1-lucas.tanure@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8Gla6hySb4xhSKuC"
Content-Disposition: inline
In-Reply-To: <20230301124447.17672-1-lucas.tanure@collabora.com>
X-Cookie: Dr. Jekyll had something to Hyde.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8Gla6hySb4xhSKuC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 01, 2023 at 12:44:47PM +0000, Lucas Tanure wrote:
> Add support for Steam Deck bios old properties. If a Steam deck didn't
> upgrade the BIOS, the driver should be able to handle the previous
> properties for shared boost types.

This doesn't build:

/build/stage/linux/sound/soc/codecs/cs35l41.c: In function =E2=80=98cs35l41=
_handle_pdata=E2=80=99:
/build/stage/linux/sound/soc/codecs/cs35l41.c:1041:36: error: =E2=80=98CS35=
L41_SHD_BOOST_ACTV=E2=80=99 undeclared (first use in this function); did yo=
u mean =E2=80=98CS35L41_EXT_BOOST=E2=80=99?
 1041 |                 hw_cfg->bst_type =3D CS35L41_SHD_BOOST_ACTV;
      |                                    ^~~~~~~~~~~~~~~~~~~~~~
      |                                    CS35L41_EXT_BOOST
/build/stage/linux/sound/soc/codecs/cs35l41.c:1041:36: note: each undeclare=
d identifier is reported only once for each function it appears in
/build/stage/linux/sound/soc/codecs/cs35l41.c:1043:36: error: =E2=80=98CS35=
L41_SHD_BOOST_PASS=E2=80=99 undeclared (first use in this function); did yo=
u mean =E2=80=98CS35L41_EXT_BOOST=E2=80=99?
 1043 |                 hw_cfg->bst_type =3D CS35L41_SHD_BOOST_PASS;
      |                                    ^~~~~~~~~~~~~~~~~~~~~~
      |                                    CS35L41_EXT_BOOST


--8Gla6hySb4xhSKuC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmP/Zk4ACgkQJNaLcl1U
h9AS3gf/dFCy7mGxEZ4YMb0SnBBAy/ph/RMHSIZG3QWBIDSufaw3d779cwZ/lRdJ
ZKrWVfg2tdCiq00nIT3p7U8sv1Y1BkdZCS86kleKSx81enGThIodHPVwf46y5YAx
9F2XeoHJLvR8Ku+RPUDsPHAQqsiVzoD/rgSVDI+NnJujb68s+h5CT+u25v1Ccnmk
mO+gMstPIjv2AOkhL4YlrQn/D3GgmlVOdjw8eskyMM+6L9Z1ZYAQA9wCIHW80T8e
kcTfQ9/65CnleuBxUXTzDWH9dpOjshE0rXN3vvyfQfu95ZC/gFzSeSBpfrhPDxqi
2Vp6CN8sTSDX2KjhznCH9jAth4HWkw==
=1Jor
-----END PGP SIGNATURE-----

--8Gla6hySb4xhSKuC--
