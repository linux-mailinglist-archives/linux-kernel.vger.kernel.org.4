Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33E169E79F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 19:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjBUSf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 13:35:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjBUSfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 13:35:55 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78262E0EC
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 10:35:07 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-536e10ae021so29625237b3.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 10:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jp-hosting.net; s=google;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q43YMjfgsdyDVzOYcF56Bu/Nx3l2GHgFlcMIt46mPYc=;
        b=XxpvHumA2VhkZIiAzz4Mx4qvyPphUN54WPkZ3D3g+CXN+CKMLbJ8fhuYcRcO2bcMtL
         cNMGRQ+v6z7aLScvs9nxy5rQBaDBYuiMJUw+63ziDa/eirlcsCCUHDoheU+2iUhsT+/t
         JKwMtslNSsDM590E1d+lpZo8MVHsuIvKqRSdtnnIY1c9/FXRVANk8f16QcROsQel423m
         +/7q2nSzbw29Op3owhqLpxc0/No9HCgp8YC/rNLXYuN96K5hU0IWf6+bWtsNB002C4GS
         IScbffO2GDyX1Aji1Hdjfp+NRVkYm/tY4E9RGKFpYRNmjQ3cJu0LBcG4/FBp9LM6ky/0
         R7Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q43YMjfgsdyDVzOYcF56Bu/Nx3l2GHgFlcMIt46mPYc=;
        b=QPfRN/ByQnQlgnKk8Gjte5lRWMTYaiyfm1cF9ChptNLHbm9HwobP4eAwnx/eFGVHnd
         Ry1tQ1o50EK9pJNNmRSaH4JUyKAVGsl8ScuqosoQkNQVHck+o3ZeW8yJu3JUviqTO+UP
         8waVTtKscSOu3iuZZWWJOBGPYy+t6L1OKsKS/Jh1yaMt4l9Rnv4lgycUaeHy39iyAqgT
         kQ2rzNgSb8u2f+yGECLTZfDZKr530SbhsG5014BbblAGq9VfdG0kPxa4qbbLLrOdiJUl
         769e65nrIdiyGVfg/20T7dqX1I5mP2uUQFa+SSSJJlMKYzMqlgIeNhIjbklg+TCVHPeW
         Ig1w==
X-Gm-Message-State: AO0yUKUBFhjJqfDMYtKUij4f7YlxZfiZlku5u8iHIXz6lsrgQRaXFQlO
        RHVde2nPpXo+y5kAvZzSBXraQQVK99KEljFgCtpLnmV143aHIS66
X-Google-Smtp-Source: AK7set/dM+9tYmmMEoUXVLSmkQE/i04t4tXye1IwL5UJcWA9OT6rW9Uq+DyA8tc+AQtfPwZKTgcCt2Vi8Sqi/+Zko/o=
X-Received: by 2002:a0d:d952:0:b0:534:389:6b6f with SMTP id
 b79-20020a0dd952000000b0053403896b6fmr48734ywe.347.1677004506817; Tue, 21 Feb
 2023 10:35:06 -0800 (PST)
MIME-Version: 1.0
From:   James Addison <jay@jp-hosting.net>
Date:   Tue, 21 Feb 2023 18:34:55 +0000
Message-ID: <CALDQ5Nwfz6z_BxCJnMdTP76M0Y3b9+aSXNjZ04MZisEwSTB-cg@mail.gmail.com>
Subject: [PATCH] Documentation: update kernel parameter limit notes
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There does appear to be a limit on the number of parameters accepted by the
kernel at boot-time, so this changeset updates the kernel-parameters.rst
documentation to reflect that.

Signed-off-by: James Addison <jay@jp-hosting.net>
---
 Documentation/admin-guide/kernel-parameters.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.rst
b/Documentation/admin-guide/kernel-parameters.rst
index 959f73a32..12cbf46b6 100644
--- a/Documentation/admin-guide/kernel-parameters.rst
+++ b/Documentation/admin-guide/kernel-parameters.rst
@@ -204,7 +204,8 @@ be entered as an environment variable, whereas its
absence indicates that
 it will appear as a kernel argument readable via /proc/cmdline by programs
 running once the system is up.

-The number of kernel parameters is not limited, but the length of the
+The number of kernel parameters is limited to 32 by default (128 in User Mode
+Linux), and is defined in ./init/main.c as MAX_INIT_ARGS. The length of the
 complete command line (parameters including spaces etc.) is limited to
 a fixed number of characters. This limit depends on the architecture
 and is between 256 and 4096 characters. It is defined in the file
-- 
2.39.1
