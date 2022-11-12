Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 984536266CB
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 04:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234734AbiKLDwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 22:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234681AbiKLDwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 22:52:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5A72EF59;
        Fri, 11 Nov 2022 19:51:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CF099B827CF;
        Sat, 12 Nov 2022 03:51:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 218E9C433C1;
        Sat, 12 Nov 2022 03:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668225116;
        bh=yrK47C3f2tNJi6b6sjxYeNprjn2F4vUHA2G1RSWaNDI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bFcveIwLmHACgvqnGUDFTw2IVu4XvavQsL0tXAHgb3Bd2rlZp9ZqEqH+pTVI2/0ds
         WRXylI0yPfrHXHYYEmPB0sdTRluebX/T9j0XqsIxTCckutqPh0jJItfirGQt8oCPgH
         aGk2FYjVaRIGV+CmsA8lltaPUO6egFTS4bVhkpZZMisDF2PM4etp6MPZlc1cTZUhjG
         ruHg+5pYOfp47U065xoCS8/Li/6yOaGtMtk93GwZAXW7erG3R/XIljGc2i02saHwuy
         BLTHbe1O5nUP4Ig7Q84ZB/Vhh2/PZ3Ker4Q1ViaUrDo4fRGVKFekfuF/RnqdTzTTIq
         vgq5HSa3TsM9g==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-arm-msm@vger.kernel.org, vkoul@kernel.org,
        quic_gurus@quicinc.com, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, luca@z3ntu.xyz, treding@nvidia.com,
        devicetree@vger.kernel.org, chanho61.park@samsung.com,
        iskren.chernev@gmail.com, konrad.dybcio@somainline.org,
        robimarko@gmail.com, agross@kernel.org, mailingradian@gmail.com,
        lpieralisi@kernel.org, stephan.gerhold@kernkonzept.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: (subset) [PATCH v4 0/4] Initial SDM670 and Pixel 3a support
Date:   Fri, 11 Nov 2022 21:51:49 -0600
Message-Id: <166822510244.978218.7596649009807619936.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221111001818.124901-1-mailingradian@gmail.com>
References: <20221111001818.124901-1-mailingradian@gmail.com>
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

On Thu, 10 Nov 2022 19:18:15 -0500, Richard Acayan wrote:
> Changes since v3:
>  - remove qcom,msm-id and qcom,board-id (4/4)
> 
> Changes since v2:
>  - remove intc address and size cells (4/4)
>  - move apps_rsc label property down (4/4)
>  - move properties in intc (4/4)
>  - remove leading zeroes in iommus (4/4)
>  - change 0x0 to 0 in regs except cpu (4/4)
>  - change 0 to 0x0 in memory regs (4/4)
>  - convert hex to decimal in rmi4 #cells properties (4/4)
> 
> [...]

Applied, thanks!

[4/4] arm64: dts: qcom: add sdm670 and pixel 3a device trees
      commit: 07c8ded6e373830aed55139b2030e755177e1611

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
