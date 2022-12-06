Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD6E644B96
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 19:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbiLFSWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 13:22:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiLFSWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 13:22:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73124045D;
        Tue,  6 Dec 2022 10:20:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 83A08B81B29;
        Tue,  6 Dec 2022 18:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46291C4347C;
        Tue,  6 Dec 2022 18:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670350823;
        bh=7AtyVmJtwm6sRx65eBQipuupLkeE0S0o2iIUy5Nxzxo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jYIf8jGnJ1nw/OjIMW87RMGSlCQXBpLBS4n+mLoZhXfLLGNrYh35lsiI1POBSwOSt
         i1cFZJOrdm8b2jhLGca6JC+i5J59clKBS1l06EFy7L+kkaUOqMJmRNGAL/X9/JDFFQ
         pLH4o2sZ4BT8SaxW5r2c/H/Rg9043dMoRZurO95HhRAAWsmCQ6L2D+6efMIMvuq7QR
         oSW3+sj7x57hy2M2E6tw6YHnc71C8nAvasy+R+vQRLtCAm4bPgZh6UEdB6YizDEvXN
         rkGl1gLMq2m0L2ksTFLvFrJCAekhbYtbyTfIJmeMvMMjQN1j0nts6pekgvn1eNziGV
         6/R9t1BzmokSg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     quic_bjorande@quicinc.com, robh+dt@kernel.org,
        konrad.dybcio@somainline.org, djakov@kernel.org,
        quic_sibis@quicinc.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     quic_mdtipton@quicinc.com, johan+linaro@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: (subset) [PATCH v2 00/10] interconnect: osm-l3: SC8280XP L3 and DDR scaling
Date:   Tue,  6 Dec 2022 12:19:28 -0600
Message-Id: <167035076327.3155086.15713491718295088609.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221111032515.3460-1-quic_bjorande@quicinc.com>
References: <20221111032515.3460-1-quic_bjorande@quicinc.com>
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

On Thu, 10 Nov 2022 19:25:05 -0800, Bjorn Andersson wrote:
> The SC8280XP currently shows depressing results in memory benchmarks.
> Fix this by introducing support for the platform in the OSM (and EPSS)
> L3 driver and support for the platform in the bwmon binding.
> 
> Then add the necessary nodes and values throughout the sc8280xp and
> sa8540p dtsi files to make the various devices on these platforms scale
> both L3, memory bus and DDR.
> 
> [...]

Applied, thanks!

[06/10] arm64: dts: qcom: Align with generic osm-l3/epss-l3
        commit: a0289a1040a557428a65d099dfdebe80f1a0d0eb
[07/10] arm64: dts: qcom: sc8280xp: Add epss_l3 node
        commit: e4f68d6c32aec8f3c7cdb07d18278e9a068a7eb0
[08/10] arm64: dts: qcom: sc8280xp: Set up L3 scaling
        commit: 33ba07ffd30a1da6f10995ef0a6ec51e17c84f31
[10/10] arm64: dts: qcom: sc8280xp: Add bwmon instances
        commit: 64ebe7fc473fb3a7d67b73a2faa0a10cb322cdce

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
