Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4292765893A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 04:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbiL2Dpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 22:45:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbiL2Dpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 22:45:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C72B3F;
        Wed, 28 Dec 2022 19:45:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 68D16B816E4;
        Thu, 29 Dec 2022 03:45:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7066CC433EF;
        Thu, 29 Dec 2022 03:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672285542;
        bh=alCJu5XAjMvKb+w02CBSziyyOEltpCAw/XCcSnAbcuk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AWVpuj5foLvPtcXPEKqfw0DoLzqyOXgKpm8loWrcWzFCx9x1HAGhq1+H2xh6FDgft
         tiOxrDVp42TPAczZTjiaTkNCyYelRu20N7woz+978EI9U2qo6D4sM6IdbrTLjJm9b9
         BDYjBz4hkRwGBlqFp35eyon5jyCkJscIJVhqb2A732TGBiK3d29+nVmZHyuxDyeI7a
         AkUqXhS7acN3Gu4GTg61iI2ijgBZNZbhdo5nO7F+8XWJZZV+1gshYlBR8Z02nRLJGU
         ZYtCzy1PNtJFO39EmgrTvIDu3rH3HRI+ouTvdVNVVBCdeY9BV/5LQdLrBmn1CWUDZW
         u5JbdpRlv3fcA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     keescook@chromium.org, Tony Luck <tony.luck@intel.com>,
        luca@z3ntu.xyz, gpiccoli@igalia.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        agross@kernel.org, konrad.dybcio@linaro.org
Cc:     linux-kernel@vger.kernel.org, a39.skl@gmail.com,
        krzysztof.kozlowski@linaro.org, devicetree@vger.kernel.org,
        ultracoolguy@disroot.org, vladimir.lypak@gmail.com,
        morf3089@gmail.com, atafalla@dnyon.com,
        linux-arm-msm@vger.kernel.org, jenneron@protonmail.com,
        ~postmarketos/upstreaming@lists.sr.ht, julianbraha@gmail.com,
        fekz115@gmail.com, JIaxyga@protonmail.com,
        sireeshkodali1@gmail.com, linux-hardening@vger.kernel.org,
        phone-devel@vger.kernel.org
Subject: Re: (subset) [PATCH v3 0/9] Add a bunch of msm8953 dts files
Date:   Wed, 28 Dec 2022 21:45:38 -0600
Message-Id: <167228553507.1017132.4894386227853517055.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221207-msm8953-6-1-next-dtbs-v3-v3-0-a64b3b0af0eb@z3ntu.xyz>
References: <20221207-msm8953-6-1-next-dtbs-v3-v3-0-a64b3b0af0eb@z3ntu.xyz>
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

On Wed, 07 Dec 2022 19:30:37 +0100, Luca Weiss wrote:
> The following patches add a bunch of msm8953-based devices that have
> been created in the msm8953-mainline[0] repository, which includes
> Snapdragon 450 (SDM450), Snapdragon 625 (msm8953) and Snapdragon 632
> (SDM632) devices.
> The dts files are trimmed down to what is currently supported upstream,
> as a way to also minimizing diff for further patches.
> 
> [...]

Applied, thanks!

[2/9] arm64: dts: qcom: msm8953: Adjust reserved-memory nodes
      commit: eca9ee35e895686d179964dc6f94e6c473d2a171
[3/9] arm64: dts: qcom: sdm450: Add device tree for Motorola Moto G6
      commit: eee5a89b4fe5615ba57fd8048102504aaa052065
[4/9] arm64: dts: qcom: msm8953: Add device tree for Motorola G5 Plus
      commit: 4ccd0dd6a3d2a98b11664992012af04cb0ce8f6c
[5/9] arm64: dts: qcom: msm8953: Add device tree for Xiaomi Mi A2 Lite
      commit: 38d779c26395df5f7f66bb5da7af6241180283e1
[6/9] arm64: dts: qcom: msm8953: Add device tree for Xiaomi Redmi Note 4X
      commit: c144005129b09141b292820d35f0094e54b12d6d
[7/9] arm64: dts: qcom: msm8953: Add device tree for Xiaomi Mi A1
      commit: cf152c05eb35afc9db3c9480ce17b27a703b2893
[8/9] arm64: dts: qcom: msm8953: Add device tree for Xiaomi Redmi 5 Plus
      commit: aa17e707e04a0446de5e40f74aac979582185559
[9/9] arm64: dts: qcom: sdm632: Add device tree for Motorola G7 Power
      commit: 3176c4d6b9beba4a554bebba6b19b56942705a28

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
