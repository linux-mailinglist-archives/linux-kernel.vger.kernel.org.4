Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD9F658FB6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 18:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbiL2RYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 12:24:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233902AbiL2RYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 12:24:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5E415833;
        Thu, 29 Dec 2022 09:23:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C10A61865;
        Thu, 29 Dec 2022 17:23:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B66A6C43398;
        Thu, 29 Dec 2022 17:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672334636;
        bh=2Nqf+4IqAj+SIvDDlVvK93jJxUIm8K/qw4p4F1uIfcg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pkskW4CMR+ilKM2+U1goMT4NhDQhcSd8IvY4dKFQXVswhJZJrp8gxJqDUDWhSF7Al
         at4cfYLU/yW7zPJQbNatvTYinJN1EJlftP7ViiVgEyUdAxQMKRNlYc4rM6tAEdB+Hi
         /XPg6KO4EKWGG4y/B1NHJ637m/vC2XxPZ5oTZZoN+QVspDLhwkAs5cqdrFiUpVt3SX
         EjJejP2Y7oVu1Yz0LaqJWcnAgHmWAUrIyv9RulAp3yI67LJ5I5IwniwEe5T3/UYNzk
         ii/QhXTdYovqaSvYudJSf9SLkAKMO5MUbqfXoA2oHgJM0xmCXBl83TAIL9xWYFmcze
         /NQwFFDPOIQMg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, phone-devel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, konrad.dybcio@somainline.org,
        jami.kettunen@somainline.org, they@mint.lgbt,
        martin.botka@somainline.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        angelogioacchino.delregno@somainline.org, konrad.dybcio@linaro.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/3] arm64: dts: qcom: sm6125: QUPs, SPI and Seine I2C buses
Date:   Thu, 29 Dec 2022 11:23:35 -0600
Message-Id: <167233461774.1099840.13498656659171883984.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221216233408.1283581-1-marijn.suijten@somainline.org>
References: <20221216233408.1283581-1-marijn.suijten@somainline.org>
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

On Sat, 17 Dec 2022 00:34:05 +0100, Marijn Suijten wrote:
> Introduce Qualcomm Universal Peripheral support on SM6125 and define all
> known SPI and I2C Serial Engines.  On Sony Seine PDX201 all I2C buses
> with known-connected hardware are enabled for future hardware mapping,
> together with the respective GPI DMA 0 and QUP 0.
> 
> Changes since v1:
> - Un-downstream pinctrl mapping:
>   - Remove nested mux {} / config {};
>   - Remove useless comments;
>   - Remove unreferenced pinctrl states;
> - Use qup14 pinctrl function name instead of unknown qup_14;
> - Reword commit message;
> - Add iommus to QUP nodes now that this series depends on apps_smmu to
>   be available;
> - Reorder all properties to match other SoCs;
> - Reorder/intersperse QUP nodes with GPI DMA nodes to maintain sorting
>   by address;
> - Reorder SPI nodes to fit in with I2C nodes, restoring sorting by
>   address too;
> - Use QCOM_GPI_* constants;
> - Adhere to 3 instead of 5 dma cells for gpi_dma.
> 
> [...]

Applied, thanks!

[1/3] arm64: dts: qcom: sm6125: Add pin configs for QUP SPI/I2C Serial Engines
      commit: 075a6aef55919b9ed99cf07fe149aa52f80d9056
[2/3] arm64: dts: qcom: sm6125: Add QUPs with SPI and I2C Serial Engines
      commit: 72621d0443eaf4e70adcbcd801301b9dd6eed431
[3/3] arm64: dts: qcom: sm6125-seine: Enable GPI DMA 0, QUP 0 and I2C SEs
      commit: f3b770f7a8b439136c71c24dbfc408a0086c6326

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
