Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7212C73D43D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 22:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjFYUuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 16:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjFYUuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 16:50:50 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79664113;
        Sun, 25 Jun 2023 13:50:49 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9891c73e0fbso479217066b.1;
        Sun, 25 Jun 2023 13:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1687726248; x=1690318248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8SBQPc5uKJ8Qyprt0o5l8sXwt+At2XiILmQ1q2dIyts=;
        b=IMHhFsNgqUYKxdAxM3w5x16VUYRZJY+CnJT4V8GrDkTDJgYGlo1vqjbpePbKzzeNIi
         m0f/QTK+YGxFNpYDGn1lZ0FvwsPfoHxx6/SoZD9SBGW/utFo44kRa+8DnvC1xZZb83qx
         BpDE8v+GmkrkCb9I8vKIBh1JQlxWzOeHnGR07f7Wemj1HPLt9VeD8eoAdbR1wjmqT1mA
         9jjRAC15ucjcowUYck2JYACkuTqKpL5A0cY54bXV2y9Qhfa98vr0Tey39amH8csORJiG
         c+/9OG7MI3Iodd1IesGWwcyDpGnrhxb1T3fK2bIutDk5FQE2MqDF1X/G4wUP8x2l4HwH
         /e8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687726248; x=1690318248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8SBQPc5uKJ8Qyprt0o5l8sXwt+At2XiILmQ1q2dIyts=;
        b=Bd8KDX6bWmmYrXKUi9HopsAKBukggS2Cw8Doxpl41WZTbTydCjs2Jo0D64FiGBE6DP
         6QmK5sgoxP9mCzb3nDPjKJxKPYUOcMJOGm5jjCVXZnXIhvc8pONbGO/446VlAaYnFlMC
         +hL2Hf8MQ6XvQoBF99U/05sfizaaZf54Upnm/eIqBNuuf74BwFu40y62dAllLamqL4zA
         d9VTnXBhZ2nCbGuGFIxkzK3UgjbQ/LHpDb4mxlJlFHWsa0YrFUMDApibSpTf4DKY8eos
         DnrNEjLvjkXXvADD2a7TDDIL5UBPX/uIeCi8s9sp8Dx+oHT2KVaZef6FJLn+WhgcvWQ5
         EgAg==
X-Gm-Message-State: AC+VfDzjfbJ3ckhCMMMLoVHkaDV0wuk1wHQE75shhVPWepV7PgByW7Rx
        ZJEOwTgcrSKq9HfKlK4/GKN/y0Mjzg4IwEOM9eQ=
X-Google-Smtp-Source: ACHHUZ5jvDY83UJJ6wMhDoedkzSmA5NrWCT3rmPXFwLwZ1tUb+Ma86JQVdZo6A7aCeavA1CesRuQbbrPqMvnulJlmzI=
X-Received: by 2002:a17:906:794a:b0:98d:4ae:8db9 with SMTP id
 l10-20020a170906794a00b0098d04ae8db9mr9551240ejo.19.1687726247842; Sun, 25
 Jun 2023 13:50:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230607201641.20982-1-ddrokosov@sberdevices.ru> <20230607201641.20982-4-ddrokosov@sberdevices.ru>
In-Reply-To: <20230607201641.20982-4-ddrokosov@sberdevices.ru>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 25 Jun 2023 22:50:37 +0200
Message-ID: <CAFBinCC0F4gaW1eFkJvf=oSkmAMmjbJ-ZFbVhpnrcGZPOX2sYg@mail.gmail.com>
Subject: Re: [PATCH v1 3/6] arm64: dts: meson: a1: enable efuse controller and
 setup its clk
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     neil.armstrong@linaro.org, jbrunet@baylibre.com,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, khilman@baylibre.com,
        conor+dt@kernel.org, kernel@sberdevices.ru,
        sdfw_system_team@sberdevices.ru, rockosov@gmail.com,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Alexey Romanov <avromanov@sberdevices.ru>
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

On Wed, Jun 7, 2023 at 10:16=E2=80=AFPM Dmitry Rokosov <ddrokosov@sberdevic=
es.ru> wrote:
[...]
> +       efuse: efuse {
> +               compatible =3D "amlogic,meson-gxbb-efuse";
> +               clocks =3D <&clkc_periphs CLKID_OTP>;
> +               #address-cells =3D <1>;
> +               #size-cells =3D <1>;
> +               secure-monitor =3D <&sm>;
> +               power-domains =3D <&pwrc PWRC_OTP_ID>;
> +               status =3D "okay";
If eFuse is always enabled then we can just drop status =3D "okay" as
that's the default.
