Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10A46DA2A5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 22:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239069AbjDFU0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 16:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbjDFU0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 16:26:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010AC7683;
        Thu,  6 Apr 2023 13:26:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E06B64357;
        Thu,  6 Apr 2023 20:26:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCD85C433EF;
        Thu,  6 Apr 2023 20:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680812766;
        bh=z0gnI4xz6i2X3pKzDPyukg2dlEsKFFAw010FtVx1YaQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cnuNuqJPRT+naE4FT6Idl0PmuyfHxXLrHLCcEGQUNbXjrYXHlfPFBG6Fsl/9ZnLJn
         m4iaxLa1mQSus8aMS/oe4SthXZMbrymt6vCmo4Th8npTJkz5+Ovybe6gGRqlGebTmQ
         BqwBOIV92qjJNjEoCJtwiIR2YxtWC3wUbF1cc+5lGca8Af56GT+lGrUFDJQr3oMEs6
         YpTNUZvwhl3jTn+r6xkabr4QwfECEtZZig+t/26rA6Es9CkrHbWAoyaVs5BJC13yXA
         OOQopOY3KqIzKRizrz17ghtgN5nAiWjV0+IFqZM6Xr3WG2SQhzUpQ/dK6K+HgOGxVm
         PCIpXshlSkbig==
Date:   Thu, 6 Apr 2023 21:26:00 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Saalim Quadri <danascape@gmail.com>, lgirdwood@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        daniel.baluta@nxp.com, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: dt-bindings: wm8523: Convert to dtschema
Message-ID: <2c32b1e0-20f7-4d9f-9dbc-8725562e456e@sirena.org.uk>
References: <20230405203419.5621-1-danascape@gmail.com>
 <2dc882b7-d09f-dfa0-67a1-3f9e6f1ac457@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a/w5QI6652HIyVVV"
Content-Disposition: inline
In-Reply-To: <2dc882b7-d09f-dfa0-67a1-3f9e6f1ac457@linaro.org>
X-Cookie: Man and wife make one fool.
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a/w5QI6652HIyVVV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 06, 2023 at 07:38:19PM +0200, Krzysztof Kozlowski wrote:

> Please squash all your three WM bindings (wm8711, wm8580 and wm8523)
> into one binding, if they are the same. Probably other WM from your
> previous submissions as well. We really do not need binding per each of
> this simple codecs. If they ever need to grow, then we can split them.

At a minimum all of these devices should have separate regulator
specifications should they ever grow regulator support (and ideally
would have regulators specified in the binding from the get go).

There's also no reason to restrict simple CODECs to a particular
manufacturer...

--a/w5QI6652HIyVVV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQvKtcACgkQJNaLcl1U
h9BkDgf+M8IXpNfB37GzGQfw02E0ENuLc4LrP+u4L8FJk6W3CcGjYDaG/RO0qOGX
uILrCetFV4EAMNAKv7LLFIDcIJGuTcNZFBm+RYJDvu2INOoAYjZIeGWylN/rdKFD
pvlbQQX2e2jb4QfsqJT5dPbDYWhd+PcIy3hB698TuRCmZ5s8rbYw8Yap/N89ZgBQ
cTea2MuRLe61spgM6oelea5GgHRKIhiNPCsUjfH+waM24o6KsgaRNcR/tGzIKRfi
Mfo1ffujsCvmBrH2csO8eP7xgbiDwDLmGTrZcePl7XSXEa0259JcYR8qfErqmMxn
JdozSGQDt9qVftBf0Bn14hHTVfjoKQ==
=F4uO
-----END PGP SIGNATURE-----

--a/w5QI6652HIyVVV--
