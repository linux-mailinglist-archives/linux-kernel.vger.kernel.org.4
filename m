Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383936F6904
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 12:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjEDKWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 06:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjEDKWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 06:22:11 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7839A49EC
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 03:22:10 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-2fddb442d47so205980f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 03:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683195729; x=1685787729;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=igZ147sbnVJptuuN3QUJ58JO1vmaU7STStakWGw1wNA=;
        b=WufIVkmF1XyV+jEgUmST79a6ovQVYXTLrm9nEjN90HKUpeJgqdbd6wc6hJLlJIFip7
         IsClcRuEL5F+SVLUBekVMEHZsuylZCGOu5sHF6XOMfuZTk69TfERPzPNPmqg6DrhXj5x
         MzpLiKDDfWl334kiocOPz7dz/2nLkZA80yLx0+LLs/hcsgVkc06ndiSraeg/Ld4d7cfH
         AzoMwyoATpJGYHt5Wm0akvPtQlIYk5h6EQ2CQWXVh5HG9+doejaGwycgTlq64DOlgLUZ
         4NcG0jjuml5Zf6MwVzr/umYJzvt+WCkqtdL3PqwlvLpqhbG7RcsFT4Qnll2J51laUtym
         c+9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683195729; x=1685787729;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=igZ147sbnVJptuuN3QUJ58JO1vmaU7STStakWGw1wNA=;
        b=EQPrhGGS5cVcWdFFVDoRlVd5jHe8qkSJqmgeYfoXAMSNTnLGbqWkBt08BpjM+NmR+U
         UretLCq2c0fSdjMzT1EWF3D0lky1++4F8yaB/5YT6lTy51TkOwdPpjH6unenmhAzsPTs
         dx9+rtYS1TLWMwRnhP9fNsJwvNAMzeMz2/C+Sa0+BxqzSMjXslvjWt8IA3TKX1cJOiVA
         L6u4Rx7mOHbRF3cBqeYxHXv7Fkoyv1eHTF4rH20QRTk3576rhFWeoFj1SPl/VEVhBzwK
         Np/E+Gwc07vf84zCqgSkC4N9qvNbup/9lo/KnIMTfIe93DGkkrGvXBhyQUmfgxjgrncN
         tgxw==
X-Gm-Message-State: AC+VfDwhM0LL2uPMkfzX8KeLCg+eYdocMcs4hWz98wPTuQWHM9IUoKqT
        PE8E4RBA4AGo+mrAhE/9gtn69fBPDn3DD3iWzdxKZA==
X-Google-Smtp-Source: ACHHUZ7hgUeKqiN3CVLJwJh/YZhJbJW/Ofs5GBEw0JyUlWm+Hen0VF3SnD/VVP3gGJk51cZgYW50eNpIiZUua7F5AZI=
X-Received: by 2002:adf:e50e:0:b0:2f0:442a:2d45 with SMTP id
 j14-20020adfe50e000000b002f0442a2d45mr1991274wrm.57.1683195728830; Thu, 04
 May 2023 03:22:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230504082644.1461582-1-bhupesh.sharma@linaro.org>
 <20230504082644.1461582-5-bhupesh.sharma@linaro.org> <99686fdf-73eb-30e0-8ad2-64af1b6b3508@linaro.org>
In-Reply-To: <99686fdf-73eb-30e0-8ad2-64af1b6b3508@linaro.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Thu, 4 May 2023 15:51:57 +0530
Message-ID: <CAH=2NtzfGn_nePJYpLSEVETAyuBPC8DzqspDh6B_kS_R1ax2zA@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] arm64: dts: qcom: sm6115: Add EUD dt node and dwc3 connector
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        agross@kernel.org, andersson@kernel.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        robh+dt@kernel.org, linux-usb@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org
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

On Thu, 4 May 2023 at 15:23, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> On 4.05.2023 10:26, Bhupesh Sharma wrote:
> > Add the Embedded USB Debugger(EUD) device tree node for
> > SM6115 / SM4250 SoC.
> >
> > The node contains EUD base register region, EUD mode manager
> > register region and TCSR Base register region along with the
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
> > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sm6115.dtsi | 48 ++++++++++++++++++++++++++++
> >  1 file changed, 48 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> > index f67863561f3f..6865342fc42f 100644
> > --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> > @@ -180,6 +180,18 @@ core3 {
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
> > @@ -647,6 +659,35 @@ gcc: clock-controller@1400000 {
> >                       #power-domain-cells = <1>;
> >               };
> >
> > +             eud: eud@1610000 {
> > +                     compatible = "qcom,sm6115-eud", "qcom,eud";
> > +                     reg = <0x0 0x01610000 0x0 0x2000>,
> > +                           <0x0 0x01612000 0x0 0x1000>,
> > +                           <0x0 0x003c0000 0x0 0x40000>;
> > +                     interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
> > +                     qcom,secure-mode-enable;
> > +                     status = "disabled";
> > +
> > +                     ports {
> > +                             #address-cells = <1>;
> > +                             #size-cells = <0>;
> > +
> > +                             port@0 {
> > +                                     reg = <0>;
> Please insert a newline before each child node.

Ok, I will do it in next version.

Thanks,
Bhupesh
