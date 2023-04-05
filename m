Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D5A6D8777
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 21:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbjDETzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 15:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233385AbjDETzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 15:55:17 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8AC468F
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 12:55:15 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id m2so37332585wrh.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 12:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680724513;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2ksXkmq2smhHgv1sUdzO5vfRJBokvvn2sm+WWkFQyrM=;
        b=UuN0IN9aVIlNHBJdqSp0sMuA/m7oRprsHlZii5e5i5mAZtGML0tfoy5gToZi0ixSRO
         GoGCh50gBOhjkUzt5Ho591h8D36M52O0eJjzocfz9PSLDDKZlaov+FZ45qk4cQeK3A9y
         vvBJU05qJbMORSQji7RDAsndEvaDj241LAjDO2O/LR37EaJGjpraWZLDpRjrtcpbX+dI
         UHB86uX0910Ak7YlUm7bIipvBr9zrz0MpvjiCHQNlm4I6gpOHmFijJ5PrT/Ixa1qhROv
         ltfOWHFK/M95wZ+lCbvogDTyPIUyadT9Jl+ccjXagaHG2RKI+SgiPbYeehRqewVWJ+6z
         zYaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680724513;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ksXkmq2smhHgv1sUdzO5vfRJBokvvn2sm+WWkFQyrM=;
        b=7EjBCvybw0oYhwY7bla8tahdz7ZiMtGyvgEzWIillcCZ25EGffozkVkFwbMgVs8fLB
         0D9NUfXMieGkxvWUyeWuKQeq8adnQNM3IgLmmG/jfR7XbuB0PNRn/emvaaGH9ygUFbdb
         9ftqUxkbBYOxf8iPCmcWCMhoRXbLapCHV48kXPdbnIC70eA8kzIM6+/cw9e1n/N+T/Lv
         boEuMh/rHQVpYhXZxe6V/sNZVoSX9SOR3u+nrHcxWi2glw/lBBIRWFj7ijzfNr+AjMMc
         w0lWoa797J6Bf135hIpfcUUlrKqz6TqLmHUeGYQW040cq8WWHCSVUbCqM46Hx78KemDi
         eL/w==
X-Gm-Message-State: AAQBX9cj9ctQbUmk1XPqYQRiPT/1VrMSRWpLAYEG+J7XMouLwMhBsc1n
        aTHztLTou8Xk9hcm8gL8w3V3qI1iGazliZOw4DaF5w==
X-Google-Smtp-Source: AKy350a+WR5HnIxkBJY1P8g+NaepzvHYZgg9l7RYM1p+GA2Vi83nA1ON10/P6Hr+Qwmmu9YcAGs/mrCa4R7btbO1PGE=
X-Received: by 2002:a5d:51c7:0:b0:2ce:a8d6:570f with SMTP id
 n7-20020a5d51c7000000b002cea8d6570fmr1546955wrv.4.1680724513613; Wed, 05 Apr
 2023 12:55:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230405191633.1864671-1-bhupesh.sharma@linaro.org>
 <20230405191633.1864671-3-bhupesh.sharma@linaro.org> <CAA8EJppfRvc7nJ+AeUjrqfmZ8aLWPma-Ecda-tjOwezqWVueuw@mail.gmail.com>
In-Reply-To: <CAA8EJppfRvc7nJ+AeUjrqfmZ8aLWPma-Ecda-tjOwezqWVueuw@mail.gmail.com>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Thu, 6 Apr 2023 01:25:02 +0530
Message-ID: <CAH=2Nty_EAyLVQfKhczJDhurvvTubotm44iitmWPNMQAe-fRLA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] arm64: dts: qcom: sm6115: Add USB SS qmp phy node
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
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

On Thu, 6 Apr 2023 at 01:06, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Wed, 5 Apr 2023 at 22:19, Bhupesh Sharma <bhupesh.sharma@linaro.org> wrote:
> >
> > Add USB superspeed qmp phy node to dtsi.
> >
> > Make sure that the various board dts files (which include sm4250.dtsi file)
> > continue to work as intended.
> >
> > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > ---
> >  .../boot/dts/qcom/sm4250-oneplus-billie2.dts  |  3 ++
> >  arch/arm64/boot/dts/qcom/sm6115.dtsi          | 36 +++++++++++++++++--
> >  .../boot/dts/qcom/sm6115p-lenovo-j606f.dts    |  3 ++
> >  3 files changed, 40 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
> > index a1f0622db5a0..75951fd439df 100644
> > --- a/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
> > +++ b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
> > @@ -242,6 +242,9 @@ &usb {
> >  &usb_dwc3 {
> >         maximum-speed = "high-speed";
> >         dr_mode = "peripheral";
> > +
> > +       phys = <&usb_hsphy>;
> > +       phy-names = "usb2-phy";
> >  };
> >
> >  &usb_hsphy {
> > diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> > index 2a51c938bbcb..b2fa565e4816 100644
> > --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> > @@ -650,6 +650,38 @@ usb_hsphy: phy@1613000 {
> >                         status = "disabled";
> >                 };
> >
> > +               usb_qmpphy: phy@1615000 {
> > +                       compatible = "qcom,sm6115-qmp-usb3-phy";
> > +                       reg = <0x0 0x01615000 0x0 0x200>;
> > +                       clocks = <&gcc GCC_AHB2PHY_USB_CLK>,
> > +                                <&gcc GCC_USB3_PRIM_CLKREF_CLK>,
> > +                                <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>;
> > +                       clock-names = "cfg_ahb",
> > +                                     "ref",
> > +                                     "com_aux";
> > +                       resets = <&gcc GCC_USB3PHY_PHY_PRIM_SP0_BCR>,
> > +                                <&gcc GCC_USB3_PHY_PRIM_SP0_BCR>;
> > +                       reset-names = "phy_phy", "phy";
> > +                       status = "disabled";
> > +                       #address-cells = <2>;
> > +                       #size-cells = <2>;
> > +                       ranges;
> > +
> > +                       usb_ssphy: phy@1615200 {
> > +                               reg = <0x0 0x01615200 0x0 0x200>,
> > +                                     <0x0 0x01615400 0x0 0x200>,
> > +                                     <0x0 0x01615c00 0x0 0x400>,
> > +                                     <0x0 0x01615600 0x0 0x200>,
> > +                                     <0x0 0x01615800 0x0 0x200>,
> > +                                     <0x0 0x01615a00 0x0 0x100>;
> > +                               #clock-cells = <0>;
> > +                               #phy-cells = <0>;
> > +                               clocks = <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
> > +                               clock-names = "pipe0";
> > +                               clock-output-names = "usb3_phy_pipe_clk_src";
> > +                       };
> > +               };
>
> I can repeat previous message:
>
> Please update this to newer style bindings (see
> qcom,sc8280xp-qmp-usb3-uni-phy.yaml).
>
> We are going to switch all QMP PHYs to use a newer style of bindings.
> I have started the work to convert existing usecases. As you are
> adding a new DT node, please add it in a good shape from the
> beginning.

Your earlier message was not clear and I sent out a reply for the
cover letter query you had, but got no reply. I think a pointer to
<https://patchwork.kernel.org/project/linux-phy/list/?series=733714>
would have been more clear.

I will rework and send v6 accordingly.

Thanks,
Bhupesh
