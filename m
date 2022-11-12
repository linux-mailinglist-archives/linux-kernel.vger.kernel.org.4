Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B128B6266C1
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 04:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234643AbiKLDv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 22:51:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbiKLDvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 22:51:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1B7CE32;
        Fri, 11 Nov 2022 19:51:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC5E862182;
        Sat, 12 Nov 2022 03:51:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76578C433D7;
        Sat, 12 Nov 2022 03:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668225113;
        bh=hCrG8ptjKZpzLPPtEVhO1Ste4W0pa3edizyEN70rmlY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BE9M+XC8MietZwra/puZCE9ck+UQNRQ998VUE7HctGKfkmQAZ6cT+ZETnI2hQ9bTR
         C0nKDlTLp0XTEkhtvxB3s9XCRLLIwUgWFMUN64VJMytdws31+4XvJAj2G2hCClu+jn
         WeRveKMHjdj0/JpiGBy1W3KIlgIOQldFM3KQrN9SKoyc8muPGGN6JlhHFtVpuvto2l
         JwZV0mJe9itf4Mb0ijVYNkWxGOTOeDprh3WflJQyZWZJi+YVCcuJ+D7iGxMck8K7q0
         bKWnsYSxFxUneiU+3OFfgG9an/0u1KAJcRDp5FtxpmP8eZp8GS9dWthsa5oP9s7PGL
         2ooMA7D4T96QQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     johan+linaro@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, agross@kernel.org,
        konrad.dybcio@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org
Subject: Re: [PATCH 0/9] arm64: dts: qcom: sc8280xp/sa8540p: add support for PCIe
Date:   Fri, 11 Nov 2022 21:51:46 -0600
Message-Id: <166822510245.978218.2210001441742824269.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221110103558.12690-1-johan+linaro@kernel.org>
References: <20221110103558.12690-1-johan+linaro@kernel.org>
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

On Thu, 10 Nov 2022 11:35:49 +0100, Johan Hovold wrote:
> This series adds support for PCIe to the SC8280XP and SA840P platforms
> and specifically enables the NVMe SSD, modem and WiFi controller on the
> SC8280XP-CRD and Lenovo Thinkpad X13s.
> 
> Note that these patches depend on the PCIe QMP PHY support that was
> merged this morning:
> 
> [...]

Applied, thanks!

[1/9] arm64: dts: qcom: sc8280xp/sa8540p: add PCIe2-4 nodes
      commit: 813e831570017bfbab8ccb898a46349c2df3f0f1
[2/9] arm64: dts: qcom: sa8295p-adp: enable PCIe
      commit: c35d4d7128726e7c8160bedd9ed5b309978bdeb3
[3/9] arm64: dts: qcom: sc8280xp-crd: rename backlight and misc regulators
      commit: 5634c6d9771df48838384b14592a00a1e7da8fdf
[4/9] arm64: dts: qcom: sc8280xp-crd: enable NVMe SSD
      commit: 6a1ec5eca73c0ca8cdefd13426bf812c65a1e510
[5/9] arm64: dts: qcom: sc8280xp-crd: enable SDX55 modem
      commit: 17e2ccaf65d16848b27793853af8f42ae524219f
[6/9] arm64: dts: qcom: sc8280xp-crd: enable WiFi controller
      commit: d907fe5acbf1061f86936485d604c229e68ae312
[7/9] arm64: dts: qcom: sc8280xp-x13s: enable NVMe SSD
      commit: b4bb952e6cfc13f86b4b52c3039b199dd3f16020
[8/9] arm64: dts: qcom: sc8280xp-x13s: enable modem
      commit: 176d54acd5d9c79bb6b51dbe2550a3b0441353bf
[9/9] arm64: dts: qcom: sc8280xp-x13s: enable WiFi controller
      commit: 123b30a75623f7131af0f0fa2bee330be65f1ead

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
