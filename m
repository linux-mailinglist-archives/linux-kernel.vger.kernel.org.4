Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3D274CC15
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 07:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbjGJFJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 01:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232382AbjGJFIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 01:08:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244172D6B;
        Sun,  9 Jul 2023 22:06:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8EB6360DE6;
        Mon, 10 Jul 2023 05:05:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F1E0C433C9;
        Mon, 10 Jul 2023 05:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688965504;
        bh=SBT+AhhoDmQM0vuw/3dZth4ORvb6AEKLt2X/q4l88VU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=amLp2OrQjqpNCO7vcUPvpqJHjjLNaujWrTiUvTq1+YpKXeRGmRkuOoGZ+16YVsC3A
         fmZeh6hoc2v3DMU8X2G3I1GcZr7sdruLNur6RlmQybrgHbXZDrXHqX28cw9oJCTLUh
         a1mDWwRWyeVBLY4jgxJNraQWYukC39Ol9g6xs9Gj3DTmsvH/u4SWwZ3CgWW3AjAqlH
         Bw//gqmhB74hs5lEfTrrLrn+be3hBoF6zjrQYx/6pgdfsPf9fdv8wgK3+2df9esVSY
         A7kmYFxgiTnm70l3S5ib1q6LMxYV/T5MT46Hc0MjsCdjred1R+wdeopKJnM4/Gva7G
         QXzz83qEDbFyA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 1/2] arm64: dts: qcom: sc8280xp-crd: Correct vreg_misc_3p3 GPIO
Date:   Sun,  9 Jul 2023 22:07:41 -0700
Message-ID: <168896565964.1376307.6436290962734178451.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230620203915.141337-1-quic_bjorande@quicinc.com>
References: <20230620203915.141337-1-quic_bjorande@quicinc.com>
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


On Tue, 20 Jun 2023 13:39:14 -0700, Bjorn Andersson wrote:
> The vreg_misc_3p3 regulator is controlled by PMC8280_1 GPIO 2, not 1, on
> the CRD.
> 
> 

Applied, thanks!

[1/2] arm64: dts: qcom: sc8280xp-crd: Correct vreg_misc_3p3 GPIO
      commit: 9566b5271f68bdf6e69b7c511850e3fb75cd18be
[2/2] arm64: dts: qcom: sc8280xp-crd: Fix naming of regulators
      commit: 8882ae076344f8b4e9f1e5a116e1a83c4292b790

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
