Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50720607F51
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 21:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiJUT40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 15:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiJUT4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 15:56:23 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06ED7257CCC
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 12:56:23 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id bh13so3455686pgb.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 12:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PVHR6st+fnyvZfjMvAocuNZtpc8eTVDV7jE2UDAUQUc=;
        b=LYzsRGKsbb/1ZyylXufuI8XNEppsOHrZaOGd72JjdthErF1TPZdgL/2giRc9ZrNTv7
         jyJmuvvoMsx2yDczM25IJe1bUlAcu04wHUKQFndcVXynBFJ2SJsXJCToRG0TXsnBcWwX
         hxbywQ+LEUSm9IAH9TWe1FVSFXmTA4tTsshvJgTGDIIVEjFCZdvRx2DZ1Wf1yIUt7ysj
         ciwbq5kVbWfdgXzzjjDSJIBu5ASdC8rubjBZ5JWuapW02MoYNx4QsMODQw9BM+EYGA5q
         4LItOYl5QIb+8fh/0vkd00zvIP5Xm/6c7K/SdPKao+fG9bxH1p+ake6zLSasa6hq7DFK
         AEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PVHR6st+fnyvZfjMvAocuNZtpc8eTVDV7jE2UDAUQUc=;
        b=7nHi1nd3npiszYJAWtYcspGUOhg09xV/MssE6cSRyuNsgJ9Nd0EO/FO0SSUweyoVE7
         XraFY2gKN6AI3JE9QYV+hlTzgjZs+mq03NX4/RqKJ/vvi2sml126vwygLMabFT99u0kW
         Fi3PY7F8dx68xTP9lQrym/h3JKW3zbiuIyL80jJimd9h8Poq85lRwk00IXQV1XH+sJ2y
         idZcFecZVKtDF4tZkSjoIMHfsyYsVMYZqbDHwa+CaWwS0ONhFOQtAsbCoUwsT0DGA9Tx
         ieyeRmtU3KTj9zmbrT76XxcrLZwlYKRbcuQutKUre9w2P8ZOs4m41gckf0f5YOD6Krgi
         J/vQ==
X-Gm-Message-State: ACrzQf0YdG+4ZOZ4LmV9ln01vN15+uwWGSnTJt7SrZMNgqVpcvrccWKG
        km+5KFI43Lf6l/e6q9CMFWE=
X-Google-Smtp-Source: AMsMyM7wtVtAENJMy0zwI6HAc0B7xm4IVcTdnVNBA1HZdGetCkDdmAjmdj4DlG8jdHsjUTCCKdYNdA==
X-Received: by 2002:a63:8141:0:b0:460:5be4:f6a9 with SMTP id t62-20020a638141000000b004605be4f6a9mr17366703pgd.368.1666382182549;
        Fri, 21 Oct 2022 12:56:22 -0700 (PDT)
Received: from localhost.localdomain (192-184-163-51.fiber.dynamic.sonic.net. [192.184.163.51])
        by smtp.gmail.com with ESMTPSA id g13-20020aa79dcd000000b005668b26ade0sm15179345pfq.136.2022.10.21.12.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 12:56:21 -0700 (PDT)
From:   Emily Peri <eperi1024@gmail.com>
To:     gregkh@linuxfoundation.org, outreachy@lists.linux.dev,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Emily Peri <eperi1024@gmail.com>
Subject: [PATCH v2 1/3] staging: rtl8723bs: remove tab in variable definition
Date:   Fri, 21 Oct 2022 12:54:55 -0700
Message-Id: <ee1bcccb23b3d24eb87d0b08bfa817b4af692dc5.1666380274.git.eperi1024@gmail.com>
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

Remove unnecessary tab in variable definition in rtw_ioctl_set. Issue
found by checkpatch.

Signed-off-by: Emily Peri <eperi1024@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ioctl_set.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
index 8c7daab141db..ede7d2930844 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
@@ -367,7 +367,7 @@ u8 rtw_set_802_11_disassociate(struct adapter *padapter)
 
 u8 rtw_set_802_11_bssid_list_scan(struct adapter *padapter, struct ndis_802_11_ssid *pssid, int ssid_max_num)
 {
-	struct	mlme_priv 	*pmlmepriv = &padapter->mlmepriv;
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	u8 res = true;
 
 	if (!padapter) {
-- 
2.34.1

