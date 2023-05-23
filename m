Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A202570E5B0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 21:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238392AbjEWTge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 15:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233459AbjEWTgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 15:36:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309D4E42;
        Tue, 23 May 2023 12:36:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BBE9260BE9;
        Tue, 23 May 2023 19:36:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 718C4C4339E;
        Tue, 23 May 2023 19:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684870575;
        bh=YpLNa9GI5B0k97SFnyAPA6gdmqxiWuHNv94RrcTFvPs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZrpZ8ZRlbn+tUXbyGw5dPexoUoiSLkzUyVEorM6Ll35qLzs4BcuivRQLx56oUTjQx
         cDP1wlMiEtSu7Y8hWM4JQUhHtTKXllrdT/3O16pI7Vc2gdjTjmmbUrrrYzRaOtB37k
         aA0qT8JIOBAR+1hQvUVRB7Gmq2CmBF9Luc8+qr7ZmFqE1swmc5T7i2NUDjpJbBpT5A
         /MEj3W69/kNR8r51EACFiKQUnz86AYsH6rxro79CdCGwkAI1y6QURRIL/RNG4Nw1I5
         gGZxekiEoRB1/J5+mrIyF15S2J6uHHQSuah1QcX/GTly+Gv2RNoM1cpUchy2vntZYf
         NqFNnwatbbEHA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>
Subject: Re: [PATCH 0/5] QTI RB2 features
Date:   Tue, 23 May 2023 12:40:04 -0700
Message-Id: <168487080174.3522253.18438283481936566941.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230515-topic-rb2-bits-v1-0-a52d154a639d@linaro.org>
References: <20230515-topic-rb2-bits-v1-0-a52d154a639d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 May 2023 15:04:11 +0200, Konrad Dybcio wrote:
> This short series brings a couple of fixes and features
> (such as display out) for the QTI RB2 board. Similar patches
> for the RB1 should be expected soon.
> 
> Depends on and based atop (in order):
> 
> 20230505075354.1634547-1-bhupesh.sharma@linaro.org
> 20230502053534.1240553-1-bhupesh.sharma@linaro.org
> 20230505064039.1630025-1-bhupesh.sharma@linaro.org
> 
> [...]

Applied, thanks!

[1/5] arm64: dts: qcom: qrb4210-rb2: Describe fixed regulators
      commit: e130889286881e561a2904c5da44c3cbf5d5cd79
[2/5] arm64: dts: qcom: qrb4210-rb2: Enable display out
      commit: f7b01e07e89ced85975345b12cb63538ee07e91c
[3/5] arm64: dts: qcom: qrb4210-rb2: Add GPIO LEDs
      commit: fd888ed763415c31cf0ea7f044bd6cf429832f0e
[4/5] arm64: dts: qcom: qrb4210-rb2: Enable load setting on SDHCI VQMMC
      commit: 42be4edd8910a5f998a5bd993f42ea7112dd8f80
[5/5] arm64: dts: qcom: qrb4210-rb2: Enable CAN bus controller
      commit: 34a7cdf075410c30ca88c85627520dda74d3bd30

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
