Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9062644B23
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 19:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiLFST5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 13:19:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiLFSTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 13:19:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877479FF9;
        Tue,  6 Dec 2022 10:19:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23944617F2;
        Tue,  6 Dec 2022 18:19:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E799CC43470;
        Tue,  6 Dec 2022 18:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670350779;
        bh=qy91yRHK7/rNs9k0s4jgURDTbyCEZs1LsZFvSNmtcwQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KgOT0XWcr3Bx+7v4MvRUjOixreAjzyH87RJjf4rC0PgvZpjGhJmPSHIBVXjhbYoFN
         4KUZbeumwqy+SZsskNMYdMfWEY2T2oB42aBBQUkaDGXR7NApPVnZs4w9q97hnZU7q4
         D0mkPZha4RVwErZwOc6PzRR7eEOX6J5aAfAZOcbMBJihNfX8qnrV6PE7lBEQMOwpiS
         rshr1ELgb5q2Pl5pxzeEG5Nv2JzYS642NG3IXfexosC3ShhVjlzbK33CWiOCza4GLY
         SyMHFkw+zNCycjRXS41EdapmX3sbxjOSKd3oE5LkbIRkFHFZbuxGnM7eqvv8EIXuj0
         ww7hH23OlBVRA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, angelogioacchino.delregno@collabora.com
Cc:     kernel@collabora.com, keescook@chromium.org,
        linux-iio@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jassisinghbrar@gmail.com,
        jic23@kernel.org, devicetree@vger.kernel.org, luca@z3ntu.xyz,
        gregkh@linuxfoundation.org, a39.skl@gmail.com,
        marijn.suijten@somainline.org, gpiccoli@igalia.com,
        srinivas.kandagatla@linaro.org, evgreen@chromium.org,
        konrad.dybcio@linaro.org, lars@metafoo.de,
        Tony Luck <tony.luck@intel.com>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: (subset) [PATCH v2 00/11] MSM8956/76 and Sony Xperia X / X Compact support
Date:   Tue,  6 Dec 2022 12:18:45 -0600
Message-Id: <167035076330.3155086.18379797801018993736.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221111120156.48040-1-angelogioacchino.delregno@collabora.com>
References: <20221111120156.48040-1-angelogioacchino.delregno@collabora.com>
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

On Fri, 11 Nov 2022 13:01:45 +0100, AngeloGioacchino Del Regno wrote:
> This series adds basic support for MSM8976 and its lower spec variant
> MSM8956, along with two devices: the Sony Xperia X and X Compact.
> 
> For now, even though I do have a tree in which these two devices are
> fully booting, only a basic console boot is provided as the rest is
> awaiting cleanup and some more dependencies.
> Especially every device requiring IOMMU support, like MDSS, MDP and
> Adreno GPU cannot work with the current qcom_iommu driver, as it
> needs some code to get the ASIDs right for MSM8956/76.
> 
> [...]

Applied, thanks!

[09/11] arm64: dts: qcom: Add configuration for PM8950 peripheral
        commit: e07f41b0e1db8244867ff363f1d1eceefe8d6ad2
[10/11] arm64: dts: qcom: Add DTS for MSM8976 and MSM8956 SoCs
        commit: 0484d3ce090252048daaeb6c7df982b0c7400830
[11/11] arm64: dts: qcom: Add support for SONY Xperia X/X Compact
        commit: ff7f6d34ca07f76f430e8c2cac80495076895a99

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
