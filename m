Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFD05EFB34
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 18:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235928AbiI2Qpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 12:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235901AbiI2Qpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 12:45:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6131176D3;
        Thu, 29 Sep 2022 09:45:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 55A59B8255A;
        Thu, 29 Sep 2022 16:45:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61BCEC433D6;
        Thu, 29 Sep 2022 16:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664469938;
        bh=xfXH9howLkQouPcZg71dW+3U4N+GgMwRp5qnA7Husp4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o/z1yOhvk5jPMyMKVymYRjRRy3vfpS4pmCNsh5dxHPsYVuKWybGAbKjTAaHBUHzJX
         eIIXK5Xsncez/V3DgCJ0HVTn8u/aCDdfzV3MmUdPfsL48wH0B8wvV9/FVs/2KXS5mp
         5cM/lNviDO/LAMVl6GoPweMmp2dJCkEaxrcn7onDZNrm2b4O08ZN589l1MlCQdNOa7
         0ChrLKXI7LJct7yE6IccQBsPm7m6DRR8KXsEfChnjumdBeTDDc2R/XhCkNdLtIQiOl
         UjFGzxsAyeI019kX1k2512WIPII5jKQknBd+7Ks06zIQUqtJZdqz9DZyz5+bvqA5wk
         nF0jvjnFPCAKA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     johan+linaro@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, agross@kernel.org,
        mturquette@baylibre.com, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, sboyd@kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: gdsc: add missing error handling
Date:   Thu, 29 Sep 2022 11:45:33 -0500
Message-Id: <166446992872.1979534.15976759847957977086.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220929155816.17425-1-johan+linaro@kernel.org>
References: <20220929155816.17425-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Sep 2022 17:58:16 +0200, Johan Hovold wrote:
> Since commit 7eb231c337e0 ("PM / Domains: Convert pm_genpd_init() to
> return an error code") pm_genpd_init() can return an error which the
> caller must handle.
> 
> The current error handling was also incomplete as the runtime PM and
> regulator use counts were not balanced in all error paths.
> 
> [...]

Applied, thanks!

[1/1] clk: qcom: gdsc: add missing error handling
      commit: eab4c1ebdd657957bf7ae66ffb8849b462db78b3

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
