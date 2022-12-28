Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094896572C9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 05:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbiL1Eib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 23:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbiL1EhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 23:37:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15718E013;
        Tue, 27 Dec 2022 20:37:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C6708B8109E;
        Wed, 28 Dec 2022 04:37:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E231BC433D2;
        Wed, 28 Dec 2022 04:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672202230;
        bh=Y3D5lQSuVSwgBHwcnmWD5APaSf7f0qMuZ2OP792Wvrg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=IkVEX/bfs7dxW1avTE/rZI3kGoYN5+MHZg6kd7yhG6o9DHfIMCp3mBiWxdAIBLu/J
         0DfD5QJO8P4Q+Y00LR+mM9tI0EX4WmzbqIvVj0UBxWunbszUEF45UyZbbqr4dn0pIB
         YXHoWmq36ZJCDW6pS9yRvA0T/M7iycL3xfj1n5ISFmaT57mNal4V4bjtFygBXW0EgK
         pUVwSWm+GfepExNifNqEq6EFewYlSVSSFfY3Yz4ifr2+Zhl6FboVoJNLsUVSmNp4RW
         3QZfYltbcYA6eZq7u4QLv8iIHYk39AU20XnWxbpAKiNBwP6/aC05bN+02XntHaJesg
         PV+VUlwTS4vXA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
        konrad.dybcio@linaro.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: (subset) [PATCH v2 1/3] arm64: dts: qcom: msm8996-xiaomi-gemini: use preferred enable-gpios for LP5562 LED
Date:   Tue, 27 Dec 2022 22:36:45 -0600
Message-Id: <167220221219.833009.18401531649717521241.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221127203240.54955-1-krzysztof.kozlowski@linaro.org>
References: <20221127203240.54955-1-krzysztof.kozlowski@linaro.org>
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

On Sun, 27 Nov 2022 21:32:38 +0100, Krzysztof Kozlowski wrote:
> The preferred name suffix for properties with single and multiple GPIOs
> is "gpios".  Linux GPIO core code supports both.  Bindings are going to
> expect the "gpios" one:
> 
>   qcom/msm8996-xiaomi-gemini.dtb: lp5562@30: 'enable-gpio' does not match any of the regexes: '^led@[0-8]$', '^multi-led@[0-8]$', 'pinctrl-[0-9]+'
> 
> 
> [...]

Applied, thanks!

[1/3] arm64: dts: qcom: msm8996-xiaomi-gemini: use preferred enable-gpios for LP5562 LED
      commit: 4df05b44468cdf5dea7a7aa291eeabd7e639f8ff
[2/3] arm64: dts: qcom: align LED node names with dtschema
      (no commit info)

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
