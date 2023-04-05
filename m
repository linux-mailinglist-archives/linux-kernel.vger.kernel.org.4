Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F42C6D730A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 06:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236842AbjDEEGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 00:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236798AbjDEEGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 00:06:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856DF46B4;
        Tue,  4 Apr 2023 21:06:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C564B63AF7;
        Wed,  5 Apr 2023 04:06:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D27C433D2;
        Wed,  5 Apr 2023 04:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680667585;
        bh=bo8udfK3oCf5bsNbwF7O3B7B5LY9dZv533Pc02TKyEw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pugRBGubmsg7RdXBuIgPpsakZ+ZVySiPUmHdSCojkqXOeS/xgBNs/P7z3Y9wTH4vR
         gGJgIr4Qm36M4eOMP+eDadokHxcJuNqWti7ThVcG2asYYnY5ue+Tj5zEQNH0Q5Lfqt
         EEK6lP6OJRNfds9mxguJbjyKjHxKk7cTxdgd3CmOUOi2NtDnB0y/pAd7B9O8k+xIwJ
         VCe7X3CVA2yGNFhpk2Mt3Iz/Rh0guSN2X9BojYD7Qnq7OBbATJRlEe5ms2m8Lj7nEN
         YfXJ7sn17HdDtkz6T490s+jaIFwwxj/X/UhfzcEgEq4yJC228zG+8N8nnQpi937ZPy
         ve0G4629YXaEg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: (subset) [PATCH v2 00/14] SM6375 feature enablement (round one)
Date:   Tue,  4 Apr 2023 21:08:56 -0700
Message-Id: <168066774415.443656.6342944459205331077.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230303-topic-sm6375_features0_dts-v2-0-708b8191f7eb@linaro.org>
References: <20230303-topic-sm6375_features0_dts-v2-0-708b8191f7eb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Mar 2023 15:12:49 +0100, Konrad Dybcio wrote:
> v1 -> v2:
> - Reword CPUCP L3 commits to indicate that CPUCP != the L3 scaler within
> - Pick up tags
> - Drop the MPM introduction as we work on resolving RPM MSG RAM bindings
> 
> v1: https://lore.kernel.org/r/20230303-topic-sm6375_features0_dts-v1-0-8c8d94fba6f0@linaro.org
> 
> [...]

Applied, thanks!

[04/14] arm64: dts: qcom: sm6375: Add RPM sleep stats
        commit: 2cecb9c2419f78e939e6e902895591ce3e3a7cc7
[05/14] arm64: dts: qcom: sm6375: Add IMEM
        commit: 528630df2fa6d34eca0268a293fe354c71e48556
[06/14] arm64: dts: qcom: sm6375: Add RMTFS
        (no commit info)
[07/14] arm64: dts: qcom: sm6375: Add wifi node
        commit: 149d179d1408bc67b6af10af160ac13b48fa3399
[08/14] arm64: dts: qcom: sm6375: Add modem nodes
        commit: 31cc61104f6894f686491dbbb5c8ece97b06e75d
[09/14] arm64: dts: qcom: sm6375: Add CPUCP L3 node
        commit: 2f51d9231485250c0e4cf4d7326c30109c553382
[10/14] arm64: dts: qcom: sm6375: Add TSENS
        commit: 3f54391526b407a419d2dfd4055fdc9e6e223551
[11/14] arm64: dts: qcom: sm6375: Configure TSENS thermal zones
        commit: 33555cdae863984c7840ba742cfffe839a0f71e4
[12/14] arm64: dts: qcom: sm6375: Bump CPU rail power collapse index
        commit: 097d6525af378f4be768c05cc1d77183a4e742e3
[13/14] arm64: dts: qcom: sm6375: Introduce C3 power state for both ARM clusters
        commit: dbe38b9cba6d0de56ca186151f3f54f9c776f9d9
[14/14] arm64: dts: qcom: sm6375-pdx225: Add volume down GPIO key
        commit: 795ee50e55f4e869ad1d56f0262d0baa401f6c3d

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
