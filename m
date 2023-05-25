Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4867104A5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237947AbjEYEz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237549AbjEYEx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:53:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587CC1B3;
        Wed, 24 May 2023 21:51:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E01A9642C8;
        Thu, 25 May 2023 04:51:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F76EC43445;
        Thu, 25 May 2023 04:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684990304;
        bh=IVPrSp1Rzd/jeDknlfHG2qYxHMpBodqY31lMRg/JiG8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DQXutS5hkqBfHRbwqtdlEDGseXSkzk7nOANff1iYVmL64i6753B1Igc3bAi32jKYe
         5+JPitil0U2D2u59uMEcR4V5X6sqbzLIZkqWwWCzrAy0Y46zmTkmlEUE03BONpFm55
         6wJL0guDArSxIuISvyP4cEnqve8DMxqqC980FRNdqKF+CIorFm931Erob6jGfXEOO/
         djubnindno1SFO2PGfWCyqJ5npo1dcvkrr4gvXOYizZhj/gpuA6gDi+DaRW8418GwQ
         WbxXyG9hgMf1TYrpP1Xj1wzIBowLsrlMOFKOXeLQkyxAxD3RQESrJ048sOLWAC3GNc
         qLP9qawYEnWWA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>, Luca Weiss <luca@z3ntu.xyz>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: Add BLSP DMAs for I2C
Date:   Wed, 24 May 2023 21:54:23 -0700
Message-Id: <168499048184.3998961.13911841167895422124.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230422-msm8953-blsp-dma-v1-1-0024801bb587@z3ntu.xyz>
References: <20230422-msm8953-blsp-dma-v1-1-0024801bb587@z3ntu.xyz>
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

On Sat, 22 Apr 2023 13:39:16 +0200, Luca Weiss wrote:
> MSM8953 has two DMA controllers for the various I2C, SPI and UART
> busses. Add the nodes and configure all the I2C nodes so that the driver
> can use the DMA.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: Add BLSP DMAs for I2C
      commit: a5317b23fe6f26307f4c821d56d694c893887675

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
