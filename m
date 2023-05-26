Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED30712ECF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 23:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244083AbjEZVPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 17:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237512AbjEZVPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 17:15:12 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C249CBC
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 14:15:10 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-75b08639930so138247985a.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 14:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685135709; x=1687727709;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=NZs1ifsRVIrPuhehqNMplVsVFwlkOFVBkWyhYebsJ+c=;
        b=do+W/wuggezssSHkDzH+Cr05dCJwG8868LDrIHwEalsU2HJoD0hSsZ/3wt5dHcmogF
         wDR55b9KIHkfFglFylF+V4MVzGQg3YlkL2fW2UB+6YrF0x8jkmYDFLz/gvW37x2uUuOK
         xSy66jZU6z4wPUawRZvTL9a6Z37nAFHMbt7Ux33TfVZrruEjka+T0wd4ARRpwpbQOV7J
         WvgjC6BDpMh8lDCmrNOAzWFcewG/g5kxn2Oc9U5+ueYAEDMurN1L9zgS8xDRkZL6Ti88
         +xb8i3z0bzuDxsSP7zhK5QlGOtdYuPFXVx5phvVu3BkbL7MqMRHhuGhD3589Iq6dOMHQ
         Br1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685135709; x=1687727709;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZs1ifsRVIrPuhehqNMplVsVFwlkOFVBkWyhYebsJ+c=;
        b=KqpeB4XRgjmhEbiLQcY9zII8kpH+ovhtpEruS8eZPCWIkkJHPGhK5taNs4B50kqL/Y
         eOwEpP7vzH4me9peXj1+bkKTpxRxiHmNstAfKG4zfWRqIX7MzYkwaYHOeUicEvw71sk8
         AOBT/qEmQ8I/1KdffvCCrYyR/t3ka8Npey3ssLABkBsWWa4mlrOXdynqgpKWFJIXV6dp
         jnDnhrYi8a9MWMTQehVkLIWclvzcLZTiiNugzv/3IcycU508RysRSF/9SCVouKHg0iQl
         r9njYRJGwCc+awwcxBpdbSVIeZLujSF9wM41DLT+pwdlvf6rZH47xQT6I7oeOfFPBkQ9
         u9RQ==
X-Gm-Message-State: AC+VfDw5N1yTWP5Mw00Im92XArEqKHzSUn3F+5AFeNGSa6oD31clbmQk
        JquG1/z2R9pfU4Pqvoi6SetSfLwyh/bxNA==
X-Google-Smtp-Source: ACHHUZ66NgKJwbtKjniaQgtdLg1M31N7MR7QDUm66wsXjcsC6BROLi+lP/X2Y2oYlWl+TVPtcxIcYw==
X-Received: by 2002:a05:6214:c4b:b0:625:aa49:ea00 with SMTP id r11-20020a0562140c4b00b00625aa49ea00mr190005qvj.29.1685135709520;
        Fri, 26 May 2023 14:15:09 -0700 (PDT)
Received: from skiffserv.dyndns.cscott.net ([172.56.193.158])
        by smtp.gmail.com with ESMTPSA id k9-20020a05621414e900b0062142017f4csm1460548qvw.143.2023.05.26.14.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 14:15:09 -0700 (PDT)
Sender: "C. Scott Ananian" <cananian@gmail.com>
From:   "C. Scott Ananian" <cscott@cscott.net>
To:     linux-kernel@vger.kernel.org
Cc:     "C. Scott Ananian" <cananian@alumni.princeton.edu>
Subject: [PATCH] Update CREDITS for C. Scott Ananian
Date:   Fri, 26 May 2023 17:14:54 -0400
Message-Id: <20230526211454.192438-1-cscott@cscott.net>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "C. Scott Ananian" <cananian@alumni.princeton.edu>

Update website and address.

Signed-off-by: C. Scott Ananian <cananian@alumni.princeton.edu>
---
 CREDITS | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/CREDITS b/CREDITS
index de7e4dbbc599..1af62a56d714 100644
--- a/CREDITS
+++ b/CREDITS
@@ -85,13 +85,12 @@ S: United Kingdom
 
 N: C. Scott Ananian
 E: cananian@alumni.princeton.edu
-W: http://www.pdos.lcs.mit.edu/~cananian
+W: https://cscott.net
 P: 1024/85AD9EED AD C0 49 08 91 67 DF D7  FA 04 1A EE 09 E8 44 B0
 D: Unix98 pty support.
 D: APM update to 1.2 spec.
 D: /devfs hacking.
-S: 7 Kiwi Loop
-S: Howell, NJ 07731
+S: Brookline, MA 02446
 S: USA
 
 N: Erik Andersen
-- 
2.30.2

