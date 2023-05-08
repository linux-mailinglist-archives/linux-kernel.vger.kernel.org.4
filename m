Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94CD46FB173
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 15:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234089AbjEHN12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 09:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234021AbjEHN1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 09:27:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACBD2FCCE;
        Mon,  8 May 2023 06:27:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6019463D34;
        Mon,  8 May 2023 13:27:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14B00C433EF;
        Mon,  8 May 2023 13:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683552432;
        bh=RlKHn1WfbUhFopUYq+iJPenXx0NBhKVWFakuSC0iDws=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=UMyuP6NmNroiwtG7+UAv502k3AqBkF4wD/7dIL2aDolwyaqaBNGc97EGHkSVUz8nE
         d1MZz5kkk3cXsTZKyNLPVMgP7c8lUydEwsWeLL1qS/JwyH2F5oYb2MINXAo9vqqTyV
         ar2/gHt6elxr69pMOAGJDLGtpkZccvTij1i/C28g0Zsm4ZJpHxU9a04psLQLsQPXbQ
         7shalt1pJVblrl5dU5qwF7u3/0ATlaDn7Nt4GYVYVICfVXFSTbK7k28YYre5JLeROi
         JV6XrMSH6nL6ITW/P8tURDkfJcuciHamwAkpsaa3BBGprFV1tkq3X1/5rIzj08S/0x
         siytZi/04hajA==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        Michal Simek <michal.simek@amd.com>,
        Michal Simek <michal.simek@amd.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
In-Reply-To: <2afed7285061abbb5d9ad3b1e795b737dcff9693.1683102032.git.michal.simek@amd.com>
References: <2afed7285061abbb5d9ad3b1e795b737dcff9693.1683102032.git.michal.simek@amd.com>
Subject: Re: [PATCH v2] dt-bindings: spi: zynqmp-qspi: Add power-domains
 and iommus properties
Message-Id: <168355243037.260152.6627127053306597242.b4-ty@kernel.org>
Date:   Mon, 08 May 2023 22:27:10 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 May 2023 10:20:36 +0200, Michal Simek wrote:
> ZynqMP QSPI IP core has own power domain and also iommu ID that's why
> describe optional power-domains and iommus properties.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] dt-bindings: spi: zynqmp-qspi: Add power-domains and iommus properties
      commit: 47e0255989560fbfd6cd0e03407982f37fdabe5a

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

