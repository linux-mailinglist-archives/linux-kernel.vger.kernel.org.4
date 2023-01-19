Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93626672F6E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 04:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjASDPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 22:15:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjASDMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 22:12:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849C82B61B;
        Wed, 18 Jan 2023 19:11:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0CAAE60684;
        Thu, 19 Jan 2023 03:11:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 896D2C433EF;
        Thu, 19 Jan 2023 03:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674097899;
        bh=ZFnXbMslwExvHQav6CVuep6N5rjcp0bLLlr1yNvmzoU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DpkQ21nZnOs3m6T6tOitOPjcIx3DVIdYR3FhDlS1ilJ1p/rSr8xE1reulRJWOAIiz
         EK/xpM3GwcmbPwomuQ72wp4IrfaXfEeEApp5I1szlK9m6AOnPVwwyKjzwVO3EHcaWR
         KFIyX9ocvhRLl2gVjEjn42wqL4b7trjl9vB1rADCS4U7ngD2FMx/vOmQnZciCMrQ9O
         vjfRfHUE8ZnISjG0pJePWE+ApEovi5V3j1m6up3TzUU1aKb7Fm5nAJ7l8jIaKkxTAt
         bppiB69ouGd+pOgGkO/wd1nFYUt1kKsTl6m/9UaiYPevyh/rp4CmmY3AIVRiHcB//f
         /oyGQYYnPfBtg==
Date:   Wed, 18 Jan 2023 21:11:36 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: clock: qcom,a53pll: drop operating-points-v2
Message-ID: <20230119031136.27vson2awemt3nkt@builder.lan>
References: <20230113145859.82868-1-krzysztof.kozlowski@linaro.org>
 <e73ad320fafa1365e3506bbd4cc77d8d.sboyd@kernel.org>
 <063c5516-417d-7c21-b58f-a6552779a621@linaro.org>
 <705c78c1d0da18089419b064832d5fed.sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <705c78c1d0da18089419b064832d5fed.sboyd@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 11:11:00AM -0800, Stephen Boyd wrote:
> Quoting Krzysztof Kozlowski (2023-01-15 06:35:23)
> > On 13/01/2023 21:28, Stephen Boyd wrote:
> > > Quoting Krzysztof Kozlowski (2023-01-13 06:58:59)
> > >> The CPU PLL clock node does not use OPP tables (neither driver).
> > > 
> > > What device is qcom_a53pll_get_freq_tbl() operating on?
> > 
> > On its own, internal table. While of course driver could be converted to
> > operating-points-v2, no one did it within last 5 years, so why it should
> > happen now?
> > 
> 
> The property was added mid 2021 by Shawn[1], that's not 5 years ago. I
> guess there were plans to add an OPP table that never happened[2]? Is
> Shawn still working on this? If not, we should revert the OPP code out
> of the driver.
> 

@Bryan, what do you think about this?

Thanks,
Bjorn

> [1] https://lore.kernel.org/all/20210704024032.11559-4-shawn.guo@linaro.org/
> [2] https://lore.kernel.org/all/20210709021334.GB11342@dragon/
