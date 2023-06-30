Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29024743B19
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 13:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbjF3Ls3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 07:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232525AbjF3LsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 07:48:25 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2C63A90
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 04:48:24 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-bfe6ea01ff5so1686683276.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 04:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688125703; x=1690717703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n5ZqAZiSn5H7ncYmND2Mk0HDGl8wCPZgwIU7C8IqLJ4=;
        b=eJu3hD8LV6A9O1ghoud7QTR+967Q4UY5TO/Mut++jAffD8Q9ckoNu0Q0JnDaWRbVhD
         w74d5xSb4m8YZZsImJmvU8GpkonaTEnYXvJ9xWy2o59Slw7umVI7g5EFHpvcoCmrdJZI
         bIsUgIDtFTUYaG4QNZkQpSrooeZ80wHOudjrIEMrFFIHo3qBVOf8CCAhmgHayq9aprAy
         Vy4jQ1oaByHqqwLB8suCXJCe2L43qGAQ5uIFfSbbXCTr/ERAp5iRAxAWfVCWvaDJQwR8
         WaOhu5mQci+vrhWh2/KJw3iI6qg7HlzquSK3f9vWxnFG9TgCrj3dtiApQZEjkMwPwnzo
         RFYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688125703; x=1690717703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n5ZqAZiSn5H7ncYmND2Mk0HDGl8wCPZgwIU7C8IqLJ4=;
        b=J//0CnZo1lZfGC/jC2GPZlWiGEh3UhxaMVCIsPnThkWfrZ6tFsjvxkVy+JtY5UmJGA
         jNDOFg4zIzwHo+Y+fpqt4xLNd+KrAhD3BgXTzxIY/cDDl1HymcWBIj3TaNu8FuZVNKni
         Gi/1wA18WwzeAxt/MdwouRTVieCvyJlTeF3tD+SlauLKW2JRAQjQCiDXXxk14eeBe1RZ
         DLFubnua4XmqZ+j013f/zJnFAT/HCpJddAuRMxy7QX37jT0iUh0MZbwix124Ytcd8/PX
         xJ9/G6YuQx3LveQpkHJc/4rmc5BH0Jq6u42qEN1+H7IdU0N+b5ZnzEu7kkoiuUQtu6C+
         EJ2Q==
X-Gm-Message-State: ABy/qLb4SVrl5xQd+ljPkgHDpT515GyvqlISpLpJOhXnftWKlvrR8/bi
        SVvuFMfDLgx21vouq6dagdeC65cTJNibtQdYaEBjCA==
X-Google-Smtp-Source: APBJJlEn23zpm9K2m3GcGXdyOI90JuXNMbceme7t72QCtVJK1VLTsf7axf/ddaUV4XHnxExw+9SjP+jDaXTxQSRWvDE=
X-Received: by 2002:a25:1f54:0:b0:bca:7cd:7f32 with SMTP id
 f81-20020a251f54000000b00bca07cd7f32mr2488364ybf.48.1688125703651; Fri, 30
 Jun 2023 04:48:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230621174943.30302-1-andriy.shevchenko@linux.intel.com> <20230621174943.30302-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230621174943.30302-2-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 30 Jun 2023 13:48:12 +0200
Message-ID: <CACRpkdbraGC0H+axUizMXEpo=kC2L-iwfFeiWCL8x8xc9e=6sQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/5] gpiolib: Factor out gpiochip_simple_create_domain()
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

> As a preparatory patch and for the sake of consistency,
> factor out gpiochip_simple_create_domain().
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
