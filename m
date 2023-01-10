Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595FC663D3B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 10:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238073AbjAJJrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 04:47:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbjAJJrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 04:47:31 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C266416;
        Tue, 10 Jan 2023 01:47:30 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id bj3so8547836pjb.0;
        Tue, 10 Jan 2023 01:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R6sUd/uHtqMfedDkpegs2nXLaTKbhfyEkpAVIcIIPDE=;
        b=DhBv0nkcpoIvEpbwmONFue0ovB8/R0gHS5r9BW8vt1F3c4/FQr23xr0kNEkYkCNbe1
         TW0t6ScZkoES95Xln5B+DHOwiAMkfgYB/WCVJpYPrNb7+uDdcJn4wui8o3C6DokhOHXh
         bmCwIsUY/giPsC35c9axlq1iKQC04TDazZ8c9Tt/u2t+eCZEgY0bfBsmxzBLR8oLZ3VH
         Wc0cQZDjeNp04rhfpNsBQ5R9h+8dJ0qv07HyjWaeu2icNU8se5bmWFRSNEafYFK1O7v6
         Tf0eCqe0mztyjGElfxab+YbourMu9PnKb+3AAFaY7A6goBgHzQQDzlNYTBw7zT5gmzXQ
         sj+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R6sUd/uHtqMfedDkpegs2nXLaTKbhfyEkpAVIcIIPDE=;
        b=6DAJ7u5KZ8EgjjxtzA1wAggLBSP3FcHQYE5YfJDE8ShQOzM5CZe1x3mcp6JZaSUdhW
         X1UJaqMZ79J+ZBqpDf+9P19VHqYJ49i4ME8WUvV1PN32DSFQqgrcwT6RCExpuvvggire
         JnrMxoiPR9YTb6GvUjXH7PgyG0ZBjN152WHM0RlHI/LrlTuHHBwJ2OUI1xkXY63gfFWN
         dAziJMeRGWeLSOKVoIG1FEZJgVwX2+hcM4X/G6l9yNnhDcy6YFxl3Y1ctkMxD10swEfi
         uo2C3LcBKtrWFfjuXVWjbm6t326kbx4e1dxfkXdjOXPSvRnoqvjmxkp9t/P0RZ53Ad0d
         JQWg==
X-Gm-Message-State: AFqh2kpfR7PnyyEc063Z/UjzLIGbsO4m43awd2269TB1woqwaYnrWgt4
        ctBFIn74teZFOk41HZG+EUc=
X-Google-Smtp-Source: AMrXdXskoMEs+JnwgcmWTaVfS+LyzHBnEmRrj/3hKZtrhQEpG05UWEdBeqODJmLRC7wJJMowsBK4QA==
X-Received: by 2002:a17:903:32c2:b0:192:b0cb:2e23 with SMTP id i2-20020a17090332c200b00192b0cb2e23mr49724214plr.46.1673344049569;
        Tue, 10 Jan 2023 01:47:29 -0800 (PST)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id x11-20020a170902a38b00b00192fb119eb2sm7662295pla.54.2023.01.10.01.47.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 01:47:29 -0800 (PST)
Message-ID: <4b162dbe-2a7f-1710-93e0-754cf8680aae@gmail.com>
Date:   Tue, 10 Jan 2023 18:47:25 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH] docs/conf.py: Use about.html only in sidebar of alabaster
 theme
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"about.html" is available only for the alabaster theme [1].
Unconditionally putting it to html_sidebars prevents us from
using other themes which respect html_sidebars.

Remove about.html from the initialization and insert it at the
front for the alabaster theme.

Link: [1] https://alabaster.readthedocs.io/en/latest/installation.html#sidebars
Fixes: d5389d3145ef ("docs: Switch the default HTML theme to alabaster")
Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
---
Hi Jon,

I noticed this (kind of) build regression while trying to compare
the alabaster theme with the other themes.

I must say that the current html documentation at

    https://www.kernel.org/doc/html/latest/

is almost unusable in site navigation. Once I jump from the top page
to somewhere, I'm at a loss. I can only go back to the top page,
or go back to the previous page with the help of the browser. 
(Of course, as I know the directory structure under Documentation/,
I can navigate manually, but that's not nice!)
I think it should at least have the same set of links as those
the classic theme provides.

Having read [1] and its surrounding documentation (for the first time,
I must confess), the alabaster theme sounds (somewhat) unique in
customizing sidebar and related links.

But before looking further into alabaster, I'd like to know why
you picked alabaster among those themes which come with Sphinx.
Could you elaborate?

        Thanks, Akira

--
 Documentation/conf.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 44899be7b2cc..d927737e3c10 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -345,7 +345,11 @@ html_use_smartypants = False
 
 # Custom sidebar templates, maps document names to template names.
 # Note that the RTD theme ignores this
-html_sidebars = { '**': ["about.html", 'searchbox.html', 'localtoc.html', 'sourcelink.html']}
+html_sidebars = { '**': ['searchbox.html', 'localtoc.html', 'sourcelink.html']}
+
+# about.html is available for alabaster theme. Add it at the front.
+if html_theme == 'alabaster':
+    html_sidebars['**'].insert(0, 'about.html')
 
 # Output file base name for HTML help builder.
 htmlhelp_basename = 'TheLinuxKerneldoc'

base-commit: 7021e29503a30f323d74e91b57f06227337ecc95
-- 
2.25.1

