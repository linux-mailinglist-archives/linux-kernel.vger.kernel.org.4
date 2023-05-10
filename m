Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3216FDFB5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 16:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237347AbjEJOLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 10:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236672AbjEJOLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 10:11:37 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF6C10F
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 07:11:35 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-b9a6eec8611so36106359276.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 07:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683727895; x=1686319895;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ABREL4RA4HQkooXBZ4vFWzYroT9eYO8/4h0/bu7hTPg=;
        b=nJecOsJyqcRvaPT9m6MbM8DDYx5vc8NikACtgnGDBMlsZ7jEUJkdiuqpUXSwJ+VDLR
         SV8mBBD/MDHq53G/wg7Y67l/cSYGGnu8Z5LWkidbHXZ8v0zSeOCnpwAO0nSQzFXbVY8z
         fREaKLtEXgrcDSUNKwxcbxQRHq4YrFYpLHlc8TcY4xQEqEyzykC24djuJbI5K5v9Q775
         05gR4e2Exo5gy8VpID15rkL7IZNqvJfmwHzeIixJ4NxhmP5fM1+neOLV9IfuD+TN6rBJ
         VR1FKFpkYm6OLaVPBErbw+bW+/4vfdFxt3vDpMvbuBsqA0C41Te1XXj6Ah1IcqKn+/B7
         46VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683727895; x=1686319895;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ABREL4RA4HQkooXBZ4vFWzYroT9eYO8/4h0/bu7hTPg=;
        b=IZ7+OIaM2WRruVkuYEIeJgnHycOcFNZfSCFFCqgfydZ7nHO2aIJs+glci6Gswgs0Pn
         muf1hMAHiFW5EsZGJpQ8c9JPVu3PpwUIipLyy05Qo5sH/AF40oyIEfURaqm23ToIR6Nf
         c+cnytAp8uH+Reyh/aOABabNOLFep0DEkTiedTxviS17hEKUTgftEo6cmifo4906SGbQ
         C5FtREJclP8Xus3yofgqIRRPgPTJZ+ECGdglBX8KjgTsh5SdcFi0hNB9cXLhI1rravew
         0AxaDcp68UJbRP2qU829weuKzKTrNlWUtAatEh/WWuLlkT/bn6769Gd9Lj3cUlDbp6xD
         SY4A==
X-Gm-Message-State: AC+VfDzafG7Pn04Mond19UdKromnD1Kj7275tjq0LfnvZU08+3nCeXSV
        7VJFaSkEtS8xgFQLSSMcGTb/4Ba/HT/U33jJUMvwlA==
X-Google-Smtp-Source: ACHHUZ6qSFZacUexcQkHcVAJ+XtxS7EGJ0Aso4chPxbPdm4XjwCwQpJtI34WDH2cWrBtoFXh8o5rCwC8gRl71XOUXuU=
X-Received: by 2002:a25:a87:0:b0:b9e:772f:34bc with SMTP id
 129-20020a250a87000000b00b9e772f34bcmr21231831ybk.22.1683727894999; Wed, 10
 May 2023 07:11:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1683630932.git.quic_varada@quicinc.com> <42bf6244582d6208f51db1a9299fe1c8afab4e14.1683630932.git.quic_varada@quicinc.com>
 <CAA8EJpqkSNzx=73JS1Csw+ivVovhrFeM0R5j2tpruEfNqvT48Q@mail.gmail.com> <20230510102244.GA21530@varda-linux.qualcomm.com>
In-Reply-To: <20230510102244.GA21530@varda-linux.qualcomm.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 10 May 2023 17:11:24 +0300
Message-ID: <CAA8EJppgkHREJrBzhSDn9VT--RRcpcxMYvTWoYfkXkv4XFtK6Q@mail.gmail.com>
Subject: Re: [PATCH v11 8/9] arm64: dts: qcom: ipq9574: Add LDO regulator node
To:     Varadarajan Narayanan <quic_varada@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        gregkh@linuxfoundation.org, mturquette@baylibre.com,
        sboyd@kernel.org, quic_wcheng@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 May 2023 at 13:23, Varadarajan Narayanan
<quic_varada@quicinc.com> wrote:
>
> On Tue, May 09, 2023 at 04:08:59PM +0300, Dmitry Baryshkov wrote:
> > On Tue, 9 May 2023 at 14:56, Varadarajan Narayanan
> > <quic_varada@quicinc.com> wrote:
> > >
> > > Add LDO regulator node
> > >
> > > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > > ---
> > >  Changes in v10:
> > >         - Add LDO regulator node
> > > ---
> > >  arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> >
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >
> > Minor question below:
> >
> > >
> > > diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
> > > index bdc1434..1f5d14f 100644
> > > --- a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
> > > +++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
> > > @@ -60,6 +60,13 @@
> > >                         regulator-min-microvolt = <725000>;
> > >                         regulator-max-microvolt = <1075000>;
> > >                 };
> > > +
> > > +               mp5496_l2: l2 {
> > > +                       regulator-min-microvolt = <1800000>;
> > > +                       regulator-max-microvolt = <1800000>;
> > > +                       regulator-boot-on;
> > > +                       regulator-always-on;
> >
> > This usually points out that there are other users which are not yet
> > enabled/properly specified. What users are there for this supply which
> > demand it to be always on?
>
> The 1.8v rail is used by PCIe PHY, PLL for Ethernet SerDes
> interface and PLLs that generate SoC clocks. The voting for this
> rail is managed by the RPM f/w.

Then I'm looking forward to seeing the patch which declares all the
actual users of the lane. Please do not declare power lanes as
boot-on/always-on unless there is a strong reason for doing it.

>
> Thanks
> Varada
>
> > > +               };
> > >         };
> > >  };
> > >
> > > --
> > > 2.7.4
> > >
> >
> >
> > --
> > With best wishes
> > Dmitry



-- 
With best wishes
Dmitry
