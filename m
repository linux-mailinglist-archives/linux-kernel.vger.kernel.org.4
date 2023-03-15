Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D49B6BC165
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 00:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbjCOXfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 19:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233249AbjCOXe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 19:34:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33BC27FD50;
        Wed, 15 Mar 2023 16:33:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 931D1B81FAA;
        Wed, 15 Mar 2023 23:32:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8EF5C433AA;
        Wed, 15 Mar 2023 23:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678923169;
        bh=TztJJoAB6d1POBSwF2F6LPHhJ889Q1ZZwKBG9GfxuF4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=hYGHQdWlGJecZiXMu+JIX/RKgRakH81fwi7MrI5kqOkVN2IoE+M3AEvjWvVRsWFFy
         2L7SmNYXPMIu1BvO+r9LnhlYxQRQ5F/6YTMrpIfSb2n/ZIuTz84bjGtAPmJgqsrkcc
         yWb+hkKayMT/cvdZkrORMw+CBKq5KqEVYUBSChKkm4WhbpO4f2FTCxN7AZAbLLFsgN
         92lzoXcEtRyzs5l6M5sKWBB+34CiT9Hm79ZCrCdN3fiGoODaYY7dQugUszUooK9I2E
         6NHtkuYXg5yn+0YBq+u/2YRebmzydizPcwARDHOTIfsw1sTnz6IMmVsiGnMTxPB4Oz
         8S2b1gN2Spk0g==
From:   Bjorn Andersson <andersson@kernel.org>
To:     broonie@kernel.org, agross@kernel.org,
        Kathiravan T <quic_kathirav@quicinc.com>,
        geert+renesas@glider.be, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, linux-clk@vger.kernel.org,
        rafal@milecki.pl, devicetree@vger.kernel.org, will@kernel.org,
        mturquette@baylibre.com, dmitry.baryshkov@linaro.org,
        linux-arm-msm@vger.kernel.org, sboyd@kernel.org,
        robimarko@gmail.com, robh+dt@kernel.org, nfraprado@collabora.com,
        konrad.dybcio@linaro.org, quic_gurus@quicinc.com, arnd@arndb.de,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH V6 0/9] Add minimal boot support for IPQ5332
Date:   Wed, 15 Mar 2023 16:35:20 -0700
Message-Id: <167892332568.4030021.1650680100964955590.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307062232.4889-1-quic_kathirav@quicinc.com>
References: <20230307062232.4889-1-quic_kathirav@quicinc.com>
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

On Tue, 7 Mar 2023 11:52:23 +0530, Kathiravan T wrote:
> The IPQ5332 is Qualcomm's 802.11be SoC for Routers, Gateways and
> Access Points.
> 
> This series adds minimal board boot support for ipq5332-mi01.2 board.
> 
> Changes in V6:
> 	- Added couple of patches 1/9 and 5/9 in the series to make sure
> 	  all the dependent patches are together
> 	- V5 can be found at
> 	  https://lore.kernel.org/linux-arm-msm/20230217075835.460-1-quic_kathirav@quicinc.com/
> 
> [...]

Applied, thanks!

[9/9] arm64: defconfig: Enable IPQ5332 SoC base configs
      commit: 48adb3be7d617ecc7d9656032e7253406b8040f5

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
