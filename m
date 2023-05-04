Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 909316F6747
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 10:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjEDI0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 04:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjEDIZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 04:25:31 -0400
Received: from m228-13.mailgun.net (m228-13.mailgun.net [159.135.228.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F0C59FB
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 01:18:59 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=equiv.tech; q=dns/txt;
 s=mx; t=1683188339; x=1683195539; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Subject: Cc: To: To:
 From: From: Sender: Sender; bh=kWEemaQZmsMuYmg29aWpou4RqRqESJO00M5rW2oZmNo=;
 b=cIp3oOXFw04yBY2WxVoD5878/Fu2dfgKGdn0xs/Yrw0fEAsOOhU1i4ovpPa+MRuZfWD7zgArJRPmqVO2ggS0L+VPTSPem8ZU+d7+JDW5WQa7qYGc1Ea4ZRdJUlbMVZl9VxnOXeQF49Qo8ZKoQc89ulIWIBc0xBxRiae6nb9oynsY15qiad8ymhPo5K8Qd8PNn/R4e3MIkaz2BehaVGmWKYyq91/UsnrXZoFyXOhe52cacOFG8rEofyCWPgFMrxf3FaNhp6XVRtNePsPQEMvwUFO2HrqnnlQ302cGGThtHx8IpiwvVSFW9In5DhKbmvJYe8Dbv7kvbqUqgQPznpWDSg==
X-Mailgun-Sending-Ip: 159.135.228.13
X-Mailgun-Sid: WyI4ZWI3MiIsImxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmciLCI5M2Q1YWIiXQ==
Received: from mail.equiv.tech (equiv.tech [142.93.28.83]) by efeec5c3c3b9 with SMTP id
 645365a37ce302952f4fc523 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 04 May 2023 07:58:27 GMT
Sender: james@equiv.tech
From:   James Seo <james@equiv.tech>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     James Seo <james@equiv.tech>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC 01/11] Documentation/hwmon: Move misplaced entry in hwmon docs index
Date:   Thu,  4 May 2023 00:57:42 -0700
Message-Id: <20230504075752.1320967-2-james@equiv.tech>
In-Reply-To: <20230504075752.1320967-1-james@equiv.tech>
References: <20230504075752.1320967-1-james@equiv.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the entry for the inspur-ipsps1 driver so that it no
longer appears in the hwmon docs TOC as a document relating
to the hwmon subsystem itself.

Signed-off-by: James Seo <james@equiv.tech>
---
 Documentation/hwmon/index.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index fa1208c62855..03b30a94a9e6 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -9,7 +9,6 @@ Hardware Monitoring
 
    hwmon-kernel-api
    pmbus-core
-   inspur-ipsps1
    submitting-patches
    sysfs-interface
    userspace-tools
@@ -85,6 +84,7 @@ Hardware Monitoring Kernel Drivers
    ina2xx
    ina238
    ina3221
+   inspur-ipsps1
    intel-m10-bmc-hwmon
    ir35221
    ir38064
-- 
2.34.1

