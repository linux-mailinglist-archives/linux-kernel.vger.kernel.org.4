Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2827659C46
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 21:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235641AbiL3UmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 15:42:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235571AbiL3Ul4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 15:41:56 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B316DF6B;
        Fri, 30 Dec 2022 12:41:52 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id u9so53507357ejo.0;
        Fri, 30 Dec 2022 12:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=86PyXlSx5WkytdDAlxZ5GSQ+l6oxs1MnuvKlsCrh+9M=;
        b=h87Rvb404enElgERXfZMPxMoZrB5KqD1u02z4/gTM4413rL9TrmWIj4f7mEkk8MLtR
         l1fwSSXAkcXl0d6Zugv9vLO+sw9cfmkW8Pf5a+rr1ezn2Ah4i7MckbGejqsB8XOWiysd
         RaZsGcKoCKqiBmoIe0HboQKI7fDHdedUpbfojxYPqaG8xI15LCsT0/lrPkP6bZQSk6Lu
         3hhlj9TSgj7S16DvRTRv5JqrHQKofwhh5jqXyVv+QonYZ7usF014u15QcxfM+3xcT8nM
         H1q4PH4sZa8Dw4cDsUvM36tmzjyBSFoLhJmGC8XHwRHUMomswJweMe2MKTGaCQZQHVM6
         HDEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=86PyXlSx5WkytdDAlxZ5GSQ+l6oxs1MnuvKlsCrh+9M=;
        b=1848ZchN9ZshDGYV2hC24WRcD2EZb7x424ElvoTQLP3gtvbzNV2mk28siOX7Hj5rE6
         /MjcG8VXpSueVcXHUjYykR2nyRQbGKygE2R7wQHIqP4XXn+vLOgMxPnloGd3tKXo+D9f
         SvCJJ47L1ZQZno1EjlmsKohG6qJRr+yw6oIslIevvy91kqUpFsz1J6GtCTnj+45OpXoR
         ME0Xxyr/NgXwATbsngT0IHs6yO5MON2xr0+n+nUhHUpBaW9TCnAClLuT9Srzn/mRlCKc
         jtFQ8bAColxYlMUfP5eqHqkLWWT+hlY0QFEzkMGau7IABM+ZNgGFeBE731h1vb1wu8dl
         8wAg==
X-Gm-Message-State: AFqh2kpFc4qmbvT+sr6MspVXbCtfSfUF/YQPxwthBYS5DvmkK1+ArjND
        GORahRgW67R09YfXFavODzPA3AP7LLLtGg==
X-Google-Smtp-Source: AMrXdXtNMroc0OK8FqmhkdN4N1DU1jgDPDEaOAr48xUA8CZ2ByhHMnBwnMSidMv1W2zQo0nZTbNebg==
X-Received: by 2002:a17:906:2349:b0:7c1:65f7:18d8 with SMTP id m9-20020a170906234900b007c165f718d8mr26755992eja.60.1672432910345;
        Fri, 30 Dec 2022 12:41:50 -0800 (PST)
Received: from giga-mm.home ([2a02:1210:8629:800:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id a15-20020a170906368f00b007a9c3831409sm9996070ejc.137.2022.12.30.12.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 12:41:49 -0800 (PST)
Message-ID: <2c25f7d8882da98f2acaa1cc26f4f2de84eef1cd.camel@gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: adc: ep93xx: Add
 cirrus,ep9301-adc description
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date:   Fri, 30 Dec 2022 21:41:48 +0100
In-Reply-To: <20221230180809.051fc6bd@jic23-huawei>
References: <20221223162636.6488-1-alexander.sverdlin@gmail.com>
         <20221230180809.051fc6bd@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On Fri, 2022-12-30 at 18:08 +0000, Jonathan Cameron wrote:
> On Fri, 23 Dec 2022 17:26:35 +0100
> Alexander Sverdlin <alexander.sverdlin@gmail.com> wrote:
>=20
> > Add device tree bindings for Cirrus Logic EP9301/EP9302 internal SoCs' =
ADC
> > block.
> >=20
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
>=20
> Applied to the togreg branch of iio.git and pushed out as testing.

Thanks!

> Whilst we are looking at this driver, Alexander, would you mind if we rel=
axed
> the Kconfig dependencies to:
>=20
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 46c4fc2fc534..fd1d68dce507 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -441,7 +441,7 @@ config ENVELOPE_DETECTOR
> =C2=A0
> =C2=A0config EP93XX_ADC
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tristate "Cirrus Logic EP93XX =
ADC driver"
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on ARCH_EP93XX
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on ARCH_EP93XX || COMPILE_T=
EST
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 help
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Driver for the ADC=
 module on the EP93XX series of SoC from Cirrus Logic.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 It's recommended t=
o switch on CONFIG_HIGH_RES_TIMERS option, in this
>=20
> I end up doing that locally to build test patches like this one and it do=
esn't
> seem to cause any problems.

Sure, it's fine with me!

--=20
Alexander Sverdlin.

