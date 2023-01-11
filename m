Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDEC466538E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 06:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbjAKFUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 00:20:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbjAKFSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 00:18:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A43813E2C;
        Tue, 10 Jan 2023 21:10:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D79B561A34;
        Wed, 11 Jan 2023 05:10:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B770C433F2;
        Wed, 11 Jan 2023 05:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673413800;
        bh=vj8NeQWO26h/43dw4uv0BM78Kwwf88YiNDQGsMktjtc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wf+iuPIZnsiXo7wAg6+QsgwYwMcSLOyCUc5L1FB0p8QR5wx5lJrHIrUO0KREDVsZf
         jpGTbC3IFcJC09TBoWRwiS6bjpKHSD0YANUxoL+kx2TYpTbQjJWTHoI9n47hjyoiqu
         ozW9kunl5srsQY03bTlzCAroR2b8bKE5YU7gT7DWmIPvbQssbO0kRQ6ituSgXFZ2vv
         BDshsIn0irastfikfV1mPwB/XUh8roaayu21g8c0EA3XXcgdHuTwHFr033l4SuVBfP
         AkJb4EjPH0lHtyqCXSh9htR71igD956qfmT5NAGq8BYRHCbHwbJoUR7e+Sdiq6bCI9
         NKVqaIKub/yzQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        wim@linux-watchdog.org, konrad.dybcio@linaro.org,
        linux@roeck-us.net, agross@kernel.org,
        saiprakash.ranjan@codeaurora.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH 01/12] dt-bindings: watchdog: qcom-wdt: require fallback for IPQ4019
Date:   Tue, 10 Jan 2023 23:09:25 -0600
Message-Id: <167341377721.2246479.13455570899363041787.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221212163532.142533-1-krzysztof.kozlowski@linaro.org>
References: <20221212163532.142533-1-krzysztof.kozlowski@linaro.org>
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

On Mon, 12 Dec 2022 17:35:21 +0100, Krzysztof Kozlowski wrote:
> The device specific compatibles ("qcom,kpss-wdt-ipq4019") should be
> follwed by fallback "qcom,kpss-wdt", which is actually used by Linux
> driver for binding.
> 
> 

Applied, thanks!

[07/12] ARM: dts: qcom: reverse compatibles to match bindings
        commit: 25da76a92f88b57331946e98f659b2626d512ea2
[08/12] ARM: dts: qcom: apq8064: drop second clock frequency from timer
        commit: 462671ab0472175b52a45b91abf140df3ecf7326
[09/12] ARM: dts: qcom: ipq8064: drop second clock frequency from timer
        commit: aa482e69cd3b3513d952eab71858534315b535bf
[10/12] ARM: dts: qcom: mdm9615: drop second clock frequency from timer
        commit: 501d1437d57604659a02378d712a8fc347f8ed84
[11/12] ARM: dts: qcom: msm8960: drop second clock frequency from timer
        commit: f630f8205c37579092b37cf216428a43a73e35b8
[12/12] ARM: dts: qcom: msm8960: add qcom,kpss-wdt-mdm9615
        commit: af657876c67062a07650cacf5f0b2c754d9f14d6

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
