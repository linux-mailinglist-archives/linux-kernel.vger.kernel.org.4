Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30FD574CBA5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 07:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjGJFFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 01:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbjGJFE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 01:04:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82A7E50;
        Sun,  9 Jul 2023 22:04:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D49460DF3;
        Mon, 10 Jul 2023 05:04:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B243C433CA;
        Mon, 10 Jul 2023 05:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688965474;
        bh=4QW5Pspd9XzCJVbs3KRgrFvk3XDwLainaklLXJebkME=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NcRpfU7JubPtxocdu6a6+2i0OJDf4aJquVn2rHjxh/o5gQOwKynVUN5llQtZHV1Cu
         hGuFgfTGBJeeCkvyJl/cOu1HgOsulwFA8AscJbFVLcQehOR5wy/XPdlvJ7yC8QbZQg
         N1fmDalAQRcpYOWMceAwtbPWKDGmMY4xOZnP43BQCWtJ/n9KD4avPPQC93N3/SmVdn
         Yr9pRjgUSAeWUhEy2It7ue4rLbiZu5MhTZLVWXOOYq0XC0Y0NNPqUgno7mJSzWETYb
         iiBl5T0gMkeK5vOSbeiiVm9Ix59Fn5dlROjXygSbF0ezbqSwfJFaw8q5TCIaYZ1cjM
         LQrvXEWlho0/w==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Robert Foss <rfoss@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] SM8350 CPU-adjacent fixes
Date:   Sun,  9 Jul 2023 22:07:14 -0700
Message-ID: <168896565988.1376307.1532849453927343435.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705-topic-sm8350_fixes-v1-0-0f69f70ccb6a@linaro.org>
References: <20230705-topic-sm8350_fixes-v1-0-0f69f70ccb6a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 05 Jul 2023 15:36:20 +0200, Konrad Dybcio wrote:
> I noticed there are some holes in the cpuidle and cpufreq on SM8350.
> This series attempts to fix that.
> 
> 

Applied, thanks!

[1/3] arm64: dts: qcom: sm8350: Add missing cluster sleep state
      commit: 29a687c219e20fd4c6e8c47d214365f0d34e3d3d
[2/3] arm64: dts: qcom: sm8350: Fix CPU idle state residency times
      commit: 91ce3693e2fb685f31d39605a5ad1fbd940804da
[3/3] arm64: dts: qcom: sm8350: Add missing LMH interrupts to cpufreq
      commit: 951151c2bb548e0f6b2c40ab4c48675f5342c914

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
