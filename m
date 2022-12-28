Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A394A658649
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 20:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233191AbiL1TOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 14:14:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232887AbiL1TNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 14:13:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9680915FC2;
        Wed, 28 Dec 2022 11:13:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 51ABBB818B4;
        Wed, 28 Dec 2022 19:13:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6286CC43396;
        Wed, 28 Dec 2022 19:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672254829;
        bh=ikSaEpGESi6nJo2oNemB0/e9dQjk6n8wX0aBYShZfG4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lj3ThX/NjGmPjg61NGPGciUEW0S5HM3Gxzo4XMTYRNGnr1ZbT2ZvBY9duoy77nb5W
         mgUV8YU9CWnuA+mxP45fRyxnbqAEn+Qz9Mi/q389zhvN+5j+Cesi53Jz45D75oiaXh
         bnTontD2C028+qazg1Z4JNjJ8DgvBbyxYODKHBX5s+vj4M6nj8Ioj6qY/QB8aJiBzF
         U785XBgcYCb1PpFUkmZRbtXXMzz2aOnEzjfQ44LoxA2hWGEwN6uf8xa+pOcuyyBgI1
         3hl+HrS0VR1DBv3LKnGzfZ/dFI8v2oOvz/FmfAWWtKkKT9UvQwR9uyf6mVSAXtEbwD
         FWzofy0RKwCiQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     quic_youghand@quicinc.com, konrad.dybcio@somainline.org,
        agross@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, quic_mpubbise@quicinc.com,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3] arm64: dts: qcom: sc7280: Add wifi alias for SC7280-idp
Date:   Wed, 28 Dec 2022 13:13:44 -0600
Message-Id: <167225482208.977158.6544697528495697859.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221228094104.356-1-quic_youghand@quicinc.com>
References: <20221228094104.356-1-quic_youghand@quicinc.com>
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

On Wed, 28 Dec 2022 15:11:03 +0530, Youghandhar Chintala wrote:
> Currently, depth-charge Chrome OS bootloader code used in the SC7280
> SoC accesses the WiFi node using node names (wifi@<addr>). Since
> depth-charge Chrome OS bootloader is a common code that is used in
> SoCs having different WiFi chipsets, it is better if the depth-charge
> Chrome OS bootloader code accesses the WiFi node using a WiFi alias.
> The advantage of this method is that the depth-charge Chrome OS
> bootloader code need not be changed for every new WiFi chip.
> Therefore, add wifi alias entry for SC7280-idp device tree.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sc7280: Add wifi alias for SC7280-idp
      commit: dc58c4d160e72cb28445074c54cc5069bda086a5

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
