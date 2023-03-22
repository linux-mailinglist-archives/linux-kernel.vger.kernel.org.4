Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CED76C4E3D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbjCVOoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbjCVOnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:43:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938516133A;
        Wed, 22 Mar 2023 07:42:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DF566215F;
        Wed, 22 Mar 2023 14:42:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FFA4C433B3;
        Wed, 22 Mar 2023 14:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679496142;
        bh=52RarzgVET2Bv4G6bqD9HuDEi4TB9QAb2IdiPKsH8tc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=INNjlL6GXmwc1jvAeNK9LlJVhn1WRDRGpLGKf3yL2RU6nDoHtCOLVTV+gS3pGjt7o
         6MF4y6f9jxTa71Qy9hH4MSNXe8T+feiNrTKNukjSfd7/BblkV+XiAir5YvBE7JBVq6
         qdeKXZ6jCzx2etW1C0P5xWJQO1J1tQFYuoUASRjBPUJxqKQXqcdOeH7A7N9ahy+G51
         nq+ue534ckZ7qykQdhCHMCtVGj1VyphP5ey3fUOf+og8swsbMpuZSkpkJfwX1dV7/r
         37vqpsK/i7wd/51IEkM3PGIy9AoKciR1hLCDttWaStbbt1Llq0HfJ/TBYMIfBwpBS3
         4m6Wxh4YJ4c6A==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: (subset) [PATCH 1/2] arm64: dts: qcom: sm8450-hdk: use precise WCD9385 compatible
Date:   Wed, 22 Mar 2023 07:45:14 -0700
Message-Id: <167949631653.1081726.4627560327365298976.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230308183317.559253-1-krzysztof.kozlowski@linaro.org>
References: <20230308183317.559253-1-krzysztof.kozlowski@linaro.org>
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

On Wed, 8 Mar 2023 19:33:16 +0100, Krzysztof Kozlowski wrote:
> The HDK8450 uses WCD9385 audio codec, so use precise compatible, even
> though WCD9380 and WCD9385 are both compatible.
> 
> 

Applied, thanks!

[1/2] arm64: dts: qcom: sm8450-hdk: use precise WCD9385 compatible
      commit: f0d0966f87f9c38b74619bf7f0345f368af3a4c1
[2/2] arm64: dts: qcom: sm8450-hdk: align WCD9385 reset pin with downstream config
      commit: 6b2777fff8a9942cdcee82ae3f17d7f483a1e18c

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
