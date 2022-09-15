Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA485B9359
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 05:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbiIODiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 23:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbiIODhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 23:37:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B6292F7E;
        Wed, 14 Sep 2022 20:37:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E18D0B81D86;
        Thu, 15 Sep 2022 03:37:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B06F2C43140;
        Thu, 15 Sep 2022 03:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663213039;
        bh=vA2kIzFD8k9VkBgt+fbtYJwYrubdCPahDssg2GXZrnA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=faMc6t5zHm4NdjqnKYJrHZVKh80UTHna3ls2jxsDYZCT3azfn+zwzGWVk54Ci3Sqz
         k1LvvVXS9kp2xLP4GC9+pK2OVhxs1Ify4YxJtwZmaSB/iuWVV92QIAjVpjbt/nJ4L7
         fdGV9v8y+fUycTb9geScSZdyxPY4YGcKrpSvLIjXKpzS2aw8Fo52StHiyZxH3aR2hb
         hmy4oU7ByAb+u6Xx4dvHjb2kLNmgAnydXtnu1bEhBcOXPc+XmFq2JqkWe00nB4LdEN
         A03OUN610xUB42AWfF4gD+KqBierajS3AFAaPG6vevzYAyKVG8GjAkdMHVui+7Q5Hk
         fJGUWFQeDOmug==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, mka@chromium.org, krzk+dt@kernel.org,
        Bjorn Andersson <andersson@kernel.org>, swboyd@chromium.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dianders@chromium.org
Cc:     krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@somainline.org
Subject: Re: (subset) [PATCH v24 1/2] arm64: dts: qcom: sc7180-trogdor: Add nodes for onboard USB hub
Date:   Wed, 14 Sep 2022 22:37:01 -0500
Message-Id: <166321302062.788007.6887378147525965852.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220722093238.v24.1.I7a1a6448d50bdd38e6082204a9818c59cc7a9bfd@changeid>
References: <20220722093238.v24.1.I7a1a6448d50bdd38e6082204a9818c59cc7a9bfd@changeid>
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

On Fri, 22 Jul 2022 09:32:44 -0700, Matthias Kaehlcke wrote:
> Add nodes for the onboard USB hub on trogdor devices. Remove the
> 'always-on' property from the hub regulator, since the regulator
> is now managed by the onboard_usb_hub driver.
> 
> For anyone using trogdor-based devices on Linux, it should be
> noted that this requires "CONFIG_USB_ONBOARD_HUB=y".
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: qcom: sc7180-trogdor: Add nodes for onboard USB hub
      commit: a73dd03bb2e0287497f8fe9e221c332369e05fca
[2/2] arm64: dts: qcom: sc7280-herobrine: Add nodes for onboard USB hub
      commit: dc94156c6694e0ecee32870df94ed8fae07327ca

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
