Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7F7672BB5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 23:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjARWui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 17:50:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjARWue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 17:50:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C9C4A1DD;
        Wed, 18 Jan 2023 14:50:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56188618B4;
        Wed, 18 Jan 2023 22:50:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7FF0C433F1;
        Wed, 18 Jan 2023 22:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674082232;
        bh=kXu5AUDMM/M8mYcvNkTdBUI6QwMPJkNFlP2A/gNNVIc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ffn/6PIIKnITlhRHTxRRxgTEYNaDFrk2GsMOGShSfDhYOvl1MWgngirTIH/kuDF+6
         V6y3wrH4RYHi8X+1qbKce6o7NRIK/DeqGnRzpSIFtDPoKq8/sAAOL52INXYogsJRGl
         ZQQCL8mdQIfUDq1yk+tJm5/YhQbUdPSuJEUZvbims5PdD1fB4y42PIuCEg+BcPDA8q
         Kf4RX2pQxqIxJv124lvuQaoS6jEOk+5tsn/HFZoQMWk1K6fNR902XFknvmVT/2mUuK
         uVk3aeB6yHFFUyXvTRrBqnQ0lAiF1htILwuNhaiLQUxqPBXcHeaN7lq5NeQSxcXzZ3
         F+a8mv7Kp7HyA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     ecs.beijing2022@gmail.com, LKML <linux-kernel@vger.kernel.org>
Cc:     konrad.dybcio@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, kuabhs@chromium.org,
        dianders@chromium.org, linux-arm-msm@vger.kernel.org,
        henrysun@google.com, krzysztof.kozlowski+dt@linaro.org,
        agross@kernel.org, moragues@chromium.org
Subject: Re: [PATCH] arm64: dts: qcom: sc7180: set ath10k output power calibration string
Date:   Wed, 18 Jan 2023 16:50:22 -0600
Message-Id: <167408222411.2952004.5006897725946629011.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230117085212.1.If242b1cd61b2e87e312dd9cf81e20301bae2a5a4@changeid>
References: <20230117085212.1.If242b1cd61b2e87e312dd9cf81e20301bae2a5a4@changeid>
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

On Tue, 17 Jan 2023 08:56:25 +0000, Yunlong Jia wrote:
> Add the string to load RF output power table for pazquel360 project.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sc7180: set ath10k output power calibration string
      commit: c326e851eed4e3ab1cc18deffb6505ce34560ba5

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
