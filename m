Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC56A61E935
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 04:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbiKGDOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 22:14:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbiKGDNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 22:13:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07716FAC4;
        Sun,  6 Nov 2022 19:13:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCE1E60E9D;
        Mon,  7 Nov 2022 03:13:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79237C43147;
        Mon,  7 Nov 2022 03:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667790780;
        bh=Tu0gg1bahmEVdqrXLMfKYiBWkxu6aCiwoffkHF4cWYw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=tBK6ppGkzA1lKNP+qUug1tLHsf4z6OHpnqmqBHiQmcfUSFiPGYp2yMznPlAbl8sEh
         xddo4d0MyWxMVMS5V/YYsADOXAATQIqv8YG77lLO4j2Fs2xuo099U4WpIhyR2r+V/W
         aW0BcwZTHHKP0KPVeaNhPArKGSa0kPmqIvJ2sjLPqm1fJyVxGl6w7IopYq66VvnhxX
         U0jeAHZf+aPTDvjGxgHu2WjOgpFHYNm6EEWKYWdxcnMyhX+fity+FXUy/QVhxlq6Ii
         v7hW1mgjt7asRw5/xlWXSk2K3vJwiZFOPTfEeIovzCmyUFbxslxKmCEV2mYLOHvKf+
         VJqbJ0Qa8mFdQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        konrad.dybcio@somainline.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, linus.walleij@linaro.org,
        srinivas.kandagatla@linaro.org, Andy Gross <agross@kernel.org>
Subject: Re: (subset) [PATCH v2 00/12] pinctrl/arm64: qcom: continued - fix Qualcomm LPASS pinctrl schema warnings
Date:   Sun,  6 Nov 2022 21:12:18 -0600
Message-Id: <166779074255.500303.2589437465871812483.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220927153429.55365-1-krzysztof.kozlowski@linaro.org>
References: <20220927153429.55365-1-krzysztof.kozlowski@linaro.org>
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

On Tue, 27 Sep 2022 17:34:17 +0200, Krzysztof Kozlowski wrote:
> Changes since v1
> ================
> 1. Reorder patches - DTS first.
> 2. Correct commit msg in two binding patches, as suggested by Rob.
> 3. Add tags.
> 
> Overview
> ========
> This is the *second*, independent patchset around Qualcomm pinctrl in recent days:
> 1. First round of TLMM fixes: merged
> 2. LPASS fixes: *this patchset*
> 3. ARMv7 TLMM fixes: https://lore.kernel.org/all/20220926074415.53100-1-krzysztof.kozlowski@linaro.org/
> 4. ARMv8 remaining TLMM fixes: https://lore.kernel.org/linux-devicetree/20220925110608.145728-1-krzysztof.kozlowski@linaro.org/T/#t
> 
> [...]

Applied, thanks!

[01/12] arm64: dts: qcom: sc7280: drop clock-cells from LPASS TLMM
        commit: 67cb6e988f8937105560c782bf04520c3d0db841
[02/12] arm64: dts: qcom: sc7280: align LPASS pin configuration with DT schema
        commit: 886a50bd031aae7b6880030a4076a146d0429492
[03/12] arm64: dts: qcom: sm8250: correct LPASS pin pull down
        commit: 195a0a11d66d6c696cbcf398d6bc3f3a3a462f7c
[04/12] arm64: dts: qcom: sm8250: align LPASS pin configuration with DT schema
        commit: 031f5436c9b7209446eb90fe512d1e379ace0e1b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
