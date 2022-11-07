Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D49C61E914
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 04:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbiKGDNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 22:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbiKGDMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 22:12:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFE8DFB0;
        Sun,  6 Nov 2022 19:12:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 37D85B80D7C;
        Mon,  7 Nov 2022 03:12:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14104C4347C;
        Mon,  7 Nov 2022 03:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667790767;
        bh=eHVb7ZciPLVALoLFYWEq9rlBEq8qxMdq9ufQ9uYRkms=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uqFvO7JIcnSlS6mJZwkd9bE17zGBWsYaBJgZCLgfDWQYwsfcVOK1koC5sE6ejYo+V
         k3nYF8+QdIkXzX/3NT7DZLzFuuIE47mSEc1gXESwi/lH+VUowQl6dNsDCFZde3Wdan
         SPHebRQvd1pgeKO+Lpnj4paeW06/lRHoGuT/BOkJ3KOQvpoCXJIqZX9Q+pTvCpiK7K
         03u6RBk1is4bp6IMwRAM1Ky4BIlMH3SmOWQMapwfWZ10ogOcngZ13/hE/S6bDbEGyc
         Jk29aT01FaoT8zac1/zyOLmqNy+C99Z5zSzZUBX28S7FjZY89kUniGRUvBk2hFCDbY
         LyAKmpRbl2pog==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, hpausten@protonmail.com
Cc:     ~postmarketos/upstreaming@lists.sr.ht, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, konrad.dybcio@somainline.org,
        y.oudjana@protonmail.com, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>
Subject: Re: [PATCH v2 0/4] Initial OnePlus 3(T) Support
Date:   Sun,  6 Nov 2022 21:12:05 -0600
Message-Id: <166779074264.500303.8835095295944116089.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221023204505.115141-1-hpausten@protonmail.com>
References: <20221023204505.115141-1-hpausten@protonmail.com>
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

On Sun, 23 Oct 2022 20:45:16 +0000, Harry Austen wrote:
> Changes from v1
> ---------------
> v1: https://lore.kernel.org/all/20221021142242.129276-1-hpausten@protonmail.com/
> - fix node name DT schema problems
> - removed "simple-bus" compatible from /clocks node
> - use common "-clk" suffix for divclk1/4 node names
> - use common "-regulator" suffix for wlan-en regulator node name
> - move status properties last in all nodes
> - fixed copyright to be assigned to myself, since I don't work for LF
> - add Krzysztof's Rb tag to bindings patch
> 
> [...]

Applied, thanks!

[1/4] arm64: dts: qcom: msm8996: standardize blsp indexing
      commit: 1a94ba5b44c5448c7ec962a5ce66eb12a6042288
[2/4] arm64: boot: dts: msm8996: add blsp1_i2c6 node
      commit: 18c32de673bf3ade651979be48e9a14bfe612487
[3/4] dt-bindings: arm: qcom: add oneplus3(t) devices
      commit: ce5d6ba21ae6c83fc2db385f9202272ca0d403f2
[4/4] arm64: dts: qcom: msm8996: add support for oneplus3(t)
      commit: 5a134c940cd368b72d5bcf24132b8f951be9a4c1

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
