Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C48664297
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 14:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238368AbjAJN6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 08:58:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238673AbjAJN5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:57:51 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DD75FBE
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 05:57:22 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id c82so4575860ybf.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 05:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edgeble-ai.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4Mu/An59fONbzPRRXniVbBo2b/RYl5DOA+W3aYaQcyw=;
        b=A+VwZe+u1nuaXMwW6Cj2PrS1qQQg+UcBPDvzx7xTvRgfxbNtZ8mz9+BYaTjmAkfAXC
         fChq5JmsNAjOSXSJmXZRhVIBHUvkaWiCrAx/YTbAE0A+BKjkshO0d/CzrCmn9dcpmqLm
         eqoAFNY+H8j4hmZGNLv7WWq9h/5KfDSMkZPj9/cw6UartHfIcRawTTrW5OTA1XA3DK/v
         OUJOEO3PTF6cwSOfVc25N1vISgwimjp1vodQE3p7Po0nUm6SXBweDQ6QNTSgQvM2b4MZ
         1jsTeGkrpFgnh7Y7cpzU5hYQioOT/hOqEPlplMT8VAimjtlexJDwcxCQ+zc39Fk3SPMK
         qU3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Mu/An59fONbzPRRXniVbBo2b/RYl5DOA+W3aYaQcyw=;
        b=r2xEC6ObStl4YxbJJrErabKFgu5gJj9Scoey804UPwEEfK9qquvouKyEphcbm+Q62H
         ttuIjohyAl0ALyH/edXxJ+H5gZf6vu/lWOFpNu+I3tKobQ21HiRVyfnIlFaRr3G3Bgje
         XhdiAf36gbZ6CMGE9rTxiMXe7GRF6KZ2pvQrRa2BNUwpKyQj+DcpyxIRin8OXB/GnJpW
         ET+v70zi3dv6oFfuDWzLrrnHgYxAeJm5iCHMVvvdaHI9XsX/kyVX02EZts9WucoitrDv
         zE/G5XcW4lR/tgTjIO+9Q8oGUoNCmcAO+kdW3l9Shk6QPS2DcLebIFn2ayDWwbSvKptC
         myoA==
X-Gm-Message-State: AFqh2koLlyN9ieFpTuB9mgViRB4p9rstKDjEsHQ+hk1DIKkYXwCiQfMz
        +RfXjERU63QnlKmaJ61783Rf+rOn6SUqihbezPVx4A==
X-Google-Smtp-Source: AMrXdXvJRRkuDxhywF9so2rhvJI+tN5+UMoa9SjW3oXrwilPFR+vyfb1fDxa95qStrW3l7lP9zl+bLyQEdFDh5onnzc=
X-Received: by 2002:a05:6902:529:b0:700:331d:69b4 with SMTP id
 y9-20020a056902052900b00700331d69b4mr4862758ybs.101.1673359041793; Tue, 10
 Jan 2023 05:57:21 -0800 (PST)
MIME-Version: 1.0
References: <20230109155801.51642-1-sebastian.reichel@collabora.com> <20230109155801.51642-4-sebastian.reichel@collabora.com>
In-Reply-To: <20230109155801.51642-4-sebastian.reichel@collabora.com>
From:   Jagan Teki <jagan@edgeble.ai>
Date:   Tue, 10 Jan 2023 19:27:10 +0530
Message-ID: <CA+VMnFzM66AqDJJ6Nu--SG3dAt+MUGYMP3Y9LGN3BgV0sLkwgw@mail.gmail.com>
Subject: Re: [PATCHv8 3/7] arm64: dts: rockchip: Add base DT for rk3588 SoC
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
        Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Sugar Zhang <sugar.zhang@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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
> This initial version supports CPU, dma, interrupts, timers, UART and
> SDHCI (everything necessary to boot Linux on this system on chip) as
> well as Ethernet, I2C, PWM and SPI.
>
> The DT is split into rk3588 and rk3588s, which is a reduced version
> (i.e. with less peripherals) of the former.
>
> Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> [rebase, squash and reword commit message]
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---

Acked-by: Jagan Teki <jagan@edgeble.ai>
Tested-by: Jagan Teki <jagan@edgeble.ai> # edgeble-neu6a
