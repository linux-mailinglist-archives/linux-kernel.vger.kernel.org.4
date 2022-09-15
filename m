Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC175B9516
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 09:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiIOHOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 03:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiIOHOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 03:14:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D232513F53;
        Thu, 15 Sep 2022 00:14:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC1866212D;
        Thu, 15 Sep 2022 07:14:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53788C433D6;
        Thu, 15 Sep 2022 07:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663226086;
        bh=sP+mf27rpzQewNKmHATbFvxbwmIP1vT96/dnVf67BGE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HzbzvksJv084a0UrE6q/2aKgn4atqBzVeINSsND2hXnrUdHgyHprCEPup+L9FzJ7L
         C/1usAQH9GRzXklrt9P1GvwZolWpMeQXG/FKNyeq1aaYU0bNDH27OdA4GxVwh7EqH8
         tpWnYxdnXc8TNtyIyl20nvZsX5RN+RYqVOcx0WqF6QLYOJYJFevevIDVnarpsEn5TA
         pB8WVvrRcwRV6Q9nW47mitfpggZ+3R+Ym+Fu2811EpCEqQ5RavSFRrOKRyTYt7iTN+
         4m1Bi3IWugs3Ju3nOFkWqQrVPdetyqRC9/1IJt0ntDufbH0Uqdcgz3KpZ7E0wqki4H
         5xhRAFcZ5Q1+Q==
Date:   Thu, 15 Sep 2022 08:14:42 +0100
From:   Wolfram Sang <wsa@kernel.org>
To:     Lin Yujun <linyujun809@huawei.com>
Cc:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        akpm@linux-foundation.org, wim@iguana.be,
        linux-rtc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v3] rtc: stmp3xxx: Add failure handling for
 stmp3xxx_wdt_register()
Message-ID: <YyLQ4k54vK+3239d@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Lin Yujun <linyujun809@huawei.com>, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, akpm@linux-foundation.org,
        wim@iguana.be, linux-rtc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220915065253.43668-1-linyujun809@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zY9MrxLdtodLpJSH"
Content-Disposition: inline
In-Reply-To: <20220915065253.43668-1-linyujun809@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zY9MrxLdtodLpJSH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 15, 2022 at 02:52:53PM +0800, Lin Yujun wrote:
> Use platform_device_put() to free platform device before print
> error message when platform_device_add() fails to run.
>=20
> Fixes: 1a71fb84fda6 ("rtc: stmp3xxx: add wdt-accessor function")
> Signed-off-by: Lin Yujun <linyujun809@huawei.com>

Reviewed-by: Wolfram Sang <wsa@kernel.org>


--zY9MrxLdtodLpJSH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmMi0N4ACgkQFA3kzBSg
KbYPbw/9GACuotdUXQczt6AehOptdIothwIs3XpY86K9M6HD1roJOQWAj1kGSbW1
VnbIddLxCwMJbgISgy1imJlLM1b9L+aaFi4hwv7jtAx7SZNQDXEASW5jjQGLGODx
/iv0rWdQfFdMJ+7v1ZSvLTLE8zuKCZjp/Q8Gb2t5GYEFhIoVHELnB7hHIO324IPd
ZqJxY69c5Q4DPblzOsEolA8959y9cFY8RDBcDssP7YIvXXJyQPYUOFtv0tHHM38p
ezZg+aoZu6QMiQsxQZ8vGom5ojws57ESBCFRtSP2R2W4e0JF6lbeY8e53VJqJrxE
VpJxTxSEoBX+0+Unnj4HITienCObC4C/fiSRzxangICn8ItE+/U+42xYf3sVhlk9
/geNPmJj2iNYVrd9mI4uNoOMjsQMVxBUgLdV3WHtlwsuyvNbF4Td7awPJIGxYlTZ
HtaO4EN6MPapP2VjF41Nkco6qcTzJmPa9b3cV+Z8kprD2Z9ApDbOovVNJ7QdrsAY
0fPGNEXu2q2ZkwoX8LKOiEqm8+ltIzOYXRIEJxNYvMXzx1TY8oALcQuqF3RfPlvC
Yy+nLNoa3oTANMrXDTmu21q+n9UUaxFJ9gcTXn2hzu65i+Evqsiy7q0hrtdItCFf
YJLw7JcXEvHXhfbw3XN60QCr88vi8yHZrScifnLO4znAcCi3ZYw=
=OsHN
-----END PGP SIGNATURE-----

--zY9MrxLdtodLpJSH--
