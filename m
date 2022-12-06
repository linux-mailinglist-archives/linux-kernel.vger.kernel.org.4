Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556B0644B6D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 19:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbiLFSVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 13:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiLFSUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 13:20:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC713E09A;
        Tue,  6 Dec 2022 10:20:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6F988B819F3;
        Tue,  6 Dec 2022 18:20:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C1C5C433D7;
        Tue,  6 Dec 2022 18:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670350803;
        bh=U7vGlhITEbQd4WX+9fQAHXCsBIf8zJHHXiMf11kTcC8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VvWy+kuxp1zIz0I7sFygPAmKy5j5Z5XkxBWQnvNgqFWKcaQjPQ8oXKiVx5TdrDnnf
         SuJ6h5+q0YRZ3BBQHpWLIb79P4H0K/9+LsKExyh/SzBkjVW4z+QDmtS6RpVFNO2zcl
         gjKnFrrO2HaLuSefBMxFwOUvPfqNXm6uGibrHvHFoHS3yR6Dc2fzL1WWQs35SGlj5Y
         rLpO9NfBXmf10dDQZy4gdub7rt9xu7Ytp+GrVc/JE1IJZqxXnkVJ2bCUrxZfNeoKUm
         E9869E4xmiK/VZTv7Dzn1LrIqg4vmzEY5a9r7md2QcfNmLBgipliZ93O/gVSHitZ6u
         ZbbU+tB6oKZjg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        konrad.dybcio@linaro.org, krzysztof.kozlowski@linaro.org
Cc:     robh+dt@kernel.org, linux-mmc@vger.kernel.org,
        bhupesh.sharma@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        ulf.hansson@linaro.org, patches@linaro.org
Subject: Re: (subset) [PATCH v2 1/4] dt-bindings: mmc: sdhci-msm: Document SM8350 SDHCI
Date:   Tue,  6 Dec 2022 12:19:07 -0600
Message-Id: <167035076338.3155086.11697985301746793469.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221116123612.34302-1-konrad.dybcio@linaro.org>
References: <20221116123612.34302-1-konrad.dybcio@linaro.org>
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

On Wed, 16 Nov 2022 13:36:09 +0100, Konrad Dybcio wrote:
> Document the SDHCI on SM8350.
> 
> 

Applied, thanks!

[2/4] arm64: dts: qcom: sm8350: Add SDHCI2
      commit: 60477435e4de3375775c3a0c0d21467f2ae7c398
[3/4] arm64: dts: qcom: sm8350-sagami: Add GPIO line names for TLMM
      commit: dcbb6fe5d669f1832ad6a0781d9d52d728c8cf60
[4/4] arm64: dts: qcom: sm8350-sagami: Wire up SDHCI2
      commit: 1aaa0772741820e2d15e0b1e109d776acb63d52a

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
