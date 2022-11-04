Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1EC619382
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 10:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiKDJaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 05:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbiKDJ3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 05:29:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582C529CA4;
        Fri,  4 Nov 2022 02:29:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E65ED62114;
        Fri,  4 Nov 2022 09:29:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50DCFC433C1;
        Fri,  4 Nov 2022 09:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667554188;
        bh=GvpMC/s97cy1zODznYS5BOEVcIvr4qyq43qRasSeRqs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WYbQsiIwNF1cF6QBI0aTi+8vG8quWpm81ADIzZIhiYBWKG1Ece4kXL5OLIshNohBf
         wO5oSxVeOYvYS76vsIkHoO+BudVt4N7putwzbWkN6ULnSuaRjQE2ZrIsxhJXfjhYAh
         bYPc1mZLfok3O/YriEm91hnClG5gwU1DePng7rLNKElK3GuEvMpIf6jQt0L0DOnUGU
         o5x1VMLz8t4XAKAAdGKzI6LDbIxlRolpcY+PDN8c8/VuiIuH/oR4VMo5ZaFtZ0Vfe4
         bHKXYbnemDuNvMs0HG+K1F/0SvWEhCUblmL2iAl40CmpSB/rgkAXziTOaDUsX0Q7tT
         YJe5ZQ5YvyLmA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oqt10-0004ha-Gb; Fri, 04 Nov 2022 10:29:30 +0100
Date:   Fri, 4 Nov 2022 10:29:30 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Shazad Hussain <quic_shazhuss@quicinc.com>,
        Stephen Boyd <sboyd@kernel.org>, bmasney@redhat.com,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] clk: qcom: gcc-sc8280xp: add cxo as parent for
 gcc_ufs_ref_clkref_clk
Message-ID: <Y2Tber39cHuOSR/W@hovoldconsulting.com>
References: <20221030142333.31019-1-quic_shazhuss@quicinc.com>
 <20221101182402.32CE5C433C1@smtp.kernel.org>
 <Y2IZaxukERXNcPGR@hovoldconsulting.com>
 <c96304da-f57e-4926-2f3f-665c2054fb00@quicinc.com>
 <Y2Imnf1+v5j5CH9r@hovoldconsulting.com>
 <bb590bfb-07a4-97c1-e5c0-d00d840e2e11@quicinc.com>
 <Y2I3tekSAO42r0xR@hovoldconsulting.com>
 <20221103024949.lw4g2tavk7uw5xt4@builder.lan>
 <Y2OEjNAPXg5BfOxH@hovoldconsulting.com>
 <20221103152355.5sfbkpsfvjzgeixi@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103152355.5sfbkpsfvjzgeixi@builder.lan>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 10:23:55AM -0500, Bjorn Andersson wrote:
> On Thu, Nov 03, 2022 at 10:06:20AM +0100, Johan Hovold wrote:
> > On Wed, Nov 02, 2022 at 09:49:49PM -0500, Bjorn Andersson wrote:

> > > In line with the downstream dts, we have GCC_UFS{,_1}_CARD_CLKREF_CLK
> > > providing a reference clock to the two phys. Then GCC_UFS_REF_CLKREF_CLK
> > > feeds the UFS refclock pads (both of them), which connect to the memory
> > > device(s).
> > > 
> > > In other words, GCC_UFS{,_1}_CARD_CLKREF_CLK should be "ref" in
> > > respective phy.
> > > 
> > > GCC_UFS_REF_CLKREF_CLK is the clock to the devices, but as we don't
> > > represent the memory device explicitly it seems suitable to use as
> > > "ref_clk" in the ufshc nodes - which would then match the special
> > > handling of the "link clock" in the UFS driver.
> > 
> > Thanks for clearing that up. Using GCC_UFS_REF_CLKREF_CLK as ref_clk for
> > the controller sounds reasonable.
> > 
> > I guess the only missing piece is which "card" ref clock is used by
> > which PHY.
> > 
> > The ADP dts uses:
> > 
> > 	phy			ref clock
> > 
> > 	phy@1d87000 (UFS_PHY)	GCC_UFS_CARD_CLKREF_CLK
> > 	phy@1da7000 (UFS_CARD)	GCC_UFS_1_CARD_CLKREF_CLK
> > 
> 
> This matches the documentation.

Thanks for checking.

> > > All three clocks are sourced off the CXO pad, so I would like this patch
> > > to cover at least all of these. And
> > > 
> > > Fixes: d65d005f9a6c ("clk: qcom: add sc8280xp GCC driver")
> > > 
> > > seems to be in order for such patch.
> > > 
> > > 
> > > @Johan, would you mind writing a dts patch flipping the clocks around
> > > and Shazad can update this patch?
> > 
> > I'll do so, but I'll wait with posting until you can confirm which
> > clkref is which.

I've know posted a patch fixing the devicetree here:

	https://lore.kernel.org/lkml/20221104092045.17410-1-johan+linaro@kernel.org/

Note that we need to get Shazad's clock driver fix in first as the UFS
controller driver expects a valid frequency for the device ref clock.

Johan
