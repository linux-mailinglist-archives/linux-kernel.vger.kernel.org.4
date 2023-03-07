Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9228D6ADE9E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 13:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbjCGMXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 07:23:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbjCGMXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 07:23:50 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B853B3B222
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 04:23:45 -0800 (PST)
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 93E883F591
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 12:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1678191821;
        bh=gcBjgTyFzqziFUQTuD3fuF6hhRUdHz1Lc7VypcmVc5Y=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=WpJE/LXCYJbGg7pIZwbw8HzM5FpbcRF62miUduTwPndq1IjX8sb32x8kx3ZsbFNGY
         xtm1yw0KEreCekiaeMjzeW3UPHguVbT8pCdlibzmYdOVgZF1eo8cMjMzGec6tL6mF3
         +qSSUaWFtQpmFAnjtjs6GjIfbYAR6VzIc9+Qwkpykw9ANpu5Qv9uyrxs7/8rFbhSaF
         eOVlcEVz0V7gVLjVWHzD6qI/rca/Y3B52kM4w5UQtGw0G/eJnj7oOZnykufl9modKr
         wpI4jivy3ES8sE1CWIXL9BikULTnZhm5OkMTF3gaWy29xVvBmRmUU8/8B79zmLVOfK
         Sd0pMdVQCTznQ==
Received: by mail-qv1-f71.google.com with SMTP id jy22-20020a0562142b5600b005710b856106so7421975qvb.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 04:23:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678191820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gcBjgTyFzqziFUQTuD3fuF6hhRUdHz1Lc7VypcmVc5Y=;
        b=tSKC6IFKYGssOkWpgkedIPKZFtruaYBmuyOxwQ0qxmVyqRk4Nxz4YJYn9+uFzSa8vb
         wy+8B3aNSJ06lgYkEHEuX5SnjwNow+pfr0qIIUw6OkbSxRDfGK4bo9KxAItsiPbukobq
         oZIar+oM/SBMr4O/MKhUOq2z0jnHflb/YJA7CPGQ/yuHrnyZDYVGDyUz1Sp9+MyuLaXV
         i7q4JTSUmsr5utSCQSU4NhKEk17y5/N0Thd9yXwg8B7U0gh8NputhEMv5tTLPCB4eClL
         tj5SaEMy47r+aAJkpj6CFjNPWITQjnBqt6nggfRVU/VTffGn+mqV66IrsZHIT/kGwnDr
         IzsA==
X-Gm-Message-State: AO0yUKX4ty9QLMBH3qxh/FwMwxP7PTV0sUR8h0WX1KU7utVrdoF21Eo2
        QKcDoKZSM1gngRsoW3gp8TXGQ519Jwmma0W2yOxW9Uxrz1NDpwfEPHX3gQljQ9yPUBTRpp9qBuk
        8cIuakps//qlRXMVFYpoodso+xFyMuzCZq7aY9dxsHVBhzQ3woU3Hej4Cmw==
X-Received: by 2002:a05:6214:b04:b0:56e:917a:1c19 with SMTP id u4-20020a0562140b0400b0056e917a1c19mr3445626qvj.0.1678191820512;
        Tue, 07 Mar 2023 04:23:40 -0800 (PST)
X-Google-Smtp-Source: AK7set/xv6+E6KxtnITdbAjC4xYrTm6Drs+UHv7miXjwgKWU+sirb/BaI9S4untDNyhwiOt1iKsR4BAo+UXPdUSi9e0=
X-Received: by 2002:a05:6214:b04:b0:56e:917a:1c19 with SMTP id
 u4-20020a0562140b0400b0056e917a1c19mr3445610qvj.0.1678191820260; Tue, 07 Mar
 2023 04:23:40 -0800 (PST)
MIME-Version: 1.0
References: <20230303085928.4535-1-samin.guo@starfivetech.com>
 <20230303085928.4535-13-samin.guo@starfivetech.com> <CAJM55Z-WpxJUshAa_gN5GD+mMp1VaxPbnF6AV-ua0HzsFWsB6w@mail.gmail.com>
 <99a9eccd-2886-832f-07e6-4ba620c522b5@starfivetech.com>
In-Reply-To: <99a9eccd-2886-832f-07e6-4ba620c522b5@starfivetech.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Tue, 7 Mar 2023 13:23:24 +0100
Message-ID: <CAJM55Z9P9PG2TBU_UVHWhRikg5YXoi=77ObjeCc4TU1FykLK1w@mail.gmail.com>
Subject: Re: [PATCH v5 12/12] riscv: dts: starfive: visionfive 2: Enable gmac
 device tree node
To:     Guo Samin <samin.guo@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Richard Cochran <richardcochran@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Yanhong Wang <yanhong.wang@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Mar 2023 at 02:21, Guo Samin <samin.guo@starfivetech.com> wrote:

> =E5=9C=A8 2023/3/6 21:04:28, Emil Renner Berthing =E5=86=99=E9=81=93:
> > On Fri, 3 Mar 2023 at 10:01, Samin Guo <samin.guo@starfivetech.com> wro=
te:
> >> From: Yanhong Wang <yanhong.wang@starfivetech.com>
> >>
> >> Update gmac device tree node status to okay.
> >>
> >> Signed-off-by: Yanhong Wang <yanhong.wang@starfivetech.com>
> >> Signed-off-by: Samin Guo <samin.guo@starfivetech.com>
> >> ---
> >>  .../dts/starfive/jh7110-starfive-visionfive-2.dtsi     | 10 +++++++++=
+
> >>  1 file changed, 10 insertions(+)
> >>
> >> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2=
.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> >> index c2aa8946a0f1..d1c409f40014 100644
> >> --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> >> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> >> @@ -12,6 +12,8 @@
> >>  / {
> >>         aliases {
> >>                 serial0 =3D &uart0;
> >> +               ethernet0 =3D &gmac0;
> >> +               ethernet1 =3D &gmac1;
> >
> > Please sort these alphabetically.
> Thanks, will fix.
> >
> >>                 i2c0 =3D &i2c0;
> >>                 i2c2 =3D &i2c2;
> >>                 i2c5 =3D &i2c5;
> >> @@ -92,6 +94,14 @@
> >>         status =3D "okay";
> >>  };
> >>
> >> +&gmac0 {
> >> +       status =3D "okay";
> >> +};
> >> +
> >> +&gmac1 {
> >> +       status =3D "okay";
> >> +};
> >
> > Since you'll need to add to the gmac0 and gmac1 nodes in the board
> > specific files too and it's only one line, consider just dropping this
> > here and add the status =3D "okay" there instead.
> >
> According to Andrew's suggestion, can I put the nodes of mdio and phy her=
e?

Yeah, if the boards then end up sharing more information it's fine to
put it here. It just seemed a little much to add 8 lines here when all
the boards shared was a status =3D "okay";

> >>  &i2c0 {
> >>         clock-frequency =3D <100000>;
> >>         i2c-sda-hold-time-ns =3D <300>;
> >> --
> >> 2.17.1
> >>
> >>
> >> _______________________________________________
> >> linux-riscv mailing list
> >> linux-riscv@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-riscv
>
> Best regards,
> Samin
> --
> Best regards,
> Samin
