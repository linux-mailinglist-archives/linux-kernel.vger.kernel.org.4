Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3411C61764F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 06:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbiKCFpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 01:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKCFpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 01:45:17 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A67B13F54;
        Wed,  2 Nov 2022 22:45:16 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4N2t563hyvz4xG6;
        Thu,  3 Nov 2022 16:45:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1667454314;
        bh=odUBhmY5EdWW5u5PgK2wpAh5CNrc3eSrrWaOMinBiek=;
        h=Date:From:To:Cc:Subject:From;
        b=e5UmbPjoFUTfQEnNnNjz+Z6LIpG6SSEBNdgsthFr9UbSNmrM+IHQ21m7vFRzzBkJn
         B1gXwMmoHh4j2Gh1vabRzOaRiqpPTF7plP44hphE3kU9i4IgkMT/LEstV4IQctvoOS
         kcMEVgtsRIhxf1WjHLQ6Y1bcPEmaOAjtEUgot/fQ/lOSlEcGkD/o68r1pDjaIu0/VX
         SkntbsfQACGkpnctdGdDJWFB7MoyPkmm6zuq+aNAeEfV7nb8FW7Z20nTNcNPpEEQRD
         CBt16lUtf76BJkE7WN9uyP91Lx8lqhLWjYn5MOf0G6tdwNqq6Y+MrgQ+8ts3cxKhRY
         dKhSlE8kIjPlQ==
Date:   Thu, 3 Nov 2022 16:45:13 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the drm-msm-lumag tree
Message-ID: <20221103164513.1042ac8d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/TV9+jsoUrH4AYLMNqfE.9dd";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/TV9+jsoUrH4AYLMNqfE.9dd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  28cdee47f519 ("drm/msm/dsi: drop modeset sanity checks")

Fixes tag

  Fixes: 3f0689e66352 ("drm/msm/dsi: check msm_dsi and dsi pointers before

has these problem(s):

  - Subject has leading but no trailing parentheses
  - Subject has leading but no trailing quoteso

Please do not truncate or fold Fixes: tag lines.

--=20
Cheers,
Stephen Rothwell

--Sig_/TV9+jsoUrH4AYLMNqfE.9dd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNjVWkACgkQAVBC80lX
0GwGJAf/bk/6bA69je74QGLz20G7LeYw7n+5JC5N2kv6tcxdwmJ86GILE9YDo6b3
5XITzeRcEQbj6NJwO8YonQTW/MYONEEeNQgzqYr2AZqYD+0GrMM3vmCmYuBjD+VL
fSKdE19wOg9HUA7DJPeGumLDwTHOUqs3REN2sZYeh+x/HE1rzuoJiWAZi+OIovXI
ImzdCxNH0uweKU+UMzFexthq6uGoL0i0VMDkkkAOYvxcgmFt7moVQhWCYLLIIE5e
leC0j6AMomOSgzMtQZQH0XZP4MpVZrqZj0HVlU1/hZelvUBV35SQeKlJ6DFoPeCG
GnYgEMSPWZcC7eF8RMnBH/YeDM2Y/w==
=8Wrh
-----END PGP SIGNATURE-----

--Sig_/TV9+jsoUrH4AYLMNqfE.9dd--
