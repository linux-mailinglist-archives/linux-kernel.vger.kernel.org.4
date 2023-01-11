Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70EC2666413
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 20:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239204AbjAKTt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 14:49:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235509AbjAKTtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 14:49:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81869E0A8;
        Wed, 11 Jan 2023 11:49:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 25F44B81CCE;
        Wed, 11 Jan 2023 19:49:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15DB4C433F1;
        Wed, 11 Jan 2023 19:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673466553;
        bh=8ITmzr3alPpJcS3hQWDTSyLjBdW7Kev5u5x5E2Dt4Kk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rsrqQnZP29tJIFlVCu4cLzVm6czdxfDfHMybhghkm6d1d9ELhvx3mnynzaYJcNhXC
         gofgsouzuH9WwAeUqcyt16tnKji6ufjQ7A74276LR8H5S1BopZ437QAwSj8mP8BS+V
         a3NJ30kc33uGMFwgHmOrY1jBsUI4clDAmr3jukfkAtKHNU2QONPD5vG1WhLOwohxBr
         snSWhtI45en89ELaLkS8NmTHGrlm47C4pkvmn20beK1njeeZFzHZbiQm3b43Qa4bbV
         la8hl8bWjaGIcep0Bo6wcEJyS27X4b+zNYSuLQZjPwSNVHbklqwL9NoaO93KefJJIr
         j/ptxRk7AawNw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, krzysztof.kozlowski@linaro.org,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, marijn.suijten@somainline.org,
        sboyd@kernel.org, lkp@intel.com, linux-clk@vger.kernel.org,
        mturquette@baylibre.com
Subject: Re: [PATCH] clk: qcom: camcc-sm6350: Make camcc_sm6350_hws static
Date:   Wed, 11 Jan 2023 13:49:03 -0600
Message-Id: <167346654443.2315924.16045077859789889895.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230107120434.1902666-1-konrad.dybcio@linaro.org>
References: <20230107120434.1902666-1-konrad.dybcio@linaro.org>
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

On Sat, 7 Jan 2023 13:04:34 +0100, Konrad Dybcio wrote:
> There's no reason for it not to be static, and some compilers don't
> like not it being that way. Make it so.
> 
> 

Applied, thanks!

[1/1] clk: qcom: camcc-sm6350: Make camcc_sm6350_hws static
      commit: bfc7486991c2b1b514cee90854af0f90c56b6bf2

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
