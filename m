Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1CB76B8420
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 22:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjCMVmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 17:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjCMVmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 17:42:21 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDF88ABF4;
        Mon, 13 Mar 2023 14:42:17 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Pb99L6T25z4whr;
        Tue, 14 Mar 2023 08:42:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1678743735;
        bh=17d+EcKlY/En8UZdp52sksh6GRy/ocvPXgStvvw3rJ0=;
        h=Date:From:To:Cc:Subject:From;
        b=jixGxLlLUz3SLOEsHfBLB1bAZ3vS4cSSIgN0l0WC95kCg425TPzkTp5TGa9dRKMcj
         VvnoXxSpOuU/KPkZPGMe8P9Kek9Tx9chvK9VFzGJbkBr6+zmAvA4AqnFR+rFywICWo
         ZvU8fdDf1mejt34n63C2P9o5f/w++cVNW0yn/5UGIzFhvrdSOFm1z5IqfjYF3Cb0TN
         kCXmu7EYk4PbBg5b2wd/maXYJpp/AZx4h1bwBTcgonvUWRQjRa2eQeGQxz5fDTPwOm
         2BBa15wF60MtlGWf9zng43A0tkafI2hGjesw5Cv2M/tKXM133qfwdVzr03vvfbFAVP
         4+PLsgJRZ/Zfw==
Date:   Tue, 14 Mar 2023 08:42:14 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linux Crypto List <linux-crypto@vger.kernel.org>,
        Uwe =?UTF-8?B?S2xl?= =?UTF-8?B?aW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the crypto tree
Message-ID: <20230314084214.113e74dc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/yuUr.7MdmN_.eaT8M0Qqkc/";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/yuUr.7MdmN_.eaT8M0Qqkc/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  b4fb7f4afa5d ("hwrng: xgene - Improve error reporting for problems during=
 .remove()")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/yuUr.7MdmN_.eaT8M0Qqkc/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQPmLYACgkQAVBC80lX
0GzlxAgAhKeWO6dELwmRH1XAyqaQzS35NS4CYTtJz5Hqt+nY0Qi/hbj+80mic5T/
dtlhpw1A24/XK3jV+2LZRnswaBzsNqcbfP/dHG2wmZ9F/bEDWKqq8K3yuZVMuz7Z
tLbJQcT+UuI2luwrhyVHGooECvhAr7WoLeh1v1q0wxVFe/2+ttsz+vX5hqJqakmz
4uMwZ4WhLKAdA84gHYYVxkgBYE2/KzzuSR9ltb1mGJKxVne2NgQLBa3z4pguTcjK
TVUQK8+TLrMdV2Mynh34xO+HzikpJTN3l0YkDgAHQr+8vJlfe1+4mSD7JSRjdswK
O98W1W6C1nDXXkuBPLoBuSrDO6D37w==
=Yf9r
-----END PGP SIGNATURE-----

--Sig_/yuUr.7MdmN_.eaT8M0Qqkc/--
