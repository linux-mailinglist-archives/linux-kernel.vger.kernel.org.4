Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73CC638DAE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 16:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiKYPtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 10:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiKYPtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 10:49:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BAC23381;
        Fri, 25 Nov 2022 07:49:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54C8E6251A;
        Fri, 25 Nov 2022 15:49:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F8C2C433D7;
        Fri, 25 Nov 2022 15:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669391388;
        bh=J1n7A3Po/BvjIiR1JkMUhIHi/MIjb2B5HBeJvLmwlrc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IlJkXvd6UD0q9KHrp0K6eTAKTW+cDf93ng3pAFhU8yb2+8+Q2Xs0wtEAT6fCUkjj5
         oZhNQoGestw7q/77t7S1TOKFWod64jyhVQzayoGxCppnVhIfn7WUkBl9Fh/Qa2NX2k
         8nGl86ofw2ut2ByiUSDWTmrhXWVDljsV7RYZTltgGuLH/B4flQYbZnTGJrR02M4u++
         g+2CSHQhFFq9GwUXKT0UWMTvG4D2u95+0tAt73qLX9FXLxRE5w+hy5hNq+ocm8pVE7
         kEn6KL3kEcUENP0VM41/1pbKahH7k9fN+psf3fjR1BkdkwngmdBpPPezz+Al+vVqHt
         EZZ65d3HUhF8Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oyax9-0006Zf-7R; Fri, 25 Nov 2022 16:49:23 +0100
Date:   Fri, 25 Nov 2022 16:49:23 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp: fix PCIe DMA coherency
Message-ID: <Y4DkA6Tbf9exhnL7@hovoldconsulting.com>
References: <20221124142501.29314-1-johan+linaro@kernel.org>
 <20221125142625.GA9892@thinkpad>
 <Y4DUr7tVqnFT5HV9@hovoldconsulting.com>
 <20221125145336.GB9892@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221125145336.GB9892@thinkpad>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 08:23:36PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Nov 25, 2022 at 03:43:59PM +0100, Johan Hovold wrote:
> > On Fri, Nov 25, 2022 at 07:56:25PM +0530, Manivannan Sadhasivam wrote:
> > > On Thu, Nov 24, 2022 at 03:25:01PM +0100, Johan Hovold wrote:

> > I never claimed it would fix the problem, I explicitly wrote that it
> > made it less likely to occur (to the point where my reproducer no longer
> > triggers).
> 
> > Increasing the buffer sizes to two pages to force CMA allocation also appears
> > to make the problem go away.
> 
> The "go away" part sounded like a claim to me and hence I added the statement.
> But no worries :)

Hopefully it's clear enough if you also read the preceding sentence
(with emphasis added):

  presumably as these queues are small enough to not be allocated using
  CMA which in turn make them *more likely to be cached* (e.g. due to
  accesses to nearby pages through the cacheable linear map).

Johan
