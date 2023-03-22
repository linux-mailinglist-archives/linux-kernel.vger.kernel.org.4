Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A356C5949
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 23:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjCVWHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 18:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjCVWHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 18:07:39 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7539E1A642
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 15:07:38 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id r11so78943121edd.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 15:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=seecs.edu.pk; s=google; t=1679522857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bNg7iZ+PuRMN0DqLdZrW00PMhOD0f4GRznXTT5Ec9ug=;
        b=Tu0kJyknJ1v6iH//+q5ZfDMvt0rY1p/4T/YYsEa/38n9mUAQ+R51ip28tUYR6N8OtW
         ZSV1sDRWvKVVPPGh6n3KkRyhLonpqmarMlDm3mNzO0gM1d5SU1Sevp48Yes1YW1ZlHrv
         fLgiz9w+NNBQJ5wx7ykUxmSJfRYuhC2raDpUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679522857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bNg7iZ+PuRMN0DqLdZrW00PMhOD0f4GRznXTT5Ec9ug=;
        b=0hyyaqFDTncPj7Hh9RM3H4H+YJBms2WMLmswQis5rXN6UKuSojHUiCHK8XseYLMusK
         VCc9F9yDEWucNAZuR0vALnXxFaEykOBFtm6Y0mngz6cEGviM9PbEmk1ZcupuuSQH0IjX
         9L8a2aCPS+ESx2qRcnROF1fnAQ8I4KDI689W7zhU7TCoa5stByEbU+R5wWkEFluvtBOW
         jV4nrffGuXHHaei9qhMVqc0VN+MrIgHJ7c0n0yb32L9qPwS3V88eiiZFKkRzdtG2JvNg
         VlWobBFAAb8r0yFCdEldEQMCUwRxdPD5WkAhM6sih3t0VNM0tbjYuJC2ha8ODC9GZ1Yv
         /zdQ==
X-Gm-Message-State: AO0yUKUYWfCaD4T8iQw2rcvYJrbDDLKk/V6VjnD5Pa/VY/joVcB65vFl
        yFfEZ6DJbDzrrWEwNFoBSbs8QougOenDo7ZxhQE=
X-Google-Smtp-Source: AK7set/Go4nTDvGsSsr8EOi4LAu7QSXAanN9vrFV1yKOh/zWi4mwbDzpIza4iTG9e7p13fUM7x2A8w==
X-Received: by 2002:a17:906:9493:b0:870:b950:18d4 with SMTP id t19-20020a170906949300b00870b95018d4mr9240963ejx.5.1679522856995;
        Wed, 22 Mar 2023 15:07:36 -0700 (PDT)
Received: from khadija-virtual-machine.localdomain ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id v19-20020a17090651d300b0092b86d41dbasm7787935ejk.114.2023.03.22.15.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 15:07:36 -0700 (PDT)
From:   Khadija Kamran <kkamran.bese16seecs@seecs.edu.pk>
X-Google-Original-From: Khadija Kamran <kamrankhadijadj@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Khadija Kamran <kamrankhadijadj@gmail.com>
Subject: [PATCH 2/4] staging: rtl8192e: add blank lines after declarations
Date:   Thu, 23 Mar 2023 03:07:02 +0500
Message-Id: <eae4647540b26afa88ee99209e39f5b461e7132b.1679521517.git.kamrankhadijadj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1679521517.git.kamrankhadijadj@gmail.com>
References: <cover.1679521517.git.kamrankhadijadj@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
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

