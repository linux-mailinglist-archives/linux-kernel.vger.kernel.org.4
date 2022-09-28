Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5435EE307
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 19:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234617AbiI1RXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 13:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234185AbiI1RX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 13:23:28 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24267C1E8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 10:23:27 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id sd10so28619719ejc.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 10:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=j1KSyzaOPwalWf0pjnfJfXhH4MRcgiZbBjdZrYO0OQk=;
        b=Q7jDtpRe5K8YAjFqF4bQRDvmoFtZVKows8Ctd0gk4DNtFLOvt/NfdMOjgSAJwaERsG
         a36RbywejyXu0Q3iabHXMXwunSrULrBSrEzXZmRma0Y0/9dGbErngxzCm1BByz7XdP8e
         0hQK+k/TB9BZfB72vQ9QiicJuFkSJ6Bgbfx+xEwBwlFRCk/xpYorF3lE7yk12bu0Rbjf
         p/fu421y8+GmU8gKV5gFSRIylrfvm1jccDN6vO5GD8xCWO0l4UjaDhUgr6y/cl0xEheF
         2GY1oiDVF6QirQHO9DrEZ3B0xC3ygjyXS9jxk2gpizu76K00BPZKrLC01/nkvHtejppU
         sEPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=j1KSyzaOPwalWf0pjnfJfXhH4MRcgiZbBjdZrYO0OQk=;
        b=E7KcHGYZQw4HPpYj5mYWfMFew5m2/JGVsqwlMt00Y4W4K3VzNwlaFUTpfiMCpOAJLd
         sdFTTZ841wOJgykfy1pYYFrSyFyUiAKCT83gVlVIm2Zgj/xOzACL3bzdZZ2gtEwtyDo0
         iiL8Iqf6OVYdlWf3OSU27NemBldvIRCl6mvaKx4wnQCRa6NWJ9pb+YIiVOWgTb5GdjSg
         6MB6AqXr7NnBisEPWxS2GYMSI6AIUS96crEKNjuyLwRVFin3bVE21nCciFwlrc8GkJTl
         pvzb/l8AqM5OuyXIW8CdbNLKVaqcACQPpMnMxKRuhjVETKFs4FlRzCrP+3PvdWxuo0tX
         HYFA==
X-Gm-Message-State: ACrzQf35QXPH1pQ+SiwKSfcZzU/M5vOpFoTb7FvpD/FKtZzYqlY5kHBb
        t4rwmYHFlsbDq0ifqmMLGI+VSZlEkic=
X-Google-Smtp-Source: AMsMyM6eFw13xXqIKeSV3vLMuLiiD5CfNcuLpmycgL+iEvvH4STqJ+ZsiUXCl3mXQ7m+Mfvk1nnzeA==
X-Received: by 2002:a17:906:fe49:b0:73d:70c5:1a52 with SMTP id wz9-20020a170906fe4900b0073d70c51a52mr29369840ejb.469.1664385806018;
        Wed, 28 Sep 2022 10:23:26 -0700 (PDT)
Received: from localhost.localdomain (ip-217-105-46-158.ip.prioritytelecom.net. [217.105.46.158])
        by smtp.gmail.com with ESMTPSA id lb6-20020a170907784600b007306a4ecc9dsm2725063ejc.18.2022.09.28.10.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 10:23:25 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     forest@alittletooquiet.net, gregkh@linuxfoundation.org,
        dan.carpenter@oracle.com
Cc:     namcaov@gmail.com, philipp.g.hortmann@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [RFC PATCH v2 3/4] staging: vt6655: remove redundant assignment
Date:   Wed, 28 Sep 2022 19:21:49 +0200
Message-Id: <4ccc5c55d136cb0749cf773e673fa903eebf473c.1664384503.git.namcaov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1664384503.git.namcaov@gmail.com>
References: <cover.1664384503.git.namcaov@gmail.com>
MIME-Version: 1.0
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

In function device_rx_srv, the assignment rd->rd0.owner = OWNED_BY_NIC
is redundant because this is already done in device_alloc_rx_buf() which
is called right above. Remove it.

Signed-off-by: Nam Cao <namcaov@gmail.com>
---
 drivers/staging/vt6655/device_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 21d10d9fde47..c8cae6df7f51 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -839,7 +839,6 @@ static int device_rx_srv(struct vnt_private *priv, unsigned int idx)
 				"can not allocate rx buf\n");
 			break;
 		}
-		rd->rd0.owner = OWNED_BY_NIC;
 	}
 
 	priv->pCurrRD[idx] = rd;
-- 
2.25.1

