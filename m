Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735E760221E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbiJRDKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiJRDIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:08:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D479AF91;
        Mon, 17 Oct 2022 20:07:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CE8C61369;
        Tue, 18 Oct 2022 03:07:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4250C433C1;
        Tue, 18 Oct 2022 03:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666062431;
        bh=jOsOzWE/NCwC8A+Q/qgUuroUOrJ6Pvfc/Ah6rtTsNjk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=n2e3sXTjUOwMVVzYFZsVnTJXtUGjGFR+HhFkE7Qg+sY7JxS4koEY2+pCgUZ2DQ1+W
         4I8U6ulTldjIrftpq81peyTthRzibZfjQdXXWsE1IASgaHeV7E1h2qYBpwC99sBQGr
         +ib0R7MTyMgapYk+CO7XIc5TkpACv+IAGa7Nxd2lSV2sHWkr2hdaZNuFyOLDDYZKHp
         5nqIx2gHttRIQL7DtBiaqRQfa8M+e6B6zWHZaQOtDoNbYHSBl97TftDMdvPENgMcNI
         pqJBPFlw5W9pFZ+3qWN3/+CFoAS4zT0vvAoBB3+NCq7H728f5idNCxgdd7xNqgLRu5
         X+2tNy8nXyGJg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        stephan@gerhold.net, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org,
        linus.walleij@linaro.org, vkoul@kernel.org, shawn.guo@linaro.org,
        robh+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        quic_vamslank@quicinc.com,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: (subset) [PATCH v5 00/34] pinctrl/arm64: qcom: continued - fix Qualcomm TLMM pinctrl schema warnings (third set)
Date:   Mon, 17 Oct 2022 22:05:44 -0500
Message-Id: <166606235863.3553294.2899134058558070077.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221016170035.35014-1-krzysztof.kozlowski@linaro.org>
References: <20221016170035.35014-1-krzysztof.kozlowski@linaro.org>
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

On Sun, 16 Oct 2022 13:00:01 -0400, Krzysztof Kozlowski wrote:
> Changes since v4
> ================
> 1. Drop drive-strength (included by common TLMM node).
> 
> Changes since v3
> ================
> 1. All patches with subject: "use common TLMM schema":
>    Drop properties and required items which are already provided by common TLMM
>    schema.
>    The change against v3 is non-trivial, however I retained reviewed-by tags.
> 2. Add Rb tags.
> 
> [...]

Applied, thanks!

[03/34] ARM: dts: qcom: sdx55: add gpio-ranges to TLMM pinctrl
        commit: 0139f183bcddcf5b36f805254bb0f0625963f783
[04/34] ARM: dts: qcom: sdx55: align TLMM pin configuration with DT schema
        commit: bda79af488a3e75769433fb961800c39bb07b29c
[05/34] ARM: dts: qcom: msm8226: align TLMM pin configuration with DT schema
        commit: df9c86025510c45a6d90669347129e8000e1bbbc
[06/34] ARM: dts: qcom: msm8974: align TLMM pin configuration with DT schema
        commit: 6cd72414abc7345e277fcab5e1c763c3a017dc6a

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
