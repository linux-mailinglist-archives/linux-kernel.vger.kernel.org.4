Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6E35EDE58
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 15:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbiI1N7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 09:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiI1N7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 09:59:49 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA65FD03;
        Wed, 28 Sep 2022 06:59:45 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id b2so4443084eja.6;
        Wed, 28 Sep 2022 06:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=lpfVHj+RDccjHYGjeoqa72Pm48ZvPePtdQJtt8JQZXk=;
        b=k7Zv4LgRiDjyJBlii7p5vFZBJyFH+e44eYv5nzGTZE46tV5K3r7cHb+eBBoBvLO3lK
         pl2jh6Ov24srBnGirRzzHwQlgFfyJSVa+OQ0F9nGec98lPOmtgD1O7qeGanfpiiadoG0
         RYULKpM25+w14uMV1IBmh1BmpIWMDlSM7d5RCPMlt5qWGKCDYyFABRFFit8l4ocl3J8e
         hihBXWhJriR0F7OpOeJT0VEO2PCGZr4FEGC+6E10GyX2uKwNwJdxiaL1kVQVL4DKaF9B
         1fWkXvfqgaEhdqQS8fKhxfyF1n7qw0czLzsxTXDQe7B9HIkvxyEJ1OTM4V1nJME+fcAQ
         MHcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=lpfVHj+RDccjHYGjeoqa72Pm48ZvPePtdQJtt8JQZXk=;
        b=7xifiPrX1Fo9afq5AFGPU9xyjjQ1V5EBomFa1NGnzn4cP6JCnsUA2kI5vG58qPB+2/
         pPLKFwdkbWTT3YpjfpOzelIfQDX1NnSdEWEMGSp2H/P6RltUoogdaNCKD4VxB9KPIgza
         eb6mRwLHpUE/dASQlMBozjGi2AuzJh7wk+XPcutbkGv30ZbuqolAjDqjyhNSo4tp55G3
         mf0JwBXZy3gttYhOL2b15WXOseJcf6WVmc5hx2K79EhsDUk636XoumeyIdOOti8Zafrj
         NmjO/9ozDRH63x/i34n5fN6Kq1DP3CZtG6P4AfuXQTuXit/ioec8Ocp8oS4RLs7UyC5o
         YMYg==
X-Gm-Message-State: ACrzQf3GQHvjekViHxqrQpyyajfD36EPWpslI1nMn3bfk2geaC8uSz4B
        ZgxRLnnsX7x4OXLTHS28D3A=
X-Google-Smtp-Source: AMsMyM5hBOvEKEWpHZgz3huI7BLk3tHM3vkbt2WoWDY6DRqLKZ5Fj/SdI+SaNpg7MlhI7XgiNtj4uw==
X-Received: by 2002:a17:907:a04e:b0:770:79f4:f520 with SMTP id gz14-20020a170907a04e00b0077079f4f520mr27033245ejc.730.1664373583736;
        Wed, 28 Sep 2022 06:59:43 -0700 (PDT)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id cm17-20020a0564020c9100b0044838efb8f8sm3387858edb.25.2022.09.28.06.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 06:59:42 -0700 (PDT)
Date:   Wed, 28 Sep 2022 15:59:40 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     xinlei.lee@mediatek.com
Cc:     u.kleine-koenig@pengutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        jitao.shi@mediatek.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@list.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH,v2] dt-bindings: pwm: Add compatible for Mediatek MT8188
Message-ID: <YzRTTGPAstQTnJdZ@orome>
References: <1663915394-30091-1-git-send-email-xinlei.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CmzLNmPwX482UbLD"
Content-Disposition: inline
In-Reply-To: <1663915394-30091-1-git-send-email-xinlei.lee@mediatek.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CmzLNmPwX482UbLD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 23, 2022 at 02:43:14PM +0800, xinlei.lee@mediatek.com wrote:
> From: xinlei lee <xinlei.lee@mediatek.com>
>=20
> Add dt-binding documentation of pwm for MediaTek MT8188 SoC.
>=20
> Signed-off-by: xinlei lee <xinlei.lee@mediatek.com>
> ---
>  Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

Thierry

--CmzLNmPwX482UbLD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmM0U0wACgkQ3SOs138+
s6EgCA/8Cln97n5y2+lTHYL2Vh12ctUxVaV7Fh2q63qXOofQ6M8htH+lKEC+g2fp
ijRlTNFATbA5KZOyJa2MAYHfcdx/hL4fwaEJitMBQoOiusTTAcv204BfC+ag1L+3
0CB3ayFrPF5mzEYqXvwq0vrQG2ohV86gDAF98O9kmHGMnqnzPEGMKcjz4m4bLGCA
3bWAlYlBVFRxptoLgc4sQFY4UgYm29JMxvq2QF+wHBC9zzzc0Cnl17bps6gaRzmD
HSojW19WJn0SJMzRNbZJE0AwX6lHmIQMO6cC2medls2UTiuWPneQDFsF9OdOw9Id
n9e3gH2NJk4bRl8rrUDy2XnN6YmQM3iYkx7qQjzGaIyaUP9Z9xT5HkXD+atHrQHA
aK98/D8DrfgM3lUor/3zE6OHdM/aU/pkUNEecWs7gURoQnlgIuwBADi81KZq0JHk
mG4Dlp1ElDofdhhvqd0o1MZ7H7cRqQKj9iaceY5Z+1n/xo8L8W65jdwdKP7hry3J
N3WMwlbHC/V/817fNNoEahE4MbwzSUbR/Ogh72Ye9F1Qw4dJ88xKGT/b6nqNZCus
ZX3W7Ay1pg1jVz/8S9/OnkBmPM+XMDVzga82JuaGZ5Obl7Pqyr4IWgiJX6MTyaCA
ILG4DBs/H4f6wlIYdek77xYg4Cb3KY3SCM43u8ucYTKW0/+MJHc=
=ojFY
-----END PGP SIGNATURE-----

--CmzLNmPwX482UbLD--
