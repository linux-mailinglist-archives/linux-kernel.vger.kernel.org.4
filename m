Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25F97290ED
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 09:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238674AbjFIH1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 03:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjFIH12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:27:28 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308C52D7E
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 00:27:27 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5659d85876dso12639457b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 00:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686295646; x=1688887646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=79c5wwIkf5JFBuHBe/pz5shE4weHE+6yaH3P5LzlEZA=;
        b=CDzIQHQESQF3OKQcN2e/Uk5EHv1GuvRpWWO6qmJ28hV2ZWI0oltmfJfsEuVni7JKUj
         MCdkaTR+qjFMBLDpsbPTxFzbj0w+A1JE/fAuGkUh0K6HjZzUrICNeUSAWaD+wOoNSS+P
         3FxmA4eW0FCjImvwEvo8l3yBa021DL2+11cFd53jLhmiY8Se/cULYNYoenWkI+RBXecI
         xmjN5QtEggW/NGkgrUp5NplJ3uOONvUVP14do+mliUULmzE6iUR9pHU+yyrl+xAlcBdM
         qBrseG0CmciAuLddOaigdFvLesrrEPSFx+PExltJsxIEHZq1Y9lgwGCE3hPUCH9MzndW
         3jMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686295646; x=1688887646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=79c5wwIkf5JFBuHBe/pz5shE4weHE+6yaH3P5LzlEZA=;
        b=EvR+CARpsuNRUQ4CN+EXNJZA1sbQ2Kkhhk+pabZh4eA0Ur+TVMKP4ws93lHagZTL5t
         Ztdkx505oYVd0YafnCOWvvnn20DizvDat4Xv94pTWKgRyFkAywz6Z76i41LHsNMFw5r8
         v4MwUyWhhbvNdogQtaaKSFJSLrJ59emgmdkmVyIL8Wp9hkPDmGv1y593Y3WX7OegAnL8
         LolQU+3+ktyHQnmNCxf3u+pDuSdSq7/ifraZc0OmuwWGVg5JHzjmZkRlqXa3MTRvP96K
         19sk6XSf+ETJHJrNZU0U4LdmYKjBq0z2ATttxLMd7Bv9IIh6gvyzienJzJFfwwOUmH1Y
         y94A==
X-Gm-Message-State: AC+VfDzFXL4SFDXaT5TMMPbpq1w0x2F2VKTQ7hLIjNYfFPne7Y9S9M5+
        SDEqwOyezHhLihqtVXMtpht86h+0lzim9oaZQRXV6A==
X-Google-Smtp-Source: ACHHUZ6V8n51QunpOT9L+GvuKgO/ttKnk5Hb+I0waoIxJieTUrGVZBGkGdL4GRVfFKMIqAUIu0H1FEJhwjKDXkDyqJY=
X-Received: by 2002:a25:a025:0:b0:b9e:4d05:1f96 with SMTP id
 x34-20020a25a025000000b00b9e4d051f96mr385739ybh.44.1686295646461; Fri, 09 Jun
 2023 00:27:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230605125411.60378-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230605125411.60378-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 9 Jun 2023 09:27:15 +0200
Message-ID: <CACRpkdYnFHBUt4rwLFqA7LYJRJxJ7e9hEGf_B8oi3rc_+Hc3AA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] gpiolib: Remove unused gpio_cansleep()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-gpio@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
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

On Mon, Jun 5, 2023 at 2:54=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> There is not a single user in the entire kernel of this deprecated API,
> kill it for good.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks for working on this!

Yours,
Linus Walleij
