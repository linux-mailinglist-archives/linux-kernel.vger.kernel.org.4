Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72BA56D72F2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 06:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236797AbjDEEGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 00:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjDEEGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 00:06:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C921C30ED;
        Tue,  4 Apr 2023 21:06:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64F5963965;
        Wed,  5 Apr 2023 04:06:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F99C433EF;
        Wed,  5 Apr 2023 04:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680667577;
        bh=qjrgDVDa5fPmLzogqlbGWIXUX3IHvG/mEgP6jyFc9U4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VB2ma9b65mcKZzx6vfJffxl2Y4m6rs34Uvvwhr+1uCqV0tvAxrihAzmGzpxFi6gWY
         LAcAZGmxJ314S/bPCspKDCb6MgKhvCOyGP4r0Cu+7OD33NhnOV1OKtLP4tedneBD/u
         Kjm2Urynnngii28CKxMtvi8nQtEawo3QQ9ecZ+FyLiR09WI0DH5t14S/DVn02pEUUQ
         lSdsqchxIS+Fx1a8SBpsxrqv/xW9FUXcm1qBAI7QuZae3g43/mcUcEeePTsFusZuKB
         AnOqTCOjqcWSE+UKF7X9wkN7AXE6MAtqhXl5YVjBpxCqhkSEREWsiHL3fUscLHMnRe
         V5+BEjHGG6UxA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Adam Skladowski <a39.skl@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: (subset) [PATCH 1/4] arm64: dts: msm8953: Replace xo_board with rpmcc sourced xo
Date:   Tue,  4 Apr 2023 21:08:49 -0700
Message-Id: <168066774416.443656.12283295998891742657.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230325112852.18841-1-a39.skl@gmail.com>
References: <20230325112852.18841-1-a39.skl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Mar 2023 12:28:49 +0100, Adam Skladowski wrote:
> Assign RPM_SMD_XO_CLK_SRC from rpmcc in place
> of fixed-clock where possible.
> 
> 

Applied, thanks!

[1/4] arm64: dts: msm8953: Replace xo_board with rpmcc sourced xo
      commit: 3042fb4b61c8a6ce692a4914b1970daa56e6f04e
[2/4] arm64: dts: msm8953: Provide dsi_phy clocks to gcc
      commit: 635abd877516f6d5e35343d3c3eb233ab195ebc5
[3/4] arm64: dts: msm8953: Drop unsupported dwc3 flag
      commit: c0494df2cdac723f4c7df834c05d548ea3a804e9
[4/4] arm64: dts: msm8953: Pad regs to 8 digits
      commit: 26aae2310fd7375a5ca0dd772cd3bc57cf5e02bb

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
