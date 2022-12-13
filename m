Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA6164B875
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 16:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236168AbiLMPc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 10:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236180AbiLMPcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 10:32:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D9C13F6A;
        Tue, 13 Dec 2022 07:32:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDB896156A;
        Tue, 13 Dec 2022 15:32:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDFE9C433EF;
        Tue, 13 Dec 2022 15:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670945537;
        bh=kVDKUdti33XTefbEJEXfmxK8dV0SRSUu09JS0+ypmzQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=teSjOeLv3+CS6aZ4cX3lc8WrGB3OSj1wLBy6NRgyKtcAMSGFv3GE2y1vk+wDo6W9h
         YooBWKCL/5JJokzBkUmenE32QoX92rc7xL9vkdw+bNK1WxRxB/8QuzbBjOQdLA0YmY
         +XN+9uTiUu4VFZogHFfBlDIests+oEVsjMfuH0pEYC/+E+M/z2rSNC6xMvoBY3iJ6S
         LlBBmU5IXLwOoyn8rj9F+t5cqoZ/titQNrRWBVpLabUDhfnRVqT6lMMHNjf72ebIyF
         tEbS43edLE6/h+oT7uAa060SUSKr5UDpsq6nvJ9pQgOW477j+JuHQj7A4RNLttKkBN
         8NFCHueOkltZw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1p57Gt-0005HU-0a; Tue, 13 Dec 2022 16:32:43 +0100
Date:   Tue, 13 Dec 2022 16:32:43 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Brian Masney <bmasney@redhat.com>, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        johan+linaro@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ahalaney@redhat.com, echanude@redhat.com, quic_shazhuss@quicinc.com
Subject: Re: [PATCH 1/4] arm64: dts: qcom: sc8280xp: rename i2c5 to i2c21
Message-ID: <Y5ibG29yKQgD54Dn@hovoldconsulting.com>
References: <20221212182314.1902632-1-bmasney@redhat.com>
 <20221212182314.1902632-2-bmasney@redhat.com>
 <Y5iSDehp72mQPc+h@hovoldconsulting.com>
 <Y5iXjTQnEtMCZy7W@hovoldconsulting.com>
 <114e960f-3b63-8c8f-9d4a-87173049d730@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <114e960f-3b63-8c8f-9d4a-87173049d730@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 04:29:04PM +0100, Konrad Dybcio wrote:
> 
> 
> On 13.12.2022 16:17, Johan Hovold wrote:
> > On Tue, Dec 13, 2022 at 03:54:05PM +0100, Johan Hovold wrote:
> >> On Mon, Dec 12, 2022 at 01:23:11PM -0500, Brian Masney wrote:
> >>> According to the downstream 5.4 kernel sources for the sa8540p,
> >>> i2c@894000 is labeled i2c bus 21, not 5. The interrupts and clocks
> >>> also match. Let's go ahead and correct the name that's used in the
> >>> three files where this is listed.
> >>>
> >>> Signed-off-by: Brian Masney <bmasney@redhat.com>
> >>> Fixes: 152d1faf1e2f3 ("arm64: dts: qcom: add SC8280XP platform")
> >>> Fixes: ccd3517faf183 ("arm64: dts: qcom: sc8280xp: Add reference device")
> >>> Fixes: 32c231385ed43 ("arm64: dts: qcom: sc8280xp: add Lenovo Thinkpad X13s devicetree")
> >>
> >>> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> >>> index 109c9d2b684d..875cc91324ce 100644
> >>> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> >>> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> >>> @@ -827,7 +827,7 @@ qup2_uart17: serial@884000 {
> >>>  				status = "disabled";
> >>>  			};
> >>>  
> >>> -			qup2_i2c5: i2c@894000 {
> >>> +			qup2_i2c21: i2c@894000 {
> >>
> >> Note that the node is labelled qup2_i2c5 and not qup_i2c5.
> >>
> >> That is, the QUP nodes are labelled using two indices, and specifically
> >>
> >> 	qup2_i2c5
> >>
> >> would be another name for
> >>
> >> 	qup_i2c21
> >>
> >> if we'd been using such a flat naming scheme (there are 8 engines per
> >> QUP).
> >>
> >> So there's nothing wrong with how these nodes are currently named, but
> >> mixing the two scheme as you are suggesting would not be correct.
> > 
> > It appears sc8280xp is the only qcom platform using a qup prefix (even
> > if some older platform use a blsp equivalent), and we're not even using
> > it consistently as we, for example, have both
> > 
> > 	qup2_uart17, and
> > 	qup2_i2c5
> > 
> > (where the former should have been qup2_uart1).
> > 
> > So either we fix up the current labels or just drop the qup prefixes and
> > use a flat naming scheme (e.g. uart17 and i2c21).

> Oh, I didn't notice that! I suppose sticking with i2cN as we've been
> doing ever since i2c-geni was introduced sounds like the best option..

Yeah, sounds good to me.

Johan
