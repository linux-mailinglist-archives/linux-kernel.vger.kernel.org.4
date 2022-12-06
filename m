Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C5D644B14
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 19:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiLFSTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 13:19:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiLFSTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 13:19:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43C4B7F9;
        Tue,  6 Dec 2022 10:19:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 408A8616D1;
        Tue,  6 Dec 2022 18:19:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E73F2C433C1;
        Tue,  6 Dec 2022 18:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670350773;
        bh=xE1VX+sqMz9bHvicspUk6EkE1y74gTVG4LROkg8zm9w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ng6OSi5zCpPqkWqfmNA13O+qXH5Rz+qxuydYj/ZlQTa4q6iVMc28bY/RMFHg4rLx/
         c6Fqb4QRovPld4s+48dJ3jZ7JNbza/9WE5WG8n9PNmZB8pvpQeLu1kyKDxYz3gPrpk
         dFUxpSjwM81TgYkwrfOdwvtHLw2bVif2hV+MRnNIlr0wn2HLFJKOCnYH/pL4B3ITnw
         RLc4DQPlVfdSD9YJTXXrnxmAc/3bJ24/mDvbmVbfjE+foZBRKeecjTQVrmlheEWA+k
         rFXRAjhB+/SRj8tg9/eDUfGVy7+bLdVzxVBAdS7kYAXDP46G1iaWuw/xiuK5GeJEea
         SDble89faMZZw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, daniel@ffwll.ch,
        quic_abhinavk@quicinc.com, dri-devel@lists.freedesktop.org,
        thara.gopinath@gmail.com, freedreno@lists.freedesktop.org,
        robdclark@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        loic.poulain@linaro.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com, dmitry.baryshkov@linaro.org,
        konrad.dybcio@linaro.org, daniel.lezcano@linaro.org,
        sean@poorly.run, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        airlied@gmail.com, amitk@kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Gross <agross@kernel.org>
Subject: Re: (subset) [PATCH v2 00/12] SM6115 DTS changes
Date:   Tue,  6 Dec 2022 12:18:39 -0600
Message-Id: <167035076353.3155086.13233208234326908710.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221130200950.144618-1-a39.skl@gmail.com>
References: <20221130200950.144618-1-a39.skl@gmail.com>
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

On Wed, 30 Nov 2022 21:09:38 +0100, Adam Skladowski wrote:
> This patch series adds bunch of new nodes
> also it fixes some small nitpicks in yamls and adds compatible.
> 
> Changes since v1
> ================
> 1. Changed title for mdss yaml patch
> 2. Added missing dmas to spi0
> 3. Wired freq domains to CPUs
> 4. Added R-b/Ack tags
> 5. Reworded smmu dts patch
> 
> [...]

Applied, thanks!

[03/12] arm64: dts: qcom: sm6115: Add cpufreq-hw support
        commit: aff96846c63ed3e3ed7d5212ea636a422d9694a3
[04/12] arm64: dts: qcom: sm6115: Add TSENS node
        commit: 7b74cba6b13f4bbe1f15e3417f386ed1907ab0ef
[05/12] arm64: dts: qcom: sm6115: Add PRNG node
        commit: fc676b15c065b8d4c750bbaab9914f24829a7a13
[06/12] arm64: dts: qcom: sm6115: Add rpm-stats node
        commit: d18c0077963ae2b6d232f6f3f25fb1ceb875ce7f
[07/12] arm64: dts: qcom: sm6115: Add dispcc node
        commit: 884f95411ba4030ca44436217c6d8df4a960c555
[08/12] arm64: dts: qcom: sm6115: Add mdss/dpu node
        commit: 705e50427d8148211ffd05922bfa6a2520781338
[09/12] arm64: dts: qcom: sm6115: Add GPI DMA
        commit: 1586c5793511d7fb389139ab7aa5dae9118666ad
[10/12] arm64: dts: qcom: sm6115: Add i2c/spi nodes
        commit: 323647d32e83fae7f1a81b40e12ca6b0b63e880c
[11/12] arm64: dts: qcom: sm6115: Add WCN node.
        commit: 245bb9a37c16dc324be60764aa2597aa4704a8e3
[12/12] arm64: dts: qcom: sm6115: Add smmu fallback to qcom generic compatible
        commit: 58a9e83605478e931139b574e43d453851de3a26

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
