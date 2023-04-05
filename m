Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 374BC6D7311
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 06:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236915AbjDEEHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 00:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236832AbjDEEGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 00:06:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF603A9C;
        Tue,  4 Apr 2023 21:06:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 952A863AFD;
        Wed,  5 Apr 2023 04:06:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AD18C4339E;
        Wed,  5 Apr 2023 04:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680667587;
        bh=ttpEWdZSAWEyCGJLAKskUbf3iSUwFA9qdZSzeKXVsNo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jM6BAVfGVzQVtiySDY04dOVh5Hvu/uJdWh/g6cc0h6Y43AmkhwSztCY+YEobGWQY9
         T8VrOwbYCBGBTwp9OfoUIUCt4fXAmj+lHffICfvb7WludUCGlh/WxD/IOaq/BCLRKA
         sVjOPVexBS0TdND56NjAPM/rvDmfswSfpWGJxV129ZFaPzOJ63JqtjFfk4bD5q8ADy
         JIGHtBlSip1XUiORiMLMCi8EwsADpsTaEXSsFAAtwcJPvRjebNFLqMszhNbytyI3T7
         djLOCnHuWe17JZcUZOFdrbk39qOB9kPkrFMW7t9dZGDANaT5y2dcC6cwjLucqcnz6R
         Uo7EfXWW3yiQQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/6] Sony SDM845 panel and remoteproc enablement
Date:   Tue,  4 Apr 2023 21:08:58 -0700
Message-Id: <168066774419.443656.11153531857834240493.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313-topic-tama_disp-v3-0-2b1567c039d7@linaro.org>
References: <20230313-topic-tama_disp-v3-0-2b1567c039d7@linaro.org>
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

On Wed, 29 Mar 2023 21:41:17 +0200, Konrad Dybcio wrote:
> v2 -> v3:
> - Fix pinctrl-n / -names ordering [1/6], [2/6]
> - Drop unnecessary #-cells [1/6]
> - Drop GPIO52 (it's apparently some LCD mode, single vs dual port,
>   not sure how real it is considering it came from messy downstream
>   code and not touching it at all does not seem to break anything) [1/6]
> - Use interrupts-extended instead of interrupt-parent+interrupts [2/6]
> 
> [...]

Applied, thanks!

[1/6] arm64: dts: qcom: sdm845-tama: Add display nodes
      commit: 5dcc6587fde26fa03fe6993278d9bd01daed09b1
[2/6] arm64: dts: qcom: sdm845-tama: Add Synaptics Touchscreen
      commit: 3ab8216de2fab6a6efeb5b22d8d61676b67964dc
[3/6] arm64: dts: qcom: sdm845-tama: Add regulator-system-load to l14a/l28a
      commit: 1d99fee382a6ada0cd05ae8afaea2dd1884c58a3
[4/6] arm64: dts: qcom: sdm845-tama: Enable remoteprocs
      commit: 39e0f8076f6fc5022902c62f5046ad91cf2b7a59
[5/6] arm64: dts: qcom: sdm845-tama: Enable GPU
      commit: ff9108ea69adc0b38e5bbc8575434355f0e20579
[6/6] arm64: dts: qcom: sdm845-tama: Enable GPI_DMA0/1
      commit: da51e2ceedc2df7248bad6bec45ae3280de9ada2

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
