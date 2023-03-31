Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50276D203A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 14:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbjCaM0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 08:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbjCaM0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 08:26:37 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC9D1165F
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 05:26:36 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id r187so27168091ybr.6
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 05:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680265595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7t9CjXOgWpSz/pLs1pfLzGpzRhlP/Dqfbs5hEbKF6gY=;
        b=R9pkgLb7mWPyOZ4L56pd/LRhL33whlm4RfOyb6AVCPZWkOdCtX5pB/dGciOyJdNo1F
         UJ9pcp0won9n97KOfPlybTH/LHSNxMAYInpfBMlZIBO8nqSXv9jmCpJEKUD8FAH0SwBX
         Ix9VoBozTAXhOjygTOgTTC4TgIvzfv5kJc2ksMQBXrABeeSLHUe4eF7NNJX7kgWLcJVF
         NzPih5ISz8IsiDdp50m5JLj2HT3Gc/4FCE+UWkniarbN0EHy2Mbspjmh4FVULaEpzEQC
         WCrA/gP1+1rtJxgSTfjseWFYOLhirRHlUHSmttcSGDveDkeapU1hCtvwWzVs4L4B+SY5
         X8IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680265595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7t9CjXOgWpSz/pLs1pfLzGpzRhlP/Dqfbs5hEbKF6gY=;
        b=f4Ko3OAabbJMjRoV/vnxvEvw02pVzH4oHSppgU2K4bbkJgFSjiupPwR5LSus40x9xA
         KazQYATMS/GV2KbXygZTDVyHIdRpPZwZcCxR7N+3Ck+2uEBo655B+TWcXWbmcKUJ3ADW
         AYEjEl5MHGue62e9fUfNqIvDJK4IsiioBmAN7X3JmNCnsI5wXPz8FnXDDmqyL43Qtptc
         Z7DZD4PVD7QCnossA3cacb990hCsSiWZmINNG3Jjh5yzwivzMlkryqFnxgR75vEKn/BN
         puTSfrFT6Hjljrp+cOdjMLaz/zwLBTUPEGdez2+xdwiIygIc4mduEhraodpPAhxMnop0
         1aPQ==
X-Gm-Message-State: AAQBX9dpnGatNOWpSD4SGfx2ndtj+O7Fq2Ri4pqH7p+Ygj24ITORPTHL
        GEMdCgWpGsP1DOtxb3gISEBDF9J7hD5XG3efMUxiCg==
X-Google-Smtp-Source: AKy350aGmjtep9hI2AVm2TnZACla550tfInyXNn4xaLkBqIuJrOGxBjqFPRSg9J8V84Q1tehJLEqGdguSBByYK2io84=
X-Received: by 2002:a25:8712:0:b0:b74:3236:2fac with SMTP id
 a18-20020a258712000000b00b7432362facmr17176959ybl.4.1680265595278; Fri, 31
 Mar 2023 05:26:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230330100550.2049687-1-peng.fan@oss.nxp.com>
In-Reply-To: <20230330100550.2049687-1-peng.fan@oss.nxp.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 31 Mar 2023 14:26:24 +0200
Message-ID: <CACRpkdYb6PhGdeUuZvmiUDieZr+tAqO-Ls7+hJiaTgeoPCaAKg@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] dt-bindings: gpio: fsl-imx-gpio: update gpio-ranges
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, stefan@agner.ch, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 12:00=E2=80=AFPM Peng Fan (OSS) <peng.fan@oss.nxp.c=
om> wrote:

> From: Peng Fan <peng.fan@nxp.com>
>
> And bounds for gpio-ranges to address dtbs_error.
>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> V2:
>  Enlarge bounds to 32, since it max supports 32 pins

Saw this after already ACKing v1...
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
