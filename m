Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A3C644B68
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 19:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbiLFSVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 13:21:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiLFSUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 13:20:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5498E25E9F;
        Tue,  6 Dec 2022 10:20:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD130616C6;
        Tue,  6 Dec 2022 18:20:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A660C43142;
        Tue,  6 Dec 2022 18:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670350800;
        bh=GGcgVAWbKAaeKgBUJoZLQS1AH4CGIZHE1vwTGXk2aTs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dt3Y+hU8RmEVyVhlyrbrgh4oklgU7bJJEn384CzAeQQaR9qEm641gkneHOBgrepND
         qosrF5bzPPGDaFtnLJiNd3D3lOA/FwvKRNrQU8DPHfSz8ipat8wlw3N1JVk6YdSBcH
         b7f249czL+sZXDZCOG9zTwq6Snok8WsL3rN9ZUcQwUXUEVeQbYD8YnntIiYche+s7l
         YqjnE6kHpDzn9a5Yuuuf9952F9jDoCPyo9QFAJD0m+hvMNSPbAinZEKARGoCDZzHuF
         dt7QP2Zsv9DsJWeek4R27ITdUHfkK77G+LRx7veaVzmFtgKf/79XU1JVsZ74+B+yru
         4ZaAYadKjRoGw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        konrad.dybcio@linaro.org, krzysztof.kozlowski@linaro.org
Cc:     robh+dt@kernel.org, konrad.dybcio@somainline.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, patches@linaro.org
Subject: Re: [PATCH] arm64: dts: qcom: sm8450-nagara: Add gpio line names for TLMM
Date:   Tue,  6 Dec 2022 12:19:04 -0600
Message-Id: <167035076343.3155086.8221489903193050914.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221117141613.19942-1-konrad.dybcio@linaro.org>
References: <20221117141613.19942-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Nov 2022 15:16:13 +0100, Konrad Dybcio wrote:
> Sony ever so graciously provides GPIO line names in their downstream
> kernel (though sometimes they are not 100% accurate and you can judge
> that by simply looking at them and with what drivers they are used).
> 
> Add these to the PDX223&224 DTSIs to better document the hardware.
> 
> Diff between 223 and 224:
> < 	gpio-line-names = "NC", /* GPIO_0 */
> < 			  "NC",
> < 			  "NC",
> < 			  "NC",
> > 	gpio-line-names = "TELE_SPI_MISO", /* GPIO_0 */
> > 			  "TELE_SPI_MOSI",
> > 			  "TELE_SPI_CLK",
> > 			  "TELE_SPI_CS_N",
> < 			  "PM8010_2_RESET_N",
> > 			  "NC",
> < 			  "NC",
> > 			  "UWIDEC_PWR_EN",
> < 			  "TOF_RST_N",
> > 			  "NC"
> < 			  "QLINK1_REQ",
> < 			  "QLINK1_EN", /* GPIO_160 */
> < 			  "QLINK1_WMSS_RESET_N",
> > 			  "NC",
> > 			  "NC", /* GPIO_160 */
> > 			  "NC",
> The tele lens setup is different on 1 IV and 5 IV and power wiring
> is different for some lenses, so it makes sense. As for QLINK, no
> idea.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sm8450-nagara: Add gpio line names for TLMM
      commit: 15245c93d3c8775a8405c0de18704a8c17a41775

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
