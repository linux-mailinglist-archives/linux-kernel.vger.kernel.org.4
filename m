Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015F568BA34
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 11:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjBFKav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 05:30:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbjBFK3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 05:29:45 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF79227BE
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 02:28:57 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id n13so8282214wmr.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 02:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yPRxk+XR4q6rcvb7Uhvae10cdYLboc87AwhU8wC3gnk=;
        b=HnUjiCp6NRaOTc+1by9scrNsDK2FQexgkD03EklB/VtqP5Ttvw4az/7RBSeW5CPMvX
         1KrisJ7GAlfzAR+fQeyev1N7ftc8gX0QlTTeWeIFdqcHuL/GtlxxFovZKdffT7vptTfD
         f4UGHzL472DI/kyCxfpUxCq8wQmqfNQzfBbg4DnMRPaHl5ny/WBkr3Y3TYQiTldZikF6
         hCZx5pduLhbLmpSdQO7FK17YVC/yl/4VIHbAuKdMUroBBS0bZQJ2n9IkZHWHmxkNDdqk
         2L2mc9Akw0EZl852qoH1yhOVG2JKvqee43c73FJV443AeqkmGoAA/sPDscqD4yC/arjg
         ZZQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yPRxk+XR4q6rcvb7Uhvae10cdYLboc87AwhU8wC3gnk=;
        b=5EJpegTuG/q90c4QkoLRBLoEAl5AUdu4hJ7J8INwdJUC+F8EUvKtmfqO2xoQvN5mp7
         sYovihAPqtrxJqlnmCdPYwrAeHPXZ4Gnarg7UJEZ4VAj4oqZtlANbnNwiR10rEyoyOeo
         wmb/ELJHBnuEQx6eOdaoDvd1FjfFV6ScoXpQFwesJdEtZB9hc6ZvsSA3ollsauWVpWPx
         pMSBGokROHm67G0Fbx5p7pID8czgWeOL2tPbdKH5QezcdKSu/gPuG4a4ERMkf+nkI60m
         jpKGICMGhjWDlYmrkfSogV6CeVwsiKtq9mMu7KTF72xWqUTayIzRIk8nRwVwL3erowNF
         XWgA==
X-Gm-Message-State: AO0yUKVpJedDQmX0yZ43RzYeCydUUcLvCd94di0LGkZ0Q1L/u608uVbQ
        5saeAVPfA+mPhoSIKQxi0LCzxH/Ks37Sgc2l
X-Google-Smtp-Source: AK7set+ZW2SYoWw7GNnrksTSc2pGks9kxMJ+1IQLwQKhA35iWn7TgzYD5DE5/P6ZVvGzFthKTKd3IQ==
X-Received: by 2002:a05:600c:3591:b0:3dc:5362:134a with SMTP id p17-20020a05600c359100b003dc5362134amr18563123wmq.9.1675679335218;
        Mon, 06 Feb 2023 02:28:55 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id g10-20020a05600c310a00b003de77597f16sm11002446wmo.21.2023.02.06.02.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 02:28:54 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andrey Vostrikov <andrey.vostrikov@cogentembedded.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [RESEND PATCH 33/37] nvmem: rave-sp-eeprm: fix kernel-doc bad line warning
Date:   Mon,  6 Feb 2023 10:27:55 +0000
Message-Id: <20230206102759.669838-34-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230206102759.669838-1-srinivas.kandagatla@linaro.org>
References: <20230206102759.669838-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Convert an empty line to " *" to avoid a kernel-doc warning:

drivers/nvmem/rave-sp-eeprom.c:48: warning: bad line:

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Andrey Vostrikov <andrey.vostrikov@cogentembedded.com>
Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/rave-sp-eeprom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/rave-sp-eeprom.c b/drivers/nvmem/rave-sp-eeprom.c
index 66699d44f73d..c456011b75e8 100644
--- a/drivers/nvmem/rave-sp-eeprom.c
+++ b/drivers/nvmem/rave-sp-eeprom.c
@@ -45,7 +45,7 @@ enum rave_sp_eeprom_header_size {
  * @type:	Access type (see enum rave_sp_eeprom_access_type)
  * @success:	Success flag (Success = 1, Failure = 0)
  * @data:	Read data
-
+ *
  * Note this structure corresponds to RSP_*_EEPROM payload from RAVE
  * SP ICD
  */
-- 
2.25.1

