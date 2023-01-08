Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89AC661908
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 21:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjAHUIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 15:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233759AbjAHUI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 15:08:29 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73266DF4D;
        Sun,  8 Jan 2023 12:08:28 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id x10so6848409edd.10;
        Sun, 08 Jan 2023 12:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SfAqEk6Cnz3wz96nFjB9/0XtkQDtrkyzMilGj3K5kcc=;
        b=l+P3T/rc63Dk1hu+Zklkl14XXrxB1jeun5TSVBOd+i8BMhesz3gLBssP3l10+iF50Q
         7mbPnP/D2Rj9MpB5Huwa+EueQG3kuSw/y3aOhj7jPkoaOJi2GVFtxtN2GeC6fh4nOszv
         +9L8bG3wrVgHF4/x8A4MRX+Mxt0cVK6515FCi6HeE3TFqFvJcS7ZLeln7pwxTYzTmW4S
         LyAw+z9c+6o80pwm6XNC1n07FKxybG5Zoq+szQT3wYDjlUkvwukzkUMY1DYak0A1VVDe
         a3RavT65tQknYqGQ/M1vjOzKpPXzLduHaEANq4p4Be3GJHJCm34KMCSRK9Ln2zgxVvYO
         82wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SfAqEk6Cnz3wz96nFjB9/0XtkQDtrkyzMilGj3K5kcc=;
        b=bXoWNeHhODSxQW5XznmwBaqrKLv2NvlGLSlBtSjTur9cBZkR4ThnK8v6y9zPgDuMQl
         q/hiNhJhvklTOrS2fuc4+XuerkXdJ+IyJN4cFv4MLwwUengsYQYE/EYnl8amapv3RVQW
         HMAamHr6SlwW1M6i5nNxcOy/C8Qy42mJynwvqvnqKv1tKMQG2Y4kPtBxmiBzKUBXWPlP
         t1XlbyoJQmbXMS4qQbpIkfEjf/TdeT8nLhTjovt8Vh3e3S/66KiaeMuFylsmk5nqJy8E
         lsgtPyCTIT1SYb5ZPlfn6DGu+03ElmwdbJgTGampdcZ4imYrWD/EhTgOd8zk4RLYIkd2
         4JdQ==
X-Gm-Message-State: AFqh2kpqtJMnvMS1720kRfBbbB1en1/+hGVnPtXIZYwKZlS5StTpVcyS
        U6LEt2756DpcdmPGnEBPkKE=
X-Google-Smtp-Source: AMrXdXtha5ZnOvivJfTEpoecJn3Pj1c4rtqTe3te3Nqi8REjGrYlLvRd+Q6FAJIGr98dh3jnixatSw==
X-Received: by 2002:a05:6402:646:b0:499:b582:8414 with SMTP id u6-20020a056402064600b00499b5828414mr1096018edx.8.1673208507013;
        Sun, 08 Jan 2023 12:08:27 -0800 (PST)
Received: from jernej-laptop.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id m20-20020aa7c2d4000000b00495f4535a33sm2919484edp.74.2023.01.08.12.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 12:08:26 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Samuel Holland <samuel@sholland.org>
Cc:     linux-sunxi@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH 0/2] iNet U70B Rev 01 Tablet Support
Date:   Sun, 08 Jan 2023 21:08:24 +0100
Message-ID: <2165851.irdbgypaU6@jernej-laptop>
In-Reply-To: <20221229224547.25225-1-samuel@sholland.org>
References: <20221229224547.25225-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne =C4=8Detrtek, 29. december 2022 ob 23:45:45 CET je Samuel Holland napis=
al(a):
> This series adds a binding and devicetree for yet another A33-based
> tablet board. The devicetree currently fails validation because I have
> no idea what compatible string to use for the DPI panel. Neither the
> hardware nor the software provide any clues about a manufacturer or
> model -- the driver used by the vendor Android is called "default_lcd".

Can you drop the node until this is figured out? Otherwise DT file looks fi=
ne.

Best regards,
Jernej

>=20
> Link: https://linux-sunxi.org/Inet_U70B
>=20
>=20
> Samuel Holland (2):
>   dt-bindings: arm: sunxi: Add iNet U70B Rev 01 Tablet
>   ARM: dts: sun8i: A33: Add iNet U70B Rev 01
>=20
>  .../devicetree/bindings/arm/sunxi.yaml        |   5 +
>  arch/arm/boot/dts/Makefile                    |   1 +
>  .../boot/dts/sun8i-a33-inet-u70b-rev01.dts    | 172 ++++++++++++++++++
>  3 files changed, 178 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sun8i-a33-inet-u70b-rev01.dts




