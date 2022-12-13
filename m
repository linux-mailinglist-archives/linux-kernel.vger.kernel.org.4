Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A382C64B7DB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 15:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235814AbiLMOyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 09:54:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235895AbiLMOxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 09:53:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A25120B4;
        Tue, 13 Dec 2022 06:53:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3C3ACB81222;
        Tue, 13 Dec 2022 14:53:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8A62C433D2;
        Tue, 13 Dec 2022 14:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670943220;
        bh=0ssVJDgvZbB9LnC5sqEOsvKmP5VomXOUSJCqaAQ4RLI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b0l8P6ZVrL/TkvsRKU/S0gkk7uXRtpi0SZ5oltfRx3Sbl6NiGvi8oOpfEcCETte7+
         JOmrM4kudD/MTa4lRbiXUPNgFfehwS0tfeoyjllnLFa43XbptpTi5+W7qkSb0Y9/bI
         OcmCtJ+DfRJeeA2iJmRkcuaI+AM4IGrcJGYIPBItI+lRH9vqtf+BeBv97mqaOKxDUr
         y6fYQQAzuu4eIssTVF46UumGB/Y3ZUaPa4i7ODBdZ323qO36MwK+y/vHE/6KNRwbcA
         qO/SRTRxcOMluig5biLiT0UjdTHZlwS5XigC/1TUJ3wqDgPr/4xUUPVeZ2QrSfDxn7
         +sq9CIf3MPbyQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1p56fV-0004hh-Ob; Tue, 13 Dec 2022 15:54:05 +0100
Date:   Tue, 13 Dec 2022 15:54:05 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Brian Masney <bmasney@redhat.com>
Cc:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        johan+linaro@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ahalaney@redhat.com, echanude@redhat.com, quic_shazhuss@quicinc.com
Subject: Re: [PATCH 1/4] arm64: dts: qcom: sc8280xp: rename i2c5 to i2c21
Message-ID: <Y5iSDehp72mQPc+h@hovoldconsulting.com>
References: <20221212182314.1902632-1-bmasney@redhat.com>
 <20221212182314.1902632-2-bmasney@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212182314.1902632-2-bmasney@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 01:23:11PM -0500, Brian Masney wrote:
> According to the downstream 5.4 kernel sources for the sa8540p,
> i2c@894000 is labeled i2c bus 21, not 5. The interrupts and clocks
> also match. Let's go ahead and correct the name that's used in the
> three files where this is listed.
> 
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> Fixes: 152d1faf1e2f3 ("arm64: dts: qcom: add SC8280XP platform")
> Fixes: ccd3517faf183 ("arm64: dts: qcom: sc8280xp: Add reference device")
> Fixes: 32c231385ed43 ("arm64: dts: qcom: sc8280xp: add Lenovo Thinkpad X13s devicetree")

> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index 109c9d2b684d..875cc91324ce 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -827,7 +827,7 @@ qup2_uart17: serial@884000 {
>  				status = "disabled";
>  			};
>  
> -			qup2_i2c5: i2c@894000 {
> +			qup2_i2c21: i2c@894000 {

Note that the node is labelled qup2_i2c5 and not qup_i2c5.

That is, the QUP nodes are labelled using two indices, and specifically

	qup2_i2c5

would be another name for

	qup_i2c21

if we'd been using such a flat naming scheme (there are 8 engines per
QUP).

So there's nothing wrong with how these nodes are currently named, but
mixing the two scheme as you are suggesting would not be correct.

Johan
