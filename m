Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B526FB153
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 15:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234052AbjEHNUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 09:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233727AbjEHNUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 09:20:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753E633853;
        Mon,  8 May 2023 06:20:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 844DC617FB;
        Mon,  8 May 2023 13:20:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86072C433EF;
        Mon,  8 May 2023 13:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683552007;
        bh=qxFXyXiRdVLI2aihpdzgvoA6SSxPIdCsgLDWxMdXX5o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SDESLVfEzhSqWVZXhUfs6uC5deUwcGU3S2WRTAYeCbTYSo11M9ke2xWtgxCkxK/jH
         zseYJ5kcIgk01/TUw0HouGhrGsR2ro7tLcbpIWXiku1Ftpy5MkGLNkUVysAAJfTl3M
         CU3Mj5AlTpTjCGuKpcl9EZuV+7HMlFQCqGedxrGWko3yG1uii8CUJJGBxupTa7/Fgo
         ZGzU6I4xF9fGk1yMeyOPDhzGhrvJUQ2OyuIfsutzEqsvBLTCw2JJJ1ta8e8/JBjT8c
         I7tBoJOxRHAM0Ui58UKO8Tu7WfOAp4nogSRpFaoSASmVZzzrhMndR8/yhjsExAP5i7
         Qfwxuzf4IuCnw==
Date:   Mon, 8 May 2023 22:20:04 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v9 2/2] spi: loongson: add bus driver for the loongson
 spi controller
Message-ID: <ZFj3BEHCDc/XLBZB@finisterre.sirena.org.uk>
References: <20230426071045.20753-1-zhuyinbo@loongson.cn>
 <20230426071045.20753-3-zhuyinbo@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XLm4P5IUAz3phiU9"
Content-Disposition: inline
In-Reply-To: <20230426071045.20753-3-zhuyinbo@loongson.cn>
X-Cookie: New customers only.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XLm4P5IUAz3phiU9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 26, 2023 at 03:10:45PM +0800, Yinbo Zhu wrote:
> This bus driver supports the Loongson spi hardware controller in the
> Loongson platforms and supports to use DTS and PCI framework to
> register spi device resources.

This breaks an x86 allmodconfig build:

/build/stage/linux/drivers/spi/spi-loongson-core.c: In function =E2=80=98lo=
ongson_spi_init_master=E2=80=99:
/build/stage/linux/drivers/spi/spi-loongson-core.c:222:31: error: implicit =
declaration of function =E2=80=98of_node_get=E2=80=99 [-Werror=3Dimplicit-f=
unction-declaration]
  222 |         master->dev.of_node =3D of_node_get(dev->of_node);
      |                               ^~~~~~~~~~~
/build/stage/linux/drivers/spi/spi-loongson-core.c:222:29: error: assignmen=
t to =E2=80=98struct device_node *=E2=80=99 from =E2=80=98int=E2=80=99 make=
s pointer from integer without a cast [-Werror=3Dint-conversion]
  222 |         master->dev.of_node =3D of_node_get(dev->of_node);
      |                             ^
/build/stage/linux/drivers/spi/spi-loongson-core.c:242:13: error: implicit =
declaration of function =E2=80=98of_get_property=E2=80=99 [-Werror=3Dimplic=
it-function-declaration]
  242 |         if (of_get_property(dev->of_node, "spi-nocs", NULL))
      |             ^~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

--XLm4P5IUAz3phiU9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRY9wMACgkQJNaLcl1U
h9DhnAf/Rhh0Q9tyOwxp7DdPW2Ys4Rcuq4CES/hgxOKXyxUqTn1HsF0H9VL2/P1w
KqLKoqzD1+Y24twdKcTh100SonViZqf6xMJSAB0U+RfyLcErUwafjmckjQe0pmEH
Yigc7BExtn4GY7hK+IeSE3XbUX17Tk6WLcn0t7khwOcpo2KfaeCrea/ZJtlMt1eR
/PAv/6QL64kBj6j23F/EtzvCTx9yXGPi3oa1sh9D/c/EkkwQhbdDJv1zMW6pRN9T
A6nyb+wUq+vwN03XnyqWu8cjHd6Y9ExhDjnELm9jbxXr5kARlfK/8rihNL+PDjzT
xuTS6cmhMfWsXisDtixgKfRf4UBFeQ==
=z8qJ
-----END PGP SIGNATURE-----

--XLm4P5IUAz3phiU9--
