Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E296F313E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 14:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbjEAMys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 08:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjEAMyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 08:54:47 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82E210C0;
        Mon,  1 May 2023 05:54:45 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-95369921f8eso404755766b.0;
        Mon, 01 May 2023 05:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1682945684; x=1685537684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cvMlMk+g9+vzaZ1OWKXbFrRdjkHE+cIOaEaWSWx3yeM=;
        b=h07jkgAH2pyhCZVKjt79SZAaEYWyQXm6TWqpoKmnzK6zYzTv2oE3Ob8cZEeBvw/+Bf
         8IIeRtYzTay148BY98KudqhCgDU2d3PY2qSr8votk+DQORTNKq7pSMOfZqCR6QKNXpgt
         WRc7gqG+Z7zPhYAp6+k255qxIDHRkXatOvFP1038WhIIwdzGyTpdXCOh8uqKtrRz0So8
         5fEq0l7MAt6hmohkQ1I2JU65EBvkHOgoi+K684ScgtehYOq0/yxL1EmoBqDdZ8KwVDO8
         G37ZbyNszv/K2utdFde8ObsNyEjEOxMRfroBwx/CZS5SQInEGHoTZ3WAxHdVNJugQLXE
         Jorg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682945684; x=1685537684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cvMlMk+g9+vzaZ1OWKXbFrRdjkHE+cIOaEaWSWx3yeM=;
        b=N5BSEWKQMK1p6tnbjJu7fjh8QVJ4Ru+v9i0c5hEeshk4A+nczHeXQdhEqtGmDjO2ZF
         AvPTeIn11KqHAdgQFk7mD37tZ5zu8uI13ftFw5V0z/3OPYsAhipq4rzHp5yROlUX8LN5
         IUJIW1OxH3obVEf9knNSEH5GWTarm+uhjJempa7oz0+OsRnWeV4yI73cWx3pGm6j+4gm
         +0jzJseav99mjMM2r2BJ3qphC/Jf327NYH+RYybzAIjIejb2YX+93cI4SuOfFPXhzk4o
         i4DXtgntLKwe/dNqPXCZuDq+ivloVIdp/mRTtZbSHzF3Q2we4evTT9CJ253OKZGivWZd
         G1rQ==
X-Gm-Message-State: AC+VfDxnAQA+qMgMtVh1mc684l1sfQt6lVWnWg8PCff+ZnqdbBwkdrzK
        7dHa4xVVsZPfjGADNGqcA6Y3y7JpiZNtUNhxDKk=
X-Google-Smtp-Source: ACHHUZ6/a2ChTGXpyoAxt0VdAT7RdfEXxC/8hthQRDyOA0Bawg7ngmFYluiEfZ9SB+z5QTcA7urN8/4WQOwEIxw+54M=
X-Received: by 2002:a17:907:360b:b0:960:ce5:20c0 with SMTP id
 bk11-20020a170907360b00b009600ce520c0mr12214296ejc.20.1682945683886; Mon, 01
 May 2023 05:54:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230425165624.11999-1-exkcmailist@inbox.lv> <20230425165624.11999-3-exkcmailist@inbox.lv>
In-Reply-To: <20230425165624.11999-3-exkcmailist@inbox.lv>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 1 May 2023 14:54:32 +0200
Message-ID: <CAFBinCA4c1qDC5=NWJKEMkTh5HfhkqpgrpetgEH3kJTY_qLVHA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] arm64: dts: meson-gxl: add support for Xiaomi Mi
 box 3
To:     Karl Chan <exkcmailist@inbox.lv>
Cc:     linux-amlogic@lists.infradead.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, neil.armstrong@linaro.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
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

On Tue, Apr 25, 2023 at 6:57=E2=80=AFPM Karl Chan <exkcmailist@inbox.lv> wr=
ote:
>
> From: "Karl Chan"  <exkcmailist@inbox.lv>
>
> The Xiaomi Mi box 3 is a TV box based on the Amlogic S905X chipset.
> There are two variants:
> - 2 GiB/8GIB
> - 1 GiB/4GIB
>
> Both variants come with:
> - 802.11a/b/g/n/ac wifi (BCM4345)
> - HDMI , AV (CVBS) and S/PDIF optical output
> - 1x USB
>
> Signed-off-by: Karl Chan <exkcmailist@inbox.lv>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Note: Neil will probably only apply this (and the other patch from
this series) after 6.4-rc1 has been released
