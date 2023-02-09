Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3BA768FF06
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 05:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjBIEcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 23:32:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjBIEbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 23:31:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0216E3F2AE;
        Wed,  8 Feb 2023 20:31:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B178BB82008;
        Thu,  9 Feb 2023 04:21:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B40C4339B;
        Thu,  9 Feb 2023 04:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675916509;
        bh=ezclNvFQxe/s1Qj7sqatiqOnvzd8+/jAr2Hd+15IwT8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ngjhzb1N/+hseXvjQ1snOLNiB4jSCPwdK9I9YKzDV0wKClo94w4y4KeS4quL00E/s
         XoEv7aMIWt7urzQ3gR8oq0s2W7m8hc+bX9Nw6N4NDZowjHYmFqk3dtgDwN/K5ioqzQ
         crHeO1annqMiMx1RgXPUeayy8wB3QgAAyrD0DfHws72WWrNOMOT3IVes1floqSGqMd
         XzmcP5JQaZeuWxnllDyxr7qXXMJQ2jhxOOAXwxazNsSGZAJUGuE1LZjcSCA9UoghFC
         7gehCjjX4LKdnyDNMQJ6k/7Xac4GlQM+ct84JN2UcSDRARk9HPtZiEG/u2U3Or2p6c
         NU6wPClqi9FBQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: (subset) [PATCH 1/5] dt-bindings: pinctrl: qcom,sc7280-lpass-lpi: correct GPIO name pattern
Date:   Wed,  8 Feb 2023 20:23:05 -0800
Message-Id: <167591660371.1230100.17284546425667937573.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230203164854.390080-1-krzysztof.kozlowski@linaro.org>
References: <20230203164854.390080-1-krzysztof.kozlowski@linaro.org>
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

On Fri, 3 Feb 2023 17:48:50 +0100, Krzysztof Kozlowski wrote:
> The SC7280 LPASS pin controller has GPIOs 0-14, so narrow the pattern of
> possible GPIO names.
> 
> 

Applied, thanks!

[5/5] arm64: dts: qcom: sc8280xp: correct LPASS GPIO gpio-ranges
      commit: 9c23d6848e43c25c4fe7bded4daf75569c360631

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
