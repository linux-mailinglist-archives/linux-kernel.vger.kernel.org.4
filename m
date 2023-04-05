Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9756D7319
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 06:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236887AbjDEEHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 00:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236837AbjDEEGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 00:06:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548034EE9;
        Tue,  4 Apr 2023 21:06:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B581E63B15;
        Wed,  5 Apr 2023 04:06:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AE55C433A0;
        Wed,  5 Apr 2023 04:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680667591;
        bh=9/JGOJLdDPVHhkGKeLEDl3xpks+HjrMEVLnec1kQFfc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=P9gzJUQjXwfet+qR2tJTq2XWLAeid9y5IhX7uF8/NRGT6dr1dwQSFVXQMjpiWpH7E
         IudF0XGxGASAegtco/5Hm75WGlKgyC9fdz/Ud2z+nBtTMU+46XYaewajlL+Kk2kXrw
         cg+hR3nXxRaPM3f1XRpJ2r68JuD2+TUEVcmI7ZW1cPYcww68Q/v6bQvohvS9rcKLap
         tH5B2O1xOcKRtE8cUB2BtWJn+RkdQXPf5L7Ib7yiyinlIHFpvIaHclab/06dka1198
         BtQazS7ZhBSsY1kqrY8VcNfpT9RI+NpICIItRlRDnZyjzg74U9oTE/36JfGCQjEWbu
         T11SY3ivOrQqA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp: correct Soundwire wakeup interrupt name
Date:   Tue,  4 Apr 2023 21:09:02 -0700
Message-Id: <168066774419.443656.2284359152819336272.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230403132328.61414-1-krzysztof.kozlowski@linaro.org>
References: <20230403132328.61414-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Apr 2023 15:23:28 +0200, Krzysztof Kozlowski wrote:
> The bindings expect second Soundwire interrupt to be "wakeup" (Linux
> driver takes by index):
> 
>   sc8280xp-crd.dtb: soundwire-controller@3330000: interrupt-names:1: 'wakeup' was expected
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sc8280xp: correct Soundwire wakeup interrupt name
      commit: 894e258b6a38922f9860a20ca07cf2f745e3b090

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
