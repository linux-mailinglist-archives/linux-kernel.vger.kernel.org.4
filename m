Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB7173239D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 01:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbjFOX2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 19:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbjFOX2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 19:28:15 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF14A359F;
        Thu, 15 Jun 2023 16:27:54 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qhz3q4Pj2z4wjG;
        Fri, 16 Jun 2023 09:27:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1686871673;
        bh=MG6iU+m/dTJRRmntf6pbcRuvIpqIn5ipHqp1iCVi2tM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qGjAnQtyEhKdht9o9QqMd5PvcmiN2+xxwLJVrNjNjl8ET9VImh1uGKKshvEJlMnjC
         k6KL2kok4HxFmtGjHlEbdeVgrcp+8T7sCyTSfMFz2Q4ZaRSwJCunSeQDkxJZRIcsF1
         PwvIBcmsPr7hv28XSymB//UnBraRkOzD1jwax0mS536taUlL6rGkw9Y3VOyALQDYdn
         emoASw5pR/sdpxQ8Nsf08IO/3FImJu5MmNy5ZEo7g3FnG7+9EKYTocvtiCcsLihqQ7
         xDSIK2yE/9Ekxn1bBbOJ8EDLqPplnDdGQW0SUoLvRhb3bz7i5KOrGXgFHRfRRvUg3V
         lHXb/YarGUXLg==
Date:   Fri, 16 Jun 2023 09:27:50 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Von Dentz, Luiz" <luiz.von.dentz@intel.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Linux Next Mailing List" <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the bluetooth tree
Message-ID: <20230616092750.3d00fd7a@canb.auug.org.au>
In-Reply-To: <PH0PR11MB5126F2B2E020774AF8D91299D35BA@PH0PR11MB5126.namprd11.prod.outlook.com>
References: <PH0PR11MB5126F2B2E020774AF8D91299D35BA@PH0PR11MB5126.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/kr.oGh/At6HymqKuhS0Gj90";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/kr.oGh/At6HymqKuhS0Gj90
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

On Thu, 15 Jun 2023 23:06:59 +0000 "Von Dentz, Luiz" <luiz.von.dentz@intel.=
com> wrote:
>
> Im on bussiness trip this week thus the delay, will be back next week
> so I hope this can wait until then.

No worries, just checking that it wasn't forgotten.

--=20
Cheers,
Stephen Rothwell

--Sig_/kr.oGh/At6HymqKuhS0Gj90
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSLnnYACgkQAVBC80lX
0GzUlgf/WNwtoth7cjdbOhbEzGBCAajHiAVRuIqjCShz+zc31sei87DTo+iRV99R
5aESBRSEIwClft38OjiWWDO+7SE3+WGh3Qf6lJEwhBgl1LbVLPEojSEmRFJosl+P
rBVc0nCTLKPyeTINRcvLMwKx7hLJ1tAWsYBmEnh4SxpcY4AiXWmhmbkcIvmOUI75
Gvv3FzKg1VFOnfmuTvm6xsDMPA6zT1A8kvirkZyUATUZby/TqIa8wW6kkFksjB3v
xlpoS0oEPEzeWSt0fXJYxpvKNU73yaao0kLGB11RMhu101tztmVShYY2Onv28ZE/
Q/i4SF0cXg/chz6fPsALM7cSJzlNrg==
=0xQt
-----END PGP SIGNATURE-----

--Sig_/kr.oGh/At6HymqKuhS0Gj90--
