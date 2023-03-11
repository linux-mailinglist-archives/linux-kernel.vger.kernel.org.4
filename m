Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40DC46B60CC
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 22:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjCKVBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 16:01:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjCKVBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 16:01:53 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096D4515DC
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 13:01:53 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id cn21so4003515edb.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 13:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112; t=1678568511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mqLiLsZSZqkghPgueB9X9yY17FbUEdbpIwT7a5FTGHQ=;
        b=ahu2SILpBVmjIN/fyu8SXMNhCl85Y6wEUwLo8mfsBvX2hPGiJilmcEdlX3yWE2Moyp
         N9muMb0BsILbEQxbvGT8dTcTEgqzHAkVH8SMDB7hKDDadT7tQyfWZV+6AllBg7R1ljhR
         A7HlWu4jQkj9Q8u/3KH8GMpc4ooxjlzde38Jj5faLL1o0ufoRIkLZOzBzbeHTvbg55x3
         PjZrt+MYSDWIyd90r5ppRdDc9vGvCVL1VfixYgFFj9WvRHywzmqtqB2swIFxdF7Tod/d
         WSRQAiwVU7yP3oAv7YqJDrfZgKj5ZAoPKVdO9JtqTBdtzfkMUA0fxmtAC/wbqBTN9MXW
         nPHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678568511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mqLiLsZSZqkghPgueB9X9yY17FbUEdbpIwT7a5FTGHQ=;
        b=oRLG4NExC8mCgbBGxM8NpR5m2U8Dt0wEG9sHN5AHQHKsPPDqXJDRdSF1rJraw646gI
         s54naVPjBffL+Hf/8VXtwGYPEfzumLiC2XL02llMmJ87isH99F7SmQ3sf2KBr3fN9u4z
         rafTmvf97KEwgaiE6MI5NBABia1AtHZofwF7y5UNCxBe6OSw6F2+fAe1GE5XPX8TLtcG
         XISPAhgLO4ZLAKyjcaWOmtbb/gFJ+ZbkBYgzZKR6DR3qILHRUMw7FuceaSY4UpO6MPNG
         y+vYpSC/qLs+CW7nH8n2FnVp2Ad6zkVfEDTXL8UuYhVffEEsGaK75aV0PUjjWvRSBhX0
         t/jg==
X-Gm-Message-State: AO0yUKUsLUS1RMm2NahxKrVD/R5h4okpRLgUZQNcAicOg7vh0r+LZy/T
        btlteRjkqW3L3K53Kgcppxi8vCytUHzOAMEBF7A=
X-Google-Smtp-Source: AK7set9T7FoO2Nq2LlElL4QVevBogC3v/8RbnuqWg65zLah33pZl2isqrJhvphk/gfAO/Pw7SKdcFzIHpctQPPCAVjI=
X-Received: by 2002:a17:906:a3c2:b0:8b1:78b7:6803 with SMTP id
 ca2-20020a170906a3c200b008b178b76803mr15132394ejb.4.1678568511360; Sat, 11
 Mar 2023 13:01:51 -0800 (PST)
MIME-Version: 1.0
References: <20230311111423.251383-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230311111423.251383-1-krzysztof.kozlowski@linaro.org>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 11 Mar 2023 22:01:40 +0100
Message-ID: <CAFBinCC3eWMdS5fH=HBLt1ET5r5jXhc51FVfXjGa62z+FjyJ-Q@mail.gmail.com>
Subject: Re: [PATCH] irqchip: meson-gpio: mark OF related data as maybe unused
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 11, 2023 at 12:14=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> The driver can be compile tested with !CONFIG_OF making certain data
> unused:
>
>   drivers/irqchip/irq-meson-gpio.c:153:34: error: =E2=80=98meson_irq_gpio=
_matches=E2=80=99 defined but not used [-Werror=3Dunused-const-variable=3D]
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
