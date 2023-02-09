Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12CB368FEB2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 05:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjBIE04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 23:26:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjBIE0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 23:26:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1B538E91;
        Wed,  8 Feb 2023 20:26:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A72A76189F;
        Thu,  9 Feb 2023 04:21:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4513CC433D2;
        Thu,  9 Feb 2023 04:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675916517;
        bh=fSjxvm7KOumtlGtIbxqhGYjsdgDcZa3mrpi9bzrx2Vo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=n+DowkqtYmBZNaS8jAxma9+aXG3K08okTLFICYdT205BD3l+ifj52/RkuarZOzW2L
         30YBuUye8DS0IB9nD8oH96shKSoBb0Lb9DR/nSQaPPxGPCphbtyO8s7IhcRwNAOmZ1
         zi0KA59cjTFxxqwODHv5AltMPwnVNmnB+pves4yg2pEDSyFMpTsJ+QvjIFvio7w3Vn
         XGXvMVvQPJAQawcoTi2ouphd+QlTofKomChza5PN7S/DvaN8StUp33LvlNbMbqL7cf
         KzfEqsjyLNcVZbNDmQoFVaKtmrfnAMSsil8b2fJjyVV2BOQbqs1774M9w2QJQHt4RH
         OrEiRrCDZiVng==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        devicetree@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: (subset) [PATCH v3 1/4] arm64: dts: qcom: use generic node name for Bluetooth
Date:   Wed,  8 Feb 2023 20:23:13 -0800
Message-Id: <167591660367.1230100.913839288470109488.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230124084951.38195-1-krzysztof.kozlowski@linaro.org>
References: <20230124084951.38195-1-krzysztof.kozlowski@linaro.org>
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

On Tue, 24 Jan 2023 09:49:48 +0100, Krzysztof Kozlowski wrote:
> Node names should be generic (as Devicetree spec mandates), so use
> "bluetooth" for BT node.
> 
> 

Applied, thanks!

[1/4] arm64: dts: qcom: use generic node name for Bluetooth
      commit: f7aaaf3030d8c9873b2bb3abbe506fa4da8936cf
[2/4] arm64: dts: qcom: sm8350: drop incorrect cells from serial
      commit: 6027331e6eae9eb957d1b73a7e3255f4151d6163
[3/4] arm64: dts: qcom: sm8450: drop incorrect cells from serial
      commit: 60d2da2c916956535cf37b7bf1ae8fefbf432e55
[4/4] arm64: dts: qcom: sm8550: drop incorrect cells from serial
      commit: fa3ba1c6a0be9f1924daa312271245cafd3f4305

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
