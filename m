Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C27A9602214
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbiJRDKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbiJRDIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:08:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290549AFB4;
        Mon, 17 Oct 2022 20:07:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B30986136C;
        Tue, 18 Oct 2022 03:07:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B009C43141;
        Tue, 18 Oct 2022 03:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666062428;
        bh=1BfY1PnCTylRiKFpt8p1zmwAtZauu1fmolEvNIMb6I8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=lk+PqEPC8pYWTpVz+i6D79fy6Fx15G6eSENpvrTtDBrbdS71xXwAiQ/go7to8oZxH
         yoGUZ0P+MnwkwxkMk5358T5RxI9qQwUsvtllePNhvHXThkjYqedbWJyXWbqiyHZjVH
         J1ben/ouoAz9Hw0T2zgK9BhBSVuVvFaJ3EB9y43pgXmi9Ap+wNHh4cSJS5720gQN9H
         hfA88vrCNWHmTey99LRmshx7ar+B1ymvVW30S951M8k+kg/LUS/b3C/bRqtoz6Vrba
         KnMgs6ER+SJ59FrC4IEGAVO94gGu7mPzDWwkBctO2ukd3LFkPJAHfa8B4+d+W9eVAv
         1Yl8HRx2p8NtA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, agross@kernel.org,
        krzysztof.kozlowski@linaro.org, linus.walleij@linaro.org,
        robh+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: (subset) [PATCH v3 1/4] arm64: dts: qcom: msm8998: add gpio-ranges to TLMM
Date:   Mon, 17 Oct 2022 22:05:41 -0500
Message-Id: <166606235861.3553294.17820472045453373115.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221013210612.95994-1-krzysztof.kozlowski@linaro.org>
References: <20221013210612.95994-1-krzysztof.kozlowski@linaro.org>
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

On Thu, 13 Oct 2022 17:06:09 -0400, Krzysztof Kozlowski wrote:
> Qualcomm pinctrl bindings and drivers expect gpio-ranges property.
> 
> 

Applied, thanks!

[1/4] arm64: dts: qcom: msm8998: add gpio-ranges to TLMM
      commit: e3d5e948d1b87e8531d842f4c98f56e0bb1a5c60
[2/4] arm64: dts: qcom: msm8998-oneplus-cheeseburger: fix backlight pin function
      commit: 46546f28825cf3a5ef6873b9cf947cd85c8a7258
[3/4] arm64: dts: qcom: msm8998: align TLMM pin configuration with DT schema
      commit: ed9ba9e9b7437416ed97b36fe06ecb6001f0b067

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
