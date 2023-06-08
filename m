Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00777285CA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 18:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236232AbjFHQuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 12:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237023AbjFHQt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 12:49:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780561FFA;
        Thu,  8 Jun 2023 09:49:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06EDE64F78;
        Thu,  8 Jun 2023 16:49:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 336F9C433D2;
        Thu,  8 Jun 2023 16:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686242990;
        bh=3ekp8A+Jx8UMxm6h0EHMSByRFgboVvf7rSt82JDLZjc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c883ILcA2qpCKMGLCoX0/KSUxb+Y3s8fa/N2Iz0EXZlNjoPrGx6CJI7VrvUU9n05z
         UGhZ4c02+/vEARbd2aLyOfNQZzX82HdlukfNKZFs0zRPMoF6MbmvoLKG7US/lhPOmL
         aceQz/xc+l923q7iYdmTn9IhACBg52PDulL7FekxvLpIA25Z+YFXMwnpdtOdemkAN0
         LzCAzYs4gDMH33+rJV6mdZL+NPhtCxHLribA1hgDTUfuGk9Ql1JkgEwmEJjJ+K2seX
         UVxe3BD0LirD9O78mj2T4h6VKHMYjJxxiRHV0mwtn14DZmrzAXTxwrMHfJaGmUPDjb
         hkY9UeXSLhRZQ==
Date:   Thu, 8 Jun 2023 17:49:45 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        sre@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 3/4] dt-bindings: power: reset: atmel,sama5d2-shdwc:
 convert to yaml
Message-ID: <20230608-tiptop-unfold-66c4b8f4e620@spud>
References: <20230524123528.439082-1-claudiu.beznea@microchip.com>
 <20230524123528.439082-4-claudiu.beznea@microchip.com>
 <20230524-blizzard-hunting-4da815e634e2@spud>
 <20230607204351.GA3984668-robh@kernel.org>
 <20230607-refute-acrobat-3b3f645da71b@spud>
 <CAL_JsqLyLs3Vfsd8LRd5_dUbzjE9LgMNnWa+8uP88Ab+E1oLfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3OP8EDElDDSK71VF"
Content-Disposition: inline
In-Reply-To: <CAL_JsqLyLs3Vfsd8LRd5_dUbzjE9LgMNnWa+8uP88Ab+E1oLfw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3OP8EDElDDSK71VF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 08, 2023 at 08:38:10AM -0600, Rob Herring wrote:

> For reference, anything done by Arm, Linaro or NVIDIA employees is
> okay to relicense to dual license.

Ah cool, that's good to know, thanks.
Perhaps I should try to get a similar edict issued for Microchip ones.
@Nicolas, does that sound reasonable?

Cheers,
Conor.

--3OP8EDElDDSK71VF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIIGqQAKCRB4tDGHoIJi
0pR8AP9d4cw6E/ufo8t618IGZahirOpz4CHysPhwG5LPV9YlqgD9Fb+VtXbxG+YU
VTaH0RxhkUyE9w4emQ+vy5uI4J+1wgs=
=MS3R
-----END PGP SIGNATURE-----

--3OP8EDElDDSK71VF--
