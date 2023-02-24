Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7756A1C38
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 13:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjBXMed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 07:34:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjBXMeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 07:34:31 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A55410A96
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 04:34:30 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id y19so7515871pgk.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 04:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zEGhtws+wiErVlZ42D9/AJOQAx1qZAqoPjXvwOSW4/Y=;
        b=Luaf/TY2AqGgB0hkPGQ+LksJldhRPkMqBb4ra3M5uPh482D5dCWjp2wvQj+3mmf8t/
         X2WA9NiEHb2iqZwdly4569+fDq7Hi0rkAbZVvlVwgZMqRInv6IVPZH4caEEHFdTE7ikU
         uhlFGI5xi6P4yFE2rQ40ONh+kB6ndNlGtPcAPkh6nOKoK90KKMc+ZxYZneW2qZVqlcWd
         7n4JUMOsVevmFGWjsVrWTBI7xLY3JeObOD6vhJVoyNYoPdKWIVYq6tXxebmUxTWWIuQ2
         b7CS39BWFDzjcF1f7/u8phe/mFv/91h8oIoyGNwS5sifVSNtcBhXli3suvE5ydiEBd9k
         yUAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zEGhtws+wiErVlZ42D9/AJOQAx1qZAqoPjXvwOSW4/Y=;
        b=Oc58zq81FJvT0cM5zWiMZ/5ietdaqv3iqNvmXN2MeHYxpUtZTMalTUtgSQZWcgCA69
         MCVwCXuz9yO2f7FEDUoioHXayCIToX5vmdtDiYWJXU7SQoWutdEHpUABVliH1b0xfWir
         TcJsqMVKx35zk+309CA/fEulbvay2ow3rYtahAcNNfKnlP5h/e55QzC0pXaUhh2Z2gip
         oIukzCcrPcjcJbc5y1tBMCx2z1yjWRJROFp8iy2Fy/n/qEWPjJb5p77F0sdcgfgv/LBr
         EPv6aL4W2BODHeAic9SBFWa2Av3IR6m3YZhHjNPj/w9bVhAfbjE33bgwBUsjKOFh/7vb
         Vvpw==
X-Gm-Message-State: AO0yUKWzQe2g0Kq8rvQa8qaMDnHtdS13XVjH8Tych+4uAYpXuKoFO5E2
        SudJZD6IeQMORKXmkVe3UAk=
X-Google-Smtp-Source: AK7set+gXnlTz88F5C7LHfoQ4IzUJlqJp62R4Zz5yYBd6fcXYpcsOMNQ0lXzhyMpmivpyYCZ3CxCDQ==
X-Received: by 2002:a62:601:0:b0:5a8:c2bb:f0c4 with SMTP id 1-20020a620601000000b005a8c2bbf0c4mr11619701pfg.13.1677242069584;
        Fri, 24 Feb 2023 04:34:29 -0800 (PST)
Received: from XHD-CHAVAN-L1.amd.com ([103.115.201.82])
        by smtp.gmail.com with ESMTPSA id e24-20020a62aa18000000b005d61829db4fsm4866032pff.168.2023.02.24.04.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 04:34:28 -0800 (PST)
From:   Rohit Chavan <roheetchavan@gmail.com>
To:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Cc:     Rohit Chavan <roheetchavan@gmail.com>
Subject: [PATCH] staging: vme: remove blank line after return statement
Date:   Fri, 24 Feb 2023 18:04:01 +0530
Message-Id: <20230224123401.1365-1-roheetchavan@gmail.com>
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

This patch resolves a checkpatch issue by removing blank line,
after return statement at end of the function.

Signed-off-by: Rohit Chavan <roheetchavan@gmail.com>
---
 drivers/staging/vme_user/vme_fake.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/vme_user/vme_fake.c b/drivers/staging/vme_user/vme_fake.c
index f5d2c345978a..7c53a8a7b79b 100644
--- a/drivers/staging/vme_user/vme_fake.c
+++ b/drivers/staging/vme_user/vme_fake.c
@@ -329,7 +329,6 @@ static int fake_master_set(struct vme_master_resource *image, int enabled,
 err_dwidth:
 err_window:
 	return retval;
-
 }

 /*
@@ -638,7 +637,6 @@ static noinline_for_stack void fake_vmewrite8(struct fake_driver *bridge,
 	}

 	fake_lm_check(bridge, addr, aspace, cycle);
-
 }

 static noinline_for_stack void fake_vmewrite16(struct fake_driver *bridge,
@@ -669,7 +667,6 @@ static noinline_for_stack void fake_vmewrite16(struct fake_driver *bridge,
 	}

 	fake_lm_check(bridge, addr, aspace, cycle);
-
 }

 static noinline_for_stack void fake_vmewrite32(struct fake_driver *bridge,
@@ -700,7 +697,6 @@ static noinline_for_stack void fake_vmewrite32(struct fake_driver *bridge,
 	}

 	fake_lm_check(bridge, addr, aspace, cycle);
-
 }

 static ssize_t fake_master_write(struct vme_master_resource *image, void *buf,
@@ -1234,7 +1230,6 @@ static int __init fake_init(void)
 	kfree(fake_bridge);
 err_struct:
 	return retval;
-
 }

 static void __exit fake_exit(void)
--
2.30.2

