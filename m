Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B3670225E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 05:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238905AbjEODbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 23:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238790AbjEODaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 23:30:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE12C2D71;
        Sun, 14 May 2023 20:29:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E85B461E24;
        Mon, 15 May 2023 03:29:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C28C4339C;
        Mon, 15 May 2023 03:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684121361;
        bh=4tkjjLigultxX06hgQhfDnpBDgfjBXuWZiQgBzAfQsk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qX/+RDFEikaqSjNDGyYOZiK/zPfebMUeOKrWlmWUlhNU1H5G+1S2ZbIMaaNkpizlJ
         vxzcOR7uRCGJE1VZICFR39iiivLdmsN/7u/wtD7IR5FjUmfbFHyAk1/cxoDqqXeQcc
         X84US/5NZgy+P77gnYMVniLdZh07ScJ+bAIdhwRzno+Ys3uCURk0tVKLBwfIzVVU6C
         arfrY1qlPIQS+Yp3aui3VeCxt5jHePZOK3rnZhfTzlHy4iHApcvLIPblJxPGV8n1SH
         mhjdJ7woI4OF/Q0RTbUDBY5TW/OSLHacpFuUJ7JLJMoh3lNcaGq0eg7UD2DvTC6VY0
         DszqVEf8BN3Tg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Will Deacon <will@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: (subset) [PATCH v2 0/3] arm64: qcom: fix the reboot reason handling on sa8775p
Date:   Sun, 14 May 2023 20:33:00 -0700
Message-Id: <168412158455.1260758.14595564908295968594.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230417145536.414490-1-brgl@bgdev.pl>
References: <20230417145536.414490-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Apr 2023 16:55:33 +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> SA8775P uses nvmem to pass the reboot reason magic value to the bootloader.
> Remove the reboot modes from the PON node and introduce an SDAM node passed
> to the nvmem-reboot-mode driver. While at it: convert the bindings for
> nvmem-reboot-mode to YAML and enable it for arm64 in defconfig.
> 
> [...]

Applied, thanks!

[1/3] arm64: dts: qcom: sa8775p: pmic: remove the PON modes
      commit: 40d5835998705c28b985b1325114114c6007546e
[3/3] arm64: dts: qcom: sa8775p: pmic: add the sdam_0 node
      commit: 6c92689a0a57b40c758a12c1ca668d6a36a805a6

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
