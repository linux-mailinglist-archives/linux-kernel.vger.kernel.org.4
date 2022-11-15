Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 797AE62A0AD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 18:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237857AbiKORqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 12:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232474AbiKORqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 12:46:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13293EBA;
        Tue, 15 Nov 2022 09:46:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F31B61962;
        Tue, 15 Nov 2022 17:46:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A996C433D7;
        Tue, 15 Nov 2022 17:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668534397;
        bh=dMtcSNBQcQgILJj+tM8JSnzQQOykIsWtB7W8E/0ngzc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UHLmcXWf0fMI4SxAtnrNJwi90WLGXDqL4+9u6pMGCHkvwByWaWjeVVMV39yVlRFcu
         U5/6dY1WW9RJc//0UBpRUKaVmJK4sSnTQrwvNO+E1W1LABK63KwcHpRwdkQkk53LHF
         9IgmMH0l8JXl+qbE2GTQUazikVeXOq4OsAX+srLMQY/hBn8aUMNypyK8WEayU7aHxA
         /ltAaOzjSwYqwzc3leA4GyPJXTPWHVzED7FwUFVqW2FXNGvpXvnk++f7uuvEnSQACF
         n/1PMQDCvCOg0xFx301XMA9frfx5Mi+4ZdHl/Qb8xfkp67OQEQ2YnF74hopcQJp+Vy
         JWXJaa/ZU+aKA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-arm-msm@vger.kernel.org, konrad.dybcio@linaro.org,
        krzysztof.kozlowski@linaro.org, agross@kernel.org
Cc:     mturquette@baylibre.com, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        konrad.dybcio@somainline.org, patches@linaro.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org, sboyd@kernel.org
Subject: Re: (subset) [PATCH v2 1/2] dt-bindings: clock: add QCOM SM6375 display clock bindings
Date:   Tue, 15 Nov 2022 11:46:30 -0600
Message-Id: <166853438865.1276519.10413893363571799353.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221115155808.10899-1-konrad.dybcio@linaro.org>
References: <20221115155808.10899-1-konrad.dybcio@linaro.org>
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

On Tue, 15 Nov 2022 16:58:04 +0100, Konrad Dybcio wrote:
> Add device tree bindings for display clock controller for
> Qualcomm Technology Inc's SM6375 SoC.
> 
> 

Applied, thanks!

[1/2] dt-bindings: clock: add QCOM SM6375 display clock bindings
      commit: 9285e61a5670657cb0a0f0f4e5c5a320dd18b471
[2/2] clk: qcom: Add display clock controller driver for SM6375
      commit: aec5f36cf6763a1f246befd9db266d24ba6e8d4b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
