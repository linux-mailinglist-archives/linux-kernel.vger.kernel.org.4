Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 537BE665387
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 06:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234554AbjAKFTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 00:19:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjAKFSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 00:18:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A2213DFA;
        Tue, 10 Jan 2023 21:09:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9F7A3B81AD7;
        Wed, 11 Jan 2023 05:09:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98CEEC433F2;
        Wed, 11 Jan 2023 05:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673413795;
        bh=9nJcAZKtVH88u96eaZwyHZOGTioTiHUDb0PaFuFEimg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hk4k8jQVUo/RpLKLNQQOpon2WsWKwCF15+U2fRXBKtCJ9LsvRkR4d48wxsxBz61pX
         G2QLj/4oiN3Gdrz8t9S5LY1YxKtnO3bjd3LSWkghnT97H5WpDEjs2By3nErpamHqnj
         rQgVXnhAwfp4WjZEeGTjnuMocK64vckiX0F4MAk4bvKsWUbF4wOvc8Kt08tl9Z/GDn
         v4njM4oPkcmzz+JYo0gCMLg/TAXpeKOHNWQQ8MyLVDldui3Q/6Ym8xIwCWbuVOP461
         EhmU8nP7JmGQiPxtKIxOJ3yZ5GtjjVIG19pHgZIM0M1vnQLcKwvB4pUhRbddFrefkn
         NEFqU6cwjZnEQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-arm-msm@vger.kernel.org, konrad.dybcio@linaro.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: msm8998: Use RPM XO
Date:   Tue, 10 Jan 2023 23:09:20 -0600
Message-Id: <167341377736.2246479.578626530362512664.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230110143642.986799-1-konrad.dybcio@linaro.org>
References: <20230110143642.986799-1-konrad.dybcio@linaro.org>
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

On Tue, 10 Jan 2023 15:36:42 +0100, Konrad Dybcio wrote:
> Feed GCC and SDHC_2 with the RPM XO instead of the fixed-clock one.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: msm8998: Use RPM XO
      commit: 83fe4b9efb03d8b1f9a724c965f0f76574a840cd

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
