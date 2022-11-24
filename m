Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAF9637707
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 12:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiKXLC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 06:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiKXLC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 06:02:26 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5585890394
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 03:02:25 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id s5so1965121wru.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 03:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qu3xB7BDAsHZerZW0pGAagjp7CtoVgai761hm4h5lQU=;
        b=Z8zCGR++Ue7UFFaHxzioTXIV4JWkztILoC3/z7OUDG6lIRcHovoFrqihk+6onf35Ws
         nhJs27sLIgKSf6ahrCMqxFa6i8MVBVCWn3jaDSHWCZfhmZVXbW9B6dcc2QuYYgaXSAF7
         WYNYADxPv+21hB5kavh/TznBo/YU/GPPeEa9rSatk5SPSK6XpBeRTvqNJGoA8RA7zMqf
         XdRPfTajuuBRnbeRMiRSKqAJnhEP/Cekggvq/xDcMa7Im3Eea43ZPOknaEj1uLEYPP9F
         ob4pZ55k0lpdY/GBPaFxLsBHwVjqPPdd4+Sed56KiiVg8yTLQOBjF0OzO8diYsK9aQ/C
         w24g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qu3xB7BDAsHZerZW0pGAagjp7CtoVgai761hm4h5lQU=;
        b=fKEb0rTX6j11npAxdOcNkiJloW+rS5eqOWr/oqrGMxGljlVEq1EQITs71mWiN+AhCl
         kjxGMx2/m11nHA+y3Im7LQv+bGzZCBMH5StAVMDKWHVdgY1bG11SK27iCOA2Tx8PSjlJ
         kxbM78NQLgq+9aPc1iOCPLEWgwi4OPKIJhhItTMINJWlLz/Wr1cBPmeCEsi25o8Zl5zM
         oFLMvxXid5RgwwlE3ENWurisQOu44MFHTRY8R0YSRDRqoBMsjY5yiByCVGWCtVOEGq5n
         Ab67fX0Po2PyxeovXsif8UrgvAzU6+W9unUtiEJYMzz5yNdvMlEWmcui2e33nb+ZQeyt
         Dv8w==
X-Gm-Message-State: ANoB5pk0bA+RfZRfoQbZ2/MIICzFe8wGvUKmffrYXH97Utp/m2585oGR
        +FKkKDst0kwPoXz8YIozHKxIbGqiQInwMlr6
X-Google-Smtp-Source: AA0mqf6TLVfgymm9l7wugpcbFltgYMGd0ic7k9E0zh9Aq+quuAWfqrQkYTBJp6L+gPlwKH7FoGN6sQ==
X-Received: by 2002:a05:6000:1181:b0:22e:53c0:ead8 with SMTP id g1-20020a056000118100b0022e53c0ead8mr19895500wrx.210.1669287743590;
        Thu, 24 Nov 2022 03:02:23 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id s10-20020a1cf20a000000b003cfe1376f68sm1332732wmc.9.2022.11.24.03.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 03:02:23 -0800 (PST)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [RESEND PATCH v11 0/2] mfd: max597x: Add support for max597x
Date:   Thu, 24 Nov 2022 12:02:07 +0100
Message-Id: <20221124110210.3905092-1-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

max597x is multifunction device with hot swap controller, fault
protection & upto four indication leds.

max5978 has single hot swap controller whereas max5970 has two hot swap
controllers.

Changes in V11:
- Update description in DT
- Remove newline at end of file.
Changes in V10:
- Cleanup unused properties
- removed superfluous comments
- Update description for regulators property
- Fix typo
- Update 4 spaces indentation in example
Changes in V9:
- Update properties description
- update required property
Change in V8:
- Set additionalproperties to false
Change in V7:
- Update id
- Remove empty line
Changes in V6:
- Update missing vendor prefix
- Update indentation in example
Changes in V5:
- Fix dt schema error
Changes in V4:
- Add NULL entry for of_device_id
- Memory allocation check
Changes in V3:
- Address code review comment
Changes in V2:
- Update depends in Kconfig.

Marcello Sylvester Bauer (1):
  dt-bindings: mfd: Add MAX5970 and MAX5978

Patrick Rudolph (1):
  mfd: max597x: Add support for MAX5970 and MAX5978

 .../bindings/mfd/maxim,max5970.yaml           | 151 ++++++++++++++++++
 drivers/mfd/Kconfig                           |  12 ++
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/max597x.c                         |  93 +++++++++++
 include/linux/mfd/max597x.h                   | 101 ++++++++++++
 5 files changed, 358 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max5970.yaml
 create mode 100644 drivers/mfd/max597x.c
 create mode 100644 include/linux/mfd/max597x.h


base-commit: 27fea302952d8c90cafbdbee96bafeca03544401
-- 
2.37.3

