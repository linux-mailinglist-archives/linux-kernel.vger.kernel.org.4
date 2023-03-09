Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E616B1B2C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 07:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjCIGNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 01:13:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjCIGNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 01:13:18 -0500
Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6B538B46
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 22:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1678342392;
        bh=KegTiNtaj9nu4V344iEXVgx5ugpCk+MWO9VI6Uk1A8w=;
        h=From:To:Cc:Subject:Date;
        b=Unr8WDyidgcnxamfXZed9LfqFutk3xX1e2zEkMDMzfu4WNivFE2XBdB9v2ZLtCL3O
         oWS+wGRZ9ZORd31DWnMh/M99C9Jpd+WJ6uUnklsLxIxK7nv546mc0Gv1wXCR5nO9fh
         XjtFQfO0aD4OCDhbYYcg8SA5j6u3zVmz3iqDL9tE=
Received: from localhost.localdomain ([39.156.73.13])
        by newxmesmtplogicsvrszc2-0.qq.com (NewEsmtp) with SMTP
        id 349386FB; Thu, 09 Mar 2023 14:13:09 +0800
X-QQ-mid: xmsmtpt1678342389t593iwdwx
Message-ID: <tencent_52B2BC2F47540A5FEB46E710BD0C8485B409@qq.com>
X-QQ-XMAILINFO: Mm/8i8/T4yne4Bn1iBVkKejeEu23aZloj0TzU4h1E6xJBrwip9Ln13OCFrpWp9
         qV2wCAb5oeluXR/JNbXYs/MC6zZAJOecHVheq53QQMVAbrSknvAo5Y9vKqUjCZ936Ru5iKfMXKX9
         YUApTjSyJBAXyBKvJ54Qlg4ABbA2JX2uIgkmQ4zijY819mpO79okYICNsxPS1NBPiNg4xwmPTcIe
         PA03hlWXp8lpjKEgiBEeBQZeycIfwQR54i7sLDE7sypR50XhoJGsVXkT1jBghlgJd6yFBFusqkHj
         wc1/DkUND2IvsPlclDiEnzCTueLYS++VZbOCGJxMfPXPmE2yKSgV3VQILBp/pPLoYuFjybW331T4
         C1plRnpBMpXeP5CeSIVS2X15M5I4VmstkPOv2w5+XTNYrTbqhmYxgvTDpp0qJ9xJEGMIUkD27Qvr
         VIi1PhGyS2LX+l8Is9v9MVL7IoxXG4IT0HHTEos0XrACdVyoAFrVexYEKhpKEJ4wJdJbSG8xZiZW
         dJzskn0/Hzj7owkczjuKl5MKGYnBt0/YHK0oVUkfDbTXaVdP5cb0gvtMsQCjQSQz4ZA7lsnygBf/
         Gk3CdJnfgWRtz/3uO/O9F7v4HD+MbbwRtsM7pER+c0F89hjx5DhFoJSF/uUWA8E63XwggKDVbXla
         jpii6knqjS89WRzl/CuEGLKLZRBvrE+6GBZGvBkdxfNDC2PeKr04sly2ZqyAPcrAGVFaQdrR9C4K
         BQqopq8jH7JTtfLMZAM9fHuYRf4wzz6+vPMOISKnCZTgykyosRvKUXBObmAPFVfJzsUJHHj10puL
         p7oaui6m6Y39c69+1IX/gZX4Z/InFGVWiUbki2+3DJlaVk6fsZP4fFyKgWGOEu99y96JiisjvIfU
         1wPDcI+n6hoQfqav/1p1wZAzWzEAWxuNgrQtJuyedvBzOmvDIK0Thi8+6ZVCak6wygwJY4Cce7AW
         Xe1ZUA4AY8bvj4pmeh4o3MykKEGksMYbs4eir95Vk=
From:   Rong Tao <rtoax@foxmail.com>
To:     sgarzare@redhat.com, mst@redhat.com
Cc:     Rong Tao <rongtao@cestc.cn>, Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO CORE AND
        NET DRIVERS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] tools/virtio: Ignore virtio-trace/trace-agent
Date:   Thu,  9 Mar 2023 14:13:07 +0800
X-OQ-MSGID: <20230309061307.30071-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rong Tao <rongtao@cestc.cn>

since commit 108fc82596e3("tools: Add guest trace agent as a user tool")
introduce virtio-trace/trace-agent, it should be ignored in the git tree.

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 tools/virtio/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/virtio/.gitignore b/tools/virtio/.gitignore
index 075588c4da08..9934d48d9a55 100644
--- a/tools/virtio/.gitignore
+++ b/tools/virtio/.gitignore
@@ -2,3 +2,4 @@
 *.d
 virtio_test
 vringh_test
+virtio-trace/trace-agent
-- 
2.39.1

