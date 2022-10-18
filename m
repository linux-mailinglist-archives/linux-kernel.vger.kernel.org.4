Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921916021BF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiJRDHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbiJRDGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:06:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30DC73901;
        Mon, 17 Oct 2022 20:06:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6596DB81C5C;
        Tue, 18 Oct 2022 03:06:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65FB7C43141;
        Tue, 18 Oct 2022 03:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666062394;
        bh=TgPmSxG73o1j43Hh1nLaVBRIR68zjBpA0IPJMPe2ikI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kB6WuQC9TdG7ex1XbLonRWXCaE548TbuN4P80FnPNRF0nQaKFG/I+sZRPs656ttkU
         rKAN4wdvOAc+cYEiWTP4+K+LRBngCA22vOsLepvigjV9WgIvapzV40y4moYHVwYXcQ
         g2ByC/fM077viJKq1her6JuZirVXEYS8Ex1gzTSUIlPSPFyCZ3DpC/ItJf7tHcgfVk
         Bp1gQZhjCfTHKuip16gzN88/7zZutGTOJ5sjodnPboODsHLGfRg/Uk1Y29DnLWuctz
         KrDL7KDkoklmzw3yYstwvoqrrUHFKq3dywnRkyCPyZIIzkgN2aHX3YOQdh8dpVfp4U
         NRwsqXXu0JQ6Q==
From:   Bjorn Andersson <andersson@kernel.org>
To:     krzysztof.kozlowski@linaro.org, dmitry.torokhov@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org, alim.akhtar@samsung.com,
        k.opasiak@samsung.com, linux-kernel@vger.kernel.org,
        agross@kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: (subset) [PATCH 1/3] arm64: dts: exynos: fix polarity of "enable" line of NFC chip
Date:   Mon, 17 Oct 2022 22:05:15 -0500
Message-Id: <166606235860.3553294.4751927209979123286.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220929011557.4165216-1-dmitry.torokhov@gmail.com>
References: <20220929011557.4165216-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Sep 2022 18:15:55 -0700, Dmitry Torokhov wrote:
> According to s3fwrn5 driver code the "enable" GPIO line is driven "high"
> when chip is not in use (mode is S3FWRN5_MODE_COLD), and is driven "low"
> when chip is in use.
> 
> s3fwrn5_phy_power_ctrl():
> 
> 	...
> 	gpio_set_value(phy->gpio_en, 1);
> 	...
> 	if (mode != S3FWRN5_MODE_COLD) {
> 		msleep(S3FWRN5_EN_WAIT_TIME);
> 		gpio_set_value(phy->gpio_en, 0);
> 		msleep(S3FWRN5_EN_WAIT_TIME);
> 	}
> 
> [...]

Applied, thanks!

[2/3] arm64: dts: qcom: msm8916-samsung-a2015: fix polarity of "enable" line of NFC chip
      commit: 978bc4c578a6d7baffc5646b0f327da036b3051b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
