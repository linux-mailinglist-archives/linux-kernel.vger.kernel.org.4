Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4156A702287
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 05:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238459AbjEODjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 23:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238737AbjEODih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 23:38:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4B32103;
        Sun, 14 May 2023 20:35:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4C0261E2F;
        Mon, 15 May 2023 03:29:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11659C433A4;
        Mon, 15 May 2023 03:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684121364;
        bh=HRIToHkGRH4pOwUqzIxZbRZQcsaatfgrVmn3/fmoO2k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wkjp9hT9C49r4vpCOdfUfIkvNe6/cADSqzn9ZnGexdj48j8U4B23D42YPQzeIqAEG
         9Geo7iMJF2iPp1PYRb+d86aPQmUH3ufrkEba5dTo3qprSnjWb1jtFZw+goQGkqK4XH
         6Ne3yhooro08/u3YQCpXF1PiIfPeNm8+VopHhTn20Z+DMJnzhs9JDCMS1DiaciKkVC
         LMXjtkTS0B3BwFlKabVvoL4ylt+PKAWPCc2qoyVR/wSmvzNtXIXxTI6vkQsa2i3tqz
         RqJWaxJKcJFA2nMgSWOPcUHJQnb9PNL2isLj31iZQWE+KgizHKmWFHh60WbbCMjNXo
         DeXE/mtv+TDOA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Will Deacon <will@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: (subset) [PATCH v4 0/5] arm64: dts: qcom: sa8775p: add more IOMMUs
Date:   Sun, 14 May 2023 20:33:02 -0700
Message-Id: <168412158455.1260758.7417505729277068962.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230417125844.400782-1-brgl@bgdev.pl>
References: <20230417125844.400782-1-brgl@bgdev.pl>
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

On Mon, 17 Apr 2023 14:58:39 +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add the GPU and PCIe IOMMUs for sa8775p platforms as well as the required
> GPU clock controller driver.
> 
> NOTE: I didn't pick up Krzysztof's tag for patch 4/5 as the patch changed
> significantly.
> 
> [...]

Applied, thanks!

[1/5] arm64: defconfig: enable the SA8775P GPUCC driver
      commit: 8125a56125114d91843918cc6ef95367c4c39fc7

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
