Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0DA6F5532
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 11:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjECJtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 05:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjECJtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 05:49:00 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAB35B92;
        Wed,  3 May 2023 02:48:14 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-74db3642400so448558985a.2;
        Wed, 03 May 2023 02:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683107293; x=1685699293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tLkQD32F3IyzI9nuizEgzw57kW3UmWyAr9AlLHhtw/w=;
        b=EzxTxtGSL3zdYaLaEhs72pGdeB0Zra/NxBtuqx7f8JwACc+XbqYDu37vlb6u8y2ohO
         qFcW7MytFMXf+78FAiD9S0g4DGsNZy72i4FbVuz35UOrbuwStgOCmqwrj4VcNyr5DKWD
         GdYS3KBu1ib4z11kTk8ZXXSNDyejh6T0UTLt2HsiKQf3xBZdYVJGS5GPCR7aTbCXS6AL
         rfW8XO2hv5VC4eItvnc2zXcZIZtMlIxCt/7kKRh7pGOr71A6bBmnfp854IRTfyIWs1La
         dKT3bN4+F73RsM1MnR5CFo/fpM7zEk9ALtzvcZJDKxfYq/oQKvW0iC5wq++VrhEdy0fs
         gDvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683107293; x=1685699293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tLkQD32F3IyzI9nuizEgzw57kW3UmWyAr9AlLHhtw/w=;
        b=OaUOjUHzaDjm5oAK+CTaeE0MXMYZ/KCQil9Z7HWdqC7Lt4/IW7sycwz0XQRBY/8Dne
         8y5KMFOZbrWFDb+u2JmSl/vV6YX84vYGkF2U7zniPHLSX6wz3hQcLdT10v31GNiyEZCh
         EPPxrwb/s3QfaeLR4YEHDRSU4blc3zM72s3zAUKcx3rwON5LpvoPu4wedDYAUev9hH6O
         t7wMzj5TFehb3GphonZaAurWehmfgRTxkpIVV4rQ9/2v2AALLNB2xkkrKkcGge2qNElj
         CM2XPeSE63d+h8kSus4s/I4JJr/07hI5qrw/KNYnvTGzrL2AIcGz2I4xk1NzMD0i3HwA
         gksg==
X-Gm-Message-State: AC+VfDzJsYsd4Hok4KC7stH7zNF9SMnVrzSg8QjtkamTz0vidZ5LWlkf
        IO66+J+a9KtrxwB+czvPmfpkp8uBu9L7A8gsYUo=
X-Google-Smtp-Source: ACHHUZ4Q5WQUaumtaNYI49nhQWXJyCnvaZUIKU+GwPX9rXu7Tuv0i4XSm6dxaPFhw0f4LYxtCet8Vcp57kX3RfIVqac=
X-Received: by 2002:a05:6214:5012:b0:5ef:45a7:a3c0 with SMTP id
 jo18-20020a056214501200b005ef45a7a3c0mr10842556qvb.27.1683107293366; Wed, 03
 May 2023 02:48:13 -0700 (PDT)
MIME-Version: 1.0
References: <1683092380-29551-1-git-send-email-quic_rohiagar@quicinc.com> <1683092380-29551-4-git-send-email-quic_rohiagar@quicinc.com>
In-Reply-To: <1683092380-29551-4-git-send-email-quic_rohiagar@quicinc.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 3 May 2023 12:47:37 +0300
Message-ID: <CAHp75Ve0FqX7=x3B5eaCfj0AE5m1qMXGrYzLoHzqbLY7gdOSOg@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] pinctrl: qcom: Add SDX75 pincontrol driver
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linus.walleij@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, richardcochran@gmail.com,
        manivannan.sadhasivam@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
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

On Wed, May 3, 2023 at 8:39=E2=80=AFAM Rohit Agarwal <quic_rohiagar@quicinc=
.com> wrote:
>
> Add initial Qualcomm SDX75 pinctrl driver to support pin configuration
> with pinctrl framework for SDX75 SoC.
> While at it, reordering the SDX65 entry.

...

> +#define FUNCTION(n)                                                    \
> +       [msm_mux_##n] =3D {                                              =
 \
> +                       .func =3D PINCTRL_PINFUNCTION(#n,                =
 \
> +                                       n##_groups,                     \
> +                                       ARRAY_SIZE(n##_groups))         \
> +                       }

Or even define

  #define MSM_PIN_FUNCTION(fname) \
      [msm_mux_##fname] =3D PINCTRL_PINFUNCTION(...)

in the header for all MSM related controllers.

All the same for the rest groups (if any), otherwise use redefinition
of FUNCTION inside each file.

--=20
With Best Regards,
Andy Shevchenko
