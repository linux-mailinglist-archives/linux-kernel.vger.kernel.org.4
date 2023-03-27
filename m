Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1306CB181
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 00:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbjC0WQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 18:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjC0WQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 18:16:40 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD32210CA
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 15:16:13 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id n14so10095840qta.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 15:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1679955373;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z5lj/6UTrMTaQs3XxDzRmkfXrhODt3Vk2XYXlA7CNSk=;
        b=EK2yoTZaEtxFX/3TLQN6gzUJMYeSfOGAR/HFGrnEDjIjX5aG/DUbySfreRK8kpPp65
         2+iZvNUAL1Qoe+9xSCeaOKhO0WH/hNND9wwTx9OeA7SiQ817m0Rfr7wckfGYvF+MZYTq
         szTv8tuGi3AQNkMOHsMcMFdMGgXZg31C7OcmKQzedqAplG2/24qOf6qBb6MotL/9i3Jt
         vVsa68qNnH6yS1M54GhN+trCYbP+eH3OR4Yhs3BFzLhFljBowVcm0j1vztIzSAmJXZzs
         Gpc9OQUzBI8qWDVNNJcSaD3/+HEJpNf/GKYsqfeOZNFTm6LDNgIe1vcZyoVUKB2m9Pjg
         HbJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679955373;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z5lj/6UTrMTaQs3XxDzRmkfXrhODt3Vk2XYXlA7CNSk=;
        b=RSUsjj5ha3fRnJBJDiqnj9MjZckeBbqoktWa3zkt3+ExWgzBepkyqT4AYeNpAsqyTL
         z9KsDl6RKrPP4/MNomPw91Jmmy/91QHVnI1ripv88Uw5Au8wiFiX26UnTYu6e9NtTirL
         FDctOocxtvbCEyjUi8z8C0NOjEUv7qFne38sOYsy+mx35EzQ5fHTi9G70HhJQpQo83Lr
         QZFgJRccQCtmZ1Ozsa14gyi4JTpRKj/Ai4VdSLYHgIJAvPgVVSWGRgafvefhkeozQsu6
         iUZ43D6S72iYPZNFvX+B0RF9PY/sONil+TCdsRqoLiJ1rKfNmCdIaMH7op6vkaHXI+y5
         G8jQ==
X-Gm-Message-State: AO0yUKV10sIp6ucz9bnrxlz8LsVCG5vtuJZK0E45aP1vw7REnFm3qAif
        ymTw2Vkrj/deWxIO2Tol/rlCaYO558ZCPPukK38=
X-Google-Smtp-Source: AK7set+agQjVz+xTuIC1yCXMJbM4aGDPi+73qWSmpx2q1CeguaYQjJsMApS7ZK6OKEdhGLFP+Ihslw==
X-Received: by 2002:a05:622a:1193:b0:3e4:26de:162d with SMTP id m19-20020a05622a119300b003e426de162dmr21706637qtk.16.1679955372850;
        Mon, 27 Mar 2023 15:16:12 -0700 (PDT)
Received: from [172.17.0.3] ([130.44.215.108])
        by smtp.gmail.com with ESMTPSA id i67-20020a37b846000000b0074865a9cb34sm1516383qkf.28.2023.03.27.15.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 15:16:12 -0700 (PDT)
From:   Bobby Eshleman <bobby.eshleman@bytedance.com>
Date:   Mon, 27 Mar 2023 22:16:06 +0000
Subject: [PATCH net-next] testing/vsock: add vsock_perf to gitignore
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230327-vsock-add-vsock-perf-to-ignore-v1-1-f28a84f3606b@bytedance.com>
X-B4-Tracking: v=1; b=H4sIAKUVImQC/0WNSwrDMAwFrxK0riCxS1p6ldKFP3IiCnKQTQiE3
 L1OKXT3hoF5OxRSpgKPbgellQtnaTBcOgizk4mQY2MwvbG9NTdcSw5vdDH+1kKasGbkSbIS3o2
 /jn5INo0JWsS7QujVSZjPjFBFoa2ealFKvH2/n3/xOo4PqELZWpUAAAA=
To:     Stefano Garzarella <sgarzare@redhat.com>,
        Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bobby Eshleman <bobby.eshleman@bytedance.com>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the vsock_perf binary to the gitignore file.

Fixes: 8abbffd27ced ("test/vsock: vsock_perf utility")
Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
---
 tools/testing/vsock/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/vsock/.gitignore b/tools/testing/vsock/.gitignore
index 87ca2731cff9..a8adcfdc292b 100644
--- a/tools/testing/vsock/.gitignore
+++ b/tools/testing/vsock/.gitignore
@@ -2,3 +2,4 @@
 *.d
 vsock_test
 vsock_diag_test
+vsock_perf

---
base-commit: e5b42483ccce50d5b957f474fd332afd4ef0c27b
change-id: 20230327-vsock-add-vsock-perf-to-ignore-82b46b1f3f6f

Best regards,
-- 
Bobby Eshleman <bobby.eshleman@bytedance.com>

