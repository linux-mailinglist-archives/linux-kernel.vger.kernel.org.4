Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C12874B637
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 20:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbjGGSZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 14:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbjGGSZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 14:25:58 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37732685;
        Fri,  7 Jul 2023 11:25:55 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fb94b1423eso3412936e87.1;
        Fri, 07 Jul 2023 11:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1688754354; x=1691346354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mvSuPmDBRkMUtbxeFEDKBqN/HUSlNbMkBzcYBqA7WAA=;
        b=c/5XYBUfXCROSHVrq4biJN4WXZqTwmXivTq7fzg2KTCqttVnlWpgN34Wmu6cEqwcnK
         UQh/SMHYn7YOdaIWguqT3UtojTOeDyhLCRTrzLT3SiO6O6LDJXI0j2rJGGL2w9JgCaJV
         /7v2NTXwCpbYFwZGNBnNCClo3hHyBA5thKSkkvXl/DN/ic80uWVNWxqAXHRCtc78+Upt
         qhPq7/DabVuoXm2Dm/Kj6NqT3tT7a95o6Gn8iKRGJQ7hBvngAGPq7JadUTvaGAMSASOR
         UrXhziD7xZkavK3QTN23Xg4rtluy8O6lFMqRHsdUEivdgEn+quL5N4l5MbvrXQWMyjZy
         w1Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688754354; x=1691346354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mvSuPmDBRkMUtbxeFEDKBqN/HUSlNbMkBzcYBqA7WAA=;
        b=KqFX3GwF4NmuN+HN0VX9hH5vKH8g/pSXd+71cvuwVaCUpb1ifFjX1ckjb1IYntc4Xk
         Ye6kxq5VR7jXiiwW4xu3/qD1+OzQ4qkhQOgleLX5JI4IaOZ2FW4QHi168vngDSn12jFa
         hB/iY4mR7CftaHNX6kqGoq6bPnJ6bhR/9F/MfazhL6uCv6vkR7rV1q6+vnY/QMX2sdks
         Bud0QdS4/VOPHkB2du7wdmUkLIA439+WYXHeMPJ0nJYs+cUrKJMyYcSzCBcxPESkfHY/
         ox1sbsFVqirxJUli8P/Qd+fmN1ksru0F58PJUpI+k9oHYakIc3/9J1WNNsUIyEnHz9TI
         6LBg==
X-Gm-Message-State: ABy/qLbZp1fu9qvfnOX6YhB2XSoXm0PbtSJejprP7Eema832c/aTQOlV
        AvgBa4pOEyeH+ZNnRdYkzM2+VPeGDh14lP9eMVs=
X-Google-Smtp-Source: APBJJlGuj4EgTrfcJLH8Pc0UZuGcgAEH6Y3fQwLS8xUkwJ5eWj/BMmo1okteYii023YGNDliWzcgY1LgtqFvubYZUMw=
X-Received: by 2002:a2e:9d45:0:b0:2b6:d9dd:f65f with SMTP id
 y5-20020a2e9d45000000b002b6d9ddf65fmr4102574ljj.17.1688754353772; Fri, 07 Jul
 2023 11:25:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230707140434.723349-1-ulf.hansson@linaro.org> <20230707140434.723349-4-ulf.hansson@linaro.org>
In-Reply-To: <20230707140434.723349-4-ulf.hansson@linaro.org>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 7 Jul 2023 20:25:42 +0200
Message-ID: <CAFBinCBT8yP5yZVOkQhkpQ0N83VO1Ctdm+npb91rLiv3KQz4ZQ@mail.gmail.com>
Subject: Re: [PATCH 03/18] soc: amlogic: Move power-domain drivers to the
 genpd dir
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ulf,

On Fri, Jul 7, 2023 at 4:04=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org>=
 wrote:
[...]
> --- a/drivers/soc/Makefile
> +++ b/drivers/soc/Makefile
> @@ -23,7 +23,6 @@ obj-y                         +=3D mediatek/
>  obj-y                          +=3D microchip/
>  obj-y                          +=3D nuvoton/
>  obj-y                          +=3D pxa/
> -obj-y                          +=3D amlogic/
I think this change has to be dropped (see below)...

>  obj-y                          +=3D qcom/
>  obj-y                          +=3D renesas/
>  obj-y                          +=3D rockchip/
> diff --git a/drivers/soc/amlogic/Makefile b/drivers/soc/amlogic/Makefile
> index 7b8c5d323f5c..c25f835e6a26 100644
> --- a/drivers/soc/amlogic/Makefile
> +++ b/drivers/soc/amlogic/Makefile
> @@ -2,7 +2,4 @@
>  obj-$(CONFIG_MESON_CANVAS) +=3D meson-canvas.o
>  obj-$(CONFIG_MESON_CLK_MEASURE) +=3D meson-clk-measure.o
>  obj-$(CONFIG_MESON_GX_SOCINFO) +=3D meson-gx-socinfo.o
> -obj-$(CONFIG_MESON_GX_PM_DOMAINS) +=3D meson-gx-pwrc-vpu.o
>  obj-$(CONFIG_MESON_MX_SOCINFO) +=3D meson-mx-socinfo.o
> -obj-$(CONFIG_MESON_EE_PM_DOMAINS) +=3D meson-ee-pwrc.o
> -obj-$(CONFIG_MESON_SECURE_PM_DOMAINS) +=3D meson-secure-pwrc.o
...as drivers/soc/amlogic contains drivers which are not moved (in
addition to the genpd drivers there's also SoC info and canvas
drivers).


Best regards,
Martin
