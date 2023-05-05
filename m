Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A666F7BF8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 06:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjEEEgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 00:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjEEEgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 00:36:11 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA06FAD28;
        Thu,  4 May 2023 21:36:10 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-50bc394919cso1932296a12.2;
        Thu, 04 May 2023 21:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683261369; x=1685853369;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHXpRNogIn0ct4t7Ry5evm1n6j6x1w7ZcKvxVp5O/fo=;
        b=ge4rbSshpxxES+ofvWqX6cyowd58NOjDSYelee4jXRYiOsPbj1n87ly+cs1zgFVa2j
         qDscPN6kwoVZeKOuWFnuuIj/smv2Td8PerBuXHMEQil1fXhVnwACYcv0Kpc8N5jY+d//
         HdjyKyS7nYr7Du9J2xTfxFGWhb3IpdfL+oTIz2xJf3kUnvSSHAz64XyOMpeJm+1/69OC
         v2RvM0n9KkYN74bgg0yUj56qwAp32Rt/4uzBls8yhcTN8aq9IptHRHaTbXHxh3JSt7vd
         4UgZTo64sljkXTWdTpNY8hIK6Xlh2z7d6zSohl2tIny/RqVIcTKTFNY3ChM1lA85zAOD
         4HLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683261369; x=1685853369;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HHXpRNogIn0ct4t7Ry5evm1n6j6x1w7ZcKvxVp5O/fo=;
        b=Mx2+7J9OxM6ltHG60af1WW3rGueDAQUayrqIV1RrfAt7maElw59XZtg5xEugOMw1VC
         gtKznm8HtvyXXiS+Lo8WIdQCNZDwFPZ/SJQLvCh04jfrRpjow3k7+IBaJmS4JYPzp+/o
         fEGM+Tpb9TC4D7bGwR85UKcrvXn1mHHyogL3L09vB5g3t8Oi+cHYcM+ebeZGVBoG4LAW
         2JxxeUP5IGMYlyrIHDHnNUICuqCvh7q5und4tJ47MIMQY9ANdj8pzCn/soUB4AwsP1Vr
         p3kmh7EW0hwTIl6T8qG8v6LT79tpo9VU+TIRrYRgkrl2AKhTj0+Zhzv33bPz18sRW+IL
         iF6w==
X-Gm-Message-State: AC+VfDxSulu7qfe/XFB+kBMWSx2Fx5oUtppA4C7WC/ufwAEjsmSQtO6w
        ocjH7ZyfYAGEyQY5zDvVLi4=
X-Google-Smtp-Source: ACHHUZ5Rkfr4oErH79i/dwbA+mFOP6QhPywNPqUxTc0xur7TCsyDR69bjnLtI1aryFhwq6S6rYaPpA==
X-Received: by 2002:a17:906:fe01:b0:94e:aa8e:b56e with SMTP id wy1-20020a170906fe0100b0094eaa8eb56emr878675ejb.33.1683261368991;
        Thu, 04 May 2023 21:36:08 -0700 (PDT)
Received: from felia.fritz.box ([2a02:810d:7e40:14b0:a45b:729e:518b:29af])
        by smtp.gmail.com with ESMTPSA id d3-20020a1709061f4300b009655d4450a6sm402678ejk.192.2023.05.04.21.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 21:36:08 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: remove section INTEL MENLOW THERMAL DRIVER
Date:   Fri,  5 May 2023 06:36:05 +0200
Message-Id: <20230505043605.22272-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 2b6a7409ac39 ("thermal: intel: menlow: Get rid of this driver")
removes the driver drivers/thermal/intel/intel_menlow.c, but misses to
remove its reference in MAINTAINERS.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
broken reference.

Remove the INTEL MENLOW THERMAL DRIVER section in MAINTAINERS.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 39a00522ca37..08b37d967cc9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10564,12 +10564,6 @@ F:	drivers/hwmon/intel-m10-bmc-hwmon.c
 F:	drivers/mfd/intel-m10-bmc*
 F:	include/linux/mfd/intel-m10-bmc.h
 
-INTEL MENLOW THERMAL DRIVER
-M:	Sujith Thomas <sujith.thomas@intel.com>
-L:	linux-pm@vger.kernel.org
-S:	Supported
-F:	drivers/thermal/intel/intel_menlow.c
-
 INTEL P-Unit IPC DRIVER
 M:	Zha Qipeng <qipeng.zha@intel.com>
 L:	platform-driver-x86@vger.kernel.org
-- 
2.17.1

