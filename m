Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD4870FF20
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 22:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234154AbjEXUWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 16:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236438AbjEXUWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 16:22:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BE1191;
        Wed, 24 May 2023 13:22:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9C8B64047;
        Wed, 24 May 2023 20:22:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E4C9C433EF;
        Wed, 24 May 2023 20:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684959759;
        bh=s5ykL53eIy5CGwh+Iw+O4G1LCAdTOLiMVsk4kKJJvAs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ic/gA1SoNxVphLi9Yr09q1NOWlRi4n7QtIlO8PiDMPO/5AjhF6tN41JSTraVU1rZ1
         EsrhMklEgX39a0oHewCQ10+hcL0SEAdgS8IbzVpihF5ydl2kBE8JBBtWHHuniBvlTj
         FzhJaENSXzTgkjYx4bCwnq8kJACAT1YwCIps5tGdyoP3z75f3+0/orOyLTDr9dlliX
         K+tXhcvgKpbBYK39Mfgm9Xq3R0b2qbHSW7bKfJ6YQar/5Rtp+mBokGvN/eQ67bCzsz
         Wrfc/rAdnq9ZO1clL5tM/tzth/oShl3jjHA3YfFdkdlp81/59hY37IpGAbjx+BTTfe
         wPLGlfRd7LJag==
Date:   Wed, 24 May 2023 21:22:34 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc:     dianders@google.com, daniel@ffwll.ch, neil.armstrong@linaro.org,
        sam@ravnborg.org, airlied@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, hsinyi@google.com,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [v2 0/4] Support Starry-himax83102-j02 and Starry-ili9882t TDDI
 MIPI-DSI panel
Message-ID: <20230524-dispense-luster-7962b13074c5@spud>
References: <CAD=FV=WRecTWsFM96k81YAx1=jJT0vpS4EPP0ZfWFUGHNFx9Tw@mail.gmail.com>
 <20230524072816.1131039-1-yangcong5@huaqin.corp-partner.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rgZPHXM2KOTwBnaO"
Content-Disposition: inline
In-Reply-To: <20230524072816.1131039-1-yangcong5@huaqin.corp-partner.google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rgZPHXM2KOTwBnaO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 24, 2023 at 03:28:12PM +0800, Cong Yang wrote:
> Compare V1:Add compatible for Starry himax83102-j02 and Starry-ili9882t
> in dt-bindings.

BTW, my mailer doesn't like how you threaded these patches, I guess you
sent them as a reply to something I was not CCed on.

>   dt-bindings: display: panel: Add compatible for Starry himax83102-j02
>   dt-bindings: display: panel: Add compatible for Starry ili9882t

These two are
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--rgZPHXM2KOTwBnaO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZG5yCgAKCRB4tDGHoIJi
0mNmAP9AKMIRtWN+rUBErdb+/gBM5rXYpT7EtNguO7DBe0rJsgEAz1171lVSS3no
TFIgyfCnddHmw1ar3lRdb02Reqyxcg4=
=TsDO
-----END PGP SIGNATURE-----

--rgZPHXM2KOTwBnaO--
