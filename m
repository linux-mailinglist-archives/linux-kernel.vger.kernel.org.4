Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69030658586
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 19:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233524AbiL1SN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 13:13:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbiL1SNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 13:13:52 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D8417065;
        Wed, 28 Dec 2022 10:13:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 73694CE1375;
        Wed, 28 Dec 2022 18:13:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7494C433D2;
        Wed, 28 Dec 2022 18:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672251228;
        bh=lVwSaqSZ7IuhavkV9bL4BSr/f9Da8jSkCwPr1LBYck0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=moKj8pZL8Wrj9P/eXsJ1Lgk3vAhAqLZvJdm41aT7jjWHVzU+cDx7eQ76dLuPOcaQg
         ZFQkAacEzfxqeB2ML0zbu+de2Ew3hki+kAeU9m2yDg8qqJRq568PMKoFCzGhtCaDl3
         2wIeFSyEspJIkTNow/2PQiG/DjwIvtO2QC7nXfCxy42pC8pigC5/iCBbEpsb5ltGCG
         3VL6MNymaTUkZexJN/Z5pT7CwV9BfDFK1p1+9b/6NdXd3qzhslDrUrE7b2KOUUmnXX
         2Hks/s3yPGQManGLBSs/FixP3Db+jcRMPlsaiMu8nfibsV4Tr5TTi0u7V1/fWp519x
         jdYZEkcXCu7TA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-arm-msm@vger.kernel.org, konrad.dybcio@linaro.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     robin.murphy@arm.com, joro@8bytes.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        will@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        marijn.suijten@somainline.org, iommu@lists.linux.dev
Subject: Re: (subset) [PATCH 1/2] dt-bindings: arm-smmu: Add sm8150-smmu-500 to the list of Adreno smmus
Date:   Wed, 28 Dec 2022 12:13:42 -0600
Message-Id: <167225121530.949655.3229083574762071501.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221213002626.260267-1-konrad.dybcio@linaro.org>
References: <20221213002626.260267-1-konrad.dybcio@linaro.org>
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

On Tue, 13 Dec 2022 01:26:25 +0100, Konrad Dybcio wrote:
> From: Marijn Suijten <marijn.suijten@somainline.org>
> 
> sm8150 has an smmu-500 specifically for Adreno, where the GPU is allowed
> to switch pagetables.  Document the allowed 3-compatibles for this,
> similar to sc7280 and sm8250.
> 
> 
> [...]

Applied, thanks!

[2/2] arm64: dts: qcom: sm8150: Enable split pagetables for Adreno SMMU
      commit: c34bef62a0096d1db309db8ffd165a1a6f01f227

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
