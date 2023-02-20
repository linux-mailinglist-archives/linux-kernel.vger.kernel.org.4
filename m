Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1FD769D1C1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 17:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbjBTQ6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 11:58:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbjBTQ55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 11:57:57 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F43F7A8F;
        Mon, 20 Feb 2023 08:57:55 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id o12so7606728edb.9;
        Mon, 20 Feb 2023 08:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sKhS1XkPMQxMCs4PB6gvYep2AFIGq1h4u0coF+hO4cs=;
        b=PiXZZTBpnSk7jqOvEbc8PkUHAQktrGb4YNVGKT/ZHKH7ZuHbGZUsQDWfhsYT1ofpsY
         juUYSy3JCUoOfp/cM/Yd3IWpid9re8SW8pap9fHQWupba9QkDz1XpFwBw6+c707VDOgw
         x6bLoAEoLN91vxCXVehQ2wqD6XkQJkkptMLIseBmgdGDCIAW87h3F+8YKdN1FV7qxj12
         5RYLoLQ+5G9DFZm3laExe2B2xcBKK7U8QrAaD5e4ARtjADnxzfXXx55YJ/9qusX0SRi6
         rIMWy5XAUtbY4W44ahIoqN6a7JPqX7vwpIIC8dl+/VqOz99DDyX795OARNKkB+57Witp
         5OGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sKhS1XkPMQxMCs4PB6gvYep2AFIGq1h4u0coF+hO4cs=;
        b=D8wuBJNiHoJiIWZSjMUOBXYBEF8gz28FFvYhZ52zKhEJ1E9Mix/VyohRLJk1qjKl/P
         862a4qAxVaU09OocFp6AZeJcpTBUE7W7MCH8er1jRvyC+H4IdilYLGcp+VV4c2BqAwY3
         R9BNUkbzFHzDDfYwl1OYgJ0eMg0XbReu9CuWD+G37Z5GNS2aVlU+hLK0FjzwUTpT/3/5
         bwDqlSi9qW8jEsOYA39Sfl/yVKDE9+gA85H+KkBbL4zHI//Pw3qnMufdHAw+GbBxdcOQ
         TolV8f0SMJjDj/SUOR9lzfNtcWC8wLs69ToAmL/NufFrOWtEV/T5HD/yWxjID4XKfw5D
         ofFA==
X-Gm-Message-State: AO0yUKXgZYAmM0WkI0a3n0ZpBp0oau+c9d0MqD9/EMpSy0IaGJDG9kjw
        Hm8lHBWz+kZDxyk+K74hmnMoirxgO+E=
X-Google-Smtp-Source: AK7set+mH7M/KvRblmnMoa+9/DsPaLZW6zlUTOWS4is9TUws62Uxkgy5fA8KpE6ss2dF9bPRf8HVSQ==
X-Received: by 2002:a17:906:7c55:b0:88e:d435:3fd6 with SMTP id g21-20020a1709067c5500b0088ed4353fd6mr10651591ejp.63.1676912273814;
        Mon, 20 Feb 2023 08:57:53 -0800 (PST)
Received: from felia.fritz.box ([2a02:810d:2a40:1104:ad0f:1d29:d8a4:7999])
        by smtp.gmail.com with ESMTPSA id hb22-20020a170906b89600b008b14d3978adsm6004006ejb.189.2023.02.20.08.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 08:57:53 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] docs: locking: refer to the actual existing config names
Date:   Mon, 20 Feb 2023 17:57:49 +0100
Message-Id: <20230220165749.12850-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The config is actually called CONFIG_RT_MUTEXES, not CONFIG_RT_MUTEX.

The config CONFIG_LOCK_TORTURE_TEST should be connected by underscore, for
the sake of consistent referencing to configs in the kernel documentation.

Address those issues.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 Documentation/locking/locktorture.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/locking/locktorture.rst b/Documentation/locking/locktorture.rst
index dfaf9fc883f4..7f56fc0d7c31 100644
--- a/Documentation/locking/locktorture.rst
+++ b/Documentation/locking/locktorture.rst
@@ -5,7 +5,7 @@ Kernel Lock Torture Test Operation
 CONFIG_LOCK_TORTURE_TEST
 ========================
 
-The CONFIG LOCK_TORTURE_TEST config option provides a kernel module
+The CONFIG_LOCK_TORTURE_TEST config option provides a kernel module
 that runs torture tests on core kernel locking primitives. The kernel
 module, 'locktorture', may be built after the fact on the running
 kernel to be tested, if desired. The tests periodically output status
@@ -67,7 +67,7 @@ torture_type
 
 		     - "rtmutex_lock":
 				rtmutex_lock() and rtmutex_unlock() pairs.
-				Kernel must have CONFIG_RT_MUTEX=y.
+				Kernel must have CONFIG_RT_MUTEXES=y.
 
 		     - "rwsem_lock":
 				read/write down() and up() semaphore pairs.
-- 
2.17.1

