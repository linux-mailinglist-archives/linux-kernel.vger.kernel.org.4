Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE8C73B5B4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 12:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjFWKsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 06:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjFWKsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 06:48:50 -0400
Received: from mail-40135.protonmail.ch (mail-40135.protonmail.ch [185.70.40.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576E0E6D
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 03:48:49 -0700 (PDT)
Date:   Fri, 23 Jun 2023 10:47:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1687517327; x=1687776527;
        bh=njggoM5qv9v0nrUjGAlbTE4gjHY6AHfrf/AEkceyafU=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=m+GfRfTg/4EBmzW1ShQVhw62yM1BMw+JUawuWgiRyztr8dBIxT/FD5PH93ZLWn901
         A8GNRhftM9lRcmXODGL3hqXHsSYzIu+RciDFsaoKt5nydntanOMoAjn1H1Jc2J+bDy
         C4kjGx6l6DLexxWU8sNAv4Nv9686ufi4ywT8raSpRCPfEq2VeRtv4nnb08iMNAYpDO
         6VZyRGWM30rQ7IZgYJnRWCQRQHkoF3MZFNr1kOq8+BSi7yPG/p5u7FzzqNLDEpfexj
         bT+6dv+J4ik3KF+9lgHlpVqX5TAUfbVIAjtU6BGa4A85+1Xt6VkLYEg/FM0c/p2+9X
         P33SrYXhbnkmQ==
To:     bryan.odonoghue@linaro.org
From:   "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Cc:     agross@kernel.org, andersson@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, konrad.dybcio@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, linmengbo0689@protonmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        nikita@trvn.ru, robh+dt@kernel.org, stephan@gerhold.net,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: msm8939-samsung-a7: Add initial dts
Message-ID: <20230623104647.5501-1-linmengbo0689@protonmail.com>
In-Reply-To: <5fbba4e8-a8d9-0e99-e112-31b5781c1648@linaro.org>
References: <20230623100135.5269-1-linmengbo0689@protonmail.com> <20230623100237.5299-1-linmengbo0689@protonmail.com> <5fbba4e8-a8d9-0e99-e112-31b5781c1648@linaro.org>
Feedback-ID: 40467236:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bryan,

On Friday, June 23rd, 2023 at 10:27 AM, Bryan O'Donoghue <bryan.odonoghue@l=
inaro.org> wrote:

> > +++ b/arch/arm64/boot/dts/qcom/msm8939-samsung-a7.dts
> > @@ -0,0 +1,495 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +
> > +/dts-v1/;
> > +
> > +#include "msm8939-pm8916.dtsi"
> > +
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/input/input.h>
> > +#include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +/ {
> > + model =3D "Samsung Galaxy A7 (2015)";
> > + compatible =3D "samsung,a7", "qcom,msm8939";
> > + chassis-type =3D "handset";
>=20
>=20
> Will the downstream bootloader accept this dts without
>=20
> // This is used by the bootloader to find the correct DTB
> qcom,msm-id =3D <239 0>;
>=20
> qcom,board-id =3D <0xEF08FF1 1>;
>=20
>=20
> ?
>=20
> https://github.com/msm8916-mainline/lk2nd/blob/master/dts/msm8916/msm8939=
-samsung-r01.dts#L10
>=20

Similar to A3 and A5, and the other msm8916 devices, with lk2nd,
"qcom,msm-id" or "qcom,board-id" are not required in mainline to boot
this dts.
If I understand correctly, lk2nd will attempt to boot an image with any
qcdt appended.

https://github.com/torvalds/linux/blob/master/arch/arm64/boot/dts/qcom/msm8=
916-samsung-a3u-eur.dts
https://github.com/torvalds/linux/blob/master/arch/arm64/boot/dts/qcom/msm8=
916-samsung-a5u-eur.dts

Regards,
Lin

