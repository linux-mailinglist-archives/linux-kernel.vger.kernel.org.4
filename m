Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E58A6FCD1A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 19:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234772AbjEIR7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 13:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234636AbjEIR7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 13:59:21 -0400
Received: from m228-4.mailgun.net (m228-4.mailgun.net [159.135.228.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53D94EF4
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 10:59:18 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=equiv.tech; q=dns/txt;
 s=mx; t=1683655158; x=1683662358; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Subject: Cc: To: To:
 From: From: Sender: Sender; bh=AhzIKWTMsV4zA7MKuXnmnFl9fzQYGsYJmx449VzTw/k=;
 b=rt7nZG4eY1jmCmkyT+f4vD1T6Gb3gdCSV+Tne5Y+RvAU+u8DLKnqNaMUjMI2BQTafFLQMClsyB7q4p8DOae9wpUVOl4G4tg1cNWRZC/TizMOY/iqCiRGCNQeFJVaefxFYaE/JmJj/9BrCxXOkkaafyEZeKcmIJCFoPwh+Z25SM76Ev79ubuJn0iWBwSdoR17QORl0yR9hQecprKAyVnvWzHhm3A6zQEbZf+jFPBvmoJyExQQ+0bi4U5CGfZNNUUPALSLd6WQLMEC+x02fpOJ8qeOuu3sPUGMXhE/8do5A4Vf097PIDQT8WSl9uXQ4d93hELxx8yCizt5C+9c7vIOMw==
X-Mailgun-Sending-Ip: 159.135.228.4
X-Mailgun-Sid: WyI4ZWI3MiIsImxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmciLCI5M2Q1YWIiXQ==
Received: from mail.equiv.tech (equiv.tech [142.93.28.83]) by 450ed783a028 with SMTP id
 645a89f67ce302952fa785cb (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 09 May 2023 17:59:18 GMT
Sender: james@equiv.tech
From:   James Seo <james@equiv.tech>
To:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     James Seo <james@equiv.tech>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] Documentation: core-api: Add error pointer functions to kernel-api
Date:   Tue,  9 May 2023 10:55:48 -0700
Message-Id: <20230509175543.2065835-4-james@equiv.tech>
In-Reply-To: <20230509175543.2065835-1-james@equiv.tech>
References: <20230509175543.2065835-1-james@equiv.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bring the error pointer functions (e.g. ERR_PTR(), PTR_ERR()) into
the docs build so that they can be cross-referenced elsewhere.

List them as kernel library functions in the kernel-api document.
Nowhere else seems to fit, and they need to go *somewhere*.

Signed-off-by: James Seo <james@equiv.tech>
---
 Documentation/core-api/kernel-api.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/core-api/kernel-api.rst b/Documentation/core-api/kernel-api.rst
index 9b3f3e5f5a95..44b96e18f8f2 100644
--- a/Documentation/core-api/kernel-api.rst
+++ b/Documentation/core-api/kernel-api.rst
@@ -96,6 +96,12 @@ Command-line Parsing
 .. kernel-doc:: lib/cmdline.c
    :export:
 
+Error Pointers
+--------------
+
+.. kernel-doc:: include/linux/err.h
+   :internal:
+
 Sorting
 -------
 
-- 
2.34.1

