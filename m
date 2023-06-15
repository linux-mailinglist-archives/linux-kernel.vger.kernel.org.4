Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363B3732039
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 20:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjFOSyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 14:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjFOSyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 14:54:06 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EDD01FFA
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 11:54:05 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5704ddda6dfso5348717b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 11:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686855245; x=1689447245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QwKA0mI6E3ECHuSybdmXbxPH2E9QmacoEa6v9Pwyf/g=;
        b=NMwcqpA9BOG0MJwES5ZLpsP4ZHAfV1x2QcFintJUrxP4HqtBRpcJy8y2RdqrOXu6NN
         +GDQ2/+IGQLyajJuylDILzO1kYeYVNqmawq7NHzxLekntEV0L0DxULD8OFQzJWJlsaLP
         5Clin/GUtI/6RnJfIVvF8SWOx7eoYrbW43RQjvqBFLmJteMUrOZCv6Fq9I1pdCWJayKU
         Vb2quLe5s3VRKNnsPYEsizFJOAFIAnd+si1Shnh4MYp6+kcfQvdGm+VnuE8h67LPHDtR
         9eGarY7Ei2ZRC54PetprjhlxjR0SIeK+YIr5txQCeYzsAcv7QqhhVMZJEQFKAadciMGR
         5/9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686855245; x=1689447245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QwKA0mI6E3ECHuSybdmXbxPH2E9QmacoEa6v9Pwyf/g=;
        b=kebdgjYKei+A7iE3VDMxMU7AGuwze8F2hf/d+OiJJN8JBTRr7gWRSw0lve7JOD4rp/
         jYJIqDOl7AO3Q29q34w6IDtyUFbaHEKcCOsSZrfrXwMswQenv4VkTR8k0+SCwPWhxGGN
         UVvNYDt+tRJH4plGoJf4H/pDomnPyyGkj4fSrmKG+/VIfzbjRJ9mnbImL1aC4zmCSgUm
         +RD/jtz+3nZjMMuqNi67Nh1nQEhZ+7XEYiiZ7JO8AX3ZbcMeSoU9/TIk49vVb1wFWjBA
         MO5aYKibmk26l+fGeTsZm8l+xZhHdzOTE2EqUn6tRrbv6xZQVNs6uCnnwx/lgD6nP2oz
         P6KA==
X-Gm-Message-State: AC+VfDw2Gt2aHIuF37M7XxE49P6q08Ly09Zd1e02DAyEPx+KOnSRQ1lu
        SNqpok0BukGVz2q68ns+SpSYw0wx1L9dCApwg8EyrQ==
X-Google-Smtp-Source: ACHHUZ5kbh49/R4F2mM4t8uRVbSyFW2gntjVuHyPDdPfd5ksCF8QfK6xH+kB4xDbHBBbYwHEOy81mQdszL2NzWz30y8=
X-Received: by 2002:a25:e086:0:b0:ba8:3613:76a8 with SMTP id
 x128-20020a25e086000000b00ba8361376a8mr6826471ybg.41.1686855244870; Thu, 15
 Jun 2023 11:54:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230615162612.21487-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230615162612.21487-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 15 Jun 2023 20:53:53 +0200
Message-ID: <CACRpkdYFu=RP1ikbTXkW1TC-pgO-FGdgdB2CUyLLbkFc6Dcn_g@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpio: xra1403: Remove unused of_gpio.h inclusion
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nandor Han <nandor.han@ge.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
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

On Thu, Jun 15, 2023 at 6:26=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> The of_gpio.h is not and shouldn't be used in the GPIO drivers.
> Remove it.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
