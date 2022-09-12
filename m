Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06315B5294
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 03:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiILBqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 21:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiILBq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 21:46:26 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98C2252A3;
        Sun, 11 Sep 2022 18:46:24 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MQqFQ13vpz4xQs;
        Mon, 12 Sep 2022 11:46:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1662947179;
        bh=JUzNdbpckONCPuzlpTFdYGw3om0b8qs7vClxseI5AVo=;
        h=Date:From:To:Cc:Subject:From;
        b=ck2q9FiMxiOBXWQFWBSt93y5QHJ6RBgVGLmnzZZxT1/hz+RPN3IA0LOOyA1Jao9Pr
         mxNYfAFmqWX9xHwE5BwBMaM6Ua18no84r2gzH8HiDJKqaE/mQceNEyCTGS0Pg2S5yw
         CmsznClDbHXym7wTV8PUEVUTK9HruVAjAdwMrn3rZAzN3h2MYNbtv0tVseguVA7Wbm
         DgimpTj65kNVXydg/X1dOzdRUic9yv2LgipTKV050X8BFv2olJxLKUtmf6UjVohOHq
         A/i61nncbvwyps6TwywUx/Plh7eZtaO5zMvk638MyxlpVIQ462QIdiMsXmZwDeUVjv
         U63vob3T1uB7A==
Date:   Mon, 12 Sep 2022 11:46:16 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Dave Airlie <airlied@redhat.com>
Cc:     Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Ville =?UTF-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Subject: linux-next: manual merge of the drm-intel tree with the drm tree
Message-ID: <20220912114616.5f686243@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/hVOi3.2gqwmVBO2k/pK7a+T";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/hVOi3.2gqwmVBO2k/pK7a+T
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm-intel tree got a conflict in:

  drivers/gpu/drm/i915/intel_pm.c

between commit:

  254e5e8829a9 ("drm: Remove unnecessary include statements of drm_plane_he=
lper.h")

from the drm tree and commit:

  42a0d256496f ("drm/i915: Extract skl_watermark.c")

from the drm-intel tree.

I fixed it up (they both removed the same include) and can carry the fix
as necessary. This is now fixed as far as linux-next is concerned, but
any non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/hVOi3.2gqwmVBO2k/pK7a+T
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMej2gACgkQAVBC80lX
0GwrQggAmnmujkHXbD/S5DiS5MZe4j48iwDviIOAZtN+L/JmyMRkC2B/TAQ8UHnJ
bsvsJm+G+b1k2UDssP4ZScBqdvRTfEmKDW6EVIJa3OhulvDi6Usw+mpJVLiJbirq
O4q3/vfDyY95k8y/99K60ERH4YYEFHz4bBkdUC6XvEp9OuPNoJFANQOyZfcvaM12
Fo5OwR0sC8492F34rW6qOIDLsBAqIfFIbgq8wB9WErTZUYS4NxC4D5hdSnuYnLfn
fceRlJpjuyLAz1q7NWuBcbrd+JVBl66T5b4B5sGUjm4GcEgFK6xcYcPl3aqrcqoP
5HKIrrHwlD73tXhZNnvKP/I4XJbFjw==
=2h2g
-----END PGP SIGNATURE-----

--Sig_/hVOi3.2gqwmVBO2k/pK7a+T--
