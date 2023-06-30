Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE40743B1D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 13:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbjF3LtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 07:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232728AbjF3Ls6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 07:48:58 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7BE3AAE
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 04:48:56 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-c13280dfb09so1717794276.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 04:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688125735; x=1690717735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hhPx8Hh7M7YH2J3WFDsXt4EqPndUN6y8De0tyQm/k4E=;
        b=LJ2jAot5pSG+gTYVJX8fDjg75kz1nugO/4ywCuOzL9SfpdNfK6+ka3mXQpCsybMvNi
         tTh2Noxd61oD66W6L08Ur174fW7LAmmHVhwjR//RgnfFP38UfW0bYaJDMc3FlBi2H7r9
         VhJ0Y8Fbs8ZTSF8/+pN4tsiWeipBWUQzFKRhYEpkeq8AuRDE073FkqWQVxL6S0Frlrlm
         mS08R71iEQEBoER1u2caEDZy23H9/k1wv8UVUPB+QdBTRMiaa0BJk9oGc533kTKEn0Ng
         H0LD2RY60hwy002Ga7PqODwprhmSoO+td5O14VZqRpI/nkWNDdNYvTmzhe7A/+CiryUF
         hMhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688125735; x=1690717735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hhPx8Hh7M7YH2J3WFDsXt4EqPndUN6y8De0tyQm/k4E=;
        b=iilXHRhnTMLQNvlcm5ESqNIzPVgGYrxokZXt7SzeKNn0qMkaUIGXJiMiifgwPENH+5
         Zp6+3hcOBxJcXpKnaHo9kiFu1LwGAPcfd5ZknP7dmMCAoynnnXqdMCVp9YLac4pfZyAV
         a7d+GNvoNWip8QZFV/mAfpLbkN75Ia0dce9f1xOfPk0EdHCwxPqxHt011F9W5IZdPUOv
         b/eLC0I4TrmkIZCrIb9/EAbEEtZNSIN6kCIcOpSa9DVYpqFbUsfcIz7lOe1oDqnT8YLT
         nCZskWE+GzchfrVZpuoQZ/1jvUM0ZBDLbJ0AwsjXunQMlZQkLYdXJPUQZ/8XXxL7/L/+
         XPuw==
X-Gm-Message-State: ABy/qLZ5ZLmJ01VSzbJdCyH/Aro/X7eqaNxCsAQ74sWqD+0r7rXut75j
        P2JyM5ktAN2jpXX1TMwkxjRS8LTZbWtiGl7wKrL4eg==
X-Google-Smtp-Source: APBJJlFseWNZE0jgDgce+tEtRmGuGFF56nVMUZU7MLkCT4lM7cJTLHUcM7VU1LvLY1VR7MkMNtkDKZuvDDX/VaTmcR0=
X-Received: by 2002:a25:6884:0:b0:c39:8036:e3f9 with SMTP id
 d126-20020a256884000000b00c398036e3f9mr2551934ybc.26.1688125735691; Fri, 30
 Jun 2023 04:48:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230621174943.30302-1-andriy.shevchenko@linux.intel.com> <20230621174943.30302-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230621174943.30302-3-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 30 Jun 2023 13:48:44 +0200
Message-ID: <CACRpkdY--Mg8VORij9u+ef5KJ_VGyVnP_qeSVVQ_k3WxMr4U+g@mail.gmail.com>
Subject: Re: [PATCH v1 3/5] gpiolib: Do not assign error pointer to the GPIO
 IRQ chip domain
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

> Check domain for being an error pointer before assigning it to
> the GPIO IRQ chip domain.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

And this concludes patches 1,2,3, nice!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
