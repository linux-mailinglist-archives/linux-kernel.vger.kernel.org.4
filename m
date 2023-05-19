Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC133709F20
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 20:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjESSel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 14:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjESSei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 14:34:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073DF1A6;
        Fri, 19 May 2023 11:34:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85FE165A5E;
        Fri, 19 May 2023 18:34:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24FF6C433D2;
        Fri, 19 May 2023 18:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684521276;
        bh=eeko69CoO8ZrCLhtBQPdoKb6TrEQeWu0O7r9Z4y9WyI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JlJEz5/fnfTeVT2F9T0JGJYwTG5ZOKk0uPVzkWYsehaV7usdCNAIu2Z2/r8v8s+rH
         u8HYQSvGExfEQDNk26ID9aVGrlaAEU+ax0gjbdULERwkzpYY/wHz1XhhM73074LkRb
         PGQGQGL+QXufYkxcwom4NzC4/OQwDL/kJOnVUpxF0fEtwneheu4roB5C++12c44qH2
         Z2VVcTnO2ni7jAtcXuWBWBnZmzbsONKr9ikIFEBbBBE9LWrK2v9Nqpsh1OnclfukSM
         pZwD3NCNzvarD3kereEo8SlKMybREFlwaFMkz8oLho7oYT3ot5sNTva9jwZfuXUhKQ
         u4b1Onax2BMdQ==
Date:   Fri, 19 May 2023 19:34:31 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Artur Weber <aweber.kernel@gmail.com>
Cc:     thierry.reding@gmail.com, Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v5 1/3] dt-bindings: display: panel: Add Samsung S6D7AA0
 LCD panel controller
Message-ID: <20230519-catatonic-swimmer-80b086ae0586@spud>
References: <20230519170354.29610-1-aweber.kernel@gmail.com>
 <20230519170354.29610-2-aweber.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZbsHYCLMrj/q3z3Z"
Content-Disposition: inline
In-Reply-To: <20230519170354.29610-2-aweber.kernel@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZbsHYCLMrj/q3z3Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 19, 2023 at 07:03:52PM +0200, Artur Weber wrote:
> Add bindings for the S6D7AA0 LCD panel controller, including the
> S6D7AA0-LSL080AL02 panel used in the Samsung Galaxy Tab 3 8.0 family
> of tablets, and the S6D7AA0-LSL080AL03 and S6D7AA0-LTL101AT01 panels
> used in the Samsung Galaxy Tab A 8.0 and 9.7 2015.
>=20
> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
> ---
> Changed in v2:
>  - Updated commit message
>  - Added reg to required properties
>  - Reordered required properties
> Changed in v3:
>  - Fixed patch that didn't apply
> Changed in v4:
>  - Added LSL080AL03, LTL101AT01 compatibles
>  - Added description to reset-gpios
>  - Added vmipi-supply, renamed enable-supply to power-supply
> Changed in v5:
>  - Changed compatibles to avoid concatenating multiple model numbers
>  - Removed '|' from multiline descriptions
>  - Fixed license

Looks like you've resolved the things Krzysztof and Rob took issue with.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--ZbsHYCLMrj/q3z3Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGfBNwAKCRB4tDGHoIJi
0u0GAP9naF1Vwzu/CY4ARw7Njk+TP9o/o4hxhuUWXHEbiUuBlwEAoblSB3j14JWx
NEOpn/W7lrzZa4Ggt66sk+s2FdulmwY=
=/BPW
-----END PGP SIGNATURE-----

--ZbsHYCLMrj/q3z3Z--
