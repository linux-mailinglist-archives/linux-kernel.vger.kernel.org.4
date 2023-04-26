Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F756EF610
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 16:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241207AbjDZONj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 10:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240789AbjDZONh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 10:13:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7716A70;
        Wed, 26 Apr 2023 07:13:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2E5C60FFA;
        Wed, 26 Apr 2023 14:13:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1876C4339B;
        Wed, 26 Apr 2023 14:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682518416;
        bh=FGzEvw9TbVU4T3e26lHuswObY6PfV6RZ4w7PVZz4AXQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f4Sckc1gV0y+6gByaTDKrw3r1jyCDAO5rEijIAFivAFWrEsgtcXgkUsqZT2U8W0zk
         t93z4Zk0jrT1K/0VaUkkBwrfgbx0y9TakXUMTQ6f3mv8AWCayCR3TVAQer80Wvyays
         rTP+oXkU9hwPXEqkCCTiWOy5LzU5JXSYuGaOv5LnxQuw4Zqy2BhayBPu4a8D5dEwhG
         onrMoG371i1qUYlWcO74Qp2AeenrQPuN/YtTmlLc4aJS1Z59rFyqfyx8BY2HUILKDY
         JEQ/+l78mw8JzA9oUwUYHQKOrgp7ZAjVsywR7x18nNNtnlvJkmOp3tSDGPT0A0ofn9
         B7dit+o6WdUZw==
Date:   Wed, 26 Apr 2023 15:13:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dongliang Mu <dzm91@hust.edu.cn>
Cc:     Li Ningke <lnk_01@hust.edu.cn>,
        hust-os-kernel-patches@googlegroups.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH] spi: davinci: Remove dead code in `davinci_spi_probe()`
Message-ID: <dbcc6739-e741-495f-85f9-bac104647194@sirena.org.uk>
References: <20230423032446.34347-1-lnk_01@hust.edu.cn>
 <d29c4b3e-9e82-4ea9-9f0c-a8e2c7637eb9@sirena.org.uk>
 <46299274-d827-279f-cadf-020e93296c13@hust.edu.cn>
 <ed846afc-7155-4998-9a8d-e9d9e8aaf8e2@sirena.org.uk>
 <1488abfa-9a0e-970b-e074-11842a6c6413@hust.edu.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Od8kKp2gYUL6gufg"
Content-Disposition: inline
In-Reply-To: <1488abfa-9a0e-970b-e074-11842a6c6413@hust.edu.cn>
X-Cookie: Drilling for oil is boring.
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Od8kKp2gYUL6gufg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 26, 2023 at 09:50:26AM +0800, Dongliang Mu wrote:

> Second, from code review of platform_get_irq / platform_get_irq_optional, it
> would warn IRQ 0 as an invalid IRQ number.

> out:
> 	if (WARN(!ret, "0 is an invalid IRQ number\n"))
> 		return -EINVAL;
> 	return ret;

Like I say I'm not sure that's actually accurate for all architectures
yet.

--Od8kKp2gYUL6gufg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRJMYoACgkQJNaLcl1U
h9C2lAf9GVQt82EKlECp9WbwEG+hwJjul3gLVids2AwP3aiURs70c1x2jUFqHvdf
zlZkjjNOK4TEwy4TiUjws5Ep5rnAv1bUQ46rn9wZN1njGpCrAcSxKBLPBug4XlbJ
FZcvjrI0mcgX7ZsPNm8Phyggy585Vys2eipru31AnNooURTZDeWf8cZikcofb/n3
7E6hdhrKyfbvKHwX3D7P/HVcd/appSvwBYAUVS7qxMqowdlkh+3un1Ei+VWMDHcK
HV8vvO6dfNrMJiVODYR45X61cgtEbAhUeZQ9nae8qExhTyJwWs/XWRWrlgQf4U99
RteubIvOsSglFeh2vJsvkg58IM4MXQ==
=bX6c
-----END PGP SIGNATURE-----

--Od8kKp2gYUL6gufg--
