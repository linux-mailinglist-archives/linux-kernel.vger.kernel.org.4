Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6649A6FEACD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 06:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236759AbjEKEjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 00:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236620AbjEKEjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 00:39:03 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFF94C3E;
        Wed, 10 May 2023 21:39:00 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6439d505274so4797565b3a.0;
        Wed, 10 May 2023 21:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683779940; x=1686371940;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NfPVn5olpqaJ9gF1uVFBdyzllvA5roFYhnWM8hmvvQs=;
        b=CM2a/lbq36x13q65iqDwkGGnCpC6151bIAR/XQPvlA8z+Y6wKEd+Nha4w5xrFs44c1
         H3TY0uUqVGkNT5yVmPS25lxl0Ta9fTqjSwH+v6Anb+zWV3xkwqA0cT1fGAZdxKPX70oP
         4P79mAd17GqG/uU2P4h8nS47QRJK0omdBXdfRZ2WcCuFKBvC8ZCenZa/Zj2x6h9gQuyK
         8hZ1kwDHppvJ6rKpsYi7uB20mAyMvlm539JG9spgQZLJjP0lkGsrtV0L1UVqAoPhPCRi
         kLVkXxtEfOFsSbZFceOA+USKon1SCIEghEDU3aBULWHRHWX61zVmQui0mRm/2Gek26AT
         QA0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683779940; x=1686371940;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NfPVn5olpqaJ9gF1uVFBdyzllvA5roFYhnWM8hmvvQs=;
        b=ZnCPgmKEfRtB6KUIL2OdfpkIGrTl6wI8TSTp1KOyQpN3GvXUODwIRepY42ZEh9D2I6
         3Y5bb5bRVAu1LXoiIoSTU3mRLbgmu7NKwb0MF+n5WnVUx5KHTUQ77XT3mv7+3db0KzEz
         q+Tqiptq9B8zr+pmYSRyw/pAZ5Q0PHxXxvRcsfE3zjd6jrrD+xGL1WC5Vq72dhHZeer2
         M4E8uDgPG7jTq9z+UiLw4wadUxg256rEGkIj6E5ARhbQ4LuPsP5y7hPLjv4nVUWqvuMs
         AKKMmYpqQk6wu7SMjQF5WmA1DN8JUqjKZPZTOzZVj7W858i/0WoHh9hfPS+gWLz5e/d/
         94ww==
X-Gm-Message-State: AC+VfDzDol05Umo/2AG/3vgjMQZ4dyDBheNN9oVo0UuH9wadBhpGuM5U
        MEydZmnXUA4NoUiL7tEa+bE=
X-Google-Smtp-Source: ACHHUZ5sRVAXm3qGSvE+1Rday563eVVSMrEr5tsVUTa4o9ro6yWRvwUwJUnRr1BQi0R40oBd8GQIOg==
X-Received: by 2002:a05:6a20:7d8d:b0:101:166:863f with SMTP id v13-20020a056a207d8d00b001010166863fmr13020204pzj.23.1683779939585;
        Wed, 10 May 2023 21:38:59 -0700 (PDT)
Received: from debian.me (subs09a-223-255-225-70.three.co.id. [223.255.225.70])
        by smtp.gmail.com with ESMTPSA id h5-20020a62b405000000b0063932e36437sm4319779pfn.134.2023.05.10.21.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 21:38:59 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 852CF106772; Thu, 11 May 2023 11:38:55 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux Keyrings <keyrings@vger.kernel.org>,
        Linux Kernel Build System <linux-kbuild@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH] Documentation: module-signing: Mention default_x509.genkey template
Date:   Thu, 11 May 2023 11:38:52 +0700
Message-Id: <20230511043852.25803-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3450; i=bagasdotme@gmail.com; h=from:subject; bh=KYJZUTwEc47lOKWrdoWj83OI1aAJrI5PpPp4KRuKUhk=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDCkxhaGrj8yYspKtJX1CWdIUEetLucbtZXt6eTLdr7HES +7adFm0o5SFQYyLQVZMkWVSIl/T6V1GIhfa1zrCzGFlAhnCwMUpABNx2M7I0N/T/uBeTb02h/0B udttJ9kfN3zfqZY6mUlK04/lfrDTeob/MT9z2xM/nS3QbfLYp3zgzsJn9cwyj55te7D+ew7/mY1 3WQA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit f3a2ba44e93e2c ("certs: check-in the default x509 config file")
adds default x509 keypair config file template, but forgets to mention
it in kernel module signing documentation. Update the doc accordingly.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/admin-guide/module-signing.rst | 41 ++++++++------------
 1 file changed, 17 insertions(+), 24 deletions(-)

diff --git a/Documentation/admin-guide/module-signing.rst b/Documentation/admin-guide/module-signing.rst
index 7d7c7c8a545ca6..365d60a6245f17 100644
--- a/Documentation/admin-guide/module-signing.rst
+++ b/Documentation/admin-guide/module-signing.rst
@@ -133,46 +133,39 @@ kernel so that it can be used to check the signatures as the modules are
 loaded.
 
 Under normal conditions, when ``CONFIG_MODULE_SIG_KEY`` is unchanged from its
-default, the kernel build will automatically generate a new keypair using
-openssl if one does not exist in the file::
-
-	certs/signing_key.pem
-
+default, the kernel build will automatically generate a new keypair in
+``certs/signing_key.pem`` using openssl if it doesn't exist,
 during the building of vmlinux (the public part of the key needs to be built
-into vmlinux) using parameters in the::
-
-	certs/x509.genkey
-
+into vmlinux) using parameters in the ``certs/x509.genkey`` configuration
 file (which is also generated if it does not already exist).
 
-It is strongly recommended that you provide your own x509.genkey file.
-
-Most notably, in the x509.genkey file, the req_distinguished_name section
-should be altered from the default::
+If you'd like to provide alternative configuration, copy
+``certs/default_x509.genkey`` to ``certs/x509.genkey`` and edit the copy
+instead. Most likely, you will want to edit the ``req_distinguished_name``
+section, which identifies the resulting keypair. For example::
 
 	[ req_distinguished_name ]
-	#O = Unspecified company
-	CN = Build time autogenerated kernel key
-	#emailAddress = unspecified.user@unspecified.company
+	O = Example company
+	CN = Example kernel build
+	emailAddress = user@example.com
 
 The generated RSA key size can also be set with::
 
 	[ req ]
 	default_bits = 4096
 
-
-It is also possible to manually generate the key private/public files using the
-x509.genkey key generation configuration file in the root node of the Linux
-kernel sources tree and the openssl command.  The following is an example to
-generate the public/private key files::
+Optionally, you can also manually generate the keypair so that the same
+keypair can be used in multiple builds. To generate it::
 
 	openssl req -new -nodes -utf8 -sha256 -days 36500 -batch -x509 \
 	   -config x509.genkey -outform PEM -out kernel_key.pem \
 	   -keyout kernel_key.pem
 
-The full pathname for the resulting kernel_key.pem file can then be specified
-in the ``CONFIG_MODULE_SIG_KEY`` option, and the certificate and key therein will
-be used instead of an autogenerated keypair.
+See :manpage:`openssl-req(1)` for the explanation.
+
+The full pathname for the resulting ``kernel_key.pem`` file can then be
+specified in the ``CONFIG_MODULE_SIG_KEY`` option, and the certificate and key
+therein will be used instead of an autogenerated keypair.
 
 
 =========================

base-commit: ac9a78681b921877518763ba0e89202254349d1b
-- 
An old man doll... just what I always wanted! - Clara

