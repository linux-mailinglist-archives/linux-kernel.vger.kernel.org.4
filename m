Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83CD5645E27
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 16:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiLGPyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 10:54:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiLGPyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 10:54:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6673C6E3;
        Wed,  7 Dec 2022 07:54:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7121961A9F;
        Wed,  7 Dec 2022 15:54:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A25C433B5;
        Wed,  7 Dec 2022 15:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670428445;
        bh=rj/mVJVWuy/34su8OwO33Cp8pq0OuQeJZ7/9ytPZOrU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WDq1AH3lbomsINjS3GguVdS/h5Td6uLaXw67R43MIP2MiTWHIQpXFUAjQYKlgaqSB
         U10nuK/kzxO/SrwmdHYmXYgiUiivy+5slNpmmTvTsukJbCByKZEhczpRMSkEHB63if
         pjj4UItKYeQfng5a+GTYltxJGey1Y+6HYJt1FjqaI4v+dzeJJP8uP0VumvEZFSz6DB
         Z1UoqBY9LmLkcwqic3ILXV51P9I+OasS0AS+XGFoXkMuQYNKR8p8WKqCN90OP2cwfR
         BlW5OtYTolhLb7yPJvxo33Tens6dy5FG6DGmM+kOKGP72lGfJQSiNNHRr16GI5U0wu
         /+FM0xXxtsbjA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     mturquette@baylibre.com, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        agross@kernel.org, robert.marko@sartura.hr,
        linux-arm-msm@vger.kernel.org, sboyd@kernel.org
Cc:     luka.perkov@sartura.hr
Subject: Re: [PATCH] clk: qcom: gcc-ipq4019: switch to devm_clk_notifier_register
Date:   Wed,  7 Dec 2022 09:54:02 -0600
Message-Id: <167042843840.3235558.6811850896669798460.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221205113545.575702-1-robert.marko@sartura.hr>
References: <20221205113545.575702-1-robert.marko@sartura.hr>
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

On Mon, 5 Dec 2022 12:35:45 +0100, Robert Marko wrote:
> Switch to using devres-managed version of clk_notifier_register(). This
> allows us to drop driver's remove() callback.
> 
> 

Applied, thanks!

[1/1] clk: qcom: gcc-ipq4019: switch to devm_clk_notifier_register
      commit: 52fb1b8e481b423afbb34259be964494ba5b8614

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
