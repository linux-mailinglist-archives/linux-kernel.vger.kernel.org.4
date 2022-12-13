Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6DB64B834
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 16:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236053AbiLMPRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 10:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235161AbiLMPRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 10:17:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BFA2098F;
        Tue, 13 Dec 2022 07:17:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 60247B811D8;
        Tue, 13 Dec 2022 15:17:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06486C433D2;
        Tue, 13 Dec 2022 15:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670944628;
        bh=5QESWjudrIWVHyOcAlkl6YNsgZ0EkNBCvncmf6xjMOM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YUgRo65BwCx+hSWdf1niQ24ejHfuX4ek/krmnbk5Y1v1j7WdpaDyYAIBnIJj631Uz
         tzFdIJaiqguVn0mMztziVjKpKZ9SzAJCUT7DtLRyV5f5pK0Ti7TBD2/fnJfbSgtDHD
         msSLKTxGrOOgqXA++cj7KQRxIDpiM6wgfQmPSuLr7JRVis7xxDKtyGykNnhzGz0UHZ
         +FGOdLP5p6Q9XiE3SOpNvkWWrFC59lUTz0TBeCTf1OEOXT73s3L9XONWvnoWZgJqn7
         03StvfYEVoWTs9WX463dfh0WKMGkvtrL5cRTUkqaIyOYHx55fktwPVZUp7c+zC/KBl
         P/nK0WdI9kkXw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1p572D-00053B-7H; Tue, 13 Dec 2022 16:17:33 +0100
Date:   Tue, 13 Dec 2022 16:17:33 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Brian Masney <bmasney@redhat.com>
Cc:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        johan+linaro@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ahalaney@redhat.com, echanude@redhat.com, quic_shazhuss@quicinc.com
Subject: Re: [PATCH 1/4] arm64: dts: qcom: sc8280xp: rename i2c5 to i2c21
Message-ID: <Y5iXjTQnEtMCZy7W@hovoldconsulting.com>
References: <20221212182314.1902632-1-bmasney@redhat.com>
 <20221212182314.1902632-2-bmasney@redhat.com>
 <Y5iSDehp72mQPc+h@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5iSDehp72mQPc+h@hovoldconsulting.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 03:54:05PM +0100, Johan Hovold wrote:
> On Mon, Dec 12, 2022 at 01:23:11PM -0500, Brian Masney wrote:
> > According to the downstream 5.4 kernel sources for the sa8540p,
> > i2c@894000 is labeled i2c bus 21, not 5. The interrupts and clocks
> > also match. Let's go ahead and correct the name that's used in the
> > three files where this is listed.
> > 
> > Signed-off-by: Brian Masney <bmasney@redhat.com>
> > Fixes: 152d1faf1e2f3 ("arm64: dts: qcom: add SC8280XP platform")
> > Fixes: ccd3517faf183 ("arm64: dts: qcom: sc8280xp: Add reference device")
> > Fixes: 32c231385ed43 ("arm64: dts: qcom: sc8280xp: add Lenovo Thinkpad X13s devicetree")
> 
> > diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> > index 109c9d2b684d..875cc91324ce 100644
> > --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> > @@ -827,7 +827,7 @@ qup2_uart17: serial@884000 {
> >  				status = "disabled";
> >  			};
> >  
> > -			qup2_i2c5: i2c@894000 {
> > +			qup2_i2c21: i2c@894000 {
> 
> Note that the node is labelled qup2_i2c5 and not qup_i2c5.
> 
> That is, the QUP nodes are labelled using two indices, and specifically
> 
> 	qup2_i2c5
> 
> would be another name for
> 
> 	qup_i2c21
> 
> if we'd been using such a flat naming scheme (there are 8 engines per
> QUP).
> 
> So there's nothing wrong with how these nodes are currently named, but
> mixing the two scheme as you are suggesting would not be correct.

It appears sc8280xp is the only qcom platform using a qup prefix (even
if some older platform use a blsp equivalent), and we're not even using
it consistently as we, for example, have both

	qup2_uart17, and
	qup2_i2c5

(where the former should have been qup2_uart1).

So either we fix up the current labels or just drop the qup prefixes and
use a flat naming scheme (e.g. uart17 and i2c21).

Either way, there's no need for any Fixes tags as this isn't a bug.

Johan
