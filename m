Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75D1651BC7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 08:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbiLTHhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 02:37:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233591AbiLTHhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 02:37:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99624DEC9;
        Mon, 19 Dec 2022 23:37:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3FADF61280;
        Tue, 20 Dec 2022 07:37:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2691C433EF;
        Tue, 20 Dec 2022 07:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671521826;
        bh=66SlnYG/nwUzCZrhRPG1TjPvZM9jtU1rQo7zEHGPSqU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=vJB4jk/y5LQIaiEIhTFeBKn0rmFWU1H/8Vzf0VJLLZspPVyyheAqH7K3M9YGN6wgX
         UxMCDyPdyAWw/z2IKWHGy4uJwYQEmV/txn3N8VAw29BBAavaTQ/MJmmO8HxKKz9oQq
         ebsD/pIY0KHJHnocDD+LZnWleYHvr2G9Q6f69MxEiVFzixTTgwrFwJ3t8tZwxG560n
         mtTkiMpkNBDjNusK3sJqN5gLT2S85Au+/5errsNy+6xPf1nJBONFCfQhOaECaAts87
         zsmQ5L2zsoWepxt7mpIIdmvmXrhHtXUK4RLGzrFxVNMJ2d8OKTVo+DGy6ImTfE/joh
         aXj4zPS8Tjtig==
From:   Felipe Balbi <balbi@kernel.org>
To:     Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     linux-rockchip@lists.infradead.org,
        Johan Jonker <jbx6244@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: usb: rockchip,dwc3: Move RK3399 to its
 own schema
In-Reply-To: <20221219191038.1973807-2-robh@kernel.org>
References: <20221219191038.1973807-1-robh@kernel.org>
 <20221219191038.1973807-2-robh@kernel.org>
Date:   Tue, 20 Dec 2022 09:37:00 +0200
Message-ID: <87bknya5lv.fsf@balbi.sh>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Rob Herring <robh@kernel.org> writes:

> The rockchip,dwc3.yaml schema defines a single DWC3 node, but the RK3399
> uses the discouraged parent wrapper node and child 'generic' DWC3 node.

Why discouraged? Splitting those two separate devices (yes, they are
separate physical modules) has greatly simplified e.g. power management
and encapsulation of the core module.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEEg3wK/NVnD14JZqsmho6y4DXKpEQFAmOhZhwRHGJhbGJpQGtl
cm5lbC5vcmcACgkQho6y4DXKpEQmdQ/9HUBWlOG25MYVfiwdxaImz5mgCa6Tkae3
5Jsmxxfrv702yoTBc/Pfh32g6Vfbn5u0zO0D956HzXZub+q4ZXKNzJMRz6Hkgq5Q
8L3ta+RfPmSGc3pd9cB0zY77xeI4NAWQXeIbt1wz3uik9+RqHONmz2oTU47vIgHS
U6yNIecEBDIPBIxJ8jgi1kadmPeyBZAEzHjwqzMsJjDM3aYUXY3pMn+tL4N3noxD
xtCLfnCKSStZfkf1I+J9IG25apct/gdJmVXh8nkL4jxnLJKvobCXBszM/AI4uBo9
ROgE8mzawpuR8cBzh0FQMhSwcEHFkPoOA30GgJXwgnvrsSXgNSFAWQTdY4T38201
gKaWXK3dIeQBU32K1Zxlm7/vcLZn2mR6HfkmgRG0Y6ZlVeLvZIj2UVkcQHrMVAGx
GEjhev3Yn3TBU+237RRAYR6+uYKcFFgtmhc7YU1u6uQWJUVniztdpEe/Yvocz6xK
CVU8EYO1y4U1jo326JCRnGMwHDKH9JUyt0so+mDmuVGltkMCb+4R26VAXGC3iNl+
rs2pUYlXUn178Zs8rbBEBQUg/OoToFaT7R3h5zvdDiMr7ux+AhJALy2b+El63q1N
724mM2/9cm84opCok1LxBLaxeLxUGdCREL7A3uJrhiqK9rC6za8emL86KNPuh6na
ttm1GYfsohg=
=LkjN
-----END PGP SIGNATURE-----
--=-=-=--
