Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFED60221A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbiJRDKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbiJRDIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:08:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473179AF9F;
        Mon, 17 Oct 2022 20:07:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0648C61371;
        Tue, 18 Oct 2022 03:07:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1E18C43141;
        Tue, 18 Oct 2022 03:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666062424;
        bh=xLr45fjjYMsaA2oWkGlLP6xqQPpBY0Nk6pN8GqVbgpk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=TJs5AX/Fl0uv/cddO+TQeO5mP/02ak5a1d7iC10zuenrjofuxCBWXGNvOMtkoK9hJ
         qUKDZWQKfuAbdbiI5xaHAZj/LcVZ3jTtgpqr8GvVOi3zBPOcKI52qFQQucHPIAy1s4
         wVwVO+A0CLgN6H//xP3YhDfMQRhWCLbTbNtEPpAMlRyHVhOvhzZXQmHUXxbm7CwSfC
         PS43LyC3hdOAW6bISLVVzQ2/wGkFih4aYljIiuXW8WA7JftO/LnaR6qaBp/vfrMEXK
         p0soKwkWQ7w5kgsrNsHRBlqnH8CAeHcu6zK/iM6kPCdIfSx4FEM/PIp79/6V/CFQSS
         kPMcJoTUuMduQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, agross@kernel.org,
        krzysztof.kozlowski@linaro.org, linus.walleij@linaro.org,
        robh+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: (subset) [PATCH v2 1/4] arm64: dts: qcom: sdm630: add UART pin functions
Date:   Mon, 17 Oct 2022 22:05:38 -0500
Message-Id: <166606235861.3553294.8390135332228667844.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221011190231.76784-1-krzysztof.kozlowski@linaro.org>
References: <20221011190231.76784-1-krzysztof.kozlowski@linaro.org>
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

On Tue, 11 Oct 2022 15:02:28 -0400, Krzysztof Kozlowski wrote:
> Configure UART1 and UART2 pins to respective functions in default state,
> otherwise the pins might stay as GPIOs.
> 
> 

Applied, thanks!

[1/4] arm64: dts: qcom: sdm630: add UART pin functions
      commit: 804ec4dad48c4fc7844c66b5febe9dbc6198f8b5
[2/4] arm64: dts: qcom: sdm630: correct I2C8 pin functions
      commit: 06783c3ae8899aa71abc795d3d6490a4afa9ed99
[3/4] arm64: dts: qcom: sdm630: align TLMM pin configuration with DT schema
      commit: 048a765ac5712397cb58e374a7e1087c34875b5f

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
