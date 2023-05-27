Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF536713256
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 05:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbjE0D5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 23:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjE0D46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 23:56:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1AA116;
        Fri, 26 May 2023 20:56:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D5CC64FF1;
        Sat, 27 May 2023 03:56:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4075C433D2;
        Sat, 27 May 2023 03:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685159813;
        bh=ZD7Ij+Drs1pqMm30ZIHkyCeAKzFLEQBg9YtscwC86Sg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rBBMkQcvApk99FYiqc4zhW0EC+VurFT2Cr9fUuQTjLr1mYTVQQbV5YY1lHk7rgXhS
         9LdHc8xZHImLpYCaohbVk5T8SCvOYZhG7Zlpp7CaSYtQF5nEyFB///nLG2HmFMTPTl
         Pl1inO2qXz5vMsDS8M2MX1owRqE0CI8zp+65ErtkwtcMP8OkOg8LyS7iS5GdRaAhxd
         ToISuSscUwaA3F7YLR386jeFcIdHpwVlrcczeXhMvu5QG4gvSDt2A3319CRR9jjmpo
         F+eyL5zMIsasQITX+0iWTJxkP7Gw0Sc+O6PmFFvNYmrpDfO1cDYUINFh1krHjNOsKb
         mRNg19EprQX9Q==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 0/4] SM8450 GPUCC
Date:   Fri, 26 May 2023 21:00:35 -0700
Message-Id: <168516003598.405989.9713462057366695068.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230517-topic-waipio-gpucc-v1-0-4f40e282af1d@linaro.org>
References: <20230517-topic-waipio-gpucc-v1-0-4f40e282af1d@linaro.org>
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

On Wed, 17 May 2023 18:40:37 +0200, Konrad Dybcio wrote:
> Introduce hardware clock control to ultimately avoid spurious rcg
> (re)configurations and introduce GPUCC for SM8450.
> 
> 

Applied, thanks!

[2/4] clk: qcom: rcg2: Make hw_clk_ctrl toggleable
      commit: a0e0ec7424c99a0459b44fbf0459de9728be37ab
[3/4] clk: qcom: gcc-sm8450: Enable hw_clk_ctrl
      commit: d4113d5f2bc9b58d3243df0edd2c42247181dbdd
[4/4] clk: qcom: Add support for SM8450 GPUCC
      commit: 728692d49edce3cdc77be92f3c79a6c56f81e531

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
