Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4F5656C4C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 16:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbiL0PJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 10:09:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiL0PJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 10:09:25 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C11DB9;
        Tue, 27 Dec 2022 07:09:25 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id k7-20020a056830168700b0067832816190so8350994otr.1;
        Tue, 27 Dec 2022 07:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mxrzV/iOu2I4ctne6i2SxOd69YjJ9MLkAy6iEbH6YCs=;
        b=Xgv7aHpYuRzukrZlbUxMmTh9NLmpbYlrlqSUvc4Hm3uTnYkLAZHdJCf8OfOA+bi+bq
         7gsUPDKhg24cO493BKoJyz/W0yXfTgw341gS21kNfnF+SR+3aw08W254vq7k6XSEysOW
         MZxzQqbONIHMZUnKOgDOCexGeWQlqPNzaXSJ6qtVYToauM666uTvVQ1AnOLmrDEg9fgr
         NEt00NHPE4RHmrCVMGbzLymkgMxceJlFb1IBGXLH2OgGjmobbJPZC5EizE44BQWpsmOx
         xEkT0prJE21SWaU9VXiRdVqKvzVwdBoRyTrZRSfoBL7jMNqzhotsPV4hU20f66vonoHO
         V7sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mxrzV/iOu2I4ctne6i2SxOd69YjJ9MLkAy6iEbH6YCs=;
        b=svuDAUN/EPKq4RjtDz7sJ5gszZy34uz1MMtsIIaWf5KlMj1hX1m0i97+hBqhvdxEv1
         rCyqnsfIiLOse0yGDvEM3U23Fkg8KGJ7ZMoJDUa4xkQ/wzPseBulF0Oybyt2GwSpy5o1
         KPoAHait6UAPI2Y8QL1f7+cQocvX4THT3V4ncCVHLuDx4JpCq2SCBps0XC1wtXqcjPaC
         Q6st3kShCfksokdaVdUzy2LLOoJaGQl+elq3e2KcnwvtXBuMLEuXY2bjilCU7xZ79HpB
         0J2WrIcDUcTKuPs9PExOEhwUmYj1lVEvV4lPzN2SujRgjMQM9b5L+2n88Z/JWgwNJYMg
         VNIw==
X-Gm-Message-State: AFqh2kpTx1wdVJbUA7SviX+Mdq6nDu5T1HWHZRiAPYTXi9XAgo2esQuD
        akwuQJ2K6Tgix1BftliQyMo+Tjqzzo8Qwoz+K8U=
X-Google-Smtp-Source: AMrXdXssBAl7zYN2GKFSy6s7Gg9yKSoQuGKkrUORp607Ls/hI3MHC/x6i1XoMTK+WO25pquU/tod3lo0axhE1BKhpaY=
X-Received: by 2002:a05:6830:109:b0:66c:68e5:84c5 with SMTP id
 i9-20020a056830010900b0066c68e584c5mr1426123otp.321.1672153764454; Tue, 27
 Dec 2022 07:09:24 -0800 (PST)
MIME-Version: 1.0
References: <20221112203300.536010-1-dsankouski@gmail.com> <20221112203300.536010-3-dsankouski@gmail.com>
 <20221222115922.jlachctn4lxopp7a@SoMainline.org>
In-Reply-To: <20221222115922.jlachctn4lxopp7a@SoMainline.org>
From:   Dzmitry Sankouski <dsankouski@gmail.com>
Date:   Tue, 27 Dec 2022 18:09:13 +0300
Message-ID: <CABTCjFBrGPW07AOnGgL0FD9KhHZAhRoj=n6QmttfDEobisgCqA@mail.gmail.com>
Subject: Re: [PATCH v12 2/2] arm64: dts: qcom: sagit: add initial device tree
 for sagit
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
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

Thanks for the note, I'll send the fix.

=D1=87=D1=82, 22 =D0=B4=D0=B5=D0=BA. 2022 =D0=B3. =D0=B2 14:59, Marijn Suij=
ten <marijn.suijten@somainline.org>:
>
> On 2022-11-12 23:33:00, Dzmitry Sankouski wrote:
> > New device support - Xiaomi Mi6 phone
>
> <snip>
>
> > diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts=
/qcom/pm8998.dtsi
> > index 6a0e14382be8..6a5854333b2b 100644
> > --- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
> > @@ -52,6 +52,14 @@ pm8998_pwrkey: pwrkey {
> >                               bias-pull-up;
> >                               linux,code =3D <KEY_POWER>;
> >                       };
> > +
> > +                     pm8998_resin: resin {
> > +                             compatible =3D "qcom,pm8941-resin";
> > +                             interrupts =3D <GIC_SPI 0x8 1 IRQ_TYPE_ED=
GE_BOTH>;
> > +                             debounce =3D <15625>;
> > +                             bias-pull-up;
> > +                             status =3D "disabled";
> > +                     };
>
> This should have been a separate patch, one that deduplicated
> overlapping nodes with existing msm8998 / sdm845 boards which all add
> this node individually to &pm8998_pon.
>
> What's more, their override has the same node name and will be merged
> with this one without setting status =3D "okay", leading to all those
> boards suddenly having a broken resin key because they inherit your
> status=3D"disabled".
>
> Can you send a fix to address that, with proper Fixes: tag?
>
> - Marijn
>
> >               };
> >
> >               pm8998_temp: temp-alarm@2400 {
> > --
> > 2.30.2
> >
