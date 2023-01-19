Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E43672ED6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 03:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjASCRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 21:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjASCRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 21:17:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910D467975;
        Wed, 18 Jan 2023 18:17:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0406161A60;
        Thu, 19 Jan 2023 02:17:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99EEFC43443;
        Thu, 19 Jan 2023 02:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674094628;
        bh=H5QccH4CWY1iZGAEJVZR8VPaEdCQgRtnjkZInKPUjCI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ii7iNmngnLUamqh8MP5rpJFBsB8RQAtJ/hY0slC5vnXBR5uW8Hlri7P59s8N9O4+O
         /CHKOGc27pe8A4qmI9mmcmm5KkKxwmtIQEnYL9io2w4ElfSRdljJAMDJzZmjP6jTOb
         j76VShIofl21ZYswsRcQ4HM/X1woIqBZFyiOzDSk1hEj0rZkZIlmEJM0XG/b0czMmU
         KwvAwJJ3AJEKGTFvjmuSrTNKpPJPlDC3T24UusYc4+4N5RDwURvp99O9Rk/7rDQbdO
         /YSxBJHpIGSOjt0MTVquGI1Dwl5KXFB2NVmfvJYONy72Oa0qN64lO6r7CyDEmjN1Yx
         TKZpBG7211ZPw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>, nikita@trvn.ru
Cc:     siddharth.manthan@gmail.com, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        jja2000@gmail.com, ~postmarketos/upstreaming@lists.sr.ht,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v3 0/3] Add support for Samsung Galaxy tab A (2015) tablets
Date:   Wed, 18 Jan 2023 20:16:57 -0600
Message-Id: <167409461439.3017003.12114565962848726602.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230107141911.47229-1-nikita@trvn.ru>
References: <20230107141911.47229-1-nikita@trvn.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_ANY_PILL_PRICE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Jan 2023 19:19:08 +0500, Nikita Travkin wrote:
> This series introduces basic support for two Galaxy Tab A
> tablets: 8 and 10 inch variants. They share most of the
> hardware and are mainly dffernet by the display.
> 
> With this series both tablets gain support for things like
> - SDHCI (internal and external storage)
> - USB Device Mode
> - UART
> - Regulators
> - WCNSS (WiFi/BT)
> - GPIO keys
> - Fuel gauge
> - Touchscreen
> - Accelerometer
> 
> [...]

Applied, thanks!

[2/3] arm64: dts: qcom: Add device tree for Samsung Galaxy Tab A 9.7 (2015)
      commit: 7cc406151a99ec1643ed8bf3c52fa5fbdf74238f
[3/3] arm64: dts: qcom: Add device tree for Samsung Galaxy Tab A 8.0 (2015)
      commit: 41adc65ca5a4a3a651def2ae84ccbef7eed7cb24

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
