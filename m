Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B90DC5F7D6D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 20:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiJGScf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 14:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiJGScd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 14:32:33 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F639D2CFC;
        Fri,  7 Oct 2022 11:32:26 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id ay9so3339548qtb.0;
        Fri, 07 Oct 2022 11:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e6P6g2j7gHc+dCGuLY9AwhSfRUocqi2EQUPgF4YKlwQ=;
        b=lngHBD4edZIvv6F2ACdGicqNpGRJB4aeCT4vuZAsRE3IkFAgnj4PDIYnb3irLyT2Sl
         Fj2RUza2HL0srflOAhqz9GATviziXISjpaXgi54XlCgAJHl3bA2A9yeUG78Hqi0Ui6Yu
         vYEZ9K6dfYoxDixiKx2fcquVhetCVTJ+uYWDR9lht7bfa6PxwytD/1QE5B/R1LwqU8Fn
         LAUi5mUqysAyn3n6T3b20By3p5LV6xS49hJaROF/aDXj+uJGwuH8wxkEaTC/t9wee8sp
         dY8qdxqyhoTiZKgfsQmfs144GJrv9EPn1cj3lJAVPOQwaRGWLT4g6/MobqtnC4HIwWV1
         UUpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e6P6g2j7gHc+dCGuLY9AwhSfRUocqi2EQUPgF4YKlwQ=;
        b=A2SEr6eFFrK3ByWrIHAMwapqUXO5zWkCWAG2e8ioWRVsCtyTbGlZhc+jGHRII4fwHf
         8qppMFJpZQ2xcFhfvxQRkTTCZJGGvk1FHbjW5a9F5SI0f/H7nnqyeN9QVnSr0zaaP3a9
         ahrhoMP7e0SFBvbKRcMBOILBRAq9h9DZdlt4+HLopvFg2Ny3wxYY2Wq5hJKKlw6AW2uv
         f5F98RycG4o2s5xZq6qoH5RP2njlAPenR/XU1z8ORGhqljaorIklq/PnEToBYhcqGJCt
         rASHmyeFCNa5l2OFdYP5eLh8e1gKQRtmWr+XEkU4MiuZPj3LIYYWISt5SaiQ273UERGh
         +9yg==
X-Gm-Message-State: ACrzQf3VyZmSalpjKEeShtSa7EWrv9FheNV82/pmu+wCGlSQkcBC6uRE
        rNaTKmdVtXeiG/gHq1WcpM8y8N4bs8sl8w==
X-Google-Smtp-Source: AMsMyM6tQktkK1zI7/JKOQ34ne9zAhOXQAcYwGfyN1Kp7hclSGuJayjqeKdCR8SI+2zSrLcdCF6usA==
X-Received: by 2002:a05:622a:50e:b0:35d:4f2c:f3df with SMTP id l14-20020a05622a050e00b0035d4f2cf3dfmr5303886qtx.521.1665167544641;
        Fri, 07 Oct 2022 11:32:24 -0700 (PDT)
Received: from stbirv-lnx-2.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id w20-20020ac86b14000000b0035cebb79aaesm2602229qts.18.2022.10.07.11.32.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Oct 2022 11:32:24 -0700 (PDT)
From:   justinpopo6@gmail.com
To:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, vkoul@kernel.org, kishon@ti.com
Cc:     f.fainelli@gmail.com, alcooperx@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, justin.chen@broadcom.com,
        Justin Chen <justinpopo6@gmail.com>
Subject: [PATCH v2] MAINTAINERS: Update maintainers for broadcom USB
Date:   Fri,  7 Oct 2022 11:32:09 -0700
Message-Id: <1665167529-9840-1-git-send-email-justinpopo6@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Justin Chen <justinpopo6@gmail.com>

Al Cooper is no longer the internal broadcom maintainer for broadcom
USB. I will be taking his place as the internal maintainer and as an
additional upstream maintainer.

Signed-off-by: Justin Chen <justinpopo6@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8656ab7..3e8ecde2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4078,6 +4078,7 @@ N:	bcm7038
 N:	bcm7120
 
 BROADCOM BDC DRIVER
+M:	Justin Chen <justinpopo6@gmail.com>
 M:	Al Cooper <alcooperx@gmail.com>
 L:	linux-usb@vger.kernel.org
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
@@ -4184,6 +4185,7 @@ F:	Documentation/devicetree/bindings/serial/brcm,bcm7271-uart.yaml
 F:	drivers/tty/serial/8250/8250_bcm7271.c
 
 BROADCOM BRCMSTB USB EHCI DRIVER
+M:	Justin Chen <justinpopo6@gmail.com>
 M:	Al Cooper <alcooperx@gmail.com>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	linux-usb@vger.kernel.org
@@ -4200,6 +4202,7 @@ F:	Documentation/devicetree/bindings/usb/brcm,usb-pinmap.yaml
 F:	drivers/usb/misc/brcmstb-usb-pinmap.c
 
 BROADCOM BRCMSTB USB2 and USB3 PHY DRIVER
+M:	Justin Chen <justinpopo6@gmail.com>
 M:	Al Cooper <alcooperx@gmail.com>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	linux-kernel@vger.kernel.org
-- 
2.7.4

