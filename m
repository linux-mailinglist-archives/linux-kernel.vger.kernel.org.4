Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260746C618C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 09:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbjCWIX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 04:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbjCWIXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 04:23:23 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07324CC0C
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 01:23:21 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id y5so23879081ybu.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 01:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679559800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k0Uj1D6Vqv6eak6KS2dw5QFFUEfJrY+AgAxpx6hngss=;
        b=aeJEBmKYCou/2yRAhdrhEFObNMaQFg/4BWZrhU3vILJzHRL71UsWpxr4B8Wd16IORd
         d+sQ+X4oT1/Dy1afmOCOEeHYl91vNz+QIDJxYMQafU011ZH7x14k+mDHdbbYe6PrSeBC
         oe7dnnNpivzS368qIdpPFl3eNt5oHn5Tb5CUuLjUBnTQuNYzfetoDCLC+wRuK6UsY2II
         3T255Itm6cM9tmSgN39G6V9B4TZlGCRvIIz3Vjt5oZJbIuW4CSKnp6sxVNJ5jEQkFI7j
         5ozs8GDgzqo/Ma5SKiHcuoWx0oima6ShmRymvHWJqHWiIoamtRaDH8E6jG0IwawnhtWj
         oDdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679559800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k0Uj1D6Vqv6eak6KS2dw5QFFUEfJrY+AgAxpx6hngss=;
        b=Ya7Ey1BJuScOnv/OWl3IHnSrRx5U1sXmkbRcvmnorzjfCOZwbTq224nXTTyQirooEz
         1edfClmwSDIfWE5g8bNCKuVSbOgk5tNgvr1iAQ7F1Eqqq+4UuDW1ekAzNMVayAjFXlbB
         HkIvNZFwBgPa4oDl65+4GlH5zWtLhk0a4Ta6kQ5eGWR5J9bxJQDsCVhq8IGuBQx3k6Ta
         4BN7oAzwi/nPTKb5Rkkl9haYS1vigxNrZIA5N/X9+BgsG1HgMaSDdur1uLzH2Lq4lJz1
         QToKNbCKvTf8WhrxsytwX+O2X4fO1KJKWuUPHFpOsAnfJpBp/L3zIc7DriZDI9i6OdcC
         j4sQ==
X-Gm-Message-State: AAQBX9dUDr/m5bUbLJ2cJs8LHG9gnMjdhMLZtBT/t4BTzzsylNEZqdRp
        6/7ukuXCyQOnJumY/N3NXo5FLf4R/YWSd/c9rxmMwA==
X-Google-Smtp-Source: AKy350YPGJ35B9iOe8VCljZyntYq/QtonM0DlTvDbtRALy1W0Ec0fsVbAquagmZ2Q4I46+NueAFlfzuUhJ0Qb17jOC8=
X-Received: by 2002:a05:6902:1005:b0:a6b:bc64:a0af with SMTP id
 w5-20020a056902100500b00a6bbc64a0afmr1780411ybt.4.1679559800269; Thu, 23 Mar
 2023 01:23:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230314183043.619997-1-brgl@bgdev.pl> <20230314183043.619997-13-brgl@bgdev.pl>
In-Reply-To: <20230314183043.619997-13-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 23 Mar 2023 09:23:09 +0100
Message-ID: <CACRpkdanAd8J2b4Ky=2jmwchVi9_yojnUQoM1OrzW79_inFV4A@mail.gmail.com>
Subject: Re: [PATCH 12/14] dt-bindings: pinctrl: qcom,pmic-gpio: add
 compatible for pmm8654au-gpio
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
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

On Tue, Mar 14, 2023 at 7:31=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Add a new compatible for the GPIO controller on the pm8654au PMIC. It
> has 12 pins with no holes.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>

Bartosz are these two something I should apply to the pinctrl
tree or will you queue them?
Either way:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
