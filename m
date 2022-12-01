Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2C963F452
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 16:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbiLAPkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 10:40:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbiLAPkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 10:40:06 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567B9B3921;
        Thu,  1 Dec 2022 07:39:28 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id m7-20020a05600c090700b003cf8a105d9eso1847369wmp.5;
        Thu, 01 Dec 2022 07:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K7khnonYfy4kMw5YrLUdWciangWNF/Rcsht2NfCuP98=;
        b=JDHX2Ef/eGunqsAS2A/QsNSfTGzQ9HLN3nyTgk0TE4UPI4oNls73HDML6r/m9Vda/X
         ilej4uBBfLJ1H0X/pjnNPvUyTUwHo8YEcbvn8Z7uvvpsudk1v4Q9IO1ygbLkn71uHIEk
         8+q6Ecke1blGoEePDwxOhvM9fqUx8zUzqtEiCJPTy4TjGEBf18N1Hbys3jClLejEV+QD
         TeYkUBDxjnnoBov+qs5ZreYpk0OfznbTl9ntaJl3ia2ETbbmQHMYQbBcKklxr3SIttBU
         oe44XRPAuhNXi7XPi9RqcJOX0ZJ8zUwpZXJk8JifGgQ6Nf83MFkVlH27AnqQ62hMx+Hw
         JWdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K7khnonYfy4kMw5YrLUdWciangWNF/Rcsht2NfCuP98=;
        b=ILzhmFK/EC+Ibhotp2YM2EKadjA6wuZJJTr58Nt3cf1tXY72ECX07jFpC9Xkppvqo+
         0mnMx7/Uq7AcKlaQQhslQFBwep4mQX3mC6xiivQ959Tod4QiC5ustuDupitCScfu37XD
         78X3QZsYdfw2brH/dSmnce6eQzJ+6RJPastaNgcjFTZSE23UHI/dQ6Odjeq0Twf5ZHzZ
         4RCf/iuiAt7dt8DnINqZaDp3iaFtXdgrspQY8yS74g7wSWJ2yAfFZ6t9A7o0i7zV6UDD
         q5ZuhkdehP3DEkewjUEcXHKS8vVTXSOTHCF2WbWxm2kZ6zk0cvHkMy5EgwHhbnGgtyhG
         UNKA==
X-Gm-Message-State: ANoB5pnkkYnA6yM89m/pvQWJmXGf4UizfDcplPw8/sNVwzBFltv6Fg/7
        e2VMQozMrPwXJyOoc4Acx0ulBpum6mE=
X-Google-Smtp-Source: AA0mqf73XEGmHBsINcaGBgXVrgZEX+L3ujME2ZROjhfpOEDJGxp9qHMfj044jAOBJh9ZlwetXJO9YQ==
X-Received: by 2002:a05:600c:18a1:b0:3cf:a9d5:36c7 with SMTP id x33-20020a05600c18a100b003cfa9d536c7mr34763990wmp.13.1669909167060;
        Thu, 01 Dec 2022 07:39:27 -0800 (PST)
Received: from wlan-cl-kit-cs-172-17-20-201.scc.kit.edu ([2a00:1398:9:fb03:6341:588f:5b6d:9173])
        by smtp.gmail.com with ESMTPSA id fn7-20020a05600c688700b003c6b70a4d69sm5523597wmb.42.2022.12.01.07.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 07:39:26 -0800 (PST)
From:   Peter Maucher <bellosilicio@gmail.com>
To:     alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Peter Maucher <bellosilicio@gmail.com>
Subject: [PATCH 3/3] drm/amdgpu: mention RDNA support in docu
Date:   Thu,  1 Dec 2022 16:38:24 +0100
Message-Id: <20221201153820.257570-4-bellosilicio@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221201153820.257570-1-bellosilicio@gmail.com>
References: <20221201153820.257570-1-bellosilicio@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The amdgpu kernel module has supported RDNA for a while,
mention that in the module description.

Signed-off-by: Peter Maucher <bellosilicio@gmail.com>
---
 Documentation/gpu/amdgpu/index.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gpu/amdgpu/index.rst b/Documentation/gpu/amdgpu/index.rst
index a24e1cfa7407..bcc0f5c15f93 100644
--- a/Documentation/gpu/amdgpu/index.rst
+++ b/Documentation/gpu/amdgpu/index.rst
@@ -3,7 +3,7 @@
 ==========================
 
 The drm/amdgpu driver supports all AMD Radeon GPUs based on the Graphics Core
-Next (GCN) architecture.
+Next (GCN) and Radeon DNA (RDNA) architectures.
 
 .. toctree::
 
-- 
2.38.1

