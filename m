Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0665FBBC3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 22:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiJKUEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 16:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiJKUEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 16:04:24 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233009B851;
        Tue, 11 Oct 2022 13:04:22 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 70so13410548pjo.4;
        Tue, 11 Oct 2022 13:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1mcFLXqtRl0XJ50RmZ7UiVHxAaM7FNqJT26e3F2Iovs=;
        b=pr34KmSm2oM6GYfvByyfdEbzQzCE89LbBGnfn2eGNl3Ozw7NvncnPS58wHRCqrlnxS
         yaWJmkq9b3rgVDHlGRl3t+iY7ZPyNFKaSsiAHhrvbnqwulA4O7bYDCCetJ61+4njJ3Ne
         sVkZ9MUWsvhpfmHiddFKj76qxABN42cm/SnjUy2Mv66Wl+KSAvMu6Xs7BSD5w77y1rGf
         34ecURlSlxApKgSVRyg8d2x5A6yQ0hkEkSYbVHRjJA2qpMTryIqXsyFsC0zx1mPx/tB4
         bM99BaV2/yEiq9zyU+fmS2+q0ix2X9+qjP0zUGDidiIc1kgIy8TKrW0mP5pAFkFS6lYf
         XRwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1mcFLXqtRl0XJ50RmZ7UiVHxAaM7FNqJT26e3F2Iovs=;
        b=22Cood6Uu63ckv9hvNfy45DvL19+nYxljSU7eiPUuUO3sHhlgctGSt0C7osnf/WEJV
         WUAaD4GRZUoBYjsx4aNQnVduA44ZXH4K+0lvEevr+UGGX91QT5kbMKQnehC2mQnt4FfU
         rl/4FXXdPJDPXNWMNR349OUQMOGoRYlEUDQpwuJSfTgokFOzajVSQdpRWV0EXY9cCNsz
         vM52NuPwXu7InDjdo4mE3mTCIMKAXRMfx1Y19rnCfwVt/LQ4L+fGpavHk7MGUYgdrqLw
         V8SfAWeZQ7082T+7xwhnzJ2ak51fu9TSr19k4Pv9qCLiKxQLKcsPNU3qOHggADM/Uti4
         nnKQ==
X-Gm-Message-State: ACrzQf2FLh8HkP6PH+5UAjm8NLnlCM35yF4lJ5v+//pLclPsWW7iHfl9
        VNGvZ7AtBQNB2iQhkZob9DwRmY+igyjDgw==
X-Google-Smtp-Source: AMsMyM7oxB+GXhhjKdUbdC7MsY+skrJqg7L39sa8j1qeR4QTdEcix2nUt1DvbVTvH5KiCUhapuKXIQ==
X-Received: by 2002:a17:90b:1d88:b0:20d:7449:c0ef with SMTP id pf8-20020a17090b1d8800b0020d7449c0efmr905477pjb.103.1665518661683;
        Tue, 11 Oct 2022 13:04:21 -0700 (PDT)
Received: from mail.google.com (122-58-209-93-fibre.sparkbb.co.nz. [122.58.209.93])
        by smtp.gmail.com with ESMTPSA id r10-20020aa7988a000000b00561f8fdba8esm9715166pfl.12.2022.10.11.13.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 13:04:20 -0700 (PDT)
Date:   Wed, 12 Oct 2022 09:04:15 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     Christine Caulfield <ccaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>, cluster-devel@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        paulo.miguel.almeida.rodenas@gmail.com
Subject: [PATCH v4] [next] dlm: replace one-element array with fixed size
 array
Message-ID: <Y0XMP2RMkE4MWNPE@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0W5jkiXUkpNl4ap@mail.google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One-element arrays are deprecated. So, replace one-element array with
fixed size array member in struct dlm_ls, and refactor the rest of the
code, accordingly.

Link: https://github.com/KSPP/linux/issues/79
Link: https://github.com/KSPP/linux/issues/228
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101836
Link: https://lore.kernel.org/lkml/Y0W5jkiXUkpNl4ap@mail.google.com/

Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
---
Changelog:

v4: resend patch using the right version number. Req: Gustavo Silva
v3: replace one-element array with a fixed size array. Req: Kees Cook
v2: patch resent as I had an issue with a <CRLF> char in my mail client
v1: https://lore.kernel.org/lkml/Y0ICbf8tCtXMn+W0@mail.google.com/
---
 fs/dlm/dlm_internal.h | 2 +-
 fs/dlm/lockspace.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/dlm/dlm_internal.h b/fs/dlm/dlm_internal.h
index e34c3d2639a5..94fadb619ba0 100644
--- a/fs/dlm/dlm_internal.h
+++ b/fs/dlm/dlm_internal.h
@@ -670,7 +670,7 @@ struct dlm_ls {
 	void			*ls_ops_arg;
 
 	int			ls_namelen;
-	char			ls_name[1];
+	char			ls_name[DLM_LOCKSPACE_LEN + 1];
 };
 
 /*
diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index bae050df7abf..23de0d47cbc1 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -473,7 +473,7 @@ static int new_lockspace(const char *name, const char *cluster,
 
 	error = -ENOMEM;
 
-	ls = kzalloc(sizeof(struct dlm_ls) + namelen, GFP_NOFS);
+	ls = kzalloc(sizeof(struct dlm_ls), GFP_NOFS);
 	if (!ls)
 		goto out;
 	memcpy(ls->ls_name, name, namelen);
-- 
2.37.3

