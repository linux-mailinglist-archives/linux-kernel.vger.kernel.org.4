Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84EC67E306
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 12:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233129AbjA0LTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 06:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233036AbjA0LSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:18:38 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F4C7A499
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:18:15 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id d14so4651038wrr.9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DUOxD1F8eRNm4Bz5AYSwM1sKglQF1AVwavHsc7USB10=;
        b=nR3Hu0Fbm53CjYNtgfZuRtIgs9heWbZT/kyV+PVoiRMQXUZZx9ie63OSXDarmWfO+x
         LkdHBuViHDz9M/s8r2ghs4Us+HI0w9/qgrGH9MZhn+ePJ2VURj1eafUjxLrg6TNiv+oe
         /H0iVLCy4F5AGmelZjT+hwO9MptJNbcpsViubeqgDb1RHY0/oNWBB9QuPMweNHyVwZFD
         W4GQ8SLTcPTBOChPHKG5ALAp4ejg0/lHLxf5kO1JVvRLhP5yMtq+5q7LbC/63HlGK3w/
         PDT935dnPtg1SR3OIpfQaEr4g4n8dg7dc2xPhcOxiHrkckieh+N/0r7hZMLLAMt3LEnp
         i9IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DUOxD1F8eRNm4Bz5AYSwM1sKglQF1AVwavHsc7USB10=;
        b=5Ajm1P9m35PU+Dm7YdKmdWyDDoBupfLyI/4RdDc9HehbjBYEvfSFWe5D6jUpPTHcwc
         Hk9HB6c3xogu6XYzBziOI653AXFs9igq/ZbKFaIQNvyNRrABNjpJdiC5VnO0OhlZurIm
         hWRYOTdWz3jw1Ew+OhoxS5DKGATDG0CCwE/kzP6KHBvpYy+czzWR3cQlAUgFnt7ulY9N
         JHv2PFWiWYos+BRB2dKuqtQ29OYKTHlbYJU+4Pl0LT8WE9PPWNihNHeCfRj6hwvy9JIC
         EbMspg9d8TK6hMZZzFa0fSDTGDw8TqvO2fLbx0oFuYrNAjVSQ4yJ07BmvJKL0qTOGVWB
         dWcg==
X-Gm-Message-State: AFqh2kr3NQjOevXCL7ZwEV7urjpagNjUIXEe4J1lIeFqJLRcPZFluqx0
        sWwFIY28MNNg8+gA45PJDFq5rQ==
X-Google-Smtp-Source: AMrXdXt/CXpReFe/elilQ4Mj8deNGTLfM6wq8SD0fJxBFDiH9R7YjjOKzvxXDT22JJpX/VtAjPjzhw==
X-Received: by 2002:a05:6000:1e18:b0:2bc:846a:8ead with SMTP id bj24-20020a0560001e1800b002bc846a8eadmr37474231wrb.37.1674818294959;
        Fri, 27 Jan 2023 03:18:14 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id c13-20020adffb0d000000b002bfd190fd60sm1843314wrr.108.2023.01.27.03.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 03:18:14 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 26/37] MAINTAINERS: Add myself as ONIE tlv NVMEM layout maintainer
Date:   Fri, 27 Jan 2023 11:15:54 +0000
Message-Id: <20230127111605.25958-27-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230127111605.25958-1-srinivas.kandagatla@linaro.org>
References: <20230127111605.25958-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miquel Raynal <miquel.raynal@bootlin.com>

Following the introduction of the bindings for this NVMEM parser and the
layout driver, add myself as maintainer.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 70aa4547d784..60b8f2c07e7f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15577,6 +15577,12 @@ L:	linux-hwmon@vger.kernel.org
 S:	Maintained
 F:	drivers/hwmon/oxp-sensors.c
 
+ONIE TLV NVMEM LAYOUT DRIVER
+M:	Miquel Raynal <miquel.raynal@bootlin.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/nvmem/layouts/onie,tlv-layout.yaml
+F:	drivers/nvmem/layouts/onie-tlv.c
+
 ONION OMEGA2+ BOARD
 M:	Harvey Hunt <harveyhuntnexus@gmail.com>
 L:	linux-mips@vger.kernel.org
-- 
2.25.1

