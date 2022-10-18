Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE94B602209
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbiJRDJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbiJRDIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:08:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E4C9AF9B;
        Mon, 17 Oct 2022 20:07:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BFA38B81BDF;
        Tue, 18 Oct 2022 03:07:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C428CC43141;
        Tue, 18 Oct 2022 03:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666062421;
        bh=NleOGOgHsVzK8x+TdSpwEiqKpO84mXV39srZaXakc70=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=VBZNbrdgqL0JDxPyIyh1UUnMZMNVJIRL7djrIwdgKmeLXYpbOKlGI/FyAm48G+Wqg
         mBa6eKf4fthCbH92QeQzXq85g0ptsitMUCpWIFo9HBqTqp43Ryghp/wpGXgqGukd+9
         63PdR2DHzD6KPNgYiWpnlsfPwbFvzNLMMsEN3NtvAmI4KSTH3e69eXwOVN1n5oHAg9
         ovCGdFBc64Wswqtv2WB6Znbw2d99v9k7WRHjEkazyLgeGZnHupFELWdce95Q/jh17j
         rpS7b5HlytE7RH2mm3hPwFCk7A5ru3OlGU8bqOE7JYvDfTofVtNcaKl+dTWvMkRKmO
         JDP8gr9ls9Gnw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, agross@kernel.org,
        srinivas.kandagatla@linaro.org, krzysztof.kozlowski@linaro.org,
        robh+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: (subset) [PATCH v2 00/11] arm64/slimbus/dt-bindings: convert to DT Schema, minor cleanups
Date:   Mon, 17 Oct 2022 22:05:35 -0500
Message-Id: <166606235859.3553294.11708040908306667736.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220928152027.489543-1-krzysztof.kozlowski@linaro.org>
References: <20220928152027.489543-1-krzysztof.kozlowski@linaro.org>
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

On Wed, 28 Sep 2022 17:20:16 +0200, Krzysztof Kozlowski wrote:
> Changes since v1
> ================
> 1. Fix commit title typo (Steev).
> 2. Add Rb/Tb tags.
> 
> Dependencies
> ============
> No dependencies. Binding patches are independent from DTS.
> 
> [...]

Applied, thanks!

[01/11] arm64: dts: qcom: sdm845: drop unused slimbus properties
        commit: 0a4594886dd904b73541188c875bf378c463cbbc
[02/11] arm64: dts: qcom: msm8996: drop unused slimbus reg-mames
        commit: 9eae83f9ec9cee5cbc615fd6bc4221c7d62c07d5
[03/11] arm64: dts: qcom: sdm845: correct slimbus children unit addresses
        commit: 251ba7ee1674cb7608fa2c5da6c188e976e83481
[04/11] arm64: dts: qcom: mms8996: correct slimbus children unit addresses
        commit: e92a949e436e9956a2f99a07f9f4f640f42d8f99
[05/11] arm64: dts: qcom: sdm845: drop unused slimbus dmas
        commit: 7b027503c3620bcc8f60f3cef30ee3bc7f7aeede
[06/11] arm64: dts: qcom: msm8996: drop unused slimbus dmas
        commit: 3cc63b981bab83e8e439629e94ea96c1b3ae5888
[07/11] arm64: dts: qcom: sdm845: align node names with DT schema
        commit: 880d93355135515d842a41b7ff50f27daaeb3bec
[08/11] arm64: dts: qcom: msm8996: align node names with DT schema
        commit: 6414b1177e2e4f229b7807009f17ccf9491c6a44

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
