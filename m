Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E0A6F52B6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 10:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjECIIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 04:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjECIHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 04:07:50 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A5C4C11;
        Wed,  3 May 2023 01:07:30 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-50bc570b4a3so6332227a12.1;
        Wed, 03 May 2023 01:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683101236; x=1685693236;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=09OiAlmJHnxmXTt7scQ4FafxCqw8R8tFLy6fwfABkDs=;
        b=a4QTso0ArgQ3u05yRNy24SFFh5JR6CX+AZhS7A2Mo90hg0Yt/I8Hqzkik5eJlomllG
         tE08dLUwl2TN7edHXrMDZGeKevSF6V5rI+zpAsY7nGXcXGCsdPqsTFBGq/pHS71CX3Wr
         pUdKF1soOSSd7M5pekgpWxD6vjHyLYOxWNSkYqWtMwwlraBgTedEcIBx4MFr2d3bdnlL
         WIgPc+FFgdvPNdOTwr3Yj30UQx5G/dSqUAiyVIhJv4i3Q5+vvOyk4+Wr+yt1zHeBTRCz
         NS9sjWFUZMlguHYkAQa8BseUWYhmbHfERlLnyJwb8hVJF4s1ShvYLRKZL6jhTeWZJBGH
         pIUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683101236; x=1685693236;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=09OiAlmJHnxmXTt7scQ4FafxCqw8R8tFLy6fwfABkDs=;
        b=SoTr8+TLv4+HkPFhv2XkM7Ewv937C+hp8VqbQCKqLAadziAcukeYuOQDNv5k/2RTS8
         cnbGqZe9hTR0QwAq9a1NKuSFmvl317L4NComKILs87tIoWp6r5lba6WPCO6RYc0mPPID
         hiNSRggyA30/6h+VvcQ2twe4gOqxVTnR8LpBgsSf04HfkpewfHKE4ZKfK2dTVfpA66wW
         3h5a69wOWmw8iIkb2Ow2iwynqY1NFWAXm9ZdwzVvbP7nu//Sz82psVCQluHwb7UN9ceq
         NHzZDLQDTwC+Q+wrhLi4smwAJSiO7PtOZF3B8QlNvIjDTH0KHVSRBEMLfVuBWU2MdtH7
         9Sbg==
X-Gm-Message-State: AC+VfDyLsk9HCxQjBl1MgpN/3gkQg7yn3HLG/29KypdqWkcWM1F1FYLN
        /2Lfhg4wVpw3tvzgjaCULeY=
X-Google-Smtp-Source: ACHHUZ4Xf3p4gBRyPUJk6wwm+xAC7Wgq2nUNZz7BOZQoCWwUwEZGxxkwTISwBqfZtk9Nvl6qwekpsg==
X-Received: by 2002:a17:907:7d94:b0:962:582d:89c3 with SMTP id oz20-20020a1709077d9400b00962582d89c3mr2337568ejc.22.1683101236185;
        Wed, 03 May 2023 01:07:16 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef05:8700:c599:e44a:8287:c91c? (p200300f6ef058700c599e44a8287c91c.dip0.t-ipconnect.de. [2003:f6:ef05:8700:c599:e44a:8287:c91c])
        by smtp.gmail.com with ESMTPSA id jx14-20020a170907760e00b009655eb8be26sm430265ejc.73.2023.05.03.01.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 01:07:15 -0700 (PDT)
Message-ID: <f83adfd4df5cd23176721087a4fcd9a0225c3483.camel@gmail.com>
Subject: Re: [PATCH v4] Fix IRQ issue by setting IRQ_DISABLE_UNLAZY flag
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Masahiro Honda <honda@mechatrax.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 03 May 2023 10:09:28 +0200
In-Reply-To: <20230502102930.773-1-honda@mechatrax.com>
References: <20230502102930.773-1-honda@mechatrax.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-05-02 at 19:29 +0900, Masahiro Honda wrote:
> The Sigma-Delta ADCs supported by this driver can use SDO as an interrupt
> line to indicate the completion of a conversion. However, some devices
> cannot properly detect the completion of a conversion by an interrupt.
> This is for the reason mentioned in the following commit.
>=20
> commit e9849777d0e2 ("genirq: Add flag to force mask in
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 disable_irq[_nosync]=
()")
>=20
> A read operation is performed by an extra interrupt before the completion
> of a conversion. This patch fixes the issue by setting IRQ_DISABLE_UNLAZY
> flag.
>=20
> Signed-off-by: Masahiro Honda <honda@mechatrax.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> v4:
> =C2=A0- Remove the callback.
> v3:
> https://lore.kernel.org/linux-iio/20230420102316.757-1-honda@mechatrax.co=
m/
> =C2=A0- Remove the Kconfig option.
> v2:
> https://lore.kernel.org/linux-iio/20230414102744.150-1-honda@mechatrax.co=
m/
> =C2=A0- Rework commit message.
> =C2=A0- Add a new entry in the Kconfig.
> =C2=A0- Call irq_clear_status_flags(irq, IRQ_DISABLE_UNLAZY) when freeing=
 the IRQ.
> v1:
> https://lore.kernel.org/linux-iio/20230306044737.862-1-honda@mechatrax.co=
m/
>=20
> =C2=A0drivers/iio/adc/ad_sigma_delta.c | 4 ++++
> =C2=A01 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/iio/adc/ad_sigma_delta.c
> b/drivers/iio/adc/ad_sigma_delta.c
> index d8570f6207..7e21928707 100644
> --- a/drivers/iio/adc/ad_sigma_delta.c
> +++ b/drivers/iio/adc/ad_sigma_delta.c
> @@ -584,6 +584,10 @@ static int devm_ad_sd_probe_trigger(struct device *d=
ev,
> struct iio_dev *indio_de
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0init_completion(&sigma_de=
lta->completion);
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sigma_delta->irq_dis =3D =
true;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* the IRQ core clears IRQ_DIS=
ABLE_UNLAZY flag when freeing an IRQ */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0irq_set_status_flags(sigma_del=
ta->spi->irq, IRQ_DISABLE_UNLAZY);
> +
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D devm_request_irq(=
dev, sigma_delta->spi->irq,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ad_sd_data_rdy_trig_poll,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sigma_delta->info->irq_flags | IRQF_NO_AU=
TOEN,

