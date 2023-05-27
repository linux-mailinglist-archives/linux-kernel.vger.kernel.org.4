Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217DA713146
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 03:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244099AbjE0BEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 21:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243223AbjE0BEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 21:04:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627F3E4E;
        Fri, 26 May 2023 18:03:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 416CC654C3;
        Sat, 27 May 2023 01:03:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 847EBC433AA;
        Sat, 27 May 2023 01:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685149438;
        bh=yOxFoBLmp1jeScMv79meMtTIDUcnUXDUr4oCfNwQ2AM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=etGs4LLK1h56gzqxJZ4WvvhIlyJFrF8n0D2EVtUJ/+gADZpYRlpmfOAKdCye96MFw
         BlT9l+TCfks1y1evKD2QOAM5/B9EVgCBtzQ3jgBictWvKLB8VkyArQ4oWwTstBfA1W
         bQHSzazdWTOhECQJCMBAeF19eo0uTbFexCV8E/6zMB4b6nWqPhG7JljzBqXGRlq1xe
         xAcO55+mPcSwJ1tAz8jRp6sAibXG1f31kad9r1RMOnxLxHcl4KhNqJ5OUAIbJ0zn9R
         b6An0+VPFbBPFenq9uyoKWUoDqhWqn9FXTDqIYx8jdouzN6vwCfyDdIEvAdAHDw01C
         vwIcE4rSp1sZw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     cros-qcom-dts-watchers@chromium.org, agross@kernel.org,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@linaro.org, broonie@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-spi@vger.kernel.org
Cc:     mka@chromium.org, quic_vtanuku@quicinc.com,
        quic_msavaliy@quicinc.com, dianders@chromium.org,
        swboyd@chromium.org
Subject: Re: (subset) [PATCH v5 0/5] spi: Add DMA mode support to spi-qcom-qspi
Date:   Fri, 26 May 2023 18:07:33 -0700
Message-Id: <168514964951.348612.11351632756145429472.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <1682328761-17517-1-git-send-email-quic_vnivarth@quicinc.com>
References: <1682328761-17517-1-git-send-email-quic_vnivarth@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Apr 2023 15:02:36 +0530, Vijaya Krishna Nivarthi wrote:
> There are large number of QSPI irqs that fire during boot/init and later
> on every suspend/resume.
> This could be made faster by doing DMA instead of PIO.
> Below is comparison for number of interrupts raised in 2 scenarios...
> Boot up and stabilise
> Suspend/Resume
> 
> [...]

Applied, thanks!

[2/5] arm64: dts: qcom: sc7180: Add stream-id of qspi to iommus
      commit: 8164116023acb6dd600776a3391d5b0cd7699adc
[3/5] arm64: dts: qcom: sc7280: Add stream-id of qspi to iommus
      commit: cc406006126e89c5330ff5c75da20deb5cafedf8
[4/5] arm64: dts: qcom: sdm845: Add stream-id of qspi to iommus
      commit: 0aa2811cf5eb2355cd91035b4a76a6120a5c6382

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
