Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAF865B9A3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 04:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236625AbjACDPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 22:15:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbjACDPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 22:15:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFABBE30;
        Mon,  2 Jan 2023 19:15:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D7A6FB80D75;
        Tue,  3 Jan 2023 03:15:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEABCC433EF;
        Tue,  3 Jan 2023 03:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672715705;
        bh=usYv2k53gVb1bCSUiKHWvGw2If/fwm0/gxfWbzhK348=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=BLg1kC3wOs67OmJgmfXK6T2ySmnGvyB9lIaTnKVkD2I8nkKnonjkPhFZ8sC9GM2Rs
         5BqhYhLMF8a8f3Jg+a8h8/wFFPmFxfKT1+sddUQYyrNNXggQ7B41Lm73xEWERMlrKO
         jP0Xw7C1R6YeZkjToil75NboeOImP6s4KDCjWovESJrhVAefxTMsANNAIcTslxBhFW
         /iOsLQJdxyawpSkcwAfseReuPNPu42u7Qm0FsmMB5gk8dQwTisbXDr19LDTcaW8ZQn
         MiGOFraY40nz61NTvwT7B54zg8xm47LQj+vwIMLiqcAfdveT/YN+hAakklBKuVGRYt
         Gq2sMVb9Au+dA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     devicetree@vger.kernel.org, konrad.dybcio@linaro.org,
        sboyd@kernel.org, mturquette@baylibre.com,
        krzysztof.kozlowski@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, agross@kernel.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: clock: qcom,gcc-sc8280xp: document power domain
Date:   Mon,  2 Jan 2023 21:15:01 -0600
Message-Id: <167271569385.1479016.15755509178788749198.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230102085909.24620-1-krzysztof.kozlowski@linaro.org>
References: <20230102085909.24620-1-krzysztof.kozlowski@linaro.org>
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

On Mon, 2 Jan 2023 09:59:09 +0100, Krzysztof Kozlowski wrote:
> GCC clock controller is supplied by CX power domain:
> 
>   sc8280xp-crd.dtb: clock-controller@100000: Unevaluated properties are not allowed ('power-domains' was unexpected)
> 
> 

Applied, thanks!

[1/1] dt-bindings: clock: qcom,gcc-sc8280xp: document power domain
      commit: cae04c4425e374ed10dc8a8c1f3bd369934945d7

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
