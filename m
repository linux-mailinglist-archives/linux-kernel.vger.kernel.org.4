Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7DBB64D8F4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 10:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbiLOJsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 04:48:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiLOJrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 04:47:52 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB28C537E1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 01:47:07 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id z26so14789314lfu.8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 01:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w0ykWWBKW8/ZBMZU3VIzhqp7T3vPa6pgVpq4cSGMlg0=;
        b=fgs9z7V83Xphm9Tb2ZsNfDTHKudzIQGMDRXRybBuAd/t+P+YYElj4tBpeNKRq817P7
         Xf7gv5n4xHLyZfvcHRxTx45qFv2tnVO/9XHgz7R8lWEW48qaOZKfAoMqA7z0h4esYwkI
         HDmOFPzFQGDkEZHdiy4b0CKpzoqoKjK/b7rNWuKY0DRAeuviQQ0cUT8ANhG2127bVRjz
         ZmVfTqdpNVYAPaiJOehXLkQRNTGkpruDhsH6tKhn6FuaDMlQ97xN3PT7bzKVzCMFv+zl
         lxWJvyHsX+1Mg9wn0cl6RfRspA6tUBKiU0HZ0mCmrV4sMUw5+/J5fYpXuanJOa0DpN4F
         zE0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w0ykWWBKW8/ZBMZU3VIzhqp7T3vPa6pgVpq4cSGMlg0=;
        b=1bCPlzMCas0/jbxT73CMR55cSnuSJY5NXHtWjl4lK0mEpMvWbkc/56G6DngcFOkEs/
         jHiRnKNfjoLOVzz7XWX63DcEI15129v+A/iNf5kPdHGCzhQDwFLiPKnCTthO9qe/Smak
         Z13NC1QdUXV9Jo6E/SFE/fFkLRbAin7Gf4WXo/JZwZKdA/t/Hlh7JtQl/HV2O112fe1U
         6ltBTUhsl9UDhvThkGoYdXFWeAYvds8TRHq8v/1c0P3mXlbEnICbed6Ekn7HvQrzCOsp
         Lk/xkzpsBiUi/m2vAJA56gVNOUphmhLJ4mm2Ha8fIj4bge3soiXLiI+geQxmUSKmytOB
         C57w==
X-Gm-Message-State: ANoB5pkWb5Pjr1fzDst8Iv9FgmksuTMGcf7bdJymWnF2u+N/s/ZcW+6i
        6nBHCDRCyfAV4olU/oZSBj0n8+AMp0ONbnU/kqqbxg==
X-Google-Smtp-Source: AA0mqf505m+SddZABkA7fouzchAPJq45jpr0VwmD2u0n7HZnbMPDQTn6v6VHx1n2Or7OUL9zBeTAozudY0O570Zf6L4=
X-Received: by 2002:a19:6b19:0:b0:4a2:740b:5b02 with SMTP id
 d25-20020a196b19000000b004a2740b5b02mr30983264lfa.122.1671097623236; Thu, 15
 Dec 2022 01:47:03 -0800 (PST)
MIME-Version: 1.0
References: <20221214203124.564537-1-bhupesh.sharma@linaro.org>
 <20221214203124.564537-4-bhupesh.sharma@linaro.org> <f77cc097-56ac-845f-9882-e67aab82b02c@linaro.org>
In-Reply-To: <f77cc097-56ac-845f-9882-e67aab82b02c@linaro.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Thu, 15 Dec 2022 15:16:51 +0530
Message-ID: <CAH=2NtxeovBZq9UGUzS73iY5oXhb24vZgaq44-hcOOztZDsrAQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: sm6115: Add USB SS qmp phy node
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        agross@kernel.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, andersson@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Dec 2022 at 13:49, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 14/12/2022 21:31, Bhupesh Sharma wrote:
> > Add USB superspeed qmp phy node to dtsi.
> > Make sure that the oneplus board dts (which includes the
> > sm4250.dtsi) continues to work as intended.
> >
> > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > ---
> >  .../boot/dts/qcom/sm4250-oneplus-billie2.dts  |  3 ++
> >  arch/arm64/boot/dts/qcom/sm6115.dtsi          | 38 ++++++++++++++++++-
> >  2 files changed, 39 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
> > index 3f39f25e0721e..4f0d65574448b 100644
> > --- a/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
> > +++ b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
> > @@ -232,6 +232,9 @@ &usb {
> >  &usb_dwc3 {
> >       maximum-speed = "high-speed";
> >       dr_mode = "peripheral";
> > +
> > +     phys = <&usb_hsphy>;
> > +     phy-names = "usb2-phy";
> >  };
> >
> >  &usb_hsphy {
> > diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> > index e4ce135264f3d..15f311dcd289f 100644
> > --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> > @@ -579,6 +579,40 @@ usb_hsphy: phy@1613000 {
> >                       status = "disabled";
> >               };
> >
> > +             usb_qmpphy: phy@1615000 {
> > +                     compatible = "qcom,sm6115-qmp-usb3-phy";
> > +                     reg = <0x01615000 0x200>;
> > +                     clocks = <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>,
> > +                              <&gcc GCC_USB3_PRIM_CLKREF_CLK>,
> > +                              <&gcc GCC_AHB2PHY_USB_CLK>;
> > +                     clock-names = "com_aux",
> > +                                   "ref",
> > +                                   "cfg_ahb";
> > +                     resets = <&gcc GCC_USB3_PHY_PRIM_SP0_BCR>,
> > +                              <&gcc GCC_USB3PHY_PHY_PRIM_SP0_BCR>;
> > +                     reset-names = "phy", "phy_phy";
> > +                     status = "disabled";
> > +                     #clock-cells = <1>;
> > +                     #address-cells = <1>;
> > +                     #size-cells = <1>;
> > +                     ranges;
> > +
> > +                     usb_ssphy: phy@1615200 {
> > +                             reg = <0x01615200 0x200>,
> > +                                   <0x01615400 0x200>,
> > +                                   <0x01615c00 0x400>,
> > +                                   <0x01615600 0x200>,
> > +                                   <0x01615800 0x200>,
> > +                                   <0x01615a00 0x100>;
> > +                             #phy-cells = <0>;
> > +                             #clock-cells = <1>;
> > +                             clocks = <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
> > +                             clock-names = "pipe0";
> > +                             clock-output-names = "usb3_phy_pipe_clk_src";
> > +                     };
> > +             };
> > +
> > +
>
> Still two blank lines.

Ok, I have sent a fixed v3. Please help review.

Thanks,
Bhupesh
