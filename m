Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D19A711DDC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 04:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234915AbjEZC1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 22:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjEZC1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 22:27:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C122E9B;
        Thu, 25 May 2023 19:27:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54C7264B7B;
        Fri, 26 May 2023 02:27:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1015C433EF;
        Fri, 26 May 2023 02:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685068037;
        bh=IjyfqYdDittzF4tAOZQdZ6/Y82iHJkRqWBGwxbBg8oQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JFnVko+8k4pihJ0qM+7G/pCT8x9IQmKp/6xd/DnhPw/BE1BSWI0M9TRaOWKePlWVf
         +lK01wchufp1ksgCy7BKqWVSW3VfAsNCC7+4sir0SlGl73T5YlaP6kw3CSsQKvpTgP
         nLTz9NpNoBRx9UA2ibHnN2crMc6dpGR36hmizOw1HjDIYJstJHnoxmqKdYoUc6gL8z
         079roSFb0XrDbXQWZxtR6aNXonDgCXPYrJXRqffLF38yF89yvAL6L65ge5zsky5Lq9
         +bj3NEmO75zQzNozr1kyBUgqllnA1zYikpR+H3s0d7/1Js4FeMk/8PtN/1rokRYy73
         tPaMLD1lOYqsw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     konrad.dybcio@linaro.org, robh+dt@kernel.org, agross@kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        krzysztof.kozlowski+dt@linaro.org, djakov@kernel.org
Cc:     stephan@gerhold.net, dmitry.baryshkov@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, benl@squareup.com,
        linux-arm-msm@vger.kernel.org, leo.yan@linaro.org,
        fabien.parent@linaro.org, shawn.guo@linaro.org
Subject: Re: [PATCH v9 0/4] Add MSM8939 SoC support with two devices
Date:   Thu, 25 May 2023 19:31:07 -0700
Message-Id: <168506826317.164705.12122160122945640956.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230407194905.611461-1-bryan.odonoghue@linaro.org>
References: <20230407194905.611461-1-bryan.odonoghue@linaro.org>
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

On Fri, 7 Apr 2023 20:49:00 +0100, Bryan O'Donoghue wrote:
> V9:
> - Fixes name of tsens
>   s4 is not present
>   s4->s5
>   s5->s6
>   s6->s7
>   s7->s8
>   s8->s9
>   I erroneously thought the last sensor needed to be brought in but,
>   as has been pointed out to me, the last sensor isn't used, so
>   no need to support the reading and reassembly of the non-contiguous
>   calibration data - Stephan/Dmitry
> 
> [...]

Applied, thanks!

[1/5] dt-bindings: vendor-prefixes: Add Square
      commit: 8051c8b83ac076ab7f4fc80cff5e7f8cc3b1eefb
[2/5] arm64: dts: qcom: Add msm8939 SoC
      commit: 61550c6c156c3715baf54ab2cdd678c8c35b3803
[3/5] arm64: dts: qcom: Add msm8939-pm8916.dtsi include
      commit: 1e6dfe47ba020a192d743c7c820b469fd7253813
[4/5] arm64: dts: qcom: Add Square apq8039-t2 board
      commit: 273a3dc13eb746c7b7abe7ea682811a8dacc89d6
[5/5] arm64: dts: qcom: Add msm8939 Sony Xperia M4 Aqua
      commit: f1134f738fad68c51a44216ab0f68a0f086a1a5e

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
