Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A486C6D0044
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 11:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjC3Jyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 05:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjC3Jym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 05:54:42 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E8940CF
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 02:54:40 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id j7so22746672ybg.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 02:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680170079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pbyws3H75gB+yatcu0+FBMyILwRxUxSpq4AefwZkLKg=;
        b=mZsCUYHtWVu0vKKEGZmsGvkF+uy4o1aUwHzHWz89XldmLe8AQt/HxwPKXCnk93KRbH
         V8UAN9+MMCbN5JvfzvF+7noo3B3ZC1SlListXXAlyAe/Si2dth9gBK0ZYJ1pNZjq9WpB
         iNKgAFfirtS5iYb0r3mNi+HVpohWdyNPRun52UqeTAcSf+8ut/tE0fXdPt8xlgEB0Xiy
         Rj4pHSlWP9szJ+wDfC+QfLt2W4ckBGmT2H86xnDFs4tatnn3zZjeDGcEbbnYNyzNRnHm
         anAKm5idqzYX1EilwXDVQL2PFUkUsY4u2ooCexDw3QuTQhI2n1gfk4TR7i0W9tXx8lZp
         mHGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680170079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pbyws3H75gB+yatcu0+FBMyILwRxUxSpq4AefwZkLKg=;
        b=b+87tcqkb6wA0p2gaQxijbnWG6j1rlr2lEtOFsRnu5+wi9iCgZQy8PesMAy5Q6vllX
         uegx/oKK963A0eKh7aQEzquV9qkU0lyb8XjBO5iS8MRrXFlA7nN0o9PCo9ESnxjAia9O
         Wp++90Wdh0aG7aHGJgXk8wcINlaCTYAI/qMC1EFZyuS3VM3wuNAN45fgASh4xBHGBCu9
         u6JeMQchu7il03tL7Vdth6Qd8fLd9tZq7sfb3vqEufQv9iZ3/D8FDRrcB4zmoBXRtKlP
         Xa8MPubsF9UR4rLeuJSq1JS+tHL4+YPW5SklQeZeUHQYZWf+vegkN20LyL+Mo1o1EcEO
         Uf8w==
X-Gm-Message-State: AAQBX9c0PeyddKILse/RAb9lTN5BdWgZxaoHpOzEWTrgyi40162IqO+/
        DjsQG3uhkQ6BxElYI30PIW6hsFmocvQE9BraC/7LIQ==
X-Google-Smtp-Source: AKy350bEejlHh/La/ICbG+v0y62RclEvzaIlO/L71B6Mcr7xujU2ePyASX64lF1cgA+JnYGg8IIpcjjXYY2L1pzN96g=
X-Received: by 2002:a05:6902:1501:b0:b6d:80ab:8bb6 with SMTP id
 q1-20020a056902150100b00b6d80ab8bb6mr15155725ybu.1.1680170079704; Thu, 30 Mar
 2023 02:54:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230203-evk-board-support-v3-0-0003e80e0095@baylibre.com> <7h8rffyu9x.fsf@baylibre.com>
In-Reply-To: <7h8rffyu9x.fsf@baylibre.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Thu, 30 Mar 2023 11:54:27 +0200
Message-ID: <CAFGrd9p7oPvhZ8KL40XYfNi2CAdEd8BZWrXPqfcqu7DTSSg4Kw@mail.gmail.com>
Subject: Re: [PATCH v3 00/17] Improve the MT8365 SoC and EVK board support
To:     Kevin Hilman <khilman@baylibre.com>
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
        Linus Walleij <linus.walleij@linaro.org>,
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
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeu. 30 mars 2023 =C3=A0 02:09, Kevin Hilman <khilman@baylibre.com> a =
=C3=A9crit :
>
> Alexandre Mergnat <amergnat@baylibre.com> writes:
>
> > This commits are based on the Fabien Parent <fparent@baylibre.com> work=
.
> >
> > The purpose of this series is to add the following HWs / IPs support fo=
r
> > the mt8365-evk board:
> > - Watchdog
> > - Power Management Integrated Circuit "PMIC" wrapper
> >   - MT6357 PMIC
> > - MultiMediaCard "MMC" & Secure Digital "SD" controller
> > - USB controller
> > - Ethernet MAC controller
> >
> > Add CPU Freq & IDLE support for this board.
> >
> > This series depends to another one which add support for MT8365 SoC and
> > EVK board [1].
>
> It seems to depend on more than that series.  In order to test this, I
> tried applying this series on top of Bero's minimal support (now in
> linux-next), and it does not apply cleanly.
>
> Could you please list all the dependencies that are not yet upstream.

Hi Kevin,
You're right, it also depend to
https://lore.kernel.org/all/20221122-mt8365-i2c-support-v6-0-e1009c8afd53@b=
aylibre.com/

Regards,
Alex
