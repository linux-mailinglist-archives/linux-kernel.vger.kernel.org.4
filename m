Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A066FAC3B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 13:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233964AbjEHLWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 07:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235591AbjEHLWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 07:22:08 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06E730161
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 04:22:03 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-55a829411b5so38835347b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 04:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683544923; x=1686136923;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ko/U1fePk/WQPy7Vn3m2ZCRRwSMISl8BqLJIER3u0Oc=;
        b=lmH0XMw8PpvMAbg4bTIjxo7HrMUANXnsUFHAGj4B/mc9GFBCjA8omr6ylekmWkYkhn
         6Z6uO30eTzH+govAWZABsibcAaCFm4bxOHizPQYwPIX998PelJ/aRHI9BhWZvuA/0RTc
         L27hLqc7EVPLe5WpS1yCjZXfSORDmbnHsH9qYJsXK6gRuQDaVw1B4EQwt/WVy54savt8
         CTObqlSg0mBBX9N4XY2o7IoofdceWwM2Jkgf9UH8/a8V3K9LECpbwxeAASI1HSGsnlDH
         VWbxvbXnl6V4UczO1yrBQo5vMiRDzC1WnKLkdPf4o9OJNIQKVwjwFFVIYE4VMAJJp+gw
         43lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683544923; x=1686136923;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ko/U1fePk/WQPy7Vn3m2ZCRRwSMISl8BqLJIER3u0Oc=;
        b=cVybESLyoKr5g9nx7cjklry5H7motlnk/t3RDV3EmnU+PSR4a0x6ou9O3sHV4dKyMm
         l9zbg8rCzuk6L7odkKdLysszG4YcmljDiwSbmc1FN9yL1bKmxYNr+hnDvPqvxZap9Qb8
         0WLXHHDvr+g6nfSXJwQWsD8IkG668cAyIFJbJGtxx/ILTCch9tdPzdy2VS0EQrxARR88
         s/PwUWwMJNerKnMLTYrSm2U4BpWuDjRhQmcRdbxm8yMd78xCFuuCbN5ejyTc0MEebNUn
         yF8fkCMmrUC1VACfFNLs7fx8ilV09ha1YkFly5bMuly/XISuPPZ2bDbZgCHYKdAsMZf8
         FLEQ==
X-Gm-Message-State: AC+VfDxhwCO+1VmcqAcIHBY51WPBQ+ePpK3v4p9IhfaTTvKBf288qIbM
        OsXzmVW+1INabAtT5b4wBnmAEIYLpMWj9wsvLWjFZQ==
X-Google-Smtp-Source: ACHHUZ5au/Vo+wSxMFwJFjI/9KWWlfBLe/b0UuwxkO/sVsdYW6os9E+PkdqReYK5feb3ykElLiD8ESJVRHb4HRFlL5A=
X-Received: by 2002:a25:d008:0:b0:b92:3958:dad9 with SMTP id
 h8-20020a25d008000000b00b923958dad9mr10268569ybg.40.1683544922857; Mon, 08
 May 2023 04:22:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1683183860.git.quic_varada@quicinc.com> <8894bf2c44eaf4959c7a1966b66229e6cf5cda96.1683183860.git.quic_varada@quicinc.com>
 <CAA8EJppvj2nzqwdsC+Xct4cJg2-_yPpiGDELjHJG4HyAH3zGMA@mail.gmail.com>
 <20230506110918.GC10918@varda-linux.qualcomm.com> <CAA8EJpqg2htfa2QZ7q6SP58N5YAABa8knBn4c5eYqYOU6HQNiA@mail.gmail.com>
 <20230508051657.GA24472@varda-linux.qualcomm.com>
In-Reply-To: <20230508051657.GA24472@varda-linux.qualcomm.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 8 May 2023 14:21:52 +0300
Message-ID: <CAA8EJppubMsUrG3Vo=2W8Y6=MCBKd7OCViM30jdGAdCc8x65Ww@mail.gmail.com>
Subject: Re: [PATCH v10 8/9] arm64: dts: qcom: ipq9574: Add LDO regulator node
To:     Varadarajan Narayanan <quic_varada@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        mturquette@baylibre.com, sboyd@kernel.org, quic_wcheng@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 May 2023 at 08:17, Varadarajan Narayanan
<quic_varada@quicinc.com> wrote:
>
> On Sat, May 06, 2023 at 02:33:11PM +0300, Dmitry Baryshkov wrote:
> > On Sat, 6 May 2023 at 14:09, Varadarajan Narayanan
> > <quic_varada@quicinc.com> wrote:
> > >
> > > On Fri, May 05, 2023 at 12:29:54PM +0300, Dmitry Baryshkov wrote:
> > > > On Fri, 5 May 2023 at 11:23, Varadarajan Narayanan
> > > > <quic_varada@quicinc.com> wrote:
> > > > >
> > > > > Add LDO regulator node
> > > >
> > > > As this LDO is provided by the PMIC, it would be nice to know why it
> > > > is modelled as an always-on regulator instead of the proper PMIC
> > > > regulator. Up to now we were doing this only for the outstanding power
> > > > rails like CX/MX or EBI.
> > >
> > > These are always ON because USB phy doesn't support power
> > > collapse, and there is a chance that other IP blocks might be
> > > sharing the rail.
> >
> > You are describing the software side here. From the hardware point of
> > view, it is an I2C regulator, which is probably also exported as an
> > SMD_RPM regulator. Unless you have a good reason not to do so, there
> > should be a node under rpm-requests, which describes mp5496 regulators
> > exported via RPM. then USB should refer to those regulators.
>
> Yes. It is a part of rpm-requests. That is why have mentioned V10
> is dependent on
> https://lore.kernel.org/lkml/20230407155727.20615-1-quic_devipriy@quicinc.com/T/.
> The 4th patch of the above series
> (https://lore.kernel.org/lkml/20230407155727.20615-1-quic_devipriy@quicinc.com/T/#mea3f0ea37c53cf5e39e10cd6cf3bed5243cec629)
> adds the rpm_requests node and this regulator definition is added
> to it. Hope that is ok.

It is fine. Most probably I was mistaken by the patch itself. Please
excuse me. If this this is an RPM regulator, it's is fine and correct.

>
> Thanks
> Varada
>
> > > > > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > > > > ---
> > > > >  Changes in v10:
> > > > >         - Add LDO regulator node
> > > > > ---
> > > > >  arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts | 7 +++++++
> > > > >  1 file changed, 7 insertions(+)
> > > > >
> > > > > diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
> > > > > index bdc1434..1f5d14f 100644
> > > > > --- a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
> > > > > +++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
> > > > > @@ -60,6 +60,13 @@
> > > > >                         regulator-min-microvolt = <725000>;
> > > > >                         regulator-max-microvolt = <1075000>;
> > > > >                 };
> > > > > +
> > > > > +               mp5496_l2: l2 {
> > > > > +                       regulator-min-microvolt = <1800000>;
> > > > > +                       regulator-max-microvolt = <1800000>;
> > > > > +                       regulator-boot-on;
> > > > > +                       regulator-always-on;
> > > > > +               };
> > > > >         };
> > > > >  };
> > > > >
> > > > > --
> > > > > 2.7.4
> > > > >
> > > >
> > > >
> > > > --
> > > > With best wishes
> > > > Dmitry
> >
> >
> >
> > --
> > With best wishes
> > Dmitry



-- 
With best wishes
Dmitry
