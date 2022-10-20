Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADCE160555A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 04:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbiJTCOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 22:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbiJTCOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 22:14:31 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D489128E3D
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 19:14:30 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id u8-20020a17090a5e4800b002106dcdd4a0so1976795pji.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 19:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I3ANpxjJ572lzCN+d7NeAV+J7e07b8qZ08Zpd9awBZk=;
        b=LdPZykmSqN6UwxtypWa2H15iI1/ZrD3Z9GGkGlxaAGsFw8K99tPDeUPZMp9OI/wF1T
         Vzl4hBhXGlRZ2tg0X/KBwo7DqO2/4IRujPeby9Pr4Wti8jcgew3rub+0HelojqiQsfKB
         6rKJ4NaeYqeNpgKTickgVynxBqzPWm8iEFoSHb5AtHBPemVCrRfPPI7JMLmfLkd/f5IJ
         FX/v5Rspo6JlJGO6pC01AVqD3tcvua04jwVXgHnmml7uMzWRZTNyOd5cSSMWVZJNwf3y
         LJoEoysx5eUy2h1kMJyiBw1PFop2vQdc+S7sHgqbNn7q/aeo+VZet5aan6dB07sf25j7
         RdFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I3ANpxjJ572lzCN+d7NeAV+J7e07b8qZ08Zpd9awBZk=;
        b=W6gtQv/RJPiPQlyAqHu6lbOZ9qXjEf2/hMP5SQX2nmNS8hYI6b57VSC3tcSNMNmpDh
         XCDbE/Ppm55GVpfD0PxmgF+8DBcprEa14iAbLqlplSKze25BM6SBQg/i8e+kSC1xFswB
         gHLjLe1JZ4NtaKt8Njjm9zdCECP5GXaBWe4x3bQlWWx0BesAFmy4Mr+CMznhqaIOmXCA
         0BwMOQVXjX40XOV31ri2WcfjdWbjwFYx2RXFx4/4Fgn8DAywgRTi4wnPUadA0X8AiO4K
         F0MesuVY5nge8Gd6s9iVAfA6iYpfyHMn31jIP+8mOz3eJt+EIp9pXOhd/Bw9YFiAjcVu
         cHTA==
X-Gm-Message-State: ACrzQf3CTXxDPHZEd5976OJASWfR/tz2o/3bcmWbq1AjXK0E/TaXqxEJ
        FNN5A8ZpA0vffcOe8M6Dssbu/Bw1mhRqGA==
X-Google-Smtp-Source: AMsMyM4FY7Z/vObWo6W/aKPN+GV/NUPBodquhSEqJnUrucWScnRYdQJjsDQmHxtdRz40InqSLjqLOA==
X-Received: by 2002:a17:903:189:b0:183:7473:57f1 with SMTP id z9-20020a170903018900b00183747357f1mr10974663plg.28.1666232069847;
        Wed, 19 Oct 2022 19:14:29 -0700 (PDT)
Received: from localhost.localdomain (192-184-163-51.fiber.dynamic.sonic.net. [192.184.163.51])
        by smtp.gmail.com with ESMTPSA id n18-20020aa79852000000b005631af4ece2sm11942936pfq.182.2022.10.19.19.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 19:14:29 -0700 (PDT)
From:   Emily Peri <eperi1024@gmail.com>
To:     gregkh@linuxfoundation.org, outreachy@lists.linux.dev,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Emily Peri <eperi1024@gmail.com>
Subject: [PATCH 1/3] staging: rtl8723bs: fix white space warnings
Date:   Wed, 19 Oct 2022 19:10:51 -0700
Message-Id: <45558673b486808e7978e2e4838c6ce5a2485b8b.1666230736.git.eperi1024@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1666230736.git.eperi1024@gmail.com>
References: <cover.1666230736.git.eperi1024@gmail.com>
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

Fix the following checkpatch warnings in rtw_ioctl_set:
1) Add missing blankline after declaration
2) Replace spaces used for indent with tab
3) Remove space before tab

Signed-off-by: Emily Peri <eperi1024@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ioctl_set.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
index 8c11daff2d59..354e61a8f2bd 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
@@ -78,6 +78,7 @@ u8 rtw_do_join(struct adapter *padapter)
 		goto exit;
 	} else {
 		int select_ret;
+
 		spin_unlock_bh(&(pmlmepriv->scanned_queue.lock));
 		select_ret = rtw_select_and_join_from_scanned_queue(pmlmepriv);
 		if (select_ret == _SUCCESS) {
@@ -311,7 +312,7 @@ u8 rtw_set_802_11_infrastructure_mode(struct adapter *padapter,
 		if ((*pold_state == Ndis802_11Infrastructure) || (*pold_state == Ndis802_11IBSS)) {
 			if (check_fwstate(pmlmepriv, _FW_LINKED) == true)
 				rtw_indicate_disconnect(padapter); /* will clr Linked_state; before this function, we must have checked whether issue dis-assoc_cmd or not */
-	       }
+		}
 
 		*pold_state = networktype;
 
@@ -367,7 +368,7 @@ u8 rtw_set_802_11_disassociate(struct adapter *padapter)
 
 u8 rtw_set_802_11_bssid_list_scan(struct adapter *padapter, struct ndis_802_11_ssid *pssid, int ssid_max_num)
 {
-	struct	mlme_priv 	*pmlmepriv = &padapter->mlmepriv;
+	struct	mlme_priv	*pmlmepriv = &padapter->mlmepriv;
 	u8 res = true;
 
 	if (!padapter) {
-- 
2.34.1

