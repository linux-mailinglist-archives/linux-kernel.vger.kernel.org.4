Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B5E712D68
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 21:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbjEZT1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 15:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjEZT1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 15:27:20 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323CE1B1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 12:27:14 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-30a892c45c4so680670f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 12:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685129233; x=1687721233;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4RG7dPUDUZOMlBAs1383gBxh4HflNwt399txwioncds=;
        b=ZClEf5sZuEtSsNFNhaeCkpj8T5RiPbpyidNqyhfa/Y4vr/mZ7hptk0svoX5Or8p7cQ
         WsO/k8papZAuKVyUwEf+VrdsYPx54vmXxqyfJFjkds3w4zIAZSsqDDYGXUUz0XV9hcAW
         OrnixBxePqd/jw9YCWckrOofmr+8QABIhpRcjDlv618H6n6TCX+z+Axd81jOVMT9MMPj
         bjMiSV3H3LlW3S093wAltees8ZXStjy9Fgd+mta+fzdcheSSbA9Nrw2UhBrUP396txUT
         di1mgCiufkID7JfjCvtne1WgiGFIZlVlEZc+Xxf4ZDEA5St4gxrcLzPoHPcG/Q+ZE0jS
         rkYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685129233; x=1687721233;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4RG7dPUDUZOMlBAs1383gBxh4HflNwt399txwioncds=;
        b=WdPT5lgUEhKm4xWzWgmDBqyq+8Z2+DB4MtB3L9uJXUkarrbBdXObueBJjNfKlUYtRV
         Eft197/KvJOZMMPhC1u9BlNhmxtvw6UA2N9CbS/ZsLFm0oQXngDuQiLeTokMd5O6lw4t
         JLNFfQJRgSeoENiDI2WQ1hovmQrzdzSTPMBZTt6ZEctTSnw/Qd5cca+CiQmFRZPAwEXv
         u8aevJAf5+H0DP51J44tBzDQD/tPOy+8wkdXgz4rwj7SqBnSyBI7/IrbRh3YeDSwNFx+
         IO4H8o5zQxN1PEEebXKtq8ZnIC6i81qsSq2vHVnpW/zBdNSgWDC0LapUpuSkUSEvWcTX
         2orQ==
X-Gm-Message-State: AC+VfDyHsayApbHti/dQSQniy2ExAHjTcI8owsXVaCOG9uvtDO/657J4
        dH+mMFYL3ofaNXlDoBYnLrZWk0z2JbeZ2+fK8o0How==
X-Google-Smtp-Source: ACHHUZ6SddmgRY2i5qzNxt6nE/91yQ86wVr3fo8Fe+cRJEurp9CIx78Vc80kzgQ3AZYopDoZPb1KKwvmCK3fcyFvEKo=
X-Received: by 2002:adf:f6c3:0:b0:309:303b:3dc5 with SMTP id
 y3-20020adff6c3000000b00309303b3dc5mr2490703wrp.7.1685129233112; Fri, 26 May
 2023 12:27:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230104101228.3964304-1-bhupesh.sharma@linaro.org> <20230526190222.2dyopipjz2llclus@ripper>
In-Reply-To: <20230526190222.2dyopipjz2llclus@ripper>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Sat, 27 May 2023 00:57:01 +0530
Message-ID: <CAH=2NtzRypkbWeTDqEvNY6w25Pi_OCU19VVcjuo2OA4VTvkpcw@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: dts: qcom: sm6115: Add EUD dt node and dwc3 connector
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, quic_schowdhu@quicinc.com,
        agross@kernel.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On Sat, 27 May 2023 at 00:28, Bjorn Andersson <andersson@kernel.org> wrote:
>
> On Wed, Jan 04, 2023 at 03:42:28PM +0530, Bhupesh Sharma wrote:
> > Add the Embedded USB Debugger(EUD) device tree node for
> > SM6115 / SM4250 SoC.
> >
> > The node contains EUD base register region, EUD mode manager
> > register region and TCSR Check register region along with the
> > interrupt entry.
> >
> > Also add the typec connector node for EUD which is attached to
> > EUD node via port. EUD is also attached to DWC3 node via port.
> >
> > To enable the role switch, we need to set dr_mode = "otg" property
> > for 'usb_dwc3' sub-node in the board dts file.
> >
> > Also the EUD device can be enabled on a board once linux is boot'ed
> > by setting:
> >  $ echo 1 > /sys/bus/platform/drivers/qcom_eud/../enable
> >
>
> I was under the impression that you where working on some updates to EUD
> and was going to resend this, but I don't find a new version, and I
> don't see an on-list reply from me.
>
> So just to make sure this isn't lost any longer... Can you please respin
> this to correct the dtc warnings?

