Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453A86C70F1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 20:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjCWTUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 15:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjCWTUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 15:20:13 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CA59004
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 12:20:12 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id cn12so45550017edb.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 12:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679599210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bNg7iZ+PuRMN0DqLdZrW00PMhOD0f4GRznXTT5Ec9ug=;
        b=OJIo47Myz01VHL4lrQeojnyEpyLvmvQXDDd6hHSS/33DZtiIbZVU7qBQHVeN4eZmqL
         pI2LMQEvACyay5EpO7m6NGMH86o9x5+k7B9iv6q7KUkN6DVpgEls47lJsY7TVbLUuYYs
         EgX/06Rd6Ojoal6cMZxhPVS3xQDwCs2aWpLeWE9CozYurmhRzls9imDtcCRe2uLvVFDp
         J1agRigoHP+AyEzl9XD55oHW1M1J+5dFbufDsoa0zPDlhs8FzN2XvXMVucbHr5aIA+MH
         ryYX++TbCXHWoTO5zgUPCSntzQlRZJShFvrRv/YZ10dv8/2LwakQd17YgLq3BiwvLzBn
         yYtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679599210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bNg7iZ+PuRMN0DqLdZrW00PMhOD0f4GRznXTT5Ec9ug=;
        b=t/W4DFpIolAOvESFd4G59OMsUYBNFRrpEcJXFePw70OZF1wlnkuh8j9JtfJRPKWgG1
         Nfi83nyzEv5JH5T/AIb1Y6GeUu1XPdYyqTBGME7cf9VBIHFuqrXlMlKXXFjCdVtpXxC1
         frJ7ley99f4J7qr3JmxJuXAVgEiJrH7nZiWzu10USbHNLaaQgaGzGhg0mfqpoC/lhyJJ
         ziUaE3H0Ip7SCyfohTdUa04BGA7ot/V5N387F2E0HntzV6ZzJ1Q5I/xs9RPp7E5Ws6En
         hWAR7r/CN2FHwvtfJYVxKNW6pv1fQDyp7+ZQ7Z3VyttS63O+2FQepTXbU5g7N1VgNr+U
         FkVg==
X-Gm-Message-State: AAQBX9eFFuYyRM1kTm3YD5SWO+C145SfUA/9FJv0Ij8wZAjTwe3p7oG5
        GhHB/6X2Enf8sFtFIzszsOk=
X-Google-Smtp-Source: AKy350aEDwuUxxMp4nnwx5P5DHdZ0chMO6ZyhQIUZoD3U+kI9JNHF+uSmtwf+ENiSGPY9Y3xEewkHQ==
X-Received: by 2002:a17:906:3592:b0:932:ba53:83ba with SMTP id o18-20020a170906359200b00932ba5383bamr126094ejb.34.1679599209880;
        Thu, 23 Mar 2023 12:20:09 -0700 (PDT)
Received: from khadija-virtual-machine.localdomain ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id ia9-20020a170907a06900b00932b3e2c015sm8161409ejc.51.2023.03.23.12.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 12:20:09 -0700 (PDT)
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] staging: rtl8192e: add blank lines after declarations
Date:   Fri, 24 Mar 2023 00:20:00 +0500
Message-Id: <eae4647540b26afa88ee99209e39f5b461e7132b.1679598576.git.kamrankhadijadj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1679598576.git.kamrankhadijadj@gmail.com>
References: <cover.1679598576.git.kamrankhadijadj@gmail.com>
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

Add blank lines after declarations as reported by checkpatch.pl

"CHECK: Please use a blank line after function/struct/union/enum
declarations"

Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_rx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index c6114d99829b..7144a0630ea6 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -231,10 +231,12 @@ rtllib_rx_frame_mgmt(struct rtllib_device *ieee, struct sk_buff *skb,
 static unsigned char rfc1042_header[] = {
 	0xaa, 0xaa, 0x03, 0x00, 0x00, 0x00
 };
+
 /* Bridge-Tunnel header (for EtherTypes ETH_P_AARP and ETH_P_IPX) */
 static unsigned char bridge_tunnel_header[] = {
 	0xaa, 0xaa, 0x03, 0x00, 0x00, 0xf8
 };
+
 /* No encapsulation header if EtherType < 0x600 (=length) */
 
 /* Called by rtllib_rx_frame_decrypt */
-- 
2.34.1

