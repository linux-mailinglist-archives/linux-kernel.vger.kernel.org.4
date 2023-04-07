Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E9B6DABDF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 13:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbjDGLAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 07:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjDGLAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 07:00:47 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471E0212A;
        Fri,  7 Apr 2023 04:00:46 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id l7so39482310pjg.5;
        Fri, 07 Apr 2023 04:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680865245;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bValTCmP8jL39xWPsKXDLk0iGwt7McxKpWULvY55dr8=;
        b=oEGxlDUq1/ihIF5In3dKoWta8MJZ+9vj5Yc9J5vEp6CdfMG4hfD1W0NRP1RbCbl30D
         B+YXiqTEshFNmV4EQfkrRcZCMpGqfERVJ2z35L7mx/BwtA0IKAz1V6XEsZ+wyJWbopwI
         noQl4Bi2MGoQmWL7pHrMIwSc8fZxD7TMw71ZnW2iSNLPN/Bpz+xFDcxSz/HncEBcooPW
         JbUySTlX4AYk08Ip2rA6I1f8riqT5T70KE51+24jEverAZoffHz6e1yCc2YTpSzA7M0u
         1G2t+l47IDdpHmB7GuMQGFqa1O2snmtXdxRZQe2wCqBXHgghVV36404AEUGhebLWEYA4
         4hyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680865245;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bValTCmP8jL39xWPsKXDLk0iGwt7McxKpWULvY55dr8=;
        b=RHhS0aJwdpMf4djhmIVL8poqiZHXTclJevN5wPhkyNsUYeYZJnGvO4uymz4abkTYvn
         80ABnB2QPhVkDDX3fxMNqX7wGZWwF0UCXUCv/VUIaBqagnsb/SqSCwCG6VVMGevSqWCq
         jg4aG+LIUIFHjjvEMjZdrHhMtynM58tKe4qrZxMOFf1UqF4h1gWiaAIrSPfoexwnOZxj
         hoakw7JV+f5ep3upq5rz8YJNwWFWYWbr6n73YiQuuSfWcbABnQp4R90okNZWRp02T+GH
         cL4qQ3VsjjtoRdSaDXoPBaRLrNm1AQQcfGmchg5jmGL8y87kAqCCaQKeuU43Gt985fYk
         E4qA==
X-Gm-Message-State: AAQBX9c/Ocw1nyWsbW+NC9FqpGLSGEInUMT/KBZ5gdzV3qn8q91oxvN5
        tr3l8uCMYEBwYvago6wPEve50q5N4Jv3IQ==
X-Google-Smtp-Source: AKy350bFByCPFxB3LOK0UQsaT3LPOP9A/QKFkG759WX6sj7FX9y0xpYbccC0UkzolEOQBD/BH/eIIQ==
X-Received: by 2002:a17:902:ea0c:b0:19a:7758:e5e6 with SMTP id s12-20020a170902ea0c00b0019a7758e5e6mr3313624plg.48.1680865245302;
        Fri, 07 Apr 2023 04:00:45 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.. ([38.84.161.179])
        by smtp.gmail.com with ESMTPSA id jw1-20020a170903278100b0019ee042602bsm2732005plb.92.2023.04.07.04.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 04:00:44 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Yang Ling <gnaygnil@gmail.com>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH 0/2] Devicetree support for Loongson-1 watchdog
Date:   Fri,  7 Apr 2023 19:00:23 +0800
Message-Id: <20230407110025.516405-1-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT support and dt-binding document for Loongson-1 watchdog.

Keguang Zhang (2):
  dt-bindings: watchdog: Add Loongson-1 watchdog
  watchdog: loongson1_wdt: Add DT support

 .../bindings/watchdog/loongson,ls1x-wdt.yaml  | 40 +++++++++++++++++++
 drivers/watchdog/loongson1_wdt.c              | 12 +++++-
 2 files changed, 51 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/loongson,ls1x-wdt.yaml


base-commit: cf3be7e82b129ed34f811f116f2b113f6299d449
-- 
2.34.1

