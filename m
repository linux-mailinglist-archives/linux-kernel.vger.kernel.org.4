Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E26976022AE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbiJRDbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbiJRDbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:31:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DA5A5726;
        Mon, 17 Oct 2022 20:22:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17886613EA;
        Tue, 18 Oct 2022 03:14:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D45E9C433D7;
        Tue, 18 Oct 2022 03:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666062884;
        bh=S/TSlq/qmWq1g/fA9AArA809Y3+rGSjUckivxyPLYg8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HFfU3h/syKffq5Zhik9DclywCfuQIHck5GSdM1A/WxE2L1JF2WemgxiCzNrdRm51L
         ZUjS3AO4KkNE3y7XLn7Hsuy0FsFrPT5R3hljP7+3fyc6Vr2k7bK/XuX3lI2vRPTYr4
         FDl3aWinxOuGcdqRiYQ8DeqRo4YaCRtUvtOiFzcZG5YtnQwni/gZoB8zz0bG9oPDDL
         CyWW7UaEkfOUDqapQKe5O6WJB30ynmroxK6+2rtQ52PgTXXnaCG97nVTCxTymarIDT
         PbuFS0Ffo4KyPc5/2kEtpZAiroiuzC5Lh6EE8sj4xd7TK4oCxbhqzjIBRK/2O8PyPG
         VpoSv+gbP/Vpw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        agross@kernel.org, quic_rjendra@quicinc.com,
        konrad.dybcio@somainline.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: Add required-opps for i2c
Date:   Mon, 17 Oct 2022 22:14:34 -0500
Message-Id: <166606235842.3553294.18438105208617247977.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220927104233.29376-1-quic_rjendra@quicinc.com>
References: <20220927104233.29376-1-quic_rjendra@quicinc.com>
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

On Tue, 27 Sep 2022 16:12:33 +0530, Rajendra Nayak wrote:
> qup-i2c devices on sc7280 are clocked with a fixed clock (19.2 MHz)
> Though qup-i2c does not support DVFS, it still needs to vote for a
> performance state on 'CX' to satisfy the 19.2 Mhz clock frequency
> requirement.
> 
> Use 'required-opps' to pass this information from
> device tree, and also add the power-domains property to specify
> the CX power-domain.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sc7280: Add required-opps for i2c
      commit: e3e9a5803807302221060e80880feee1b0be5765

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
