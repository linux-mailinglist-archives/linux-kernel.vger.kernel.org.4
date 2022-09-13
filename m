Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660195B7D47
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 00:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiIMWsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 18:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiIMWsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 18:48:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8900852DCA;
        Tue, 13 Sep 2022 15:48:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 29212B81173;
        Tue, 13 Sep 2022 22:48:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9120C433D6;
        Tue, 13 Sep 2022 22:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663109294;
        bh=uv77tai1BCYC/4qEL/4nS7QCqtMJjwF829Abww+ZQl4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=LptG3Lc4LgeKuOIDpuzyAcpL6G5rKzKeOxu810/KQdLJap5fhLuKs62v/W/lysDTX
         Cft+/+1Y7Vj/2gMCspJvPqZtt/DMo6NdUIPokVxo1glMH747IJRFk4iDOTxdxnzmtk
         fMGOP4+eHPkgssYli3sz33eoafI4ToZOujUNabiuQXchGGrRN0GegzuyIeDVf5nSvy
         ysYTqs19fCHFvjlqcQKIXEKkSTLE0nndUuWGWCQ+iS1q0Y5VfALCBcewmR6iOZd8an
         cjyq90LJCfeaEY8y1yYasjLIDdRuknwtaXOwuEDEAwnDUp71SF+iJslpa125KlfZG1
         KbfHbetihkd1w==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        agross@kernel.org, vkoul@kernel.org, iskren.chernev@gmail.com,
        linus.walleij@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        konrad.dybcio@somainline.org, linux-arm-msm@vger.kernel.org,
        martin.botka@somainline.org, krzysztof.kozlowski@linaro.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: Re: (subset) [PATCH v2 00/40] pinctrl/arm64: qcom: fix some of Qualcomm pinctrl schema warnings
Date:   Tue, 13 Sep 2022 17:48:07 -0500
Message-Id: <166310928487.670084.13401205270132967103.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220912061746.6311-1-krzysztof.kozlowski@linaro.org>
References: <20220912061746.6311-1-krzysztof.kozlowski@linaro.org>
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

On Mon, 12 Sep 2022 08:17:06 +0200, Krzysztof Kozlowski wrote:
> That's a set for some of arm64 pinctrl bindings fixing most common warnings.  I
> have a plan to continue this for remaining arm64 (sm8250 needs updates) and for
> arm.
> 
> Changes since v1
> ================
> 1. Correct commit msg in commits "fix matching pin config".
> 2. Correct commit msg in commit #2 .
> 3. Add Rb tags.
> 
> [...]

Applied, thanks!

[34/40] arm64: dts: qcom: sm6125: align TLMM pin configuration with DT schema
        commit: be24fd19b1b42e0b38e77e0d6a379282bafb6aa6
[35/40] arm64: dts: qcom: sm6350: align TLMM pin configuration with DT schema
        commit: 448f5a002fedb2ff2d19e5a563d3af1ea5e123e1
[36/40] arm64: dts: qcom: sm8350-sagami: correct TS pin property
        commit: c9c53d1f4329564f98ed0decfe3c377c6639ec5d
[37/40] arm64: dts: qcom: sm8350: align TLMM pin configuration with DT schema
        commit: e227fa2970fd259fa65f97c4defb0b85dffc62d7
[38/40] arm64: dts: qcom: sm8450: align TLMM pin configuration with DT schema
        commit: a73747528867fabea8e285a1b604594181091507
[39/40] arm64: dts: qcom: sc7280: align TLMM pin configuration with DT schema
        commit: d801357a0573105ff5db9fbfde80c3572369a261
[40/40] arm64: dts: qcom: sc7280-herobrine: correct TLMM gpio-line-names
        commit: e0eeb08522c94860c3528816f612c335a6d6552c

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
