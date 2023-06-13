Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03CEF72F0B7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 01:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242072AbjFMXtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 19:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241444AbjFMXrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 19:47:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8E11BFD;
        Tue, 13 Jun 2023 16:46:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BFD763C79;
        Tue, 13 Jun 2023 23:45:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B892C433C0;
        Tue, 13 Jun 2023 23:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686699945;
        bh=ZseuDVtPZx7qTmwgoEv1ylF+KAXwdDILoO8Fkiiir48=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hMtMwLBKBd8hCMUxocPlj5dpt08WaA2jkrwhxAr0tT410C2+vhlxgsdsFx/Ypp4RS
         oKahyaRjKwvvNKRDOGd1ztaH1hXImOuIqbrwzV4xhqqEiPdV8Nn2dWYO/ZKzl1/Nn/
         TjbFUPi/pDHBG9WpmmXfClJ2NQu9T8lbfz0KrOWIal8qUsnP0YjI+VO3gaZvXRXIhA
         bdUSCAnAkC2OEAQs/dqduFYV1iyleImjON2cge1KJozjwwhnPAPeta8LrgO58vLJVh
         KSx3ki1jlY9htvGzTH1Xn1KLoLatb6KV67q9oRC2xKQJaIt7n8NMsxa/vAg+h/Idh/
         vdet5kNOszh+w==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Andy Gross <agross@kernel.org>,
        Iskren Chernev <me@iskren.info>,
        Stephen Boyd <sboyd@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Update parts of PLL_TEST_CTL(_U) if required
Date:   Tue, 13 Jun 2023 16:48:48 -0700
Message-Id: <168670013502.1400697.6968638068672657163.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230601-topic-alpha_ctl-v1-0-b6a932dfcf68@linaro.org>
References: <20230601-topic-alpha_ctl-v1-0-b6a932dfcf68@linaro.org>
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

On Thu, 01 Jun 2023 11:39:06 +0200, Konrad Dybcio wrote:
> Some recent-ish clock drivers touching on the "standard" Alpha PLLs
> have been specifying the values that should be written into the CTL
> registers as mask-value combos, but that wasn't always reflected
> properly (or at all). This series tries to fix that without affecitng
> the drivers that actually provide the full register values.
> 
> 
> [...]

Applied, thanks!

[1/2] clk: qcom: clk-alpha-pll: Add a way to update some bits of test_ctl(_hi)
      commit: 501624339466a7896bb8a1f048cf8dcfd54b174e
[2/2] clk: qcom: gcc-sm6115: Add missing PLL config properties
      commit: e88c533d8a2a0fe84bb54cff1569bd079ad3512c

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
