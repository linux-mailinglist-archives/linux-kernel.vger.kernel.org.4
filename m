Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF95611DBF
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 00:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiJ1Wzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 18:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbiJ1Wzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 18:55:35 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA23171CC3;
        Fri, 28 Oct 2022 15:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1666997726; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=7rlLnd7xNWQad1M+asDuys3euM61zFqauDXbafni6hw=;
        b=Ar0nt1tO9pfYoUUqueO7Exx2jkrZsuCoDkr479Zdw66/HVlzo7fda9WGLLzA018o9Lufk3
        RDRDxNhCRHNPAnEHs8nZfp0jOZMQIRD4vnKwdN8R5JNpNS482AtGI61EREZsRw8/LT4NNW
        TbWP3wq+7Itna/nnb4zJ2QN5L2ZSP3A=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        od@opendingux.net, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 0/4] rtc: ingenic: various updates
Date:   Fri, 28 Oct 2022 23:55:15 +0100
Message-Id: <20221028225519.89210-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alessandro / Alexandre,

Here's the V2 of a previous patchset I sent back in April.

Patch [1/4] was updated with Krzysztof's feedback.

Patches 2-4 are unmodified from V1 as they didn't receive any feedback.
Patch 4 is RFC; I *think* it works, but I don't know how to test it.

V1 had a 5th patch which would reset the scratchpad register on power
loss, but was dropped following upstream feedback.

Cheers,
- Paul

Paul Cercueil (4):
  dt-bindings: rtc: ingenic: Rework compatible strings and add #clock-cells
  rtc: jz4740: Use readl_poll_timeout
  rtc: jz4740: Register clock provider for the CLK32K pin
  rtc: jz4740: Support for fine-tuning the RTC clock

 .../devicetree/bindings/rtc/ingenic,rtc.yaml  |  32 ++++-
 drivers/rtc/rtc-jz4740.c                      | 113 +++++++++++++++---
 2 files changed, 129 insertions(+), 16 deletions(-)

-- 
2.35.1

