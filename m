Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE370620602
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 02:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233420AbiKHB3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 20:29:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233414AbiKHB2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 20:28:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386D02B250;
        Mon,  7 Nov 2022 17:28:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C707761388;
        Tue,  8 Nov 2022 01:28:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13AB3C43470;
        Tue,  8 Nov 2022 01:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667870888;
        bh=kHb/0kaYEYHJy6WjyZh1ezGPAYiw7Je+ByX/XxqPxYM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RsjDexSxkUp3X/k2rua3Pw24Bfq9Ummk9HLefx4t5stmb+hmFOj5ocoGPfK9A8dA/
         0ZOJRUppf6/5SUCopSEJQefH+9+qsr0wMPMGa2+x0tIyZYMnqsoJ29vBg2q2FV7GT+
         Z84jYb1dj8Ri94DAybtVgf+1HW0b2U7rTsWRgbYrpGQ0EDeB5tUWhkObtkTtKmG/Gy
         Y21zqb9um2H46do2i+oavulBi2Ykvyzl/JKgJ0PU+UcfjaD/VB7Xpeo6D6ub5KXSJy
         6gar01OrATqKAOgNxoDZSYi+NDThuYxzC+/hsGIhG00tsmNLCEI2MkrGTksbfRlgdo
         oCnZzw4+3d4ZQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     quic_molvera@quicinc.com, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        maz@kernel.org, tglx@linutronix.de
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        quic_tdas@quicinc.com, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: (subset) [PATCH v3 0/5] clk: qcom: Add clocks for the QDU1000 and QRU1000 SoCs
Date:   Mon,  7 Nov 2022 19:27:37 -0600
Message-Id: <166787084679.599230.10880542049435908148.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221026190441.4002212-1-quic_molvera@quicinc.com>
References: <20221026190441.4002212-1-quic_molvera@quicinc.com>
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

On Wed, 26 Oct 2022 12:04:36 -0700, Melody Olvera wrote:
> This series adds the GCC, RPMh, and PDC clock support required for the
> QDU1000 and QRU1000 SoCs along with the devicetree bindings for them.
> 
> The Qualcomm Technologies, Inc. Distributed Unit 1000 and Radio Unit
> 1000 are new SoCs meant for enabling Open RAN solutions. See more at
> https://www.qualcomm.com/content/dam/qcomm-martech/dm-assets/documents/qualcomm_5g_ran_platforms_product_brief.pdf
> 
> [...]

Applied, thanks!

[2/5] dt-bindings: clock: Add RPMHCC bindings for QDU1000 and QRU1000
      commit: 70d9f589918aaadd6d5547ecb27355b7b69fc32c
[4/5] clk: qcom: Add support for QDU1000 and QRU1000 RPMh clocks
      commit: 05e5c125b120c75b9313af0a6dc8c4f5a71e8e7c

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
