Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE292640FB0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 21:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234431AbiLBU7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 15:59:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234218AbiLBU7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 15:59:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C9EEBC91;
        Fri,  2 Dec 2022 12:59:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2B60CB8229D;
        Fri,  2 Dec 2022 20:59:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 146C6C4314A;
        Fri,  2 Dec 2022 20:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670014743;
        bh=Sux5cf4T7Np+/5t6fDdjcUbSLLRu3dj+HENpPuV94zA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=occw9aMmoNGq8/fU0bXvuIbDGDSWS4XCrQDn3QGG4x97EW5hpCrqnr98oWYu+/0jc
         iDDy6JrIyzCBxpCjBHzoNn5Ii9H0bSrUrJiOww+sEngMfXudrv1u8V4n53MkdFjuFC
         fMvXyU+rItFURqcElnorRSBJGpKk89H3H6dqkIbsARHmzYyxmggufZhXckjK2Y+qQn
         WB4XI5aQNjS4ovU67i/FiBvjp7CBWi5h8dhwkpzagaxtiW0z+lpp43CEUJkXwVw+SG
         +CZ9JcEHit94DkjVMi/TT9gmxNOPxUodkPr7vpuK5BJlYp+ZFqhMF0smvKR4PdfYCy
         d2es019zfKyVg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linmengbo0689@protonmail.com, linux-clk@vger.kernel.org
Cc:     nikita@trvn.ru, konrad.dybcio@somainline.org, sboyd@kernel.org,
        "open list:QUALCOMM CLOCK DRIVERS" <linux-arm-msm@vger.kernel.org>,
        stephan@gerhold.net, agross@kernel.org, mturquette@baylibre.com,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clk: qcom: gcc-msm8939: Add rates to the GP clocks
Date:   Fri,  2 Dec 2022 14:58:49 -0600
Message-Id: <167001472429.2721945.13570948550126937765.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221117171343.24216-1-linmengbo0689@protonmail.com>
References: <20221117171343.24216-1-linmengbo0689@protonmail.com>
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

On Thu, 17 Nov 2022 17:15:26 +0000, Lin, Meng-Bo wrote:
> Similar to msm8916, msm8939 has (at least) 6 "General Purpose" clocks that
> can be muxed to SoC pins. These clocks are:
> 
> GP_CLK{0, 1} : GPIO_{31, 32} (Belongs to CAMSS according to Linux)
> GP_CLK_{1-3}{A, B} : GPIO_{49-51, 97, 12, 13} (Belongs to GCC itself)
> GP_MN : GPIO_110 (Doesn't seem to be described in gcc,
>     ignored in this patch)
> 
> [...]

Applied, thanks!

[1/1] clk: qcom: gcc-msm8939: Add rates to the GP clocks
      commit: a9b6703459b1317354ae5da28acb5be918c16262

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
