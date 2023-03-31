Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489286D1DEA
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 12:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjCaKWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 06:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjCaKVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 06:21:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A6A40C6;
        Fri, 31 Mar 2023 03:18:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CE0A3B82E29;
        Fri, 31 Mar 2023 10:18:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E4F0C433D2;
        Fri, 31 Mar 2023 10:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680257929;
        bh=5A3MI1NM5Uq/2OVg1nMJ+OOp//buqxGmoqLAWsIGndg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nFu8EEpL/yc6LfoS3gnG3bmm4mj3ewDjHxPWj9mvPwAM+ZuAZVRh6EhG7X6qmZ5HD
         l5cAYUlVPq/z4q9mER2jXuIvzGQonzJ8ULQPpBwjMYoZRY5GePZG+o+irlHXOp8vTD
         DybiTBkdYhiEMqL9fU4xX/j554JNFo3ZxyKdiU+b+4eR37mWDdX3AyotYNrWZGyExY
         Hpz6gF2ZhRcUsXKXT+FAJrZEbbdG5zOJlZ0SqmF21V+7YsHXJmMEGXHOZYsx2bPivZ
         heJvpIwi0b11XfAq9jWZbLUsCJrHq1WtlkBHa3Ola2amMkXG/fIyuYP/XTh0FiUG4r
         /PAYny8iqIpvA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1piBqg-0004es-QE; Fri, 31 Mar 2023 12:19:10 +0200
Date:   Fri, 31 Mar 2023 12:19:10 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Varadarajan Narayanan <quic_varada@quicinc.com>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, vkoul@kernel.org,
        kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        mturquette@baylibre.com, sboyd@kernel.org, quic_wcheng@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v5 7/8] arm64: dts: qcom: ipq9574: Add USB related nodes
Message-ID: <ZCaznloORtzgioOP@hovoldconsulting.com>
References: <cover.1680162377.git.quic_varada@quicinc.com>
 <c46b542b112b59002ab965be1d3fcae8c372d545.1680162377.git.quic_varada@quicinc.com>
 <CAA8EJpo_ckJtYV4aU613X5L6+wj-1i9vZkud5p72PLdCSnj5ng@mail.gmail.com>
 <20230331092710.GB19162@varda-linux.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230331092710.GB19162@varda-linux.qualcomm.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023 at 02:57:11PM +0530, Varadarajan Narayanan wrote:
> On Thu, Mar 30, 2023 at 12:44:40PM +0300, Dmitry Baryshkov wrote:
> > On Thu, 30 Mar 2023 at 11:42, Varadarajan Narayanan
> > <quic_varada@quicinc.com> wrote:
> > >
> > > Add USB phy and controller related nodes
> > >
> > > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > > ---
> > >  Changes in v5:
> > >         - Fix additional comments
> > >         - Edit nodes to match with qcom,sc8280xp-qmp-usb3-uni-phy.yaml
> > >         - 'make dtbs_check' giving the following messages since
> > >           ipq9574 doesn't have power domains. Hope this is ok
> > >
> > >                 /local/mnt/workspace/varada/varda-linux/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dtb: phy@7d000: 'power-domains' is a required property
> > >                 From schema: /local/mnt/workspace/varada/varda-linux/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
> > >                 /local/mnt/workspace/varada/varda-linux/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dtb: usb@8a00000: 'power-domains' is a required property
> > >                 From schema: /local/mnt/workspace/varada/varda-linux/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> >
> > No, I think it is not.
> 
> There are no GDSCs in IPQ9574. Can you suggest how to proceed.

You need to update the binding and either make the power domains
property optional in the binding or dependent on the SoC.

> > > +               ssphy_0: phy@7d000 {
> >
> > Nit: usually the label usb_0_qmpphy
> >
> > > +                       compatible = "qcom,ipq9574-qmp-usb3-phy";
> > > +                       reg = <0x0007d000 0xa00>;
> > > +                       #phy-cells = <0>;
> > > +
> > > +                       clocks = <&gcc GCC_USB0_AUX_CLK>,
> > > +                                <&xo_board_clk>,
> > > +                                <&gcc GCC_USB0_PHY_CFG_AHB_CLK>,
> > > +                                <&gcc GCC_USB0_PIPE_CLK>;
> > > +                       clock-names = "aux",
> > > +                                     "ref",
> > > +                                     "com_aux",

This is not the right name for this clock so you need to update the
binding first.

Please be more careful.

> > > +                                     "pipe";
> > > +
> > > +                       resets = <&gcc GCC_USB0_PHY_BCR>,
> > > +                                <&gcc GCC_USB3PHY_0_PHY_BCR>;
> > > +                       reset-names = "phy",
> > > +                                     "phy_phy";
> > > +
> > > +                       vdda-pll-supply = <&reg_usb_1p8>;
> > > +                       vdda-phy-supply = <&reg_usb_0p925>;
> > > +
> > > +                       status = "disabled";
> > > +
> > > +                       #clock-cells = <0>;
> > > +                       clock-output-names = "usb0_pipe_clk";
> > > +               };

Johan
