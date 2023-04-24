Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A09F6ECB6B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 13:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbjDXLfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 07:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbjDXLe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 07:34:59 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DF23AA4;
        Mon, 24 Apr 2023 04:34:58 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-94f6c285d92so780180666b.3;
        Mon, 24 Apr 2023 04:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682336096; x=1684928096;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EbSU9RjDYInaXljiYUfVeOZN1Ljlxfq5r8fOJ91jdBw=;
        b=FAMZ5KCdUlBonqbrUjdWglJ0XsUYCZcNASthRpFCH4Egt4u129lxmnRajJKmfeico3
         /f0nD9PDvu7xgJ6iFp9vljjQz6V+scC8as9bDFjRXNp02exuT2S0GA2gH3Uwzm/Ht+Ke
         hIrLSsAGC0P5u9FYMaYeq0LrZU+Nt7oDS5QvzDvfLqjXk8+bo7BWff59N8FV+VyeqrOP
         0HUbQbyzHZYcv3PqV/VFFbrn9/ArqAkqbPo7U/aWtrDvAervQ5j+wCfVAIUhFze1FlUG
         kzQomLZTzR0/swn63eOetP1p03d4cUfHrDl80sBSaKg/vRmzWNlRoee2AqIoa9vhFJ67
         TYog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682336096; x=1684928096;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EbSU9RjDYInaXljiYUfVeOZN1Ljlxfq5r8fOJ91jdBw=;
        b=iBV4/VyaHacIjVS/EYX4yAIm0JNXrTGeLmfW9f4fb3ShPvH8wQF6kFyVGnOjk/w/pF
         7V1h60saNRNNyTm1XkuzLqpKwlCK18mIoP4Lsz9SSZzGZF1PCckPOlEEvwnWIDgyARjv
         o3gvsXmePzDvjPrp4u5x1UKfChgzBzW64mLacdJEX7S4MzPaPu19FxeB/bgGBDBkZJsm
         pP4L7NBK+0MP43rf82s7Q4TTl9PgFSZOeBglRtiT69Oi023s6/zlLK9ieW+pZ0KxlwfA
         m551ax+eUNIjICRXHBq7O9E/SGVhGdWBjDOxJVNdttjVmqGKBgIcEHy8bslpJSYU4N2p
         N0uw==
X-Gm-Message-State: AAQBX9ettDS4IM0W3eR7dztSaFj5ItxxwyXAP9dimXXDLIArr285hz4j
        N1JspKOeiKVlZVojpDA4ZmDsQCltsjv9Sw==
X-Google-Smtp-Source: AKy350aHbDnDfjszhYFxHUof03CGll4kNyiiJk9KlQWmsBNW8HJCve+Hnr0Tp9bBXJu9DwSugPZ2+g==
X-Received: by 2002:a17:906:9b4b:b0:94e:1069:151d with SMTP id ep11-20020a1709069b4b00b0094e1069151dmr8435439ejc.10.1682336096332;
        Mon, 24 Apr 2023 04:34:56 -0700 (PDT)
Received: from giga-mm.home ([2a02:1210:8629:800:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id sg9-20020a170907a40900b00959aba150c3sm878730ejc.50.2023.04.24.04.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 04:34:56 -0700 (PDT)
Message-ID: <9e5e9b7dc5da40bca285d45618e0f7c15572e6c4.camel@gmail.com>
Subject: Re: [PATCH 17/43] spi: ep93xx: add DT support for Cirrus EP93xx
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 24 Apr 2023 13:34:55 +0200
In-Reply-To: <20230424123522.18302-18-nikita.shubin@maquefel.me>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
         <20230424123522.18302-18-nikita.shubin@maquefel.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-04-24 at 15:34 +0300, Nikita Shubin wrote:
> - find register range from the device tree
> - provide clock access via of
> - use_dma as a DT node
>=20
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>

Tested-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Acked-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

> ---
>=20
> Notes:
> =C2=A0=C2=A0=C2=A0 Arnd Bergmann:
> =C2=A0=C2=A0=C2=A0 - wildcards ep93xx to something meaningful, i.e. ep930=
1
> =C2=A0=C2=A0=C2=A0 - drop wrappers
>=20
> =C2=A0drivers/spi/spi-ep93xx.c | 31 ++++++++++++++++++++++++++++++-
> =C2=A01 file changed, 30 insertions(+), 1 deletion(-)

--=20
Alexander Sverdlin.

