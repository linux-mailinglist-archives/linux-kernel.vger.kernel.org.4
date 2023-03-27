Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538536CAD69
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 20:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjC0Snp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 14:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232755AbjC0Snb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 14:43:31 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FF83AB1;
        Mon, 27 Mar 2023 11:43:24 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id w133so7123214oib.1;
        Mon, 27 Mar 2023 11:43:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679942604;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kEGgZynpOWxMMcgnhx5oPKpn1kXWJspMTBnhIlRJRTE=;
        b=S4kJ4C3v6vQmSKRETD46OhwWPgU4Bf2zEnniGtxAO45xVzcsTHiQkFo3UU/ohZFBRz
         Tk4qZkyt/pzlEebpGDNNZcbtcuQAn+rabfVywUd5iFO3Y1PcV/GcVecCXvc+t5vTFsDp
         XwSAlbUop39S1g6ALB4AjdpYMUXpgHTPCbE6ODAsi0r+5LoPp865PZrJSqKAo0PfoGBd
         KIFAQJ2fAH9Lpc66SGf3efMI3uiqUv/ixKHB5l97F0rVNXc90K2YPtBqqh7J9MRIOLNB
         dMnDtvkCW0QTqxgb+KcIikWxO7hlfEVOj7B2ONmgVlCcIIEoYVgoJrATcV92Q62z8IcC
         upYA==
X-Gm-Message-State: AO0yUKWk60iS5N5WOZ0vJKIFlIbVQkZb1WTZGnSJVQ72m383YI6f6YQu
        dIe0/j+VtyRvwEGD9qC3BsP3WHGBOQ==
X-Google-Smtp-Source: AK7set97PHnpHnNcJd0YvHu98kxp/1+R4hE13vkhtRYsN9y0C0ya9L6PqEFAa2u7vAGLV9IfWhm4tg==
X-Received: by 2002:a05:6808:1389:b0:37f:936d:b5d9 with SMTP id c9-20020a056808138900b0037f936db5d9mr7045261oiw.12.1679942603966;
        Mon, 27 Mar 2023 11:43:23 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s9-20020a4a9689000000b005255e556399sm11758101ooi.43.2023.03.27.11.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 11:43:23 -0700 (PDT)
Received: (nullmailer pid 250777 invoked by uid 1000);
        Mon, 27 Mar 2023 18:43:19 -0000
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 27 Mar 2023 13:43:18 -0500
Subject: [PATCH 1/3] MAINTAINERS: Add Marvell mvebu clock drivers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230327-mvebu-clk-fixes-v1-1-438de1026efd@kernel.org>
References: <20230327-mvebu-clk-fixes-v1-0-438de1026efd@kernel.org>
In-Reply-To: <20230327-mvebu-clk-fixes-v1-0-438de1026efd@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org
X-Mailer: b4 0.13-dev
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/clk/mvebu/ is missing a maintainers entry. Add it to the
existing entry for the Marvell mvebu platforms.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d5bc223f305..b9d04f781524 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2356,6 +2356,7 @@ F:	arch/arm/configs/mvebu_*_defconfig
 F:	arch/arm/mach-mvebu/
 F:	arch/arm64/boot/dts/marvell/armada*
 F:	arch/arm64/boot/dts/marvell/cn913*
+F:	drivers/clk/mvebu/
 F:	drivers/cpufreq/armada-37xx-cpufreq.c
 F:	drivers/cpufreq/armada-8k-cpufreq.c
 F:	drivers/cpufreq/mvebu-cpufreq.c

-- 
2.39.2

