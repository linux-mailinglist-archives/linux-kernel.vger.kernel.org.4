Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D7361E8FE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 04:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbiKGDMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 22:12:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiKGDMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 22:12:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BC0DF99;
        Sun,  6 Nov 2022 19:12:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0A1360E9B;
        Mon,  7 Nov 2022 03:12:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A5ACC433D7;
        Mon,  7 Nov 2022 03:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667790761;
        bh=/ITrgkN/B9hw0kL4nYSR1Lr2KvFvAGSqf17UtxY6OHs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ItwvoZoBlM+MAppiXVJQ3Iax5zK7SOXxA6Rh5pFJMci+VZHh9bN+kPfXGlTKXe8o2
         JJgv8y8mbd9wSUrcdyy8WWAifftk0wXjqPwd7/r6Kdu3JbW9vDydl905+uYspyNdAv
         +vo0Cmo1IC2NKDXaytS1fXFlVn9oVYF/Myyl4ZsLoJfgBIoPbAAbyAaBxro2o36zmG
         S7QEovROHK7CZ5eu5seeFWbBwMrDVSsAQdA0Z9EUuYqQKBb/2G9xVuXO2cF/9Dnm67
         xkDSJpQX6fBFcgb1+WQVKp2Ek8bNvWBPTOdkXf8k7aunHLMIqm/FoL7MukcdpSFl6g
         r0Hhi6Wa/Y0LQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     caleb.connolly@linaro.org
Cc:     krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, konrad.dybcio@somainline.org,
        luca@z3ntu.xyz, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH 0/5] arm64: dts: qcom: add and enable the pmi8998 RRADC
Date:   Sun,  6 Nov 2022 21:11:59 -0600
Message-Id: <166779074258.500303.6143441430945522925.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221016180330.1912214-1-caleb.connolly@linaro.org>
References: <20221016180330.1912214-1-caleb.connolly@linaro.org>
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

On Sun, 16 Oct 2022 19:03:24 +0100, Caleb Connolly wrote:
> This contains patches 6 through 10 of the series adding a driver
> for the RRADC
> https://lore.kernel.org/linux-arm-msm/20220429220904.137297-1-caleb.connolly@linaro.org/
> 
> The driver and DT bindings have been in mainline for a while.
> 
> This introduces a new dtbs_check warning which is fixed in
> https://lore.kernel.org/linux-arm-msm/20221016175757.1911016-1-caleb.connolly@linaro.org/
> and depends on Luca's series:
> https://lore.kernel.org/linux-arm-msm/20220925211744.133947-2-luca@z3ntu.xyz/
> 
> [...]

Applied, thanks!

[1/5] arm64: dts: qcom: pmi8998: add rradc node
      commit: 1cb78978d34e1b65bbb912d8265eb95713ae7a45
[2/5] arm64: dts: qcom: sdm845-oneplus: enable rradc
      commit: 868985181a69df53321035d96aa668d90f6cd5cb
[3/5] arm64: dts: qcom: sdm845-db845c: enable rradc
      commit: e779eb99859cc26d051f6fc723d2bd2d5990a812
[4/5] arm64: dts: qcom: sdm845-xiaomi-beryllium: enable rradc
      commit: 53c54069d9ffd556b52893077324e628655cd591
[5/5] arm64: dts: qcom: msm8998-oneplus-common: enable RRADC
      commit: aac16a9d247e5496361bfe20d651f2c1333eb5dc

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
