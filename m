Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518A86770D7
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 17:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjAVQ7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 11:59:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjAVQ7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 11:59:36 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB8955AD;
        Sun, 22 Jan 2023 08:59:35 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id v3so7403337pgh.4;
        Sun, 22 Jan 2023 08:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jMLOxC2C35i5VkOISpJQkRuzCxswSG3K6QdajKumJsE=;
        b=SEDcQVFwEbK/J797mjjh59HEBPZOVSmxdSEKyl1+TIJfq4WQoN/ejKNdX8ub9N4IJj
         eYqfJ7VXoj01BGGX1iHo4rE0UE/AwhzU20hP3fxJ9c3ToFhNPOiZK5F1Yyaf6/EIytpj
         2DiNtX/A+NuqmtHQq0DoyrVh7qXBA1P0ugWlBYqbxudAYhXacgWxijfEmx6gfHWtM5uq
         SQjf9+kvDlk6iijk0Foy7GOi0X27i9PeGsqk9Mru1ZdhN7UhN/y4p2KG3ezEAX5qCnBs
         o2SLdcQJqKXP7xf6faXH0mLxqixJwUVRbXPwa/bH+MkmNClpOIw1LxliI1ry6dvDni2b
         C7Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jMLOxC2C35i5VkOISpJQkRuzCxswSG3K6QdajKumJsE=;
        b=bVSv83ukTls5fUAGez6Yuq12LcuyC1gWysO038t+y1eVhVT/2jq3CIZhUJ4qvcjd+0
         f96yLc3o6oyMjJean7V+3OHqCnXqzxkuCxJ8m2/WW9gm/cecgzEZhe7Sz4ncdPdgHcY7
         njAwAHSvMqR0Qo2P6ixOUqj7s1xq6xVGy7piFxbGs4kNjyYw7nkUpyVe7ffjToXkCP8I
         yoXAjOwYuECvOTeeCiKdwr/OFVA/n7c6ut4IR6crr5krwds4/f482KSXWz1p8jae1Yim
         v1cUDLJg9Rw0aImGl9iGi7cfNA0YrsScMenNDu3wYnGOTX751ireF9MEPmhMpY5bTO/l
         RQWg==
X-Gm-Message-State: AFqh2kqtY0IRLWUO+1TNcXAd9higTwEBYfl4H1GEdFKhCf3Z6FmRxXt2
        UqsSOmGAHfLNCn348btQsBoOgPu1V4cVVYhCfV0=
X-Google-Smtp-Source: AMrXdXukEcokGhxUL7W1D7wDhweMaEBOuq6JMRmtkDHwj7ZBuIUIKRWFLRUQUVkcjaEeSfUjssMvGToAF0mHQ8SePhI=
X-Received: by 2002:a62:1a48:0:b0:588:99cb:ac19 with SMTP id
 a69-20020a621a48000000b0058899cbac19mr2160132pfa.61.1674406774971; Sun, 22
 Jan 2023 08:59:34 -0800 (PST)
MIME-Version: 1.0
References: <20230121112358.52216-1-robimarko@gmail.com> <20230121112358.52216-2-robimarko@gmail.com>
 <ebdd9932-e251-0cd7-6c98-3c735ecb74a6@quicinc.com>
In-Reply-To: <ebdd9932-e251-0cd7-6c98-3c735ecb74a6@quicinc.com>
From:   Robert Marko <robimarko@gmail.com>
Date:   Sun, 22 Jan 2023 17:59:24 +0100
Message-ID: <CAOX2RU7p-0ZTx8fkY4hOk=Zmx6RT+1PwVL+CQxkjzVadm0ehTA@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: ipq8074: add QFPROM node
To:     Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Jan 2023 at 17:57, Kathiravan Thirumoorthy
<quic_kathirav@quicinc.com> wrote:
>
>
> On 1/21/2023 4:53 PM, Robert Marko wrote:
> > IPQ8074 has efuses like other Qualcomm SoC-s that are required for
> > determining various HW quirks which will be required later for CPR etc,
> > so lets add the QFPROM node for start.
> >
> > Individidual fuses will be added as they are required.
> >
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > ---
> >   arch/arm64/boot/dts/qcom/ipq8074.dtsi | 7 +++++++
> >   1 file changed, 7 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
> > index 8eba586065a3..f29491f647fe 100644
> > --- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
> > @@ -301,6 +301,13 @@ mdio: mdio@90000 {
> >                       status = "disabled";
> >               };
> >
> > +             qfprom: efuse@a4000 {
> > +                     compatible = "qcom,ipq8074-qfprom", "qcom,qfprom";
> > +                     reg = <0x000a4000 0x1000>;
>
>
>  From the HW document, I see the overall size of this region is 0x2000,
> any reason to stick with 0x1000?

Like always, I dont have access to docs and 0x1000 is all I could find
downstream
being used.

Any chance you can share the regions inside of QFPROM, it would be great to use
the ECC corrected one if available.

Regards,
Robert
>
> Thanks, Kathiravan T.
>
>
> > +                     #address-cells = <1>;
> > +                     #size-cells = <1>;
> > +             };
> > +
> >               prng: rng@e3000 {
> >                       compatible = "qcom,prng-ee";
> >                       reg = <0x000e3000 0x1000>;
