Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA898674722
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 00:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjASXXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 18:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjASXXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 18:23:34 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249BCC2;
        Thu, 19 Jan 2023 15:23:32 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id ud5so9853073ejc.4;
        Thu, 19 Jan 2023 15:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8DGpgiYGDw6FkTW7tBePouJaM0hNgJ2GPhgSnYe3qzM=;
        b=dxFittEFd7ZZTeIUxCkcyFFbtWAGVpLauvBjmr39x4O8whTZd5VinA1geQ7tFl0KIx
         lsiSASLn+IkCZIIuSXcHfOXmgoOUDHGpFYgFsXtQngWlUyqJ15z0Yeh0y0YJEJIPvCCN
         Xo/QYqrmgJT2sEe4eb4Ki2d1TW1hlJX4uaZ9GS40aVrbUlSwEcl+XEJuqOXFozH5FHlv
         x/f5ZhFuxOacFWR1pAwlo6HhC6ZhFCfwlHvRVmD4CFOQXUe4k3tuAncWOVI4bF4UUrKY
         7d58swG3RvDjM0sPw6k+r5MjP+X3WO0BCny0ze6+pN51C7FrL2tzpbdk+f5hzAzt2qEl
         3ncA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8DGpgiYGDw6FkTW7tBePouJaM0hNgJ2GPhgSnYe3qzM=;
        b=duIKhr2D/mDgCwdNHbnEcwJyFHQZ+0BQ/VsSE5K13Z3y3MHDkaB9ABMQVX9nMoHo3O
         yjRmAcFSoRVQnF8zgJlPR02IbNAfazJqLcuKHgwCRAkufyyOkwMmIK+AEYhJnaVoPoHS
         YpFBT23ATGkAap58h4WrJ03ENlDlOn1enVFkwUhzGxlx5UpR1p8OqCNZBShQ041N4koC
         WtJom8sjAfgUcT1spTZ0CVVNiL98HCNr33XJG/ErVAHushSoWwGV5Hu1PTiV5mwkbV4/
         Cy+ty3bfEPKy1dmC10hZdA/L3WYSLkCbv9S5FARxifyyHZTE3nkcHKWj+4GZm+fUZrr4
         uYOg==
X-Gm-Message-State: AFqh2kqfnB6rlgTiIpPPtKpfDN1B04Cj+E+cZWOmPzpA9aYoEQkGPK2/
        YsF9YWbce8dzJpl8C9Wp+clGkdb8PXXs6Q==
X-Google-Smtp-Source: AMrXdXttdOs/ggl9oW7qjKrudW7xZqvfwUgElT+nvQ8eQGO5ZzoWD8ZmYz3V0yVDFSC7ZGgWOv0+hw==
X-Received: by 2002:a17:906:5417:b0:877:5dbc:da84 with SMTP id q23-20020a170906541700b008775dbcda84mr7962484ejo.72.1674170610747;
        Thu, 19 Jan 2023 15:23:30 -0800 (PST)
Received: from [127.0.1.1] (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id u21-20020a1709064ad500b00855d6ed60desm13093390ejt.192.2023.01.19.15.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 15:23:30 -0800 (PST)
From:   Jakob Koschel <jkl820.git@gmail.com>
Date:   Fri, 20 Jan 2023 00:23:20 +0100
Subject: [PATCH v2] docs/scripts/gdb: add necessary make scripts_gdb step
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230112-documentation-gdb-v2-1-292785c43dc9@gmail.com>
X-B4-Tracking: v=1; b=H4sIAOjQyWMC/32NTQ7CIBBGr2JmLQamtkldeQ/TxQDTlkTAADaap
 neX9gAu3/eTt0Lm5DjD7bRC4sVlF0MFPJ/AzBQmFs5WBpTYSKVQ2GjenkOhUpdislrQKKXFRqPu
 JNSfpsxCJwpm3p+ecuG0F6/Eo/scssdQeXa5xPQ93Iva03+aRQklZE+6bTvuFV7vkyf3vJjoYdi
 27QeRjaPQywAAAA==
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakob Koschel <jkl820.git@gmail.com>
X-Mailer: b4 0.11.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1674170610; l=1456;
 i=jkl820.git@gmail.com; s=20230112; h=from:subject:message-id;
 bh=3W6+W19na9oCoUtm0oHRdq58UYpKhHaVRjP5Hz+vctc=;
 b=wdTEA3IYp4TiRylTeGZWzhOPiS9maBfDgZagABMYNhDcNwA2fQ4xAM0NFEwou8IoM5BvRLrm7l1I
 RAMWwMlPAxAkDPfXF3fuNQISCwMyESSZvUsdR4c8qREHJmVBitMB
X-Developer-Key: i=jkl820.git@gmail.com; a=ed25519;
 pk=rcRpP90oZXet9udPj+2yOibfz31aYv8tpf0+ZYOQhyA=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to debug the kernel successfully with gdb you need to run
'make scripts_gdb' nowadays.

This was changed with the following commit:

Commit 67274c083438340ad16c ("scripts/gdb: delay generation of gdb
constants.py")

In order to have a complete guide for beginners this remark
should be added to the offial documentation.

Signed-off-by: Jakob Koschel <jkl820.git@gmail.com>
---
Changes in v2:
- Add correct Signed-off-by
- Link to v1: https://lore.kernel.org/r/20230112-documentation-gdb-v1-1-09ab556e9124@gmail.com
---
 Documentation/dev-tools/gdb-kernel-debugging.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/dev-tools/gdb-kernel-debugging.rst b/Documentation/dev-tools/gdb-kernel-debugging.rst
index 8e0f1fe8d17a..895285c037c7 100644
--- a/Documentation/dev-tools/gdb-kernel-debugging.rst
+++ b/Documentation/dev-tools/gdb-kernel-debugging.rst
@@ -39,6 +39,10 @@ Setup
   this mode. In this case, you should build the kernel with
   CONFIG_RANDOMIZE_BASE disabled if the architecture supports KASLR.
 
+- Build the gdb scripts (required on kernels v5.1 and above)::
+
+    make scripts_gdb
+
 - Enable the gdb stub of QEMU/KVM, either
 
     - at VM startup time by appending "-s" to the QEMU command line

---
base-commit: c757fc92a3f73734872c7793b97f06434773d65d
change-id: 20230112-documentation-gdb-af00d23b2b60

Best regards,
-- 
Jakob Koschel <jkl820.git@gmail.com>
