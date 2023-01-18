Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F023672BC5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 23:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjARWuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 17:50:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjARWun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 17:50:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65E9654DA;
        Wed, 18 Jan 2023 14:50:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65388B81F70;
        Wed, 18 Jan 2023 22:50:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D482C433EF;
        Wed, 18 Jan 2023 22:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674082236;
        bh=dx/RyOv4myvAhvEzvK2zgD1ue19vwbELf4FPcJL9jIM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MSJCGl4jIq/T3YKZ3RYLbTm/AFanYEKNH6aYErh/cjON8oxF13ckd551v2+rN0DFS
         L8eUCkxP1MzwwhwIx4Rk2+Rp92xIKBC6m08zqEP9xDLsw5zHAjJZh6EkuArWW2KhM+
         GgNJwPgeWESEGyrgyVAivhxpNQbymWm6SuhLHkFdLVvHRltDag7ljVnGqqxUJgaESB
         N4OtKxEtapQmND+79A9ryRf4SujDzHd9rzH7Kg6byUTpX33XeiPiZf6zsS6GGbJmNX
         sdogrnzqG120vQiz4gJWVQzmnApY64BbBL5lk1Aig2Zkc968H1PAEk//I+1mFK+qR7
         f/42HduykPafw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     konrad.dybcio@linaro.org, neil.armstrong@linaro.org
Cc:     linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 0/2] arm64: defconfig: enable modules for Qualcomm SM8550-MTP display
Date:   Wed, 18 Jan 2023 16:50:26 -0600
Message-Id: <167408222409.2952004.11124017292055201527.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230110-topic-sm8550-upstream-display-defconfig-v1-0-9941c8083f10@linaro.org>
References: <20230110-topic-sm8550-upstream-display-defconfig-v1-0-9941c8083f10@linaro.org>
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

On Tue, 10 Jan 2023 20:34:33 +0100, Neil Armstrong wrote:
> Enable the SM8550 DISPCC and Visionox VTDR6130 panel drivers as module
> to enable display on the SM8550 MTP device.
> 
> 

Applied, thanks!

[1/2] arm64: defconfig: enable SM8550 DISPCC clock driver
      commit: 406b4c06cb61bb2d19aa2e5a9267044f17a539a0

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
