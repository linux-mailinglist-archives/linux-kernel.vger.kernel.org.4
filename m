Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3226568FA77
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 23:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbjBHWy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 17:54:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbjBHWyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 17:54:23 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9D729E29;
        Wed,  8 Feb 2023 14:54:11 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PBwKY4zFXz4xyp;
        Thu,  9 Feb 2023 09:54:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1675896849;
        bh=qJeZfYZsZ95CdMmRTTcGcPpOnIE8j3xS/nlqggZjCVE=;
        h=Date:From:To:Cc:Subject:From;
        b=CSKora93YE9Vk1WuxmNXiwR6GTvcUXFXCJkj4hilbQIismvke1Jbz4x7lq2uMAbf5
         WFNHYQQR9wTFvDer7Qxptn6YCC6wvn9jnF0d4ygPWpb/8SPUIHvDbk6ps0YlmsyAgI
         pKvaCeHuKsJF8o3O6ZLwIAJtkUqbFtjfz8hIJzoGK2jIDRlREOKuguJlSz8/sMOtkC
         hV4UE94XdsSNwBLlnC6gh0rtoVg+srPWWOrgPK0e1KHvgvWQtsF1fXS+nX1q7h/uQX
         x6HErLrmUF/TgW5fC2J4S0J8xnjDIjvwElmHttDd1gDnyr3tBqBb5uHErDPoZPMwNx
         zRxe2vzWJ6oJw==
Date:   Thu, 9 Feb 2023 09:54:08 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the amdgpu tree
Message-ID: <20230209095408.59e2469e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/DV.10do=caCRq8i92cpRBw2";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/DV.10do=caCRq8i92cpRBw2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  b2d7ff0d8741 ("drm/amd/pm/smu7: move variables to where they are used")

Fixes tag

  Fixes: 711d3c39503b ("drm/amd/pm: fulfill powerplay peak profiling mode s=
hader/memory clock settings")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: b1a9557a7d00 ("drm/amd/pm: fulfill powerplay peak profiling mode sha=
der/memory clock settings")

--=20
Cheers,
Stephen Rothwell

--Sig_/DV.10do=caCRq8i92cpRBw2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPkKBEACgkQAVBC80lX
0Gyg1wf+P9Vgjffsk0qVyGJOTpJW3eq8twmhlZt5PnC3T9ga4w3YOrNrKjjsbQG0
M9MstJwRhYbVz7zV1E3kwCQ/ZXpKG/x1wY8/pJZrF47y+5YQB80v9d6ANjNYQeMx
JCmFs9WlgAmjsYnknsJBLc8+AFAvUsPkUaf8iuG/X9MlJbEYdWZ+mUO1NSmzXSDq
qzWdIW15jFjmygmK8xy8vdYZoP5XhwqVZhB8ieFQezl3CIFj7bTkAiZlUNcLXkEr
FdTMu5guA/847LF+wA/NMucL6qCd9BZqGzMJGuK9aUdq176uxA1TzYwKDN5uvTNK
2Wy874/z8M75ygHeLOf+ZIy/8CahOg==
=L0ud
-----END PGP SIGNATURE-----

--Sig_/DV.10do=caCRq8i92cpRBw2--
