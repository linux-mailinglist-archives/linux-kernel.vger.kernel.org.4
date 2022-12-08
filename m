Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54789646A9C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 09:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiLHIe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 03:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiLHIeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 03:34:25 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C8C60EA5;
        Thu,  8 Dec 2022 00:34:25 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id 124so770852pfy.0;
        Thu, 08 Dec 2022 00:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BZ7BqfAhscppPd/MMMpuIWNmxf+bevD/qEdzAfh6TaA=;
        b=i4WtgrRFZFtuWZpu0rjYVGQ0WZiSRkT4KxWWsX62cUJsJiIC+5aqn2OQpn9fBZh2fF
         +evj1UKVOAfpBKVnWpYLsc7pEhJa1O9bXKs5+103J9Hu61HpO6u4V3fzqzgy1QP34JSp
         kcci03OZEbgzsk8r9dk1AX8NXlt6KLZcTUwyoWzux4oyJCc5H3gLrV9gU320mgVRQabc
         9oJ2yMhfzLxe4qpAO0KrrhQo7g5/84pGIEYgPGYmTwO3uZhBZDKXO31my+lUdSdu8y/a
         qiW6paHrwp5uIkyBuCvrfTUYL/X4/YxJMFgzpVYtwl2HezbEH57z0uHcMmivRsCl3RT9
         V83w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BZ7BqfAhscppPd/MMMpuIWNmxf+bevD/qEdzAfh6TaA=;
        b=NsVi6RmDWnidbjTa4mAnhHeX1Pdx75zlfXh+ACWnFqCab5vB90VI634Nq0hbtnEcl7
         CJzbkiwSROqMtBXfbH2sNYM4wKaVZcQH76AgtNiE+7BV8zAzrhPwrvUYhtQIdHTeiHNX
         o7XAuCf8CK0V6VIkp5cRzCRmO81s8PQzMvJjg+QqCTxteUqJ5CrMToTwBrLBvOaPBWt9
         1WM6MMX3qcBvPf2Lu31T7PaU/VqksszSOIh0VcRrU3WjIzXhy9KGMm4V0O4EErKKXxa6
         y+Ma7rR+hl0bZJsvwk93IDrukeE05wKmKV315hdNqssnI6ScCTw+7kn4zaZyR2Ri1zSE
         XNzg==
X-Gm-Message-State: ANoB5pk223DFOImDWOozPUSJw9WtqqWqNKGnqNXqpHRXUMbBQlSfsodH
        r1jQo/74P9r/p71nKilFl6M=
X-Google-Smtp-Source: AA0mqf6aFICfOn7lllVd/nJdh2oYrJ2tni0ymgClNyq5cUlsGJT07TT+CUlYUqxbEC5bWIlK2s5yEw==
X-Received: by 2002:a63:120c:0:b0:477:6ccd:9f4 with SMTP id h12-20020a63120c000000b004776ccd09f4mr73105104pgl.534.1670488464697;
        Thu, 08 Dec 2022 00:34:24 -0800 (PST)
Received: from localhost.localdomain ([185.216.119.110])
        by smtp.googlemail.com with ESMTPSA id j9-20020a654d49000000b0046ae5cfc3d5sm12445980pgt.61.2022.12.08.00.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 00:34:23 -0800 (PST)
From:   Wang Yong <yongw.kernel@gmail.com>
To:     alexs@kernel.org, siyanteng@loongson.cn, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wang Yong <yongw.kernel@gmail.com>
Subject: [PATCH] docs/zh_CN: fix a typo in howto
Date:   Thu,  8 Dec 2022 08:33:53 +0000
Message-Id: <20221208083353.160152-1-yongw.kernel@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a typo in Chinese translation of howto.rst

Fixes: 40d93e496180 ("docs/zh_CN: update howto.rst to latest version")
Signed-off-by: Wang Yong <yongw.kernel@gmail.com>
---
 Documentation/translations/zh_CN/process/howto.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/translations/zh_CN/process/howto.rst b/Documentation/translations/zh_CN/process/howto.rst
index 888978a62db3..10254751df6a 100644
--- a/Documentation/translations/zh_CN/process/howto.rst
+++ b/Documentation/translations/zh_CN/process/howto.rst
@@ -254,7 +254,7 @@ Linux-next 集成测试树
         https://git.kernel.org/?p=linux/kernel/git/next/linux-next.git
 
 通过这种方式，Linux-next 对下一个合并阶段将进入主线内核的内容给出了一个概要
-展望。非常欢冒险的测试者运行测试Linux-next。
+展望。非常欢迎冒险的测试者运行测试Linux-next。
 
 多个主要版本的稳定版内核树
 -----------------------------------
-- 
2.25.1

