Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DEFD659DE8
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 00:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235487AbiL3XPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 18:15:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiL3XO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 18:14:56 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A79FDE81;
        Fri, 30 Dec 2022 15:14:55 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id ja17so16060875wmb.3;
        Fri, 30 Dec 2022 15:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lk6w/dQjZUnYKE5Q3JHgYqAZAoCgT7dU2bsxNcBc+uw=;
        b=WxA+HcdaZEzK4JWMlzrKByVBwloSBQ4d402kcMDlw5Hq6HagKbayu5W4MrDLSFENNQ
         Qowus9h3Ny3R+1gniOvdEsOdjm3i9sAO2nvV+L7bKpMLUjMsY4CidfXhahR9czVjzrjl
         1ZpR+n78MqWawDXDnBN0DMKYrpWjriDxGmjPv+e9zDyoP3oHleBMREWvo6N/mof7wgbw
         QITaXu+rTIoY4I6VRipHipMZgsfKmvGbn3zDtDuNp7bl4IN5egDla4uOw/kpgxgTuPas
         euQZzxMySnf7cazDn6/NM/731giIICXTeIAiyXJ23Q0UPBqQNeINTV0DHx1X5vb/q9yG
         BJhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lk6w/dQjZUnYKE5Q3JHgYqAZAoCgT7dU2bsxNcBc+uw=;
        b=oWUAAbv4qEuCsQ7H1VydKhiNRmomB81BhP6aCmH6As3URwzoiVusD6+vCdAVm3R1sA
         bNoQFmB0LqNrBvkP1N8yYIW4PMUEcKdCex/ehBayYKm/cOzKvcZu1ttqL448bEpTqrFa
         YmVHiMsgzAWlNJ094AF63hsF9LFB0KjdqXrt2mpdYWGc5zyMGb2IgSA25ctve/2xJ+vU
         ssmoCDQ44dNhR1oTKUFwsms68CIpwfi9tXvA59YP31LLUTAShChEfs8Jupf6VlQ7XJnz
         bFT0S7AQpjg82cA4PY8KZ7UwCAFmNZaTTJ68JX7uZdrSUTB6tE/evn4TYSIxp8sLuP9J
         TG5g==
X-Gm-Message-State: AFqh2krHBz3KgYKeDNF0CrVU00UgS4nQnhknGiYA9x46aQiwa5ZH9gjp
        WJ31eHh2qbSwPKr8nolJK8eDGaWd3xM=
X-Google-Smtp-Source: AMrXdXvozabtH+hwGlMJ481uiCYAIaPqDIJRQ+OdqGE7yXSLtmnx2I2T2IlqOBqB9g7uApOlepmx8g==
X-Received: by 2002:a05:600c:6016:b0:3d3:3c93:af5e with SMTP id az22-20020a05600c601600b003d33c93af5emr23727755wmb.35.1672442094088;
        Fri, 30 Dec 2022 15:14:54 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id p34-20020a05600c1da200b003d99fad7511sm5304770wms.22.2022.12.30.15.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 15:14:53 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Jan Kara <jack@suse.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] udf: Fix spelling mistake "lenght" -> "length"
Date:   Fri, 30 Dec 2022 23:14:52 +0000
Message-Id: <20221230231452.5821-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a spelling mistake in a udf_err message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/udf/directory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/udf/directory.c b/fs/udf/directory.c
index a4c91905b033..18a1514871fe 100644
--- a/fs/udf/directory.c
+++ b/fs/udf/directory.c
@@ -34,7 +34,7 @@ static int udf_verify_fi(struct udf_fileident_iter *iter)
 	len = udf_dir_entry_len(&iter->fi);
 	if (le16_to_cpu(iter->fi.lengthOfImpUse) & 3) {
 		udf_err(iter->dir->i_sb,
-			"directory (ino %lu) has entry at pos %llu with unaligned lenght of impUse field\n",
+			"directory (ino %lu) has entry at pos %llu with unaligned length of impUse field\n",
 			iter->dir->i_ino, (unsigned long long)iter->pos);
 		return -EFSCORRUPTED;
 	}
-- 
2.30.2

