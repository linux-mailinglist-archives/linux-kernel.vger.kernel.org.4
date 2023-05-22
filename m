Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B8470BC77
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 13:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233512AbjEVL41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 07:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbjEVL4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 07:56:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA3FB9;
        Mon, 22 May 2023 04:56:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0391A6134C;
        Mon, 22 May 2023 11:56:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B091C433D2;
        Mon, 22 May 2023 11:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684756579;
        bh=EpckMfRwCrGZAekKS+zFPZVkXbLFweYKsYGy6IlCrE4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tQSQV9dZCvUQhuKuPIzyN0sCZBxK+HW7ub8uVFB8OrCdswMUk7g/JowZVCq1PVo2O
         SlWo6ilSu4uwUccVAjShBFHEePgFUVVBA09L3zoN4B7toXtRzPnLmwRQ/qSEueq99h
         f5W8NsmSf8VQw95v8bLs8/JTY1aMSNaxrQ2ZmAXag34xV0idRVIhvEPXIfQkW2KJxq
         iJ0spio8yqFXAo3aUxAI5+7UsehWY7CAZi/xJKHtQ75t8odajwgY33mzkhG6NcKG2Z
         SX03/9kxiSmob0gS+kouwiu0mxwLc57a+qho1V3OihxP2aQ4zWIB8qTAY2ZsQRGTaJ
         5P23VAl32CmhQ==
Date:   Mon, 22 May 2023 12:56:13 +0100
From:   Mark Brown <broonie@kernel.org>
To:     zhuyinbo <zhuyinbo@loongson.cn>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v11 0/2] spi: loongson: add bus driver for the loongson
 spi
Message-ID: <a4afd330-6ffd-432e-a868-f8a19fddb47d@sirena.org.uk>
References: <20230522071030.5193-1-zhuyinbo@loongson.cn>
 <3c15d22f-4f94-4cc5-96a8-f565e58c66b9@sirena.org.uk>
 <4dfa5245-d330-f432-e81e-163053687d42@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Mu4/waE/XYgeawDk"
Content-Disposition: inline
In-Reply-To: <4dfa5245-d330-f432-e81e-163053687d42@loongson.cn>
X-Cookie: HOST SYSTEM RESPONDING, PROBABLY UP...
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Mu4/waE/XYgeawDk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 22, 2023 at 07:44:49PM +0800, zhuyinbo wrote:

> The recently patch was as follows, It seems no issue for patch apply
> them, Maybe it is the 0/2 patch issue ? this 0/2 patch wasn't a valid
> patch and it need was skipped.

What's causing problem is that you patched MAINTAINERS in both patches
but also used the wrong subject line for the first patch so I was having
to fix it up by hand every time.

--Mu4/waE/XYgeawDk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRrWF0ACgkQJNaLcl1U
h9C0UAgAhrblfa0jqRU5ktPpX7VnSb5GNr1m4jRjFTcDgingEkTWEwite4ck5b97
v7mBYqqaAZ2edpJywoIuDc25E8XJWItca6JMQRbpXpA+g3eavN5Dx0yhm41knrKl
FJQ9h+qYEXoQNggCwd+lzKJSzatfrFyf4ZIidTYG8IR3ZyuqEQ9WrrKqxm8/OxBn
44uT6pZ+oqZ3CBZdZ6LrVmhatSUGh7jOU/PO3GuLYmL+h/Z8abvqv4RoYOFSRz2G
/hRwExrFid16pcm33VZNBCtqpkRtDobN0rGHOTvT4LK4QbcLfAR/+rHnDI2YjkgH
JVPhZ4A6CBgM3Lfms1RQuYwvIwW/xg==
=J/Qi
-----END PGP SIGNATURE-----

--Mu4/waE/XYgeawDk--
