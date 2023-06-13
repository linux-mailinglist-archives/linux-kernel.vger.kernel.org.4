Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119EB72EF78
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 00:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241284AbjFMW3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 18:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241111AbjFMW2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 18:28:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BADE26AF;
        Tue, 13 Jun 2023 15:27:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DBC4D63B91;
        Tue, 13 Jun 2023 22:27:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 506FDC433C9;
        Tue, 13 Jun 2023 22:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686695256;
        bh=PmmIMwt5KX2PmtbiocXIA/iO1nolx+T4Zv5EbVNRwoI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=doc//gFGoCjLH2ABmF/MOUq+sm18PrnTsdZzJGDtGfTNHKohBYLAm1hTqfTpg5d1m
         vleLHoP2vHNAomRnzfjW1pPSSTPo9bZ28hH4JsRtfRx5Rc7TeBPi2BqiNs2LYxuFg4
         GdpR4D++l+RaKDgMUsj6yO3C+ZcfnNxWyqbmerKHOVlJZSfsAAfFAlkHtkt171KH1I
         dn5pvSz1XOuB41Lb6ySizEiqovr3yECz214MdDh3m8ks9UmXOjQ9Dvyhs9mlEAfRvg
         MvAa9d5jB7tXhB1gpWRw9t7TiNyps46wS8WENKU4dCH1b7CB0iCrpceBp15+OpMqRg
         b0xSN6VpR4ugw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     agross@kernel.org, sboyd@kernel.org, johan+linaro@kernel.org,
        linux-arm-msm@vger.kernel.org, konrad.dybcio@linaro.org,
        linux-clk@vger.kernel.org, conor+dt@kernel.org,
        mturquette@baylibre.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v3 0/6] clk: qcom: sc8280xp: add lpasscc reset control
Date:   Tue, 13 Jun 2023 15:30:32 -0700
Message-Id: <168669542894.1315701.12133539015223197295.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230608125315.11454-1-srinivas.kandagatla@linaro.org>
References: <20230608125315.11454-1-srinivas.kandagatla@linaro.org>
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

On Thu, 8 Jun 2023 13:53:09 +0100, Srinivas Kandagatla wrote:
> On SC8280XP, LPASS IP is controlled by q6dsp, however the reset lines
> required by some of the IPs like Soundwire still need to be programmed from
> Apps processor. This patchset adds support to reset controller on LPASS
> CC and LPASS AudioCC.
> 
> Tested on X13s.
> 
> [...]

Applied, thanks!

[6/6] arm64: defconfig: Enable sc828x0xp lpasscc clock controller
      commit: 318da4837d75efb2411b86b39427b7047b41204a

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
