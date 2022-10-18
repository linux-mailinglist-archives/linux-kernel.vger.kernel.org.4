Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9214602210
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbiJRDJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbiJRDIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:08:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06849AF96;
        Mon, 17 Oct 2022 20:07:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DF47CB81C55;
        Tue, 18 Oct 2022 03:07:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E05F1C43144;
        Tue, 18 Oct 2022 03:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666062420;
        bh=p/DwXLD07U+mpIZ77JdU0A89LpCIf7HXAGZogHrukbQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Nakt19YgP1Qz9rRQdFqiYmy08lDO9uLPAq+fUFfrKffZMkvLX06r5wMXP0QIPZHVk
         LNULM6GpmF2KY2b130AzBudzOI0q9AV2mIE7KDVTWQ2iTOFe8Xza6GgiZEXqMjZXGi
         oUXl2qw5fSMf88Ikh+t3RLBnh5rkyNlf54vOOGtchPfqo98ZHf7+GGso6Xt0Qm8lR5
         TCIHY/aM6DXaUVTzG25lnBrXsLdI+gn0bmqWidMVKOxr3ZASka/teXLgAnBLe2KZLI
         osybrj81QjJn+Xh2gC4n3M5x1V+3zQv5Vb8TBskfTgBlk8QlmYCF5B8GQq0g7KUNY+
         cxzI115d1GSvA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org,
        robh+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH] ARM: dts: qcom: correct indentation
Date:   Mon, 17 Oct 2022 22:05:34 -0500
Message-Id: <166606235861.3553294.553249361299787614.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221002092000.68844-1-krzysztof.kozlowski@linaro.org>
References: <20221002092000.68844-1-krzysztof.kozlowski@linaro.org>
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

On Sun, 2 Oct 2022 11:20:00 +0200, Krzysztof Kozlowski wrote:
> Do not use spaces for indentation.
> 
> 

Applied, thanks!

[1/1] ARM: dts: qcom: correct indentation
      commit: 8ad78282a43f6effe86530b9980ba456b98d7cbc

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
