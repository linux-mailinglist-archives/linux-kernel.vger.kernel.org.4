Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137685F8447
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 10:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiJHIdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 04:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiJHIdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 04:33:01 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A8E520A9
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 01:33:00 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id 204so6766484pfx.10
        for <linux-kernel@vger.kernel.org>; Sat, 08 Oct 2022 01:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g2+zmkPwl+G0YLDiQrCjhamJbw1PvG/z0mV21D7/zEw=;
        b=helOohmfQK7SaLm/GgIOYpZHrJ5nDzJLkgOckmyYFU+bxIVOf9FoKLiPQsit2RQM3L
         6Qch+qBdUdbEZQFzxvhah388RKh9lyLmRSlhAyZxOiUOe46mddrhpugeJV4HJPH7/aOQ
         +PKa1BvOP/0Agu4ce24RNKILESjhXtqqD3kFE/qRjNF1zq0r6q7ZqfIj+GGiiDvPUd/h
         IHJeP2dBKfmHsF+bJV26sRtFzfyJOpP1lD6MqpUb1uSl4OEKeczVrTV5poafDtsMObaa
         8E+YWNh0Trm9MLJ+ZElamCD4ONA3JP2O7V6xlWJGSeye4ZJ0LpxFETar2YhaGoooeoOt
         u8Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g2+zmkPwl+G0YLDiQrCjhamJbw1PvG/z0mV21D7/zEw=;
        b=Do1CFo2MhR/rJfH9EgbZFEAzejndXK1moWc1mb98g+iOGKjzGWlMvCwl2MdQggMnXi
         afvId46DdG4+1+8bKkWH9dL+685eRLBdpFpvyVJvpM2wKYZ9PtS5q9CQzbUTAGe6kTQJ
         hVNZ0zDXJTPNHhX++/1km1QLkQjoMc9+vxqTM6APNCdI0LwThevzv87TDlnWICHuqkTy
         o//hCabuIoEQxEPW+ZswWpCp4MXgJokkdmtm0JyezOtkM4H/ACpk6LY5h+aX6dvCbTwG
         nOvqzE5n6nbLVF1xfrKdkyZBwRYIuPVAw1vzQ64dwdgeRS1EAJWnlM6zlZOHzhJjjF2n
         Re6g==
X-Gm-Message-State: ACrzQf1FUIO0ue7Xy9jsQDBBmelMmLmXfFxXAU+uBeWaA+n4EldwG2BR
        jsIiobHMMNQdIhHns6t7Zj5JbQ==
X-Google-Smtp-Source: AMsMyM5UrR7OZxRCAUkAbiLivVZ4YvPChxjhW3bt6h1olO4EL4CBTCgCTYTCksGXAcdF3VPNntZ/jw==
X-Received: by 2002:a05:6a00:1503:b0:540:e2c7:2387 with SMTP id q3-20020a056a00150300b00540e2c72387mr9208321pfu.48.1665217979997;
        Sat, 08 Oct 2022 01:32:59 -0700 (PDT)
Received: from leoy-huangpu.lan (45.78.18.36.16clouds.com. [45.78.18.36])
        by smtp.gmail.com with ESMTPSA id x24-20020aa79418000000b00537f16e25d3sm2963504pfo.75.2022.10.08.01.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Oct 2022 01:32:58 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH] docs: ftrace: Correct access mode
Date:   Sat,  8 Oct 2022 08:32:50 +0000
Message-Id: <20221008083250.3160-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
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

The documentation gives an example for opening trace marker with
write-only mode, but the flag WR_ONLY is not defined by glibc.

Use O_WRONLY to replace it.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 Documentation/trace/ftrace.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index b37dc19e4d40..60bceb018d6a 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -564,7 +564,7 @@ of ftrace. Here is a list of some of the key files:
 
 	start::
 
-		trace_fd = open("trace_marker", WR_ONLY);
+		trace_fd = open("trace_marker", O_WRONLY);
 
 	Note: Writing into the trace_marker file can also initiate triggers
 	      that are written into /sys/kernel/tracing/events/ftrace/print/trigger
-- 
2.34.1

