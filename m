Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F52D6FFB8E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 23:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239042AbjEKU7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 16:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238977AbjEKU7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 16:59:43 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6698A60
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 13:59:40 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-ba1911d60f5so13381826276.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 13:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683838780; x=1686430780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=98GuhjooiSGjjfi39ai9daDWBREdBaEVAwj4iftZzQw=;
        b=bSmaeaL6XsMSpQGXVo76D7Cka2A4+V528u3twGhCTwRyrimipNK15gOdfOSKEJGUcU
         8BeA40+cyE6Q7FgzMM21dinVLyVevn3cbLDwFulnfDWnwwYGbN4dZB/xNLXwQeVOFxID
         Gg/Wmtn/ugPGXNbGhKmvAngpjGyndGFRIgXSaZ1rOgff4984EMtBzzipl4PhC1MqBSt+
         7Uawpthv42pqK5STAfQJ5RACIDrUJUTdF6/x3zn6BPtkErb3w8abtp+bfY0rmHLLhm11
         MorAW146RMaNsZXRpnvxPJ387fjeJZHxZwnbPbMltsTYqfXw57f0dQKtvtbGwH555Ny2
         mh1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683838780; x=1686430780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=98GuhjooiSGjjfi39ai9daDWBREdBaEVAwj4iftZzQw=;
        b=ICoBoHiV4MU7vIs6bfPvbmh0ht6aSdpSxDKPyPr7g5W7wvG4atqSueGOW2T6uKQ2Wn
         fwssf8hKlyBfNo6XiK6MC2TIS9fAuQfMgn09jg6bsCVF3ZWlOJud/QJ0Br426Dipyjf5
         GRonSj7RlFIpQikR/6ECiJ14uxaN4nZlzV7Pol7Gdxo/7gsCYtdQwiZ92ISkwczGAhcj
         7YcS0g9ueEBYLgIJPAQPsJ9ADat+lQIfDce4mVt8Z9Y62S+tmqDFcfI98lbToCRJeWt3
         HxUnpjxjL0TjgJ3049LndWmumRIaYPJWHoBbybEdq9pedPebMekhp7usj3Izp9FdRdcD
         yc9Q==
X-Gm-Message-State: AC+VfDwiLqkQAwowoWv+eCCH6cIB6QtQIMK9T9twQ/K2mcySFjWPnS/u
        b33JHBYbVkrtpnGm6b3SfIWKlo4SXbEogeAeWxlC2A==
X-Google-Smtp-Source: ACHHUZ6ixYhh8mxrkFHh0EE3iYR47T48OtoSaq7fLOFFEYZe/0R3Yk5UGjBRDzTOlSPxA0t5l6n+scz/ceHpvIGOcno=
X-Received: by 2002:a25:694a:0:b0:b9f:9665:cab3 with SMTP id
 e71-20020a25694a000000b00b9f9665cab3mr18616597ybc.62.1683838779933; Thu, 11
 May 2023 13:59:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230511-tps65219-add-gpio-support-v2-0-60feb64d649a@baylibre.com>
 <20230511-tps65219-add-gpio-support-v2-2-60feb64d649a@baylibre.com>
In-Reply-To: <20230511-tps65219-add-gpio-support-v2-2-60feb64d649a@baylibre.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 11 May 2023 22:59:29 +0200
Message-ID: <CACRpkdb2yrgoDFQ2rYTyJRaBbVHMFRSJtuemGa4jLN5tMuS2hA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mfd: tps65219: Add gpio cell instance
To:     Jerome Neanne <jneanne@baylibre.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Tony Lindgren <tony@atomide.com>, Lee Jones <lee@kernel.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Jonathan Cormier <jcormier@criticallink.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 4:09=E2=80=AFPM Jerome Neanne <jneanne@baylibre.com=
> wrote:

> tps65219 PMIC GPIOs are exposed in a standard way:
> gpiodetect
> gpiochip0 [tps65219-gpio] (3 lines)

Write something in the commit message about that the cell
has the wrong name, because all you do is change it from
plural to singular.

> Co-developed-by: Jonathan Cormier <jcormier@criticallink.com>
> Signed-off-by: Jonathan Cormier <jcormier@criticallink.com>
> Signed-off-by: Jerome Neanne <jneanne@baylibre.com>

With that:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
