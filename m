Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0D9656CF8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 17:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiL0Qec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 11:34:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbiL0QeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 11:34:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69E8FCA;
        Tue, 27 Dec 2022 08:34:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 270BAB80E8C;
        Tue, 27 Dec 2022 16:34:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D319C433EF;
        Tue, 27 Dec 2022 16:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672158856;
        bh=L4X2cqJuODaqT66gGdKRMeIV6j3U8LZVs5YsoD0VJqk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ioAXOXnP+kK9D6Ommoy7Z/pjdq6zDaCXFfwCm4Ze6DV0ZDpDW7Uj7xvmgi21nvu+P
         DoBz4Dk/m4XrulnxHQRaUq5zmt5k2cloWM26BRtmojUJZQMZTS8Ej2LM6jMDEhk96r
         +FISTO6fU2QNvoOiZtGkG7CWpKgm9H/5tQXLWRoIEuylIQ0pbFAS1yDV+v5+7yBcNM
         itYR2AbmVUlgNdo131rvH83T0aDLOxq/WzaSM5XW+hUY2Jc0IxhQko3hXhKKDHIS8J
         qWMKEzDvjEVe4gwt0gJVlV5dPLIi5sUASX3xdEqVOJO/6QIR4G3F4s0PtcstXTERsV
         TjD61wRlvjIMA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pACu8-0003lF-K6; Tue, 27 Dec 2022 17:34:16 +0100
Date:   Tue, 27 Dec 2022 17:34:16 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Lux Aliaga <they@mint.lgbt>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Adam Skladowski <a39.skl@gmail.com>
Subject: Re: [PATCH v4 2/4] arm64: dts: qcom: sm6125: Add UFS nodes
Message-ID: <Y6seiLt0447jnkRs@hovoldconsulting.com>
References: <20221215190404.398788-1-they@mint.lgbt>
 <20221215190404.398788-2-they@mint.lgbt>
 <e474f99d-2375-c8db-203c-632c918d8e4d@linaro.org>
 <6ddf93eb-aadb-a9b8-d91a-0c56ed54418f@mint.lgbt>
 <Y6Kx+iq9c5izbYRH@hovoldconsulting.com>
 <f76f19df-ff82-e24d-511c-ad5b4ff7683b@mint.lgbt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f76f19df-ff82-e24d-511c-ad5b4ff7683b@mint.lgbt>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2022 at 12:57:09AM -0300, Lux Aliaga wrote:
> On 21/12/2022 04:12, Johan Hovold wrote:
> 
> > On Wed, Dec 21, 2022 at 12:34:46AM -0300, Lux Aliaga wrote:
> >> On 16/12/2022 08:24, Konrad Dybcio wrote:
> >>> On 15.12.2022 20:04, Lux Aliaga wrote:
> >>>> Adds a UFS host controller node and its corresponding PHY to
> >>>> the sm6125 platform.
> >>>> +			reg = <0x04807000 0x1c4>;
> >>>> +
> >>>> +			power-domains = <&gcc UFS_PHY_GDSC>;
> >>>> +
> >>>> +			clock-names = "ref", "ref_aux";
> >>>> +			clocks = <&gcc GCC_UFS_MEM_CLKREF_CLK>, <&gcc GCC_UFS_PHY_PHY_AUX_CLK>;
> >>>> +
> >>>> +			resets = <&ufs_mem_hc 0>;
> >>>> +			reset-names = "ufsphy";
> >>>> +
> >>>> +			#address-cells = <1>;
> >>>> +			#size-cells = <1>;
> >>>> +			ranges;
> >>>> +
> >>>> +			status = "disabled";
> >>>> +
> >>>> +			ufs_mem_phy_lanes: lanes@4807400 {
> >>>> +				reg = <0x4807400 0x098>,
> >>>> +				      <0x4807600 0x130>,
> >>>> +				      <0x4807c00 0x16c>;
> >>>> +				#phy-cells = <0>;
> >>>> +			};
> >>> I believe this is deprecated. See [1].
> >>> [1] https://lore.kernel.org/linux-arm-msm/20221104092045.17410-1-johan+linaro@kernel.org/T/#m988f3fe3d83b76bac247aea2d9dac34f37728d65
> >> I've looked into the documentation and this is only for the sc8280xp.
> >> This PHY is defined as it is for the msm8996 and derivatives.
> > No, it's not just for sc8280xp. It's intended for all new bindings (i.e.
> > do not add more platforms to the msm8996 schema file).

> Alright. But this would mean writing a new config for the sm6125 
> specifically. If we're changing how the bindings for UFS PHYs work, 
> wouldn't it make more sense to change the sm6115 config instead, since 
> they're defined pretty much the same?

It can be done that way too, that is, you can add the missing offsets to
the sm6115 config and use it for both sm6115 and sm6125 if they are
really that closely related. The driver will only parse the old-style
bindings (for sm6115) if the PHY node has a child.

You still need to add a new compatible for sm6125 to the PHY driver,
though, which appears to be missing in this series.

Johan
