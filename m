Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F096095D5
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 21:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbiJWTce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 15:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiJWTcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 15:32:32 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC0F1D306
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 12:32:31 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id c23so4645542qtw.8
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 12:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:subject:to:date:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HP6MRGchwFDAaW2YSoV/4jEvws0jwi3gehL8e+vPr2o=;
        b=HAMncO65QpvSxc1QP0PYQXT50CySTx/v78iFc4LCQCoGYP3tJ/YjYca47FlTClYeNX
         WWHKCBkGbt3zhRjd0FE6xr/qTMxt7CGW0BpW++EWlCTWxuJ2iYgKfuHQlo5b9Oo3wNMF
         03hbJX177xPx5oYyqRnrbQcvK0UVvIZZFYa6y13l+9x+9DSdyfFUFLouh4tgD0p88Q/E
         QmMptKv2t5A4sheL1t5O0Q3XoQJz4SUAvZHUxzOQOQXDU9idGHJiI6meCU0UzzqJ9FyW
         PR+ylMVAxAk6TrnwR/CDRFVh0ANzFytU4AT8v9WU48Nn6Q/gzD0btpBODDRTicdEgu1K
         iDzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:subject:to:date:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HP6MRGchwFDAaW2YSoV/4jEvws0jwi3gehL8e+vPr2o=;
        b=ToASWif0JM1+j9myx5DYpXfD+/yoRlgmuNCm3oX39JYZQcTjqfnOB/JOWCZuXEw974
         W757sCvKJ5IVp7DUs5+2eKQAI2N96h1tffqdsp5hjv3s2/eHY2MTPIFpngOa3JpcsOGv
         w/l+UDXqJ7oSF+Z73j2CrAhWdAVH8mqb20yWwk1QNUnYaVbkOFnnefs9BSVoD/R/cHgP
         aK2WNz6NONuWgZsIF3DyyEvBwkK8VAQ9Ur2Ds33mbs/MNkZtvWbUt406t0S1hARHjcpz
         rzRObRHNIcw4LpLuPbIyJquw8vpp60cgI7vggarIl8AbyxYyiGgrdYyz2yuhm0Gneztx
         f8xg==
X-Gm-Message-State: ACrzQf39vMVFVXaZ6Kd0CwbALvkNZN9e1KPjSM+Qj0EZ7PEazgRMlSKk
        +pYb/Q3RLzVWJAra8GLqlWQwxb4W2G0=
X-Google-Smtp-Source: AMsMyM48ITtGyXtD5RwHuXRp1lfPRFzaAtgXqq/ZOLIOKQXXiFN9y2y5v/Z0ZAqwuVEsWOPLZkYDeg==
X-Received: by 2002:ac8:5cc9:0:b0:399:98dc:2c6b with SMTP id s9-20020ac85cc9000000b0039998dc2c6bmr24909814qta.549.1666553550644;
        Sun, 23 Oct 2022 12:32:30 -0700 (PDT)
Received: from komputer (pool-100-36-177-89.washdc.fios.verizon.net. [100.36.177.89])
        by smtp.gmail.com with ESMTPSA id cf17-20020a05622a401100b0039c7b9522ecsm11732022qtb.35.2022.10.23.12.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 12:32:30 -0700 (PDT)
From:   uroshm <uroshm@gmail.com>
X-Google-Original-From: uroshm <ludakoreo182@komputer>
Date:   Sun, 23 Oct 2022 15:32:31 -0400 (EDT)
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        micky_ching@realsil.com.cn
Subject: Fixing rts5208 driver code style
Message-ID: <3dbf8c82-9e07-5b9f-e969-4a7cd83e4d9e@komputer>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=us-ascii
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


diff --git a/drivers/staging/rts5208/general.c 
b/drivers/staging/rts5208/general.c
index 0f912b011064..4694593af4d9 100644
--- a/drivers/staging/rts5208/general.c
+++ b/drivers/staging/rts5208/general.c
@@ -9,7 +9,7 @@
   *   Micky Ching (micky_ching@realsil.com.cn)
   */

-#include "general.h"
+ #include "general.h"

  int bit1cnt_long(u32 data)
  {


Signed-off-by: Uros Milojkovic <uroshm@gmail.com>

