Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5C66EC17D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 19:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjDWRvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 13:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjDWRvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 13:51:44 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66CB10D4;
        Sun, 23 Apr 2023 10:51:43 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-506bdf29712so26744774a12.0;
        Sun, 23 Apr 2023 10:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1682272302; x=1684864302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OA0ppbVgL5FeMNHPio5HwgD93aIrdhW8q22dK3Sz1m8=;
        b=ZVd9skx5EC78EZ/AC/SRBNS4+B9YWd9oI4M0XgTPfk1aTDz+EcXCxgtvSRsgLwZE0g
         RbGv4QfbletmBUdzVzTYzs7DFphjS6D4nSWWoXu+bzIIl2AFTpm1W7M4NKaxBZ7MBFOU
         alOpH++YX2Rf/T8fKxya9VwiLUyD/whXd3+Q7ke3Vln1sYJCq9Ro83iUsUKMj66x+LYk
         ilAt0mg9ZSTZVWfBw6vL5WM7/ODG+Eaib6Mv9Ju9IyJsHCXaNyEpTMZ7QirpZ1VQNvqb
         q9hZDglC8rBr47BOYsF4oEuGrwOeegcY0CVa57kTZixVIw2Uf0UR1r4m6sriIKQXGS2x
         X/gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682272302; x=1684864302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OA0ppbVgL5FeMNHPio5HwgD93aIrdhW8q22dK3Sz1m8=;
        b=IHSaMGRy8s0QoGR6rKbPC+H0OCtwV27es4ZvT2F+P2nBMx/PvcCsT8WUVaTcEVvsRa
         aJlXiyiMrEdc56j6jT5QDHSleRdcUuIVh1A80UOFrRUY5b4yJMnn3bhhUu5DmxLULnAk
         5ICHPUI05WhnaRJ81NdmG1OnVLwPWMb8pvaBLI3yjjA4KTdRIgcmq80HCRodjvVdDB54
         3y5szOdcF4iudX+ijzr6dAD0IwJP2A+kLzb3tjKNKf+9fPv0CSFq1wBeTvPYnkcmBE6+
         NLAdwxEuRizRWckslbiF5ce0//Ud66QQkHdUEBh3OqCby0an1/Ydwhe8oSctcl2jXmX8
         mPVA==
X-Gm-Message-State: AAQBX9edop23wIYtpfc5Xze6FQe4g0M6mbN8cu01JNime6lXxzH3vWBC
        8NE4pzjzAsyDnhvAS+XPpoZ5qqv421Mr6cTKOQg=
X-Google-Smtp-Source: AKy350buw6nrgnBr18y3RmSiYBmXWUb6v+A+eUdQ7uLO+M2UVAlnBUQR6+EkfMNJsCXYdFUMbla70TBWYcZhFUkUvRU=
X-Received: by 2002:a17:906:a44f:b0:957:28ed:aeb5 with SMTP id
 cb15-20020a170906a44f00b0095728edaeb5mr7755510ejb.9.1682272301997; Sun, 23
 Apr 2023 10:51:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230418111612.19479-1-ddrokosov@sberdevices.ru> <20230418111612.19479-6-ddrokosov@sberdevices.ru>
In-Reply-To: <20230418111612.19479-6-ddrokosov@sberdevices.ru>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 23 Apr 2023 19:51:31 +0200
Message-ID: <CAFBinCDvyweC-m=nKw+FZFYvASDE2x3e-Vt=JkSzBifu87cnNw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] arm64: dts: meson: a1: support USB controller in
 OTG mode
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, neil.armstrong@linaro.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        mturquette@baylibre.com, vkoul@kernel.org, kishon@kernel.org,
        hminas@synopsys.com, Thinh.Nguyen@synopsys.com,
        yue.wang@amlogic.com, hanjie.lin@amlogic.com,
        kernel@sberdevices.ru, rockosov@gmail.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-phy@lists.infradead.org
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

On Tue, Apr 18, 2023 at 1:16=E2=80=AFPM Dmitry Rokosov <ddrokosov@sberdevic=
es.ru> wrote:
[...]
> +                       usb2_phy1: phy@4000 {
> +                               compatible =3D "amlogic,a1-usb2-phy";
> +                               clocks =3D <&clkc CLKID_USB_PHY_IN>;
> +                               clock-names =3D "xtal";
Out of curiosity since there's also a CLKID_USB_PHY clock (which is
used for the dwc3 controller below):
Do we know that this part of the clock hierarchy is correct? I have no
way to check this myself, so I'm curious if you could verify this
somehow.

[...]
> +                       dwc2: usb@ff500000 {
> +                               compatible =3D "amlogic,meson-a1-usb", "s=
nps,dwc2";
> +                               reg =3D <0x0 0xff500000 0x0 0x40000>;
> +                               interrupts =3D <GIC_SPI 89 IRQ_TYPE_LEVEL=
_HIGH>;
> +                               phys =3D <&usb2_phy1>;
> +                               phy-names =3D "usb2_phy";
Documentation/devicetree/bindings/usb/dwc2.yaml only allows a
"usb2-phy" (dash instead of underscore).

[...]
> +                       dwc3: usb@ff400000 {
> +                               compatible =3D "snps,dwc3";
> +                               reg =3D <0x0 0xff400000 0x0 0x100000>;
Note to self: interesting that Amlogic swapped the register location
of the dwc2 and dwc3 controllers since the G12 generation.
