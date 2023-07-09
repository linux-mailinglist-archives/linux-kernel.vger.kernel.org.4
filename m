Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A989774C7FF
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 22:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjGIUGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 16:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbjGIUGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 16:06:20 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7909C12A
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 13:06:17 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-666683eb028so1942414b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jul 2023 13:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688933177; x=1691525177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=84nuhO7uhc0FSqNYunVJq47COQFz0Z2aYuyBe1K3vhA=;
        b=ZZTQpVCaPBY6kWmMtfaIF7B+BomyDXOU9JXMfd0Ct8ykB/Mogy460AR/NtYs82aIg2
         2wWxGvffGzBYgdlLAddYDeMMHtzOGE9gk9KmZThMldhVJEgf27COiaqZ7Qj1xUF4LZqO
         5auR6RiPjgMx9lt/Mu9+eWS2WVv8Ss+IUtWBvPARWnSU5rURhYCFqGrOn+h+qcuhtycR
         x9t50B61y12Mc4A+wpZA3fM/lAXr9YOC1U5bMfe02sz2lIpc8S7zaKEBkBIDE1/+Wffq
         huZROIJpsVt8ur1zWv035MswYVyboXLThogcINuQqp0FQceP3oM8XluI6oIxLD0v8ADH
         5LVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688933177; x=1691525177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=84nuhO7uhc0FSqNYunVJq47COQFz0Z2aYuyBe1K3vhA=;
        b=foIrsGpMK8hKnHd5YweXYkRym95pLhsgP80W1310dIe50ceoFngrUwWUk7/rNElOOI
         x/7pjQzceE1PTbKxO2vFVlAZh9erHZAvCGtaZT3ETgQh6n7Lgk/aBIu6WTbu+pD9ms50
         +c+B+/6o3nUtfo/8hZNYmgXNiV7ZjNjRPpZIjzoceUIptQWhMgcQfIAumZ8AeyuXEAs6
         nk0sAw3j5p84cDBnv/Bg4J7Z36rXzdhyUT0AtQwPo2AgbJveRTbUjdlw3mdwq2dXlp0/
         Nv4DxwyD0tNyMZFSU+WI5cncKXM5NdNCcbSV+AARwHM2hbIVuj6FDrVkS9awZEFUEYfe
         5mwg==
X-Gm-Message-State: ABy/qLZOP6lEYBqcin369Vnbtovqk10+xTMYah5bDp7Su+MdgYXI7ZwO
        3ImfkRPxwu6mgLs+4hwm3twdKlLPzLnWQxQl6KwJdQ==
X-Google-Smtp-Source: APBJJlFf2cal+FNdbeg+7cyuRYOy/nxEObSk7pEWQEDzEx0l7y9JAlu9FGggVfloGLkKBiezlrd0egG4D4UZ9xVaj5o=
X-Received: by 2002:a17:90a:88b:b0:262:ff1c:bc37 with SMTP id
 v11-20020a17090a088b00b00262ff1cbc37mr8977376pjc.2.1688933176914; Sun, 09 Jul
 2023 13:06:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230709111451.101012554@linuxfoundation.org>
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
From:   =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Date:   Sun, 9 Jul 2023 14:06:05 -0600
Message-ID: <CAEUSe7_dcPNEMqCbd6r+f_zJypQ196MSxigq6i+5eSh3=vvDOQ@mail.gmail.com>
Subject: Re: [PATCH 6.3 000/431] 6.3.13-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Sun, 9 Jul 2023 at 05:18, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> ------------------
> Note, this is the LAST release for the 6.3.y kernel series.  After this
> is released, it will be end-of-life.  Please move to the 6.4.y kernel
> series at this point in time, OR let us know what is preventing that
> from happening for you.
> ------------------
>
> This is the start of the stable review cycle for the 6.3.13 release.
> There are 431 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 11 Jul 2023 11:14:03 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.3.13-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.3.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

There build regressions on Arm 32-bits, specifically omap1_defconfig:

-----8<-----
  /builds/linux/arch/arm/mach-omap1/irq.c: In function 'omap1_init_irq':
  /builds/linux/arch/arm/mach-omap1/irq.c:221:11: error: implicit
declaration of function 'irq_domain_add_legacy'
[-Werror=3Dimplicit-function-declaration]
    domain =3D irq_domain_add_legacy(NULL, nr_irqs, irq_base, 0,
             ^~~~~~~~~~~~~~~~~~~~~
  /builds/linux/arch/arm/mach-omap1/irq.c:222:13: error:
'irq_domain_simple_ops' undeclared (first use in this function); did
you mean 'irq_domain_chip_generic'?
              &irq_domain_simple_ops, NULL);
               ^~~~~~~~~~~~~~~~~~~~~
               irq_domain_chip_generic
  /builds/linux/arch/arm/mach-omap1/irq.c:222:13: note: each
undeclared identifier is reported only once for each function it
appears in
  /builds/linux/arch/arm/mach-omap1/irq.c:250:23: error: implicit
declaration of function 'irq_find_mapping'; did you mean
'iomem_get_mapping'? [-Werror=3Dimplicit-function-declaration]
    d =3D irq_get_irq_data(irq_find_mapping(domain, omap_l2_irq));
                         ^~~~~~~~~~~~~~~~
                         iomem_get_mapping
  cc1: some warnings being treated as errors
  make[3]: *** [/builds/linux/scripts/Makefile.build:252:
arch/arm/mach-omap1/irq.o] Error 1
----->8-----

Greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org
