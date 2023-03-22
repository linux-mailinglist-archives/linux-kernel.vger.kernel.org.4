Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E096E6C51FE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 18:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjCVRPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 13:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbjCVRPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 13:15:08 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED9B65469
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 10:15:04 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id eh3so75841545edb.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 10:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679505303; x=1682097303;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TXfJ+2b55JPGSMz5Q3HBnYgsDGuPhWyRh26ofAF5NYc=;
        b=TqoEOhVG/jqyArt9PpQt5UJgpgtofFHKrtBvtcXu/guu+XTExQebbY3kIoeqza0pcc
         eIzK/l88oHE2OTA0Bn1zUDtFtUZ9uf8REaBko3OWuV8ARFteJlIW/vBQU2PuphFvKxOO
         kqCJ4QmI8khz2Th92+/bHl+T8HfU4QEkPo/aT6oZFaJelwCStgaw5lcd5//x2pp74UPm
         zySxJMwI3afiGtMdfhEQMwwtD42WxUMKDEuSJ0BgvQDCGafaYLZZITBtTj97xZyvvwOC
         BxDFCrlHdkjKCdIZ1m5zZmCtBQmkHP1g1ejegCYtREP1/JfzOVt+2DB5kqTfvnlXsv9j
         IQbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679505303; x=1682097303;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TXfJ+2b55JPGSMz5Q3HBnYgsDGuPhWyRh26ofAF5NYc=;
        b=6LZwsOkL25RzbTHVcihyjVwLuRIj/z5I13XBrGUFXwdSDXSfp5xxdMWMqIFU/OxEvS
         EzxBS7YOuT2a/r3Ia2SJnvCaH1nfZwEy2WANbpC9xUYgZHk2+1DW1vJ4RL8ZAq0SC0b6
         AsH2asOwmVqETWNdv62O+DZOWsW4/82KvY09h2Exw5x00xlFGLEv12aAGRSK7H4+ZHfa
         2cU4vYHGKZTk1i7AsYujoAxRXIQYYAy6pK3V+qes7JFDvF4j87KCT6kDTqV7vqpZloMT
         hM1anN2N6JpBnYVq/cwwlKJVqa50guvEifEUzbjEWlUPOu+DsJJhhKjJ3Oruepo0eroH
         Ytow==
X-Gm-Message-State: AO0yUKWNxCDUlDYW1X18tdWAu/6aFwCni2aFc2ubd+xOL0wd4g2kyl20
        Qsor7KB3LsRPFu3GFvCqjJ5VXbAIDvs=
X-Google-Smtp-Source: AK7set+O97i1N28jdHjPDOelpFeYC4L6ZjRG3cBvgKFZHHZA1m3wOHPIpafA3QfcepZQB6Yqd48xwA==
X-Received: by 2002:a17:906:105c:b0:92f:ceed:ab35 with SMTP id j28-20020a170906105c00b0092fceedab35mr6321485ejj.5.1679505302611;
        Wed, 22 Mar 2023 10:15:02 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id c2-20020a170906694200b0092b546b57casm7471706ejs.195.2023.03.22.10.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 10:15:02 -0700 (PDT)
Date:   Wed, 22 Mar 2023 18:15:00 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/8] staging: rtl8192e: Remove unused macro
 queue_delayed_work_rsl and more
Message-ID: <3ed738a5d67a999ad42454fcb0d6668bfa706205.1679504314.git.philipp.g.hortmann@gmail.com>
References: <cover.1679504314.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1679504314.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused macro queue_delayed_work_rsl and queue_work_rsl to increase
readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
V1->V2: Changed subject line to be without “..”
---
 drivers/staging/rtl8192e/rtllib.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index cb904fc4f574..8965bb605eaa 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -62,10 +62,8 @@
 #define IW_CUSTOM_MAX	256	/* In bytes */
 #endif
 
-#define queue_delayed_work_rsl(x, y, z) queue_delayed_work(x, y, z)
 #define INIT_DELAYED_WORK_RSL(x, y, z) INIT_DELAYED_WORK(x, y)
 
-#define queue_work_rsl(x, y) queue_work(x, y)
 #define INIT_WORK_RSL(x, y, z) INIT_WORK(x, y)
 
 #define container_of_work_rsl(x, y, z) container_of(x, y, z)
-- 
2.39.2

