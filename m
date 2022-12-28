Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECB7658638
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 20:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbiL1TEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 14:04:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232366AbiL1TEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 14:04:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4404D140AA;
        Wed, 28 Dec 2022 11:04:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DABC1B818BF;
        Wed, 28 Dec 2022 19:04:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E7BBC433D2;
        Wed, 28 Dec 2022 19:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672254273;
        bh=2sPDqSv4XfgXtrU9TtQZwuf1yZc/sk1JV//l/lt6t30=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L+/rPCcrsgGsAHNyAcVTFV+3AGC5z5yhobjz/b5ixj6jx0z1YoUMgAThgkn/3iH2y
         yonRij1Mhd3zwcazRc4h/x4Scu3E+5WGQxQFMGSJ4AyfbDBCV7LY7CpLOfllYnI0++
         kqrmCRl2ABh3zYTJOyR62XeyxIpdo2KVG8XxRbP+2SR08ANSos0+N/3SrC7GIR545z
         nKuhxQvIVj7j7fDKWcvSsXhNmIE3agDZioQpS69HS/KLsYInfy7FAZsV5jynJ0FDFY
         WhjRecAlWXe/38bANu9N1R5aa5jVB85fy3hKU+vmx9b1feGxFwUyqLnb+zLMjia2En
         OKWojytFpOFdA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, konrad.dybcio@linaro.org,
        krzysztof.kozlowski@linaro.org, linux-arm-msm@vger.kernel.org
Cc:     robh+dt@kernel.org, linux-clk@vger.kernel.org,
        mturquette@baylibre.com, konrad.dybcio@somainline.org,
        marijn.suijten@somainline.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        sboyd@kernel.org
Subject: Re: (subset) [PATCH 1/2] dt-bindings: clock: add QCOM SM6350 camera clock bindings
Date:   Wed, 28 Dec 2022 13:04:28 -0600
Message-Id: <167225426552.971585.7520385380811591762.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221213152617.296426-1-konrad.dybcio@linaro.org>
References: <20221213152617.296426-1-konrad.dybcio@linaro.org>
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

On Tue, 13 Dec 2022 16:26:15 +0100, Konrad Dybcio wrote:
> Add device tree bindings for camera clock controller for
> Qualcomm Technology Inc's SM6350 SoC.
> 
> 

Applied, thanks!

[1/2] dt-bindings: clock: add QCOM SM6350 camera clock bindings
      commit: 7afc1f6977d0b0d1b722aaedf6d9796df9a82325
[2/2] clk: qcom: Add camera clock controller driver for SM6350
      commit: 80f5451d9a7c20d8c09f44f4eb1083fd861d7a46

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
