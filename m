Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB51D5B934F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 05:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbiIODht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 23:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbiIODhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 23:37:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E042793214;
        Wed, 14 Sep 2022 20:37:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3213A62082;
        Thu, 15 Sep 2022 03:37:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99AFAC43470;
        Thu, 15 Sep 2022 03:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663213037;
        bh=hXo8PbklUD4P7mwRU94L4ijc/+r0ea3knn93F9DL5NU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fN5OnTN27Qym2fGhL8dkz8BCao1+NYI3gARhELO5AuHPtBdzPlvBv0Nz3Jm31AHAr
         eF34y7xDTLIG+TGxQ8dS8AMclzvY5rQUJJiP+f91wVQKDKUPvZIjEVPPCTenizncnP
         O6Mbo4sAdM9W6iz/elTttBXT4KefdIm0f92HRWy308W4mbI1+U/w3A0WyvUHml+Jdc
         Ng4o7sKuYtl3gJt7TCwY/CtUx33lchZ9qnLSx7sSlV7EVD8HNq2iEzvNQgCveyWdsc
         oZQOZc9SmMG5XTI+m/zE6X/5RpR7UdeTnBOPJqwe91J+znfBc2lthLlofaD874/nWt
         0BMvpNyu5edXw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     mailingradian@gmail.com, linux-arm-msm@vger.kernel.org
Cc:     agross@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        jo@jsfamily.in, konrad.dybcio@somainline.org,
        linux-clk@vger.kernel.org, robh+dt@kernel.org, caleb@connolly.tech,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH v4 0/3] SDM670 Global Clocks
Date:   Wed, 14 Sep 2022 22:36:59 -0500
Message-Id: <166321302049.788007.6905629348240646404.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220914013922.198778-1-mailingradian@gmail.com>
References: <20220914013922.198778-1-mailingradian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Sep 2022 21:39:19 -0400, Richard Acayan wrote:
> Changes since v3:
>  - rebase onto next-20220913
>  - accumulate review tags
> 
> Changes since v2:
>  - drop GCC_SDCC1_BCR reset
>  - reorder gcc-sdm845 and gcc-sdm670 if statements in bindings
>  - add space
>  - accumulate review tags
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: clock: gcc-sdm845: add sdm670 global clocks
      commit: 657e9326658c1c570eb1e8fd122a4a7936433673
[2/3] clk: qcom: gcc-sdm845: use device tree match data
      commit: 8e90216d2db99f0b883be3b40d5b581437dc4a5d
[3/3] clk: qcom: gcc-sdm845: add sdm670 global clock data
      commit: ae66b1fe48e2dd91229f2b8f25295bce629382d0

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
