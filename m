Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2668D74CBC0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 07:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbjGJFGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 01:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbjGJFFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 01:05:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231D710EB;
        Sun,  9 Jul 2023 22:04:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FE0E60E26;
        Mon, 10 Jul 2023 05:04:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDE82C433CA;
        Mon, 10 Jul 2023 05:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688965483;
        bh=sokvzETFKZC41G3wVx4ImZdZy5HEdd2PWZtA9rXFHrI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lh9aJynOtSUeK1d7Ukri4iaHcseh6EzHo63eoS+z4FgnL4whjuiQg39RbjgNXagIr
         mrXa5WuFEb2fy3gLURIPQ9bBA+OiVhuoMIbsJKGWN/YIGQIFjXu6gBAaHLgggKHWeT
         XWtEVo+Fn3HsbtQAwG+Y6ElbSJ6tA9WwTMVMwDORKTOyGxEiGO/2exCl75ZgQN9+QP
         pH5KKUnr0Y1c2rDR0CDqX7Hlb72C1anw6c5uun2w1QcJ/h2Hi4gskxtE+WBig/mSYD
         HnSl9wTnTSs5WoqxmaXfXMmLiFDyiXg8KfMP7c2g22VBpONcIAD/cHMhmWOXM8P+u1
         k6UaDOLxXztCw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: (subset) [PATCH v2 0/3] Fix up 8280 GCC GDSCs
Date:   Sun,  9 Jul 2023 22:07:23 -0700
Message-ID: <168896565971.1376307.5044970624310354958.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230620-topic-sc8280_gccgdsc-v2-0-562c1428c10d@linaro.org>
References: <20230620-topic-sc8280_gccgdsc-v2-0-562c1428c10d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 26 Jun 2023 19:48:05 +0200, Konrad Dybcio wrote:
> Part of the SC8280XP GDSCs were not fully described and others were
> missing. This series attempts to fix that.
> 
> As usual with the laptop stuff, please test it on your setup to make sure
> everybody's still happy.
> 
> 
> [...]

Applied, thanks!

[1/3] clk: qcom: gcc-sc8280xp: Add missing GDSC flags
      commit: 2fd02de27054576a4a8c89302e2f77122c55e957
[3/3] clk: qcom: gcc-sc8280xp: Add missing GDSCs
      commit: 4712eb7ff85bd3dd09c6668b8de4080e02b3eea9

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
