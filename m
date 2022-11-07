Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D37061E916
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 04:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbiKGDNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 22:13:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbiKGDM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 22:12:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A0BDF8B;
        Sun,  6 Nov 2022 19:12:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 203C5B80D8E;
        Mon,  7 Nov 2022 03:12:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05279C433B5;
        Mon,  7 Nov 2022 03:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667790769;
        bh=2z0Swf5gWoaqNl0BXqBEmu6CuAxocfOtJzK3VCpU6a0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QgZehyyV7k4ECrMlxKtMysvqJx5DQhepRTZDrA9szsDo2zikL/r1WfHPAs1xUlBVb
         e3J7iH8hcB3ld8p6jLSZ8M+meXp6H/b3pXBNASjAZdnHSyrCmM5VaEpklnsSggNFV8
         21OguizgftkW/hXnTEDYwoqhXYc67O3SOSSpIuaKeTR5kuWfEteHKA0EjoltKjh0Yo
         sHyu5ay7TM6YLCRSFLY7u5966C12TheMLAIaAzAgJQHxF6pudCu1IAKG7o9vniRFoB
         coJQ7BRk3DPQyWmDGOf9ueJu8uCxh7iJFFGRU2fAE9szKp6F3L2S/hSVK+IjGB50Hz
         5SdqPX9i8gIzw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     johan+linaro@kernel.org
Cc:     dmitry.baryshkov@linaro.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, vkoul@kernel.org,
        konrad.dybcio@somainline.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH 0/4] arm64: dts: qcom: fix UFS PHY registers
Date:   Sun,  6 Nov 2022 21:12:07 -0600
Message-Id: <166779074265.500303.10223051049432517680.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221024091507.20342-1-johan+linaro@kernel.org>
References: <20221024091507.20342-1-johan+linaro@kernel.org>
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

On Mon, 24 Oct 2022 11:15:03 +0200, Johan Hovold wrote:
> When working on the updated QMP binding for SC8280XP, I noticed that the
> UFS PHY register definitions for most platforms are wrong. Apparently
> the register region sizes have just been copied verbatim from the
> original SDM845.
> 
> As Linux maps these regions as full pages this is currently not an issue
> on Linux, but let's update the sizes to match the vendor drivers.
> 
> [...]

Applied, thanks!

[1/4] arm64: dts: qcom: sm8150: fix UFS PHY registers
      commit: 36a31b3a8d9ba1707a23de8d8dc1ceaef4eda695
[2/4] arm64: dts: qcom: sm8250: fix UFS PHY registers
      commit: 7f8b37dd4e7bf50160529530d9789b846153df71
[3/4] arm64: dts: qcom: sm8350: fix UFS PHY registers
      commit: b3c7839b698cc617e97dd2e4f1eeb4adc280fe58
[4/4] arm64: dts: qcom: sm8450: fix UFS PHY registers
      commit: 7af949211a0554bbc06163b081fc2cb516674880

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
