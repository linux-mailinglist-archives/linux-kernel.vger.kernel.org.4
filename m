Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E798672EC1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 03:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjASCRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 21:17:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjASCRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 21:17:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21E14A1D5;
        Wed, 18 Jan 2023 18:17:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 966C461A44;
        Thu, 19 Jan 2023 02:17:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34CADC433EF;
        Thu, 19 Jan 2023 02:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674094620;
        bh=MyknK0zG04Vm1eMpPeIae2VzeSFz5zjtn/5ESP6Vt4I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Td5MfZD5LSsuxcOj7aDEcBE2ow8dsyNxwtUIEmBO7V6cs5vi0VlFr9u2sTTOUlS0z
         T2kE3WzdJMW5BktrzJMSBLmX5B946MeXIIxbuZdvhztD7E0fCqjWnZEpttr2W1x50M
         VbIhcGDCVRpuQK+awIIwOqKZD5dsujZU/AR2YwS23czToP3fzQwGzH+g9x+2yANW5W
         w/xRHt6WogyWTN/chvHyfkdAkoB0WQbSV3SGTaRNd06KR1w2qdxFlh6dp8yrf0kXtx
         6gAV/1LWfdy4P3kwhc9//eczcvswM++uFzPoPN3kPVWXMv+M/s4Nu86swCVW6TYJI6
         thtLMVpHjCGbg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     krzysztof.kozlowski+dt@linaro.org, bmasney@redhat.com
Cc:     konrad.dybcio@linaro.org, ahalaney@redhat.com,
        linux-arm-msm@vger.kernel.org, johan+linaro@kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org, echanude@redhat.co,
        quic_shazhuss@quicinc.com, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v4 00/10] dts: qcom: sc8280xp: add i2c, spi, and rng nodes
Date:   Wed, 18 Jan 2023 20:16:50 -0600
Message-Id: <167409461438.3017003.5293699933825726271.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230103182229.37169-1-bmasney@redhat.com>
References: <20230103182229.37169-1-bmasney@redhat.com>
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

On Tue, 3 Jan 2023 13:22:19 -0500, Brian Masney wrote:
> This patch series adds the i2c and spi nodes that are missing on the
> sc8280xp platform and cleans up the existing nodes. Since I am already
> making changes to sc8280xp.dtsi in this series, I also included a change
> to enable the rng node for this platform as well.
> 
> Note that this series needs to be applied on top of:
> [PATCH v5] arm64: dts: qcom: sa8540p-ride: enable pcie2a node
> https://lore.kernel.org/lkml/20221213095922.11649-1-quic_shazhuss@quicinc.com/
> 
> [...]

Applied, thanks!

[03/10] arm64: dts: qcom: sc8280xp: rename qup2_uart17 to uart17
        commit: 71bc1b42844fc0f596da28441c45ab67c5664fb2
[04/10] arm64: dts: qcom: sc8280xp: rename qup2_i2c5 to i2c21
        commit: 6e1569ddfa64be0a6d6bd16aa85568a6175384a2
[05/10] arm64: dts: qcom: sc8280xp: rename qup0_i2c4 to i2c4
        commit: 31e62e862a1ed8711fc973675c74848595422180
[06/10] arm64: dts: qcom: sc8280xp: add missing i2c nodes
        commit: 645aaf0a3826ba18a6f31993e721189666525cfc
[07/10] arm64: dts: qcom: sc8280xp: add missing spi nodes
        commit: 3d256a90b3bf596d2fe318bba15339aa902d406e
[08/10] arm64: dts: qcom: sa8540p-ride: add i2c nodes
        commit: e073899ec3e14d3a9fe7ac62469c1768f4bb7fe0
[09/10] arm64: dts: qcom: sc8280xp: add aliases for i2c4 and i2c21
        commit: 1db9c1d1273904b13cef0e76690395a416e41dd4
[10/10] arm64: dts: qcom: sc8280xp: add rng device tree node
        commit: fa5573edd01e6dcf5aa2b2298be2a35d04917148

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
