Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA0172C8B8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 16:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237448AbjFLOhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 10:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233318AbjFLOhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 10:37:39 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E914CC5;
        Mon, 12 Jun 2023 07:37:37 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-6261a25e9b6so31675476d6.0;
        Mon, 12 Jun 2023 07:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686580657; x=1689172657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MmSsLFguTLJjtTHyvAvqjYdTmV32NSHTxBWlCv3zHog=;
        b=TDU4ml5ch6xZRnQ9VDKFueU/TLUi3rWBPsflKK6FSeqvLIYEecXz4u3zkxQ7AoTstz
         Shyv4Dbupw02KdavKgHB4oE+pEoPqnObV5pg6MxkRgzoGrGRX72UvhsjXD5Vu9dP9enz
         1vCF/QnSmAq48yAcYFnyQzQEjyL/vAULNGK26VkZXDFndIWcgpzORmgpO16JJ/Xfx+qc
         Knnr52TBoQjiU0QWHcFEEEIqSCrftgf3pycyVCDJSW899V2ManLnwg/Uym8Lh6ptcP3i
         zgXJLgKLXltamTjg5OK14C5jGfOF2WT3B/QBWET0aWs8PREt/z4q4/2/XgwiNU/6J3iX
         E1eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686580657; x=1689172657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MmSsLFguTLJjtTHyvAvqjYdTmV32NSHTxBWlCv3zHog=;
        b=JFGO4WYnK4JDYcIAAs3pRzWpz7nUP2IgC/0r4/xDqiBtukDHuz1tMzBJeW5WAmNICc
         u74Gn6a+vI99q3tO/1UYgFi13dhGWaZ7Wpyqmgpi0nV6oyQJM2685JK2NI9OyG4kzf/B
         o/ZQkAkfNyAp2bZXUY4s33DS6OZqpCPz8RwC84/95TovmOHn88okJgpguG5dgp9sBVUd
         49ex53hfDEaXrrGSvWSMVD4llU5BVuJBxKY9XnQHtkgmEPdE4oyvuFCDYzwEN3lTfrJ0
         eBVJLV5HnWcYuAaLZsCWxvAEMiIYLZLdAc8WEfPR0Y6hOWt4mXWN/Fq1IeMYaw5ePwso
         MipQ==
X-Gm-Message-State: AC+VfDy8ze0nR9zWwQcs4sJaveFV0hfmLZqnySJ++Yyv6AJawN4tYjlc
        zScRZuRp3wKIJ3ANhqcDodlzORYzh32MYC4Z5Ts=
X-Google-Smtp-Source: ACHHUZ7nS7ciyNOUxF5wEsTyHkkZkD4qaCOb8fp62HByN8hKzmuFZEHozZVENXt3UghG0BQYtizir1726/li13koNwQ=
X-Received: by 2002:a05:6214:f28:b0:625:aa1a:b6d9 with SMTP id
 iw8-20020a0562140f2800b00625aa1ab6d9mr10687001qvb.59.1686580656910; Mon, 12
 Jun 2023 07:37:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230612122926.107333-1-herve.codina@bootlin.com> <20230612122926.107333-12-herve.codina@bootlin.com>
In-Reply-To: <20230612122926.107333-12-herve.codina@bootlin.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 12 Jun 2023 17:37:00 +0300
Message-ID: <CAHp75Vfz+vSJ7rQ4sxb0R+zRbrjipXUX3VpaHyvOWWePdPxejQ@mail.gmail.com>
Subject: Re: [PATCH v3 11/12] ASoC: codecs: Add support for the generic IIO
 auxiliary devices
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 3:30=E2=80=AFPM Herve Codina <herve.codina@bootlin.=
com> wrote:
>
> Industrial I/O devices can be present in the audio path.
> These devices needs to be used as audio components in order to be fully
> integrated in the audio path.
>
> This support allows to consider these Industrial I/O devices as auxliary

auxiliary

> audio devices and allows to control them using mixer controls.

allows one to control?

...

> +#include <linux/iio/consumer.h>
> +#include <linux/minmax.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>

> +#include <sound/soc.h>
> +#include <linux/string_helpers.h>

