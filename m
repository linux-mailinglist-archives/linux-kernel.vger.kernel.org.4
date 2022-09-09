Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D340A5B37BC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 14:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbiIIMY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 08:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbiIIMY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 08:24:28 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C538DF21
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 05:24:25 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id lz22so3597226ejb.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 05:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=a/QNA2ugiBfj/JrsH5nr1chbYMfF/AQ6Nq2ohVefuQc=;
        b=kV/tDS1JyHz3VU/TqzB+feXF1OCVJcIc5v9iVYTFXzJwqOsH1FakFl2RNzNZCU33Lb
         jxemN1hOMw7PFj5I5kdnA7JEHVDvGDuFc53N8df9RFwJbWlqadh9HasFEvfh8p9Cv8SH
         A1YFANiXbANkckWpFZsZglWHxFJlmRFYj7FnrrKF5tR8p1PgznfXlVIwKEhMAjuDF5Do
         YvyOhVgDcFa1JdtzDi6+mhqOxBq0MpUK4fz7Ok45dkIZiH2P11dhFE24Y//RD9CD6nrO
         gy0bn93/o3wP0/GchWvQ9yrVMIYKM+h2RS7XTfJlpsCWctbGH4yKy3p1vWHBaML6YlHi
         zC7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=a/QNA2ugiBfj/JrsH5nr1chbYMfF/AQ6Nq2ohVefuQc=;
        b=4i6nYNnCSvfRAj4RXrBy+rWb8mxMJ6noBap3I167zFBUymLkSJ5jx7YCcvoLTvydHd
         kkdFh/xyGqayT4RbQXT4BHRY4QNjZ9+wPNoQ9YVLzUVn2+ile24NQylmkIkwp2SGAzSq
         dEi1JgM1XIZO1hUBKMtsDOF32xgQD43TQTFSDz8zA1G/egg4mfstpxbhhYzv6jrDaKZe
         mj8CuL+tf7dvM7E2np6dIIVvzDUR8E1iKo8VzcbBJaAyzfQI6+WU9NSSTff60O3RCY5B
         hoqUt/G7k+1g7nk4qXYA6zaSXNysJDeu9MCAutpVkvIi8dSthZ63lW9FxV7476gNYmcU
         LeFg==
X-Gm-Message-State: ACgBeo2lnNxjzaccWpBgun5QCMqOBtLRAOUKkDy+3Sr/9/Xi+h8F1Ijs
        DE3DwSvAD9dGffy6+NbqDZrqmC4DTOsn0h3JcZDZEA==
X-Google-Smtp-Source: AA6agR4bp4ordUFJ9GfA6ar/9KhgIrwvHc/u68mfz0ax5EIwsCIWX1EnWnS0FZ9Qe2l6IlTyI52iyZt+TCDrz/uUXsg=
X-Received: by 2002:a17:907:7f8e:b0:770:7c67:f522 with SMTP id
 qk14-20020a1709077f8e00b007707c67f522mr9648310ejc.366.1662726263875; Fri, 09
 Sep 2022 05:24:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220906033957.4377-1-f.fainelli@gmail.com> <20220909073509.301363-1-naresh.kamboju@linaro.org>
 <51e6ea21-8af4-775d-1561-6671cfc50ecf@linaro.org>
In-Reply-To: <51e6ea21-8af4-775d-1561-6671cfc50ecf@linaro.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 9 Sep 2022 17:54:11 +0530
Message-ID: <CA+G9fYv79_BrWT28DVfu4JHasiOKMeL-Wr_MJapU5xeB5VomBA@mail.gmail.com>
Subject: Re: [PATCH] arm64: defconfig: enable ARCH_BCM
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     f.fainelli@gmail.com, andersson@kernel.org, arnd@arndb.de,
        biju.das.jz@bp.renesas.com, catalin.marinas@arm.com,
        dmitry.baryshkov@linaro.org, geert+renesas@glider.be,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        marcel.ziswiler@toradex.com, michael@walle.cc, shawnguo@kernel.org,
        soc@kernel.org, vkoul@kernel.org, will@kernel.org,
        lkft-triage@lists.linaro.org,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Benjamin Copeland <ben.copeland@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Sept 2022 at 13:08, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 09/09/2022 09:35, Naresh Kamboju wrote:
> > From: Naresh kamboju <naresh.kamboju@linaro.org>
> >
> >
> > On 2022-09-05 20:39, Florian Fainelli wrote:
> >> Commit 96796c914b84 ("arm64: Kconfig.platforms: Re-organized Broadcom
> >> menu") introduced a new symbol ARCH_BCM and made all of the Broadcom
> >> SoCs Kconfig depend on it, but did not enable it in the defconfig.
> >> Thus, now the defconfig doesn't include support for any Broadcom
> >> architectures anymore. Fix it.
> >>
> >> Fixes: 96796c914b84 ("arm64: Kconfig.platforms: Re-organized Broadcom menu")
> >> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> The patch was sent on 6th of September. Your report on 8th of September...

Understood !
Maybe off-topic,
Testing Linux next seems to be a bit late to report the regressions.
Our testing would have build and boot test devicetree/for-next or
devicetree / master branches to find early regressions.
or Any other well known maintainers trees.

Your suggestions are most welcome for improving Linux kernel quality.

Best regards
Naresh Kamboju

--
Linaro LKFT
https://lkft.linaro.org

>
> Best regards,
> Krzysztof
