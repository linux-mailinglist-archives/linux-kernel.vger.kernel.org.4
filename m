Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10C26953B6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 23:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjBMWVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 17:21:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjBMWVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 17:21:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5581C32B;
        Mon, 13 Feb 2023 14:21:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CF9E9B81986;
        Mon, 13 Feb 2023 22:21:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA183C433D2;
        Mon, 13 Feb 2023 22:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676326862;
        bh=Xx9JTJbppKpd8lgxM8k8T32w8dkyUExzmRsBsJ7zG6M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZFlWX3CEvgfnQ1jNH5Vjl8JeZpxlowwY2T9npNbtYyjkQCUygbAZ4oVR4vHJqvnef
         UaP1qxPPA/m9249fb2ruDwWVKHqSIvqUrzVIBKXtVO6Dukkrny1ZJ/Qra+vZLdSy39
         8nwxEqWXzbX7EDHWpIE27vDHsPQQpUtB1Ymag6y03YA5z7wlsnduwXczA1to6q/lvS
         Gk+5cOMamIbf1Ossrfr0HYq31ccHnvncHZfTWMtT9HgukCPeHEHtv0I/uDubF1+OQy
         LZ5pK1c/58KtVM20WsYj5Y9YSsdG2ENl7zjTQGDKowEYatbbYBkpdTrCVQzmoTwNWh
         2RgzzSdlvfM8w==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [RESEND PATCH] arm64: defconfig: enable drivers required by the Qualcomm SA8775P platform
Date:   Mon, 13 Feb 2023 14:22:59 -0800
Message-Id: <167632698311.557014.11045879973663738246.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230209103531.469809-1-brgl@bgdev.pl>
References: <20230209103531.469809-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Feb 2023 11:35:31 +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Enable the pinctrl, GCC clock and interconnect drivers in order to allow
> booting SA8775P boards. The drivers need to be built-in for QUPv3 and
> subsequently UART console to work.
> 
> 
> [...]

Applied, thanks!

[1/1] arm64: defconfig: enable drivers required by the Qualcomm SA8775P platform
      commit: 687bcd03a047e65fcf12ae2b693043ee44acad4c

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
