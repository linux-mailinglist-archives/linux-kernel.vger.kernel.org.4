Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3870474CBD0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 07:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjGJFGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 01:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbjGJFFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 01:05:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0251985;
        Sun,  9 Jul 2023 22:04:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7EF1C60DF3;
        Mon, 10 Jul 2023 05:04:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22660C433C8;
        Mon, 10 Jul 2023 05:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688965492;
        bh=OXintvStWPY/Rn//5Om9zDsg1msekWSP2yTLF/pVnEA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=KyOa4u/kwrVRd4BVwAf1uLC7EIbnXNlkZ7QQZ5jdhwfYXLOsbkUFZbq4kaLM2gRSn
         VxU0FR0xC6Ro1zf0EuyStKlHxyxtgrQYorgc9bFdy6Tne5pW2aGbEsO5dquQEgelsO
         4Is7x8m014lAFNBVyx1y/rUUZXWP68oELpQrYBaThqUPW85DLRq/Tn9UictDKpmyF5
         Xk3gXfuw5aNF0hJIgysIwghcvqo/T5ykz79u2pFgcjD3p1tCIKfFoAtboawtsGY3bA
         gbPzJQxIxp1w3Xt/m1lzz1WSIgTKyzNklIIMGyPAW4q8xHdf9Oez8FSUTB4jVz3hcv
         qrnosuK4bWFyA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] arm64: dts: qcom: add missing space before {
Date:   Sun,  9 Jul 2023 22:07:32 -0700
Message-ID: <168896565989.1376307.16596846019737958398.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705144226.280490-1-krzysztof.kozlowski@linaro.org>
References: <20230705144226.280490-1-krzysztof.kozlowski@linaro.org>
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


On Wed, 05 Jul 2023 16:42:26 +0200, Krzysztof Kozlowski wrote:
> Add missing whitespace between node name/label and opening {.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: add missing space before {
      commit: 068be6cb4b98a8a26426b603b23582b78630dd23

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
