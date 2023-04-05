Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 567D96D7312
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 06:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236925AbjDEEHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 00:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236825AbjDEEGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 00:06:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0074EDD;
        Tue,  4 Apr 2023 21:06:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A295A63978;
        Wed,  5 Apr 2023 04:06:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36B1BC433AA;
        Wed,  5 Apr 2023 04:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680667588;
        bh=Ui3jnieI9AXk4LCarQBNQu0M1iAeft4liE1RMONuhn0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hf5nApxgEjxSp63b4WYC0vL9WIjsqyHQ35JGRfMiYRuzmK63vvPB47Bszh8M/A/lA
         bHLb+uMhj6/GmBKd1uNxGa0Ui9g3RrivkxQ2rrIthyGornOQjpodsjRN2cr99R5dKP
         qK+8RfE9PG6EL4KXgZG0E5zfHLRiKahm7QzSd1cpefI7iXTurPcoUs0ojvAW9MZus3
         s06HnJeP6jzWb299geQYoICC+H4aCc2h5nxCBNApRZrqqYz+Hpq0dlNyegsuxaVpGX
         QQhAi/9OPp9tmOpqRd1EUbUMzeUmXGK56aq+C3j0la4avspxBzNuNONETIXlwNExwC
         /NeZPvx6OGmMA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: (subset) [PATCH v3 0/7] Fix BWMONv4 for <SDM845
Date:   Tue,  4 Apr 2023 21:08:59 -0700
Message-Id: <168066774413.443656.15060107491615957803.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230304-topic-ddr_bwmon-v3-0-77a050c2fbda@linaro.org>
References: <20230304-topic-ddr_bwmon-v3-0-77a050c2fbda@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Mar 2023 15:11:18 +0100, Konrad Dybcio wrote:
> v2 -> v3:
> - Rename: "DDR BWMON" -> "CPU BWMON" [2, 6/7]
> - Set F_IRQ_STATUS = F_NUM_GLOBAL_FIELDS in enum bwmon_fields to save
>   one space in the enum
> - Correct the struct icc_bwmon->global_regs array size
> - Reorder the "Remove unused struct member" patch to come before the big
>   one
> 
> [...]

Applied, thanks!

[4/7] arm64: dts: qcom: sc7280: Use the correct BWMON fallback compatible
      commit: bad26511c4cb5469545834886e8df1d2b4c117d8
[5/7] arm64: dts: qcom: sc8280xp: Use the correct BWMON fallback compatible
      commit: 5e1b11c00ffc0a2d105af5a92053fa10ca15fcd0
[6/7] arm64: dts: qcom: sdm845: Use the correct BWMON compatible
      commit: e95b60f1207dee16e0d3d66254ece655fd4e73c0
[7/7] arm64: dts: qcom: sm8550: Use the correct BWMON fallback compatible
      commit: feffd767971e25f43ba47bf2ab23a660f3a3758c

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
