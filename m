Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D4972548F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 08:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237689AbjFGGnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 02:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237700AbjFGGnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 02:43:04 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6385F1732
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 23:43:03 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-565eb83efe4so90961217b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 23:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1686120182; x=1688712182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dsg7fMeOwWf6duFi3SL6qXsSugXJIk0Q5FLHDNP0ztQ=;
        b=kVd/MnqaoIb5oxrldwJ5KKFEpysXJo1vKiAhaP19lZrkPC6P9oUh93qci0bfIU3RYr
         FOzKnA6wBqU6vXDEPXVRMXQ54vUNAsclDBESzc7L+maa4WBFhljs6Xr+L827WRe4vcD/
         aB9DVry9wy72Eh4u11rbQThzzLKuFbWeSnLWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686120182; x=1688712182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dsg7fMeOwWf6duFi3SL6qXsSugXJIk0Q5FLHDNP0ztQ=;
        b=Z7Gw8gvUS4ne/CinCr/1DJobj6om6YL6Fdb4BVTAN6KSSqedrQluzkBsvhvCtz6yo4
         pEMS5PMbq4xmoj7oVLMT9WM4bVaEjW+EQRDE1OdMbPyXVaJZ9XCrH6L9SRspNIZiQTUc
         PWAmWQNBtiav1tu0VZjYzbqC/BZVan+vKIUF1IPZFT8dMx8ddnRd4i/ZNKODTGTQKKK2
         T766UT5O3sNP/L9LdNOanwniao7ngxvaOToXVaLWkUF50dmbYYn5UKhOFsXWSpxTZGFZ
         N1jdXt38WG508mAjWPQ3lBtP/Iqg9TY6AqBJqDnzqyROxrO2SKY/9101Tqn4hx7YNZsW
         ri1g==
X-Gm-Message-State: AC+VfDyP2vnsZFstzPSKQBKTP//POSPYp+U3I/QOBD/SeONAyFtA9ymB
        F7rcIQudGdlOqSbLUTG32Y3Gd4qUEjP02fQeybjUqQ==
X-Google-Smtp-Source: ACHHUZ6sjnQG6odBG4w0qQkBK4LJZGwQU7CqikJozkVHCbSGSE0jcdrkgzVwr1fXZBKKMsum+q741mo0WSCe/CRDp74=
X-Received: by 2002:a81:8450:0:b0:565:b22c:4165 with SMTP id
 u77-20020a818450000000b00565b22c4165mr5933812ywf.11.1686120181918; Tue, 06
 Jun 2023 23:43:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230607063139.621351-1-dario.binacchi@amarulasolutions.com> <20230607063139.621351-4-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20230607063139.621351-4-dario.binacchi@amarulasolutions.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Wed, 7 Jun 2023 12:12:50 +0530
Message-ID: <CAMty3ZDCkQ_T+j96iXtMAhkOLFBm=hZHk=sZzSGA=MOQQUOv7g@mail.gmail.com>
Subject: Re: [RESEND PATCH v2 3/6] ARM: dts: stm32: support display on
 stm32f746-disco board
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org,
        Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        michael@amarulasolutions.com,
        linux-stm32@st-md-mailman.stormreply.com,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
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

On Wed, Jun 7, 2023 at 12:01=E2=80=AFPM Dario Binacchi
<dario.binacchi@amarulasolutions.com> wrote:
>
> Add support to Rocktech RK043FN48H display on stm32f746-disco board.
>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
>
> (no changes since v1)
>
>  arch/arm/boot/dts/stm32f746-disco.dts | 51 +++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>
> diff --git a/arch/arm/boot/dts/stm32f746-disco.dts b/arch/arm/boot/dts/st=
m32f746-disco.dts
> index c11616ed5fc6..cda423b6a874 100644
> --- a/arch/arm/boot/dts/stm32f746-disco.dts
> +++ b/arch/arm/boot/dts/stm32f746-disco.dts
> @@ -60,10 +60,41 @@ memory@c0000000 {
>                 reg =3D <0xC0000000 0x800000>;
>         };
>
> +       reserved-memory {
> +               #address-cells =3D <1>;
> +               #size-cells =3D <1>;
> +               ranges;
> +
> +               linux,cma {
> +                       compatible =3D "shared-dma-pool";
> +                       no-map;
> +                       size =3D <0x80000>;
> +                       linux,dma-default;
> +               };
> +       };

This looks unrelated to display enablement, isn't it?

Jagan.
