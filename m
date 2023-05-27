Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15111713126
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 03:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjE0BDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 21:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237933AbjE0BDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 21:03:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3D7135;
        Fri, 26 May 2023 18:03:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48402654C2;
        Sat, 27 May 2023 01:03:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2F2EC4339C;
        Sat, 27 May 2023 01:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685149428;
        bh=qvIBLBAiQzYBgrR/tWLgLwTNLeFZWE7PV7vdWgOl7qk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UAcrGnZX5Cx4qK3F/1NxooifYBL71T+kJIOfrHkebWI8tznhUnamGi4dgALoj2TgN
         ZRs1LRWHnlHSwBw3A7/vG6cBUWq3pGTwi7QjUaAjHj3wSv/pNPuAu9723w96m9CTtT
         R7YVyqttdJvWNY2vkuROXgBBSm2kMAZl3gvxfZ7OkUI7xHIDJBa+8JvuvtIjrVEWcb
         Q1wGyVsruAHmcajgj8Fepp2HEdS0Llu1aPA8swRDii8k0RhiJGMP9CDVXtkjWDRXWF
         izeZ8zlydTBRZNAg7gOPGiv5zWSsTbGG/GlPIU7ONg8tbSEduf9bIFj+2JiqaiJNbI
         b414U8vmI3TAQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>
Subject: Re: [PATCH v2 0/2] QCM2290 dispcc fixups
Date:   Fri, 26 May 2023 18:07:23 -0700
Message-Id: <168514964950.348612.6270759305773857512.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230412-topic-qcm_dispcc-v2-0-bce7dd512fe4@linaro.org>
References: <20230412-topic-qcm_dispcc-v2-0-bce7dd512fe4@linaro.org>
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

On Fri, 14 Apr 2023 13:06:34 +0200, Konrad Dybcio wrote:
> v1 -> v2:
> - Drop the merged "remove inexistent dsi1phy clk"
> - Reword the commit messages to hopefully make them clearer
> 
> Rebased on qcom/for-next (see base-commit) for ease of merging
> 
> v1: https://lore.kernel.org/r/20230412-topic-qcm_dispcc-v1-0-bf2989a75ae4@linaro.org
> 
> [...]

Applied, thanks!

[1/2] clk: qcom: dispcc-qcm2290: Fix BI_TCXO_AO handling
      commit: 92dfee0fc889b5b00ffb6b1de87ce64c483bcb7b
[2/2] clk: qcom: dispcc-qcm2290: Fix GPLL0_OUT_DIV handling
      commit: 63d56adf04b5795e54440dc5b7afddecb2966863

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
