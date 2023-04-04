Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF2B6D6450
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 15:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235301AbjDDN6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 09:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234987AbjDDN6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 09:58:24 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36595FD6
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 06:57:40 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-54184571389so614922577b3.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 06:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680616597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QOG7EXNpbCQF/FK7NgcIhsZjmEslJSuxN767xxFdzrM=;
        b=c0QPXE/HaATOw04uUyouWe33f7wYI0Gv9yrnJ/BtLOmZ2x7dDrUf3+Lht5pe/vWj8U
         PyzZX6FfyOpHP5wKyYZCK6EQDJ7nqLYQsoLowAgjvykIR38+KPw2yxcLBaTY5Xn0CEID
         Fke1g6Ii4InnnyFybyNtl1M7H8x9AxOkI18J1LO5oZmq9DqbhEMUH3EAU0wHyoc6R1i8
         q2KJ7WwpTwic4zJ0z/1SW5hh1Fnu24KAWI2g9Mp5PmfLHoQ+wykh5YQjOmXnHb0eN8m+
         m8QM3kJnt7gQABBijG4xCePSN8mTvn3KelbspmSjXnETJkX512C82xtPv/kMvL2kXMV9
         Fakg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680616597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QOG7EXNpbCQF/FK7NgcIhsZjmEslJSuxN767xxFdzrM=;
        b=WZ8imgkp3UL9NJHYcZG0AskV1WKSH2ecaukHQ/tG01bd12o83brjHGh9dXz2kHb7u2
         Esv2DgqJzZQNc6UHzc9hBTg73ROWV3toNo3zrNsaberiFBz0WoD7ad03VGsNffKMqyQv
         daa01yLDadcEBdU+p3zFSckOmhiHQH1mBpfGcvcwajrdRou7vUE0O7v4fyP3TaB5nQSJ
         98FqxztLU9QDerapdRI8mLNVEr2FOtpFeOgonn3ou/T0om99IhmAzYBn+eLYG6q2HVwz
         PZEgJZjuVjBj3DIZNVxOKfrQkr11OTuTtRpMgDGw2fLsmUI1HXnf+/YxDNDscDt0AXci
         BPpw==
X-Gm-Message-State: AAQBX9f04cVloGOXSwZupRgBHRy2tn0fVxGg+2eIb8D2Gdpuk1qYl2Ef
        bd092RKmAwCNz/TtbuimESRhxgmdAzv2wFzi7tn3ZA==
X-Google-Smtp-Source: AKy350YStYRZxmzUFjuh0G3rUNh+k1xCbee/1MWyMTOZE+CBKZN5euk0gmxKuhQhrjExvhnBVB5UMc35uItyJbpnS8o=
X-Received: by 2002:a81:c406:0:b0:534:d71f:14e6 with SMTP id
 j6-20020a81c406000000b00534d71f14e6mr1538463ywi.9.1680616597438; Tue, 04 Apr
 2023 06:56:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230327-cleanup-pinctrl-binding-v2-0-f21fbcc3016e@baylibre.com>
In-Reply-To: <20230327-cleanup-pinctrl-binding-v2-0-f21fbcc3016e@baylibre.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 4 Apr 2023 15:56:26 +0200
Message-ID: <CACRpkdYndXqTXrTakwv1mbvJBs-tG+pjOpLLCgS9crE0aBj0jA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Cleanup Mediatek pinctrl device tree binding
To:     Alexandre Mergnat <amergnat@baylibre.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023 at 7:39=E2=80=AFPM Alexandre Mergnat <amergnat@baylibr=
e.com> wrote:

> Deprecate properties which shall not exist, leaked upstream from downstre=
am
> kernels, there's no reason to use them. Here the deprecated properties an=
d
> the generic properties which will replace them:
>
> - mediatek,drive-strength-adv =3D> drive-strength-microamp
> - mediatek,pull-up-adv        =3D> bias-pull-up
> - mediatek,pull-down-adv      =3D> bias-pull-down
>
> Thanks AngeloGioacchino Del Regno to reported it. [1]
>
> [1]: https://lore.kernel.org/all/6e08d78f-ef4c-b228-f7d2-d63767ea87b8@col=
labora.com/
>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
> Changes in v2:
> - Change the bias-pull enum values to match with other Mediatek SoC.
>   That allows to use MTK generic define and be compliant with the MTK
>   common pinctrl driver.
> - Link to v1: https://lore.kernel.org/r/20230327-cleanup-pinctrl-binding-=
v1-0-b695e32e4f2e@baylibre.com

These patches does not apply to my devel branch:
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/lo=
g/?h=3Ddevel

Can you please rebase and resend?

If you have several conflicting patches that need to be applied to the
pinctrl tree, then collect them all in a series so I can apply them all
at once. Thanks!

Yours,
Linus Walleij
