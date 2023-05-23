Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0526C70D20B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 05:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234998AbjEWDAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 23:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232405AbjEWC7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 22:59:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83408E9;
        Mon, 22 May 2023 19:59:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1AB4C62E5F;
        Tue, 23 May 2023 02:59:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA0EAC4339C;
        Tue, 23 May 2023 02:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684810774;
        bh=SDkfp6VA76pSE8GN7P0ZvirYvZu7rNDpt/npDmum0C8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Bkk/LhLVjIbIYLYxSykQe0XlQCmim0PQIRJwa6IHQZyVBb3CxcjIIsNbrI9adrorm
         GHMHz8IqcNeMJt47xM82x4udQHZio8p6ItfOYPD9ltBFX9+izs6t1Aop0G5a86FYtm
         ktbyimAGU0tiAGfynLhrddDtMWLS5T0d77PVOUFWVs4v+GeyHl+elbxtqrq8T6myLe
         UGj8MIvOfmKYDnwhGpQAqfx//fTpuULeMsTUPpGsllHT83YwnJ38N1RhuNejSrXaex
         zbNPdfYA00gTGpX5wzwJ7g6HOOVzODdxPE1GLgnroEQe5gsMsbAxwOLD0NMSseuzAT
         qzFHGBqaAO1DQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-kernel@vger.kernel.org, cros-qcom-dts-watchers@chromium.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: (subset) [PATCH 1/4] arm64: dts: qcom: fix indentation
Date:   Mon, 22 May 2023 20:03:22 -0700
Message-Id: <168481094821.1229550.1275743345232450083.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230416101134.95686-1-krzysztof.kozlowski@linaro.org>
References: <20230416101134.95686-1-krzysztof.kozlowski@linaro.org>
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

On Sun, 16 Apr 2023 12:11:31 +0200, Krzysztof Kozlowski wrote:
> Correct indentation to use only tabs.
> 
> 

Applied, thanks!

[4/4] ARM: dts: qcom: add missing cache properties
      commit: 925a80af6106a55fa6bcfedc5bd2f02b0b835495

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
