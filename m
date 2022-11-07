Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C3061E954
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 04:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbiKGDOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 22:14:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbiKGDOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 22:14:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B77810045;
        Sun,  6 Nov 2022 19:13:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AB937B80D94;
        Mon,  7 Nov 2022 03:13:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C582FC43141;
        Mon,  7 Nov 2022 03:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667790788;
        bh=43OMBDPdLjd/l8543w5DP1nXrhojIwplzo6gqb/MlUw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QN062wLdw6E3shU2kXMli+nSD5sqmSp9FltAXA99ylNJQFhdnQrIDi2MiSfjoyXpK
         792x6v4XyEcpSoKpnhnsMRdfpuJfYpWEW7fAUlAnWZ/9wyQlxSql/8+bIQwOSshPpx
         y/hMBZiRpWZo3b9vJOnlpTRUmM70zy9a7QjqX6C25+L5fQR8FIevC85v8exQz8vBx8
         +jmAM2Rcq68/S4K0/M+CYxCc6nKqLMPykKtTmiC4FcbNUMC+dgaeX/Kl4NSkgTwoJN
         yvHjR93bjgKAwc+uOijm840wopiOykMp2zGYuEass3G4S+oCUhrHv/ATknQSqqIiim
         gU6s8JngqU+CA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     mturquette@baylibre.com, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, konrad.dybcio@somainline.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org
Subject: Re: [PATCH v2] clk: qcom: gcc-sm8250: Use retention mode for USB GDSCs
Date:   Sun,  6 Nov 2022 21:12:26 -0600
Message-Id: <166779074272.500303.12843032172428817016.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221102091320.66007-1-manivannan.sadhasivam@linaro.org>
References: <20221102091320.66007-1-manivannan.sadhasivam@linaro.org>
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

On Wed, 2 Nov 2022 14:43:20 +0530, Manivannan Sadhasivam wrote:
> USB controllers on SM8250 doesn't work after coming back from suspend.
> This can be fixed by keeping the USB GDSCs in retention mode so that
> hardware can keep them ON and put into rentention mode once the parent
> domain goes to a low power state.
> 
> 

Applied, thanks!

[1/1] clk: qcom: gcc-sm8250: Use retention mode for USB GDSCs
      commit: ac1c5a03d3772b1db25e8092f771aa33f6ae2f7e

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
