Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57895FD400
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 06:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiJME4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 00:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiJME4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 00:56:22 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233E3110B30
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 21:56:22 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id fw14so939193pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 21:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6JdZXonRGX8Hfi2tA5W8xbQxDC6wNyFwR/Pij279WU4=;
        b=5sr/GMYQpyzqszchYrjFbOSV1TLylIpkH1N3EmYlvQUd4smNELnzPqJKIFStcIhXam
         rZflGCl09879gMzwL19EzqrAQ6FZ/XqixD+9QCL7WfuDdurYuikpjh4dLuN9F2iDcS65
         uTgI7p+Al0UMieVL0WEzIZGokWjqqpUQub0MRgyRVwKNv7aUEiHqOmDPpW3tyqOoDkf9
         pG856gTbdev0qRRZhdPFkGEvz8hFS+g7ij4Yjyf9RIx8AAT4IkuGsuTqHcNnFgXYx5Dw
         3ND+3/XU2wM3f8MojuJpfeOj8xySRV3PhVF8mVFCSGB94SLd6DZCUAR9b2uJnviK089f
         LcCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6JdZXonRGX8Hfi2tA5W8xbQxDC6wNyFwR/Pij279WU4=;
        b=Ej0ZyECqNs2WGVunOMi/b1tgBqpwZffj3swUI5+LAlFUV3ilev6q7pbPdvX6MeKndG
         l0wll8c6TajDAXynICmqYEDLeBsXqf4QiMEXn8cF02F/yR9E9YGCL5Pajf8wTanmx+LC
         2qWUcWlDe4TRiG69Hx/0GjSRXQF01a0bY8lYqxIJhEkMyngzLuIN6DpQj1zoF+fo9xpC
         wPJOKCw+pm4arRc90or3l2wBWIhXhR7eGJSNzNN4TMIe6ApEh9hkFKWw0WZGXam08g8w
         zntpZ5LhV0opSjvG3Wv3hXe+hUZiVG1qA2ycnRPs3XG5qOFZW37BCt6SLex+mnOjEgXi
         8nng==
X-Gm-Message-State: ACrzQf0cQAEEx4W9rbXH4H+A3RMCjYkBaup3LaM/te+ht0thPLhJtCsJ
        NUfNfi+Zg+TZoZeCRnCLiSSwLw==
X-Google-Smtp-Source: AMsMyM41jgEKKfgOWeqLGdNsraNVlcTIzlNFWYcPyZMeo+1TAJoaFl3FK32Y8DyfJ5HhRRQgcTfphw==
X-Received: by 2002:a17:90b:1d8a:b0:20c:a6db:5713 with SMTP id pf10-20020a17090b1d8a00b0020ca6db5713mr9130520pjb.135.1665636981571;
        Wed, 12 Oct 2022 21:56:21 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id c12-20020a6566cc000000b0046ae5cfc3d5sm1519896pgw.61.2022.10.12.21.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 21:56:21 -0700 (PDT)
Subject: [PATCH 1/4] Documentation: RISC-V: Fix a typo in patch-acceptance
Date:   Wed, 12 Oct 2022 21:56:16 -0700
Message-Id: <20221013045619.18906-2-palmer@rivosinc.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221013045619.18906-1-palmer@rivosinc.com>
References: <20221013045619.18906-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     corbet@lwn.net, Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        conor.dooley@microchip.com, Atish Patra <atishp@rivosinc.com>,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux@rivosinc.com,
        Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Conor Dooley <conor@kernel.org>, Atish Patra <atishp@rivosinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmer@rivosinc.com>

I just stumbled on this when modifying the docs.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 Documentation/riscv/patch-acceptance.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/riscv/patch-acceptance.rst b/Documentation/riscv/patch-acceptance.rst
index dfe0ac5624fb..5da6f9b273d6 100644
--- a/Documentation/riscv/patch-acceptance.rst
+++ b/Documentation/riscv/patch-acceptance.rst
@@ -29,7 +29,7 @@ their own custom extensions.  These custom extensions aren't required
 to go through any review or ratification process by the RISC-V
 Foundation.  To avoid the maintenance complexity and potential
 performance impact of adding kernel code for implementor-specific
-RISC-V extensions, we'll only to accept patches for extensions that
+RISC-V extensions, we'll only accept patches for extensions that
 have been officially frozen or ratified by the RISC-V Foundation.
 (Implementors, may, of course, maintain their own Linux kernel trees
 containing code for any custom extensions that they wish.)
-- 
2.38.0

