Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89BDD73FF55
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 17:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjF0PLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 11:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjF0PLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 11:11:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551DFAA;
        Tue, 27 Jun 2023 08:11:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D478D611D2;
        Tue, 27 Jun 2023 15:11:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CF1BC433C8;
        Tue, 27 Jun 2023 15:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687878704;
        bh=V9nDz/gahtaascxaqbfTHsJw7wSFEnab4bJWGOt4Wow=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FRVnO8fD+jskfhjbdhr5fvPSObvnzUbWFBkpHPjGarxHGb/K3U0Sghio9Brpm1cRL
         5dP9r9r3lapzsKv0caBVD7pK2G9svuLXLmg2AwIp/DNmIgW/Ek6SIpJUmN9oiUNCIo
         XcGwHXAgB6w2sUoap9dBwCUolWwB81dC9eFpP/3Z636VchIE6/6F2lYUQiAq7nVAH2
         SytNTa7V0MP/XIutAL0cdz2+GcDSio8SOU5rt8Bh1VmeACvEoZdsXIJ54Jtws83NYc
         11sonmHaZAupkreFVdTyKNqV/PTWTqmqZL6pidepIIUBxD04VzyJJxZmdRycuGaA3Z
         51PzXRXTXMmKA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1qEAM1-00043x-5F; Tue, 27 Jun 2023 17:11:41 +0200
Date:   Tue, 27 Jun 2023 17:11:41 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Krishna Kurapati <quic_kriskura@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_pkondeti@quicinc.com, quic_ppratap@quicinc.com,
        quic_jackp@quicinc.com, quic_harshq@quicinc.com,
        ahalaney@redhat.com, quic_shazhuss@quicinc.com
Subject: Re: [PATCH v9 08/10] arm64: dts: qcom: sc8280xp: Add multiport
 controller node for SC8280
Message-ID: <ZJr8LUKxsfpzRCol@hovoldconsulting.com>
References: <20230621043628.21485-1-quic_kriskura@quicinc.com>
 <20230621043628.21485-9-quic_kriskura@quicinc.com>
 <2eab503f-fa0d-990e-bed2-2445c5496798@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2eab503f-fa0d-990e-bed2-2445c5496798@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 24, 2023 at 12:39:36AM +0200, Konrad Dybcio wrote:
> On 21.06.2023 06:36, Krishna Kurapati wrote:
> > Add USB and DWC3 node for tertiary port of SC8280 along with multiport
> > IRQ's and phy's. This will be used as a base for SA8295P and SA8295-Ride
> > platforms.
> > 
> > Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> > ---
> >  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 77 ++++++++++++++++++++++++++
> >  1 file changed, 77 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> > index 8fa9fbfe5d00..0dfa350ea3b3 100644
> > --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> > @@ -3013,6 +3013,83 @@ system-cache-controller@9200000 {
> >  			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
> >  		};
> >  
> > +		usb_2: usb@a4f8800 {
> > +			compatible = "qcom,sc8280xp-dwc3-mp", "qcom,dwc3";
> > +			reg = <0 0x0a4f8800 0 0x400>;
> 
> > +			#address-cells = <2>;
> > +			#size-cells = <2>;
> > +			ranges;
> These three properties, please stick just before status

No, please keep them were they are for consistency with the rest of the
file.
 
> > +
> > +			clocks = <&gcc GCC_CFG_NOC_USB3_MP_AXI_CLK>,
> > +				 <&gcc GCC_USB30_MP_MASTER_CLK>,
> > +				 <&gcc GCC_AGGRE_USB3_MP_AXI_CLK>,
> > +				 <&gcc GCC_USB30_MP_SLEEP_CLK>,
> > +				 <&gcc GCC_USB30_MP_MOCK_UTMI_CLK>,
> > +				 <&gcc GCC_AGGRE_USB_NOC_AXI_CLK>,
> > +				 <&gcc GCC_AGGRE_USB_NOC_NORTH_AXI_CLK>,
> > +				 <&gcc GCC_AGGRE_USB_NOC_SOUTH_AXI_CLK>,
> > +				 <&gcc GCC_SYS_NOC_USB_AXI_CLK>;
> > +			clock-names = "cfg_noc", "core", "iface", "sleep", "mock_utmi",
> > +				      "noc_aggr", "noc_aggr_north", "noc_aggr_south", "noc_sys";
> Please make it one per line

Also not needed for the same reason.

> 
> > +
> > +			assigned-clocks = <&gcc GCC_USB30_MP_MOCK_UTMI_CLK>,
> > +					  <&gcc GCC_USB30_MP_MASTER_CLK>;
> > +			assigned-clock-rates = <19200000>, <200000000>;
> And here

Same here.

Johan
