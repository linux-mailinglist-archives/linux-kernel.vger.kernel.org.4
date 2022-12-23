Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524806550AD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 14:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236142AbiLWNEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 08:04:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiLWNEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 08:04:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E641B11C2B;
        Fri, 23 Dec 2022 05:04:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 67BEBB82048;
        Fri, 23 Dec 2022 13:04:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0565CC433EF;
        Fri, 23 Dec 2022 13:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671800658;
        bh=py2GGdNX5gJIqq+trSYKEbk7oSorzHcDOGikjhB5VuI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BtRikoiQcEr/09nglBK/tHO0EAPCW4jHbRpN7cnMilSZjrPJC3/+HVScyY0Ok9lBx
         lSAV9U3iWhFEW6reqWB23zPLWs8kyCqPtNuQozkTCXD8nNcYtoeM9aDqHFz6S/uSnz
         sizbEWyLzEKgqG0/PK3H+N6SNyw+sXhoBhDLFb6jhBsD3GHlg3tD1XISmci8dwjTif
         RVhEGZdOt6EXV569jimEPnRCkA284JS4oyak7iQ4sR7IfyF6vS0yGW7fTp2ffVcD2d
         TWPXD6/oQ8faUnYg9VsZ/Gd41JsgEM/1UlunM0aazU+0E90emj3fMisvYAD6YSX3TY
         34qenFdc9xgpw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1p8hjb-0007xo-Dq; Fri, 23 Dec 2022 14:05:11 +0100
Date:   Fri, 23 Dec 2022 14:05:11 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Brian Masney <bmasney@redhat.com>, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, quic_shazhuss@quicinc.com,
        robh+dt@kernel.org, johan+linaro@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ahalaney@redhat.com,
        echanude@redhat.com
Subject: Re: [PATCH v3 4/7] arm64: dts: qcom: sc8280xp: add missing i2c nodes
Message-ID: <Y6Wnh+tXPhF6aC1b@hovoldconsulting.com>
References: <20221220192854.521647-1-bmasney@redhat.com>
 <20221220192854.521647-5-bmasney@redhat.com>
 <Y6WEzkcP31S2JGrL@hovoldconsulting.com>
 <80ef7460-2c92-1636-96c7-c91b7d5c62e6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80ef7460-2c92-1636-96c7-c91b7d5c62e6@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2022 at 01:42:32PM +0100, Konrad Dybcio wrote:
> On 23.12.2022 11:37, Johan Hovold wrote:
 
> >> +			i2c16: i2c@880000 {
> >> +				compatible = "qcom,geni-i2c";
> >> +				reg = <0 0x00880000 0 0x4000>;
> >> +				clocks = <&gcc GCC_QUPV3_WRAP2_S0_CLK>;
> >> +				clock-names = "se";
> >> +				interrupts = <GIC_SPI 373 IRQ_TYPE_LEVEL_HIGH>;
> >> +				#address-cells = <1>;
> >> +				#size-cells = <0>;
> > 
> > I'm aware that the two current i2c nodes has these two properties here
> > in the middle, but would you mind moving '#address-cells' and
> > '#size-cells' after 'reg' instead where I'd expect them to be?

> Hm.. we've been sticking them somewhere near the end for the longest
> time for every bus-like, or generally "i have childen" type node..
> I see it's a rather mixed bag in non-qcom SoCs, people just seem to
> put it wherever they please.. The dt spec doesn't seem to mention any
> preference fwiw.

The rationale for placing them under 'reg' is that you keep the
address-related properties together (e.g. 'reg', '#address-cells',
'#size-cells' and 'ranges').

Johan
