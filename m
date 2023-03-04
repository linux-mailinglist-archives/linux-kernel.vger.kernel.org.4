Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4866AAB48
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 17:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjCDQ4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 11:56:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCDQ4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 11:56:33 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429A51167A;
        Sat,  4 Mar 2023 08:56:32 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id l7-20020a05600c1d0700b003eb5e6d906bso2887267wms.5;
        Sat, 04 Mar 2023 08:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677948991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7DFg40ZbzBwbxAQIzgLZb9hlOQi951FRq11YcrT+rHY=;
        b=R1khRiSljPmQfcARuhVjpQYpIkeP1JdmNXv8h9lvWE+A7dz2VPO0eE1tpN53c/CnM4
         ob7ys3L8QyRp3iVPTVT/H5s+6bCj0FDUrFvpsiAw1h91iLmf3jgcptTzur15iahJ/OUH
         308TI8AeR6r/KzJaQV2QDATy3zcKkfzu915PpYSuXqe5QNzx5iNn0TuAOVyU4h/TI/xA
         q1Y+dD+3gInsxY2CpcVrQqBmPWkBw4bnCdNAPxgUYj4LaRtOULRr9/nNUFvF7sksoKQa
         fxst/e3agkh3KssB0R0F1TQXNHa4wx36UgSWne5QKBCBTcxmExZ2aJQt93IGpI3yQetq
         s4ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677948991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7DFg40ZbzBwbxAQIzgLZb9hlOQi951FRq11YcrT+rHY=;
        b=Qth2WKc15Uaw2kEy7hNErfKteUas8JVbx6heFoUjsB3SDuU79E21+yMQS9sRuRDxGk
         JTqt/d6rKNml93Hm6CBC6t2CMtf+fkO6w9sEOhLOtbaDrU2Vl/BdnxLK17mA6293Z/YX
         l6nxzm7yhlLC3+a9RxfjaGxt4KOAo1ypTjEDHkyobXTMf0JXgJT7hBWKbXGN1cMOo5fJ
         Az0iaU95hvjxsPFPxHoQwk30Ffumi8iBzeu/9kIg+1MzAfgw6Ia6NI0TAA/hjNV2rRVd
         E+OAZUOCcilyLMhKvidS0Py+q3e/kpd/8Yc9gRPYoYclgBlgAy0WgxqhRaWY2tQFRxCg
         QY/Q==
X-Gm-Message-State: AO0yUKVsKEKX00qHL0ZsoTWf5vDK91RRMHiuPneM0YUPWtIfXCeaXDl+
        xlBvbyzrFUEo0Nl+oCoWaQ==
X-Google-Smtp-Source: AK7set/hW04X57UI8FVF5W0m+9n/Kt0M0McLznL/1hwSVHOFFawJ+jVvl5Bev9Mj02GvACLwkrUPMw==
X-Received: by 2002:a05:600c:3ba6:b0:3ea:e7f6:fc2e with SMTP id n38-20020a05600c3ba600b003eae7f6fc2emr4909406wms.6.1677948990714;
        Sat, 04 Mar 2023 08:56:30 -0800 (PST)
Received: from p183 ([46.53.251.240])
        by smtp.gmail.com with ESMTPSA id v12-20020a05600c12cc00b003de2fc8214esm5525769wmd.20.2023.03.04.08.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 08:56:30 -0800 (PST)
Date:   Sat, 4 Mar 2023 19:56:28 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] menuconfig: reclaim 1 more vertical line
Message-ID: <8a8c8ed8-f322-4024-9433-3a9cb524484e@p183>
References: <94a94ef4-9d55-4293-8363-3c0243eceae1@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <94a94ef4-9d55-4293-8363-3c0243eceae1@p183>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Empty line after legend is waste, use it for config options.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 scripts/kconfig/lxdialog/menubox.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/scripts/kconfig/lxdialog/menubox.c
+++ b/scripts/kconfig/lxdialog/menubox.c
@@ -185,7 +185,7 @@ int dialog_menu(const char *title, const char *prompt,
 
 	height -= 2;
 	width  -= 5;
-	menu_height = height - 10;
+	menu_height = height - 9;
 
 	max_choice = MIN(menu_height, item_count());
 
