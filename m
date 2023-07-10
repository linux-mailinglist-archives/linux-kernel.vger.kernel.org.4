Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38CB274CBE7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 07:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbjGJFHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 01:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjGJFGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 01:06:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3732117;
        Sun,  9 Jul 2023 22:05:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10EC260DE8;
        Mon, 10 Jul 2023 05:05:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8660C433C7;
        Mon, 10 Jul 2023 05:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688965507;
        bh=XRFFV/M0m9Av1bD9IIgpByfIwoEDGoERPGjHZEmPOaY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ksQB2piS88juuZm8/s/RSE/RMjCIi1GPE+2tWJIvIeZqhpaY9Np+MkqW5K1WVXPFI
         jgMQM1ERoJ5fDaJ+SGWc9UXh/R8IWHIbsBHBefC/OcvpPovFgaABhvEl2zaSpyOyTR
         OfM7WFmvR6DInGq3brlO582nPncLihYfrKAcH2hpEXVKK/0yJb/m5TQGx9hxYULqSq
         dh+anv44S3rHHBpvKkVsMA+noE/ppjF/52SF6IVw9Ldr59g/WC/tQOlKAZjVz3xlTl
         0tgrg3AP3BlkCLuoSDmpYMWNyplCqucyVslwRytr6LDAt+NPUU05FPX6VHrru4eG2z
         2Cm/ADDqNMezQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        Komal Bajaj <quic_kbajaj@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] arm64: dts: qcom: qdu1000: add reserved gpios
Date:   Sun,  9 Jul 2023 22:07:45 -0700
Message-ID: <168896565987.1376307.686225036562384535.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705091730.32087-1-quic_kbajaj@quicinc.com>
References: <20230705091730.32087-1-quic_kbajaj@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 05 Jul 2023 14:47:28 +0530, Komal Bajaj wrote:
> Add reserved gpios on QDU1000 and QRU1000 IDP platform.
> 
> Changes in v2:
>  - Split changes into per-board commits.
>  - Updated the commit message.
> 
> Komal Bajaj (2):
>   arm64: dts: qcom: qdu1000-idp: Add reserved gpio list
>   arm64: dts: qcom: qru1000-idp: Add reserved gpio list
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: qcom: qdu1000-idp: Add reserved gpio list
      commit: 5a89585fc880a56bdeed6132d0568d99a29e4231
[2/2] arm64: dts: qcom: qru1000-idp: Add reserved gpio list
      commit: 301f7ca3574c05c3ae62d6d5ac1fa0c48cd4b080

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
