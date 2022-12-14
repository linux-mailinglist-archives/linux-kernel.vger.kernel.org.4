Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7DF64C37C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 06:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiLNFU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 00:20:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiLNFUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 00:20:54 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2776026571
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 21:20:53 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id c1so8669594lfi.7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 21:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NOSsIXm1e7RKG1HNOW6miYlEk//EEdDga29JPVWjyVc=;
        b=nRSdYgWltkNl1pbDoXuf30xFhE1cbKpCYmGAiT+UdLIgXMCfnhQOFdbRXmQYoMIoo0
         Tk1z/7UpMOkijB4QY3CL/Eq6fP8SFCwZYX6mfediSpGxT4cwdWf6hjOMj3agWKRehJZK
         Knq6lwUa7Ptnm6L7CkDJC8VyHBoeJRumfdr5fnHUy75Ppk+L83SpbdjFViaFa/g8dK1v
         WFPZFS+LYYQJeeNUeK0iceV4yyDIcpL0QTNl5KDndCJwDPoz/XRW7KW6lo7Vnog9kG/E
         8WhkiEKKwhV4nbH0EKVHXcFrNXAPp/d/XRZMuo5vigv8U6CMgk5HuU3Guspsgiq472SB
         EJ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NOSsIXm1e7RKG1HNOW6miYlEk//EEdDga29JPVWjyVc=;
        b=p4ofJh5/IeJICqgOxpGCaOCLGEL7Nn542kD/yk3aJrzNgyL25z637JmO7HfzS6baBw
         nQ+2oQEaOMM8aTrxeItbHrVnUrKSr+NCU+4OhXgJzLf6r5uy29Om9QIhPEmC7+sOsEmj
         jE1j7EPNIrG8Gbl1SLgeEBm32v7hGHVGEXFQWK4cJaFxsuVdZCrvR2cOL/eh5QERg2H7
         OYnWPBC0676suOnmdwdJ1kkZUl36e1UgFo9Gb18kxB9EONHv3khIOv+2PlshD9R2SOok
         SkRLSbvzBaLs1ZmeMYmG7+4KbXxgU6vhNm0+n/mYLryuVCtQqIRSwqs2M53YVYtJohfL
         bANA==
X-Gm-Message-State: ANoB5pmc9cl5s3R7amkqX5Zo684wyfoiyJcz5PujneWrJk84gWwlq0L1
        DqjgaRZldpaj4sgcVuK1VnPC15TbUskxYZK2Jr/6Ew==
X-Google-Smtp-Source: AA0mqf57XsAPqawchbV05aowzXHZYQHki1xb/IOjLXg5Grt3gZyzyr0jap/JFwpwmqpVql/CktK1EsmGXpFJJTdj2N8=
X-Received: by 2002:a19:6b19:0:b0:4a2:740b:5b02 with SMTP id
 d25-20020a196b19000000b004a2740b5b02mr30747922lfa.122.1670995251431; Tue, 13
 Dec 2022 21:20:51 -0800 (PST)
MIME-Version: 1.0
References: <20221213123823.455731-1-bhupesh.sharma@linaro.org>
 <20221213123823.455731-4-bhupesh.sharma@linaro.org> <39ff2174-6d04-ec21-b762-377ed28088cb@linaro.org>
 <CAH=2NtwUODvzLx=JThuZpADv+x+NtLx688Ox-95b_T9PtRf4_w@mail.gmail.com> <ecb2c9ff-b092-22fa-c91e-01ead6266457@linaro.org>
In-Reply-To: <ecb2c9ff-b092-22fa-c91e-01ead6266457@linaro.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Wed, 14 Dec 2022 10:50:39 +0530
Message-ID: <CAH=2NtynGaNH+wm-wavj=NsGFQrWVHqjYmivN2nuq-YSXFs0tw@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sm6115: Add USB SS qmp phy node
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        agross@kernel.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, andersson@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Dec 2022 at 00:29, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 13/12/2022 19:52, Bhupesh Sharma wrote:
> > Hi Krzysztof,
> >
> > On Tue, 13 Dec 2022 at 18:26, Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 13/12/2022 13:38, Bhupesh Sharma wrote:
> >>> Add USB superspeed qmp phy node to dtsi.
> >>>
> >>> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> >>> ---
> >>>  arch/arm64/boot/dts/qcom/sm6115.dtsi | 38 ++++++++++++++++++++++++++--
> >>>  1 file changed, 36 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> >>> index e4ce135264f3d..9c5c024919f92 100644
> >>> --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
> >>> +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> >>> @@ -579,6 +579,40 @@ usb_hsphy: phy@1613000 {
> >>>                       status = "disabled";
> >>>               };
> >>>
> >>> +             usb_qmpphy: phy@1615000 {
> >>> +                     compatible = "qcom,sm6115-qmp-usb3-phy";
> >>> +                     reg = <0x01615000 0x200>;
> >>> +                     #clock-cells = <1>;
> >>> +                     #address-cells = <1>;
> >>> +                     #size-cells = <1>;
> >>> +                     ranges;
> >>> +                     clocks = <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>,
> >>> +                              <&gcc GCC_USB3_PRIM_CLKREF_CLK>,
> >>> +                              <&gcc GCC_AHB2PHY_USB_CLK>;
> >>> +                     clock-names = "com_aux",
> >>> +                                   "ref",
> >>> +                                   "cfg_ahb";
> >>> +                     resets = <&gcc GCC_USB3_PHY_PRIM_SP0_BCR>,
> >>> +                              <&gcc GCC_USB3PHY_PHY_PRIM_SP0_BCR>;
> >>> +                     reset-names = "phy", "phy_phy";
> >>> +                     status = "disabled";
> >>
> >> Hm, you add a disabled PHY which is used by existing controller. The
> >> controller is enabled in board DTS, but new PHY node isn't. Aren't you
> >> now breaking it?
> >
> > The USB controller is connected to two PHYs - one is HS PHY and the other is SS
> > QMP Phy. So while the exiting board dts describes and uses only the HS
> > PHY, newer
> > board dts files (which will soon be sent out as a separate patch),
>
> Then I miss how do you narrow the existing DTS to use only one PHY. I
> don't see anything in this patchset.
>
> > will use both the HS and SS
> > USB PHYs.
> >
> > So, this will not break the existing board dts files.
>
> I still think it will be. The board boots with USB with one phy enabled
> and one disabled. The driver gets phys unconditionally and one of them
> is disabled.
>
> Even if Linux implementation will work (devm_usb_get_phy_by_phandle will
> return -ENXIO or -ENODEV for disabled node), it is still a bit confusing
> and I wonder how other users of such DTS should behave. Although it will
> affect only one board, so maybe there are no other users?

Ah, now I get your point. So how does the following fix in
sm4250-oneplus-billie2.dts look like. It allows the base dtsi to carry
the usb nodes as exposed by the SoC and allows other board dts files
to use both the USB2 and UBS3 PHYs.

Please let me know.

--- a/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
+++ b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
@@ -232,6 +232,9 @@ &usb {
 &usb_dwc3 {
        maximum-speed = "high-speed";
        dr_mode = "peripheral";
+
+       phys = <&usb_hsphy>;
+       phy-names = "usb2-phy";
 };

Thanks.
