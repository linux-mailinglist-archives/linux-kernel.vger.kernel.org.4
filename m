Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 873FD74130C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 15:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjF1Nvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 09:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbjF1Nvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 09:51:41 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30DED1715;
        Wed, 28 Jun 2023 06:51:40 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-51cb40f13f6so6523669a12.2;
        Wed, 28 Jun 2023 06:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687960298; x=1690552298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=47IYkdpu8yyPGp2Uw3op/mpBh+Ym1Oi6bcaaWezzn1E=;
        b=D+yDDjaj08Lfk0gRAmdyuBFxPZwulZrHYg4rkIeU2wF3UZTlFcHeC45dj06ctGhhBa
         eEnUTDEDK30rDE4AZ65yw4Pq42bKnsQbtWOE+lKOsDjCpQjUfv85Bkdces8k2/xNDjrB
         orgtKf+PyUx0w3zRuOkFS5LmqNp46OajNpRNMz9lr90ivujXc7lzdPNQe30oVbOT/jna
         MaLvv8P4G9IdW5B9lOdj/A+iF9t90xScjnrYMiSvuJ7DitMfFB+Im1FYBPmHQhUD38PT
         SJ6i6DIP68YT6OGNbcv5zoarFd7WhefIGddqBKcxu7Lehyf4Zul11U4lm+kbIyhi00sN
         O+2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687960298; x=1690552298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47IYkdpu8yyPGp2Uw3op/mpBh+Ym1Oi6bcaaWezzn1E=;
        b=hFvAP7N0oralV0TdPJbYc2QzpIRpO4KM6vKd8YAnmFr2tCe65wUOuKx1aTx2HrUX1q
         P4Yyao/ItWUDpuNLA7GhJts31LZfEInwYzBeBxukzJTEMuoMeb8u/mjm7e3RkavfAmCa
         EqPNSqMg4XohcjuxjscnIlzrvHqStX7kJLwCHwi5Xhv0QeWkW+ZXY7puHko6kd5xgkRY
         QxR/gAT2jZx/WLC1o/XvutxrtERvFazpJIWaGvhIV/uv7HMgoj6LuFqgiqZt03alF+0d
         GYtcWS0W6R2g4t3sSJC/foTiLrz3j66s+hvRaQLcWhkHvIZlJETR+EPZ2LE83QMAy8oK
         gT5w==
X-Gm-Message-State: AC+VfDxiXM9BHdu0WGNQEgXcxGfT1pjyuEYB8ELfJLkancDJrlIpDM1t
        t7nslYtPpxZSUQA0zNC1mIFjHfGnBUgxW91HNB0=
X-Google-Smtp-Source: ACHHUZ5/aml8Qro0WjiQrCcQZmHN9izrK6AaqhR4lEJ48L/5d/n5iBniCxNMSgrvF0j73g6sDIK3dXC3q1vQIgID0AE=
X-Received: by 2002:a50:ee96:0:b0:51a:3334:f88b with SMTP id
 f22-20020a50ee96000000b0051a3334f88bmr26148972edr.10.1687960298500; Wed, 28
 Jun 2023 06:51:38 -0700 (PDT)
MIME-Version: 1.0
References: <1687955688-20809-1-git-send-email-quic_mojha@quicinc.com> <1687955688-20809-6-git-send-email-quic_mojha@quicinc.com>
In-Reply-To: <1687955688-20809-6-git-send-email-quic_mojha@quicinc.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 28 Jun 2023 16:51:02 +0300
Message-ID: <CAHp75VcTZRdNOdgjekCMxu-GvSCiw669SnEdyL=hO0SHLkZL2g@mail.gmail.com>
Subject: Re: [PATCH v4 05/21] soc: qcom: Add linux minidump smem backend
 driver support
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     corbet@lwn.net, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        mathieu.poirier@linaro.org, catalin.marinas@arm.com,
        will@kernel.org, linus.walleij@linaro.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 3:35=E2=80=AFPM Mukesh Ojha <quic_mojha@quicinc.com=
> wrote:
>
> Add shared memory based minidump backend driver and hook it
> with minidump core (qcom_minidump) by registering SMEM as
> backend device.

...

>         help
>           Enablement of core minidump feature is controlled from boot fir=
mware
> -         side, and this config allow linux to query minidump segments as=
sociated
> -         with the remote processor and check its validity.
> +         side, and this config allow linux to query and manages minidump

allows
Linux

> +         table for remote processors as well as APSS.
> +
> +         This config should be enabled if the low level minidump is impl=
emented
> +         as part of SMEM.

...

> +#include <linux/io.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> -#include <linux/io.h>

Yeah, the result of wrong order in the initial commit. Can you fix it there=
?

...

> -#define MINIDUMP_SS_ENCR_DONE  ('D' << 24 | 'O' << 16 | 'N' << 8 | 'E' <=
< 0)
> -#define MINIDUMP_SS_ENABLED    ('E' << 24 | 'N' << 16 | 'B' << 8 | 'L' <=
< 0)
> +
> +#define MINIDUMP_REGION_VALID     ('V' << 24 | 'A' << 16 | 'L' << 8 | 'I=
' << 0)
> +#define MINIDUMP_REGION_INVALID           ('I' << 24 | 'N' << 16 | 'V' <=
< 8 | 'A' << 0)
> +#define MINIDUMP_REGION_INIT      ('I' << 24 | 'N' << 16 | 'I' << 8 | 'T=
' << 0)
> +#define MINIDUMP_REGION_NOINIT    0
> +
> +#define MINIDUMP_SS_ENCR_REQ      (0 << 24 | 'Y' << 16 | 'E' << 8 | 'S' =
<< 0)
> +#define MINIDUMP_SS_ENCR_NOTREQ           (0 << 24 | 0 << 16 | 'N' << 8 =
| 'R' << 0)
> +#define MINIDUMP_SS_ENCR_START    ('S' << 24 | 'T' << 16 | 'R' << 8 | 'T=
' << 0)
> +#define MINIDUMP_SS_ENCR_DONE     ('D' << 24 | 'O' << 16 | 'N' << 8 | 'E=
' << 0)
> +#define MINIDUMP_SS_ENABLED       ('E' << 24 | 'N' << 16 | 'B' << 8 | 'L=
' << 0)

For all these, please use format like

#define MINIDUMP_SS_ENCR_START    0x.... // STRT

...

> +static int smem_md_table_exit(struct minidump *md)
> +{
> +       struct minidump_ss_data *mdss_data;
> +
> +       mdss_data =3D md->apss_data;
> +       memset(mdss_data->md_ss_toc,
> +              cpu_to_le32(0), sizeof(struct minidump_subsystem));

Do you need cpu_to_le32() here?
Can this be on one line?

> +       return 0;
> +}

...

> +

Unnecessary blank line.

> +module_platform_driver(qcom_minidump_smem_driver);

...

> +       smem->minidump =3D platform_device_register_data(&pdev->dev, "qco=
m-minidump-smem",
> +                                                     PLATFORM_DEVID_NONE=
, NULL,
> +                                                     0);

Why can't room on the previous line be used?

> +       if (IS_ERR(smem->minidump))
> +               dev_dbg(&pdev->dev, "failed to register minidump device\n=
");

--=20
With Best Regards,
Andy Shevchenko
