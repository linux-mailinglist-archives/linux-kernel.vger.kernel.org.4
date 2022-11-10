Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09FCA623AD9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 05:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbiKJEJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 23:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbiKJEJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 23:09:18 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C8C21E19;
        Wed,  9 Nov 2022 20:09:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CC5CACE2149;
        Thu, 10 Nov 2022 04:09:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE8AC433D6;
        Thu, 10 Nov 2022 04:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668053354;
        bh=7yH7JrckIGUDV7kW3P9KSyXq3PuMvdOaTwqEkFre4pw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DaSdg8X+kNG0YXmfGX5FQem7lgW+grzj52emEkHr/cu2IFEH+qimY2tUjHIY5dHQV
         yV9vm4Ojg+7c5zruJLCT1/A5n0US9X7kqPuZ06rljDAZ6FBxM+gznBMSj9doffxwEG
         bZkeVOhVSZp3mvdPpQyM+frzuBqMCLiznQIzMF72Tjp4VcsWTNavM28D05NZ04umrp
         d3oA/7odQObmmUkwYU1efyiFW7gUGSU+f0JJ6XPMoaydb4JdpypLNARVpWzSyAmxgt
         qKlxFCwDyX6kKXplaB8I8jwO3pxUoTNzhbDIaQ+5gbhFfSErfk487ZsRDb+Lknb4IT
         9BJ4FoVOIPXdQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     robh+dt@kernel.org, sboyd@kernel.org, konrad.dybcio@somainline.org,
        agross@kernel.org, Bjorn Andersson <andersson@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org
Cc:     mturquette@baylibre.com, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH 0/2] clock: qcom: SC8280XP display clock controller
Date:   Wed,  9 Nov 2022 22:09:06 -0600
Message-Id: <166805334838.800572.10546755147001769767.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220811041211.3825786-1-bjorn.andersson@linaro.org>
References: <20220811041211.3825786-1-bjorn.andersson@linaro.org>
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

On Wed, 10 Aug 2022 21:12:09 -0700, Bjorn Andersson wrote:
> This adds binding and implementation of the SC8280XP display clock controller.
> 
> Bjorn Andersson (2):
>   dt-bindings: clock: Add Qualcomm SC8280XP display clock bindings
>   clk: qcom: Add SC8280XP display clock controller
> 
> .../bindings/clock/qcom,dispcc-sc8280xp.yaml  |   98 +
>  drivers/clk/qcom/Kconfig                      |    9 +
>  drivers/clk/qcom/Makefile                     |    1 +
>  drivers/clk/qcom/dispcc-sc8280xp.c            | 3218 +++++++++++++++++
>  .../dt-bindings/clock/qcom,dispcc-sc8280xp.h  |  100 +
>  5 files changed, 3426 insertions(+)
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
