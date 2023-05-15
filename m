Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE52702434
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 08:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbjEOGMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 02:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbjEOGMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 02:12:39 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE0618B
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 23:12:36 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-50bd875398dso18530928a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 23:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1684131154; x=1686723154;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QGQqACAtxVd3+isW2epC7gqLpY6OemSJdFuWDlSDAdc=;
        b=VUc3hbcjytBj5aTVCffVk+cmWgl6blwmePp6+3rczcJaGu4QLTZ0qWlyBAvP8l/k7y
         20twm51yI1qkSxUBEuauDH5oBvO0P6wxXVBki6CP3aEpKsAxMypaaj/uswQmZx6+MUYl
         ezpYGl3X4dEk/uyOBBNDutb119Oti+A0eXGpPKY/qSfUFLzPYPMxthNGF9/rwd+y20yg
         O24bpj8rpuhaQitTP5hiR23SbapVIxOcxD3Q1naes4IBlDwrBcBu4vHEVGSfrJNJIjEP
         bgGOdLf3fPs3QEz5yGRIqYkw+IjNYfi6mS82GB7KJyc7fdWBP6wdhUH+NdrLKTONPFtj
         HPOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684131154; x=1686723154;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QGQqACAtxVd3+isW2epC7gqLpY6OemSJdFuWDlSDAdc=;
        b=OYQERNh0App+briz1Qd3pbc2IMtVSOvE/e7lJdBJ95otVXmJOcYgl44PR7cesC1ubn
         njjJL64g/NvZIiDmvVAgf7FMPnQ/MYP42tEDBDoi/+Pq1U0WjgYTLvmhWRi+swGUtfJN
         8iqjJBGqWxisVarrOjJtE+Jta9zWbPD2/gaES23yByJ6s1ATuhZ50FjQ55rjFWUZPk5O
         DuiNdT6WtDDm845GXm+eB/w5Cw3RzsxB0LnOwZcgZZgi+GU1J30ImAU2tLj9/F1Y5aU8
         xpYY0EIrJcYt3uPWiEYRZRMdaGj4DqqyUVcmIA6Ce3cJfGnkD6TXtYbYt6m9TP+KJ9pF
         VqAA==
X-Gm-Message-State: AC+VfDzyFGkB9t7luqdn4qaNMaW7+Q92pSehm7imHARWqrYfmFY9BxzF
        VqA+IfOYtnTznw35XITQF47gRw==
X-Google-Smtp-Source: ACHHUZ6VdyzxojOvlJcM3eGCjirMUeOR1VFBmDIxIiphgjub9RZOGHgCoqUyr8RlkVy6ccA25FFuqA==
X-Received: by 2002:a17:907:7e99:b0:96a:2dd7:2ef9 with SMTP id qb25-20020a1709077e9900b0096a2dd72ef9mr17702781ejc.39.1684131154628;
        Sun, 14 May 2023 23:12:34 -0700 (PDT)
Received: from localhost (k10064.upc-k.chello.nl. [62.108.10.64])
        by smtp.gmail.com with ESMTPSA id q10-20020a1709064cca00b0096b524b160asm337851ejt.82.2023.05.14.23.12.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 May 2023 23:12:34 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 15 May 2023 08:12:33 +0200
Message-Id: <CSMMO2ZBOS6Y.3SAQOHDLW68ME@otso>
Cc:     "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        "Jakub Kicinski" <kuba@kernel.org>,
        "Paolo Abeni" <pabeni@redhat.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Marcel Holtmann" <marcel@holtmann.org>,
        "Johan Hedberg" <johan.hedberg@gmail.com>,
        "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        <phone-devel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-bluetooth@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 0/4] Add WCN3988 Bluetooth support for Fairphone 4
From:   "Luca Weiss" <luca.weiss@fairphone.com>
To:     "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
X-Mailer: aerc 0.15.1
References: <20230421-fp4-bluetooth-v2-0-3de840d5483e@fairphone.com>
 <CABBYNZJPw=Oxi+J2oA=6aosEZjCBK=u=8HEJywzRJCCrmGnkGA@mail.gmail.com>
In-Reply-To: <CABBYNZJPw=Oxi+J2oA=6aosEZjCBK=u=8HEJywzRJCCrmGnkGA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri May 12, 2023 at 10:53 PM CEST, Luiz Augusto von Dentz wrote:
> Hi Luca,
>
> On Fri, May 12, 2023 at 6:58=E2=80=AFAM Luca Weiss <luca.weiss@fairphone.=
com> wrote:
> >
> > Add support in the btqca/hci_qca driver for the WCN3988 and add it to
> > the sm7225 Fairphone 4 devicetree.
> >
> > Devicetree patches go via Qualcomm tree, the rest via their respective
> > trees.
>
> Just to be sure, patches 1-2 shall be applied to bluetooth-next the
> remaining are going to be handled elsewhere?

Sounds good.

>
> > --
> > Previously with the RFC version I've had problems before with Bluetooth
> > scanning failing like the following:
> >
> >   [bluetooth]# scan on
> >   Failed to start discovery: org.bluez.Error.InProgress
> >
> >   [  202.371374] Bluetooth: hci0: Opcode 0x200b failed: -16
> >
> > This appears to only happen with driver built-in (=3Dy) when the suppor=
ted
> > local commands list doesn't get updated in the Bluetooth core and
> > use_ext_scan() returning false. I'll try to submit this separately sinc=
e
> > this now works well enough with =3Dm. But in both cases (=3Dy, =3Dm) it=
's
> > behaving a bit weirdly before (re-)setting the MAC address with "sudo
> > btmgmt public-addr fo:oo:ba:ar"
> >
> > Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> > ---
> > Changes in v2:
> > - Add pinctrl & 'tlmm 64' irq to uart node
> > - Pick up tags
> > - Link to v1: https://lore.kernel.org/r/20230421-fp4-bluetooth-v1-0-043=
0e3a7e0a2@fairphone.com
> >
> > ---
> > Luca Weiss (4):
> >       dt-bindings: net: qualcomm: Add WCN3988
> >       Bluetooth: btqca: Add WCN3988 support
> >       arm64: dts: qcom: sm6350: add uart1 node
> >       arm64: dts: qcom: sm7225-fairphone-fp4: Add Bluetooth
> >
> >  .../bindings/net/bluetooth/qualcomm-bluetooth.yaml |   2 +
> >  arch/arm64/boot/dts/qcom/sm6350.dtsi               |  63 +++++++++++++
> >  arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts  | 103 +++++++++++++=
++++++++
> >  drivers/bluetooth/btqca.c                          |  13 ++-
> >  drivers/bluetooth/btqca.h                          |  12 ++-
> >  drivers/bluetooth/hci_qca.c                        |  12 +++
> >  6 files changed, 201 insertions(+), 4 deletions(-)
> > ---
> > base-commit: f2fe50eb7ca6b7bc6c63745f5c26f7c6022fcd4a
> > change-id: 20230421-fp4-bluetooth-b36a0e87b9c8
> >
> > Best regards,
> > --
> > Luca Weiss <luca.weiss@fairphone.com>
> >

