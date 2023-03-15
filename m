Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E346BC120
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 00:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbjCOXdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 19:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbjCOXc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 19:32:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B057830E8B;
        Wed, 15 Mar 2023 16:32:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8EB8961E7F;
        Wed, 15 Mar 2023 23:32:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 588E7C433A1;
        Wed, 15 Mar 2023 23:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678923140;
        bh=Czjipwi+z5BYD6dc6gqGxWPjzC1ZNzWInqNzGqJMQSc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bkk0mOhSDDRx1zt0HabmgLbT89tjX+13qdcM8DiR8zHlqorCtIzC4dvWIoevQoSYI
         oCaPZsBIBa0s4gz3r25/HqBlovXPZmUu7ERE/NQSXOi0IYS06LMdX/y0+TY0Us8qQq
         7E2AOuZoMDDIFqk87PqfWarr7Kce0VzULe4dJPolhpcgH4GdsP4nqxZJCd06KYUm9X
         EY/yPLmiiZJ6MHXOgwV1jhoYE1UwtGN4BGT9owI9bp54GFQ03r3hXZZt88P9OC16PS
         sBifq2wDXlqzXqws7cq21QuLwJ+/mx9PK9yt/63+ptl2KBN9JDX3bP61NdWzMsjE0K
         L5tBmDvfW/+tw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     konrad.dybcio@linaro.org, agross@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        Danila Tikhonov <danila@jiaxyga.com>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] soc: qcom: socinfo: Add SM7150 ID
Date:   Wed, 15 Mar 2023 16:34:49 -0700
Message-Id: <167892332567.4030021.15378870372973669708.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230305191745.386862-1-danila@jiaxyga.com>
References: <20230305191745.386862-1-danila@jiaxyga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Mar 2023 22:17:43 +0300, Danila Tikhonov wrote:
> This series adds ID for Qualcomm SM7150 SoC.
> 
> David Wronek (2):
>   dt-bindings: arm: qcom,ids: Add Soc ID for SM7150
>   soc: qcom: socinfo: Add Soc ID for SM7150
> 
> drivers/soc/qcom/socinfo.c         | 1 +
>  include/dt-bindings/arm/qcom,ids.h | 1 +
>  2 files changed, 2 insertions(+)
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: arm: qcom,ids: Add Soc ID for SM7150
      commit: de7aeee0d942d2e1d85b3db3652e037af38e24d7
[2/2] soc: qcom: socinfo: Add Soc ID for SM7150
      commit: bad8cdc20690fa830c49783b68c6403dd44bc0bd

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
