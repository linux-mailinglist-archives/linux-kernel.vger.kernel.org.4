Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB366663B1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 20:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjAKTYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 14:24:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235754AbjAKTWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 14:22:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06314165BC;
        Wed, 11 Jan 2023 11:22:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AE21FB81C9B;
        Wed, 11 Jan 2023 19:22:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56D03C433D2;
        Wed, 11 Jan 2023 19:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673464971;
        bh=ulKnHePlZIIKpjGhHaXcplBfyOZotqgtqsB8/R2g2WQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Z1w7JAfxEziErs6Al83JLGVAhf03iptoZ3N9HoMdp7zna+XO2o+yfaU5w9bQGJjjR
         BRNcTSAissFb5Xh8tVtvwdHd8FQkdP70aqBYwEnoY7Mxje5bEm7zYuXvpph7o6dOb8
         H/6AZxrg+UZFhgkwbEstxhbuR6TaBIjfe/AcCWS7B4DaDwT6rmD6sMLjq9d7k8XG1W
         oaUbm8912kxJI9+6+WjJyeWoNxHCC5s5TlGmngZpjfu7QTcG2b2Ma17B1tIqBkVb8C
         cmKdkMVFimX4TCjIvowvNS4Vj+OpbMfoi1+i6lhsExeVwsz+3PFx9wCJHXVBjP5Sy6
         O7H7/WRAiDk1w==
Message-ID: <6c2ea85f665a2c23d647f23a5c6be52a.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230107120434.1902666-1-konrad.dybcio@linaro.org>
References: <20230107120434.1902666-1-konrad.dybcio@linaro.org>
Subject: Re: [PATCH] clk: qcom: camcc-sm6350: Make camcc_sm6350_hws static
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        kernel test robot <lkp@intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, agross@kernel.org,
        andersson@kernel.org, krzysztof.kozlowski@linaro.org,
        linux-arm-msm@vger.kernel.org
Date:   Wed, 11 Jan 2023 11:22:49 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Konrad Dybcio (2023-01-07 04:04:34)
> There's no reason for it not to be static, and some compilers don't
> like not it being that way. Make it so.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: 80f5451d9a7c ("clk: qcom: Add camera clock controller driver for S=
M6350")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
