Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C675B7F21
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 04:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiINC6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 22:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiINC6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 22:58:11 -0400
Received: from out203-205-221-233.mail.qq.com (out203-205-221-233.mail.qq.com [203.205.221.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E61B6583E;
        Tue, 13 Sep 2022 19:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1663124287;
        bh=mntmAyFdC2kyLkanzymJFmnOFp0qNaHrcUQTPCMpG28=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=OswdrgyIdnbh1CY5/rPQHIWVZJyFR6+WCLh3oTByrLNciwak7JrwsOWeUxXiw/7Ke
         /fgSux6kli4Gl+9PKv+7Nkdkh7KvFWq3g0BJ9u+fkkJJ00e2IfmI3DakBa8IIjGULM
         +qhRoJTu6853c3YR5e0rSm0jT7qkkH7KlMfpp3jw=
Received: from localhost.localdomain ([39.156.73.13])
        by newxmesmtplogicsvrszc8.qq.com (NewEsmtp) with SMTP
        id E8301052; Wed, 14 Sep 2022 10:58:03 +0800
X-QQ-mid: xmsmtpt1663124283txe2q73ln
Message-ID: <tencent_312AB3C62E6755325FB3477910430DB08509@qq.com>
X-QQ-XMAILINFO: OEgU9iHXvJ5F5hxvh6cfJsq8O9UquHOB49EoJqG5k8wDySZxy+IO78SyBqREc6
         cyobI7u6JYRq5gtZu2Pnj7IggKgN2e67Hv1vlMAXKb/zQqy8frYr5MVHdF9NZqmAOEXD4XZ44+tO
         oq9TsLjGGRpJFkV2k11DhTKjbLz7bqe/Iev2kVwsCbyqDRpbCHp1dz4/xJpFZnFXn6lP9wJj2sb/
         CwcHS9WGRei98V7QWyhs9NQNGa0rGEAPvXbdXv7ncXwZe9IHyeLZ17pCk1lwptMfbmizr4ucapRB
         zgO4fhRoCN0l+5maM8P8la2Q8wfj61t1054qTION0PRvIcc+2DjRIY4lOBEIlyhWBmLZpZvF/hFo
         rC85pL++Sh0nXE19IrEqNxdlsHcNscCYBD6jlZuawWMhMlNx8MCz9Crm4wBJh7xuxsZhT6X/iMCV
         JvhRpnB2jd21aNpi1FrfHgBFK14QfRQ0iaTLBbh8ht4Ln6nqt5L94ijSklbDHohBmPGttHBecnLm
         Y+9UzAOaIbqyoE8s0/M9yCZqUQtSsSEs/qWz38aGVNuk00MSTLxiCm0AuWm1rNhcqS2OWmYf+4rK
         VllRQESIv6qt9rfGfyGWtnNzC7ucd7lsl0dJ2E/wUJ5jWaHe+z9KV1H1C8RSqYfK5OJWrSdQPC7d
         v2SGjL1zOr3w14KwudzZ46cLtM5VgveRFf20zPnedlY1f/7a3cUPnJ3abx2TL2O2LHvXqYc76SNa
         81MQVc9hV78Awrj2SkyvojDgHH7GvI7LYYlBUfzUPBwKNgNciyUqrt+LEbisVc/DJCXBb9Vyw30a
         edOFS+1yF4XRqL3gmiYllJKaRVKH7MmMJOnYI2fJ++vOb5luCUrq9SqcC5iXF2gMkcmn8/SMlqY4
         t4rL5jcMyJfCjA1Fm54cdAhniD+tqoCitaielG6qzt8DqVbbAu8GEzrdYfEZ/GLG0MHNLa0SW4yj
         D66kONGEMK6omcAmelJSMOwUFZSoGU4Hw/pLsNLwMSBT4tPmipisIyyKM3ApxV
From:   Rong Tao <rtoax@foxmail.com>
To:     krzysztof.kozlowski@linaro.org
Cc:     corbet@lwn.net, erik@kryo.se, jkosina@suse.cz,
        konstantin@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@leemhuis.info, lkp@intel.com,
        ojeda@kernel.org, rdunlap@infradead.org, rongtao@cestc.cn,
        rtoax@foxmail.com, tglx@linutronix.de,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v2] Documentation: process/submitting-patches: misspelling "mesages"
Date:   Wed, 14 Sep 2022 10:58:01 +0800
X-OQ-MSGID: <20220914025801.13727-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <2e4c52b5-85e8-6951-8248-961c2cdb13e7@linaro.org>
References: <2e4c52b5-85e8-6951-8248-961c2cdb13e7@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix spelling mistakes, "mesages" should be spelled "messages".

Signed-off-by: Rong Tao <rtoax@foxmail.com>
Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/process/submitting-patches.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index be49d8f2601b..7dc94555417d 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -715,8 +715,8 @@ references.
 
 .. _backtraces:
 
-Backtraces in commit mesages
-^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+Backtraces in commit messages
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
 Backtraces help document the call chain leading to a problem. However,
 not all backtraces are helpful. For example, early boot call chains are
-- 
2.31.1

