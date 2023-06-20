Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4741A737023
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 17:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbjFTPQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 11:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233766AbjFTPQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 11:16:29 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD4A2682;
        Tue, 20 Jun 2023 08:15:56 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-986d8332f50so570923066b.0;
        Tue, 20 Jun 2023 08:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687274154; x=1689866154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R4Kq1I196iP4lZi3ISIkw776HYiqmA+o0cxAPhM15Go=;
        b=b8dwpCP5mTlZb2Z5quNWb3Xk5Lb4ZFqB56ArCu4H35U6JqtjYedTgL9chdCMHSYZgT
         1cOUe+09GickZtnE0JA7ELRNQsKty8aZXLrjitNkJBH8tMzh2qxd9PY1qObnUYZhP4hv
         cjnoHlNuRlXay9XPug0Mmd7HTG1xcFj3dFry+hS8F/rQNPNBbrO5euKut+YLlxX0vzO8
         FmtWqzi+JEx6UTPF/wrO6qxiwn/uJT7PBY0GCQ+Mw9EUm92a6vRHUaGusjQDQf7kv0N2
         4vZwWStZk0JOu15qU1oKo4JAaPPr9RMeKqw+rQA/V8/kJtnK9kquseputV+RIQjYjcf+
         Zx+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687274154; x=1689866154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R4Kq1I196iP4lZi3ISIkw776HYiqmA+o0cxAPhM15Go=;
        b=TFv+AVR2yL3SqRB5oQFWQcf099vcg5TxkruZJ/4uHUIAOPNxF2C7fifAb3LoNSZCPO
         yt1LQ/4A7ma9lxrBoqiRNNzP1lhj8nPC0qeoAiJx+pIkT43hl94Q2k4ONb5Xco5JuIX8
         DgOrYnEvl/yxRjfj+opoHs9MXJ/SCPuk14tlDXeFq8ikY0N8aJvd6kxEPBJBI1QcR4vh
         TKXWk+5r62uMyh8Zq+zLo7bvFBL9U0/YMUKc34QvVwphRXjWlLeXbQ1ffjbFvb6x61yQ
         HWJO/3G295hwcIIpChYQ79cQNweJcRai8jLwnXi50qglVtz6W1TdLPo1Ff3m/+xfP8BV
         CIkg==
X-Gm-Message-State: AC+VfDwz3Zr8L1b5W2ZOFyT9XI0InqtiEW8xC+s2+BlTcMKP5xgmK6HF
        s5d5ufoUEdW2/sOZamLQqtxA44UldnbX0lHaZ5o=
X-Google-Smtp-Source: ACHHUZ7zVdF44u8WGxoDTuzM5o+pFRLnIIzjKMLxgEqG+GT0G40mJh40pf2CGhYMPzoAUr39Z4dHXjP3Iu+npMaXu8M=
X-Received: by 2002:a17:907:9812:b0:96a:1c2a:5a38 with SMTP id
 ji18-20020a170907981200b0096a1c2a5a38mr11776524ejc.11.1687274154360; Tue, 20
 Jun 2023 08:15:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230620132641.256307-1-kimseer.paller@analog.com> <20230620132641.256307-2-kimseer.paller@analog.com>
In-Reply-To: <20230620132641.256307-2-kimseer.paller@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 20 Jun 2023 18:15:17 +0300
Message-ID: <CAHp75VdR9W8U9VmP5WZntzB9qW3fM6qy1Q2-yeBSAG5PJimkaw@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] iio: adc: max14001: New driver
To:     Kim Seer Paller <kimseer.paller@analog.com>
Cc:     jic23@kernel.org, lars@metafoo.de, lgirdwood@gmail.com,
        broonie@kernel.org, Michael.Hennerich@analog.com, robh@kernel.org,
        krzysztof.kozlowski@linaro.org, conor+dt@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
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

On Tue, Jun 20, 2023 at 4:27=E2=80=AFPM Kim Seer Paller
<kimseer.paller@analog.com> wrote:
>
> The MAX14001 is configurable, isolated 10-bit ADCs for multi-range
> binary inputs.

...

> +       /*
> +        * Align received data from the receive buffer, reversing and reo=
rdering
> +        * it to match the expected MSB-first format.
> +        */
> +       *data =3D (__force u16)(be16_to_cpu(bitrev16(st->spi_rx_buffer)))=
 &
> +                                                       MAX14001_DATA_MAS=
K;

Using __force in the C files is somehow stinky.

...

> +       /*
> +        * Convert transmit buffer to big-endian format and reverse trans=
mit
> +        * buffer to align with the LSB-first input on SDI port.
> +        */
> +       st->spi_tx_buffer =3D (__force u16)(cpu_to_be16(bitrev16(

You have a different type of spi_tx_buffer than u16, don't you?

> +                               FIELD_PREP(MAX14001_ADDR_MASK, reg_addr) =
|
> +                               FIELD_PREP(MAX14001_SET_WRITE_BIT, 1) |
> +                               FIELD_PREP(MAX14001_DATA_MASK, data))));

...

> +       vref =3D devm_regulator_get_optional(dev, "vref");
> +       if (IS_ERR(vref)) {
> +               if (PTR_ERR(vref) !=3D -ENODEV)
> +                       return dev_err_probe(dev, PTR_ERR(vref),
> +                                            "Failed to get vref regulato=
r");
> +
> +               /* internal reference */
> +               st->vref_mv =3D 1250;
> +       } else {
> +               ret =3D regulator_enable(vref);
> +               if (ret)
> +                       return dev_err_probe(dev, ret,
> +                                       "Failed to enable vref regulators=
\n");
> +
> +               ret =3D devm_add_action_or_reset(dev, max14001_regulator_=
disable,
> +                                              vref);
> +               if (ret)
> +                       return ret;
> +
> +               ret =3D regulator_get_voltage(vref);
> +               if (ret < 0)
> +                       return dev_err_probe(dev, ret,
> +                                            "Failed to get vref\n");
> +
> +               st->vref_mv =3D ret / 1000;
> +
> +               /* select external voltage reference source for the ADC *=
/
> +               ret =3D max14001_reg_update(st, MAX14001_CFG,
> +                                         MAX14001_CFG_EXRF, 1);
> +               if (ret < 0)
> +                       return ret;
> +       }

Now, looking at this code I'm wondering if we may have something like
devm_regulator_get_enable_and_voltage_optional()

But it's another story.


--=20
With Best Regards,
Andy Shevchenko
