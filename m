Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB146DDB46
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 14:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjDKMxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 08:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbjDKMx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 08:53:28 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870B040C8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 05:53:26 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-54c0c86a436so275709897b3.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 05:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681217606;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fFv74P1KCayojYjxtK5/a2IFMIj+yPaoo8Ew1qIsSEg=;
        b=sMWRCSjOMPVp5si/XP2v82kjVrx83Nszx7XXfiUQ+4WWfr+Aun0q5zNh0TbCkLLrmv
         55qBvqAizK9Ib/ushXLC3pixTWaCqBTWRq2OghKIZKAO3c8aB4NXecWVCi46LhnivDh6
         rEH/S76ZH7I/zoDt9n95RFEryypfxnLPpohemb+RndwF3uYLOUa10SqfseE95Ih5aFwL
         J5cBuiYPpSO3NPLjGDX4umb2eLJqU+lzKEcPPkgYspNOJm9bDJduGJCQUHTYKyr1wo0i
         FOvd8m51xCg7kwV16LK3iJ7VO4v2z5el1fDOH4sWMg3kSwSvmhHg/f+WnFhkFhOwmdxm
         INqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681217606;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fFv74P1KCayojYjxtK5/a2IFMIj+yPaoo8Ew1qIsSEg=;
        b=hOSV4QcGDXJUckiXxCReNOtBEX/Y/o1N11AGZTwWvbUD2YKb9EiLHe6F+mm8pHw8kZ
         uuDBKCi1xFQdYH5Rs3XqAIYu3kdE777cg9YicbcpxvEmCTLfYqJ8Wlh4/DKu3tz+ZTDb
         9nb90gKAqEcA/VH6J8EBZ0J540y2KSqsY3wnT6TK4jo0/u1Kqbxjaf+soY9GjXkBuMaj
         Mxd6Iqx2Wz1IuLALiTUll41N1O8DBxyjjewF4RfGEOD1TrV9x3u8WNnRU4o7s4Nu35D5
         bNjXk9uIxL3VJ8tzb9duDc9TqVq/gn63vGfko04+uvdVr60Jfo6QDmxZMxEuc/As3MEa
         KW/A==
X-Gm-Message-State: AAQBX9c8GekNgItReyMBogitAKjnAwsrMAiZwqRmq/av49cbfYNx3yGJ
        HdNg/S6bc0RCqYPrxyxH+vxkGeY6a2ej4/dqS1OL8g==
X-Google-Smtp-Source: AKy350Y4X7sWd/sMQ10PeBq1usb+QKgdwjKDQyYcRyuD5lp1mmERKPgxY9L+t5XfRBFRr6SmHLi0cZYny6S114tUDXA=
X-Received: by 2002:a81:ca53:0:b0:54c:a67:90b with SMTP id y19-20020a81ca53000000b0054c0a67090bmr8186037ywk.5.1681217605731;
 Tue, 11 Apr 2023 05:53:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230410171010.2561393-1-bhupesh.sharma@linaro.org>
 <20230410171010.2561393-3-bhupesh.sharma@linaro.org> <1552aad0-4b84-b508-bc05-610edb3cccff@linaro.org>
 <CAH=2NtyP8zkOetnH-i8TLBGBQnjH4f569PxjzW_84HZXeCFGNw@mail.gmail.com>
In-Reply-To: <CAH=2NtyP8zkOetnH-i8TLBGBQnjH4f569PxjzW_84HZXeCFGNw@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 11 Apr 2023 15:53:14 +0300
Message-ID: <CAA8EJprCUSvtC4Os0X==E418ZyPB1sBDP18Z5Ng-zPE0=+1rXQ@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] arm64: dts: qcom: sm6115: Add USB SS qmp phy node
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org, agross@kernel.org,
        linux-kernel@vger.kernel.org, andersson@kernel.org,
        bhupesh.linux@gmail.com, krzysztof.kozlowski@linaro.org,
        robh+dt@kernel.org, konrad.dybcio@linaro.org, kishon@kernel.org,
        vkoul@kernel.org, krzysztof.kozlowski+dt@linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Apr 2023 at 15:18, Bhupesh Sharma <bhupesh.sharma@linaro.org> wrote:
>
> On Tue, 11 Apr 2023 at 13:17, Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > On 10/04/2023 20:10, Bhupesh Sharma wrote:
> > > Add USB superspeed qmp phy node to dtsi.
> > >
> > > Make sure that the various board dts files (which include sm4250.dtsi file)
> > > continue to work as intended.
> > >
> > > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > > ---
> > >   .../boot/dts/qcom/sm4250-oneplus-billie2.dts  |  3 ++
> > >   arch/arm64/boot/dts/qcom/sm6115.dtsi          | 29 +++++++++++++++++--
> > >   .../boot/dts/qcom/sm6115p-lenovo-j606f.dts    |  3 ++
> > >   3 files changed, 33 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
> > > index a1f0622db5a0..75951fd439df 100644
> > > --- a/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
> > > +++ b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
> > > @@ -242,6 +242,9 @@ &usb {
> > >   &usb_dwc3 {
> > >       maximum-speed = "high-speed";
> > >       dr_mode = "peripheral";
> > > +
> > > +     phys = <&usb_hsphy>;
> > > +     phy-names = "usb2-phy";
> > >   };
> > >
> > >   &usb_hsphy {
> > > diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> > > index 2505c815c65a..b2ea8f13e827 100644
> > > --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> > > @@ -651,6 +651,31 @@ usb_hsphy: phy@1613000 {
> > >                       status = "disabled";
> > >               };
> > >
> > > +             usb_qmpphy: phy@1615000 {
> > > +                     compatible = "qcom,sm6115-qmp-usb3-phy";
> > > +                     reg = <0x0 0x01615000 0x0 0x200>;
> > > +
> > > +                     clocks = <&gcc GCC_AHB2PHY_USB_CLK>,
> > > +                              <&gcc GCC_USB3_PRIM_CLKREF_CLK>,
> > > +                              <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>,
> > > +                              <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
> > > +                     clock-names = "cfg_ahb",
> > > +                                   "ref",
> > > +                                   "com_aux",
> > > +                                   "pipe";
> > > +
> > > +                     resets = <&gcc GCC_USB3_PHY_PRIM_SP0_BCR>,
> > > +                              <&gcc GCC_USB3PHY_PHY_PRIM_SP0_BCR>;
> > > +                     reset-names = "phy", "phy_phy";
> > > +
> > > +                     #clock-cells = <0>;
> > > +                     clock-output-names = "usb3_phy_pipe_clk_src";
> > > +
> > > +                     #phy-cells = <0>;
> > > +
> > > +                     status = "disabled";
> >
> >
> > Please excuse me if I'm wrong, but this will not work with the current
> > PHY driver. It was not updated to handle new bindings. Please provide
> > relevant driver patches too.
>
> Oh.. from your previous emails, I got the feeling that you were
> already reworking the existing PHY driver as part of enabling it for
> newer bindings.
>
> No issues, I will send the PHY patches as well in the next version.

Then this dependency should have been declared in the cover letter.


-- 
With best wishes
Dmitry
