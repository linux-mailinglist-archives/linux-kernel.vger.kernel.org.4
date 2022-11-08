Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791F86205E6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 02:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbiKHB2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 20:28:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233126AbiKHB1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 20:27:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3832AE0B;
        Mon,  7 Nov 2022 17:27:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D7016137A;
        Tue,  8 Nov 2022 01:27:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4B5AC433C1;
        Tue,  8 Nov 2022 01:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667870872;
        bh=bp0D/V+DZaLHOzxFfU/M/uHm+4rg3Wd26xR7jS9z60Q=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=vOotKZJd63DQxYQ8J3/SMqUdB2mo2ZUNXeXOc/Qt5Q98rLJhTrV0uoBYVzVL/Xh3R
         QHfUru3VzW/eiNJd/EPUU6NpOl+nfm3sOKsa9zkpYmm9ZMXTlUBJupbM9h2TbhoWpD
         3M81MRE3esLGVrjh/GKtP8a+DMQOdJ4V4nehSxIYTJtzaIBun6hM1k6c+of16accM/
         nbmSf3+ykd9nT0i3CVYC5S26yq0KHPtNpg5F7rAYxufHC6kGyqB/uAcnLRcTLtnEYv
         X3M3iAxcOmmE8NQ63iuauqUVW+PjBM6r5IYb+AakByRHyHLSqt/1otpKS/wNW8w4cc
         cRJenOyj+HN1A==
From:   Bjorn Andersson <andersson@kernel.org>
To:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        linus.walleij@linaro.org, konrad.dybcio@somainline.org,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski@linaro.org, linux-arm-msm@vger.kernel.org
Subject: Re: (subset) [PATCH v3 1/3] arm64: dts: qcom: msm8994: Correct SPI10 CS pin
Date:   Mon,  7 Nov 2022 19:27:25 -0600
Message-Id: <166787084677.599230.9490503702651891752.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221018155450.39816-1-krzysztof.kozlowski@linaro.org>
References: <20221018155450.39816-1-krzysztof.kozlowski@linaro.org>
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

On Tue, 18 Oct 2022 11:54:48 -0400, Krzysztof Kozlowski wrote:
> The GPIO55 is part of SPI10 pins, not its chip-select.  Probably the
> intention was to use one of dedicated chip-select GPIOs: 47 or 67.
> GPIO47 is used for UART2, so choose GPIO67.
> 
> 

Applied, thanks!

[1/3] arm64: dts: qcom: msm8994: Correct SPI10 CS pin
      commit: 5d76dfb86850893f2506e15a1dc68977c3adc79f
[2/3] arm64: dts: qcom: msm8994: Align TLMM pin configuration with DT schema
      commit: 9d7d01da9a24a8e37fa156d93dbea893a0665f94

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
