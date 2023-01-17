Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E29366E6DF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 20:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235071AbjAQTU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 14:20:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbjAQTKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 14:10:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39EA5C0E9;
        Tue, 17 Jan 2023 10:24:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 62BEDB81911;
        Tue, 17 Jan 2023 18:24:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CBBFC433F2;
        Tue, 17 Jan 2023 18:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673979883;
        bh=U6fq5B2JbdwO5+OYrbxTG82r1p9vuv0+mUbcRc539Vs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R5NBX3si5Q8LCcOZgJTnFeq+bE9ln5W7BwWi9hClf1Dpnj8+5dr2TDwQLzdOPep7J
         M0Xgr6GdpsBY3VzRqhP1pMOGdcKGoMxYHSzSMxcFbbmB2AdHfgR40ipVZ7HfeUIhRY
         Mc60y6dHP+BtjtwesKQgrZrYXhQEz9x1CW7G5zqQ6Jt+m5cWB9jcPCy0Gbds9akg2K
         C+t9o2bCHCwru3yMrtAYp0kFEw+5rLXGpEnRr3mV27x2GO3VLr//4E6QdscWeVoHQz
         TS1zm38lUPbeWsF4KFDmSjVFFmDq6ksWD4SY5y+Ey30sp14TMcZWGwk7f5A5x4X3OA
         aiU5N/AIl7RRQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     sboyd@kernel.org, abel.vesa@linaro.org, quic_bjorande@quicinc.com,
        mturquette@baylibre.com, konrad.dybcio@linaro.org
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: Remove need for clk_ignore_unused on sc8280xp
Date:   Tue, 17 Jan 2023 12:24:28 -0600
Message-Id: <167397986250.2832389.6462286285599201032.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230113041038.4188995-1-quic_bjorande@quicinc.com>
References: <20230113041038.4188995-1-quic_bjorande@quicinc.com>
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

On Thu, 12 Jan 2023 20:10:38 -0800, Bjorn Andersson wrote:
> With the transition of disabling unused clocks at sync_state, rather
> than late_initcall() it's now possible to drop clk_ignore_unused and
> unused clock disabled once client drivers have probed. Do this on
> SC8280XP.
> 
> 

Applied, thanks!

[1/1] clk: qcom: Remove need for clk_ignore_unused on sc8280xp
      commit: 29e31415e14e16e25d428205c7230400dea1d7cf

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
