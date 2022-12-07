Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B400645E25
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 16:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiLGPyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 10:54:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiLGPyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 10:54:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F384F37FAB;
        Wed,  7 Dec 2022 07:54:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89EF561AB3;
        Wed,  7 Dec 2022 15:54:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E9B4C43470;
        Wed,  7 Dec 2022 15:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670428445;
        bh=dpegcJetVmPR8kfhG7zDHO4Oy5WbLJ0Vt5BYB4Zi7JI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kYWA6Da+uVFd9fc5tu8B3mX9pqYeqtR1r6/6Uttt8DChEFjJk2JRJvjzHaKWv+glw
         /VUU+CUyajttnW1lfdSMOUAeWbhkXvHyX3q21Lb+JggVBqR/T1hfSiJ3jjfxHe2Oxa
         FVSoBfiONyadYsu/Tlwtl7cxwJpFw+DAVQ7sdB5OErFuHxP4fFA9KC3enJ2lWml11B
         X6a218zUM3BymfgcfDXdyGNrvhO9xk31g8VGwKxgelfnZSx41EIGdxWhO11SxjwEM1
         +jvUK+q4ZO1at7Dp4BsIkcYjqKcVNEGJFvJoFv0Wb3IXgYDqMSvBskVpzaFhH0Q+9I
         R33AEOz4FJoKg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     mturquette@baylibre.com, konrad.dybcio@linaro.org,
        elder@linaro.org, agross@kernel.org, sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org, luca.weiss@fairphone.com,
        linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dmitry.baryshkov@linaro.org
Subject: Re: [PATCH v2] clk: qcom: rpmh: add support for SM6350 rpmh IPA clock
Date:   Wed,  7 Dec 2022 09:54:01 -0600
Message-Id: <167042843841.3235558.7789152011725626423.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221202221240.225720-1-elder@linaro.org>
References: <20221202221240.225720-1-elder@linaro.org>
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

On Fri, 2 Dec 2022 16:12:40 -0600, Alex Elder wrote:
> From: Luca Weiss <luca.weiss@fairphone.com>
> 
> The IPA core clock is required for SM6350.  Define it.
> 
> [elder@linaro.org: rebased with Dmitry's changes]
> 
> 
> [...]

Applied, thanks!

[1/1] clk: qcom: rpmh: add support for SM6350 rpmh IPA clock
      commit: 2931aa6758da9f871b4bd7ee52a4be2f9d24e6ce

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
