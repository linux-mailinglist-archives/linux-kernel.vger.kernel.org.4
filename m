Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6916DA099
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 21:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240539AbjDFTBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 15:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240424AbjDFTBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 15:01:31 -0400
Received: from mail-io1-xd4a.google.com (mail-io1-xd4a.google.com [IPv6:2607:f8b0:4864:20::d4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EF8A5C9
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 12:01:07 -0700 (PDT)
Received: by mail-io1-xd4a.google.com with SMTP id g7-20020a056602242700b00758e7dbd0dbso25414962iob.16
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 12:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680807666;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ei4XEWjw7tArTwCoMKhp2ugctsL7jq49nRaYDRBL1Mc=;
        b=fbhRqzlGZlbPiWZ5IBGIy4z7rckgpL+76StH6hDf38wyBwByXbCIsFAmlVE0cVG5TK
         HqsTdsJmsOQJn26fMUBbDBhi697JYKpNT9cxQeU2fDWUSLG/eByrdUnKIe23vrDVZxqf
         ZBP1v4gu3dj1CHb/wtHjIhqoU1bMKJKU3wrEELXyN2gGsZyVLOip7UnrYagQr/ev81xN
         b3Bd3vKO5r1GVoi09bRFAB8/a7Y+D6JuDR595SthHnsolBMZsbGW92HOBuSfhM/J8OsN
         ba5cd5hdIpxcz5JXh8vvJQADy3Ad8PB/eaqfwUiX7uO/j4zE7x5OlmQhexuRZ9/HWi41
         5dOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680807666;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ei4XEWjw7tArTwCoMKhp2ugctsL7jq49nRaYDRBL1Mc=;
        b=CL0EC7BaelCRxESnylAzxu3K1VciIDWC1YF7OF+waL52iqhD3hO65vIW7oLDPTnSof
         SxsKbVLMNyRjjPBhTUYzjGkQG+CxqF8Ootd3WcNJF+CetmAo+9QA0trFEGvgdX++TWXt
         5D0jrCh9xjh8r+kk0lFSs0LS4GTqeOvF00SBBAnQPGhknk1vflSPURZj8aF9FiP3XeoZ
         jwJKvX54j0aHOVl8LBSrI0rR7qSCgvSVU367sSiyAeSU1hMOvSzxA4lfPhdZvZkESKCE
         urrdJliAIWrnLL7Ft+GVats2CnHIEImEpFkyjle7o8K9bZnxowFM9AV7bLVvwBNgqXtA
         iddA==
X-Gm-Message-State: AAQBX9fwjzCV4EBwGg4wRxqfpEttKaDlcxcuNF4N3FQ9pLjuH3qeSjtf
        qd3w8pW0FatRhtigL3R88+lUjgRTG593J7k=
X-Google-Smtp-Source: AKy350ZZbJ29Gs9P2JWFiLO/pUBF8z9KEDzLtRKohDDgzI4f5p+saGHIi3qNgDRvjyVBK16Y4yqOOCNY933bmd4=
X-Received: from allenwebb.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:12e8])
 (user=allenwebb job=sendgmr) by 2002:a02:2a45:0:b0:406:c43f:6320 with SMTP id
 w66-20020a022a45000000b00406c43f6320mr4089875jaw.0.1680807666582; Thu, 06 Apr
 2023 12:01:06 -0700 (PDT)
Date:   Thu,  6 Apr 2023 14:00:28 -0500
In-Reply-To: <20230406190030.968972-1-allenwebb@google.com>
Mime-Version: 1.0
References: <20221219204619.2205248-1-allenwebb@google.com> <20230406190030.968972-1-allenwebb@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Message-ID: <20230406190030.968972-10-allenwebb@google.com>
Subject: [PATCH v10 09/11] Documentation: Include modules.builtin.alias
From:   Allen Webb <allenwebb@google.com>
To:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     gregkh@linuxfoundation.org, mcgrof@kernel.org,
        christophe.leroy@csgroup.eu, nick.alcock@oracle.com,
        Allen Webb <allenwebb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the documentation to include the presense and use case of
modules.builtin.alias.

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Allen Webb <allenwebb@google.com>
---
 Documentation/kbuild/kbuild.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/kbuild/kbuild.rst b/Documentation/kbuild/kbuild.rst
index 5202186728b4..b27c66c3ca9e 100644
--- a/Documentation/kbuild/kbuild.rst
+++ b/Documentation/kbuild/kbuild.rst
@@ -17,6 +17,13 @@ modules.builtin
 This file lists all modules that are built into the kernel. This is used
 by modprobe to not fail when trying to load something builtin.
 
+modules.builtin.alias
+---------------------
+This file lists all match-id based aliases for modules built into the kernel.
+An example usage of the built-in aliases is to enable software such as
+USBGuard to allow or block devices outside of just the vendor, product, and
+device ID. This enables more flexible security policies in userspace.
+
 modules.builtin.modinfo
 -----------------------
 This file contains modinfo from all modules that are built into the kernel.
-- 
2.39.2

