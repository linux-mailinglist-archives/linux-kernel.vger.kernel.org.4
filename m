Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D28566E6B5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 20:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234233AbjAQTO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 14:14:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjAQTKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 14:10:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96B737B43;
        Tue, 17 Jan 2023 10:24:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 97F45B819A4;
        Tue, 17 Jan 2023 18:24:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C2BC433F2;
        Tue, 17 Jan 2023 18:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673979873;
        bh=pskJ3uX+LHEl7Doh3ts6Cez0nMy+11Ih/96iWG627u8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UjPt6GiEYir3hQn9bt6Bad+zjMU5PYyWwQqQZB+U5XuCfg533+PtPKAaTzbuk9QFj
         jjS7Vo8nQAgsEi3P9J13XT/ZDQbu5xCsJ1dO+B4UFBgpOlIfnxUo1pg5THKjJ5CeNK
         fpY/TS702MIySg1bCMCJIfvq9fAnzM8ll1Sx9CIEBHpQkKRI9YYkhRlVof+r/3h3Nd
         JJ9icl+JKkNEqujQY8aNwb1BgLM0XsctlkUYoxUWXYWgEgm5ZPr2vEns3GQ4jdfKRg
         SGHeBmre1uhqEbtN/Qdx+BKmRtcxbAljFtRpfN5mqaGvUSp51Ce88C1dLnD8M6gsZF
         hHpvu+YT/xDaQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     sboyd@kernel.org, dmitry.baryshkov@linaro.org,
        mturquette@baylibre.com, arnd@kernel.org, agross@kernel.org,
        konrad.dybcio@linaro.org
Cc:     mailingradian@gmail.com, abel.vesa@linaro.org,
        linux-arm-msm@vger.kernel.org, elder@linaro.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] clk: qcom: rpmh: remove duplicate IPA clock reference
Date:   Tue, 17 Jan 2023 12:24:18 -0600
Message-Id: <167397986261.2832389.8806893653582603859.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230117170217.2462320-1-arnd@kernel.org>
References: <20230117170217.2462320-1-arnd@kernel.org>
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

On Tue, 17 Jan 2023 18:02:09 +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> One of the ones that were recently added was already there:
> 
> drivers/clk/qcom/clk-rpmh.c:578:35: error: initialized field overwritten [-Werror=override-init]
>   578 |         [RPMH_IPA_CLK]          = &clk_rpmh_ipa.hw,
> 
> [...]

Applied, thanks!

[1/1] clk: qcom: rpmh: remove duplicate IPA clock reference
      commit: 19aeacf505a08ae8fc1e087f9d85b7caf29b09b4

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
