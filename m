Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145A560C182
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 04:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbiJYCJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 22:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiJYCJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 22:09:08 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E03B31EEE;
        Mon, 24 Oct 2022 19:09:06 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id s196so10267859pgs.3;
        Mon, 24 Oct 2022 19:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Pm3uBTI2KyqfNFZG8zBDmAPLyP8aHcCfyyi7loUOwwU=;
        b=LLBbz+nSU2WPxTx1LHdM1QUtJxdTj36sWunxs0/XsvfUJiXhf94YmGoHTpCCtdua0L
         14huliCPBU8aR4E9FYCQ4VuD287NEl7HnTdYVhYWFKhd12eiLEao3wkdnC53STj5hsQV
         wlBwSGGgzMCwgxZ5jGt6ZwYbSAd/LB7wFv4xSCSrjLWCLnCH1Tyw1kfgqHr7JAHNlQgk
         WTv9l8kSyq4XCUhz+E0FMh9AnM2Qwjmk9clBSQOHCFiNd7P36XM8q4yOfi9q+Z2Ze9/4
         WxNeGjGfpSbZTHT2XPns/gwnEdfaQjtsjBj8D0mHK0WWCHg5MH/jLL3SMnXB0l4YKVbF
         O1kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pm3uBTI2KyqfNFZG8zBDmAPLyP8aHcCfyyi7loUOwwU=;
        b=gEjpiDv3tOxOMC/y3sYcUnat1mhIPVv+QolbqtiKWoEUTECAm+cZKGXVmhfxPAHJUK
         Q3DBOW7mhEHsRSszHFNod0yQCP66pAFCT9z3iirxokajXZfnQlelreK0QdL+tWDNqCpp
         6u7Vw/5cUvuTPQi+QNaFTbejfAGE0juOC6GqclO2ajz1mkZMbGmn1wyq1rSFYY/4xorQ
         jWHCq71iV2kxzDWpSJXlG8pOwwRRcWVwxQxgbPMDtV4Qo+LKi2UH77Q/xuEx8JaHPTkx
         Uns4sC9XmGoAdy66lyyed/WAjtafF9y84ZN30Qg1aKBuL5BHR92/++ER4Ym5jo/5KL0l
         Z7NQ==
X-Gm-Message-State: ACrzQf1H7+Ou132HyCoc1jJNDB58dlGJoFb9b1NBNDTc/ZGNVtB8g/fZ
        G5MGAjS3d7Jn2K9rmPCdtA62zPb3YSo=
X-Google-Smtp-Source: AMsMyM6TvAu7HSzVk41KXIjjB1wvSO/fyRQDbFUp8OyaCscpgUP5cnmYDmpXvIG2fHp2dKUS+5w8Zw==
X-Received: by 2002:a05:6a00:1309:b0:535:d421:1347 with SMTP id j9-20020a056a00130900b00535d4211347mr36764044pfu.5.1666663745665;
        Mon, 24 Oct 2022 19:09:05 -0700 (PDT)
Received: from voyager.lan ([45.124.203.18])
        by smtp.gmail.com with ESMTPSA id a6-20020a170902ecc600b0017f80305239sm338116plh.136.2022.10.24.19.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 19:09:04 -0700 (PDT)
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Neal Liu <neal_liu@aspeedtech.com>, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Add Ben as a reviewer for ASPEED UCD
Date:   Tue, 25 Oct 2022 12:38:56 +1030
Message-Id: <20221025020856.744202-1-joel@jms.id.au>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

He wrote the vhub driver and would like to be cc'd on patches.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 MAINTAINERS | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3bb30c0d1cb4..637beabc70f1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3232,12 +3232,15 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/media/aspeed-video.txt
 F:	drivers/media/platform/aspeed/
 
-ASPEED USB UDC DRIVER
+ASPEED USB UDC DRIVERS
 M:	Neal Liu <neal_liu@aspeedtech.com>
+R:	Benjamin Herrenschmidt <benh@kernel.crashing.org>
 L:	linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/usb/aspeed,ast2600-udc.yaml
 F:	drivers/usb/gadget/udc/aspeed_udc.c
+F:	Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml
+F: 	drivers/usb/gadget/udc/aspeed-vhub/
 
 ASPEED CRYPTO DRIVER
 M:	Neal Liu <neal_liu@aspeedtech.com>
-- 
2.35.1

