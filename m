Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4C16572B7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 05:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbiL1Ehd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 23:37:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiL1EhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 23:37:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84633DFB3;
        Tue, 27 Dec 2022 20:37:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3DF9DB8109E;
        Wed, 28 Dec 2022 04:37:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DCE0C433D2;
        Wed, 28 Dec 2022 04:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672202222;
        bh=5XBYYsHYl3eDyZaEsm5bCKGC+etenJEap6Jjd1RmMLc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o4njCxglWnv78O63fHTu2AQ6mCx1hP3AcexMfQinrN4zdDFTl2VrCopAisNHZg0L0
         fQF2RPY+CcA++Ha4GF0XQkC06egNdbQ+ASyigaLkIZiMpZiehUDfT2J9wa2VlFojEm
         ZW+HPy8FL1jDSUaND8LJYcd2zGEs03ZYGPmX0kdq/mv40dAXXtIXg9e7iZkUisBZuE
         L0GlTVyk5nQUMgLipvynp34wFD6L6Z4bFBPAl7kkQkHfYm8Jbh2yIxAUnTdDyP1w5v
         4XhwffN14Qbmt08X/Eoc7Mh+tXz/bOaSAghIg83cYlxrtGKvbfIYGGraLa+5hypDjP
         3uPtw9u2AfWIQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     krzysztof.kozlowski@linaro.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, konrad.dybcio@linaro.org
Cc:     konrad.dybcio@somainline.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, patches@linaro.org
Subject: Re: (subset) [PATCH 1/2] arm64: dts: qcom: msm8996-tone: Enable SDHCI1
Date:   Tue, 27 Dec 2022 22:36:36 -0600
Message-Id: <167220221234.833009.4476887785037614924.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221210141000.14344-1-konrad.dybcio@linaro.org>
References: <20221210141000.14344-1-konrad.dybcio@linaro.org>
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

On Sat, 10 Dec 2022 15:09:59 +0100, Konrad Dybcio wrote:
> With the recent patch that allowed us to reset the SDHCI controller from
> Linux, things started working properly. Enable SDHCI1, and by extension
> eMMC. Also, remove the now-useless cmdline SDHCI quirks.
> 
> 

Applied, thanks!

[1/2] arm64: dts: qcom: msm8996-tone: Enable SDHCI1
      commit: b860ba9e42538f2a490925121071c215c23d1863
[2/2] arm64: dts: qcom: msm8996-tone: Move status last
      commit: 6152ab29a39131328a310b578aae693d3ec74a9d

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
