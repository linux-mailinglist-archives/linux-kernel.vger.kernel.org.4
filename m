Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D46F6667A87
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 17:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237409AbjALQPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 11:15:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235956AbjALQPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 11:15:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C542DDF;
        Thu, 12 Jan 2023 08:12:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1546B6206E;
        Thu, 12 Jan 2023 16:12:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDDEDC433EF;
        Thu, 12 Jan 2023 16:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673539946;
        bh=E1bJyCRjnsfu40bgh4LUcPiDwUH4wMe9l+bNGkQx8vc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=onOlt2KFJFcP177JifdloMvAR7cQaHLuSL7ioTqC7uxdNaO8oW7udifq2XVbcTryS
         I3gIGaAe9KzgcAd1YTnVe1gO1PRlgbiZ1Ec6oiMpOa5RQ8pLB1Y2ffNOLk4AMvGsTT
         SEiQE15Hufxr2ilsKJKw6yVydHk1jlXSTOFfBcdGzKY0nmwFAOGsdirOVbkEnggdEU
         fSMRq0P5Pu6R2xgRjezo5Ty+B4Y5cxK1yHaUbNUpZKE42wF0md/h1q+iMn0dz60tXt
         QVF0/UIC2F6hZqnvaqES6Nrj4fOFLiKvCYnpbT1/B3jyBzH/KxArkp7ICM+J5ceac9
         WzfGz39kQSVBQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     johan+linaro@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp-crd: allow vreg_l3b to be disabled
Date:   Thu, 12 Jan 2023 10:12:20 -0600
Message-Id: <167353993749.2393683.11896014052605146086.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230112074503.12185-1-johan+linaro@kernel.org>
References: <20230112074503.12185-1-johan+linaro@kernel.org>
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

On Thu, 12 Jan 2023 08:45:03 +0100, Johan Hovold wrote:
> The vreg_l3b supply is used by the eDP, UFS and USB1 PHYs which are now
> described by the devicetree so that the regulator no longer needs to be
> marked always-on.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sc8280xp-crd: allow vreg_l3b to be disabled
      commit: e15a815884925177f252a0adfe3b93dece6a75a8

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
