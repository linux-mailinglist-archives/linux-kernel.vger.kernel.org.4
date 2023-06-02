Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADC971FB57
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 09:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbjFBHsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 03:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233860AbjFBHsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 03:48:09 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7D4197
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 00:48:07 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-565ca65e7ffso17266327b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 00:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685692087; x=1688284087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YvKbLs2r6JPjvHYaqbpBSfWMO9ELDdpgKZ199OCUnN0=;
        b=eMkIv4uJJ0pcLg2uBFyJUdOnS1LUD9tqzovRH7qjVZE7Eb5xTsemA7Cx6FoNb36tfQ
         erAjpIWl6NNYjcsmwCQGbJBOYFvotY+UiCpNShWVkikDhDGGAx5M4yBv3g4e8qgpZiKM
         8ZYESUJcVII4AYI5qOk3LNy/3mAh4sNmot2Ds39HYeUVLQQS/zSL/nscS2fQypZq1yJ9
         B/NgntqVGcUAasdAYUE2PtzIMaGhkFZYdA3DbwTlgawdOvt+2i1ZiT7kjPmZ5WFQCe9i
         nCj3mxSBz/kClPK84oXKYliZoJufxxwagiyhfnpMMSTc5McwZfd5RILv+QchDRNlw+Gt
         lI3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685692087; x=1688284087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YvKbLs2r6JPjvHYaqbpBSfWMO9ELDdpgKZ199OCUnN0=;
        b=OV0/EhntCiBf8CnWvgbjBfRUy8tkfkn2gpyH918Ru2GN2ean6zLdAkVKqvk8cBWABU
         rBZXSxJHW4Ar0VcDkyfNfKqGFUbmIOrvDE2jLxnaKKUxoipDO6TFgrewurD9IzWBsal7
         +9FJZ13DIRgRDfNDP8ojwAzUYsL4KNqyxJzTzJK4Y9N0vnrpX+Qm6o6d0BRje+Yz0LJB
         KnbumW07YON2KDb4O2fi85FS1nG06ZbwNwhgsohMcsn6KZGeK9XqtTYdTV4AAdaL8Nmy
         8FA/yJvq/yox5Ht3BjSM8YZ3OlZZSTQzC34KDQ4TkVHi71O9we8AcHLNhtl/26JgaZKn
         Zg8g==
X-Gm-Message-State: AC+VfDxfgmUVSKKMaLW9Y/6jmbPX1wlyoCcnxpQJRkIDUTunQ/xG8MbY
        GRu+1BmFJfUqUnc1mTGTmOSyfApmGr0bUeUZL76/Ig==
X-Google-Smtp-Source: ACHHUZ69gxClkmiksXQX8sjlRTdOQo8hftIoEDxtpra+6UljIWPKkHEHblNpu41lJoSN0j9xow4szqJB4BRov4DsRlc=
X-Received: by 2002:a0d:d1c7:0:b0:54f:9cd0:990 with SMTP id
 t190-20020a0dd1c7000000b0054f9cd00990mr11133762ywd.18.1685692087002; Fri, 02
 Jun 2023 00:48:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230601152026.1182648-1-krzysztof.kozlowski@linaro.org> <20230601152026.1182648-7-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230601152026.1182648-7-krzysztof.kozlowski@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 2 Jun 2023 09:47:56 +0200
Message-ID: <CACRpkdbq3_g+i7Rn4QsXkSYv=sSeTHR3Mr7H02AaeGtsMoe5Qw@mail.gmail.com>
Subject: Re: [PATCH 7/8] pinctrl: qcom: organize main SoC drivers in new Kconfig.msm
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
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

On Thu, Jun 1, 2023 at 5:21=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> In menuconfig, some entries depending on PINCTRL_MSM are indented and
> expressed as dependening but some not, because of other Kconfig entries
> in between,
>
> Move all main Qualcomm SoC pin controller driver entries into new
> Kconfig.msm file so they will be nicely ordered in Kconfig file (by
> CONFIG_ name) and properly indented as PINCTRL_MSM dependency in
> menuconfig.
>
> Functionally this is the same, but since entire file is guarded with "if
> PINCTRL_MSM" drop this dependency from individual entries.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

This makes things look much better.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
