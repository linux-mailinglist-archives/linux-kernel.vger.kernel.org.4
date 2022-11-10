Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A34A3623ADE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 05:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbiKJEJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 23:09:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbiKJEJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 23:09:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7ED27CD8;
        Wed,  9 Nov 2022 20:09:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 682DE61D76;
        Thu, 10 Nov 2022 04:09:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DFB0C433D7;
        Thu, 10 Nov 2022 04:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668053357;
        bh=jk3JZNyq9AH3w2zPFFMG02UXloY9dAyP2DgBr7MRrA8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WVoaQJxLaYd/8yYOSiviMQPpxEhI44CCySWiKLySTMLJaQ7oduGqbd7Tg+BjSBdLO
         667i5SbDF7N+p6/1MRYaUTQ0RItNBFBm2jS8bTVlDlyG8qdAKU0GAjPvnoxxy77mi6
         dBIQwwpv9KvivRtrlhrUJDdX85Fa2m2iJWfN4hqbWxooPsFbCkNbueEpbs9pHiGDgJ
         8s9fvaVIdkj2ld+P4u6AKPf9xls4Np6pa6lj9Y6ri7gupKKj6crmsDcKppsicbhnhg
         /9fCiI6rNXKwm/bz9+NynhcZiAPthCm15woWILNWu8V8dGryjSaPvV9QyyOMD6dFRw
         0HUVtE6f9U5Zw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, quic_bjorande@quicinc.com
Cc:     robh+dt@kernel.org, konrad.dybcio@somainline.org, sboyd@kernel.org,
        mturquette@baylibre.com, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: (subset) [PATCH v2 0/2] clock: qcom: SC8280XP display clock controller
Date:   Wed,  9 Nov 2022 22:09:10 -0600
Message-Id: <166805334840.800572.11422604282237278467.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220926203800.16771-1-quic_bjorande@quicinc.com>
References: <20220926203800.16771-1-quic_bjorande@quicinc.com>
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

On Mon, 26 Sep 2022 13:37:58 -0700, Bjorn Andersson wrote:
> This adds binding and implementation of the SC8280XP display clock controller.
> 
> Bjorn Andersson (2):
>   dt-bindings: clock: Add Qualcomm SC8280XP display clock bindings
>   clk: qcom: Add SC8280XP display clock controller
> 
> .../bindings/clock/qcom,dispcc-sc8280xp.yaml  |   97 +
>  drivers/clk/qcom/Kconfig                      |    9 +
>  drivers/clk/qcom/Makefile                     |    1 +
>  drivers/clk/qcom/dispcc-sc8280xp.c            | 3218 +++++++++++++++++
>  .../dt-bindings/clock/qcom,dispcc-sc8280xp.h  |  100 +
>  5 files changed, 3425 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,dispcc-sc8280xp.yaml
>  create mode 100644 drivers/clk/qcom/dispcc-sc8280xp.c
>  create mode 100644 include/dt-bindings/clock/qcom,dispcc-sc8280xp.h
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: clock: Add Qualcomm SC8280XP display clock bindings
      commit: 73d9c10a96e52aaa2cd19806ac127a3a0e87c410
[2/2] clk: qcom: Add SC8280XP display clock controller
      commit: 4a66e76fdb6d0c742ad13db45888c14a9c1ef1a9

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
