Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C98652CAF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 07:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234462AbiLUGFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 01:05:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234271AbiLUGFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 01:05:38 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408C4A471;
        Tue, 20 Dec 2022 22:05:37 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id h21so318392qta.12;
        Tue, 20 Dec 2022 22:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CTBES3yJ2k7kxHLxg2MFG4+FEG+X7BypxEdYc1isplY=;
        b=j6+OwjMe6anmUq+Z3C3/J4Maz6ZD1sHsVp8b2rhiC95fY5rCdeszCdBt24wyGCjoOK
         nLYcDq9p4/JAZuTH+53MR0me4StToMIBoVfY3Koc4f9bAGEMJsypaFYk3Cs2OqSAhqpw
         BGr/bozkz6hE7kotPoZMCIqQKFgMisULFQwOSQ2595VCJnclSE2XjR6WmWf57Poyqqzr
         NQPIgmufneDkl4vcHBcdl5K6JhoRs4bRkjtPnDNI4dJBJ94Ad4zxIpfxmD/o8FTHwGGZ
         xu6LV6l2ckOvuVtkoJ8WUlEVHsqaXldO0TqFjNu0MTF3SLm/60lF0B6WuTsYe1y3JueA
         eptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CTBES3yJ2k7kxHLxg2MFG4+FEG+X7BypxEdYc1isplY=;
        b=qarOVX5V/YPDID3d5/QfW2MSRn8AI1ajnt5zmiYg9zVNaNm8r+4SS6aQ4dvtl4/Hjf
         gUcJnP2X1MFyTiAqijIhO4TtduqQuHH3FJJLsDHAzIQxYLXFVlP2Kvzh15OVhpHo7BaA
         BpQLCAIl7b4Du8BQX6/eJ1DhFOV/Mj8jc3yHPLPExOBelNQi+I77Otie9Fktpas7YuaZ
         g2UhGL6+iHNxcD6oIiLH/2T1JOSI75LcoxsbjuODCz26tMYB+XTfBlcHYCLHjez6hVC1
         OJyzCFGdkBNML4QAc6UyIpGS+G5O4U77hTr/4+00WzhQAx8EMOyE5rD+z5RG8sxFe3jI
         L2Lg==
X-Gm-Message-State: AFqh2kpnmoOlGQP38wnTnhMPOW6ZSXK1GDCRWJ4+XV1JiVAHUchDVRUY
        Z7uTl8NDD2cG205OGnUwnlk1ux7ElECsorXIX2g=
X-Google-Smtp-Source: AMrXdXuvA6z58v9Nai5t2roZ9vzH69AVh8tmnOnXcsOWiWe1DlxGLth7lEHmgbtTjEtCWcsc56mREmz263dWwh3mQlE=
X-Received: by 2002:a05:622a:1a06:b0:3a5:6822:1a42 with SMTP id
 f6-20020a05622a1a0600b003a568221a42mr18740qtb.174.1671602736260; Tue, 20 Dec
 2022 22:05:36 -0800 (PST)
MIME-Version: 1.0
References: <Y6GMnq3AC7Kbnag8@VM-66-53-centos> <a113d20c-dc6c-2e44-009f-d4b17beb8820@linaro.org>
 <3325915.e9J7NaK4W3@diego>
In-Reply-To: <3325915.e9J7NaK4W3@diego>
From:   ty <zonyitoo@gmail.com>
Date:   Wed, 21 Dec 2022 14:05:25 +0800
Message-ID: <CAMmci2UNqbv-ViaGM5Avi5fhSEuDa=MFkq1bDXyDsrNFM=t0jA@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: rockchip: Add RK3566 LubanCat 1
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, DHDAXCW <lasstp5011@gmail.com>
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

ok. Modifications are made in PATCH v4.

NOTE: PATCH v3 was sent with an old patch file as attachment, so please ign=
ore.
NOTE: Last Reply E-mail were sent in HTML mode.


Heiko St=C3=BCbner <heiko@sntech.de> =E4=BA=8E2022=E5=B9=B412=E6=9C=8821=E6=
=97=A5=E5=91=A8=E4=B8=89 01:32=E5=86=99=E9=81=93=EF=BC=9A
>
> Am Dienstag, 20. Dezember 2022, 17:14:51 CET schrieb Krzysztof Kozlowski:
> > On 20/12/2022 11:21, Yuteng Zhong wrote:
> > > LubanCat 1 is a Rockchip RK3566 SBC based
> > > is developed by EmbedFire Electronics Co., Ltd.
> > > Mini Linux Card Type Cheap Computer Development Board
> >
> > Please wrap commit message according to Linux coding style / submission
> > process:
> > https://elixir.bootlin.com/linux/v5.18-rc4/source/Documentation/process=
/submitting-patches.rst#L586
> >
> > > +   rk809: pmic@20 {
> > > +           compatible =3D "rockchip,rk809";
> > > +           reg =3D <0x20>;
> > > +           interrupt-parent =3D <&gpio0>;
> > > +           interrupts =3D <RK_PA3 IRQ_TYPE_LEVEL_LOW>;
> > > +           assigned-clocks =3D <&cru I2S1_MCLKOUT_TX>;
> > > +           assigned-clock-parents =3D <&cru CLK_I2S1_8CH_TX>;
> > > +           #clock-cells =3D <1>;
> > > +           clock-names =3D "mclk";
> > > +           clocks =3D <&cru I2S1_MCLKOUT_TX>;
> > > +           pinctrl-names =3D "default";
> > > +           pinctrl-0 =3D <&pmic_int>;
> > > +           rockchip,system-power-controller;
> > > +           #sound-dai-cells =3D <0>;
> > > +           vcc1-supply =3D <&vcc3v3_sys>;
> > > +           vcc2-supply =3D <&vcc3v3_sys>;
> > > +           vcc3-supply =3D <&vcc3v3_sys>;
> > > +           vcc4-supply =3D <&vcc3v3_sys>;
> > > +           vcc5-supply =3D <&vcc3v3_sys>;
> > > +           vcc6-supply =3D <&vcc3v3_sys>;
> > > +           vcc7-supply =3D <&vcc3v3_sys>;
> > > +           vcc8-supply =3D <&vcc3v3_sys>;
> > > +           vcc9-supply =3D <&vcc3v3_sys>;
> > > +           wakeup-source;
> > > +
> > > +           regulators {
> > > +                   vdd_logic: DCDC_REG1 {
> >
> > No underscores in node names. Anything requires it?
>
> looks like the answer is "it depends" :-)
>
> When the regulator-framework searches for the node to get the init-data f=
rom
> it uses the actual node-name or the regulator-compatible property [0]
> to match against.
>
> And going via regulator-compatible was the "old" way, already deprecated
> before the yaml-conversion [1] and not even included
>
> So matching against the node-name is the correct way to go and it's actua=
lly
> part of the rk8xx-binding as well [2]
>
>
> Hope that helps,
> Heiko
>
>
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/drivers/regulator/of_regulator.c#n477
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/Documentation/devicetree/bindings/regulator/regulator.txt?id=3D1914a99=
6436b09186489da73b807e1df71259f67
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml#n84
>
>


--=20
Y. T. Zhong
Student of The University of Hong Kong, major in Computer Science.
E-mail: zonyitoo@gmail.com
