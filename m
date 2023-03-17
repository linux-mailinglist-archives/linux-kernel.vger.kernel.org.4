Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB8D6BF185
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 20:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjCQTNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 15:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjCQTNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 15:13:46 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BDFE1FFF
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 12:13:36 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id h8so24221577ede.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 12:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679080414;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kU/IS1dtYj57qCBoVq56ZCvXzu4g9U4ZWrc/U3hX9G0=;
        b=hzaM0uxjpk4JIjyY/zbeCSZcL4ShubyS/mTSxEoPcqjdlr6BXMkhdYF8e/4jpOZROk
         sTH7TJCnbsaDutp46WT4/qVwEP42qItLbZtAWQdsSctVM2XeFEII6rOxHh/4bfUdc2yf
         086Kmf4Ag9XKfCBRENmlk9VW8TiSnDZYi2hnmqq42FXXIFnxaLB4tqa3u9sE+h1l2Xfp
         m2fTEnjmQh71MLsPHHQ4zGf9J82gPGgfKyrIAggrn3rmvw7uEocCqx4eLakYuBWN0imG
         loUdJ0iI10L+9OLY4Bdd/RWCd5zQHRJ3Rg2Y9rjRuwC/x+ehH6RbOz15DBw2IjytdMGC
         bmbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679080414;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kU/IS1dtYj57qCBoVq56ZCvXzu4g9U4ZWrc/U3hX9G0=;
        b=vfZ/+Py+sbbLyyVkXAUx/F+ZOi2FBb2E2cK43BD8T56KfwL18FU5FvZh//8UDmdMCa
         6O3qVX2NDhvTxjPAhJwVDZk/aX8PKYCcd5/+WgcyI+0rZOSmBkEANN63CBYJA/ol+a1Y
         FpI2hXfcbxXteMgGO9g/F5/w4oq5HIcme6pyK7mnFeCJQ8QMsXW5E4mDi30g2yDOOiB3
         Hax8fX7tfy0PkuaEEF5BSKG6HKOL6hezmuiZV7RVowDoFPeOAFHmHbnpOS+g0OREcxEJ
         JtpLKtUqjJ1ZAGu+fMmKUu9NUr2woUkPISUfn95oJoWCuCQHWOO3tSvho8JFt/sXs/OB
         FOeA==
X-Gm-Message-State: AO0yUKXersWwNwswOUxqtt83+H7IzcsX2WVkHYAd7tRzSVFz68oIgY1L
        crXw8ebAvco38ONoLykEBES8g0EXw+Q=
X-Google-Smtp-Source: AK7set84gc3AqMh/LT9CCrWYUTjFK0pDiBcwpA1kGdOXEbjQlXNm8DWj8wQD2ttrwlTt9MQV2IkTvg==
X-Received: by 2002:a17:906:7394:b0:932:170:e07b with SMTP id f20-20020a170906739400b009320170e07bmr2773690ejl.7.1679080414616;
        Fri, 17 Mar 2023 12:13:34 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id i27-20020a170906251b00b0093128426980sm1294304ejb.48.2023.03.17.12.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 12:13:34 -0700 (PDT)
Date:   Fri, 17 Mar 2023 20:13:32 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] staging: rtl8192e: Remove unused macro
 queue_delayed_work_rsl and queu..
Message-ID: <4f08897d188c61fc2e611afbf9f2de2ba18cffef.1679077522.git.philipp.g.hortmann@gmail.com>
References: <cover.1679077522.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1679077522.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused macro queue_delayed_work_rsl and queue_work_rsl.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtllib.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index cb904fc4f574..8965bb605eaa 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -62,10 +62,8 @@
 #define IW_CUSTOM_MAX	256	/* In bytes */
 #endif
 
-#define queue_delayed_work_rsl(x, y, z) queue_delayed_work(x, y, z)
 #define INIT_DELAYED_WORK_RSL(x, y, z) INIT_DELAYED_WORK(x, y)
 
-#define queue_work_rsl(x, y) queue_work(x, y)
 #define INIT_WORK_RSL(x, y, z) INIT_WORK(x, y)
 
 #define container_of_work_rsl(x, y, z) container_of(x, y, z)
-- 
2.39.2

