Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449B36B0E1C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 17:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbjCHQFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 11:05:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232477AbjCHQEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 11:04:50 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7595D1ADF1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 08:03:15 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id d20so15808808vsf.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 08:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1678291390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jdlt+ZRsYcl0EZ0IPQW4LrlvKlc0DVKPn3zh8RuEzuo=;
        b=Khvy+yYd3OImEDEJ++rMBWWC2g+Ruw1z8vFX/QmRw3tHrtnVZKPkfK88iF69ZSBC4D
         k/XZ76IchXN7iczRn4g1N75LoblDmaQ+KyL+WR+boEa9EN9czgGAWFp0bj7jnIu7u6Za
         8Y+mbEu9ZdokbXziB+iNrO4Mm/EDkr4VPViWDEXLCRrLZpqIYFoGO6Wcl+EW+SWgEkiG
         BFS1AmKRokj4m+iuglLvL/8FeB+7iBmMDbNVeR8H1cETySDm+lAC0+JDvx1W4pNxZrs6
         3X0d0yq9ELFSMy7rPEuWx+wicmfRBh6Pm1MJ5WCwa8BxC8xvYIZsctT+4Ctb6Uc67ecl
         vhaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678291390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jdlt+ZRsYcl0EZ0IPQW4LrlvKlc0DVKPn3zh8RuEzuo=;
        b=wnGKckCK7Yxh6q7RuZQnFOjS5yGGcjYKkWPyHGrrbuU4HvQiyVLisYHwWP6HHFAh9E
         t068qUR1vUAcFtwSad9XjOUBBX2zX3HqZnmnAg1nI25s6iwg0aOu3f8uhbGOtJHHKqz/
         RtCTRJl4loOLAOGj216AsGQPZHW+RP4XaxwHkRxNkx9yEKzwgQiE+G+WykWorqxEnwzB
         YUXDYAhqHFhS3qh6Jme4M2s2zOZSbY2oj+jcrYtV6HQnNQK4WG6G0xX78XHGoYVJ9jy5
         2FdghWDHH7q2cdQQN03zzlbuH/8lCkXFJzQHfun1nOE0ZI2skdInPOgUAL4OZQVskYvO
         EaRQ==
X-Gm-Message-State: AO0yUKUU+X+BVljLAMBBpA9Qh9qwgzIq0NK2oOW/tLGnyVc3A2tUaVmx
        bLMzMwkSHhPKzMNa3g3G1Gr2zDY73xdAClNZbRpNDA==
X-Google-Smtp-Source: AK7set/CUYM0PZkPJ6h7pa3w77NuZJc6zqxCCc/jOGYzS2BQxBKjWyXyMyRqclxGmcKiDv7XVTR1CjcEjALF9AHgPPw=
X-Received: by 2002:a67:f406:0:b0:414:48a5:473f with SMTP id
 p6-20020a67f406000000b0041448a5473fmr12449959vsn.0.1678291390335; Wed, 08 Mar
 2023 08:03:10 -0800 (PST)
MIME-Version: 1.0
References: <20230308104009.260451-1-brgl@bgdev.pl> <20230308104009.260451-8-brgl@bgdev.pl>
 <ca257415-afd4-155d-bbdb-822f6eedd554@linaro.org>
In-Reply-To: <ca257415-afd4-155d-bbdb-822f6eedd554@linaro.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 8 Mar 2023 17:02:59 +0100
Message-ID: <CAMRc=MfZCQSsPN7SVXAVAsnRyE1LsszHSG0YuXGz72wwZ5b00w@mail.gmail.com>
Subject: Re: [PATCH v4 7/9] arm64: dts: qcom: sa8775p: add high-speed UART nodes
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 8, 2023 at 11:57=E2=80=AFAM Konrad Dybcio <konrad.dybcio@linaro=
.org> wrote:
>
>
>
> On 8.03.2023 11:40, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Add two UART nodes that are known to be used by existing development
> > boards with this SoC.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sa8775p.dtsi | 31 +++++++++++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dt=
s/qcom/sa8775p.dtsi
> > index 992864e3e0c8..5ebfe8c10eac 100644
> > --- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> > @@ -490,6 +490,21 @@ &clk_virt SLAVE_QUP_CORE_1 0>,
> >                               operating-points-v2 =3D <&qup_opp_table_1=
00mhz>;
> >                               status =3D "disabled";
> >                       };
> > +
> > +                     uart12: serial@a94000 {
> > +                             compatible =3D "qcom,geni-uart";
> > +                             reg =3D <0x0 0x00a94000 0x0 0x4000>;
> > +                             interrupts =3D <GIC_SPI 358 IRQ_TYPE_LEVE=
L_HIGH>;
> > +                             clocks =3D <&gcc GCC_QUPV3_WRAP1_S5_CLK>;
> > +                             clock-names =3D "se";
> > +                             interconnects =3D <&clk_virt MASTER_QUP_C=
ORE_1 QCOM_ICC_TAG_ALWAYS
> > +                                              &clk_virt SLAVE_QUP_CORE=
_1 QCOM_ICC_TAG_ALWAYS>,
> > +                                             <&gem_noc MASTER_APPSS_PR=
OC QCOM_ICC_TAG_ALWAYS
> > +                                              &config_noc SLAVE_QUP_1 =
QCOM_ICC_TAG_ALWAYS>;
> > +                             interconnect-names =3D "qup-core", "qup-c=
onfig";
> > +                             power-domains =3D <&rpmhpd SA8775P_CX>;
> > +                             status =3D "disabled";
> > +                     };
> >               };
> >
> >               qupv3_id_2: geniqup@8c0000 {
> > @@ -525,6 +540,22 @@ &config_noc SLAVE_QUP_2 QCOM_ICC_TAG_ALWAYS>,
> >                               status =3D "disabled";
> >                       };
> >
> > +                     uart17: serial@88c000 {
> > +                             compatible =3D "qcom,geni-uart";
> > +                             reg =3D <0x0 0x0088c000 0x0 0x4000>;
> > +                             interrupts-extended =3D <&intc GIC_SPI 58=
5 IRQ_TYPE_LEVEL_HIGH>,
> > +                                                   <&tlmm 94 IRQ_TYPE_=
LEVEL_HIGH>;
> This hunk is board-specific and only makes sense if bluetooth
> (or some other "important" peripheral) is connected to this
> uart. Generally the uart interrupt is the one coming from the GIC
> and the other one should probably go to the board dtsi.
>

Right, the second one will be consumed by whatever driver will be
there to control GNSS or bluetooth. I'll drop it in the next spin.

Bart

> Konrad
> > +                             clocks =3D <&gcc GCC_QUPV3_WRAP2_S3_CLK>;
> > +                             clock-names =3D "se";
> > +                             interconnects =3D <&clk_virt MASTER_QUP_C=
ORE_2 QCOM_ICC_TAG_ALWAYS
> > +                                              &clk_virt SLAVE_QUP_CORE=
_2 QCOM_ICC_TAG_ALWAYS>,
> > +                                             <&gem_noc MASTER_APPSS_PR=
OC QCOM_ICC_TAG_ALWAYS
> > +                                              &config_noc SLAVE_QUP_2 =
QCOM_ICC_TAG_ALWAYS>;
> > +                             interconnect-names =3D "qup-core", "qup-c=
onfig";
> > +                             power-domains =3D <&rpmhpd SA8775P_CX>;
> > +                             status =3D "disabled";
> > +                     };
> > +
> >                       i2c18: i2c@890000 {
> >                               compatible =3D "qcom,geni-i2c";
> >                               reg =3D <0x0 0x00890000 0x0 0x4000>;