Yes, we already have the v6 for this series here:
https://lore.kernel.org/linux-arm-msm/20230517211756.2483552-1-bhupesh.sharma@linaro.org/

Thanks,
Bhupesh

> > Cc: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > ---
> > - v2 can be viewed here: https://lore.kernel.org/linux-arm-msm/20230104052047.3945983-1-bhupesh.sharma@linaro.org
> > - In v3, fix the errors reported by '$ make dtbs_check' for the port sub node:
> >   ports:
> >     'oneOf' conditional failed, one must be fixed:
> >         'port' is a required property
> >         '#address-cells' is a required property
> >         '#size-cells' is a required property
> > - This patch is based on my earlier sm6115 usb related changes, which can
> >   be seen here:
> >   https://lore.kernel.org/linux-arm-msm/20221215094532.589291-1-bhupesh.sharma@linaro.org/
> > - This patch is also dependent on my sm6115 eud dt-binding and driver changes
> >   (v2) sent earlier, which can be seen here:
> >   https://lore.kernel.org/linux-arm-msm/20230103150419.3923421-1-bhupesh.sharma@linaro.org/
> >
> >  arch/arm64/boot/dts/qcom/sm6115.dtsi | 46 ++++++++++++++++++++++++++++
> >  1 file changed, 46 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> > index 030763187cc3f..a1a4f659587f3 100644
> > --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> > @@ -170,6 +170,18 @@ core3 {
> >               };
> >       };
> >
> > +     eud_typec: connector {
> > +             compatible = "usb-c-connector";
> > +
> > +             ports {
> > +                     port@0 {
> > +                             con_eud: endpoint {
> > +                                     remote-endpoint = <&eud_con>;
> > +                             };
> > +                     };
> > +             };
> > +     };
> > +
> >       firmware {
> >               scm: scm {
> >                       compatible = "qcom,scm-sm6115", "qcom,scm";
> > @@ -565,6 +577,33 @@ gcc: clock-controller@1400000 {
> >                       #power-domain-cells = <1>;
> >               };
> >
> > +             eud: eud@1610000 {
> > +                     compatible = "qcom,sm6115-eud", "qcom,eud";
> > +                     reg = <0x01610000 0x2000>,
> > +                           <0x01612000 0x1000>,
> > +                           <0x003e5018 0x4>;
> > +                     interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
> > +                     status = "disabled";
> > +
> > +                     ports {
> > +                             #address-cells = <1>;
> > +                             #size-cells = <0>;
> > +                             port@0 {
> > +                                     reg = <0>;
> > +                                     eud_ep: endpoint {
> > +                                             remote-endpoint = <&usb2_role_switch>;
> > +                                     };
> > +                             };
> > +
> > +                             port@1 {
> > +                                     reg = <1>;
> > +                                     eud_con: endpoint {
> > +                                             remote-endpoint = <&con_eud>;
> > +                                     };
> > +                             };
> > +                     };
> > +             };
> > +
> >               usb_hsphy: phy@1613000 {
> >                       compatible = "qcom,sm6115-qusb2-phy";
> >                       reg = <0x01613000 0x180>;
> > @@ -1064,6 +1103,13 @@ usb_dwc3: usb@4e00000 {
> >                               snps,has-lpm-erratum;
> >                               snps,hird-threshold = /bits/ 8 <0x10>;
> >                               snps,usb3_lpm_capable;
> > +                             usb-role-switch;
> > +
> > +                             port {
> > +                                     usb2_role_switch: endpoint {
> > +                                             remote-endpoint = <&eud_ep>;
> > +                                     };
> > +                             };
> >                       };
> >               };
> >
> > --
> > 2.38.1
> >
