Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5CAD5FE474
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 23:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbiJMVtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 17:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiJMVtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 17:49:35 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3564E36BCD
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:49:07 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id c24so2997908pls.9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=i3K43ojbMq8isMbqFxDt+PzOi1qTNmeGQ4/NX2/+N0s=;
        b=m4GpdrZWyUxvcdlQIiSLdarZ/8f06jvKA5NbPKwsGtQy8/PzXJLAdpV0Iqq8ic3i/+
         ALBxWhsGIv7/agd3mSgUwanDeWl+OwHsWOOmyV6ujoSPkONdtO9HicQ9mAiH0Bsjspow
         s90v2642xpaknJej8cUEg8abEalRdK4fRxcA0fyeiqu/7Tp7Uk+C7uAtbm47WyTkGr87
         YaBZAY0uBXSUTLc1BcQoW/RxlmQ48lOEkHlculPPDMH8mbstu/Z5q6gO1LQ5mioaKxOJ
         51ehanKyth51rAduNNDu6GYTh1hIpyWJaFt/XCybvEnWgLgEQRiNqJ0G+YCA8CsmCeb3
         uf0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i3K43ojbMq8isMbqFxDt+PzOi1qTNmeGQ4/NX2/+N0s=;
        b=psYi5gbgmEyhqp3C5mPL0gJ6zFquiIF/L5agTWVrT465loRh/Pa2nQE3bO7aX/0RtU
         q/X12Uc3RtOfIIDiIO6cyyE3F+Lfr1GZBrVcCEk7lO6mQ/VRqbvrk4VzBwsgkrfMW0/d
         f74Ptj1VDD0rHGxIh3FFgzj/ks3GDSrC7rk26O9y19QkZGScL20UTyAWu0k7AvDcwUs8
         OrIAv9vSOoFQfosA52e+KWxaO2tVe/mikatuHgS0eyb/+SPjB60YRUq7NPRYLbJKj1kE
         VItkpU9KCD0VY37s1G3Q8M/vT3+OJ3vfhNqmwVcrfRUyvXohB40BCT3cwe2hMYpQWjWb
         aIUg==
X-Gm-Message-State: ACrzQf2xQX4CEH1skzqUMNGdoHcRZmTw8QSlHC2mNGFRVSJSo66SF558
        PZn0yx78Dt0oru/oZNn39TUafHTr+6B5qNS5
X-Google-Smtp-Source: AMsMyM733KNeybflC+If1obbzWxANjLNj7Zgxv/5gM6kA2Oko04lczn0Q0lcUQrsWOwUH9yVmaymeQ==
X-Received: by 2002:a17:903:240d:b0:183:9bab:9c3 with SMTP id e13-20020a170903240d00b001839bab09c3mr1849051plo.48.1665697745345;
        Thu, 13 Oct 2022 14:49:05 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id m9-20020a170902db0900b00182d25a1e4bsm285318plx.259.2022.10.13.14.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 14:49:04 -0700 (PDT)
Subject: [PATCH] MAINTAINERS: git://github -> https://github.com for intel
Date:   Thu, 13 Oct 2022 14:46:37 -0700
Message-Id: <20221013214637.30873-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:        linux-kernel@vger.kernel.org,
           Palmer Dabbelt <palmer@rivosinc.com>,
           Conor Dooley <conor.dooley@microchip.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     todd.e.brandt@linux.intel.com, linux-pm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Github deprecated the git:// links about a year ago, so let's move to
the https:// URLs instead.

Reported-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://github.blog/2021-09-01-improving-git-protocol-security-github/
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
I've split these up by github username so folks can take them
independently, as some of these repos have been renamed at github and
thus need more than just a sed to fix them.
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9a9ca93b63fd..7b5e1953b718 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16211,7 +16211,7 @@ L:	linux-pm@vger.kernel.org
 S:	Supported
 W:	https://01.org/pm-graph
 B:	https://bugzilla.kernel.org/buglist.cgi?component=pm-graph&product=Tools
-T:	git git://github.com/intel/pm-graph
+T:	git https://github.com/intel/pm-graph
 F:	tools/power/pm-graph
 
 PMBUS HARDWARE MONITORING DRIVERS
-- 
2.38.0

