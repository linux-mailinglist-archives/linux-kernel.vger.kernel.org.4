Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C4564B83D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 16:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236106AbiLMPTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 10:19:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236099AbiLMPTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 10:19:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1A52183C;
        Tue, 13 Dec 2022 07:19:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE4B66159F;
        Tue, 13 Dec 2022 15:19:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA3C8C433EF;
        Tue, 13 Dec 2022 15:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670944742;
        bh=jZsLp8bpAs8v+aLzKXeFWiL5E5Xn6zfVmUtVQ0BqEkA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qs4HAK4Emz9hzOJYaySZadvmLsY1XogOTrknWHgknYcJ1tzdk5NmCtS33VakU2y4P
         oaq56P6CVD0ex1VhWDRWaIHKwKGWCiivBU3q/vSFEaNBmwJEIHr6BysRgQwmCtUidb
         y+9IX0EACcJ/A+Bz+d6VhUJfCK7hhydabm6xZaFsD+pI8fBJpNS2Z2VGROrLHKEd3O
         K09ZrBpEc05bFzcW+CzCzeOdBo1bt58oK+rpTihS1m0KMs5Cr9g3+QkVKxvOT8Z0UL
         x6/DrToWHbVwWoj9JLpXWTO3GcG2XBRIi0B9n0hXaZ2cx4WcI9BZm8T1WkzN9lwCcD
         lns7X3M6GQB7A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1p5744-00054f-Qt; Tue, 13 Dec 2022 16:19:28 +0100
Date:   Tue, 13 Dec 2022 16:19:28 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Shazad Hussain <quic_shazhuss@quicinc.com>
Cc:     Brian Masney <bmasney@redhat.com>, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, johan+linaro@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ahalaney@redhat.com,
        echanude@redhat.com
Subject: Re: [PATCH 1/4] arm64: dts: qcom: sc8280xp: rename i2c5 to i2c21
Message-ID: <Y5iYAAdkJVfLrITf@hovoldconsulting.com>
References: <20221212182314.1902632-1-bmasney@redhat.com>
 <20221212182314.1902632-2-bmasney@redhat.com>
 <Y5iSDehp72mQPc+h@hovoldconsulting.com>
 <5ac2a022-59e5-1189-bcba-e67b4974cbad@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ac2a022-59e5-1189-bcba-e67b4974cbad@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 08:34:56PM +0530, Shazad Hussain wrote:
> 
> 
> On 12/13/2022 8:24 PM, Johan Hovold wrote:
> > On Mon, Dec 12, 2022 at 01:23:11PM -0500, Brian Masney wrote:
> >> According to the downstream 5.4 kernel sources for the sa8540p,
> >> i2c@894000 is labeled i2c bus 21, not 5. The interrupts and clocks
> >> also match. Let's go ahead and correct the name that's used in the
> >> three files where this is listed.
> >>
> >> Signed-off-by: Brian Masney <bmasney@redhat.com>
> >> Fixes: 152d1faf1e2f3 ("arm64: dts: qcom: add SC8280XP platform")
> >> Fixes: ccd3517faf183 ("arm64: dts: qcom: sc8280xp: Add reference device")
> >> Fixes: 32c231385ed43 ("arm64: dts: qcom: sc8280xp: add Lenovo Thinkpad X13s devicetree")
> > 
> >> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> >> index 109c9d2b684d..875cc91324ce 100644
> >> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> >> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> >> @@ -827,7 +827,7 @@ qup2_uart17: serial@884000 {
> >>   				status = "disabled";
> >>   			};
> >>   
> >> -			qup2_i2c5: i2c@894000 {
> >> +			qup2_i2c21: i2c@894000 {
> > 
> > Note that the node is labelled qup2_i2c5 and not qup_i2c5.
> > 
> > That is, the QUP nodes are labelled using two indices, and specifically
> > 
> > 	qup2_i2c5
> > 
> > would be another name for
> > 
> > 	qup_i2c21
> > 
> > if we'd been using such a flat naming scheme (there are 8 engines per
> > QUP).
> > 
> > So there's nothing wrong with how these nodes are currently named, but
> > mixing the two scheme as you are suggesting would not be correct.
> 
> Wondering we might need to change qup2_uart17 to qup2_uart1 then ?

Right, I just noticed that too.

Johan
