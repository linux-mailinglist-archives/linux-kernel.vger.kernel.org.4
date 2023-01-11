Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54EF665393
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 06:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235319AbjAKFUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 00:20:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbjAKFSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 00:18:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3524C13F0F;
        Tue, 10 Jan 2023 21:10:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C706C61A32;
        Wed, 11 Jan 2023 05:10:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63910C433EF;
        Wed, 11 Jan 2023 05:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673413806;
        bh=aUggy9Y62tG/UjSmUEwgrWS1ypNcMdK/bOkpPWk72YI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ow1M6k5cAM1cDPiVSEemiQnaDJE75yaEDIioo50evyaXdbGbAE1gt97ASo37zwLiE
         WweGQDW0E/+mT01v+XgTGGklF6GO520rI6xwnJMQVJxqrIDglDdl5J+yFBqatO5363
         a33KEXsnWUrM/ObCNX1q+oSxeSFUKlV1uyyZkzMmcDLQkeGnye4SBcHI82qA4B/RFd
         DFyev82TXiQwH2jONVzB9vFPuKywMxfEniW7ooDDRGlzmsX0gcFUdNh20JWCli1XpP
         rM1CTGjvMZHQZyU+kqXve+wYAs/85rMm6EPBU41SpfMBe8Tdx1nyx6Av1GhcrOjsvs
         ak6gvbLqf2YjQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-clk@vger.kernel.org, konrad.dybcio@linaro.org,
        devicetree@vger.kernel.org, agross@kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        linux-arm-msm@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sboyd@kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH] dt-bindings: clock: qcom,spmi-clkdiv: convert to DT schema
Date:   Tue, 10 Jan 2023 23:09:31 -0600
Message-Id: <167341377730.2246479.10494358695788234107.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221223111835.37610-1-krzysztof.kozlowski@linaro.org>
References: <20221223111835.37610-1-krzysztof.kozlowski@linaro.org>
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

On Fri, 23 Dec 2022 12:18:35 +0100, Krzysztof Kozlowski wrote:
> Convert Qualcomm SPMI PMIC clock divider bindings to DT schema.
> 
> 

Applied, thanks!

[1/1] dt-bindings: clock: qcom,spmi-clkdiv: convert to DT schema
      commit: 3c4af3ab1f68ddceb548094d680bc71806a09aee

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
