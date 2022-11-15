Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594DE62A0AA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 18:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbiKORqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 12:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbiKORqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 12:46:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9261DFF3;
        Tue, 15 Nov 2022 09:46:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64A5761965;
        Tue, 15 Nov 2022 17:46:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10D3FC43140;
        Tue, 15 Nov 2022 17:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668534395;
        bh=0r+zANsa7T4rqCWjTw1Z6scDK0Tl0ua0IYFuV5E5DXA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OGjWjthRcpBtRB02ki/yZinI11h3le5s5TIWVcAT4pnu3FveMM8j+2gl092+v7tq+
         LrUbOoo3Z3uIuJ47hSBHyDuDJNGc3AVFarZCWHNWECXZRGb1ZcD0t6ie6cKcZJlq8H
         IiuNCyQZi3fIJUKaB4Ymv/5W3SsiYj/SUV3aBe399g/PkUw18xjbL9zOYU0QyzM0Dk
         er0Logd+BPFzTzjWf9eREw6BrBAp5RjQ7MrZ+5vB3sLqSNTWnWm8Qvg9zlI4R266u2
         jGR9vLmXQi1w26LpomcSSvyDlrCXeR1TfrVOWD06Tk5a72d7FY8+FLNAkKcfWpOS45
         JRElvF6v5Lk1w==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-arm-msm@vger.kernel.org, konrad.dybcio@linaro.org,
        krzysztof.kozlowski@linaro.org, agross@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, patches@linaro.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sdm845-polaris: Don't duplicate DMA assignment
Date:   Tue, 15 Nov 2022 11:46:29 -0600
Message-Id: <166853438868.1276519.3312659383441461546.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221114140011.43442-1-konrad.dybcio@linaro.org>
References: <20221114140011.43442-1-konrad.dybcio@linaro.org>
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

On Mon, 14 Nov 2022 15:00:11 +0100, Konrad Dybcio wrote:
> The DMA properties in this DT are identical to the ones already
> defined in sdm845.dtsi. Remove them.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sdm845-polaris: Don't duplicate DMA assignment
      commit: afcd946be11c937ed400b1d4727e2b5fe04ba693

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
