Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8AF72A1ED
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 20:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbjFISPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 14:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbjFISOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 14:14:54 -0400
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700883A85;
        Fri,  9 Jun 2023 11:14:43 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-777b1b5ff50so87687939f.3;
        Fri, 09 Jun 2023 11:14:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686334482; x=1688926482;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PtmxCGh9l/ae29ZPQBJ2vM6KiVFQXXIcZskQGw0mrU4=;
        b=MM4wAaKKpGYAmiU7aGpwvbBSsksIsQO7+Q8IVEv/h4cNSbY3/hDBmrkyOqiEbgt2SO
         iBl2SKKHQfTLXhVTlJVU4YkRAVobexYahXPbYNclHxMPU8dUD00g7NgAkuBbhPcbGXzI
         ZYF6HNBPoR/nylXv7KI+zOO1yGFMTjNSsid7ovofTLZroxdUfcnZmsfyPVsfLa9Gtp5Z
         ULShsYWtG8B2YNP43svjSr19f9hRujZaTRwsIM69mS4ajNg8jT3/+P1DqSK6EsafMMqP
         48ClbitJ/gYOEI+AUulPAtZvaPRc5jI7C0vB4/E+LeHBZPieHTvZMIj9r9hR8/QQn18i
         DP8A==
X-Gm-Message-State: AC+VfDxX0BCMArF+oSvfZGZalNnZxPO/8zQWNx9xeUIi8TvtVaoUq3LQ
        bki4s/86XUkNvNxxy4tNwDoIA0h78g==
X-Google-Smtp-Source: ACHHUZ6RvrtAt54LttRWOzlIW+s7GqGRsjyJDdSvjjJuJmoFtUQvFOm9Py2c+QqhjPR1kKbASiRQkg==
X-Received: by 2002:a92:c6d0:0:b0:33b:94d:b60b with SMTP id v16-20020a92c6d0000000b0033b094db60bmr2229408ilm.14.1686334462312;
        Fri, 09 Jun 2023 11:14:22 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id i18-20020a02b692000000b00418507eef02sm1069799jam.31.2023.06.09.11.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 11:14:21 -0700 (PDT)
Received: (nullmailer pid 1681129 invoked by uid 1000);
        Fri, 09 Jun 2023 18:14:15 -0000
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 09 Jun 2023 12:13:45 -0600
Subject: [PATCH v2 1/4] MAINTAINERS: Add Marvell mvebu clock drivers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230327-mvebu-clk-fixes-v2-1-8333729ee45d@kernel.org>
References: <20230327-mvebu-clk-fixes-v2-0-8333729ee45d@kernel.org>
In-Reply-To: <20230327-mvebu-clk-fixes-v2-0-8333729ee45d@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org
X-Mailer: b4 0.13-dev
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/clk/mvebu/ is missing a maintainers entry. Add it to the
existing entry for the Marvell mvebu platforms.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7e0b87d5aa2e..5656a729f2e4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2364,6 +2364,7 @@ F:	arch/arm/configs/mvebu_*_defconfig
 F:	arch/arm/mach-mvebu/
 F:	arch/arm64/boot/dts/marvell/armada*
 F:	arch/arm64/boot/dts/marvell/cn913*
+F:	drivers/clk/mvebu/
 F:	drivers/cpufreq/armada-37xx-cpufreq.c
 F:	drivers/cpufreq/armada-8k-cpufreq.c
 F:	drivers/cpufreq/mvebu-cpufreq.c

-- 
2.39.2

