Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA43D690DE9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 17:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbjBIQGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 11:06:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjBIQGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 11:06:06 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8489658D6
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 08:05:42 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id f16-20020a17090a9b1000b0023058bbd7b2so2846572pjp.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 08:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6BmjgGEoooZ2YK4kDjyIPjYDxMBQyuc/WtwM+k0Dkgc=;
        b=ZErypnSTCqjfpg562zV9N4WkgiIRm6RdKydbDud9ixq2WXG423b5OMxYXgLQGe1rfT
         hAZ/FFrTdlAAuWKxBHvaOuagbhjvvxq2e3Q9xpLvpwzGJnCwwMgDiXUhX5l1QSgoYs1a
         ic1OvgC+vjW6E5KIhkFKSP7yBtjerKa+xMr6gSDflOLptOdzxPdYePeWA7UKdJMs+tR+
         eARSFj4H7qwEF8BXP+pwLwlpYcuJE4f4xF5GbaSOTWN9vp1GwPSLS//siL429Slv2CSi
         6Xzi1QI7NQt+QUOgyUqNFZICq8SlqbKzGOGIigwqlyheRc4cS3QGZ/+7Vre+/M+S7npS
         H0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6BmjgGEoooZ2YK4kDjyIPjYDxMBQyuc/WtwM+k0Dkgc=;
        b=lIT9nCEdo5+cpEb1usPYF0ISgjTA/tIJlwFXkRvepqu9V2TW8oS+J/gQHYICMhsNG7
         n1SC87HHx7JLAeS1CDZPjwX/XkdAfawAa2Gx2MCwMZ7uvEhyZX369bNKhREec1Y+Slcd
         zTIp3sEXIb4OUs4VfVZH3BlSiDlJSzOZ4TsYfPZTTDNKkRLI3ErFS327bAsA5HQ4e34n
         /sUNSIy4ePn+nHhdUAEwyGlzMgfrKoz2p626zqzCaW/6AFOMjMj+ly4HCKszHcEQFpuL
         2izXU4XNNhYV6Bslv+dRL9ygUFjcEk0MxKEYRbSxsemWAwD59iJqe14YiEvaFJrlXDq/
         Ow3g==
X-Gm-Message-State: AO0yUKWBm6Hq0YxQXaLDwO5q4njoKe/cfxKztRJHAD5xee6zBcTyWaG1
        hPYuuy9waGswlMa0DUGFvik=
X-Google-Smtp-Source: AK7set8T55wSl84Wj2mO6djoHWIIYf2fc0VNWHeCZ+9XJsmbQFrDh/2KFSaiqQahdbLxOw1oYEc7/Q==
X-Received: by 2002:a17:90a:5e4d:b0:22b:eb46:7d2 with SMTP id u13-20020a17090a5e4d00b0022beb4607d2mr12789454pji.47.1675958742422;
        Thu, 09 Feb 2023 08:05:42 -0800 (PST)
Received: from f37.eng.vmware.com ([66.170.99.1])
        by smtp.googlemail.com with ESMTPSA id p22-20020a17090a0e5600b001fde655225fsm7080135pja.2.2023.02.09.08.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 08:05:42 -0800 (PST)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
X-Google-Original-From: Shreenidhi Shedi <sshedi@vmware.com>
To:     dhowells@redhat.com, dwmw2@infradead.org
Cc:     linux-kernel@vger.kernel.org, Shreenidhi Shedi <sshedi@vmware.com>
Subject: [PATCH 2/4] sign-file: add license identifier
Date:   Thu,  9 Feb 2023 21:35:21 +0530
Message-Id: <20230209160523.858502-2-sshedi@vmware.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230209160523.858502-1-sshedi@vmware.com>
References: <20230209160523.858502-1-sshedi@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Signed-off-by: Shreenidhi Shedi <sshedi@vmware.com>
---
 sign-file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sign-file.c b/sign-file.c
index 76fee75..b2619db 100644
--- a/sign-file.c
+++ b/sign-file.c
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
 /* Sign a module file using the given key.
  *
  * Copyright © 2014-2016 Red Hat, Inc. All Rights Reserved.
-- 
2.39.0

