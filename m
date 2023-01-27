Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEBD67DDE6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 07:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbjA0Gle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 01:41:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbjA0GkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 01:40:23 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679E56DFF7;
        Thu, 26 Jan 2023 22:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Ln37KE47BBRyA/eAdZx39q0YL3EdBd4mcLXFNQP5HLU=; b=svL7mF3zSL0l8ZvDWTYz1UXyeH
        z4k9p1zlUDEFI85bAQeUdYmJ4SOnKmK/ejX0fCMklvB9SVjGajzcFWqJLLa4ZIgvVbKjbco9MRz/i
        XOekELtQ80Kwc/VUCsdCxgAkK9qLASniMy1C+8snwXxXADJNUKoLPfMoKuXhtlmbiq1GINbWF63u9
        s9N3Nv72DuLQe675UiDkToFrk33iaJnEJybZh3rbHnkKVvCzj7BKq17bEgs73zOFzqchMM1jERvZv
        h/Sn3nE3WhbfZOSRlcoi+6b+ePL0d9qjdS2FtJQ6PovP/Fym8G5nVbkJruXGkYcE1e/4iVhEG4P+M
        6jiICmlQ==;
Received: from [2601:1c2:d80:3110::9307] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pLIPN-00DM0u-V5; Fri, 27 Jan 2023 06:40:22 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH 25/35] Documentation: security: correct spelling
Date:   Thu, 26 Jan 2023 22:39:55 -0800
Message-Id: <20230127064005.1558-26-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230127064005.1558-1-rdunlap@infradead.org>
References: <20230127064005.1558-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct spelling problems for Documentation/security/ as reported
by codespell.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: David Howells <dhowells@redhat.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: keyrings@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/security/digsig.rst       |    4 ++--
 Documentation/security/keys/core.rst    |    2 +-
 Documentation/security/secrets/coco.rst |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff -- a/Documentation/security/digsig.rst b/Documentation/security/digsig.rst
--- a/Documentation/security/digsig.rst
+++ b/Documentation/security/digsig.rst
@@ -62,7 +62,7 @@ API currently includes only 1 function::
 	* digsig_verify() - digital signature verification with public key
 	* @keyring:	keyring to search key in
 	* @sig:	digital signature
-	* @sigen:	length of the signature
+	* @siglen:	length of the signature
 	* @data:	data
 	* @datalen:	length of the data
 	* @return:	0 on success, -EINVAL otherwise
@@ -82,7 +82,7 @@ The signing and key management utilities
 to generate signatures, to load keys into the kernel keyring.
 Keys can be in PEM or converted to the kernel format.
 When the key is added to the kernel keyring, the keyid defines the name
-of the key: 5D2B05FC633EE3E8 in the example bellow.
+of the key: 5D2B05FC633EE3E8 in the example below.
 
 Here is example output of the keyctl utility::
 
diff -- a/Documentation/security/keys/core.rst b/Documentation/security/keys/core.rst
--- a/Documentation/security/keys/core.rst
+++ b/Documentation/security/keys/core.rst
@@ -869,7 +869,7 @@ The keyctl syscall functions are:
 
 	 - ``char *hashname`` specifies the NUL terminated string identifying
 	   the hash used from the kernel crypto API and applied for the KDF
-	   operation. The KDF implemenation complies with SP800-56A as well
+	   operation. The KDF implementation complies with SP800-56A as well
 	   as with SP800-108 (the counter KDF).
 
 	 - ``char *otherinfo`` specifies the OtherInfo data as documented in
diff -- a/Documentation/security/secrets/coco.rst b/Documentation/security/secrets/coco.rst
--- a/Documentation/security/secrets/coco.rst
+++ b/Documentation/security/secrets/coco.rst
@@ -34,7 +34,7 @@ be use it for its own purposes.
 
 During the VM's launch, the virtual machine manager may inject a secret to that
 area.  In AMD SEV and SEV-ES this is performed using the
-``KVM_SEV_LAUNCH_SECRET`` command (see [sev]_).  The strucutre of the injected
+``KVM_SEV_LAUNCH_SECRET`` command (see [sev]_).  The structure of the injected
 Guest Owner secret data should be a GUIDed table of secret values; the binary
 format is described in ``drivers/virt/coco/efi_secret/efi_secret.c`` under
 "Structure of the EFI secret area".
