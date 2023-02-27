Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192296A4590
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 16:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjB0PGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 10:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjB0PGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 10:06:33 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747B622010;
        Mon, 27 Feb 2023 07:06:27 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id l25so6580392wrb.3;
        Mon, 27 Feb 2023 07:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YPvzl5AQcLke1QfhjznfZBkz9Qxeo9m3sAaerkELoHk=;
        b=DxfGrXQf5uucvaH/jk4OeIZlgdP6Y2S24+bFg4IJUCklraz7RrSwfK0fV9GxL6dfAa
         81PJaQW14FAkKGJPmWc3FMqteWpCtoYL9PAAHaJYjMm2lPBBGj4pQwoE69ZcHilgCpdS
         51XjGgTfvsBoTbcgVA77H6VIaRq33mvjwaNBRZluDXfJByNDAn3kSlO8fC4cgbNMt2Dz
         flzMPQAhEQLty2thW4Bz3USDJOVLY3Ya0oJV4R0Q6PX2yNjwywer4FUteHsKFBnN0z5b
         ku6Xh2wywy+6DGA8cS9/AcRVNIC32hKFdKeETCCekovicipBHFy9lVrRW17YsduGDRl1
         HbKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YPvzl5AQcLke1QfhjznfZBkz9Qxeo9m3sAaerkELoHk=;
        b=Yflr3Av2ag0wkaXY0dgweuKAI4+SfS6VPOZxpuh9mM2I/DIl+HwNPaozoHdYbxSp6L
         xA1qo5+bUP6twBz0ax3sJ0loln3o73WCSkk783iIZ5nqL2K4nRC1GE7Xg8YAUaXRs+vQ
         mXacPOS50jiyBHyu+KiKlrjxeyQ+wbJNsp/Zn3H/rRRLSquBKI1c5haa+5uCGv/hFirl
         h88sOrLAtMJGhab9ks3EcQsddmsBzTNaCoUztF7VGLePpYErvWdWBOv/pTrJeDeEaOlj
         J6yXKW7YOlZBfqtfFlU8HxExYRg6yc0ba1WmrU7kczscMgtaWYCWLvBVzJHz+gNQxrL6
         hdRQ==
X-Gm-Message-State: AO0yUKX/1HeNFTS5jpHFwxPpkn85HlguP0DehAJtmNX1EG8v8qa9zSt9
        FPBufjGGwM2S9tFQhbreHt/LQ6DVRm0=
X-Google-Smtp-Source: AK7set+QhiPGzqs7w6yfbUv09BRoz3Z0B9Ssu4dBhAxnmVgHXZdG7H+4oY2VVDWXKEJ3/CUIfETT+g==
X-Received: by 2002:a05:6000:38e:b0:2c5:4c9f:cf3b with SMTP id u14-20020a056000038e00b002c54c9fcf3bmr7433395wrf.7.1677510385852;
        Mon, 27 Feb 2023 07:06:25 -0800 (PST)
Received: from orome (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id m34-20020a05600c3b2200b003df5be8987esm14410840wms.20.2023.02.27.07.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 07:06:25 -0800 (PST)
Date:   Mon, 27 Feb 2023 16:06:23 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Any more work on "regulator: tps65090: Convert to json-schema"?
Message-ID: <Y/zG77uzHkyHBrhU@orome>
References: <e48669a4-8fd1-dc0b-1446-7fbe1266c32c@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KlVJJU4Pn9yv3mYm"
Content-Disposition: inline
In-Reply-To: <e48669a4-8fd1-dc0b-1446-7fbe1266c32c@linaro.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KlVJJU4Pn9yv3mYm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 25, 2023 at 04:14:09PM +0100, Krzysztof Kozlowski wrote:
> Hi Thierry,
>=20
> Long time ago you sent:
> https://lore.kernel.org/all/20211217170507.2843568-6-thierry.reding@gmail=
=2Ecom/
>=20
> Any plans to resubmit it?

It's in my bucket of things to circle back to eventually. I've got about
60 or so other conversions in various stages of review, but things have
been going slower than I expected.

I can upload a branch somewhere with what I have if you want to take a
stab at submitting those. I don't expect to get back to these within the
next two to three weeks.

Thierry

--KlVJJU4Pn9yv3mYm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmP8xu0ACgkQ3SOs138+
s6FppQ/8DDD5TbjVZkQdLBx7Xw2wxM4QQ8ejh9ekHyT9jW2MgiHM2yDnHLzkvOP/
AtmYp5s1+03Kv3a2pQmCGIkZYnCP30o9qkRB/wtH+F/aRDuZyvg65UlsgVMSK3sD
sbnDNkdC20t+30hNXU6ma5ygS4Wj612KAj1ZtElRiNAat1PqcEBQFhYIXOaXZFwL
yhJlDsfuv1MFrJxzquGhRpmlrqA7yxsJ10/H9WqF546bIk2Q1RCs6k+Q+6RW4Prl
CYJo9OqwmBc9oSmXXhGahCutP6jGzdplRr7WZoRK9r6FV0SRmEMQt5FYUVetTeA5
WI5TgYLO1MYZ1+zXaLpeq4T+MY0DPcRSFw26MQkD7PxZdPQ6/lH3y+0Qao1CoJW1
dzvenNvhPN0oLzmcP6h4V3Ml9fKOz3UMViLzVbFpd+sKoPrGEcsEt3XMV8GzLe86
XgekqKVvcjbZEkKh83X2JW9r1qlqIkPNCHknXUAssphxhnFhRGyFF79UVAhQTdxQ
jsRff1Qq3R8EFQeJDAOZFpkZxRDBppXx4hcylh8n/9R7U5OJUxJYNTysezlzsqi5
Y+Wm0Hd+gc5tMvD1GpdBMon9C2UQgSVTZB/V2WRfXUhsRj7TxnJbq9CxldFxV5LT
mH2rVmn6xkzeEFAy5J06oeGXaWMXRIWhZUbrTDIZtqM4MiHr6ZQ=
=F9ls
-----END PGP SIGNATURE-----

--KlVJJU4Pn9yv3mYm--
