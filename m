Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2FD72F09C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 01:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbjFMXs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 19:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbjFMXrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 19:47:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA3E1FCC;
        Tue, 13 Jun 2023 16:46:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2AD562EFB;
        Tue, 13 Jun 2023 23:45:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A8BBC433C0;
        Tue, 13 Jun 2023 23:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686699957;
        bh=NrWj9gZ2gbwJ5pPQEbe9lIB7b8ufPYhe6LdOBJbNLu8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kH4n03054FL6IPX7m3CJmQMg5PcKwAxboF9gXdeXoJtf/Mbg8D8//JE/aH8ENxdeo
         DtECeGHJbTBvo2jlkvD0QD6gNYp5/rEY9emu59hIseGXSzj6whQga55+Eqqxd5FHuU
         WhpHZzHck5VLAZtmF/7nvxEkHN7161CtF6G0Jrv2abCh0QAJzKTYKoTx6Sne/ohugf
         4PrvdXyP1mXcJDfvqMktkaPwLBi2YxHzLFDJPWgTIckhYKx0U9JnlV89xaRuSL4EOl
         GRfVrXpGB19STGBYfOTsChXcEjelmoPGCE9sWygjNY4uGA6KZoZa10dCzVV1gypfcs
         r5bOHDUgTMFiA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH 0/6] arm64: dts: qcom: msm8916/39: pinctrl cleanup and fixes
Date:   Tue, 13 Jun 2023 16:48:59 -0700
Message-Id: <168670013503.1400697.7956472277450926434.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230529-msm8916-pinctrl-v1-0-11f540b51c93@gerhold.net>
References: <20230529-msm8916-pinctrl-v1-0-11f540b51c93@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 May 2023 09:15:21 +0200, Stephan Gerhold wrote:
> MSM8916 and MSM8939 are very similar and almost fully "pin-compatible",
> so there are some devices that exist in very similar variants with both
> MSM8916 and MSM8939. To allow sharing definitions for such devices the
> SoCs should be set up as similar as possible, e.g. using the same
> labels. At least for me this will also simplify maintenance and review
> because board DTs do not behave and/or look subtly different.
> 
> [...]

Applied, thanks!

[1/6] arm64: dts: qcom: msm8916/39: Fix SD card detect pinctrl
      commit: dfbda20dabaa1f284abd550035db5887384c8e4c
[2/6] arm64: dts: qcom: msm8916/39: Consolidate SDC pinctrl
      commit: c943e4c58b2ffb0dcd497f8b12f284f5e8fc477e
[3/6] arm64: dts: qcom: apq8016-sbc: Drop unneeded MCLK pinctrl
      commit: 6528e4a90b5105643fe4e748ae90e37dcb3a3502
[4/6] arm64: dts: qcom: msm8916/39: Cleanup audio pinctrl
      commit: 0d3a93b102829b22d104c4108ffc9d50f19a556d
[5/6] arm64: dts: qcom: msm8916/39: Rename wcnss pinctrl
      commit: b40de51e3b6737a7bd41045e0cd3f78b75c35b24
[6/6] arm64: dts: qcom: msm8916: Drop msm8916-pins.dtsi
      commit: 8734d3355079152dc3fdf628a3724f55603c796d

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
