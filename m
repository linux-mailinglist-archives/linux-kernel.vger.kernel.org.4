Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1ED607F52
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 21:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbiJUT4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 15:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiJUT43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 15:56:29 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8266B25C2E8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 12:56:28 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id y1so3568314pfr.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 12:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wbRVFQiQ0KizwuJ0kgho517m1and4hrijf2KVLnECg4=;
        b=gy2xJoXvDq0x7SptUxENjlKj97jrolncTGtLTh7V/00DYvmiuytlbGwQxCUKSV4v2E
         PuxoEjvH0HH6RM1PgDxcFooeYDBgP5wMmYPSpM77Hop593hR/I7DHcomUa7Z/zlmI1ZQ
         pQWVIhP3I0RPHFaKsrXxQANRHAKqgIwBJ7VXa2KEfgHGIYNOe+vbrOg0keOhPzMz49hz
         vPjValM2YGnqZQk+AbQ0oCuX630kiAsGvShblGu25U1kD/ob0yt997iWmNkbSytHynVG
         kdWZRa0j1BAxowxR1uUb//bZa/bYijYDKjOwdZ40fVbv3x8e0KPopKAGHiP8wSb5FsJm
         onGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wbRVFQiQ0KizwuJ0kgho517m1and4hrijf2KVLnECg4=;
        b=y+Odd7qyYnIi+QWHq2jA5AsVMKNOmH4PfayrppoVmoVI6IZY2lHPD9+muXo9Ve2Hsx
         V9Njr2yEURcpFFD7zvoU9fcEaN7PE4CWs7+ZdDh/PmvHIMc1v4A2vQVSUpaLvIIZPef0
         H7J07HDMCW2XABejrJjQ4aa3Vytt353MSeQa4+7W1/ZMES1Dec/uJIm4kPSrVPFJez12
         HiHQoVAoL8cJQPlg8ViFkpQ0lf/3oaaV+qINXO1ppozbhVscyK+it1vxnVGcHS4KD8oQ
         Bars8AisS+/co6GT8Lcl2m55x+mhcUMXv08drwsdn8r6nnLiibgxnMKBJ8FN+dpniTN5
         IuIg==
X-Gm-Message-State: ACrzQf1YsUo7+fDd+A0kmy34oRB+q9T53JtrfUC5MyGk8Li+T+Oc2IP+
        DvGHWHEGA+pmxlRzL8EvECI=
X-Google-Smtp-Source: AMsMyM4AUWIv6wLc4JZEAhklPZ9RVIHG4XLhUfzCZRNvlhuc5n8hl/ECfbreu7MvQS7yL+IELXoz0g==
X-Received: by 2002:a05:6a00:1a47:b0:52e:6a8c:5430 with SMTP id h7-20020a056a001a4700b0052e6a8c5430mr20392527pfv.48.1666382187830;
        Fri, 21 Oct 2022 12:56:27 -0700 (PDT)
Received: from localhost.localdomain (192-184-163-51.fiber.dynamic.sonic.net. [192.184.163.51])
        by smtp.gmail.com with ESMTPSA id g13-20020aa79dcd000000b005668b26ade0sm15179345pfq.136.2022.10.21.12.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 12:56:27 -0700 (PDT)
From:   Emily Peri <eperi1024@gmail.com>
To:     gregkh@linuxfoundation.org, outreachy@lists.linux.dev,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Emily Peri <eperi1024@gmail.com>
Subject: [PATCH v2 2/3] staging: rtl8723bs: add newline after variable declaration
Date:   Fri, 21 Oct 2022 12:54:56 -0700
Message-Id: <76e1bfd210d79e6d3f7cc09233621c8b741b2370.1666380274.git.eperi1024@gmail.com>
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

Fix checkpatch style warning by adding newline after variable
declaration in rtw_ioctl_set

Signed-off-by: Emily Peri <eperi1024@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ioctl_set.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
index ede7d2930844..47323160e72d 100644
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
-- 
2.34.1

