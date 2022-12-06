Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCBB644B27
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 19:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiLFSUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 13:20:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiLFSTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 13:19:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEECCBC01;
        Tue,  6 Dec 2022 10:19:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8AE2A616D1;
        Tue,  6 Dec 2022 18:19:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86569C43148;
        Tue,  6 Dec 2022 18:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670350776;
        bh=vp3u2kK0/7F8GtdK2zs9luaR9cLHJYrVON7RUyvS9Do=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ps5FPSFf+iiTuyMwigruW8E7wscNvyIRygH2PdnD8CzW+wSdD1nCkUEa0JLGdbnJC
         qvirbrJSY0s2x9sUf+fjp5tOigO4d/tmA33dm7xuYc8K0HfSpzf2NIdZQC0OR884DF
         hjALNX91q2lRqjGJ1CPkFiQD1qs6WX9zcQ5JchQFxZEcKA13slnReDuJJO8Ec7ZRHO
         ++Ap6ohlZ8B38OjrRgWX7Xdxil4EK8kEZni6kPjn8rd/+5gUDx/shUh9aMcAt+75rn
         ZHszeMzX2aZxY/4uru2g8I+9ECVuydbt4xQYq1n5PqT5Rc1ImGVisoHT/tF36VC+y/
         KEuBCj7fPIX0w==
From:   Bjorn Andersson <andersson@kernel.org>
To:     abel.vesa@linaro.org, Andy Gross <agross@kernel.org>,
        konrad.dybcio@linaro.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: (subset) [PATCH 1/2] soc: qcom: rpmh-rsc: Add support for RSC v3 register offsets
Date:   Tue,  6 Dec 2022 12:18:42 -0600
Message-Id: <167035076337.3155086.15698556772034321260.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221116112246.2640648-1-abel.vesa@linaro.org>
References: <20221116112246.2640648-1-abel.vesa@linaro.org>
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

On Wed, 16 Nov 2022 13:22:45 +0200, Abel Vesa wrote:
> The SM8550 RSC has a new set of register offsets due to its version bump.
> So read the version from HW and use the proper register offsets based on
> that.
> 
> 

Applied, thanks!

[1/2] soc: qcom: rpmh-rsc: Add support for RSC v3 register offsets
      commit: 40482e4f73640dcf7bebcb503f034828b998c39c
[2/2] soc: qcom: rpmh-rsc: Avoid unnecessary checks on irq-done response
      commit: 323dc2dcdb503323097855174908b52d84477760

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
