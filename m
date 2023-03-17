Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8746B6BE18D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 07:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjCQGuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 02:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjCQGuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 02:50:50 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1231BBB1A
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 23:50:49 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id o12so16537427edb.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 23:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679035848;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PZwiQZCTdL7iFDG6PfjxB0RcQIGGEmYmfV5a7taivgI=;
        b=XZkTZy3h7sZw4ZbiztlnKjDmDFjudfHbEPTnTzEHbUD4ka997k74kUHUPgDNU/vMLh
         ASPmnJpDEhfyi9u6V9ometpd1uC5BChDf6HcZ+uLRZQpikSrWHyq80Se0V1CJTubK59X
         heuBpqaYh335OL/A0nOTmeAjCvjWR1fagdjlMDSnDO3d43FnVXQGeFOaA3qbUD1CCI4X
         u1MlxocH8bhMqp3zFdF2/d2/3L/qrRODH7zUnd5B8EjaXO4S1c9TY8pjLcWXkOBthE8m
         dnLw1KKB1NIM1Bnwc0K4uS34aeRDOKoOqHX58acfwbw9S/QswV3ML5VMTv/QXXyAnKMn
         +vSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679035848;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PZwiQZCTdL7iFDG6PfjxB0RcQIGGEmYmfV5a7taivgI=;
        b=SXT72iGqE0qFv7jZMQKA76HizupWXNt9vW3Sip0IDcvRZIDVZn/CHp41mtJSe3IDqV
         Rw7l9K9fd9jxVQbdF+jREFR0fXsvZ4ZJJGjRwTEUt+23KtgqG9SEqgqM9LMy0a+ag/Sp
         3Xuivd81aee7PWbp5ybU2G7vSri/k6kLmmKTlYShlRjt/YxbDInJOYs0f9eI3JKkUUsn
         pA2U8+CBEs+dslyivN01QQMn6kZpf4aVy6cm5ODNhI+gPr9s5GtqWAmv1dVph3gviCul
         nhRlp/DHhzWxweiFl1BqKyV/GP69uADvu+Ap8MZdivkUQokIE5qtMwWBEWzWaYIcT+Z7
         65JQ==
X-Gm-Message-State: AO0yUKWm4O8JA5c33sWUSi+6Rd5+FicSFTMDliNUv92V5XvCnlaunMdx
        aJVNfa8gcVr0c2mtfFHgsLg=
X-Google-Smtp-Source: AK7set+kAZThq/GfAB0rs+LLLPDquOEwRhtIl5/yKPQvzL7zPjwJZpX7pXRqhhC7AT7enGp2hzw/sw==
X-Received: by 2002:a17:907:d19:b0:930:528b:91e9 with SMTP id gn25-20020a1709070d1900b00930528b91e9mr6203439ejc.41.1679035848099;
        Thu, 16 Mar 2023 23:50:48 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abbef.dynamic.kabel-deutschland.de. [95.90.187.239])
        by smtp.gmail.com with ESMTPSA id z24-20020a17090674d800b009289de993e2sm577438ejl.216.2023.03.16.23.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 23:50:47 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     forest@alittletooquiet.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/2] staging: vt6655: remove two unused functions
Date:   Fri, 17 Mar 2023 07:50:39 +0100
Message-Id: <20230317065041.16635-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.40.0
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

This series removes two unused functions.

Michael Straube (2):
  staging: vt6655: remove unused bb_power_save_mode_on() function
  staging: vt6655: remove unused bb_power_save_mode_off() function

 drivers/staging/vt6655/baseband.c | 44 -------------------------------
 drivers/staging/vt6655/baseband.h |  2 --
 2 files changed, 46 deletions(-)

-- 
2.40.0

