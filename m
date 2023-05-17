Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF27706F7A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 19:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjEQRaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 13:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjEQRaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 13:30:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD82E13E;
        Wed, 17 May 2023 10:30:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41A7961B72;
        Wed, 17 May 2023 17:30:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60644C433EF;
        Wed, 17 May 2023 17:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684344606;
        bh=IvTb+46oPYwMB9EGNhmugY6I0xjp6TxZeov/IeB0P8k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E7Y/VqVfTJBCJa5GLyXgkRD+QqoZ66eahzP2VUe/emQ3Lb7gyz84ytXDPCrb6VBNa
         Eu2KUgIh8bBw58hZ3h3BhwvZXrKFTRbsqHJxraDSQQBkiPFOKaWfgP0RMOhX05xgsX
         tXXWg0LNs+gp/Fru6UyvvkqdB9UTie144m8wJtX8OLj+nAjzsQPXi8EnQKx/PAOzk3
         ct1OJlKAGJeqhR0vUhkRhsvFPmhwWX9jnfBwOIrQng8dhslRbZRj8LndQA39bGwOYI
         l85uzKx10jCNh6VaEbxG+6S/J34yzgZf2VvJ5Zkp/kcuV/tbnkwzt2nOts3J/DjPfu
         zZJr2CdsL7JPw==
Date:   Wed, 17 May 2023 18:30:00 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Marek Vasut <marex@denx.de>,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        Yannick Fertre <yannick.fertre@foss.st.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@dh-electronics.com
Subject: Re: [PATCH v3 2/3] dt-bindings: display: st,stm32-dsi: Remove
 unnecessary fields
Message-ID: <20230517-bless-sterile-e35305fa70e3@spud>
References: <20230517143542.284029-1-raphael.gallais-pou@foss.st.com>
 <20230517143542.284029-3-raphael.gallais-pou@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eoRL2ml0lZ9nxAWN"
Content-Disposition: inline
In-Reply-To: <20230517143542.284029-3-raphael.gallais-pou@foss.st.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eoRL2ml0lZ9nxAWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 17, 2023 at 04:35:41PM +0200, Raphael Gallais-Pou wrote:
> "#address-cells" and "#size-cells" are two properties that are not
> mandatory. For instance, the DSI could refer to a bridge outside the scope
> of the node rather than include a 'panel@0' subnode. By doing so, address
> and size fields become then unnecessary, creating a warning at build time.
>=20
> Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--eoRL2ml0lZ9nxAWN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGUPGAAKCRB4tDGHoIJi
0sYPAP0bagnXi45xl7G332sbgQz2hLgro/DfudjfE3m/BtEHgAD5AYkXh6KYQ2IP
x0e+PKodvtu48I3DV8dvY4c1iQa69QQ=
=wkP+
-----END PGP SIGNATURE-----

--eoRL2ml0lZ9nxAWN--
