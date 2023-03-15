Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6847E6BC130
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 00:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbjCOXd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 19:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232912AbjCOXcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 19:32:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7040A1FEB;
        Wed, 15 Mar 2023 16:32:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 666A261EBA;
        Wed, 15 Mar 2023 23:32:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA32C433EF;
        Wed, 15 Mar 2023 23:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678923147;
        bh=aYE3ceH7zMcEWT+pjYBPS/KkC5SY9LjLSfloAJQ7qTQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a5vX7s7W0BOZ0g7F2PU6s7rxDqcFkeoDzYAIwvYgxGeNbpXxMyMWWzIjsrKir4Ycr
         +LPES/T2b1nmS+b+JU15/T6MZQT2wWM6XS7GT5QOUu8qmi9yiGI2ukQ5FfFrOprOoz
         LVGsftmIRid79NF7p7LTvP1cfsD2VyIdKYX3ENgX95IRKzfHToYHJQXYgpFeZPDcaR
         LDTTXX7C4mdlhMqaWOTS2SF4gJk8GTWgBm5+PJslxsPThKliWfjgzIu5S1Bz+qykJX
         heRRuBt9pR5Tu6cIjhd8xMWACh3ynBH/cEaXXmfVR3pW9a/Xug7X7X6KbztgUpDfnG
         s53vHkniL7G6g==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, Shawn Guo <shawn.guo@linaro.org>,
        marijn.suijten@somainline.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: gcc-qcm2290: Fix up gcc_sdcc2_apps_clk_src
Date:   Wed, 15 Mar 2023 16:34:57 -0700
Message-Id: <167892332567.4030021.16469881579461393985.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230315173048.3497655-1-konrad.dybcio@linaro.org>
References: <20230315173048.3497655-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Mar 2023 18:30:48 +0100, Konrad Dybcio wrote:
> Add the PARENT_ENABLE flag to prevent  the clock from getting stuck
> at boot and use floor_ops to avoid SDHCI overclocking.
> 
> 

Applied, thanks!

[1/1] clk: qcom: gcc-qcm2290: Fix up gcc_sdcc2_apps_clk_src
      commit: 1bf088a9f0e50acd175ba8deef0db11c099fa26e

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
