Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC2E6DBEC6
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 07:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjDIFaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 01:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjDIFaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 01:30:09 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115444EFA
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 22:30:04 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id ik20so2040772plb.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 Apr 2023 22:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681018203;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1yGdTXD81UK+6RB1Ag6uhuMGqDZmHdmvA9kSohgNfBs=;
        b=WmqZj+7C9UJs/4Awm/8MxzqVnxLeJ0Uwk4dTwQCCBkPto6RdMcQmD6mMsfVddwYnki
         wwxrncMe1oEqNZa52XJg3esWFFuSJuscTvVDRGptjWxYbrTvopyK+V1cvJy/jspmo4Gl
         Nz5wcmv0dsplsVM570qACui//loBMlhdtSFA+5azLQDmAcjTWmFYhqGve4Irl9uigRHh
         i6XWa1G0ZNmxM/xXvY1YuNoDyXOJkA1MjasNAOp3hR4PBbRekHKyqxlN5j16z+Rg5DI6
         w4lYolN5cqP6Q8gaqX64nTt5s9H98NWDbgoFIU/+IO0KW/4GAvYRd6kOk3Ufh3h1BiiL
         VzuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681018203;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1yGdTXD81UK+6RB1Ag6uhuMGqDZmHdmvA9kSohgNfBs=;
        b=olZOQkcOSzG0+wUsaewFZipW0Bk946VJM5Cv0vwMyVa9wFFdNzq9u0QL5eaLh9PFn8
         /b5fJE2BFcrqC9mLPXJDCoXChQ8pF7eoxsng+jA/wyFA8BH5pvhFM6cfGlpKTVTvjoS5
         tLc4T3HsMHx6xpzH1zq+3x/i/sIFj0Uf7mye6apGb6VG54VvL+9P4cmQCBa8CF3sExE6
         3pQyLT7HVgvse+wcKqwyzhz0VY6Y/iFJL5efGrIJJRS+xvX9n6cD7rCozOu5khBQetKF
         LIqp0w711KGitbSco9PbNNXhRalIINM1QFfSbxq0EeatelgM5wCePyLqcIUFdzJ6Z45M
         SQCg==
X-Gm-Message-State: AAQBX9dbDGo0qAm/58UJfjOgWSJhzoPi8XaFZ4WZxJslyGAgGIG1wAvV
        3IzjtvgGAfgEoFx3HXy8bG7hHcPTRDCq1L5i6aNxWIBqzINPsDzh
X-Google-Smtp-Source: AKy350b7tGXFDbHUydSvmDVXA/EJexOmDxAPr6/WRr3WRDXuPjUCXY1xuDX9tRtp6rzmCA9xhHOEES5tV7CWfpJe+sk=
X-Received: by 2002:a17:902:d48e:b0:1a5:e03:55b with SMTP id
 c14-20020a170902d48e00b001a50e03055bmr1027625plg.11.1681018203235; Sat, 08
 Apr 2023 22:30:03 -0700 (PDT)
MIME-Version: 1.0
From:   Wang Han <wanghan1995315@gmail.com>
Date:   Sun, 9 Apr 2023 13:29:51 +0800
Message-ID: <CAFfSv_0z9gmzj0GaUKNBq9Qt00F4f9diA5O_XXyaT8pJyrSmtw@mail.gmail.com>
Subject: [PATCH] docs: f2fs: Correct instruction to disable checkpoint
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This should be 'disable' rather than 'disabled'.

Reported-by: LoveSy <shana@zju.edu.cn>
Signed-off-by: Wang Han <wanghan1995315@gmail.com>
---
 Documentation/filesystems/f2fs.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/filesystems/f2fs.rst
b/Documentation/filesystems/f2fs.rst
index 2055e72871fe6b..c57745375edbc7 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -264,7 +264,7 @@ checkpoint=%s[:%u[%]] Set to "disable" to turn off
checkpointing. Set to "enabl
  disabled, any unmounting or unexpected shutdowns will cause
  the filesystem contents to appear as they did when the
  filesystem was mounted with that option.
- While mounting with checkpoint=disabled, the filesystem must
+ While mounting with checkpoint=disable, the filesystem must
  run garbage collection to ensure that all available space can
  be used. If this takes too much time, the mount may return
  EAGAIN. You may optionally add a value to indicate how much
-- 
2.25.1
