Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E3B6FE091
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 16:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237560AbjEJOkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 10:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237567AbjEJOkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 10:40:36 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDE16EB5;
        Wed, 10 May 2023 07:40:29 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-50bd2d7ba74so69506404a12.1;
        Wed, 10 May 2023 07:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683729628; x=1686321628;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BrjfVLE0kuezCEefQF3UAj3/eiXoxjrn3YOUxgzVyC0=;
        b=KS4LjZzMHiePCh/GlG0eJsCGCU2fZKQLTkHMc3cX0qXb8XVeMLVXo4JF3N/x6oB0l/
         zib01fii1to6KK0vMrp0mx6cvXCqMajgVn76xQiJ48A8bpgzXsPmOAjlGAsmVqAwxWUE
         eX3PEdujnMiNGSQZSClyTCS/GKqI245W4cuZ/v+TJiBsvG/rKVcpl4JNQB5vyT9nu+go
         2qTg3NAw1qCPbXVDo827AlZBfyJCuj25xxjoiJNVssh26HldvJ7FYBCR4LPHzrNd/SUk
         0h8217Ke2+tSbOpEjMP+PlwRODl8bU2Gok94Rj1Pj8jkuNbyxJ1PK8mi8FEzqrFFzOEH
         GfgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683729628; x=1686321628;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BrjfVLE0kuezCEefQF3UAj3/eiXoxjrn3YOUxgzVyC0=;
        b=PEAKAHmGYICDU/71m8uh8hI/75SvZboypMTOCEm62fXIyIxm0OW1EbxRZ4YouZdCbC
         ucpkZFyHGkDL+JbgJqukYkLGDMZUQ3Fx4C8Mwj4QznKdQEQZIUY5t8BlvqEItpk5Bz0F
         Ug7nbL9MU4jNueOsJSxEV+K07xsaTEBRx7hHZp2HZwmv7caael0K19h7plyCF70Yp6sT
         ukWEYltB1A/FwlhvgHNiZ+GqiBKPQQnqHKEl9rMpmjfvn8zBhaXupjOxwhDWIOSvjdvm
         hi0CfkJUfULYD+/9BIMo6gBJiYuDCpCUyNVtJZ+dx40D3s4AJAWMUlSJyd35Lv69EitX
         91/Q==
X-Gm-Message-State: AC+VfDyOBri9U1i5jkDd94FErQePSC1XI2gHoFioCEy2DkWcGnsvDWYY
        MuffQpTqrqKTqdTj2gYAAos=
X-Google-Smtp-Source: ACHHUZ7kHhC6J//zo/saeuRoGlERPc36A71RXJAfB0Vkkt/9CfVbt/HZ6inh7l+XzHKo3smNkcE6iw==
X-Received: by 2002:aa7:c953:0:b0:50b:c456:a72a with SMTP id h19-20020aa7c953000000b0050bc456a72amr14550883edt.19.1683729628283;
        Wed, 10 May 2023 07:40:28 -0700 (PDT)
Received: from orome (p200300e41f305300f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f30:5300:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id a17-20020aa7d751000000b0050d988bf956sm1993955eds.45.2023.05.10.07.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 07:40:27 -0700 (PDT)
Date:   Wed, 10 May 2023 16:40:26 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     jonathanh@nvidia.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, stefank@nvidia.com
Subject: Re: [PATCH v2 5/6] dt-bindings: memory-region property for
 tegra186-bpmp
Message-ID: <ZFus2s7rdIS4hf0S@orome>
References: <20230510113129.4167493-1-pdeschrijver@nvidia.com>
 <20230510113129.4167493-6-pdeschrijver@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Cys7xdI4J5nU1kTN"
Content-Disposition: inline
In-Reply-To: <20230510113129.4167493-6-pdeschrijver@nvidia.com>
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


--Cys7xdI4J5nU1kTN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 10, 2023 at 02:31:34PM +0300, Peter De Schrijver wrote:
> Add memory-region property to the tegra186-bpmp binding to support
> DRAM MRQ GSCs.
>=20
> Co-developed-by: Stefan Kristiansson <stefank@nvidia.com>
> Signed-off-by: Stefan Kristiansson <stefank@nvidia.com>
> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> ---
>  .../firmware/nvidia,tegra186-bpmp.yaml        | 37 +++++++++++++++++--
>  1 file changed, 34 insertions(+), 3 deletions(-)

We usually use a longer subject prefix, even though that makes the whole
subject usually become longer than the recommended 50 (or so)
characters.

Maybe you also want to add a verb to the subject to make it more
descriptive. As it is the subject doesn't indicate what's happening with
the memory-region property. It could equally well get removed.

Thierry

--Cys7xdI4J5nU1kTN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmRbrNoACgkQ3SOs138+
s6Forg/+J9Eemk8vswIOaDn+qZ4RRD/PyuaHP2irl7MoioAXpR7tA3qM7x/ltwUz
odt+2aGX9dR2PfOE/oT6EIHP0Ho8AMyM2R+o9Ii76mqk6GaO0xiluG3PmyZHkkUS
sziQN5KGVdp74+GiQ8btD6zTn9fO9x9WQ9CXrqU8e/TzlhnPFG3qqEqU5ixH5IH1
txXMLUuecKr/NAKU0uhEU96hgrw+D7dLPTO877RFhwx4JZ2xcZjTp1qGanfBt+Ep
K5oXX0NlmcvnG3tYMLTpuwJ4lpIns+PhiANBMRyqH7Fn4fytqb9fmHZPRSPSnT7r
80+GTZRmd+vXuWI+JkKU714EOkPuJ71XF/hqg/qZHeNeUF/YC0w9GI6KTZQ2d36y
03yMm3Anvc0VBj2jWJQymgVjZdW5Yc5j1JY9AlJjX2hjNA4fvWwl1fA0YdzGnHxT
T07cl29tsBBPQlo/1ZtfKaFpcLV8IGfTdokbGirMCse1vaXgF36s1tNFqwp+7Ond
TFk/AiM91zxDRiN4dUMvpuOmtMN6J6Npj0VZmKLk6RnZn3rbJPJFwarSUJVGYC0r
A1s2XFEJo8VX5Rb+Pkk7LlTHEG17joDoVm0yCyZQ7Hm/Lvi4JoWJ8tXFqRnlYVIM
XDWqlm1JQBOZDodV1zxkzK1+19YmGjmB42HmPhS1mchieVU2c50=
=QylG
-----END PGP SIGNATURE-----

--Cys7xdI4J5nU1kTN--
