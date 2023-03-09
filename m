Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB486B225B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 12:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjCILLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 06:11:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbjCILKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 06:10:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7EDF16B4
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 03:05:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9432DB81ED6
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 11:04:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC9D9C433A4;
        Thu,  9 Mar 2023 11:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678359893;
        bh=ItLBi+0lZp70hRUNdsA4aepFuWr67EsF5Z6tELBjYvA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K3bsUTdKFdPrTbqQe90CYDicwPOgxm/Gw4Ba7ogv3/Pt/QENXim3ZlXCtkWkD1tNt
         KsHZNQUX7Dw8fUzrBN+5v5NJvO1LCNtyXFG/b4O4t/wOc7u1FJ8miIiA3AVY1ksX43
         zBCjqdLW6IpkkVHjdPOFnXODDJQl5Bw6MC8AEtxG6JgGdObfII0c4rajA60hzgmXMN
         8kl0at8oxVSpoIOTwispGjmmyvuaFbaSG5jdSFArLavA489eiI+19z1XlAtOYZbwSE
         P/liEdj9HoKeApoYQeXCXJsbYwwwKlD4j84WbviPYb/FmyBw6zGptf7E/YkBBa1pK/
         UUbgUlZC/BxKA==
Date:   Thu, 9 Mar 2023 11:04:47 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Lucas Tanure <lucas.tanure@collabora.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        "Takashi Iwai --cc=alsa-devel @ alsa-project . org" <tiwai@suse.com>,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v4] ASoC: cs35l41: Steam Deck Shared boost properties
 quirk
Message-ID: <af2de8df-b20e-4bbc-9f00-90b50546c4fb@sirena.org.uk>
References: <20230309104133.537056-1-lucas.tanure@collabora.com>
 <2881f527-1673-3496-85a2-84a13f074248@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MEn/5gcmmV3DPcub"
Content-Disposition: inline
In-Reply-To: <2881f527-1673-3496-85a2-84a13f074248@linaro.org>
X-Cookie: I will never lie to you.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MEn/5gcmmV3DPcub
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 09, 2023 at 11:42:42AM +0100, Krzysztof Kozlowski wrote:

> You are now changing ABI and adding undocumented properties.

This is newly added code, changes are fine.

--MEn/5gcmmV3DPcub
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQJvU4ACgkQJNaLcl1U
h9BIYQgAhqgJlZhWJvTkYMdqV34JKrOVN2pWnUrVIHJNkfcHxOVPfLbfx1Xzonuk
kijPUdqB9lMIAcyHtZa4ai5E3pAJ5kDVDr+42f5VeAOdonHKv9Z+S2M9s8vt8sAq
qpReSp4Y4dl2mtc7Xh2vmHZIgIJu+FFdh+I/HMp7U2FgQJ9ixw7ktfKbgSh8Sm7w
t60yvoTXQOl7V5skSzs0tNA4LHTinJJMuvWbbJISFv/qb1gkIJALKlE2ELsjaL+p
q30P58/0YAs+HDK7v4a93XHyyk/k8vvNX+90yrXVYWEH/zX9Ys5mHFLtt1QcCZFz
tOiNgQ1n1GjYDVp0bJJKa9J5Wu6Ixw==
=fWVY
-----END PGP SIGNATURE-----

--MEn/5gcmmV3DPcub--
