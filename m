Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA807602288
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiJRDWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbiJRDVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:21:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1599D512;
        Mon, 17 Oct 2022 20:17:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BEE6C613E9;
        Tue, 18 Oct 2022 03:15:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0760AC43143;
        Tue, 18 Oct 2022 03:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666062902;
        bh=aouoEcGjVXwuJ1lqdAmf9IvRDAoG+IwDHGv9FvuoLPQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vwdn4LPYEjVg4BTnb8IKt5yxhyQ6WuwuoD6rAOKMUG1hxVncLF723R4C3K4EtRWvn
         5xOSC0z+Qq/62DzbhI8QmDOuJBdY/J6Yt8tDocqxSNXAWpabSCzlvstfCDmx0YPcgJ
         C9kuTSGvfipRCnkUjjmB/5zL6qYtU8vYp8rFRGHJAeTSM6WIAtT8vwUGm34N7US+bi
         3n3Sga49fLryacXY+qro/Npz56IGcIinDGOtHQ3KkYuKAfL7XlzENFG/uMD1MuZILp
         3O/wuDQHrVWrW4tPdHJzbRC5t5lKHFaLnM3C0ttOoO0OTmd+NMxNItYIKcCXnBRlhQ
         Xea7z1d6Lat/A==
From:   Bjorn Andersson <andersson@kernel.org>
To:     amitk@kernel.org, Bjorn Andersson <andersson@kernel.org>,
        thara.gopinath@gmail.com, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        daniel.lezcano@linaro.org, agross@kernel.org,
        linux-pm@vger.kernel.org, robh+dt@kernel.org,
        konrad.dybcio@somainline.org, linux-arm-msm@vger.kernel.org,
        rui.zhang@intel.com, robimarko@gmail.com, rafael@kernel.org
Cc:     krzysztof.kozlowski@linaro.org
Subject: Re: (subset) [PATCH v7 1/5] dt-bindings: thermal: tsens: Add ipq8074 compatible
Date:   Mon, 17 Oct 2022 22:14:55 -0500
Message-Id: <166606235843.3553294.15679468325033987716.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220818220245.338396-1-robimarko@gmail.com>
References: <20220818220245.338396-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Aug 2022 00:02:41 +0200, Robert Marko wrote:
> Qualcomm IPQ8074 has tsens v2.3.0 block, though unlike existing v2 IP it
> only uses one IRQ, so tsens v2 compatible cannot be used as the fallback.
> 
> We also have to make sure that correct interrupts are set according to
> compatibles, so populate interrupt information per compatibles.
> 
> 
> [...]

Applied, thanks!

[5/5] arm64: dts: ipq8074: add thermal nodes
      commit: 887ac08946cc0f2a2b915140fcf8d4365ca9393d

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
