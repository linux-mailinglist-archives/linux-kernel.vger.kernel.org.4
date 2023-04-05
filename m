Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576C76D7313
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 06:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236934AbjDEEHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 00:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236845AbjDEEGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 00:06:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE604C10;
        Tue,  4 Apr 2023 21:06:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8896563AFD;
        Wed,  5 Apr 2023 04:06:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47FE8C4339E;
        Wed,  5 Apr 2023 04:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680667589;
        bh=QhIdDT89ax1UnY5W6Qf+ny/NTS63Yd24/qYBLLBuyjQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bicAtf43/HDrL88Ndke6JfgrTJhYvjqh8igiX899XnEqQjjm5YNeShVrXLG9m7GXx
         hDkjzt76uARCEFU+7oHHnxBi+5dDE24SPmIJE/qzHZzRbZyeZhYXbaVXRrrx0GlULd
         EQtutGbWs9GJg8ufg+r2HMAE4g+4H0w+dzP7bHmq647CZA14A3opTICqWmgT4qIMa1
         UbnK5Qh8fZANRy1M0BRaD55fDf8hI2p7zcrs+WpVnKCE5fvJNVssMScqOj1U4box12
         sy1qunxoagth2p1uvBZliEzbNKYDuh8xSB+Bw8oUuqMNQHo83xAKizLWbotE4JeYWI
         PPqWVtYiR2Nrg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: (subset) [PATCH 1/6] arm64: dts: qcom: sm8250: drop incorrect domain idle states properties
Date:   Tue,  4 Apr 2023 21:09:00 -0700
Message-Id: <168066774415.443656.12922895750189505580.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230324073813.22158-1-krzysztof.kozlowski@linaro.org>
References: <20230324073813.22158-1-krzysztof.kozlowski@linaro.org>
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

On Fri, 24 Mar 2023 08:38:08 +0100, Krzysztof Kozlowski wrote:
> Domain idle states do not use 'idle-state-name' and 'local-timer-stop':
> 
>   sm8250-hdk.dtb: domain-idle-states: cluster-sleep-0: 'idle-state-name', 'local-timer-stop' do not match any of the regexes: 'pinctrl-[0-9]+'
> 
> 

Applied, thanks!

[1/6] arm64: dts: qcom: sm8250: drop incorrect domain idle states properties
      commit: dffc4b5c086cf1d3dae4761427122a56b9d1253a
[2/6] arm64: dts: qcom: sdm845: drop incorrect domain idle states properties
      commit: 1766e9155d086cd238c24113a7be9740d35c2ebe
[3/6] arm64: dts: qcom: sm6375: drop incorrect domain idle states properties
      commit: ac7944f01b771af7718a81793ca5b38b0e3a0c21
[4/6] arm64: dts: qcom: sm8150: drop incorrect domain idle states properties
      commit: 770f85c19536fde3591f4f2f70ac32f33d86b975
[5/6] arm64: dts: qcom: sm8350: drop incorrect domain idle states properties
      commit: 7983224c6a6cea77aa0b9b4e23bb7651241df961
[6/6] arm64: dts: qcom: sc8280xp: drop incorrect domain idle states properties
      commit: ea1811e2614cd66608961ae3c5a9ee6038fc424b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
