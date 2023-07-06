Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D865974A60B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 23:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbjGFVmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 17:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbjGFVmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 17:42:45 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC45A1FD8
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 14:42:39 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-c5f98fc4237so1269064276.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 14:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688679759; x=1691271759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+0rENF/WeQpydVVWV122fwfebKo12jRQ+NnRzPzQpr8=;
        b=W/SqLqzt3wFk2cSOkuV+T+EczeUwl3oqInbbKRlT4oXgXFrFobMBlM88wjGhpBU253
         svEE5aOAjYqWkryCcUlYCJuW/m+di6FIaiJdkPSLXboETkhHC3BqRDKKtq5bJ+z2BQAX
         tDRwXpY2Zu8qlvHrtOjOLSelcVKmsuZzTuHdm7lS3OG7eM9MV8j4FMWUa9k76kaFjp4l
         wTkR+KszaKH45YQVXRN0pki6hALtHmL2LxxUYcW8xQ8wZxekpk7FpjKP1bU83cyW7mgg
         7E+XipZ1JacoQzxN0opR0dm1UCUR98tPuw1W2nAmN68HRALf7+hWg4az4Y7dGQ8+p5ya
         pbjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688679759; x=1691271759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+0rENF/WeQpydVVWV122fwfebKo12jRQ+NnRzPzQpr8=;
        b=GjO0XqGd9tvNnh8x4LtkbzMaOPst5MVq+cjvv/iBtPzhnZCafKi3QMbSzbnJATivrK
         YJPJ6+O3kX2Oy0jOa1GDGwTLV1vPV1e/1ZPkw4nt0B7U53/yNkIESgj85vodKytCjMXv
         +rHCoGrGcaBnldcZQA8TxtfhFBLUz8V4Ncywc7nX2Hr8VwJgzsF0U4aU8jXRdAw8c5qw
         XL4k4nhUP9+1Q6Gaf4n+Iz3GwCVdZ2URhbquQEaIKAVicE9Mela/L/cWnFveuZ5RgjPx
         M/Q8wLEykGmFq3ABGN92IA3csgv5rTwDdYrKtfyH+r5Qs5+Xdlvc1u4ojcCay2KQtgea
         Pt2A==
X-Gm-Message-State: ABy/qLbtdWvspsZdr0LfnrYIxqv/LG1NY/60qhdVqZept8QAOD0OtuIY
        XP8JdUzGNVrbiaIsxfBQuSp5nICZ3f5BQ0KXPnEjRQ==
X-Google-Smtp-Source: APBJJlEAXANJaCshopEoGTyGyT4USXSJCsyd2uuiYqc82UYDe7R2DDGSeNcDz1Nv2iylOJfJTRv7yTcuFYW4NiENZ/k=
X-Received: by 2002:a25:6085:0:b0:c18:1300:6339 with SMTP id
 u127-20020a256085000000b00c1813006339mr2997998ybb.52.1688679758872; Thu, 06
 Jul 2023 14:42:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230706073719.1156288-1-thomas.bourgoin@foss.st.com> <20230706073719.1156288-7-thomas.bourgoin@foss.st.com>
In-Reply-To: <20230706073719.1156288-7-thomas.bourgoin@foss.st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 6 Jul 2023 23:42:27 +0200
Message-ID: <CACRpkdaF59sJQMc9ZuEM=YFJPaw-oAmvt=s4GYjchEGWQ=yWCw@mail.gmail.com>
Subject: Re: [PATCH 6/7] crypto: stm32 - fix MDMAT condition
To:     Thomas BOURGOIN <thomas.bourgoin@foss.st.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Lionel Debieve <lionel.debieve@foss.st.com>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 6, 2023 at 9:39=E2=80=AFAM Thomas BOURGOIN
<thomas.bourgoin@foss.st.com> wrote:

> From: Thomas Bourgoin <thomas.bourgoin@foss.st.com>
>
> If IP has MDMAT support, set or reset the bit MDMAT in Control Register.
>
> Fixes: b56403a25af7 ("crypto: stm32/hash - Support Ux500 hash")
> Signed-off-by: Thomas Bourgoin <thomas.bourgoin@foss.st.com>

Oops probably my fault.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

This should probably be applied for fixes/stable.

Yours,
Linus Walleij
