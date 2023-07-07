Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E481F74B14B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 14:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjGGMtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 08:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjGGMtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 08:49:41 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F2010EA;
        Fri,  7 Jul 2023 05:49:39 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fbd33a57dcso20291135e9.0;
        Fri, 07 Jul 2023 05:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688734178; x=1691326178;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Va3gTS2j0Ri+TaCki30Zs9STlYulxibMuwQWnYz8AS4=;
        b=hNgASXwoUU0YrmeQ5XA5ZVoVAPOUSHVsK0wt1UcYJlvur2vB/rG19e5gAntydXnkZO
         w3uusptZWvnhBOL4ybghY12Oab3HcG/4SA9892eBpaNbOf2Uq/8hkq5AODWmtqb5/Gfh
         D6DHk6FiWJ8LDACtqVemFfXqnmIjbNhZp/9QhsOnzQzg+RYtfgXihUg3kl1GlT09PXXi
         o4fdkgdllMy58VTZhsp5BuaTJMaNXZgpkQv+i7DcvxBNWyX8F4GNyWDYECKhcmlrIsxy
         1os01q/SiBxRb/SeTWXVM4IVXxmz3Zt2Rk/j+i4+Qi/jlTikn087lt88J8cjrctuWwLf
         6FOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688734178; x=1691326178;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Va3gTS2j0Ri+TaCki30Zs9STlYulxibMuwQWnYz8AS4=;
        b=k0EzlvxNsDvEIOYUJzv27Q0vRJEfQwNfFrxKXIMWUamF58hQeOh1uh+brg/MbIXRyz
         nY3TiQy7FZgi+T0Ipnmvt/p55ZLkhNt8z3jM84tvZyilxS9IZu+JHA0vrriRnzk+kRX0
         aQ2MZacs78+J0az/0U1migJmMPPRqSaZoQeXc8IpZhJTPemeCX/bLBS2RVP+gHe7yR38
         ijFIjb93NQ1QQKA+7d1WM6bMizVBt3TdJLIoZOyQvMcikoa02kvql8rwv/Sf/+Xj+KKA
         3r/KcNfCdOwtVdJdPdRBTnCBZxMF+J+oL6vT4XfWo91npPUSXf+bfR1dbJUl4TVhNEE6
         NENQ==
X-Gm-Message-State: ABy/qLa706Cn9O0GwwgVblGXdYInrM1Q0hyO+p8u4gW3LpkTN9eev95J
        rDJg2RWyu/WaCqueJo+GRbo=
X-Google-Smtp-Source: APBJJlFX5h/5Cp1ugMLiBnfzudJYd7a8Zbtz+ODTURxKx98aOWLCXSASNUlxrzpC+NPK6uiltearNQ==
X-Received: by 2002:a7b:c445:0:b0:3fb:a46c:7eac with SMTP id l5-20020a7bc445000000b003fba46c7eacmr3684828wmi.7.1688734178223;
        Fri, 07 Jul 2023 05:49:38 -0700 (PDT)
Received: from orome (p200300e41f4b7100f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4b:7100:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id l20-20020a7bc354000000b003fbb8c7c799sm2387690wmj.30.2023.07.07.05.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 05:49:37 -0700 (PDT)
Date:   Fri, 7 Jul 2023 14:49:36 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Damien Le Moal <dlemoal@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-ide@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/11] ata: ahci_tegra: Convert to
 devm_platform_ioremap_resource()
Message-ID: <ZKgJ4E9X_KcHj1WM@orome>
References: <20230707095513.64224-1-frank.li@vivo.com>
 <20230707095513.64224-4-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2ty/DDzd14/803Q9"
Content-Disposition: inline
In-Reply-To: <20230707095513.64224-4-frank.li@vivo.com>
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


--2ty/DDzd14/803Q9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 07, 2023 at 05:55:06PM +0800, Yangtao Li wrote:
> Use devm_platform_ioremap_resource() to simplify code.
>=20
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  drivers/ata/ahci_tegra.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--2ty/DDzd14/803Q9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmSoCd0ACgkQ3SOs138+
s6F66w/9Gx7wEbknyiiEmjGQohgnzFz9QdkY7uOPg/m+rSDytZXQto94H0Ym9TlA
BxMSXlQvsmU0hgzamJUXcRvHp/TXUwiMTT1PFVROSk2HRRQfi49Na7KYCntkvUqt
uJe97GNSZN1WXwpaDKYNCOcgOHycL5lenJEb5jrVbSfnn73DfzCWrhjaLdl/gt3V
+D7/LsVKr9BfJzMJtF6IMl98pn8gGMpL3gbwZV/B9ckDmXwOuEbC7FL21//Xf7bF
6Osh9sZ1AeN2Ijyz+8XKvEK+c0+dZNX0Dcua2+A4X6yZ4zHlYFIxmOpviEP329Sv
zXLv954ru3RyCawTfERFjTFKrd1+XMbhXm3AzHsEXF3bdVRyAft1W0hZ96WRB5HV
xvxDZM2V2sFuZ0T/+fpnpjmvxpF/z5enMTEfKPdbzGrWZy5VNABxhN6SebnLXwJ1
OAbCAOCxfjS+oK2tyJMfCZY2Pff7KUlO3xTisGQdSljMa/c4p5Wa6sOWLvqIJs8c
zvsrQz8epuYiKM1pqK3vGhAOg0EFtp09qe2FXpTXuCR8t09CsDmb6mQHQl87MEXc
NGoreuG1xUIOxNDH4FWEXWieevX980qS89eVsEDbscqeQB4q7qRiyxOBAiWibvBn
UYtSqnWfirCYfCgGzfjVA1Tg9APfeoqSDnU1mBkLHPBUlAWhWEs=
=zriF
-----END PGP SIGNATURE-----

--2ty/DDzd14/803Q9--
