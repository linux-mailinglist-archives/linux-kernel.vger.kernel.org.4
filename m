Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6A75FE470
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 23:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiJMVua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 17:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiJMVtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 17:49:46 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCAA98E7BB
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:49:24 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id l6so2678173pgu.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=DjKmUNATEItEpOW99AiCGTogaWNGIMtFQVCXMhEpIns=;
        b=X0/aYdLTdB7hFJmTFiS/ApYrhhQlJvTFXS9vxDgmayvLCvPkysh8oeKG3kShkquWaP
         6FqWPzpEPYSRJzX3CO6QeRVFvtLrnJtSv+GYfhEX3qXHjNRyLawjy34Q0ODZKwV2HwYS
         42/dBOySDl7JVmNX4Ij+4klAMkhQ5azH5DEe4IpkT+2MUfQfJ4iKcjAQ8rKVifmlWQ27
         VI+gR9S/VyqfUsBb1ywoD0JQqazONtv3R9BTjIPCajcFXWjrlEP3PS2PTG4QOEfl6+py
         axhiBIrTQd1qAHi9C8crPihkHw9i7eDHxTLO1wnnyvmH5HJH6jLzXHtJA85qdKfry2Uy
         7C+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DjKmUNATEItEpOW99AiCGTogaWNGIMtFQVCXMhEpIns=;
        b=eDifagzXxHOgLQbOLtnIgXT8XrPVcGUZhAtMgX3Z5we+TSuJRWtoBaQUHrm2NXSLIB
         +FH/as5CzU2uLXjvxwLtJJUE4meoLXygaR7zxyW8KuNFmovjwVLDrhb9PhnoTUIZ2UDC
         4KLBz0vWmBDLbTq91DA3S3eXdKdRBuLC3cZRtKh3znVHRWV7NvlES1zk64uw16MCpbtY
         8gtiZty75JMXsMjkoHBRwvnSbxtkbbYfInssb5C3HpAHxdZ/o5QFkwlAxVlbjtGSKC1C
         SmSjN+UIPobCpOdWCQPNY2NR0SSWDfbo7zaqns3v3xTBtFBLHouHDTMgDTWB1+lmth71
         a0sQ==
X-Gm-Message-State: ACrzQf3BoG3nCKNwH4hcmLH+CtskqC88tYHifeP1a4ZuzgsUzjUmt5nE
        hXU97ykxiPedeeDYazH04vPx9waL6VTiPqSL
X-Google-Smtp-Source: AMsMyM6vJpiuPVwFChLSZeEzJEXaMLKHXW9F/hVe88MQchebwPB/mSSun5JsIUZuDviQ3mjvrGTZCA==
X-Received: by 2002:a05:6a00:10cf:b0:528:48c3:79e0 with SMTP id d15-20020a056a0010cf00b0052848c379e0mr1685372pfu.18.1665697764005;
        Thu, 13 Oct 2022 14:49:24 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id e17-20020aa798d1000000b00562ea6eeeb2sm176347pfm.93.2022.10.13.14.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 14:49:23 -0700 (PDT)
Subject: [PATCH] MAINTAINERS: git://github -> https://github.com for microchip-ung
Date:   Thu, 13 Oct 2022 14:46:39 -0700
Message-Id: <20221013214639.31154-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:        linux-kernel@vger.kernel.org,
           Palmer Dabbelt <palmer@rivosinc.com>,
           Conor Dooley <conor.dooley@microchip.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     lars.povlsen@microchip.com, Steen.Hegelund@microchip.com,
        UNGLinuxDriver@microchip.com, linux-arm-kernel@lists.infradead.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
index 6d4e578f6cc1..3bc404b292d3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2397,7 +2397,7 @@ M:	Steen Hegelund <Steen.Hegelund@microchip.com>
 M:	UNGLinuxDriver@microchip.com
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
-T:	git git://github.com/microchip-ung/linux-upstream.git
+T:	git https://github.com/microchip-ung/linux-upstream.git
 F:	arch/arm64/boot/dts/microchip/
 F:	drivers/pinctrl/pinctrl-microchip-sgpio.c
 N:	sparx5
-- 
2.38.0

