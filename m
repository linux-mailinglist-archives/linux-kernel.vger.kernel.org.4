Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73171607F53
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 21:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbiJUT4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 15:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiJUT4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 15:56:32 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7CF25C491
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 12:56:31 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id 67so3516103pfz.12
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 12:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q87+XlhQn6Tk3P1abcoeuNg9gQxaeIvmWYCmU3ZSX0w=;
        b=e0zwMkMHKkJlf9+RGMoru+W87WKCq8xNa/1hVwEGzJNTqSO4gA+72IUm5X5QYaw4MM
         b0Y+4xDS3CNIkcjZ8/BIx4pdqJLd/pkGg/9yFM6OHJM1GpHcnTot1+qXayEyKHlbsm58
         EoXGJQpLzjqk1QVmnD6Fj1HCWVfh00PkxEHQgmwlaEpsuj4ZEzpWI10ABgOU6K0pU/1D
         Ou6ya4V2MWr8B9lmN+L1JX5guAf9zwwOsp7iV0L7UhUOiGO2LVuPSIdcN6eJaEfgkgJS
         SvTdNBi1rYpn8pHHOvbMdTllC7bPVYrOVq7d92/Nst74zo4lMTSorzbbNTnRGthdd//t
         5J4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q87+XlhQn6Tk3P1abcoeuNg9gQxaeIvmWYCmU3ZSX0w=;
        b=SYSXuNlztm/WT2qjH32RG7fJ2lg0QOC70gjbPKx91M78nV6kE80lovtMuIpYYZ9LXH
         Hug7LRZ8/a8Js1HEbgUYK2LwM3DclAM53vPLENn01mzx8C1ywuv2u1IIBXm1JM/ZAnmF
         7HZ0ZhD2J1z9tVxXplHKh+9KmDUOKAgjoTO6Zu76d39pM2NC8lL7piDMIho2o2eTp+Aq
         vDB9MQKSQT8g3pAm8oKCaldLfNfXn9m1BrpkIQ+aQWCd20Wv8nkLoPSZeAGNJ+20aHUn
         NM+agTrxPcmeZXQ/jMbbQpiCwuVOSuX0SGIHXvbaA2fHqL7C/4en+JIEbbquSGVMhSVd
         a52g==
X-Gm-Message-State: ACrzQf34B3MdDhYWuDJxpP61QTdObPA9hQcZbGZ95P4trn+u60dy3jWb
        oy0kdhC/j4k07LtmvZO3ukY=
X-Google-Smtp-Source: AMsMyM4xqb6gSapkyekAI3xQRGN8PuvNIv5AfbBFdOkanjUQMGgYGMON0kG502mfjhXtN+OO3+rvkA==
X-Received: by 2002:a65:6d1a:0:b0:3fb:2109:7b87 with SMTP id bf26-20020a656d1a000000b003fb21097b87mr17299819pgb.127.1666382190589;
        Fri, 21 Oct 2022 12:56:30 -0700 (PDT)
Received: from localhost.localdomain (192-184-163-51.fiber.dynamic.sonic.net. [192.184.163.51])
        by smtp.gmail.com with ESMTPSA id g13-20020aa79dcd000000b005668b26ade0sm15179345pfq.136.2022.10.21.12.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 12:56:30 -0700 (PDT)
From:   Emily Peri <eperi1024@gmail.com>
To:     gregkh@linuxfoundation.org, outreachy@lists.linux.dev,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Emily Peri <eperi1024@gmail.com>
Subject: [PATCH v2 3/3] staging: rtl8723bs: use tab instead of spaces for indent
Date:   Fri, 21 Oct 2022 12:54:57 -0700
Message-Id: <0516cac046c617b55718fddb2aac3a50d543d84c.1666380274.git.eperi1024@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1666380274.git.eperi1024@gmail.com>
References: <cover.1666380274.git.eperi1024@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace spaces with tab for indent and correct alignment for closing
brace in rtw_ioctl_set. Issue found by checkpatch.

Signed-off-by: Emily Peri <eperi1024@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ioctl_set.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
index 47323160e72d..3b44f0dd5b0a 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
@@ -312,7 +312,7 @@ u8 rtw_set_802_11_infrastructure_mode(struct adapter *padapter,
 		if ((*pold_state == Ndis802_11Infrastructure) || (*pold_state == Ndis802_11IBSS)) {
 			if (check_fwstate(pmlmepriv, _FW_LINKED) == true)
 				rtw_indicate_disconnect(padapter); /* will clr Linked_state; before this function, we must have checked whether issue dis-assoc_cmd or not */
-	       }
+		}
 
 		*pold_state = networktype;
 
-- 
2.34.1

