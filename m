Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52AF6021EA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbiJRDJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbiJRDHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:07:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C5F9AF87;
        Mon, 17 Oct 2022 20:07:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5EFDE6136E;
        Tue, 18 Oct 2022 03:06:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 099A4C43143;
        Tue, 18 Oct 2022 03:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666062418;
        bh=v6DlFppB1J9GHtILtSEWtrNdCZjLlgo0ZR+riS6hQ3E=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=A5YplbTi98fsxb5eleBATLsY9RfKzM+o5IzNezBYTui5oU1ohXo+n4vaSb7m2FA7K
         ulucGp5a3M5l4xvBU8x4sp31DXaMtQVFPb6yTFeOs7OsImIyIN87ID/Fdt9ydvE7B4
         kSxF7BNwpWAR0tEVTArbGQJIJ6QeIRUOq523oxUq47eQ4NCS53XUDoO3Gt/ZLFoczC
         7W+vhjC5eKgeKoT2C32IjoObcc+goYVToKkv4zdibnwRJeslNDMU2AqZl3pg9fMRqm
         tQcIp4p9yhmd+uTlPDc1BQkDS18tAIo4rgjscxbV4Xzq9mCgHCkHdnpaJiX6m18zEn
         71BoKfn6HHKVw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, agross@kernel.org,
        Lee Jones <lee@kernel.org>, krzysztof.kozlowski@linaro.org,
        robh+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: (subset) [PATCH 1/3] ARM: dts: qcom: use generic node name "gpio" in SPMI PMIC
Date:   Mon, 17 Oct 2022 22:05:32 -0500
Message-Id: <166606235853.3553294.16849733094115128032.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220908080938.29199-1-krzysztof.kozlowski@linaro.org>
References: <20220908080938.29199-1-krzysztof.kozlowski@linaro.org>
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

On Thu, 8 Sep 2022 10:09:36 +0200, Krzysztof Kozlowski wrote:
> GPIO controller nodes are named by convention just "gpio", not "gpios".
> 
> 

Applied, thanks!

[2/3] arm64: dts: qcom: use generic node name "gpio" in SPMI PMIC
      commit: c95243eeae587c0fbcaaf53bec9233400005c973

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
