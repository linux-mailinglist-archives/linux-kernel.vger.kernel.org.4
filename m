Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51805B8D86
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 18:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbiINQw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 12:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiINQwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 12:52:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024A480015;
        Wed, 14 Sep 2022 09:52:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 929C8616D9;
        Wed, 14 Sep 2022 16:52:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A461C433D6;
        Wed, 14 Sep 2022 16:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663174342;
        bh=bKNrMdHprsILnukvI8Zq4wykxeN5B3O1FaspcWdZiAs=;
        h=From:To:Cc:Subject:Date:From;
        b=gsJOYb5/dcOLw30X24I/qwdLHwSqdx7XvxwI7gpTNiSetu9Gxi5oeNeCmZSS4B5Km
         lrTZCbbT0dBNj/bRNKqbn4Czu76UGoytaqwxiX/j4aC2GGuOz0Sw7jNVPhy9K3OnS1
         /fZv+w1Ma4Lgb8BuOliZtd1OxY6TtpE1N9iN6qvRArMoFXEsI70Qc1OR/cJfDFbnXe
         1hGSPajaeXFFbMpqzbLkAILf2oxrny5jbrGEqCCyLo1fpaF1GXa6BWw8kGTr5kweRs
         b7dhu/tIkDf7bcOfgILNeRBYRF3GPc/2yQXzWJ+RLk/W36KpzZGL1EE7YnNdGz1fw6
         Ih529e4wkz92A==
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org
Subject: [PATCH v5 0/2] spmi: pmic-arb: Add support for PMIC v7
Date:   Wed, 14 Sep 2022 22:22:10 +0530
Message-Id: <20220914165212.3705892-1-vkoul@kernel.org>
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

The is version 5 of support for PMIC v7. I have added a new property
qcom,bus-id for supporting v7 and then add driver changes for v7

Changes since v4:
 - Fix David name and email
 - remove trailing line in binding

Changes since v3:
 - rebase on spmi/next

David Collins (1):
  spmi: pmic-arb: Add support for PMIC v7

Vinod Koul (1):
  dt-bindings: spmi: Add qcom,bus-id

 .../bindings/spmi/qcom,spmi-pmic-arb.yaml     |  10 +
 drivers/spmi/spmi-pmic-arb.c                  | 242 ++++++++++++++++--
 2 files changed, 231 insertions(+), 21 deletions(-)


base-commit: 18c42f8d23426d3f4048df89523aa47203c3493a
-- 
2.37.3

