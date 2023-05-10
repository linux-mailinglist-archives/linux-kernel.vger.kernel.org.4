Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAEA6FDF2B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 15:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237323AbjEJNvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 09:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237277AbjEJNvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 09:51:01 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F349DD8C;
        Wed, 10 May 2023 06:50:23 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-969f90d71d4so313747666b.3;
        Wed, 10 May 2023 06:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683726617; x=1686318617;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wlwmSNTXs77IzPgehdOjVkbe1b+45AorjhoTFeUlS1o=;
        b=imeK/R+7pkd8yqG7dnwLzv1QzmgGfj4RTiZqsh99f8DrTMmmCX6ncigOxcQpbPczr3
         T/vZpvIC0koUwonOAoPUATXYCD9xoMYjVJXWicUyvlkKttQRILzy0GGgyvNu7MiUMfpE
         3Hy7fBO6i8qhanEjITohMdVi7cVF3NZAae7+dxocoGJ4drynFCqEixHrE1+4heHJ8FNX
         jSthahZz4l/+6Wfx5uYk1Dh4olv6DVCweXMV8MaylVcx++xVbpt0F+h2vnt3cfXBO4cN
         KKl18KxQ/nY7dqjKyB5fSBe6gzupCbMRvOZmF0hbbsgJzry5fdZXivDOM+X3hGfw54NS
         CKnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683726617; x=1686318617;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wlwmSNTXs77IzPgehdOjVkbe1b+45AorjhoTFeUlS1o=;
        b=K73h5B36A8KETyFAMGY5fHMezADzRBaAwuE5RXrFet5L6Ftq3s1IlmLCEg3mszMDEZ
         MXFTu8Sr7bKPBOTEcnvzM9DPZk6Qvq2r3MN8ZnJq7jEKc0l87LT8C++1pCAwBuJzWj8+
         VEDgPcQKoOGiVZMgKpn/BwEMaT66tuGub+iTKOb34SJlj90YxCSQs4px+DY3hq6GUgxs
         5/UnjYNnD4Zb/OS8RDPNmZPjIdH/yQoY51cc0tWXwNQspsAI2bZzv+NEgmTvczBOkAUg
         1HAuiQS9iUcXiMi16ke+tyyr98AjnDylBEY5Z/R2MddUSqwPkzmFm6Kdc6+BnQ4c+I7e
         hkpQ==
X-Gm-Message-State: AC+VfDzO99L3aEM/upoRWV9KZ9yqNxk9tXRNFkVE2KCiR1fhO/U+ZKwA
        T8LtEkXfWeuGgeTaRaSIhjE=
X-Google-Smtp-Source: ACHHUZ68tNCRWUqhPgHJmZq62H6phHF3xB6sqbVvwnRsddQDmWgiYDsh+zCLQTBhjLHgEqLpcIF76Q==
X-Received: by 2002:a17:907:2687:b0:94e:16d:4bf1 with SMTP id bn7-20020a170907268700b0094e016d4bf1mr13979193ejc.66.1683726617335;
        Wed, 10 May 2023 06:50:17 -0700 (PDT)
Received: from orome (p200300e41f305300f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f30:5300:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id jl4-20020a17090775c400b009658475919csm2706860ejc.188.2023.05.10.06.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 06:50:16 -0700 (PDT)
Date:   Wed, 10 May 2023 15:50:15 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 1/6] dt-bindings: mailbox: tegra: Document Tegra264 HSP
Message-ID: <ZFuhF1D16NMcY3NA@orome>
References: <20230510113129.4167493-1-pdeschrijver@nvidia.com>
 <20230510113129.4167493-2-pdeschrijver@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="irJFXVrKlSaDt8rl"
Content-Disposition: inline
In-Reply-To: <20230510113129.4167493-2-pdeschrijver@nvidia.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--irJFXVrKlSaDt8rl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 10, 2023 at 02:31:26PM +0300, Peter De Schrijver wrote:
> Add the compatible string for the HSP block found on the Tegra264 SoC.
> The HSP block in Tegra264 is not register compatible with the one in
> Tegra194 or Tegra234 hence there is no fallback compatibility string.
>=20
> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> ---
>  .../devicetree/bindings/mailbox/nvidia,tegra186-hsp.yaml         | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--irJFXVrKlSaDt8rl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmRboRcACgkQ3SOs138+
s6EYcRAAohCXXvGh9wTUKd4SyRFVcUoOHtyxKDXbp25z6jvA2ALHPcmViDZuVzh6
KTwtb9kC3HNBBkW7RbfCRfG3FGMY7i3Geu0YI54wRBwLWPDGrwgcQivL/84IOx+y
Dw6RoMANrdgO+VDeuTDNSt7XqXwo6wbgNzU9iIfkfp9Zpw+D3aWbwk2G+XcwWTIS
b0xEZt4gX92VxDqOAQDo+4cPxvvJ0bSkHxYfxvdHBJm+v7GY5VCsQ1vN0C/8KXSK
dcGNEQK7LH5eJUsGfSnl5XF1S6edu46wltPGfV6tj0hyxwWdxMG3mB2uSjAbAXG2
wWTBEF0yOKYo96uUEp/MhmTieu8y7BxuTcmEeBSoWVvX0QDQe9tuiCffa/O044Kl
3yYfCZtI06xrF7H4/kEp1LT1s1011TWpSCAuNKPOtiYco64P8hZXU1ERx8YrNaBF
U1N0rjvc7XJnstJwE8zuI1c3HPvsmeVqSYNeqE9WnwQG7/eUKMr+OzalQBfbkLCb
eN5Ax5Dr7mKmIUQoUCoJClhAnwDgCLdetu6yFa5m7hfhZffSk5jEofIEsL8JrD/I
MQOCwVK4B7Gq+G9ToI/kzpIyucCtyAREhgZ2eWJn1cpxblfTUpY5xMxqmgfeErDI
pWZmKt9rJTmAC8dvhy73PXyrEw6Hbe+1fifftIHJWrabjEVW8AU=
=qekC
-----END PGP SIGNATURE-----

--irJFXVrKlSaDt8rl--
