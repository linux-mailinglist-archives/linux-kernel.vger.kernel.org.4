Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015066E32F1
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 19:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjDORiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 13:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjDORiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 13:38:19 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058E755B1;
        Sat, 15 Apr 2023 10:37:35 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id xd13so19666674ejb.4;
        Sat, 15 Apr 2023 10:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681580252; x=1684172252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LjLF8YJVlIoAVrd1Wc6EQsJn6IlLs+osyJa+45a2H+4=;
        b=oUXO8xfkcdjlTNarUAttjz4iKfRgUqUoQF8hZnkRSGRMulnqzN1ut6yrYdLXtnwixu
         mMa/b0DQ0aMcpVVtf+IFKipOSGtpHMU0fD2ZyarfAx1hL7bYGl5P3SmuHmjAoi45L2LF
         obhlm32zXABsQKFRaQgth1xFqG//E9loWeTS3oejfcLgUhCSN3DdPFtcKKM3YDlx4zZd
         +N3V5h7h4iPDWekAd4OGFdXHNLwJkxNt4oInz7qboX9vdhGSOKBILc/KhTmhQoyVdW1v
         sIOAnLsCb+Tv9pUyayQcXub6wWZk+kq+JYilPIIQ3Drp8xYNIaXy9HMTD8Ss+uLtskeO
         nw9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681580252; x=1684172252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LjLF8YJVlIoAVrd1Wc6EQsJn6IlLs+osyJa+45a2H+4=;
        b=UYyqaeAqN8gKVyZ6KvleCiuFVG+Ef2K/J6NDJ6r8xOFdhGliKq3S+DrwK2QlCgJcmw
         IkPNvsL5MBRyr3xhrqBieN7BxYVv1c1F6m4rru0akOLOqtTa1WAoisgUWVKJhxrHcxmi
         Laum8ir1eosDAl1ngLoMfMF9aDDFtqUHCUsyOFZ5yf7dz4GvZor5sKzV4jg3zdtvgnos
         xrDEV10kkAbb+t+ZJIa4vpIJAEEypSGtrkkz3PNGYE0Pl8BgOpmkO/zvBwbq5X5/J/Iy
         4D6H1ncrlaOBPw982Kjc7EBIew64BlPMCNpCzGE8/hw8E0n6j6aW/7+JwGgurmhnXfKO
         EESg==
X-Gm-Message-State: AAQBX9dzR0vxSvArO4i6aIgycT0/GufHx4VdDDK8fYfD/a7pRxCFB+O4
        3zg3QnR55KZugB4vcZSeMg==
X-Google-Smtp-Source: AKy350YxWwyqQk5FrYeHnmlYnbJge+4Kr9B5W6bmfsiMjFD6IZgFX7N+doEG9Vb9JQfg0ltY/DelJQ==
X-Received: by 2002:a17:906:5502:b0:94f:ca5:c437 with SMTP id r2-20020a170906550200b0094f0ca5c437mr2818304ejp.24.1681580251723;
        Sat, 15 Apr 2023 10:37:31 -0700 (PDT)
Received: from p183 ([46.53.250.148])
        by smtp.gmail.com with ESMTPSA id p25-20020a17090635d900b0094e75d3ba1bsm4054490ejb.131.2023.04.15.10.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 10:37:31 -0700 (PDT)
Date:   Sat, 15 Apr 2023 20:37:29 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v3] ELF: document some de-facto PT_* ABI quirks
Message-ID: <88d3f1bb-f4e0-4c40-9304-3843513a1262@p183>
References: <2acb586c-08a9-42d9-a41e-7986cc1383ea@p183>
 <e262ea00-a027-9073-812e-7e034d75e718@infradead.org>
 <c4233c97-306c-4db8-9667-34fc31ec4aed@p183>
 <87edp7jyu4.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87edp7jyu4.fsf@meer.lwn.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Turns out rules about PT_INTERP, PT_GNU_STACK and PT_GNU_PROPERTY
program headers are slightly different.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

	v3: move to Documentation/userspace-api/
	v2: integrate into documentation build system

 Documentation/userspace-api/ELF.rst   |   34 ++++++++++++++++++++++++++++++++++
 Documentation/userspace-api/index.rst |    1 +
 2 files changed, 35 insertions(+)

new file mode 100644
--- /dev/null
+++ b/Documentation/userspace-api/ELF.rst
@@ -0,0 +1,34 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=================================
+Linux-specific ELF idiosyncrasies
+=================================
+
+Definitions
+===========
+
+"First" program header is the one with the smallest offset in the file:
+e_phoff.
+
+"Last" program header is the one with the biggest offset in the file:
+e_phoff + (e_phnum - 1) * sizeof(Elf_Phdr).
+
+PT_INTERP
+=========
+
+First PT_INTERP program header is used to locate the filename of ELF
+interpreter. Other PT_INTERP headers are ignored (since Linux 2.4.11).
+
+PT_GNU_STACK
+============
+
+Last PT_GNU_STACK program header defines userspace stack executability
+(since Linux 2.6.6). Other PT_GNU_STACK headers are ignored.
+
+PT_GNU_PROPERTY
+===============
+
+ELF interpreter's last PT_GNU_PROPERTY program header is used (since
+Linux 5.8). If interpreter doesn't have one, then the last PT_GNU_PROPERTY
+program header of an executable is used. Other PT_GNU_PROPERTY headers
+are ignored.
--- a/Documentation/userspace-api/index.rst
+++ b/Documentation/userspace-api/index.rst
@@ -23,6 +23,7 @@ place where this information is gathered.
    spec_ctrl
    accelerators/ocxl
    ebpf/index
+   ELF
    ioctl/index
    iommu
    iommufd
