Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 763C76D642B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 15:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235565AbjDDN5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 09:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235459AbjDDN4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 09:56:33 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5563E44AE
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 06:55:40 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-544f7c176easo614685987b3.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 06:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680616537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wHkwTuEK0sRBaJKLMcnB+ss8uWVVS2sTLaR7SSh4ZeE=;
        b=Qq5kv5hhcFuFy0PJtvFX4bmOosaBrR84kqX5KLBFFzUEc6HYu6DcRmucycm+pwLw4z
         c1uAzgS+6IfRZYHJk5KJGH6BUXWCXHUvONFdF36/iOgG9fJm+Or6v5c3zg4rspaHH3g3
         HiltUNh0Van26IVMA9fB0iQ/2JU4EmqjOAKnh9wB4GYotEL+CBZNtjApM3/Mvn7TE8jd
         7annxlm42iGSeOwxHaUKhpp00xjGstfzsDYvTrigHwC9433728mLS/XLnCAvVdN12kQr
         08QyncQY1xCydyx4nySCZClEtVlnx7zpGvVuhHi5DCP1Pb+uzJy0FxU1zuboEdb75qqE
         HUcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680616537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wHkwTuEK0sRBaJKLMcnB+ss8uWVVS2sTLaR7SSh4ZeE=;
        b=yNuZCzSJ29ZWGv5rNWDKLLYAQItmVT3pQ55zy317h50zwQRz8/yHYK4agyLOld1bR1
         216/rtMSZ9O2+t62kdxxFhRbh0MWEgtkVKBZAjt249UfiOwnhsiyko/l+EHu4fEEzi5N
         dIG7R5i8apdy3z20EBewZNkd/2s8bWLmn1Ic4dTJHxV8xTH3Tbi/Csqn4p4pmRBfuAHp
         dkxyR7pvgJRIsff4sZFMW3xfCMPRYTsPWVzPeB6c2ZzPMPgOYL5FOSWcREjwmWjpblC1
         XtEZF8X1oEfdtuYZyGZ6qshr3D5syPE/o7aDKxMGdqueR0Ch0BW4+4efrGGOK/U1C89F
         /bFw==
X-Gm-Message-State: AAQBX9d0lDPDPU39H/YQD3uTDXotpVFO6gn+1wPtAqgQl1ydmPypwOaW
        eZlB/+OM5vTEeBMxIbeIV3duvVxEQ+B6Pj6SJZAWHw==
X-Google-Smtp-Source: AKy350YrZFFIvslatnz6+JHLJxRXhURuO0Qe/CqTvhzL+6y/s/8tkJIoSvOoisaRTFct5e3xH8itE5OFyL+d4Sx3qSk=
X-Received: by 2002:a81:e545:0:b0:545:8202:bbcf with SMTP id
 c5-20020a81e545000000b005458202bbcfmr1485931ywm.9.1680616536968; Tue, 04 Apr
 2023 06:55:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230203-evk-board-support-v4-0-5cffe66a38c0@baylibre.com> <20230203-evk-board-support-v4-2-5cffe66a38c0@baylibre.com>
In-Reply-To: <20230203-evk-board-support-v4-2-5cffe66a38c0@baylibre.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 4 Apr 2023 15:55:26 +0200
Message-ID: <CACRpkdYSpMD-V0QNGwtiKCA4KAedYfmFpvdCHWhjST9uTricTg@mail.gmail.com>
Subject: Re: [PATCH v4 02/11] dt-bindings: pinctrl: mediatek,mt8365-pinctrl:
 add drive strength property
To:     Alexandre Mergnat <amergnat@baylibre.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Alexandre Bailon <abailon@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
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

On Fri, Mar 31, 2023 at 7:55=E2=80=AFPM Alexandre Mergnat <amergnat@baylibr=
e.com> wrote:

> This SoC is able to drive the following output current:
> - 2 mA
> - 4 mA
> - 6 mA
> - 8 mA
> - 10 mA
> - 12 mA
> - 14 mA
> - 16 mA
>
> Then drive-strength property is set with enum to reflect its HW capabilit=
y.
>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>

This patch does not apply to my devel branch:
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/lo=
g/?h=3Ddevel

Can you please rebase and resend?

Yours,
Linus Walleij
