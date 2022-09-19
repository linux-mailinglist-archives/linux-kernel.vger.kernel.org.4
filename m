Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38725BCDC6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 15:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbiISN7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 09:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbiISN6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 09:58:53 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17212A736
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 06:58:51 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id y2so18004684qkl.11
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 06:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=gHhzCqcr4uMccNSgvISt+fTNHdK2v4nDlLBU1IjHghk=;
        b=a/ucEdaAbOnjhtwf8vzz+hi2pLgvu/UPwGk0HDn2GT1wp9dtDGzis/xwfrkSOXjS7S
         lefOo0d3wsdzUSYKtUmh7C7KjPDMXowPlGzjN7qfag5VgLv5rdDVQ6QL1RSF7GQ51J9m
         AvHfcF6jfK0IWpOs/KMo9Nl+ZAtS+PS1A7YHp4ytMg64v1zlOiIbuPdaONHx5IWY/vAh
         OSi1ELC8ZD/QnWVMzLglXI9EaWGc6su8ONg+BUfaEbm9vAUxm0azCet0lcvVVlbgjSxF
         Qy7a1FndCKVDzq9v/L0oftPGjaGJHAfAWV/7hpWmWMq6hWpgZbU5K4xcHrtb6ujIEEnp
         iP2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=gHhzCqcr4uMccNSgvISt+fTNHdK2v4nDlLBU1IjHghk=;
        b=Y8sSZJ5+kdTX3Psm0akS1p4WMVFPYPQWJRzAJPSjyKJ8LtigVQyvJDnetJXsdygDaW
         AGygf22MqDdQRQhF/7hGZ4UAqHFt9PsOj8BACcIPg4J5Hcxt0rb0UamiYpC8l0vSoPMH
         SgZJ3xtd7AHdds6YQkwM4pHfgSZTH214+Uy7f3RpoYKddEFKGkn6PFC3dL2SLUwzA5zi
         HgC6FqBkKtyOxhvIvtaP5+xPrjCiZxEYPRxmdFTXEzqBOMpQwnkH8DbGkxF12z1v2eZn
         7sPyOkP2sJWXkYC2Hk/lHHsD+3n7/xnpaQUstTn1ugmqVLmDkQ3xWmvry6XxvRB3Oj61
         R7eg==
X-Gm-Message-State: ACrzQf3sbaJuS5K/fCikbcWuoFqBi6wzVc8/XWTV7T6R5OEM6X6JRjXQ
        MZYPXeZVVDixJY8+OwmIHYo=
X-Google-Smtp-Source: AMsMyM4OBiNLKEn12KMlz6pMi0ikG17VPuRSKTzFjrlIfNsFyrzI29OeNDNNVWWaDH0oKwZWAzH3sQ==
X-Received: by 2002:a05:620a:4382:b0:6ce:2761:28d0 with SMTP id a2-20020a05620a438200b006ce276128d0mr12535723qkp.329.1663595930797;
        Mon, 19 Sep 2022 06:58:50 -0700 (PDT)
Received: from localhost.localdomain ([142.126.147.56])
        by smtp.gmail.com with ESMTPSA id l19-20020a05620a28d300b006b60d5a7205sm13725882qkp.51.2022.09.19.06.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 06:58:50 -0700 (PDT)
From:   Aruna Hewapathirane <aruna.hewapathirane@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     f3sch.git@outlook.com, guozihua@huawei.com,
        linux-staging@lists.linux.dev, aruna.hewapathirane@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] staging: rtl8192e: removes blank line
Date:   Mon, 19 Sep 2022 09:58:12 -0400
Message-Id: <20220919135812.8307-1-aruna.hewapathirane@gmail.com>
X-Mailer: git-send-email 2.30.2
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

This patch fixes a checkpatch CHECK issue
CHECK: Please don't use multiple blank lines

Signed-off-by: Aruna Hewapathirane <aruna.hewapathirane@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_tx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index d5275319a486..f651947f6b44 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -920,7 +920,6 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 					tcb_desc->bTxDisableRateFallBack = 1;
 				}
 
-
 				tcb_desc->RATRIndex = 7;
 				tcb_desc->bTxUseDriverAssingedRate = 1;
 				tcb_desc->bdhcp = 1;
-- 
2.30.2

