Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4005F52FC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 12:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiJEK5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 06:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiJEK5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 06:57:42 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714837646C
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 03:57:41 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id a10so13045279wrm.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 03:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=GUiYw6qU947sxM7820wZd2S4UP5yj6LoAJhsUK073m4=;
        b=CqDfHnGb2EYedKzy6fNaP++qyJwWyB0qg+kzgP0ZHiIZ5ltP70S6MPnhROoclLRcnv
         1fsoONJ5a5sGj0qfqgVDteRXbDbyRQp780pT326I0O9Oe6uYrc1BHn863I57aLoYSBv7
         Ux1oYLaLdbLIknO4B82pno5Tad+sDy5/Xl0pH68rRVVTLi4N2J+3O9yeGA/n24fW9C86
         R6sex4jTlrEtj2QYfh5BKB7LIFpNHpwUvJT+dPG7wtvtVfOIwLZy7n9WjaHeiriOFeqC
         Kdc81zWnvKHTd6o8WQ53E6sbIJN5+NEtDgfWTt8PtfnkZ8LBtErjtSt77In67rtqiyvW
         e7tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=GUiYw6qU947sxM7820wZd2S4UP5yj6LoAJhsUK073m4=;
        b=wg6CbD2dqTk8roGrO8Bp+olAJBhWR3CQ9ejk/4zngz/UoWM82lSIkNp+kYorAJHcpr
         Kbv6RLrvUrXAsUSaWCzGMULgMQyG2NsZt7KMSE7Gt36SESKJyTjmYz4lOb0Zkkivhvdy
         JNsraux2T+LaWk0lMCHhZDc+Bpt0ZfhA+SIJvF1K+LqSol4ufAf1jZqOs02fFtv11U6/
         6mnostLJoBQuO6CnDt7aYsfGV7Xq5yV+cYw0vFmZ8Yjc81krXuhYfac0CfWJUvJvJ8kH
         8z+vlshu3JJNZm37fSPrS/4kOuezessKvkpPaMuQydCWvf/ypOGTyRZcnEPR7mNNBjYI
         Bn7A==
X-Gm-Message-State: ACrzQf13UvH+080H1ehjjEXxltZqIS4/32yDbBIg9ahwnInRLp+ALAOv
        hiU7rDmKK3/JaQf0TwjedpSuvg==
X-Google-Smtp-Source: AMsMyM5GwfpS5r3WR9lMe8uAD2m85wXOjdr8VuX42hGU78zjDstfRtbO5wVACNsCPCxPHacPIK9Orw==
X-Received: by 2002:adf:fad0:0:b0:22e:4998:fd5d with SMTP id a16-20020adffad0000000b0022e4998fd5dmr6029181wrs.267.1664967459170;
        Wed, 05 Oct 2022 03:57:39 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id q30-20020adfab1e000000b00228dff8d975sm14591680wrc.109.2022.10.05.03.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 03:57:38 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     linusw@kernel.org, kaloz@openwrt.org, khalasa@piap.pl
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] MAINTAINERS: add related dts to IXP4xx
Date:   Wed,  5 Oct 2022 10:57:34 +0000
Message-Id: <20221005105734.3513581-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_maintainer.pl currently give no maintainer on all IXP4xx DTS files.
Add them to the set of files handled by IXP4xx maintainers.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c3e94af1bd97..6d0e6353a686 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2265,6 +2265,7 @@ F:	Documentation/devicetree/bindings/bus/intel,ixp4xx-expansion-bus-controller.y
 F:	Documentation/devicetree/bindings/gpio/intel,ixp4xx-gpio.txt
 F:	Documentation/devicetree/bindings/interrupt-controller/intel,ixp4xx-interrupt.yaml
 F:	Documentation/devicetree/bindings/timer/intel,ixp4xx-timer.yaml
+F:	arch/arm/boot/dts/intel-ixp*
 F:	arch/arm/mach-ixp4xx/
 F:	drivers/bus/intel-ixp4xx-eb.c
 F:	drivers/clocksource/timer-ixp4xx.c
-- 
2.35.1

