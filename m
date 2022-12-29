Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0D4C658FA7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 18:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233842AbiL2RYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 12:24:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233851AbiL2RXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 12:23:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA7814D21;
        Thu, 29 Dec 2022 09:23:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B6221B81A1A;
        Thu, 29 Dec 2022 17:23:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9341C433A1;
        Thu, 29 Dec 2022 17:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672334630;
        bh=pnbfdQAgvYlkRU/LCASE7lcQjhgYZ3UhDxo3CMJ9WVY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=J+0wlxEhPsIsNPaImsGoGS/eCKATi6iSKNeUQaDETVARUFJMWGkjAMxGO/6/q44H5
         KQAni4XePkOJd+Tyz/Hkhbpt3tsbb22SXIXCYk4YeNftHoi3GrYcsgKr1R3EAfV6QU
         WVd2H805flWurY6kiE0Z/F6NkKaMIx9SQenRbsAi8ElV4InUmfG6Hz5D9KhJBR36xC
         k5mo0ymJNxiDq6OXXolpxil8gfDTWM04L+0oEXwY4p+tXhmsz39umSH7qNvWts4biT
         QVeBcrSoweJ2L6Q6W8M7pco7jOfthwuo3yex0kd79iG1MbxEq7BLkExX80mwykmqUS
         9C1JpCHm5bwng==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@linaro.org, devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH 1/5] arm64: dts: qcom: msm8996: align bus node names with DT schema
Date:   Thu, 29 Dec 2022 11:23:29 -0600
Message-Id: <167233461775.1099840.3444272939352778399.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221224154255.43499-1-krzysztof.kozlowski@linaro.org>
References: <20221224154255.43499-1-krzysztof.kozlowski@linaro.org>
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

On Sat, 24 Dec 2022 16:42:51 +0100, Krzysztof Kozlowski wrote:
> The node names should be generic and the bindings expect "bus" for
> simple-bus nodes:
> 
>   msm8996-mtp.dtb: agnoc@0: $nodename:0: 'agnoc@0' does not match '^bus(@[0-9a-f]+)?$'
> 
> 

Applied, thanks!

[1/5] arm64: dts: qcom: msm8996: align bus node names with DT schema
      commit: 496b308f0988f3fb610073e125da8ef8065b334f
[3/5] arm64: dts: qcom: sm8250: drop unused clock-frequency from va-macro
      commit: 42db0f72f7a8c33501a55537ac90557a665a56f8
[4/5] arm64: dts: qcom: sm8450: re-order GCC clocks
      commit: 539a9923683c79e6925dd69a2e2534ec197361c7
[5/5] arm64: dts: qcom: use generic node name for CS35L41 speaker
      commit: 9e8e9be6c499d3dfa408b7306004c4b981622ff1

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
