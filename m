Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE7A065D4D7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 15:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239342AbjADOAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 09:00:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjADOAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 09:00:30 -0500
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4869A17061;
        Wed,  4 Jan 2023 06:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1672840829;
  x=1704376829;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tuPHn0rueNqU221bzy8Hvvowp1SeYU4HeuNQGuvbPlI=;
  b=oR+p1SbP86xKZeKvchWk1O7i8NCCihZduuyRhp+DKYcWgS7yMg9WGz99
   mYdbFxzDMOTQvuaIpmTINeY8GnodGpZ8c3eXYbLVJqT/ZAI7JbpyQv/0p
   NlodqczIogvxZeN6YLk9GIK93Pnx6WAPXS6q6i1KfUasi1uXcE4j96DH0
   CagmZ30K/QjtudUc13gyHbTGyBMxEHYMNgtrhnhniQgPiRJiwLUaIMe0Z
   ++Z9s5iPNHSMzTyfSu057yyDwv45z0VtrfjRR67SysBzeHANxnzJ88Beh
   Fra06kh7Y+Mf1yqTd8m5HgoRRgg8IvIRKN9fG0AzKl6YfDaqH1f3SLfa+
   Q==;
From:   Jiri Valek - 2N <jiriv@axis.com>
To:     <jiriv@axis.com>
CC:     <devicetree@vger.kernel.org>, <dmitry.torokhov@gmail.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-input@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v2 0/2] Input: cap11xx add support for cap1203, cap1293 and cap1298
Date:   Wed, 4 Jan 2023 14:59:49 +0100
Message-ID: <20230104135951.930783-1-jiriv@axis.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230103134105.736346-3-jiriv@axis.com>
References: <20230103134105.736346-3-jiriv@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail05w.axis.com (10.20.40.11) To se-mail03w.axis.com
 (10.20.40.9)
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PATCH 1 - add compatible string for new models
PATCH 2 - add support for new models into driver

Changes in v2:
  - Fixed if statement in PATCH 2.

Jiri Valek - 2N (2):
  dt-bindings: input: microchip,cap11xx: add cap1203, cap1293 and
    cap1298
  Input: cap11xx - add support for cap1203, cap1293 and cap1298

 .../bindings/input/microchip,cap11xx.yaml     |  3 +++
 drivers/input/keyboard/cap11xx.c              | 19 +++++++++++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

-- 
2.25.1

