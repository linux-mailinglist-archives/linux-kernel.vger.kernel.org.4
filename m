Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7825B8728
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 13:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiINLV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 07:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiINLVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 07:21:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D9DFC0;
        Wed, 14 Sep 2022 04:21:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B99D3B81A2E;
        Wed, 14 Sep 2022 11:21:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02B25C433D6;
        Wed, 14 Sep 2022 11:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663154511;
        bh=sAdPmyq+D3P0BT3CpUgtjd2Swtf0rHKdzk9Al2evg/E=;
        h=From:To:Cc:Subject:Date:From;
        b=eWDbRHkZ+8RiN15xf7dWOj40FoPbmLJiIYmy5nPl805zna+2jjN4ShdSEpTYeZ8Av
         hnkHlZKmS4VMggpABarVh9JXSigL/6RmtU7PLBbOOwzcbJRY9xQX/Ob8mS/VcWiNtd
         eWQbxlve7aOmtnI8O4d6lkVIc74pEVaDLynX3+j8bh07udFJcgoOojBmAny0IgVAxk
         Gt8R6Hvg2m0KKPtAIO9ckqIJBIk0y6vuujSf9UM9qBWy4UfqJjSMln3YO0Svybrgne
         TmZuxF5+r8CIX92LfPFayyFKyyTOEX7Sbmo/gasrOmwB3Gha7JIGivNHXN7fcxN2s5
         VxdECMgnrrj8w==
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org
Subject: [PATCH v4 0/2] spmi: pmic-arb: Add support for PMIC v7
Date:   Wed, 14 Sep 2022 16:51:37 +0530
Message-Id: <20220914112139.3680354-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The is version 4 of support for PMIC v7. I have added a new property
qcom,bus-id for supporting v7 and then add driver changes for v7


Changes since v4:
 - rebase on spmi/next

David Dai (1):
  spmi: pmic-arb: Add support for PMIC v7

Vinod Koul (1):
  dt-bindings: spmi: Add qcom,bus-id

 .../bindings/spmi/qcom,spmi-pmic-arb.yaml     |  11 +
 drivers/spmi/spmi-pmic-arb.c                  | 242 ++++++++++++++++--
 2 files changed, 232 insertions(+), 21 deletions(-)

-- 
2.37.3

