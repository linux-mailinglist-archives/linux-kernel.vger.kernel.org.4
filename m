Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01E365864A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 20:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbiL1TN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 14:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbiL1TNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 14:13:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B4715FCA;
        Wed, 28 Dec 2022 11:13:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A1514B818C8;
        Wed, 28 Dec 2022 19:13:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 843FCC433EF;
        Wed, 28 Dec 2022 19:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672254827;
        bh=p70BTFSkLiba81PvWG5NKv48AXo6CdAN0ZnzCg0XeEw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZcGq/UcDyU2sUmIW1MYUBum4WJ72UMJ+mUZyk4+mZGGSu71tzxwI0xukjjbGDnsbn
         tqqPhIgllceBURSMD//VcJFxhFvOqDm/Uvz/Eqq8bmsq+2T/Orn2LlvvhIJ+hF3/pS
         IgYkMzLfm7VaXcuHhVvtOiLJFNQQfSEwsZ3DsPm1Z8Qb+miuIGrQ0Vy/+uDgJW/+bE
         T/qPbsQPopaIr9yL8JhkzzwZa3w3iXaMyvTs9Gxf61pAQuF8rsWfHEr2imR4pkkEkP
         uqFLp7ypGexUofjuYcnlOpU5TheZRwuL1Qd6nx3vUwjkBUFdRS9BWY709X32wLM/Wm
         Y+tyGUTidxTAA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     dsankouski@gmail.com, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, marijn.suijten@somainline.org,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH v2] arm64: dts: qcom: Re-enable resin on MSM8998 and SDM845 boards
Date:   Wed, 28 Dec 2022 13:13:42 -0600
Message-Id: <167225482209.977158.11261223838020673662.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221228115243.201038-1-dsankouski@gmail.com>
References: <20221228115243.201038-1-dsankouski@gmail.com>
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

On Wed, 28 Dec 2022 14:52:43 +0300, Dzmitry Sankouski wrote:
> resin node declaration was moved to pm8998.dtsi file (in disabled state).
> MSM8998 and SDM845 boards defining resin node did not previously have
> status="okay" and ended up disabled.
> Re-enable it by using resin node link from pm8998.dtsi with status="okay".
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: Re-enable resin on MSM8998 and SDM845 boards
      commit: 4c881ab73a64cdbf8691e258ef17b740d27040a0

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
