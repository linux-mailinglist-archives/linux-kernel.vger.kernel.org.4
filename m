Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38920708851
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 21:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjERTZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 15:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjERTZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 15:25:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC0D18F;
        Thu, 18 May 2023 12:25:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32B3A65108;
        Thu, 18 May 2023 19:25:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54358C433EF;
        Thu, 18 May 2023 19:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684437939;
        bh=Ey4oQzzAq2Xv5tRbfaLF7gcD0GoLd9dwY7x3rOsNRb8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hDCIEXIZSoz5QLJ9k7vqS3S3OSGN1ywQNRO66la1MxXr+zcWvWNXSWQ38pP9evaZo
         93Fqt2mgHotEMBmYG2Uc5uxiot6mBFiVSzAyrrEp264qZwAuzZF4LZG8c6k19E6LPs
         /gOHGzI75do6BeXh5QKYKhkdZmqAreDydYJ81acpGbinrWMgtQ2ki0IUiu0wEj51GC
         2ARXgBf1EXYMAoCD3m0kqyOPpXPCGDNXznOw1qFanlaGwBl1yO4t0VXS01r8qDNamf
         Vxc/PteKS1ERzZ01HKLuI8fZ0SwaNQ3+0weOWJv3UUJ1s4vAVq3Nxw7uMASaIMrQip
         XQWoZzffUmnxg==
Date:   Thu, 18 May 2023 20:25:34 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Paulo Pavacic <pavacic.p@gmail.com>
Cc:     Jagan Teki <jagan@amarulasolutions.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        neil.armstrong@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, sam@ravnborg.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH v2] dt-bindings: display: panel: add
 panel-mipi-dsi-bringup
Message-ID: <20230518-viewpoint-haven-d2e4c3b5f305@spud>
References: <CAO9szn18KsR0c+U8EEY1=xnmsKMxy6SEArMUic0z=aYJDVwWCQ@mail.gmail.com>
 <023f6cf9-0f08-f27e-d203-5ff78faf110f@linaro.org>
 <CAO9szn1EsbuPSRrOW8CLqhp+QUcL=9NE93FAwsg2n3htd_aJTw@mail.gmail.com>
 <CAMty3ZCAP6CRsJWMUZZ6+hd5igX3NgyNfhdEv2FwuDtqj4iaaA@mail.gmail.com>
 <HB0TUR.1IPEEV2C5LMB1@gmail.com>
 <CAMty3ZCSUx-81m4SQcJZvUq3NyhzZbe8ow+LiV7iyUmVLCmNYQ@mail.gmail.com>
 <CAO9szn2A22KTzrCTX+24Y3goSberHpcGf-O-Czv3+_dX+pL+vQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="A8Lg/r5jOWbk2+NT"
Content-Disposition: inline
In-Reply-To: <CAO9szn2A22KTzrCTX+24Y3goSberHpcGf-O-Czv3+_dX+pL+vQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--A8Lg/r5jOWbk2+NT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 18, 2023 at 04:47:08PM +0200, Paulo Pavacic wrote:
> > So, the driver has to be panel-fannal-c3004.c and binding to be fannal,=
c3004.yaml.
>=20
> I believe I have covered this and all the other problems in following
> patch which I will submit as a V3 of the conversation in a patchset
> together with a driver:

Please do, that'd be great.

--A8Lg/r5jOWbk2+NT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGZ7rgAKCRB4tDGHoIJi
0nOIAQCTsXNhUb/HN3g3I+6LQLZaEACF0NvppF3NLbwC/Q4KqwD/Sh27dTJJsm6S
uLadNbb0zc52FvN+PQmmFhSH4eFhRgw=
=kXGS
-----END PGP SIGNATURE-----

--A8Lg/r5jOWbk2+NT--
