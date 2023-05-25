Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B261F710460
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233553AbjEYEw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjEYEvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:51:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1705FE4F;
        Wed, 24 May 2023 21:51:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3900B641E8;
        Thu, 25 May 2023 04:51:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0874FC433D2;
        Thu, 25 May 2023 04:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684990272;
        bh=gcA53NK32ooqyyg0Lpko9CS1Ktp0fJyED185TffeSuA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b0BiP28J1cSgJwlWpjPVfmWxqkpDzNSDzFMvQ7FD6HW9ckgMy2HMrw5UVwd8WfEeR
         qza/BegAIXbygEz8pRwrZp0FWTo8BmL58G7iyk0m28EyBBONiCOEaFSOkSCjKkNay/
         DrST2Ui3APIYc3/iUXFnoFeGIrreghnS5AAAsjAUj6caZKHgvTx1NQ222EGZaxrRPs
         bfCFfTUYVU8D17RwC71iOHDDjaQHvA0cPtYNYpst2yE61/hLpws6e/pkT0n2H3ZNCK
         u+2UF/DBaGAzaNQi61Wqp+zXr7CWFaelw2nc8vnY+yColTF2GhVZH5VXwWTo6QCKpP
         HV3F3Pclti6hA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>
Subject: Re: [PATCH 0/3] Mark RPMCC XO_A critical
Date:   Wed, 24 May 2023 21:53:52 -0700
Message-Id: <168499048179.3998961.16824160413373474016.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501-topic-rpmcc_xo_a-v1-0-93f18e47b607@linaro.org>
References: <20230501-topic-rpmcc_xo_a-v1-0-93f18e47b607@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 May 2023 14:57:10 +0200, Konrad Dybcio wrote:
> The Arm part is supposed to hold an permanent, active-only vote on the XO
> resource to prevent the RPM algorithms from deciding that its main clock
> source should be cut off.
> 
> Guarantee this by marking XO_A critical.
> 
> These patches are extracted from a broader series at Stephen's request:
> 
> [...]

Applied, thanks!

[1/3] clk: qcom: smd-rpm_ Make __DEFINE_CLK_SMD_RPM_BRANCH_PREFIX accept flags
      commit: 24abad60396865caf5ff8ccfa294894617456524
[2/3] clk: qcom: smd-rpm: Make DEFINE_CLK_SMD_RPM_BRANCH_A accept flags
      commit: 2dd117943f2339d8aba8b139f55edc5e07e1d359
[3/3] clk: qcom: smd-rpm: Make BI_TCXO_AO critical
      commit: ffd853c2ea3e39853f0bffc7364c73c12170c595

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
