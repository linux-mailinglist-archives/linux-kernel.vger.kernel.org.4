Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74AC5EF57B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 14:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235056AbiI2Ma0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 08:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234300AbiI2MaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 08:30:15 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852BA67165;
        Thu, 29 Sep 2022 05:30:13 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id e18so1762626edj.3;
        Thu, 29 Sep 2022 05:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=doOtCXgO4NsKO2q8zCE4t9lVhtNbFd/oRmxWEjStvkw=;
        b=VFDzQSmojqh3HVvwqpRJZly3/YPdl2l4AYyEHz/A9cGT3M79EQm2oJpYxpu23VX3VP
         SNKfu26dq4lf/DfAnyruBhFqYoW7E2zFuPwYu4v+m4bgnVWgXAKtMVJwXLo/vdGmsntR
         gBCI3Qy1j4Rp7NaA/scg9Z0VF+/YWUvAsabls25dQYi7pHc0L2roMMUhiFkwNaUENOAn
         pCVyb0sQhPfiK8KQRM/KivTGE8jnS3Aw4Sl733vsJclcduCtfo0noPrpt93Tmo3rKTiX
         yV4qYweM7pr0KKwTk9fJsb8SLHYS50V6A8MbWbggurRA1ORekqHPWldEGRijcms1VTRO
         7QTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=doOtCXgO4NsKO2q8zCE4t9lVhtNbFd/oRmxWEjStvkw=;
        b=sQGnOPEYDrLTG6qdbzDKuuOkt9XZv0kcdSFZRA9EGsc/lLmky4Hrs5o2icktQ4L8yr
         K3wSI4v3QgHLzLSfNvONsBMQZxHh3RDoeJBqxoZPba8SfQLHzJv7HaiXMDBoKETOeTG2
         2ku4PwXe3itcZ33TqQvLcxVP3rTA/1nhWrBOd+0DOFB9wzU/rPVG9/X2ysKgA+NnWzhl
         l8FgZVOrxFzTq+g1PW7OtObDNcJjcoWog1NJwgaEXQFWbHuwhzkWtiYssG+5u8Di/vtc
         qiq4vIPGZM5/DC7wnOQ1HtbMb/Mggm0FDtuRGctUXUGVqTF271T5ueYrN0T2fNfemCAq
         iBGQ==
X-Gm-Message-State: ACrzQf1lQOFw1w14mIMEiKZ+6U0iVm3vMzXwfq7MjNCmBdUEWqgnDItB
        +W7+Le7/YjJBk3yjs9Zje1nJ5q5knT8WXw==
X-Google-Smtp-Source: AMsMyM4ZRTK1JaIi4w8rn1jAqV6lVPGsm4oqpmZO5OroujYNHOBruXG9Vk2lwxIQe2At8h5wigoPDA==
X-Received: by 2002:a05:6402:34cf:b0:454:53ae:6e83 with SMTP id w15-20020a05640234cf00b0045453ae6e83mr3101158edc.80.1664454611978;
        Thu, 29 Sep 2022 05:30:11 -0700 (PDT)
Received: from felia.fritz.box (200116b826e11200b190ebfd45660ea6.dip.versatel-1u1.de. [2001:16b8:26e1:1200:b190:ebfd:4566:ea6])
        by smtp.gmail.com with ESMTPSA id jp19-20020a170906f75300b007826c0a05ecsm3764186ejb.209.2022.09.29.05.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 05:30:11 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Shuai Xue <xueshuai@linux.alibaba.com>,
        Hongbo Yao <yaohongbo@linux.alibaba.com>,
        Neng Chen <nengchen@linux.alibaba.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: rectify file entry in ALIBABA PMU DRIVER
Date:   Thu, 29 Sep 2022 14:29:37 +0200
Message-Id: <20220929122937.20132-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit cf7b61073e45 ("drivers/perf: add DDR Sub-System Driveway PMU driver
for Yitian 710 SoC") adds the DDR Sub-System Driveway PMU driver here:

  drivers/perf/alibaba_uncore_drw_pmu.c

The file entry in MAINTAINERS for the ALIBABA PMU DRIVER, introduced with
commit d813a19e7d2e ("MAINTAINERS: add maintainers for Alibaba' T-Head PMU
driver"), however refers to:

  drivers/perf/alibaba_uncore_dwr_pmu.c

Note the swapping of characters.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
broken file pattern.

Repair this file entry in ALIBABA PMU DRIVER.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 485d66af5c9a..e14e37c7c734 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -754,7 +754,7 @@ ALIBABA PMU DRIVER
 M:	Shuai Xue <xueshuai@linux.alibaba.com>
 S:	Supported
 F:	Documentation/admin-guide/perf/alibaba_pmu.rst
-F:	drivers/perf/alibaba_uncore_dwr_pmu.c
+F:	drivers/perf/alibaba_uncore_drw_pmu.c
 
 ALIENWARE WMI DRIVER
 L:	Dell.Client.Kernel@dell.com
-- 
2.17.1

