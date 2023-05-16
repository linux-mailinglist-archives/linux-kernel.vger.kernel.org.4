Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADDB7054FB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 19:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjEPR16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 13:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjEPR14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 13:27:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFACFC;
        Tue, 16 May 2023 10:27:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B945963CF0;
        Tue, 16 May 2023 17:27:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7792C433EF;
        Tue, 16 May 2023 17:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684258075;
        bh=DfKxgGY4iCyh00gadtHR9ZZJib1hLgMeWEqpNAnGF14=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HcThpdKavmaa7uVl/qxgnjFu9KleSv7V21ssdL1ceXUdgkGh3Z5b1h5eBXFjMafvt
         q7bfmwlErmY1062WfG46SR8cWfpAdpdS15yLHUJomu3oB8EehgfoDnnla6CKKZbSIT
         O8VMfhXPxwX+ONwFWD5smWWWLf1doQXFWYlRZcrIz3y4EWdrh1KxncrijW5z8OGYnC
         hqIfSC8AI9IrJNKRoC53nCY7Ll6y2jit+qaPdLp5Rb7aQZrP3oGImzBnaSKjAeXH0c
         zRl5mfUKslElaEolxefVszmONzMaF73jryHHjG/P0hIM5ekMPYPXOaFuWjUQUABgiV
         H4KtHLaQjvZlg==
Date:   Tue, 16 May 2023 18:27:50 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Richard Leitner <richard.leitner@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marek Vasut <marex@denx.de>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mike.looijmans@topic.nl
Subject: Re: [PATCH v2] dt-bindings: usb: usb251xb: correct swap-dx-lanes
 type to uint32
Message-ID: <20230516-smasher-aerospace-1096bd7096fd@spud>
References: <20230516083432.18579-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="AQJn1tvMQYsj72xo"
Content-Disposition: inline
In-Reply-To: <20230516083432.18579-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AQJn1tvMQYsj72xo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 16, 2023 at 10:34:32AM +0200, Krzysztof Kozlowski wrote:
> The "swap-dx-lanes" was never described as uint8 in original TXT
> bindings and Linux driver expects uint32.  Fix the type to match Linux
> driver expectation.
>=20
> Fixes: fff61d4ccf3d ("dt-bindings: usb: usb251xb: Convert to YAML schema")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--AQJn1tvMQYsj72xo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGO9FgAKCRB4tDGHoIJi
0tSCAPsE3OtjPbw73sXHdoDXLdIwlg9hNuSSjUShyz184zzqYwEArIX2ECJn++0Y
nVf3gxQDwC2jRwqBNWQn4cw6HqwogQw=
=6u02
-----END PGP SIGNATURE-----

--AQJn1tvMQYsj72xo--
