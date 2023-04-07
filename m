Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915346DAB59
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 12:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240375AbjDGKRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 06:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240356AbjDGKRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 06:17:47 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5777AA5D5
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 03:17:43 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id cu36so36533794vsb.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 03:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1680862662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TJW7sjmt72lT4THQdV19MmnknlXVp7PoQh7cB3OqPYY=;
        b=jnGv+3Q0/ypEtmm6X3pNlnXEMcGwKFvjuf52+wL+W/15S/SbHwwxL7snWXSx2ZMcyd
         6X2jZ+UohYyCXx6q3gXIynsdIhtDalp2/WxYE8GH6k6CSdcabQmoKY5N5Njq6EPpwGdr
         3JVsuMf3MgITC80eRMRnRkYGNcB8zvVwcpAvWHeBJR3udlO9v+HEUJokoqySztuadKHe
         aSa6ZlWfSZEUem3GnaphCOZdg49TyOaLwsrejP4j/vKrCDCt0U32RUVpvlNnNUoK6YkN
         10S2f+5akG5+F+pJavU0t3hNU0T9BnfvnVkCJpl4iAzy4lbUBVY6MpcIqJ+pRepL2Cff
         tHMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680862662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TJW7sjmt72lT4THQdV19MmnknlXVp7PoQh7cB3OqPYY=;
        b=G5cJswcDBBSSXQ0pHKqMyptbi0gPvpZhc+ngbDfd0WDCSG8urWSDTEPL6+zq4cj4wO
         1SaaelePq1ibtXiP+397mKo6VEKVZeLF2B4tiLH7H+reB/FkP1XWnFO1OJ79HQsR0T3q
         GP/VpJBlQigziVWggxGPXB1eMZ2ALNylA6weWRHS0zKoDQYf9Mwh7aXov0GRpZGtPFZP
         YaJCXYvfzPi3vpW0uBAU0vTcFP0sM+t8fRdtF/CWhMNAaPIzYXHTeUnSxQnmw2HZAqp3
         5L4bTYOhEZxwCkBsY/9K9/D/y/DZjp19h6OvAoxjGvFdtGNgJj3ZtqI06vgl1L+9B5g2
         xnng==
X-Gm-Message-State: AAQBX9eh9cUHOVCnMo0dkt+tFsamXevwlG17Du+S9BVuyNKV7cFDXyxK
        5PF4eLasg52sOTG/9Hc3Ajwv3ZWpvnnbTyoMFoykiQ==
X-Google-Smtp-Source: AKy350YGf9gRAbDU82M96Lkvun1+ExRRdByoOp3KUflpS6XIF+nnu1nuldu7mfH9yV/jIEaz63lE0m2JlFfbHYE6vZs=
X-Received: by 2002:a67:d48d:0:b0:411:b4c2:c6c0 with SMTP id
 g13-20020a67d48d000000b00411b4c2c6c0mr873553vsj.0.1680862662472; Fri, 07 Apr
 2023 03:17:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1680708357.git.william.gray@linaro.org> <20e15cd3afae80922b7e0577c7741df86b3390c5.1680708357.git.william.gray@linaro.org>
 <50d8ee72-9b5c-4abc-a230-2aeb6eddf03e@sirena.org.uk>
In-Reply-To: <50d8ee72-9b5c-4abc-a230-2aeb6eddf03e@sirena.org.uk>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 7 Apr 2023 12:17:31 +0200
Message-ID: <CAMRc=Mc0HcMnuBqsN7ReNB5JTWR0C4FbMRRM9S7kqhW5otP5WA@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] regmap: Pass irq_drv_data as a parameter for set_type_config()
To:     Mark Brown <broonie@kernel.org>
Cc:     William Breathitt Gray <william.gray@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        techsupport@winsystems.com, pdemetrotion@winsystems.com,
        quarium@gmail.com, jhentges@accesio.com, jay.dolan@accesio.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 6, 2023 at 7:23=E2=80=AFPM Mark Brown <broonie@kernel.org> wrot=
e:
>
> On Wed, Apr 05, 2023 at 11:45:42AM -0400, William Breathitt Gray wrote:
> > Allow the struct regmap_irq_chip set_type_config() callback to access
> > irq_drv_data by passing it as a parameter.
>
> The following changes since commit e8d018dd0257f744ca50a729e3d042cf2ec9da=
65:
>
>   Linux 6.3-rc3 (2023-03-19 13:27:55 -0700)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags=
/regmap-set-type-irq-drv-data
>
> for you to fetch changes up to 7697c64b9e4908196f0ae68aa6d423dd40607973:
>
>   regmap: Pass irq_drv_data as a parameter for set_type_config() (2023-04=
-05 17:19:24 +0100)
>
> ----------------------------------------------------------------
> regmap: Pass irq_drv_data as a parameter for set_type_config()
>
> Allow callbacks to access irq_drv_data.
>
> ----------------------------------------------------------------
> William Breathitt Gray (1):
>       regmap: Pass irq_drv_data as a parameter for set_type_config()
>
>  drivers/base/regmap/regmap-irq.c | 8 +++++---
>  include/linux/regmap.h           | 6 ++++--
>  2 files changed, 9 insertions(+), 5 deletions(-)

Pulled Mark's tag and applied the two remaining patches, thanks!

Bart
