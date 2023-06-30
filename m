Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033AD743B24
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 13:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232728AbjF3Lvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 07:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjF3Lva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 07:51:30 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1493A87
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 04:51:29 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-57703895bd5so18867287b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 04:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688125888; x=1690717888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1XNK+dKeTAZKDPl3/snsEh3yGnhUwDk+DSAz9PIndMk=;
        b=yFKA/De05Qv0WpNcXF7ncMLlWV4rDz1AgTFdqwTQt6WILVsPI95de/SvK4MvoBbb/z
         ctwgg6t6i7PiBHXsfPO1coldFcvAnWtFdm+Us9arqDfYmD9dvGbxUPaj3FDMq/Jo4xxU
         ht9zgpZDXUTLpOUkL2VXK7UQJvpOM2qZItwoP/Eq4d1DmNnq5QkLmBs6+pYIEveH0qCI
         f1F0dUtfYVWYGsBaHElNgHQs551Jx9F7l+1uMkrv5jQerW0zLoXh0DPWEtblY5sjWa39
         b8gvpGZ33eaB+yZgOPVkZZrKDKP/xBOghG61Frf3Dre6+37YTYaSrp9naUwLZMoGU4fb
         8tIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688125888; x=1690717888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1XNK+dKeTAZKDPl3/snsEh3yGnhUwDk+DSAz9PIndMk=;
        b=k5u/2/VrLCL9Rz9j+5oDMmRpzZ3sli3l9yJ5S0GQrJ/+HhV0HlJoA61yZ9kgUUSEVg
         Fh5gyN0xA9C5yOfc8BOgNGMWwj9u4r0JKgA1/EnCIzGfeYKrUpTpKnC6+c4tldIzY8hb
         TpvBJfOfuJEcHmY5Cd4/iGo4U5Cc8JSFMAcPG3CC34jXYs6wd2BshWi7AUGuQslBJT7P
         16i8SKJX3MUpIGI4Rqet7WJ7B9PYHfAjaciyPPbUccHgs/cRHFSRxNCnpPC3gamwY2KN
         LqX0A3WBNEQJDFEOgJVqp5Whjunbd3ixObcNK6UeDZ4+9YDR2D/b/fHZkteHUDLWAly+
         b6Bw==
X-Gm-Message-State: ABy/qLYTxyLRzjWwZPG23VfhpkCZ2HCOGrXPPgI8VS+jwIIAIKAgO7C0
        zstJYO9skI62hREKLq50pvKPPLjbIBVQbNFq8VvQwQ==
X-Google-Smtp-Source: APBJJlFvjH7krzx+EDcfZctYU/w7i2AhV3XC0cABrjpgQiyYpHMU5mjSsBpofTBEev181OJKmBWdfJAzyjmiNBYAwyo=
X-Received: by 2002:a25:a249:0:b0:c11:d5a9:d260 with SMTP id
 b67-20020a25a249000000b00c11d5a9d260mr2264891ybi.49.1688125888512; Fri, 30
 Jun 2023 04:51:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230621174943.30302-1-andriy.shevchenko@linux.intel.com> <20230621174943.30302-4-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230621174943.30302-4-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 30 Jun 2023 13:51:17 +0200
Message-ID: <CACRpkdZSi47q9jXxN=9Z00WnzN_iDrBQVfOGXGbcE=u=CrVPZA@mail.gmail.com>
Subject: Re: [PATCH v1 4/5] gpiolib: Split out gpiochip_irqchip_add_allocated_domain()
 helper
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 7:49=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> The gpiochip_irqchip_add_allocated_domain() can be used
> in another place in the code.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
