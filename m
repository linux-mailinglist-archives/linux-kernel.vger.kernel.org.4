Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251537150A6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 22:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjE2Ulq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 16:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjE2Ulo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 16:41:44 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DEACC7;
        Mon, 29 May 2023 13:41:43 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-96f5d651170so944664466b.1;
        Mon, 29 May 2023 13:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1685392902; x=1687984902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8oVcB/3PU414dGGRa5XjMeY+ZP+wNwSmSLVI+C8Yxe4=;
        b=PsknnEmvP6wS6LwIMVDy541+2wS44WvjbYe8sUGBsjtPB9+YTtBJz367oliJzlKecq
         qq6231HCLJTLj5nXN7fGd4BWOsHorvyobp7shFhPwPsO/X1v6WX+jhZ1Zx3b5XSeWlKz
         FtjUUGlRv8XvuCVIBp62tiplKIsWU8zw/sjzgwccg8RbwYXchQqbZGutTshzbkXFzBrO
         UaXGTDhcQaNqtDwwipJW16ynLAc+dC11VAadqHBTasMdwF0fu8ZK9JWgatpex387mveG
         p9HMIWBB+Sj9NTztwj4F/DX/JGAwW90aChATDjGIY6lziSA71oD4hID+EFJFCvEVbS7t
         6fPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685392902; x=1687984902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8oVcB/3PU414dGGRa5XjMeY+ZP+wNwSmSLVI+C8Yxe4=;
        b=PiH7aS7/1PbLgp6dQfSq3MQFsscO07dSp4vmOFnvIa7UBNEIiymkj4Oe2ZbZWrAQJq
         byTb0AIHnzaYwueLemlt+FjVjRKKITtT03TJG7Vrh5CX0cXdFT6og+4IgzQD2ajUTrHB
         hTKGB6glaV/MgrwCkS3VXLPaaSm80HVZShQH2Y3uxXg0uF0xNpiW7GpCiBwRadRdqSlK
         XhwCFrX/K/m8u56U8rkKQ8xGb0+c09m7SAUEYkru81jWvRZjbAJBNon9YH00OIEZCKQj
         T/f1Rnxz39JOaXd1K7H4pcmbkn7YvziAxksIpm1RimY0vzvgXMbTzNcYWSNuksBkWDkj
         ihYQ==
X-Gm-Message-State: AC+VfDxSLKHDygGOO3B7+cOjeCwaCH6LIrZ2IkhCc5/ERHLYeApBCKE9
        CuT6eUCPaEMgbgojMKqtGcSp0IEfuCCUVWaoZ88=
X-Google-Smtp-Source: ACHHUZ6207AD0hmd3Pf2Y01WBOzBdWrg6plD6e1TcvbdQOjjEPdECzGbZUSsxNqCyt2hVYSrZgH15bzo3/Efr3x0vzo=
X-Received: by 2002:a17:907:868e:b0:96f:8afc:b310 with SMTP id
 qa14-20020a170907868e00b0096f8afcb310mr238082ejc.3.1685392901963; Mon, 29 May
 2023 13:41:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230515210545.2100161-1-gnstark@sberdevices.ru>
 <CAFBinCCc+t7Ks6fqz38cVrufPRFdxFgC9Qp+JhcM1KfD6pupTg@mail.gmail.com>
 <a52335ea-6545-8ca6-d318-38b7ffc64368@lexina.in> <CAFBinCDmkGnD5o_rV6K73De2XmHDxRYveDwNAy3iA+Kwr5sdqg@mail.gmail.com>
 <6910550a-b025-0d97-0b39-bc89b235541e@sberdevices.ru>
In-Reply-To: <6910550a-b025-0d97-0b39-bc89b235541e@sberdevices.ru>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 29 May 2023 22:41:31 +0200
Message-ID: <CAFBinCCk6OziOxt2AY1A25C=9_pibhHsDK0wJNZ_AyHMd=z6SQ@mail.gmail.com>
Subject: Re: [PATCH v1] meson saradc: fix clock divider mask length
To:     =?UTF-8?B?0KHRgtCw0YDQuiDQk9C10L7RgNCz0LjQuSDQndC40LrQvtC70LDQtdCy0LjRhw==?= 
        <GNStark@sberdevices.ru>
Cc:     "jic23@kernel.org" <jic23@kernel.org>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "jbrunet@baylibre.com" <jbrunet@baylibre.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "nuno.sa@analog.com" <nuno.sa@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>, Vyacheslav <adeep@lexina.in>
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

Hi George,

On Mon, May 22, 2023 at 5:47=E2=80=AFPM =D0=A1=D1=82=D0=B0=D1=80=D0=BA =D0=
=93=D0=B5=D0=BE=D1=80=D0=B3=D0=B8=D0=B9 =D0=9D=D0=B8=D0=BA=D0=BE=D0=BB=D0=
=B0=D0=B5=D0=B2=D0=B8=D1=87
<GNStark@sberdevices.ru> wrote:
>
> Hello Martin
>
> Actually you were right that my patch affects only meson8 family not the =
all new ones, my bad.
> It's clear from the driver code meson_saradc.c and dts files.
> I've made an experiment on a113l soc - changingclock_rate inmeson_sar_adc=
_param and measuring adc channel many times
> and with low clockfrequency (priv->adc_clk) time of measurementis high
> and vice versa. ADC_CLK_DIV field in SAR_ADC_REG3 is always zero.
Thanks for sharing your findings!

> I need to get s805 (meson8) board for example and made experiment on it.
If you don't find any Meson8 (S802)/Meson8b (S805) or Meson8m2 (S812)
board then please provide the code that you used for your experiment
as a patch so I can give it a try on my Odroid-C1 (Meson8b).


Best regards,
Martin
