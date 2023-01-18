Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 136F9672D14
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 00:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjARXzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 18:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjARXzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 18:55:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A5211E98;
        Wed, 18 Jan 2023 15:55:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B773861AD7;
        Wed, 18 Jan 2023 23:55:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C0B0C433EF;
        Wed, 18 Jan 2023 23:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674086146;
        bh=TlCGe3jm9IOAFbDfZMy+4tOtyu4bG1qGh8/i1DThhpc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mlZ4EDZAwcs17IOZz4Lmare2MFx9HT4NnOJIrGEz+EPC0k1kI1oMSDkmtXhomn5vc
         fnO9WoTSTM9n/S31J1K3dkFSQNm8rFIC/RgmP8wEdbosBENnFDckxA7/BXXJlB21HI
         vpi7pGuKDHMGGAhW7cjoOQxGVABbJbkaDlBpl3JIX99oVHrzah1SHn7UzJud4W3M3e
         f6VAk7XEQ4whH7y66Ut9aG7ijG4gTY7mCOquxQBCLekZRITb8N/UQNb+Q/f3acBlUs
         zPiNJKxgsRUeJmwPDIl1zJhkBt1lZ+zwiqCss8ZVJORDamHvuIqFbGicYWE+jK4o2O
         VY5pxBDq4mNFA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>, abel.vesa@linaro.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 0/2] arm64: dts: qcom: sm8550: Add PCIe HC and PHY support
Date:   Wed, 18 Jan 2023 17:55:31 -0600
Message-Id: <167408614065.2989059.2950818972854332656.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230118230526.1499328-1-abel.vesa@linaro.org>
References: <20230118230526.1499328-1-abel.vesa@linaro.org>
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

On Thu, 19 Jan 2023 01:05:24 +0200, Abel Vesa wrote:
> This patchset adds PCIe controllers and PHYs support to SM8550 platform
> and enables them on the MTP board.
> 
> The v1 was here:
> https://lore.kernel.org/all/20221116130430.2812173-1-abel.vesa@linaro.org/
> 
> Changes since v1:
>  * ordered pcie related nodes alphabetically in MTP dts
>  * dropped the pipe_mux, phy_pipe and ref clocks from the pcie nodes
>  * dropped the child node from the phy nodes, like Johan suggested,
>    and updated to use the sc8280xp binding scheme
>  * changed "pcie_1_nocsr_com_phy_reset" 2nd reset name of pcie1_phy
>    to "nocsr"
>  * reordered all pcie nodes properties to look similar to the ones
>    from sc8280xp
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: qcom: sm8550: Add PCIe PHYs and controllers nodes
      commit: 7d1158c984d37e79ab8bb55ab152a0b35566cb89
[2/2] arm64: dts: qcom: sm8550-mtp: Add PCIe PHYs and controllers nodes
      commit: 1eeef306b5d80494cdb149f058013c3ab43984b4

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
