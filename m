Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0DFF62A0A2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 18:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbiKORqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 12:46:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbiKORqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 12:46:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFB3F65;
        Tue, 15 Nov 2022 09:46:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 754F061962;
        Tue, 15 Nov 2022 17:46:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1582BC433B5;
        Tue, 15 Nov 2022 17:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668534394;
        bh=cCKhq94wqUbYlRYZkl82GS30wASMwI6uI2P0yK1BsEw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j4b1dKd080mlExiGRGsIo/eYcuHfX6S6LnouseSFt0QnFyabwAiTo+SLw/I7JzaOi
         2+nQU1w+CZOiLe0u1ap9xxVHbdboXakTLztVj4oik9MUKG7sofu/nwvfGUzGGWA1BT
         F/I1hGUzBek4ZtG/044IvysqER2wEs7IbhBOyUJY00MqJietD8kqMFg9MXt2H/Hnl8
         UnB2RiMNOrtOrRe6BN/ofrDvgBXz17dmAq6jfGj8TNLh69bGuuqqik18FfE01y/iaV
         3r34vZfejgyQPFg3f33aICI+Y6mm/+hMMOFsOkRXkO2ujaZZOGmAxRgYWL2Ht3dXlm
         XdO8f5wv76hbA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-arm-msm@vger.kernel.org, konrad.dybcio@linaro.org,
        krzysztof.kozlowski@linaro.org, agross@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, patches@linaro.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH 1/2] arm64: dts: qcom: sm8350-sagami: Add most RPMh regulators
Date:   Tue, 15 Nov 2022 11:46:28 -0600
Message-Id: <166853438868.1276519.12753081374700185660.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221114143642.44839-1-konrad.dybcio@linaro.org>
References: <20221114143642.44839-1-konrad.dybcio@linaro.org>
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

On Mon, 14 Nov 2022 15:36:41 +0100, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@somainline.org>
> 
> Configure most RPMh-controlled regulators on SoMC Sagami. The missing
> ones (on pm8350b and pm8008[ij]) will be configured when driver support
> is added. Thankfully, it looks like PDX215 and PDX214 don't have any
> differences when it comes to PM8350/PM8350C/PMR735a.
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: qcom: sm8350-sagami: Add most RPMh regulators
      commit: 5440c005dadc22ee132d59816ca51eb98aa59954
[2/2] arm64: dts: qcom: sm8350-sagami: Wire up USB regulators and fix USB3
      commit: 5a077120bcf6aacf97da75a0f925bfdbe2666815

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
