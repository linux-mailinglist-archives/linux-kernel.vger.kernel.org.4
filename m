Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCA074636C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 21:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjGCTjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 15:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjGCTjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 15:39:32 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC18DEA;
        Mon,  3 Jul 2023 12:39:31 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-991ef0b464cso869451466b.0;
        Mon, 03 Jul 2023 12:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1688413170; x=1691005170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xdjkuxl/GUliSxC/S2QPSFDglKe6XiR3aOWV0ZWOlb4=;
        b=g1kyzjevyoXXKeHjjlgynN3FOG9+O0T0TtBhpgTF1z6GxBZOUGwbfQOX2RFqHweX8B
         aeY5lBPpLNLzKCAV100DRAted5wVzer8ri5wT9V32+tuEJbMjlZEZbuFGbf1cDB2oADB
         d6vFoGhAOFQxVoTRBzvUAOZdtcTCyxkwN5neyVe0k/ufmse8ItCUPqs0f6dH71z/ZNQ4
         OjaQFhoZ4YivRxGapsHn28mjnFVLqZ37JrvvSnvjrf9Szi2HC13o6Qm/zmjhMA627Hhv
         ikGlFsDMEIlELhcKJ4SfVL4GDVp9jQ1FHjV492al4CtsssLMPPaIzgbwzkJQIUls0Naz
         63JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688413170; x=1691005170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xdjkuxl/GUliSxC/S2QPSFDglKe6XiR3aOWV0ZWOlb4=;
        b=cVWTOCEL1FcrR38LyHSBD/Gs6Byf7aHoZCAbpojEHFCUIu4js5edgwoHh2A4NROaQt
         A/bOZzm7UesYtVizdGQFAFTH1RKOJbgLKtXkitJ+2WS0cv6mRWLrTd2Sf5iJi11GLSaY
         lOTowah3JpltpEG+v/jQ5yM6uZSydBmNlpghZ8zMJSL2HWZmG2AmPO5HXK/keq+f8evp
         3Xk8micVWreQ7jesU5Uo4Xi/Lk7Qm2O1sFjVXtHUn0d1+rFwNUrc+voRyh6auVyF9bNy
         Dcg8Nb7T0kkwIulRS6X7UHjKB9crAYW+Rp/wthR1jk8cNo/cN4QO94cdCgRdFM2iC+sP
         lnmQ==
X-Gm-Message-State: AC+VfDwnDEdEE1p6NKUWTUoaSqPYDXmyC2GMa+zq4iTOHsr/0tQwzI4d
        Azo9tNyunGnjhGo4TYrnwqWhvTXTaz5YAw9psHg=
X-Google-Smtp-Source: ACHHUZ5yJ1O+Nu4jbUOL3a//8AgofkNaJfks09G2X24TJviwMgiZA5A56CY6N6UMcOqyu+rzF+YhpQRf0wCFknZm2fs=
X-Received: by 2002:a17:907:6e8a:b0:989:21e4:6c6d with SMTP id
 sh10-20020a1709076e8a00b0098921e46c6dmr14474331ejc.28.1688413169631; Mon, 03
 Jul 2023 12:39:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230627224017.1724097-1-gnstark@sberdevices.ru>
 <20230627224017.1724097-6-gnstark@sberdevices.ru> <20230702172116.00006f33@Huawei.com>
In-Reply-To: <20230702172116.00006f33@Huawei.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 3 Jul 2023 21:39:18 +0200
Message-ID: <CAFBinCCLt-o_QX0izmtzs8MA=ETMAhEib3KDr-6Z66n__GVkyA@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] meson saradc: support reading from channel 7 mux inputs
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     George Stark <gnstark@sberdevices.ru>, jic23@kernel.org,
        lars@metafoo.de, neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, andriy.shevchenko@linux.intel.com,
        nuno.sa@analog.com, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, kernel@sberdevices.ru
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

Hi Jonathan,

On Sun, Jul 2, 2023 at 11:21=E2=80=AFAM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
[...]
> > @@ -235,6 +249,27 @@ enum meson_sar_adc_channel_index {
> >       NUM_CHAN_7,
> >       NUM_CHAN_TEMP,
> >       NUM_CHAN_SOFT_TIMESTAMP,
>
> Silly question... Why does this device have timestamp channels?
> It has no buffer support so they don't 'do anything'.
> If it had then putting other channels after that might have broken
> things if not done very carefully (hence I went looking)
This question is probably for me (not George).
The answer is simple: when I wrote the Meson SAR ADC driver I looked
at various other drivers (but can't recall which ones exactly). One of
them probably used a soft timestamp channel so I also added that to
meson_saradc. Since "it didn't break anything" I thought it would be
fine.

Newer SAR ADC IP blocks have buffer support, but that's not
implemented in the driver (yet).
So if I understand you correctly we can drop the soft timestamp
channel (with a dedicated patch in this series)?


Best regards,
Martin
