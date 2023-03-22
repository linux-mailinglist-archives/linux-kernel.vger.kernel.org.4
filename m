Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED456C464F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 10:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjCVJ14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 05:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjCVJ1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 05:27:53 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E847574C1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 02:27:53 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id o6-20020a17090a9f8600b0023f32869993so19074577pjp.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 02:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=areca-com-tw.20210112.gappssmtp.com; s=20210112; t=1679477272;
        h=content-transfer-encoding:mime-version:date:to:from:subject
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FQeTeTFky5skaAol2n4vXrcosGiX/c8ISuilp18ejQ0=;
        b=2cFFI+HLeF4277uuvBjJmfWDZMzz3Rzpj1vHUiKs899y0KieftIQiCLOLKsQ4wmBly
         eruDF9nzddnd/0A1pi/WZqWahAhIjPtt3oZKsv+U0nAeR1cpQq6Lv/CcKVXnPOaaUncb
         NMVxfuf2pGXDD7U7T3qUoJdHc2/76LHQMr3yzB3NbyZe8UsiBSti3laf22KIXW+kjntC
         cmMqRaqo7qZv4W+xu2T7eN0mjIP6PJdAAKGao5cGCoS4L9ikcJDgEwN2qpnRLKLk3KZ8
         svLrwcGP+4XdfsvgO7WAquDtz+eNo6edDEX09BVodkDEQTl4khVXnhhRpaaNetohRbr0
         Rspg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679477272;
        h=content-transfer-encoding:mime-version:date:to:from:subject
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FQeTeTFky5skaAol2n4vXrcosGiX/c8ISuilp18ejQ0=;
        b=f+pJfv+5liaJqeUqhCEjSVl0/tG3Er4aO1TKG7l9qe2EXeTqspY4qpnfigGSTFvIyY
         /B8VcF9HOl/LVejrBFYJJV9OU5Y652ANQhEVtFLz7VGz6bTXoHpEv2WObMstQSd7ZjyS
         xByTexE8pGKc9S1sq7Ix5sb6rzT9lGPrB3lMJjJ1C+iHYp31BDwW29OsP7/zahCsd7jO
         mKeb+DM1w2EJY0NAnBwj8XeFCQKqEyXUJ9bkbWN9uMy1fw+OKEVc63UcOrDLaRpa272J
         HNUa/n68aXDEauB/ypoHQDWh2MoJ62EGbDkwADbhcgJghSytQZVAvJ4VkZlUVXF491Kb
         JQog==
X-Gm-Message-State: AO0yUKWhP/tUguYm1LAk3NNbqXisBVtC4hxFhdSyl86xfEXIjMY1OzfT
        3tTe/Rmo/CODLdSPPh8Lu990xA==
X-Google-Smtp-Source: AK7set9vi1Kudu+mfwaGAQzzDqcG6Oi4AzoBF2AJW7EP/W22utNw41IONnw/9PDyo3r41Cec+H1Shw==
X-Received: by 2002:a17:902:c949:b0:19c:e405:4446 with SMTP id i9-20020a170902c94900b0019ce4054446mr2787974pla.30.1679477272647;
        Wed, 22 Mar 2023 02:27:52 -0700 (PDT)
Received: from centos78 (60-248-88-209.hinet-ip.hinet.net. [60.248.88.209])
        by smtp.googlemail.com with ESMTPSA id x8-20020a170902820800b0019a7ef5e9a8sm10203309pln.82.2023.03.22.02.27.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Mar 2023 02:27:52 -0700 (PDT)
Message-ID: <8022803536481106bbeca2f8eb33712668f41217.camel@areca.com.tw>
Subject: [PATCH 5/5] scsi: arcmsr: update driver's version to
 v1.50.00.13-20230206
From:   ching Huang <ching2048@areca.com.tw>
To:     martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        linux-scsi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Thu, 23 Mar 2023 01:27:51 +0800
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DATE_IN_FUTURE_06_12,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ching Huang <ching2048@areca.com.tw>

This patch update driver's version to v1.50.00.13-20230206

Signed-off-by: ching Huang <ching2048@areca.com.tw>
---

diff --git a/drivers/scsi/arcmsr/arcmsr.h b/drivers/scsi/arcmsr/arcmsr.h
index 6af8ae6..ed8d931 100644
--- a/drivers/scsi/arcmsr/arcmsr.h
+++ b/drivers/scsi/arcmsr/arcmsr.h
@@ -50,7 +50,7 @@ struct device_attribute;
 #define ARCMSR_MAX_OUTSTANDING_CMD	1024
 #define ARCMSR_DEFAULT_OUTSTANDING_CMD	128
 #define ARCMSR_MIN_OUTSTANDING_CMD	32
-#define ARCMSR_DRIVER_VERSION		"v1.50.00.05-20210429"
+#define ARCMSR_DRIVER_VERSION		"v1.50.00.13-20230206"
 #define ARCMSR_SCSI_INITIATOR_ID	255
 #define ARCMSR_MAX_XFER_SECTORS		512
 #define ARCMSR_MAX_XFER_SECTORS_B	4096

