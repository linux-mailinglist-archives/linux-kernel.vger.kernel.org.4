Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D185B6FBB15
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 00:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233976AbjEHW2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 18:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233813AbjEHW2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 18:28:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC387AAC;
        Mon,  8 May 2023 15:28:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3265162008;
        Mon,  8 May 2023 22:28:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83CD4C433EF;
        Mon,  8 May 2023 22:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683584909;
        bh=YLErWiO67rCOF3C7aewUGP9j3H2s5a80TaR7xABdUvY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lt5G/T6qN01xsdTV90eNTuyZvkQ0UqIp96LBtvn7CJrONa5pIF+DAgWAqIdkcOf/v
         OkLG70AU976JQGiUDx43UGk2LGb+AWJIPa5GIR++NOMqF24r6e0WGwTK639G3crd74
         JVahwFNucBjMoAE70+uvpGtoPAc/EMoWPnIsTnm7WibdBmLyo43p6zzO9uW7U/8VfJ
         n4EPruOa1PTqDVgY1k6kzKmuZkvs2Q4N8GL7U8b0ZlEDrRakmvNPTscbtFqJ0ylMTV
         MfAnTvXBv0txCIU3HFdLERtnH7LIxS4nYd9rzkUrCpCO5q3geu0SUHNg1fJG4LnAle
         xfQDvD3VgoCOQ==
Date:   Mon, 8 May 2023 23:28:24 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.1 000/611] 6.1.28-rc1 review
Message-ID: <20230508-widget-radiation-d4acf2192fda@spud>
References: <20230508094421.513073170@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="AtKzXF1T8O8D6nJ0"
Content-Disposition: inline
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AtKzXF1T8O8D6nJ0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 08, 2023 at 11:37:22AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.28 release.
> There are 611 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Wed, 10 May 2023 09:42:40 +0000.
> Anything received after that time might be too late.

Other than the build breakage due to the bcm63xx stuff

Tested-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--AtKzXF1T8O8D6nJ0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZFl3iAAKCRB4tDGHoIJi
0tF4AQDiVnuSofK3ADTs8iiE1zmosnK+OZ2MuD8ilCrrUz0SQgD8Dw+HMtgb6jmO
BWYAvwI2oXDnVgucsYT6ElzBOzrfCQM=
=TGsY
-----END PGP SIGNATURE-----

--AtKzXF1T8O8D6nJ0--
