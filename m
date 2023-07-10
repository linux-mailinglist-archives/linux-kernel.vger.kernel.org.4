Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A7674CB97
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 07:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjGJFEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 01:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbjGJFE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 01:04:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D782218B;
        Sun,  9 Jul 2023 22:04:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 455AD60DEA;
        Mon, 10 Jul 2023 05:04:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7D76C433CB;
        Mon, 10 Jul 2023 05:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688965465;
        bh=pa4saz9eNLW7Pbhso8Ing/CUmfJzcmQ8YPVv8nad7qI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dPDo8GQoTa+e0T/dZR4B2dEW3IE6sVFCvPDcnJX3w+BWubfjAuCU2/TtPhvTZqMN6
         4eWQYicjR0uGOnaHTa27pRt6/G/GzaRvd0EIB9YzSaj0tgCtSsDYwplN3ddY3F00Nx
         ry9Bzr86P2YFPEkTzN7QxnR3c6o9Hrl2m5/XNPvwGlfllUAGY7GJIoPFgYLmaxyvyi
         PSeB/PF7xpawMsMP8bFS9lVPU+2qO6MuqXFgpGMxOJ7sMzssuUS7mDN3+1E6v1p9kX
         gWn+Hq1TK2VJ8IvDaWJ7cegpYhhljS3a7igEetezwD7tTkZfLOS3yVeo4/oGK/uusN
         yaeqtd/FzMjzw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Patrick Wildt <patrick@blueri.se>,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp-pmics: add explicit rtc interrupt parent
Date:   Sun,  9 Jul 2023 22:07:09 -0700
Message-ID: <168896565975.1376307.8490035925119859700.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230627085306.6033-1-johan+linaro@kernel.org>
References: <20230627085306.6033-1-johan+linaro@kernel.org>
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


On Tue, 27 Jun 2023 10:53:06 +0200, Johan Hovold wrote:
> Unless explicitly specified the interrupt-parent property is inherited
> from the parent node on Linux even though this may not be in full
> compliance with the devicetree specification.
> 
> Following commit 2d5cab9232ba ("arm64: dts: qcom: sc8280xp-pmics:
> Specify interrupt parent explicitly"), add an explicit interrupt parent
> also for the PMIC RTC node for the benefit of other operating systems
> which may be confused by this omission.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sc8280xp-pmics: add explicit rtc interrupt parent
      commit: 55c9b1bf29dad107b3871bbb250c00df80a68791

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
