Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF9296021D4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiJRDH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbiJRDGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:06:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC99A9836D;
        Mon, 17 Oct 2022 20:06:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E36BBB81C55;
        Tue, 18 Oct 2022 03:06:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D88C43148;
        Tue, 18 Oct 2022 03:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666062400;
        bh=6bJyLPxsVhaIusmLVfg043zJdG7nc7Swagot1PtJfcE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DkKaaHAaTKVGMwCmg6Bzjo0PZm3xkJLyspsnfpGt+fmJ0GmXNTc1pEIEVS/eDWOAF
         D8a4++e3jz2gyREf8SGbhotluR1pCnUwMyr784ihGanOKlqiXOVUvjp0L5YK7g5ATc
         PK21EUyKrN8gtlzgZj2lJJh+CDdxn3Osf5eL25QQu0afgDtuhRTTz9mErjlFUFzco9
         Rr7ZejpRNAVSpWrWaiKHbXWPKtK8t6HjfuYGOCNjAnraHFG6SCV3j+cbcX/bBZCM1X
         u+FByVa/f/absnQFG6omk3J0JoX/n094CDgDBWUSnEpbnej+g0ao3QdKAhWVooKkBq
         s/7NFk1vpEAVw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, judyhsiao@chromium.org
Cc:     linux-arm-kernel@lists.infradead.org, swboyd@chromium.org,
        dianders@chromium.org, cychiang@google.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mka@chromium.org, srinivas.kandagatla@linaro.org,
        robh+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        judyhsiao@google.com
Subject: Re: [PATCH v4 0/3] Add dtsi for sc7280 herobrine boards that using
Date:   Mon, 17 Oct 2022 22:05:22 -0500
Message-Id: <166606235842.3553294.9084316282686568235.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220721083849.1571744-1-judyhsiao@chromium.org>
References: <20220721083849.1571744-1-judyhsiao@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jul 2022 08:38:46 +0000, Judy Hsiao wrote:
> Put sound node and lpass_cpu node settings for boards that use rt5682
> codec in the sc7280-herobrine-audio-rt5682.dtsi as there are different
> choices of headset codec for herobrine projects. Common audio setting
> for the internal speaker is in sc7280-herobrine.dtsi.
> 
> This series depends on:
> Add soundcard support for sc7280 based platforms. [1]
> 
> [...]

Applied, thanks!

[1/3] arm64: dts: qcom: sc7280: herobrine: Add pinconf settings for mi2s1
      commit: a1afae1ac6e71f9995fd87fea3a116859fd64fe1
[2/3] arm64: dts: qcom: sc7280: Add sc7280-herobrine-audio-rt5682.dtsi
      commit: 1c5b7afeaf5b6568dc2f36d444d70ad9f6632582
[3/3] arm64: dts: qcom: sc7280: Include sc7280-herobrine-audio-rt5682.dtsi in herobrine-r1
      commit: dd1651572165ffbe52e3d1aa184c04a9c11d3a03

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
