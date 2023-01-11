Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78184665398
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 06:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235913AbjAKFVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 00:21:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjAKFSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 00:18:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5199F13F32;
        Tue, 10 Jan 2023 21:10:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF52461A36;
        Wed, 11 Jan 2023 05:10:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85415C43396;
        Wed, 11 Jan 2023 05:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673413808;
        bh=Po03iDcVjabOWqJnN2uVLAYw/OyRf+9tqGMzaLJcnYQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C0Bhp3e/RrCYv5j13kFtj/d9IDg1MsKKQdNqtxJjiJ+43eOJOEVIhU0p+VJ+T+Pxe
         4fGX/Q0kDa6w/SdMgg0NZUZByl9+K4fBEDYoyTjznsEo1/Y1qaaADg8Tn7PDMIXroU
         JYQUNwkf0MdE2J6ErrsHTIDbjgRMR1nA7D6I1cvQBycWL8KGhUmD8yo0Tod95ZckKN
         1g8w5xACBD4NDQxc5jz18UkceWh1EJagGQtm1gaEcJCt7b+pGKTtmVGHN6g7HjDTU8
         0OOT0Yb2qV0VUNKU6X2jjpKgfD/Q1U5YcKDlXpCdVFuZVH/MRGIsiXohFcCoWubqjj
         goYeYlod+Gv4w==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        rnayak@codeaurora.org, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, agross@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, swboyd@chromium.org,
        kgunda@codeaurora.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v2 1/4] arm64: dts: qcom: sc7180: correct SPMI bus address cells
Date:   Tue, 10 Jan 2023 23:09:33 -0600
Message-Id: <167341377723.2246479.16688396521083748321.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221213101921.47924-1-krzysztof.kozlowski@linaro.org>
References: <20221213101921.47924-1-krzysztof.kozlowski@linaro.org>
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

On Tue, 13 Dec 2022 11:19:17 +0100, Krzysztof Kozlowski wrote:
> The SPMI bus uses two address cells and zero size cells (second reg
> entry - SPMI_USID - is not the size):
> 
>   spmi@c440000: #address-cells:0:0: 2 was expected
> 
> 

Applied, thanks!

[1/4] arm64: dts: qcom: sc7180: correct SPMI bus address cells
      commit: 1f75745537222172f84783d369bbd1fb2d4b6414
[2/4] arm64: dts: qcom: sc7280: correct SPMI bus address cells
      commit: 8da3786a91e56fe0c4aeb2c2209744474af6e517
[3/4] arm64: dts: qcom: sc8280xp: correct SPMI bus address cells
      commit: 76d9e8b4d54ae2cb91a68f0cb82624887de767a7
[4/4] arm64: dts: qcom: rename AOSS QMP nodes
      commit: bb99820dd284a9bae63d713431d84b1832d222a1

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
