Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3965E672F23
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 03:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjASCm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 21:42:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjASCm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 21:42:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF5C3C2E;
        Wed, 18 Jan 2023 18:42:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DB893B81FBF;
        Thu, 19 Jan 2023 02:42:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3523C433D2;
        Thu, 19 Jan 2023 02:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674096174;
        bh=i3sWWhoC0g9ZVavGgCh88OUpF8rPvHup1Nkg1c+o8Z4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H+/bkAkcsTNo4xvSfPQX1FKWEGaHt2gswxJVZlZEo1Qjy/0PVJ4baIrwId8vrK0H2
         fy2adkmQu7+VHanB8uK+1IAszXShB3+oAC49Wa2jFXKu9k3tu8BXo6otN3zgLaqVDv
         6kXWN7IAdkoCZsOFmC0f8Wcf+Xf7FXR+HWrOwDCI92JESEVC49Ic+EQTzn1+FSSKdu
         o8SbKa5g0b2HyVgLD2FmkVFvUtmP4VqMb8HlvjimWQoyrGAOVEZuDev6McUZyxvKc7
         T/9APPGsYdb8TGN508GC2vvSfWAWu352y7RfLhNe+7xIzorHZKKxFlJ1krAAYCgREG
         Tpi4dVCqKyaQA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     robh+dt@kernel.org, agross@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, abel.vesa@linaro.org,
        konrad.dybcio@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/2] arm64: dts: qcom: sm8550: Add USB HC and PHY support
Date:   Wed, 18 Jan 2023 20:42:49 -0600
Message-Id: <167409616953.3024582.9700819381720035018.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230119004533.1869870-1-abel.vesa@linaro.org>
References: <20230119004533.1869870-1-abel.vesa@linaro.org>
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

On Thu, 19 Jan 2023 02:45:31 +0200, Abel Vesa wrote:
> This patchset adds USB controller and PHYs support to SM8550 platform
> and enables them on the MTP board.
> 
> The v1 was here:
> https://lore.kernel.org/all/20221116132212.2842655-1-abel.vesa@linaro.org/
> 
> Changes since v1:
>  * fixed the clocks and clock-names of qmpphy to be aligned with sc8280xp
>  * dropped the child node from the phy nodes, like Johan suggested,
>    and updated to use the sc8280xp binding scheme
>  * moved status property last everywhere needed
>  * dropped the newline for phy-names, like Konrad suggested
>  * decided to move #address-cells, #size-cells and ranges properties
>    in such a way to be aligned with sc8280xp
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: qcom: sm8550: Add USB PHYs and controller nodes
      commit: 7f7e5c1b037fc38dfc4f9530fcdb6fa8bd9fd01c
[2/2] arm64: dts: qcom: sm8550-mtp: Add USB PHYs and HC nodes
      commit: 772e6bc4a0a9c426385115d720743bae7804d499

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
