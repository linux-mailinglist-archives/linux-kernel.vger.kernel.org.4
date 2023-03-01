Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5E36A6708
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 05:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjCAEkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 23:40:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjCAEkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 23:40:08 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52FB837F36
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 20:40:05 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id x14so17972465vso.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 20:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NwsREfLzKNuoHKNJGJ6iVvjj/6dxpXa/wWiq+aOws3Q=;
        b=X9NKtJL0IJE82T7Th8Dk6OnTlE5QS9XjUMbMbMjCtPKJScjlgzMi9tRe9haNk5I/bp
         a9RvGAstNTzMucSeHKPPx8MvbmVGQGR1s+LPQiX5jkKZ1ObsOwdQPM7QJwwkqXqXun4D
         Mj6sb9oTp0PTfWd7kvnK46taN4Ed/rdZOW7a8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NwsREfLzKNuoHKNJGJ6iVvjj/6dxpXa/wWiq+aOws3Q=;
        b=hovMPxGjc8SSd/wi5PnIHerNBj+UuLD7pzUH0WWeNn/0ZX9Jk6QpzkqpJTW9H011oN
         36tcQ5XEzYA/K/6pjHhUos0J408Dtu6WTM7YP8cpgVxar1+po8kQoZt36YCgo91p4McN
         Yh+yV9Ssxca8IQebbYMxQMyCKS7tiwnB8z2KND8Esrhb+eHF2b1Mn94LF2x7YNPfUfU0
         08wI0gW2HdcEJHP0Zn/Tgg1sNdA0EDUvNZIqU+k43wU6X4SL6aW3FJ1XInuI+xi8Xfcd
         3hrKwom91jfe54LXzc/Et9juPNj9h1FCWUJpq3TvXKEIz76k+EolZwpQjCtnFDlq+3nQ
         XI8Q==
X-Gm-Message-State: AO0yUKXA0fzKIrzKOTVuLfoKK3e8CC4WjQ3cc5gbzo/7mrPU3/AZ/Ax+
        pQrxOUE00LPCnNmbuiWRi4Hf0zs/J6cDIyY7sMkeEA==
X-Google-Smtp-Source: AK7set/20vPvgEB8su2PX/3Zm906cvBref6o6YCdNAAccIVwSoFTAxjK0qhveIlYt8n8nLOyXZEv8bdecjorFvsqMyQ=
X-Received: by 2002:a67:f9c5:0:b0:402:999f:51dd with SMTP id
 c5-20020a67f9c5000000b00402999f51ddmr3423652vsq.3.1677645604447; Tue, 28 Feb
 2023 20:40:04 -0800 (PST)
MIME-Version: 1.0
References: <20230228104741.717819-1-angelogioacchino.delregno@collabora.com> <20230228104741.717819-6-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230228104741.717819-6-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 1 Mar 2023 12:39:53 +0800
Message-ID: <CAGXv+5HF59-QFK-CTb=JLLDb8_J-JrgbzWHpmNWKR4JqF2O0bA@mail.gmail.com>
Subject: Re: [PATCH v3 05/18] arm64: dts: mediatek: mt8183-evb: Couple VGPU
 and VSRAM_GPU regulators
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 6:47=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Add coupling for these regulators, as they have a strict voltage output
> relation to satisfy in order to ensure GPU stable operation.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
