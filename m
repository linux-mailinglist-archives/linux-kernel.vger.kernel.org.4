Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDB95F71A2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 01:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232321AbiJFXV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 19:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbiJFXVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 19:21:24 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956BECD5DE;
        Thu,  6 Oct 2022 16:21:23 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id g10so52376qtu.2;
        Thu, 06 Oct 2022 16:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HsUtilPeZlwiKK6ImAsDozMQbGgITU56YSuN7fZPUFg=;
        b=oLvgSk7wyDNAxPsi04wSzI05U8IFD/9D6c0gJSCWFNXXnS7nT63SxHTJMIkMhn7u4s
         W7YM5OXBjrvqpaDC4n3IywUaXI5wfPq95R9NCx8HfeJEHcTr0U2UPBYszrIgLVaDWIWu
         wYb8qWPrBN+sAFLuoheZrQvzmiEsgrZ1nQzaefRUTkQ1//CmL/roECN8+yKNUs+rdNCs
         7y+sbHtClpAjgo9lSYO1j/CMm5hQ4VraD/nNVSP03gIf3u9a1//qLqsGgLCloII0P1Pz
         10s9y1EzNZerXaEyAEsfuEpPzxTgbVlmwGfIIijW7jUosW9wbYUuITiFI5ZAnzIvslfL
         MZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HsUtilPeZlwiKK6ImAsDozMQbGgITU56YSuN7fZPUFg=;
        b=EycEFOt97XK/ugnZ0cX13ZBYSTRdGAStIT4WhB6zY9S4a2lYavqdS6haxLKhyBXgoA
         WNK+WEOclAMB2G9Ufh3ighdAT5KTeb+K/p1qQvkIWyx0Imve42Bt3leknV7jCD39qfmW
         /jzxnDcDkhbj3ucclGzL8hFiB12ZRN6W3zT97c8KxJgAdR9sbNvRl1pCFLDm7aAsl3aM
         OKNe1vUj6A6Wma8dIuYUWhgVKz2Q83OTcpndKknMrdIfLBgmNaSRbQOHCFSRXNFLhnX+
         OsGZj+vXHsHm2/L5ErfFU8EKUpfVOFmBLbXb2k0XjK5iVhlnzSnHXNz3Jnbjj9akRU3o
         WX1Q==
X-Gm-Message-State: ACrzQf1KHqFVOnpU6FTW0rR5pm+l7IaeG/1jHb0VldIdgM745k7nxBP8
        p8qDygttn1eExpNpSUVtagll4K3sLa3uBg==
X-Google-Smtp-Source: AMsMyM7UZNC5pCZp5Bpvb39hed0mQQU7FrMrF0YiKgsU7ewt+TMNuQVg1kIrsvbfNI4bAjY64Arj7Q==
X-Received: by 2002:a05:622a:164a:b0:35c:b87f:4839 with SMTP id y10-20020a05622a164a00b0035cb87f4839mr2307111qtj.219.1665098482325;
        Thu, 06 Oct 2022 16:21:22 -0700 (PDT)
Received: from stbirv-lnx-2.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id ay18-20020a05620a179200b006ce2c3c48ebsm386825qkb.77.2022.10.06.16.21.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Oct 2022 16:21:21 -0700 (PDT)
From:   justinpopo6@gmail.com
To:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, vkoul@kernel.org, kishon@ti.com,
        linux-phy@lists.infradead.org
Cc:     f.fainelli@gmail.com, alcooperx@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, justin.chen@broadcom.com,
        Justin Chen <justinpopo6@gmail.com>
Subject: [PATCH] MAINTAINERS: Update maintainers for broadcom USB
Date:   Thu,  6 Oct 2022 16:21:09 -0700
Message-Id: <1665098469-19008-1-git-send-email-justinpopo6@gmail.com>
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

Al Cooper is no longer the downstream maintainer for broadcom USB.
I will be taking his place as downstream and as an additional
upstream maintainer.

Signed-off-by: Justin Chen <justinpopo6@gmail.com>
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

