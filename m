Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D98766A2BAE
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 21:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjBYUhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 15:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjBYUhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 15:37:19 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46AE31588C;
        Sat, 25 Feb 2023 12:37:18 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id d10so1466391pgt.12;
        Sat, 25 Feb 2023 12:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sxttv6I+juTLKjiPxUsAPsaTJ+ru7lbKlN1o0tA6Ttk=;
        b=TVGuJQu9OPuKz6WsX33OyO5hO+0ti3VM+iAzzRzXygnaHM+ubOkEZdX9oxRv0hiZES
         p93VxwPdeblq+8sGn5Bc05UKYRQrGgmFfLwFGlgXj6/QOi0GPe8FchLEE+Dq+JOTCSsG
         6tt3Uj65Ht42AGOQnsutJWv1plH+P8dOUibjoghLBTUg9XbtO7ojmy/wIR9qSua2BQD+
         97MLRypHHttjn0WOA3fxvrXdwRHs7+iJrkuKR9rcBhlXcQxQlEC8jhQxDc3c42YPPDWT
         kqXLzhHKgQtYT5iKbJg5yV4PzKhgw1fAkorQMztEVJ7zKRrny3bcvUgHoNVrT4fiuMgt
         nCoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sxttv6I+juTLKjiPxUsAPsaTJ+ru7lbKlN1o0tA6Ttk=;
        b=4pz7t2vfeXz1Gtuu3zswW4GQCFGqlMvEplreTr67bX2i/KhSU7FaEmE2Qbml+QAY6A
         CAUx0jay16rxmGoO0ZbvfnNrEglWW/S29V7Xrt4pFVS30mKMLAmnR5rcdPi7gZWY5J0m
         DRDTieSDnbmEND2Tq/vXtJnaDfvE2w1YZ2OPxTqkmJdCfu82awE54Rv+IDc+qax1yLjp
         f/okD7iHmH0r20nS1Cy4mCczsNhmeDqyXfawhyFGRCORxE802Lux58KHx66RdSF8pULC
         xc0NmCO9ik8q5a1fezeYaWeOYwp2nn5cYezKn/1OYWfXXlMDaADh9FkLc1IpYlfdVb4T
         kxQw==
X-Gm-Message-State: AO0yUKVoDSWQZ6WbxXQDIDSjUcPii3qGwNPv/mzRkBbTSS9pGKsGMPDG
        J7VyV/+dtRbVDZQHFjI8saGG6RvncinjxJnUrIg=
X-Google-Smtp-Source: AK7set9m9zmBMybskn4/CtRVzmIsYcxR2iEnJLjJAJ597qgl75EBPE7Bor64uS4fMm70NlLYZO66s2ej2qn7jT8KgPM=
X-Received: by 2002:a63:7a54:0:b0:4fb:3896:a7d4 with SMTP id
 j20-20020a637a54000000b004fb3896a7d4mr4114625pgn.7.1677357437775; Sat, 25 Feb
 2023 12:37:17 -0800 (PST)
MIME-Version: 1.0
References: <20230225113712.340612-1-alistair@alistair23.me> <20230225113712.340612-4-alistair@alistair23.me>
In-Reply-To: <20230225113712.340612-4-alistair@alistair23.me>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sat, 25 Feb 2023 17:37:06 -0300
Message-ID: <CAOMZO5COg7wZbG3aWcwMsvTBQ9Ft8CQ9wearXMh+00o29CTaeg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] ARM: dts: imx7d-remarkable2: Enable the rohm,bd71815
To:     Alistair Francis <alistair@alistair23.me>
Cc:     s.hauer@pengutronix.de, devicetree@vger.kernel.org,
        shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        arnd@arndb.de, alistair23@gmail.com, kernel@pengutronix.de,
        jernej.skrabec@gmail.com, linux@armlinux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 25, 2023 at 8:37=E2=80=AFAM Alistair Francis <alistair@alistair=
23.me> wrote:

> +&i2c2 {
> +       clock-frequency =3D <100000>;
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&pinctrl_i2c2>;
> +       status =3D "okay";
> +
> +       bd71815: pmic@4b {
> +               compatible =3D "rohm,bd71815";
> +               reg =3D <0x4b>;
> +               pinctrl-names =3D "default";
> +               pinctrl-0 =3D <&pinctrl_bd71815>;
> +               interrupt-parent =3D <&gpio6>; /* PMIC_INT_B GPIO6_IO16 *=
/
> +               interrupts =3D <16 IRQ_TYPE_LEVEL_LOW>;
> +               gpio-controller;
> +               clocks =3D <&clks IMX7D_CLKO2_ROOT_SRC>;
> +               clock-output-names =3D "bd71815-32k-out";
> +               #clock-cells =3D <0>;
> +               #gpio-cells =3D <1>;

The binding document says #gpio-cells =3D <2>;

> +
> +               regulators {
> +                       #address-cells =3D <1>;
> +                       #size-cells =3D <0>;
> +
> +                       buck1_reg: regulator@0 {
> +                               reg =3D <0>;

The regulator@0 and reg should not be present.

Please check Documentation/devicetree/bindings/mfd/rohm,bd71815-pmic.yaml
