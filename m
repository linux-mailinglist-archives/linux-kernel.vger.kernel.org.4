Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA46A72ED94
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 23:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232924AbjFMVFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 17:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239438AbjFMVE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 17:04:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8151199C;
        Tue, 13 Jun 2023 14:04:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D2026170D;
        Tue, 13 Jun 2023 21:04:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D2E4C433C0;
        Tue, 13 Jun 2023 21:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686690294;
        bh=VBPiqTRrsIFfKk/fO/C3p90Jg4hrTEWW72mMyNqP8Bw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o4S9KTQPHV5/MUgpI5lJaIPPqruvLjgsqcJkFh6ESTRrsJ5vmpgqutzv5WbtVeDak
         FNTlVB0SU5ls6XfiWGKQg7AR6cKCS/TcGZODeMv013IguCIYYGa1s5UOG5Ac6VVIde
         HbeJiMNFw7P+NLaGpjkt2trxu3qama0hoob7NvuJnye8F6wODJUDtuVRMWmvNvXA1B
         zwranu9PVWVCfAhuGhLY1YGlMtgeEx6ta0hY4PPSN9RRkp7sgbkk35gLH8/YRpKd30
         33LsU2gv6rRKrMldaReoRx2YaSChFufpYBbrGm6Ls9eqdVWWRmFeTBojh9QLxBWQz2
         m2xzyDwrzRHLw==
Date:   Tue, 13 Jun 2023 22:04:50 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen Zhong <chen.zhong@mediatek.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: input: mediatek,pmic-keys: Fix typo in
 "linux,keycodes" property name
Message-ID: <20230613-gyration-cruelness-76f4bbaff421@spud>
References: <20230613201040.2823802-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bCcdyfHFgv1454zA"
Content-Disposition: inline
In-Reply-To: <20230613201040.2823802-1-robh@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bCcdyfHFgv1454zA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 13, 2023 at 02:10:40PM -0600, Rob Herring wrote:
> "linux-keycodes" is the wrong property name and is unused. It should be
> "linux,keycodes" instead.

Nothing in-tree at least, looks like they use the correct property
already.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--bCcdyfHFgv1454zA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIjZ8gAKCRB4tDGHoIJi
0otUAP0eUymc3D3skmsQWKQ/oO7+LbtvdtektOzxuO0m2uAF2wEAzYvSHucAROnW
HzZ5CWNeAPTLYXKs05aIkCxdFDfv2wo=
=OBNz
-----END PGP SIGNATURE-----

--bCcdyfHFgv1454zA--
