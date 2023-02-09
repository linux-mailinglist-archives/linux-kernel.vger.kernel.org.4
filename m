Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6479B6900FE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 08:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjBIHPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 02:15:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjBIHON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 02:14:13 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381303C28;
        Wed,  8 Feb 2023 23:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=1UCwqKkdi+iMeKnxe2a0f+agmuR5eX82xtKDbJBG/eQ=; b=uqCYr9QPZeK/DAmoWVOcS1RDUS
        Jes9PXFPB1yY7BQtSqs6/kYb0MMFUWyAkacZF5AVuDDK8HNHn2ilBmgw4udBOiufuCzP5aYrGg41o
        Jo434Nad39spPEJckwdOHOZ69rFXrY17CQB+WKhL4C2zBhAOfI89TbvMCF977OjOBCUYQuvOBW0n2
        zmrVjHy9F5roJy8rayt0RLlR+MKvpYGO6EMuzHz7F84CNoub2EyyjaNnlyodpjwjG7lrLGoUEnGDC
        eXaOX2fx9bUfHr+KIiNbjSmNIFAVpQX2MR7pgqN48eXyJZ+5MMAY1Nt+5hCRZn4UwDf0jNZ+8hsZz
        hBfIoJhw==;
Received: from [2601:1c2:980:9ec0::df2f] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pQ18F-000LPt-Pv; Thu, 09 Feb 2023 07:14:11 +0000
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
Subject: [PATCH 17/24] Documentation: security: correct spelling
Date:   Wed,  8 Feb 2023 23:13:53 -0800
Message-Id: <20230209071400.31476-18-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230209071400.31476-1-rdunlap@infradead.org>
References: <20230209071400.31476-1-rdunlap@infradead.org>
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
Reviewed-by: David Howells <dhowells@redhat.com>
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
