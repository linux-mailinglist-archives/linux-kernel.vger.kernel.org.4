Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E91126642A0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 15:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbjAJN7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 08:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238856AbjAJN7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:59:03 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAD73AA84
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 05:59:02 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id c124so11802250ybb.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 05:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edgeble-ai.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Dsda8KMeucoX1ilrO2O3wq/4jP5OycOEc8TNPvLqSL4=;
        b=5lyVr6VVay+hI8m/2i2l6KZTNNDYjLNisen/l9+2D4grmXW74VmNb1x4m5nbef8RXi
         JOAojJoCo1HbXi3nVvVVOUB+T2fQmistSoC/b63bhcG3/3JysMrsEfPKlW+YRW1p8t65
         VOP4atNNpHyKBKdgkbB/UEgCgbYlryKYJe1EIlbWzg1QRSe13ENMHYcghfFljnaSUQ/E
         Xuj2mlpfVbhveYHn3uO96y7Jn5W95rYc6P3PMEBLFyv7ViQy2OfLwIZpreXzYjoCmYKR
         y1Qslj64GGca37Yh7ahrSLvCi4Rua4MtNbo3LyyLaLypcxtVo6bK9nY9xmHaOXBFyEob
         P44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dsda8KMeucoX1ilrO2O3wq/4jP5OycOEc8TNPvLqSL4=;
        b=nkdHNgscqM6G0LUf4OZjdtiNatixtMHQR2g/PPRQCGQOrs/M7y2mwx/QRrqMs64BZZ
         ZuAKjb++sbK8nP+HsuJmANTez/gSJwM8m+jOiNib05bv9LghWRBrxsdlsWz1vsfx/7ph
         dD50c0Kx2Znki8AJ33PR60YvT6xIGQ9HunigmS0ho7UH2X1Ow7GfGIMBuJQ+LYYTMaE4
         PIJ2P8ZjXvwW7N9PItpoKAitVY9DywMDrAFvlzbk6h6FV+fXaxOUTl5HAj4HMYvGQaxG
         DQz3qLGXKqZ8v6sXt+opC0+WJN7qb7vuIWKHFySmXMT4b0L9B2ZXuZdtZ1UTJrUiOdCm
         vXGw==
X-Gm-Message-State: AFqh2krFhYkEKrznm8UNsCUrrzTmEtBK8c7fR0KKhVf1t8Ze6/Jp5Zun
        r1WqeVG7I4VvZgI0ULJtgkb2A2HkaJgZejqmUMDiCQ==
X-Google-Smtp-Source: AMrXdXuJbj8SnHjb++QBh1i8j0IsUc1D544EYFAL+i06GsxF0sSb2SQc9S5qlLQdeW1ZXpeu3gUoVzWVYHKJsJUSqO4=
X-Received: by 2002:a25:e087:0:b0:7b9:e22:7262 with SMTP id
 x129-20020a25e087000000b007b90e227262mr1448243ybg.416.1673359142043; Tue, 10
 Jan 2023 05:59:02 -0800 (PST)
MIME-Version: 1.0
References: <20230109155801.51642-1-sebastian.reichel@collabora.com> <20230109155801.51642-6-sebastian.reichel@collabora.com>
In-Reply-To: <20230109155801.51642-6-sebastian.reichel@collabora.com>
From:   Jagan Teki <jagan@edgeble.ai>
Date:   Tue, 10 Jan 2023 19:28:51 +0530
Message-ID: <CA+VMnFwBNc+Mk2VM=6BVGJoxVkpueekXHmkMdp50V7e6UNq8xA@mail.gmail.com>
Subject: Re: [PATCHv8 5/7] arm64: dts: rockchip: Add rk3588-evb1 board
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Christopher Obbard <chris.obbard@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kever Yang <kever.yang@rock-chips.com>, kernel@collabora.com,
        Michael Riesch <michael.riesch@wolfvision.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jan 2023 at 21:28, Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> From: Kever Yang <kever.yang@rock-chips.com>
>
> Add board file for the RK3588 evaluation board. While the hardware
> offers plenty of peripherals and connectivity this basic implementation
> just handles things required to successfully boot Linux from eMMC,
> connect via UART or Ethernet.
>
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> [rebase, update commit message, use EVB1 for SoC bringup]
> Reviewed-by: Michael Riesch <michael.riesch@wolfvision.net>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---

Reviewed-by: Jagan Teki <jagan@edgeble.ai>
