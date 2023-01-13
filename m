Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28F6266A413
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 21:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjAMU22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 15:28:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjAMU20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 15:28:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4725CDFB7;
        Fri, 13 Jan 2023 12:28:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D97D462325;
        Fri, 13 Jan 2023 20:28:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35914C433EF;
        Fri, 13 Jan 2023 20:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673641705;
        bh=HwyfpRpcKiNgFxBF8Fbg2rQkB/xW2UMxV2EyZwi2Cdg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=daL+l5NdFwnvuDTj4Zl99RfFy4ymHTe4yruuyRkEzU5Vvz1Zzb6rCQN6YLeLGKc0i
         yAgEhPfPckED5m1j04C5sUbxEjoNO3UU9Yjt14mlo+UXF5xPGYCtqvbzZWdIkoQ6NM
         Ej+2ldLt1DtJn0ohk20r9LQ469uWUOMtTi58Lrgu0ieQbVT0xoqq1rKpSbDuCHaqtn
         lGfH4IOYDWj3jNCoc3p8oIfLnLQWSWUCvSTU2Je5w5MMQeto3+wNsqIUykGGmJ+9P1
         b+DkKZkG5P3uWoMMALpqoJ7+nmEJG0CCLxOlXBGui4G0g/TodQc1aXSyRCkjTTcNdz
         +Z9wZL0kNxhoA==
Message-ID: <e73ad320fafa1365e3506bbd4cc77d8d.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230113145859.82868-1-krzysztof.kozlowski@linaro.org>
References: <20230113145859.82868-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] dt-bindings: clock: qcom,a53pll: drop operating-points-v2
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 13 Jan 2023 12:28:23 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krzysztof Kozlowski (2023-01-13 06:58:59)
> The CPU PLL clock node does not use OPP tables (neither driver).

What device is qcom_a53pll_get_freq_tbl() operating on?