Perhaps a bit of order? And maybe a blank line between linux/* and sound/*?

> +#include <sound/tlv.h>

...

> +       struct snd_kcontrol_new control =3D {0};

0 is not needed.

...

> +static int audio_iio_aux_add_dapms(struct snd_soc_component *component,
> +                                  struct audio_iio_aux_chan *chan)
> +{
> +       struct snd_soc_dapm_context *dapm =3D snd_soc_component_get_dapm(=
component);

> +       char *input_name =3D NULL;
> +       char *output_name =3D NULL;
> +       char *pga_name =3D NULL;

Now these assignments can be dropped.

> +       int ret;
> +
> +       input_name =3D kasprintf(GFP_KERNEL, "%s IN", chan->name);
> +       if (!input_name) {
> +               ret =3D -ENOMEM;
> +               goto out;
> +       }
> +       output_name =3D kasprintf(GFP_KERNEL, "%s OUT", chan->name);
> +       if (!output_name) {
> +               ret =3D -ENOMEM;
> +               goto out_free_input_name;
> +       }
> +       pga_name =3D kasprintf(GFP_KERNEL, "%s PGA", chan->name);
> +       if (!pga_name) {
> +               ret =3D -ENOMEM;
> +               goto out_free_output_name;
> +       }
> +
> +       widgets[0] =3D SND_SOC_DAPM_INPUT(input_name);
> +       widgets[1] =3D SND_SOC_DAPM_OUTPUT(output_name);
> +       widgets[2] =3D SND_SOC_DAPM_PGA(pga_name, SND_SOC_NOPM, 0, 0, NUL=
L, 0);
> +       ret =3D snd_soc_dapm_new_controls(dapm, widgets, 3);
> +       if (ret)
> +               goto out_free_pga_name;
> +
> +       routes[0].sink =3D pga_name;
> +       routes[0].control =3D NULL;
> +       routes[0].source =3D input_name;
> +       routes[1].sink =3D output_name;
> +       routes[1].control =3D NULL;
> +       routes[1].source =3D pga_name;
> +       ret =3D snd_soc_dapm_add_routes(dapm, routes, 2);
> +
> +       /* Allocated names are no more needed (duplicated in ASoC interna=
ls) */
> +
> +out_free_pga_name:
> +       kfree(pga_name);
> +out_free_output_name:
> +       kfree(output_name);
> +out_free_input_name:
> +       kfree(input_name);

> +out:

Seems redundant label, you can return directly.

> +       return ret;
> +}

...

With

  struct device *dev =3D &pdev->dev;

> +       iio_aux =3D devm_kzalloc(&pdev->dev, sizeof(*iio_aux), GFP_KERNEL=
);
> +       if (!iio_aux)
> +               return -ENOMEM;

You can make this kind of call neater.

...

> +       iio_aux->dev =3D &pdev->dev;
> +
> +       count =3D device_property_string_array_count(iio_aux->dev, "io-ch=
annel-names");

It's not recommended to switch over inside one function to a new
pointer even if they are the same. With dev here as a parameters it's
much easier to understand where the property is taken from.

> +       if (count < 0)
> +               return dev_err_probe(iio_aux->dev, count, "failed to coun=
t io-channel-names\n");

Ditto. And for the rest.

...

> +       iio_aux->chans =3D devm_kmalloc_array(iio_aux->dev, iio_aux->num_=
chans,

Esp. in this case, it will add confusion, because we have been having
the object lifetime issues with devm_*() APIs from the past and
then...

> +                                           sizeof(*iio_aux->chans), GFP_=
KERNEL);
> +       if (!iio_aux->chans)
> +               return -ENOMEM;

...

> +       /*
> +        * snd-control-invert-range is optional and can contain fewer ite=
ms
> +        * than the number of channel. Unset values default to 0.

channels

> +        */
> +       count =3D device_property_count_u32(iio_aux->dev, "snd-control-in=
vert-range");
> +       if (count > 0) {
> +               count =3D min_t(unsigned int, count, iio_aux->num_chans);
> +               device_property_read_u32_array(iio_aux->dev, "snd-control=
-invert-range",
> +                                              invert_ranges, count);

Probably good to check an error, while it might be almost a dead code.
If something happens during this we will at least know.

> +       }

--=20
With Best Regards,
Andy Shevchenko
