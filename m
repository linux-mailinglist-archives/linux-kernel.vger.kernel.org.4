Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5DD72F0A7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 01:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233025AbjFMXrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 19:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240820AbjFMXrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 19:47:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27CDD2D45;
        Tue, 13 Jun 2023 16:46:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C3836353D;
        Tue, 13 Jun 2023 23:45:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0AB9C433CC;
        Tue, 13 Jun 2023 23:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686699938;
        bh=qesurF4toa3MGEAJJCumXKvdmGx/hbsiVL5/FEtac7Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CgnBTgOnvG+2gOjPC2oBWX+HjSinI+03orQ5/AifJjsgRC37AvN+dFn4Z56a3xftm
         I+7yo5rHk6EHZaNagEDXuvrQ0ljCFAFS49o6OIRPMrWxe7X2Q+JthuXOIWgzK92HT0
         n4CDzckTlJJdCX8NqcnDBIOvMtuaBqYBOAw8W7oqJZUrFEMJme4gbzVx5e+3+ZbMXt
         Bp7UNGt7frhTWKUKLkcE2j5FtFfos9NunJupr7O16nbX7KWjr+ay7u9N2u6UbMIebS
         ENFoVf5nSRcjQr5yYN8VzrR4Z6SPYDiWW9EGcz0w509rhW85cCb1uBrQuEGJSPx4dy
         zqei5LH+Z/5CA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Andy Gross <agross@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Robert Marko <robimarko@gmail.com>
Cc:     Mantas Pucka <mantas@8devices.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: gcc-ipq6018: remove duplicate initializers
Date:   Tue, 13 Jun 2023 16:48:42 -0700
Message-Id: <168670013502.1400697.3131204181371880058.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230601213416.3373599-1-arnd@kernel.org>
References: <20230601213416.3373599-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Jun 2023 23:34:12 +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> A recent change added new initializers for .config_ctl_val and
> .config_ctl_hi_val but left the old values in place:
> 
> drivers/clk/qcom/gcc-ipq6018.c:4155:27: error: initialized field overwritten [-Werror=override-init]
>  4155 |         .config_ctl_val = 0x240d4828,
>       |                           ^~~~~~~~~~
> drivers/clk/qcom/gcc-ipq6018.c:4156:30: error: initialized field overwritten [-Werror=override-init]
>  4156 |         .config_ctl_hi_val = 0x6,
>       |                              ^~~
> 
> [...]

Applied, thanks!

[1/1] clk: qcom: gcc-ipq6018: remove duplicate initializers
      commit: 5ae7899765607e97e5eb34486336898c8d9ec654

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
