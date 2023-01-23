Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35CE8677781
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 10:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbjAWJiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 04:38:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjAWJiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 04:38:13 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B6CC66F
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 01:38:11 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id b1so8737101ybn.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 01:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5+6RKzh8/Lt7v29Nl9d79EntHpnCiB9/8mqrAnMy3gQ=;
        b=WeH++WcLNYyMKGf2E2zv8fRfVxHuz1bBP6rzSLVY/1sA+qMk5VJv9VqFdFfHmMkHx2
         3TK4on2ONCWbxtooazRn2zlREFQzvisCf1eiU9DfFoS7s1KNn3gLVJSZB+RYQNAJyQ6Z
         25IRNyNFjJp2poy8ZKVK8DiXNeUk7ETBAlJrru3Yk77C3FFx3LSSTX4JSh2HOruHWKFE
         QqJF1GCJsqsO9oK3BF4LekiCTQfo19tlHGwzkA74mlDwM+/x5OS3GK9EV7aTPwNIPS+7
         7YBFDa3F0wBfOA84nLvJAh0siJapfjp8BLjl8jcXfMw9zhyH4NBJ+oriZ8GXZrda4ee7
         77Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5+6RKzh8/Lt7v29Nl9d79EntHpnCiB9/8mqrAnMy3gQ=;
        b=s1LAIyIanU6+qmS38Phyce4PKp7St9r4QNYuuiMDvi0qVR2B1lQj3TcA51v4ge6/LQ
         KgS77P1yiqIEeVcoyoBxFeAzhtZLvwzIYRX6seyg/L16sTIWffbEClh+sJ+7oVGBW90z
         Kx33GJg/ADbHfiezU9RtQHTLcbiLFuL6Pn9DDatBoPaHpN4ul6JJn3KB8J3hHpsxLEbj
         TyCtAA7McdCB/Ftjxlvv3iL3WveBc8AQPjWUjX7gquZsEJk3XjAbw43Vs7evcM7Fthsc
         QVcnUlkH8/o9dy21xr7NspAxBy+8/MIp/R0b/bDt8VZwWKwufeQr8kG0SfCEfRiEjrDW
         yyKA==
X-Gm-Message-State: AFqh2kofyMtZ4iOCSQRQeuEXmaHNjcIq/l7x54ZGa7q3gcWum0qJ3+Xr
        N11vsbhH16okQXw1365jjEcbARaJAyXv1K0KejgTkg==
X-Google-Smtp-Source: AMrXdXuyGc4+CKGV7sHJ9YCNKzHlgrK8Jcq0Xwvkw40LgTEpzAUjXXmlBpQFuOBcJuWIcbR2wsacTUkpk9GeEMJ6a50=
X-Received: by 2002:a5b:4d2:0:b0:707:473f:b763 with SMTP id
 u18-20020a5b04d2000000b00707473fb763mr2791131ybp.158.1674466690342; Mon, 23
 Jan 2023 01:38:10 -0800 (PST)
MIME-Version: 1.0
References: <20230118-mt8365-spi-support-v1-2-842a21e50494@baylibre.com> <20230120082054.610626-1-michael@walle.cc>
In-Reply-To: <20230120082054.610626-1-michael@walle.cc>
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Mon, 23 Jan 2023 10:37:58 +0100
Message-ID: <CAFGrd9qXL-u4XzG9MLK2zbKoDudhTYpr-gJaZPjbysJ9Fo2gnQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] spi: spidev: add new mediatek support
To:     Michael Walle <michael@walle.cc>
Cc:     broonie@kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-spi@vger.kernel.org,
        matthias.bgg@gmail.com, robh+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le ven. 20 janv. 2023 =C3=A0 09:20, Michael Walle <michael@walle.cc> a =C3=
=A9crit :
>
> From: Alexandre Mergnat <amergnat@baylibre.com>
>
> > Add the "mediatek,genio" compatible string to support Mediatek
> > SPI controller on the genio boards.
>
> What is the use case of having the spidev? What if I want to
> connect a device with a linux driver to it? It seems like you
> just want to expose the SPI bus on the pin header. There was a
> similar discussion for a mikrobus connector [1].
>

Hi Michael,

Yes I want to expose the SPI on the pin header for two reasons:
- It's an Evaluation Kit board, I believe exposing SPI helps new
customers to try/understand it.
- This board will join the KernelCI soon, this setup will help to do
SPI non regression tests for a fixed default configuration.

AFAII from [1] , you can easily modify the current spidev@0 (If you
don't want to keep userspace interface) or simply add (in the DTS or
overlay) another node foo@1 with a different compatible (and so on)
according to the chip you plug on the header pin.

Regards,
Alex

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/Documentation/devicetree/bindings/spi/spi-controller.yaml
