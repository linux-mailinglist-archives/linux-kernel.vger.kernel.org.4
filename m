Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB7D6B5B94
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 13:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjCKMX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 07:23:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbjCKMXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 07:23:52 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1137CF0FF2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 04:23:52 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id ix20so1776096plb.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 04:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678537431;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RHyWlNYOWTJpaRchXuBuoW9+Bl6vt/PZv6RitZv+maE=;
        b=VeTCeUnJguiKcfFaFYvN1RBFf7V7f2qcW7ytfy1bop6uCZfFI1HU9Lwc4rLPjrvWpv
         bszpcBpkv0AmPl8cSEDp/PrXMaal1u5jCOpIxvtKLORdPj8tskLAHWzLL4U18f+wUjkG
         crMtAqLOcGwzfOEtkTwdAxoBt/25CfiLGKwt1+t9+fjj3iyYzm9eyubGiErppTOWqX8C
         VqnqzLLa8ppdMf+XWJA0NGdD2OsSvcP6CP6xHTPLwwVFDptFkviCi5zLKQ385ecsSbnY
         upNfdanXpMnEHiEEX+rRGgYT99mP4IztlyewKLQIZRUmniPF70riAs/SJGprx4GF5/xh
         Pu5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678537431;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RHyWlNYOWTJpaRchXuBuoW9+Bl6vt/PZv6RitZv+maE=;
        b=1T5Yrex2fu4AVhKj7jQa9y+wfeSa/o0wtOaJN3O72huzhkqh/56gQ/cIXymUTkVCUM
         ujs/FNvFob39O+bYOpnulnV8NOIUtG36k4OJMFpdjt78NoNWv1ePvsYDSkt3syPyjSwG
         uxCEpVrhK1Rn5lMCy1qg7a39PMAEK2ATNeLKNcFU8S1ciBEkX0qB6/F0yWbRDZllDMxT
         xWJrCM2aaAzQjbxOS3BKSeJXHkyyPfTSyUU/NY0Avqwmo0NpUXsAFNZyGkHvWOamzpd2
         ihaADelOM5BSLpri4gCE3wqIY2EnOjCZsPGH019ulEt3fk9YRYeSbq6BDMNiwgz1Al21
         joKA==
X-Gm-Message-State: AO0yUKUyIvlBqPapMi26rqM7nlgaiVlQHG8GVovT6NGroJIW6008T9fN
        iNI+9IsH8Bzr1Sugw2F7QBc=
X-Google-Smtp-Source: AK7set/h/eNxdE1SsGotLvCSm2/foTZmvHZT9k8qP5rd04raMPv685hL2Itj7MMA/JruQH7o6CnSHg==
X-Received: by 2002:a05:6a20:8427:b0:cc:70df:ae20 with SMTP id c39-20020a056a20842700b000cc70dfae20mr5536607pzd.0.1678537431501;
        Sat, 11 Mar 2023 04:23:51 -0800 (PST)
Received: from ubuntu ([117.199.152.23])
        by smtp.gmail.com with ESMTPSA id c15-20020a62e80f000000b005abc0d426c4sm1391911pfi.54.2023.03.11.04.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 04:23:51 -0800 (PST)
Date:   Sat, 11 Mar 2023 04:23:46 -0800
From:   Sumitra Sharma <sumitraartsy@gmail.com>
To:     outreachy@lists.linux.dev, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     outreachy@lists.linux.dev
Subject: [PATCH] Staging: pi433: Change bit_rate type from u16 to u32
Message-ID: <20230311122346.GA21752@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change bit_rate type from u16 to u32 inside struct pi433_tx_cfg to
support bit rates up to 300kbps as per the spec.

Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>
---
 drivers/staging/pi433/pi433_if.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/pi433/pi433_if.h b/drivers/staging/pi433/pi433_if.h
index 25ee0b77a32c..1f8ffaf02d99 100644
--- a/drivers/staging/pi433/pi433_if.h
+++ b/drivers/staging/pi433/pi433_if.h
@@ -51,7 +51,7 @@ enum option_on_off {
 #define PI433_TX_CFG_IOCTL_NR	0
 struct pi433_tx_cfg {
 	__u32			frequency;
-	__u16			bit_rate;
+	__u32			bit_rate;
 	__u32			dev_frequency;
 	enum modulation		modulation;
 	enum mod_shaping	mod_shaping;
-- 
2.25.1

