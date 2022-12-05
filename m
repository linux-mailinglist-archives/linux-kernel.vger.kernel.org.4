Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB855642901
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 14:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbiLENMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 08:12:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbiLENMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 08:12:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8D2F003;
        Mon,  5 Dec 2022 05:12:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 224B761028;
        Mon,  5 Dec 2022 13:12:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B7CFC433C1;
        Mon,  5 Dec 2022 13:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670245963;
        bh=1QbzamV3A2qmrdEpK1J1pOC6A2KL2YT6USyTTfDVch4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cYci+xZ75sEEbuYfddls/Isa7RPZUEXnGzSfTxjupZXlCwi0fK6DKK9d/cVb4K6uQ
         89ujVOaZBmtDGDCclvXGV5pvCXQ901jNck95YGRI+ETj1FdRfz8y1pu7p73VONyHGw
         DYuf1mpnhRsyrBtXPm9GFR1eWQHTyl0b0nlFAjk0+a9CFGSaxUWf3FOvHCeXnSZo+g
         1c7aptmt8p7rR1PAc0HPH4+WaLm7uy3MZCI+rMwETSNBeDkHZnYjhIzSJ04vs/aOpg
         LOd51XKtglMCyuIywKs6+8Rhzyd/lqS7JfGtWWRtoI0J49WOCvVXNxLQPyZG+r23S1
         5uGfzc/BQhOdw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1p2BH6-0000p6-Gc; Mon, 05 Dec 2022 14:12:48 +0100
Date:   Mon, 5 Dec 2022 14:12:48 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: ufs: qcom: allow 'dma-coherent' property
Message-ID: <Y43uUA2X4Vzn+VLF@hovoldconsulting.com>
References: <20221205100837.29212-1-johan+linaro@kernel.org>
 <20221205100837.29212-2-johan+linaro@kernel.org>
 <20221205115906.GA20192@thinkpad>
 <Y43e9KRDsTCS5VI4@hovoldconsulting.com>
 <20221205122018.GC20192@thinkpad>
 <Y43jtpHqlyiIEZ0S@hovoldconsulting.com>
 <20221205130048.GD20192@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221205130048.GD20192@thinkpad>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2022 at 06:30:48PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Dec 05, 2022 at 01:27:34PM +0100, Johan Hovold wrote:
> > On Mon, Dec 05, 2022 at 05:50:18PM +0530, Manivannan Sadhasivam wrote:
> > > On Mon, Dec 05, 2022 at 01:07:16PM +0100, Johan Hovold wrote:
> > > > On Mon, Dec 05, 2022 at 05:29:06PM +0530, Manivannan Sadhasivam wrote:
> > > > > On Mon, Dec 05, 2022 at 11:08:36AM +0100, Johan Hovold wrote:
> > > > > > UFS controllers may be cache coherent and must be marked as such in the
> > > > > > devicetree to avoid data corruption.
> > > > > > 
> > > > > > This is specifically needed on recent Qualcomm platforms like SC8280XP.
> > > > > > 
> > > > > > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

> > > > Yes, it would be a valid, but it will only be added to the DTs of SoCs
> > > > that actually require it. No need to re-encode the dtsi in the binding.
> > > > 
> > > 
> > > But if you make a property valid in the binding then it implies that anyone
> > > could add it to DTS which is wrong. You should make this property valid for
> > > SoCs that actually support it.
> > 
> > No, it's not wrong.
> > 
> > Note that the binding only requires 'compatible' and 'regs', all other
> > properties are optional, and you could, for example, add a
> > 'reset' property to a node for a device which does not have a reset
> > without the DT validation failing.
> > 
> 
> Then what is the point of devicetree validation using bindings?

You're still making sure that no properties are added that are not
documented, number of clocks, names of clocks, etc.

> There is also a comment from Krzysztof: https://lkml.org/lkml/2022/11/24/390

Speaking of Krzysztof:

	https://lore.kernel.org/lkml/20221204094717.74016-5-krzysztof.kozlowski@linaro.org/

Johan
