Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9432074D6F6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 15:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjGJNHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 09:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbjGJNHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 09:07:35 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FB312E;
        Mon, 10 Jul 2023 06:07:16 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f122ff663eso6929997e87.2;
        Mon, 10 Jul 2023 06:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688994405; x=1691586405;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3/nxRPesClMjOankXm61+x0K4/qIvWcmoNLhKg/B1eQ=;
        b=jJSLWRC2FVyuksKxI4+Gs2oj6PeFqZfh1J7PB9Mmb9jESBy2FeTqQ13UflTRUu/wSG
         +Uj9Qw3NTqnM45/9Q2m8XMxs6WuTj+pKu8ym+u92zbAEbmPgeSx89S2tArmWeDxHx57L
         rgYLd/3/leu/CT4+NcaEl5yHb4R3QeEfkAXOcsOryurCJI/rZB7d4npTwsekv/5Q3Q2M
         tQGw3zMOs6KnggFm3VP9PR6xn4Kdtosc7JdGwwUiAGwoCI98DixNYeID+zftm31U/aR8
         1qXFPTo1TW2wNt3H4SOL5dpJ1ugSDYHI3UbGe09HUuqbYDF1PaAKBslq46l0foaRsVlD
         e5/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688994405; x=1691586405;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3/nxRPesClMjOankXm61+x0K4/qIvWcmoNLhKg/B1eQ=;
        b=Hf7+4iMkg07ErwfYSPQUYwE/INamzwX78633gncWutkIrxJkpeSqGx1LhiR6DGXee9
         pmrRY8QVRytBsPu5AylYE/L0jNBZ7HK+S4nHuowJW2iMhj6edSE+Em/wU6FVlVyi72gz
         7ovkKOjfRVA0R6Oo8bgkDKIXPzZUFC6ZniNdHmR6S6P6/etLHRQH8jqNrKPw3nJ6xOkC
         bl6OFNqVCXajdrM0oRty7/t2LhBeH6Fyt3bBxopfcTTNorwvZe3m1+oJIpftuclqz4op
         c/7YsKFntj+RAVpvOUSp8MmaOlxbeAkY/ezWo5S3OnSarDX9FxfiwWoKONpf1mpG7mC5
         kQJw==
X-Gm-Message-State: ABy/qLYH3tTb2ShONlqO2tP/oN4+G38iSnlrEbX3KX01OpYUjZWd3mnl
        CjjhMpcbXlmiJE28nhc3RIE=
X-Google-Smtp-Source: APBJJlHVeZ+X5JEt7YY+DHxxaqOwbUT35YCrYWEmxZycQtAQgYXYOlUwmRR15tH6T8caZViMoxfM+A==
X-Received: by 2002:a05:6512:2344:b0:4fb:7675:1c16 with SMTP id p4-20020a056512234400b004fb76751c16mr10573987lfu.49.1688994404346;
        Mon, 10 Jul 2023 06:06:44 -0700 (PDT)
Received: from orome (p200300e41f4b7100f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4b:7100:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id b9-20020aa7d489000000b0051ded17b30bsm5701695edr.40.2023.07.10.06.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 06:06:43 -0700 (PDT)
Date:   Mon, 10 Jul 2023 15:06:42 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Jon Hunter <jonathanh@nvidia.com>, Sumit Gupta <sumitg@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memory: tegra: Add dummy implementation on Tegra194
Message-ID: <ZKwCYjKXtuDsOF9E@orome>
References: <20230629160132.768940-1-thierry.reding@gmail.com>
 <1fd1d5d7-7296-0e62-9f65-7347ac0f0500@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3MIRVxCUgwh5Njm1"
Content-Disposition: inline
In-Reply-To: <1fd1d5d7-7296-0e62-9f65-7347ac0f0500@linaro.org>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3MIRVxCUgwh5Njm1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 10, 2023 at 12:10:43PM +0200, Krzysztof Kozlowski wrote:
> On 29/06/2023 18:01, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > With the introduction of commit 9365bf006f53 ("PCI: tegra194: Add
> > interconnect support in Tegra234"), the PCI driver on Tegra194 and later
> > requires an interconnect provider. However, a provider is currently only
> > exposed on Tegra234 and this causes PCI on Tegra194 to defer probe
> > indefinitely.
> >=20
> > Fix this by adding a dummy implementation on Tegra194. This allows nodes
> > to be provided to interconnect consumers, but doesn't do any bandwidth
> > accounting or frequency scaling.
> >=20
> > Fixes: 9365bf006f53 ("PCI: tegra194: Add interconnect support in Tegra2=
34")
> > Reported-by: Jon Hunter <jonathanh@nvidia.com>
>=20
> Applied with checkpatch warning. Please be sure you run checkpatch
> before sending the patches.

Are you referring to the Reported-by/Closes complaint? I didn't include
a URL here because this came from an internal test report and there's no
corresponding public reference.

I suppose I could've left out the Reported-by altogether.

Thierry

--3MIRVxCUgwh5Njm1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmSsAl8ACgkQ3SOs138+
s6GayBAAoF44unOxDy0NOjwd5FhOsshvPhGM1/4T9i9sWAXmPZ04kbwEz/YhQo/O
HZ44HV2CqsM+509pGa9svyZ0tgrbwhXAciCw50d851DwtPv7ao5mSPHUiWB7qkuz
FFiXRGItlrYdfdsmbqRqi204kTskvjiigsaD2OOEtQPFLKdJWtG22uZeVA/aFHUn
6rSYUL2Hl8ikShxmiTy555envyztF61FAvTTdFqiq/+uNMbsqfXGclspzOPW97aR
X5Ci7wRIkffi9S/4yG94sKt3XSUhkcTkGYhwEJHCF4H8RMjWTfpGE7GmznyBy21H
WEvEJCU9uhCLL181uyA6RrnuHGGghJAcrNqkcmMQX/OTtMnDjOlzc3ZEdoPYiLLF
2OwDqWZ0qEGl3kFZ3V0KCYrHp5P2EvZCEz1njkPxJHnGbyZrLzRIrRL8KYqshOCJ
BQHSDF8v4/gcX92Q/PUN8RMNIR+WiA+0+wqaIMdwAO09SX3/f8UqfZ9NjgUDCkFO
SiyMGj0OLo/CtkSDyoxufqJj4wuSxqSA3KV6ftZTLcekFDT5jOpWmG9K1JTAyI+c
glWu52782GobBDOTGJO8g+0tbbySzT7JbG5Mlm/clv//4cRFXGKF77I/e0nKAeX0
W2G55XgDytzucDULRaVNKl8UVSdBboKHv9vAPb6r6U2sB3/94CY=
=YpDw
-----END PGP SIGNATURE-----

--3MIRVxCUgwh5Njm1--
