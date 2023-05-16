Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE63704B2A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 12:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbjEPKyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 06:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbjEPKyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 06:54:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60EE2D4E;
        Tue, 16 May 2023 03:54:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AF8863269;
        Tue, 16 May 2023 10:54:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B79E3C433EF;
        Tue, 16 May 2023 10:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684234442;
        bh=paHYLnFWTcB7RJB+E5stDQFsNxE2riSRbIlNnygHpvA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n2O/Hu5c0ODvDcCEzcHaiTdrBnK6A5nlfO8sespVz1X5CFmVnstH7yV1zHBuxhOgl
         ytyfdKQww5QNpmJmddMfW2guobnDKeSOnaSp6FFfzrIO5bTc7Pjj8xfr4PRWvM0BH4
         dLjB0Gn31EFsQel5tyNr1CS+Vo6mjlEawCEDpxDoZSTiMPH1/toZarYL6sslLPNiIw
         78ngRpFnCjNd8/iSihpd/CnJynHRYds3QxYQEXRftcEvF7C3hbL77R5GETnnqF7Hzc
         gj9rUpJfCStYaehCaCX2oyaqhy/MZm9uQ3WY+0UM24rOpraeTEaxo8PVM2lRTThW7Q
         ImrlYEzkjBptw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pysJe-0007ix-CP; Tue, 16 May 2023 12:54:02 +0200
Date:   Tue, 16 May 2023 12:54:02 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, quic_pkondeti@quicinc.com,
        quic_ppratap@quicinc.com, quic_wcheng@quicinc.com,
        quic_jackp@quicinc.com, quic_harshq@quicinc.com,
        ahalaney@redhat.com
Subject: Re: [PATCH v8 7/9] arm64: dts: qcom: sc8280xp: Add multiport
 controller node for SC8280
Message-ID: <ZGNgyo8ZRcC26W5l@hovoldconsulting.com>
References: <20230514054917.21318-1-quic_kriskura@quicinc.com>
 <20230514054917.21318-8-quic_kriskura@quicinc.com>
 <ZGJBLUsPcbsxj989@hovoldconsulting.com>
 <d14567fd-0576-55bb-40c0-442e060c28ba@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d14567fd-0576-55bb-40c0-442e060c28ba@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 09:02:13PM +0530, Krishna Kurapati PSSNV wrote:
> On 5/15/2023 7:56 PM, Johan Hovold wrote:
> > On Sun, May 14, 2023 at 11:19:15AM +0530, Krishna Kurapati wrote:

> >> @@ -3133,6 +3133,72 @@ usb_1_role_switch: endpoint {
> >>   			};
> >>   		};
> >>   
> >> +		usb_2: usb@a4f8800 {
> > 
> > As I believe someone already pointed out, this node is not in sort order
> > (i.e. it should go before usb@a6f8800).

>    I missed that message, but since I named it usb_2, so I placed it in 
> order after usb_1. Hope that is fine !!

No, the nodes should be sorted by unit address so you need to move it.

> >> +			interrupts-extended = <&pdc 127 IRQ_TYPE_EDGE_RISING>,
> >> +					      <&pdc 126 IRQ_TYPE_EDGE_RISING>,
> >> +					      <&pdc 16 IRQ_TYPE_LEVEL_HIGH>,
> >> +					      <&intc GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
> >> +					      <&intc GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
> >> +					      <&intc GIC_SPI 857 IRQ_TYPE_LEVEL_HIGH>,
> >> +					      <&intc GIC_SPI 856 IRQ_TYPE_LEVEL_HIGH>;
> >> +
> >> +			interrupt-names = "dp_hs_phy_irq",
> >> +					  "dm_hs_phy_irq",
> >> +					  "ss_phy_irq",
> >> +					  "pwr_event_1",
> >> +					  "pwr_event_2",
> >> +					  "pwr_event_3",
> >> +					  "pwr_event_4";

> >> +			interconnect-names = "usb-ddr", "apps-usb";
> > 
> > Looks like 'wakeup-source' is missing here too.
> > 
> 
> I believe this property was added to enable wakeup from system suspend 
> in host mode. I didn't add this property as currently I don't need to 
> support wakeup. If any requirement comes in future, then I might need to 
> add dp/dm interrupts (if any) for other ports as well and then need to 
> change driver code to enable/disable them on suspend/resume.

If there are dp/dm/ss interrupts per ports then those need to be defined
in the binding and devicetree from the start.

Similar for 'wakeup-source' which indicates that the controller *can* be
used to wakeup the system from suspend (which those pdc interrupts
indicates).

Remember that the devicetree is supposed to describe the hardware, and
which features are currently supported in some version of software is
mostly irrelevant.

Johan
