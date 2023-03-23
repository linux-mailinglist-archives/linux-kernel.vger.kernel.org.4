Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9AC6C68A0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 13:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjCWMmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 08:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbjCWMl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 08:41:57 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC9526C0E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 05:41:53 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id cn12so40300992edb.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 05:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679575312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bNg7iZ+PuRMN0DqLdZrW00PMhOD0f4GRznXTT5Ec9ug=;
        b=c2mdPwifKTGrVqQfBoQq5+0Qbh3+PzLWiTCBTCOI4wPnQmVhzmFPhlk5IcPthraXZ3
         1HXFfgirj+JKFx4BbPzy/P5IF4NUDy3ujgKxJ6Zg8IKS8ikQXsMHfm4Xnx0tYE7R4sTD
         vgQnQCLxPv3GCDiorv5u8pIdElZpye5l8wdwJde09YUNsotqRaoE6vUPDMQZ0MSllAlC
         +13Ez1ev9J65M3fJcugW9nCxTkP+0c76tSy9m093j8yoyhKMFbnaTEYPL5kNxj53v3pa
         QqPaErJgBodvp7zJ3BG3YxxkrPQuCFgiIMy8LhHWvL8tUkkHngN+SAmK6yP4TkjqU9mZ
         4l8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679575312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bNg7iZ+PuRMN0DqLdZrW00PMhOD0f4GRznXTT5Ec9ug=;
        b=fXVhV60EHaqrJKITdOOZCaj825t9Qsli76eSOy9W6sF+vrDly/hXy2Id9ohjejfdC1
         EIQvzZ0WwRcmiabiNN09m8ABvyGKZ2WF8ghUhAWZ8RjywhjtOqHzUKuS2bgdkxnTZZRn
         LZZ09wzHkfika8sn/kNwaQolV9lqs4x+Rd5tRHGvst58oK1y7j5q/FK3tLyVhHOtBmHe
         MIRvchHFQUNbnTpUH/1ZVzaO8t0PjhF3/zjKZ3ybtsD28QcS+e/Ma5iykqtWjQcZi51P
         9CxkMJutIuRsIGxdv+LxjvzKDFI/gel2SOjA5qdw6AWViwHL1IEgQxd8ayzWgC3lVuPy
         UfjA==
X-Gm-Message-State: AO0yUKU12ibay5Z1k8wdZixaMXRCw66z+Bqg4NFqhGumS+WAnEY8D7o1
        6GtPTX4O2FB5MQwNCOayNsU=
X-Google-Smtp-Source: AK7set/+XEjs58tHkW2iyt4lkh0/495N66AhyWek8O/RYAogGfqhYlkGlfP6yviSN2wtRHgYI8sYMg==
X-Received: by 2002:a17:906:3710:b0:923:812c:a5d3 with SMTP id d16-20020a170906371000b00923812ca5d3mr5550362ejc.25.1679575312825;
        Thu, 23 Mar 2023 05:41:52 -0700 (PDT)
Received: from khadija-virtual-machine.localdomain ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id g1-20020a1709061c8100b0092669fb4ba1sm8597116ejh.130.2023.03.23.05.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 05:41:52 -0700 (PDT)
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 2/4] staging: rtl8192e: add blank lines after declarations
Date:   Thu, 23 Mar 2023 17:41:43 +0500
Message-Id: <eae4647540b26afa88ee99209e39f5b461e7132b.1679573474.git.kamrankhadijadj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1679573474.git.kamrankhadijadj@gmail.com>
References: <cover.1679573474.git.kamrankhadijadj@gmail.com>
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

