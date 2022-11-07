Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF2361E906
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 04:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbiKGDNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 22:13:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbiKGDMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 22:12:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE311DFB2;
        Sun,  6 Nov 2022 19:12:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B7B760E9B;
        Mon,  7 Nov 2022 03:12:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38714C43141;
        Mon,  7 Nov 2022 03:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667790766;
        bh=STJJxFZWs8QLPw6vWl3DqO5ZoiZ0mWNzAxhomjmJWOw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kYxlldgBltm9nLhagRWkb3XE/iZh6kYBDEeg9fEBSHiNV/3+gcY58eWtMnb0pH9hT
         1g6VEqi7qrCOMdhEsX6abONxrV2lJjSGQRq96W51yzou/vwThKbhtf2rC3r3vpva8C
         i2QmhSSGRWDHMk/h+ZPCLLB2526S4Y2F1k6dGFueF/5TZOAFMW/NgKVThm0fgpCAYh
         hCGW+M9LuUVCzH/9iLtveQ7Mw9dC5L841PCSt9CCn9tBnKohNeD0ti4Wd9VfOmUBb9
         4AjxYL3GzCRrtWnz56h+Dxf6v1Ee0bSHKR+XDvjouOT5u0SUuqnqbOwf5VbP/vQf+8
         n1BesPLx1TMwA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     dsankouski@gmail.com, linux-kernel@vger.kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, konrad.dybcio@somainline.org,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH v3 0/2] add device Samsung Galaxy S9 phone (codename starqltechn) and board binding
Date:   Sun,  6 Nov 2022 21:12:04 -0600
Message-Id: <166779074258.500303.10247864226993145950.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221012185411.1282838-1-dsankouski@gmail.com>
References: <20221012185411.1282838-1-dsankouski@gmail.com>
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

On Wed, 12 Oct 2022 21:54:09 +0300, Dzmitry Sankouski wrote:
> Add initial support for Samsung Galaxy S9 phone (codename starqltechn) and board binding
> 
> Dzmitry Sankouski (2):
>   dt-bindings: arm: add samsung,starqltechn board based on sdm845 chip
>   arm64: dts: qcom: starqltechn: add initial device tree for starqltechn
> 
> .../devicetree/bindings/arm/qcom.yaml         |   1 +
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  .../dts/qcom/sdm845-samsung-starqltechn.dts   | 460 ++++++++++++++++++
>  3 files changed, 462 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: arm: add samsung,starqltechn board based on sdm845 chip
      commit: 20e88ca2960ee63450cc4b9383e387f18cc08fa8
[2/2] arm64: dts: qcom: starqltechn: add initial device tree for starqltechn
      commit: d711b22eee55ced0e32645706f20329be249e207

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
