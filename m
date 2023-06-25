Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7984573D459
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 23:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjFYVMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 17:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjFYVME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 17:12:04 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D86D134;
        Sun, 25 Jun 2023 14:11:53 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f9bece8d1bso33262505e9.0;
        Sun, 25 Jun 2023 14:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1687727511; x=1690319511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kzoUzU5JNLv1BoIvSxcNlVmIryUfpeznhRFS/dmU0XQ=;
        b=f3soY7SiE5lWLMYA4zBOBrr7HPGVFWMHBbiNne9cwsruoLhouTAeuoc/Lw88Q87QA2
         GJ2iHnL8I3wcV0f3M8pSBf7hnt1yYFcJpX8lYcd/byYG0pW+lBEXh1+eSi16Xve+GgRx
         Z0TQyaZOYw1VGiQYdyNltUQ86jQLQsJqNmbJWHHaCwVm3YfzVs5+liXGRTv2y1Vh+Fu1
         ark4vBKsW5szlJCcrLs2zmVYPdMgMTBfRuFd+jxUYmggi9g6mhfoXXmBWmkFMwcjaIwe
         1A1HR6uDNz+Q1aYdiGkg+LcED9PlMSB++YpCfP4PWrRckdV5CBqcrROKmjpttglv++IX
         o6cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687727511; x=1690319511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kzoUzU5JNLv1BoIvSxcNlVmIryUfpeznhRFS/dmU0XQ=;
        b=LTSJme+OKPeN2kzhNeLg75hrTPo/0vtjUtvpk64OHrKmi022F8uQGiDnAxAxwukJHI
         AQ5D0aAT3oPffM8ydDl/rf2GQZzRuVQsBCwfpVomayQskpf98Xs7svGijxWBNhr7K37Y
         nux7r3phyOUlOauzRvjv0BIUFRvvbOknM9AEuRqD/qBZw4rB9lsnaWoInv09b9ODcONR
         9dHORWZC73lsOrJ1s2KRj4X1vDzZIVDKx+Xsagp3rQqfq924q/fqUx3W/Pixgl8XW4La
         HBMY6WtVHle7jE2eApi9ERkiT/WKR2ITj49QJPExVjyDIo36MypI6gZ0snl0A0iV8wLX
         0PPA==
X-Gm-Message-State: AC+VfDxm/pAkECYbn8SAGlMqucIdenD1/Pyk53tfOt6TrCx17LvCQnJx
        490chIV2TKeJA8mC0ho/7grFws6qy6ygNM+etN7frgX8cWI=
X-Google-Smtp-Source: ACHHUZ5IoXpoYLc8UZ4LjxmbBpdiAV7bkg6VF0dePcdWqFrB0RTjr5kEBzsBZAuKo+wl+DE7GhD7gDCTlKy5cAFG06k=
X-Received: by 2002:adf:efcb:0:b0:311:1cec:225a with SMTP id
 i11-20020adfefcb000000b003111cec225amr19789806wrp.15.1687727511239; Sun, 25
 Jun 2023 14:11:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230607201641.20982-1-ddrokosov@sberdevices.ru> <20230607201641.20982-7-ddrokosov@sberdevices.ru>
In-Reply-To: <20230607201641.20982-7-ddrokosov@sberdevices.ru>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 25 Jun 2023 23:11:40 +0200
Message-ID: <CAFBinCC_g6FhzR=PNDsYwT4OZb4uAXAWYGKSe7vSX7_pWM8pNA@mail.gmail.com>
Subject: Re: [PATCH v1 6/6] arm64: dts: meson: a1: add eMMC controller and its pins
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     neil.armstrong@linaro.org, jbrunet@baylibre.com,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, khilman@baylibre.com,
        conor+dt@kernel.org, kernel@sberdevices.ru,
        sdfw_system_team@sberdevices.ru, rockosov@gmail.com,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Jan Dakinevich <yvdakinevich@sberdevices.ru>
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
>
> From: Jan Dakinevich <yvdakinevich@sberdevices.ru>
>
> The definition is inspired by a similar one for AXG SoC family.
> 'sdio_pins' and 'sdio_clk_gate_pins' pinctrls are supposed to be used as
> "default" and "clk-gate" in board-specific device trees.
Let's wait for Neil's response on the other patch for the question
about pin mux settings

> 'meson-gx' driver during initialization sets clock to safe low-frequency
> value (400kHz). However, both source clocks ("clkin0" and "clkin1") are
> high-frequency by default, and using of eMMC's internal divider is not
> enough to achieve so low values. To provide low-frequency source,
> reparent "sd_emmc_sel2" clock using 'assigned-clocks' property.
Even if the pinctrl part should be postponed then I think it's worth
adding &sd_emmc
