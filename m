Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD196BE18F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 07:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjCQGu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 02:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbjCQGuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 02:50:52 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F441BD4D9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 23:50:50 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id h8so16557287ede.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 23:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679035849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vsabCMN0jVXQwz5SLXDNmhQC+MOhJm5LHTpIIA+t6Qo=;
        b=UdS4eGISzJzHT/LF8yroXOCbDwHnve5JXf1pWBusOrBy2ytJVdMeHJujkpReG2+1zD
         J/9kOwHT5dZ01kGEQHbBcJvAUfmRMxR6rty88hiPLkQFHnCbRS9pfeDCaA9gStfeGue2
         JQEJo81n160sPj0nwt4KFBMX0jxPUn//V2Kvbx2q7tKQ22AtxfkHBCy+ge5iiyUN/gFf
         AQKlm+LrDr9Z0Thp895siT3bKQl8nEdnOpdqW0khh0j7QOwE870NLIIbnmUNOC6vHpWh
         efkCKOgx0Td0IzxEPsD53+GGti271joQKlnxD6i7TLzhTHymvUqcSIFinM6saO3O+l9Q
         J4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679035849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vsabCMN0jVXQwz5SLXDNmhQC+MOhJm5LHTpIIA+t6Qo=;
        b=eXMRDaIEVqPayLBftEgjzzbINBEMy+WZM1GcTC/2gr24p+hNwkCjtxGqjp48NizQEN
         wqLd+n0ceCAX9DEZ888ncYYgudpMymsS69WcJTBZTmrDog1rVNSCP7XE4YMusE840noj
         SQFidhSc1YD5zkYpF5LNJDnn6rYxtKtf/CV3XDjkySp+kHSbH257XZhgH8hfyqR48FQS
         SMQ0819F/I5b5cYnbUhzzx4uXZc58XdDTsxsdQzaTsb1IBtGTQtM7qebU3M0IuF/v2Tb
         Z9EW1nHc8v3XtG8KGN9z0KM99UGSTbIWYVZZZJWMPhy8KaZ/rSQenrwKYFMTbtBEUOLR
         Z9mQ==
X-Gm-Message-State: AO0yUKVMoqSGqwIzD/5XEwPN4Nn0npUiIzBzn/aJY5EGqy3JCaUaibS3
        R26X0zleb0aS/Dta3q78RKo=
X-Google-Smtp-Source: AK7set/nd1glzlt6Z9M5cWM/ndx6NmSuRKnBc0iy5Kk/tLAeqM8NjAzT9uvTQthctAzKYm3+FJqUUA==
X-Received: by 2002:a17:906:20c3:b0:927:6e70:e245 with SMTP id c3-20020a17090620c300b009276e70e245mr11785010ejc.63.1679035849007;
        Thu, 16 Mar 2023 23:50:49 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abbef.dynamic.kabel-deutschland.de. [95.90.187.239])
        by smtp.gmail.com with ESMTPSA id z24-20020a17090674d800b009289de993e2sm577438ejl.216.2023.03.16.23.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 23:50:48 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     forest@alittletooquiet.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/2] staging: vt6655: remove unused bb_power_save_mode_off() function
Date:   Fri, 17 Mar 2023 07:50:41 +0100
Message-Id: <20230317065041.16635-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230317065041.16635-1-straube.linux@gmail.com>
References: <20230317065041.16635-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TVD_SUBJ_WIPE_DEBT
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function bb_power_save_mode_off() is not used anywhere, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/vt6655/baseband.c | 22 ----------------------
 drivers/staging/vt6655/baseband.h |  1 -
 2 files changed, 23 deletions(-)

diff --git a/drivers/staging/vt6655/baseband.c b/drivers/staging/vt6655/baseband.c
index d7c3e4bec560..0e135af8316b 100644
--- a/drivers/staging/vt6655/baseband.c
+++ b/drivers/staging/vt6655/baseband.c
@@ -2171,28 +2171,6 @@ bb_software_reset(struct vnt_private *priv)
 	bb_write_embedded(priv, 0x9C, 0);
 }
 
-/*
- * Description: Baseband Power Save Mode OFF
- *
- * Parameters:
- *  In:
- *      iobase      - I/O base address
- *  Out:
- *      none
- *
- * Return Value: none
- *
- */
-void
-bb_power_save_mode_off(struct vnt_private *priv)
-{
-	unsigned char by_org_data;
-
-	bb_read_embedded(priv, 0x0D, &by_org_data);
-	by_org_data &= ~(BIT(0));
-	bb_write_embedded(priv, 0x0D, by_org_data);
-}
-
 /*
  * Description: Set Tx Antenna mode
  *
diff --git a/drivers/staging/vt6655/baseband.h b/drivers/staging/vt6655/baseband.h
index d1128d050ac5..e4a02c240a1c 100644
--- a/drivers/staging/vt6655/baseband.h
+++ b/drivers/staging/vt6655/baseband.h
@@ -63,7 +63,6 @@ void bb_set_vga_gain_offset(struct vnt_private *priv, unsigned char by_data);
 /* VT3253 Baseband */
 bool bb_vt3253_init(struct vnt_private *priv);
 void bb_software_reset(struct vnt_private *priv);
-void bb_power_save_mode_off(struct vnt_private *priv);
 void bb_set_tx_antenna_mode(struct vnt_private *priv,
 			    unsigned char by_antenna_mode);
 void bb_set_rx_antenna_mode(struct vnt_private *priv,
-- 
2.40.0

