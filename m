Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B536045F5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 14:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbiJSMwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 08:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233455AbiJSMv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 08:51:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFD918C412;
        Wed, 19 Oct 2022 05:33:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E04660ECC;
        Wed, 19 Oct 2022 11:57:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2652C433D6;
        Wed, 19 Oct 2022 11:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666180664;
        bh=xN0ViNDIEFlvZ8cpBkJuaRDJox/j4tz1IrTtAUrllF8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GeCWefPnlnA1NzGiDEQ8qxrAzj7yyeV1+E0QxSdNxvJIjQzteSG9pJ94aYhk29CKc
         JfJOjZV2IaoIGAjeo1Wv+eVg9jkNLK10jDKy+Pye0Q1Qw0wgDFd12UGrdX1FPPmfa8
         A46q8Lg2jRXxqy9g1hNCcBtzoS/OYF59n2yBn8jXX1BZMH30+S12CeY4qvgg47okT+
         k5G4vzXe/jr8HGoPhwJVJ5H4vGGTNYgppEd+5aY2N3VtQPNtjsb7iANuMrT6R2Fq6+
         7TPEAvR8BNtq9QvEXaZqiFQp/UO+jO9stdeg+D0skw9+1v5lllzeDnImNgzVrPpHON
         6/cjZ3lYbfVyg==
Date:   Wed, 19 Oct 2022 12:57:37 +0100
From:   Mark Brown <broonie@kernel.org>
To:     chengwei <foxfly.lai.tw@gmail.com>
Cc:     lee@kernel.org, rafael@kernel.org, mika.westerberg@linux.intel.com,
        andriy.shevchenko@linux.intel.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, lenb@kernel.org,
        linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
        GaryWang@aaeon.com.tw, musa.lin@yunjingtech.com,
        jack.chang@yunjingtech.com, chengwei <larry.lai@yunjingtech.com>,
        Nicola Lunghi <nicola.lunghi@emutex.com>
Subject: Re: [PATCH 2/5] regmap: Expose regmap_writeable function to check if
 a register is writable
Message-ID: <Y0/mMeVSTEKfOgBN@sirena.org.uk>
Mail-Followup-To: chengwei <foxfly.lai.tw@gmail.com>, lee@kernel.org,
        rafael@kernel.org, mika.westerberg@linux.intel.com,
        andriy.shevchenko@linux.intel.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, lenb@kernel.org,
        linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
        GaryWang@aaeon.com.tw, musa.lin@yunjingtech.com,
        jack.chang@yunjingtech.com, chengwei <larry.lai@yunjingtech.com>,
        Nicola Lunghi <nicola.lunghi@emutex.com>
References: <20221019022450.16851-1-larry.lai@yunjingtech.com>
 <20221019022450.16851-3-larry.lai@yunjingtech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5xY9Nrn608s6AE+Z"
Content-Disposition: inline
In-Reply-To: <20221019022450.16851-3-larry.lai@yunjingtech.com>
X-Cookie: I like your SNOOPY POSTER!!
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5xY9Nrn608s6AE+Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 19, 2022 at 10:24:47AM +0800, chengwei wrote:

> Expose the regmap_writeable function for pinctrl-upboard reference.

Why?  A driver should understand the register map of the device it is
controlling.

--5xY9Nrn608s6AE+Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNP5jAACgkQJNaLcl1U
h9AnLAf/e9cHb/Ezq1Fzitr9dlOLq7JJm0v46MICOJKH6ri06LpV+vfWzLr1/JBX
K8C/R3y+hcMe6UB6h+SK5+m4rXDTb+sD4so/z7eON/19lPtzFUw+mP2A5k31G2Yt
mfUM/QfbkAexC5DejtdPb5+mO1MA3YzqLtYVV89CqXBby1VNWZwXDlBheweApkv1
FTpGg1hbDK+490mA5UCzswq4qDHfaPJagao1isGEFFAVLHCSaj4c9tOATkrW6/y2
cZLgDN9nh5W+uktXyS7vShXXjmkZlXE4+kjnpszP8s6ZcMba8n+aVYlRsh+gRXon
KW/zSVfzuxwZbmmjBzd4WUxQer60TQ==
=rCvO
-----END PGP SIGNATURE-----

--5xY9Nrn608s6AE+Z--
