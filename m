Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8F17245ED
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237864AbjFFO16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237857AbjFFO1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:27:38 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188C81718;
        Tue,  6 Jun 2023 07:27:33 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-75e1ec47c3fso203995185a.2;
        Tue, 06 Jun 2023 07:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686061652; x=1688653652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJyXRnfhFkINlRUyK+QjXtrQLlNiUgrBBt6eFT43tDY=;
        b=DNd/kMiQRIIQpg04PdEmqFSvnHjgjCWWhVR5no38lxjnNhirVN2K9CbYPzqU34l9HC
         4oY2+6+thwYUX0PPIhTr/L4Hw4d/PLCfB2HjnuYOu9iSLckigw2Al9668tqy4uY6ptZ/
         jRYZawCtxngClpopfSoBCb3QXh3SP6HwP70WMlJ2qqCHYmTr9LL79QzOVEpyK5//ZszG
         WeGP6VB9o7Ap9Zngfc0Q/tR1Ixd7zM3x2iMC3ZmidCQ5DLRH5Ic+hAFHmTFlufhfcAZB
         SlOP+dzX4zKX3Z92EBaTarlF70/W2RCNEKEEsmMo3J2kG4bBOg63isEJNDY7/FcYkZj3
         tOvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686061652; x=1688653652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JJyXRnfhFkINlRUyK+QjXtrQLlNiUgrBBt6eFT43tDY=;
        b=UKodVvWFhNkKTMcVQ40iSozF+0hOgWgZE3uXVbT+J5DjzcJdr1Bhrv2x8Ga0WeAWP0
         pZUOTWl3L3ZLYyYJsho0MEgiWLUmtzzlQQ8FSxaaTT6OHwctBgaWupRriKu4BvILILvJ
         JId5mxkqV+S9Rkjt9R/bW6tlHOkgtEJnT3NNQ49CWD+Lr8lVrmCVFwjLNPQ1c1cCOuUC
         p6qCAxZax9YjfXcD21qeZzNWPMXoj1TUxiDh/Hiu/Bu6mfCbpRQz4z5NZLlrHFbdf3TD
         rNvyyEXlk7HpaPPqOAmLO1Er7fnAbxOU8+QVY+jU4xxGRi2UYblQbQESDdzbNuMrNc6T
         SxCQ==
X-Gm-Message-State: AC+VfDwUFdWU/Sa9ACsitCOFa98HYPnJ/ZbwP2r8t2ncbfbFu7+cYwPD
        9dZssViTCvf9Q6jnLCRIDa3G6e5vhCS4HvXUaeo=
X-Google-Smtp-Source: ACHHUZ5b/yKHVwPJvcasJ5lXLQxqrPkVm3aDYAuuKbySUu8+FKz3bUdCkTR/5IOsfuz7EdzPJ+nrvky5PEJFSPFM1PU=
X-Received: by 2002:ad4:5bc6:0:b0:62b:2d61:f696 with SMTP id
 t6-20020ad45bc6000000b0062b2d61f696mr2488357qvt.42.1686061652049; Tue, 06 Jun
 2023 07:27:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230601152636.858553-1-nm@ti.com> <20230601152636.858553-4-nm@ti.com>
 <f1e54167-15bd-8a0b-454d-53b90b18a343@ti.com> <20230605204930.3hlg3d36zwtbkal7@scone>
 <cbd314b6-08a9-7a07-7538-c2e3f1b333e9@ti.com>
In-Reply-To: <cbd314b6-08a9-7a07-7538-c2e3f1b333e9@ti.com>
From:   Robert Nelson <robertcnelson@gmail.com>
Date:   Tue, 6 Jun 2023 09:27:06 -0500
Message-ID: <CAOCHtYiV68syEKU9+rhuFntAX1wHw5KBJ8Zcp2eN-hPJjV2x6Q@mail.gmail.com>
Subject: Re: [PATCH 03/12] arm64: dts: ti: k3-j721e-beagleboneai64: Fixup
 reference to phandles array
To:     "Kumar, Udit" <u-kumar1@ti.com>
Cc:     Nishanth Menon <nm@ti.com>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
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

On Mon, Jun 5, 2023 at 11:27=E2=80=AFPM Kumar, Udit <u-kumar1@ti.com> wrote=
:
>
> Hi Nishanth,
>
> On 6/6/2023 2:19 AM, Nishanth Menon wrote:
> > On 22:31-20230605, Kumar, Udit wrote:
> > [...]
> >>> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts b/arc=
h/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
> >>> index 37c24b077b6a..c13246a9ed8f 100644
> >>> --- a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
> >>> +++ b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
> > [...]
> >>> @@ -639,7 +639,7 @@ &main_i2c6 {
> >>>    &wkup_i2c0 {
> >>>     status =3D "okay";
> >>>     pinctrl-names =3D "default";
> >>> -   pinctrl-0 =3D <&wkup_i2c0_pins_default &eeprom_wp_pins_default>;
> >>> +   pinctrl-0 =3D <&wkup_i2c0_pins_default>, <&eeprom_wp_pins_default=
>;
> >>>     clock-frequency =3D <400000>;
> >> Why we need more than 2 pio lines for i2c node ,
> > pio lines? I am not sure I understand. If you are suggesting
> > eeprom_wp_pins to be moved to the eeprom node, It is probably
> > un-related to this series, but OK, i think it is probably a valid
> > change (unless Robert sees a reason why he did it the way he did).
>
> correct, I am suggesting to move  eeprom_wp_pins_default to eeprom node.
>
> i2c needs 2 lines which are defined in wkup_i2c0_pins_default, Adding
> eeprom_wp_pins_default will not be true representation of i2c node.
>
> It will be good to have similar changes in main_i2c1 and main_i2c5  node
> for csi0_gpio_pins_default and csi1_gpio_pins_default.

I agree, moving eeprom_wp_pins_default into the eeprom node itself is
much cleaner going forward.

While we may have a lot of historical situations in the git tree where
we just dumped all pin configurations into the base node, that's not
the best practice going forward today.

Regards,

--=20
Robert Nelson
https://rcn-ee.com/
