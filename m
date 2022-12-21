Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2951D652D2D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 08:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234180AbiLUHMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 02:12:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLUHMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 02:12:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F6C205CF;
        Tue, 20 Dec 2022 23:12:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 38AFFB819B4;
        Wed, 21 Dec 2022 07:12:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF365C433EF;
        Wed, 21 Dec 2022 07:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671606731;
        bh=wB5ZvGobvITOzarRwRMummvTj0QNOaf/TUyKeEQS7eM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EJeX7s39E/jGa0z69sFBURv09t0RcsFo6fmF5jnurO1QMjMR3inwl3WsCKdB/Ippv
         hNs8L0Af8f7zoZZmSu2Gta3B8urQPl1PyWCGYUfwh80fdJzYCs7TtHifJiZhw3w+rV
         PLJWWMN9m66UOWj0ApluhfFUa0cr7wOx7fjUi8Zz9QZXC8ljutWOPkIhzYyfTCFZtX
         cKHDAoPX4ml5p+GydmOzZ9xp/YcyYbwWrRUZgy2svvriUhzYXLXiK37ofcAsAGOoz+
         bMWFZdmzDjzOd1YQn8RN5lPVu4DX50pdSZQxOk/K16NDvOoiFBjeahMzc4PUrti4fl
         ixZB7lAeDo05w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1p7tHe-0003Kq-Cd; Wed, 21 Dec 2022 08:12:59 +0100
Date:   Wed, 21 Dec 2022 08:12:58 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Lux Aliaga <they@mint.lgbt>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] arm64: dts: qcom: sm6125: Add UFS nodes
Message-ID: <Y6Kx+iq9c5izbYRH@hovoldconsulting.com>
References: <20221215190404.398788-1-they@mint.lgbt>
 <20221215190404.398788-2-they@mint.lgbt>
 <e474f99d-2375-c8db-203c-632c918d8e4d@linaro.org>
 <6ddf93eb-aadb-a9b8-d91a-0c56ed54418f@mint.lgbt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ddf93eb-aadb-a9b8-d91a-0c56ed54418f@mint.lgbt>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2022 at 12:34:46AM -0300, Lux Aliaga wrote:
> 
> On 16/12/2022 08:24, Konrad Dybcio wrote:
> >
> > On 15.12.2022 20:04, Lux Aliaga wrote:
> >> Adds a UFS host controller node and its corresponding PHY to
> >> the sm6125 platform.

> >> +			reg = <0x04807000 0x1c4>;
> >> +
> >> +			power-domains = <&gcc UFS_PHY_GDSC>;
> >> +
> >> +			clock-names = "ref", "ref_aux";
> >> +			clocks = <&gcc GCC_UFS_MEM_CLKREF_CLK>, <&gcc GCC_UFS_PHY_PHY_AUX_CLK>;
> >> +
> >> +			resets = <&ufs_mem_hc 0>;
> >> +			reset-names = "ufsphy";
> >> +
> >> +			#address-cells = <1>;
> >> +			#size-cells = <1>;
> >> +			ranges;
> >> +
> >> +			status = "disabled";
> >> +
> >> +			ufs_mem_phy_lanes: lanes@4807400 {
> >> +				reg = <0x4807400 0x098>,
> >> +				      <0x4807600 0x130>,
> >> +				      <0x4807c00 0x16c>;
> >> +				#phy-cells = <0>;
> >> +			};
> > I believe this is deprecated. See [1].

> > [1] https://lore.kernel.org/linux-arm-msm/20221104092045.17410-1-johan+linaro@kernel.org/T/#m988f3fe3d83b76bac247aea2d9dac34f37728d65

> I've looked into the documentation and this is only for the sc8280xp. 
> This PHY is defined as it is for the msm8996 and derivatives.

No, it's not just for sc8280xp. It's intended for all new bindings (i.e.
do not add more platforms to the msm8996 schema file).

Johan
