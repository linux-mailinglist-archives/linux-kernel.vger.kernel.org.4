Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC5D6DD965
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 13:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjDKLbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 07:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjDKLbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 07:31:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073272680
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 04:31:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99C3861EBD
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 11:31:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C9F6C433D2;
        Tue, 11 Apr 2023 11:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681212692;
        bh=TBpSFkNKJhrGaLD8k2bgCR9kqm83Y4dz0tYFH8ahTUQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zj1at8z0aVSVg1kFrz1ka5HxjxRZHnab7ClIEOVZeH+mGEIHSQYTtbMwSGyhHOMQf
         jfTatbRAZW+kA8Fq5QleZY9fCSs65LCsSldxFaXCzCeWMoRSke8/+zqTOHutkVdNcq
         4rOd6zlgnC08Z5DT9mCjqitB8AgkplLJ0MqFViQ86US95VUbkO9999hgBEZQCxBqnf
         kgUJQMmCN8Ndd3Z9iBl+aFubAFuPw8QR+Hv50lhtBwc/Q7wymuD1Y9FuQkLVR1xHdn
         Z9tF9xrwtUSDkoBAR3oG4+DuVIG4O+1ASz792bD42nc4G+oYfDH9cJ7V5bsl0o+r9p
         dBe2gdIkri6oQ==
Date:   Tue, 11 Apr 2023 12:31:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Shenghao Ding <13916275206@139.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz,
        pierre-louis.bossart@linux.intel.com, kevin-lu@ti.com,
        shenghao-ding@ti.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, x1077012@ti.com, peeyush@ti.com,
        navada@ti.com
Subject: Re: [PATCH v12] ASoC: tas2781: Add tas2781 driver
Message-ID: <d52e07bc-9a94-47f9-a24f-84b0b741a6dd@sirena.org.uk>
References: <20230409214304.23710-1-13916275206@139.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="B8sPpC8G1y9JJPew"
Content-Disposition: inline
In-Reply-To: <20230409214304.23710-1-13916275206@139.com>
X-Cookie: In the war of wits, he's unarmed.
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--B8sPpC8G1y9JJPew
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 10, 2023 at 05:43:04AM +0800, Shenghao Ding wrote:
> Create tas2781 driver.
>=20
> Signed-off-by: Shenghao Ding <13916275206@139.com>

As previously mentioned you need to send DT binding documentation along
with any change that adds new bindings.

--B8sPpC8G1y9JJPew
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQ1RQ0ACgkQJNaLcl1U
h9CpvAf/ay+LCnG2kWeY8mUSuolFKPEr2IbQz4l/KcRCPt6RzBCyB/71aDSS3oqR
Ww3etDD9Q4OZenlaoq+bnF8fSNZT+DVmZMSX3ML9DGV6X6jYxsTmG0RnK44PPmr3
dLVWstldZlkmtDgxnGsrYAzY0OdlZUxgUmcjzPD7PoMy1MVgCdZQQik2yhcgaYRg
jeizXVfQZBrgvUyHl2uU4HNtuoNlp1i8hwTw/n4nlAuLPZPx6dm5nAG85TR1KaRD
zW8Mp/ZRXuhS2Bl8RS+PlSTZk6GNAChCoLcmpSyAnnReEv2vpg4lA/x14AAvHDxw
cyHn2TivvheTlezWWXGzzidsWysw5g==
=q+hC
-----END PGP SIGNATURE-----

--B8sPpC8G1y9JJPew--
