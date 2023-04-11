Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5709B6DE443
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 20:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjDKSrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 14:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjDKSrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 14:47:43 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFC259E0;
        Tue, 11 Apr 2023 11:47:37 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id bm45so402493oib.4;
        Tue, 11 Apr 2023 11:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681238856;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=kk477w1X5WRzFsI1J9lBfe7oTm+OO75NUtps8CJqs0w=;
        b=nPEr2GaeemD9D86mbdw4y/kZkBnw6V7zIcxBhtxwmzBu4md6A8WwUq2b4vzfPKb6js
         7JyXhB9OJwnhb0QsXdgF0P8W1L+qQbOqBR7/C5Qce1E4T9x6gln2AigU0v+bkTByMpxv
         lNdkcdGb30wj/YAXPf6RJOizeKcJ0BZEYc6e2czmz5n0F2ZjBgj15dNCJ6srf3ia6jai
         SYu0Zgn6LRfKYdb6I7YmczgYKydCzc/cHb6lYNhdVzIPwczPi3utTBj6h3Myxi+azkPI
         C53W76gXYuLzTX24TTCZvvz9BMOUYYbLYGXQG/7XDnkrcUjBCbGWSe9gM17UH4v9JiVL
         UqKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681238856;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kk477w1X5WRzFsI1J9lBfe7oTm+OO75NUtps8CJqs0w=;
        b=TfU17abysAp1GnLfJVTol5WoWQrhwYG5p9tJcYEXfvgagaN8JfVdfO/eqSYvhzjq/B
         ULmu2CFHj5tmfX3jIMi8GGJdn4zchShG/10nIhiEx2KPOqBynlU60lXrrN2Nus5/kB82
         A1ePAz5FyxLzqqRJFB2yktTat/EeoEuRiP+/hZJxEVnXLfH8vFc0iqBPNVtUMFkmud12
         i82MDHR22avOxJ8SMDT8/TEmmDuAWyPAtHjYUM4I4hFfwSlsxzdqtAEX0VEYfIbnd7hV
         WQZvjkesxo84h4FRNY97l/QV0EaM5vlZyVS1VSdSxZaS9eCZ7mQCHxNboGaNtEsphqDK
         mdww==
X-Gm-Message-State: AAQBX9f/Krzvs8YXUM/SyQ/rWEjHdCJHO+SegQJ6xbTeDr+RWXbHeycW
        +0Kjid9aqTqcOTdq2G45eXi4yo9v2zg=
X-Google-Smtp-Source: AKy350bhbKuClLWPAR6pCoY/cFQZR5hrEldPIUh9unJdIFLO4niQZV2+pyhkBDL35GAId5Iv8l/Tzg==
X-Received: by 2002:a05:6808:194:b0:387:53ce:4eb3 with SMTP id w20-20020a056808019400b0038753ce4eb3mr4894301oic.48.1681238856255;
        Tue, 11 Apr 2023 11:47:36 -0700 (PDT)
Received: from grumpy-VECTOR.hsd1.tx.comcast.net ([2601:2c3:480:7390:54ed:46b2:3609:5e1a])
        by smtp.gmail.com with ESMTPSA id o7-20020acad707000000b0038b0dd1c040sm5937771oig.3.2023.04.11.11.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 11:47:35 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8] HP BIOSCFG driver - Documentation
Date:   Tue, 11 Apr 2023 13:47:34 -0500
Message-Id: <20230411184734.7011-1-jorge.lopez2@hp.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HP BIOS Configuration driver purpose is to provide a driver supporting
the latest sysfs class firmware attributes framework allowing the user
to change BIOS settings and security solutions on HP Inc.’s commercial
notebooks.

Many features of HP Commercial notebooks can be managed using Windows
Management Instrumentation (WMI). WMI is an implementation of Web-Based
Enterprise Management (WBEM) that provides a standards-based interface
for changing and monitoring system settings. HP BIOSCFG driver provides
a native Linux solution and the exposed features facilitates the
migration to Linux environments.

The Linux security features to be provided in hp-bioscfg driver enables
managing the BIOS settings and security solutions via sysfs, a virtual
filesystem that can be used by user-mode applications. The new
documentation cover features such Secure Platform Management and Sure
Start. Each section provides security feature description and
identifies sysfs directories and files exposed by the driver.

Many HP Commercial notebooks include a feature called Secure Platform
Management (SPM), which replaces older password-based BIOS settings
management with public key cryptography. PC secure product management
begins when a target system is provisioned with cryptographic keys
that are used to ensure the integrity of communications between system
management utilities and the BIOS.

HP Commercial notebooks have several BIOS settings that control its
behaviour and capabilities, many of which are related to security.
To prevent unauthorized changes to these settings, the system can
be configured to use a cryptographic signature-based authorization
string that the BIOS will use to verify authorization to modify the
setting.

Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>

---
Based on the latest platform-drivers-x86.git/for-next

History

Version 8
	Includes only sysfs-class-firmware-attributes documentation

Version 7
	Includes only sysfs-class-firmware-attributes documentation
---
 .../testing/sysfs-class-firmware-attributes   | 104 +++++++++++++++++-
 1 file changed, 103 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-class-firmware-attributes b/Documentation/ABI/testing/sysfs-class-firmware-attributes
index 4cdba3477176..574cdd8a6cc6 100644
--- a/Documentation/ABI/testing/sysfs-class-firmware-attributes
+++ b/Documentation/ABI/testing/sysfs-class-firmware-attributes
@@ -22,6 +22,12 @@ Description:
 			- integer: a range of numerical values
 			- string
 
+		HP specific types
+		-----------------
+			- ordered-list - a set of ordered list valid values
+			- sure-start - report audit logs read from BIOS
+
+
 		All attribute types support the following values:
 
 		current_value:
@@ -126,6 +132,44 @@ Description:
 					value will not be effective through sysfs until this rule is
 					met.
 
+		HP specific class extensions
+		------------------------------
+
+		On HP systems the following additional attributes are available:
+
+		"ordered-list"-type specific properties:
+
+		elements:
+					A file that can be read to obtain the possible
+					list of values of the <attr>. Values are separated using
+					semi-colon (``;``). The order individual elements are listed
+					according to their priority.  An Element listed first has the
+					highest priority. Writing the list in a different order to
+					current_value alters the priority order for the particular
+					attribute.
+
+		"sure-start"-type specific properties:
+
+		audit_log_entries:
+					A read-only file that returns the events in the log.
+					Values are separated using semi-colon (``;``)
+
+					Audit log entry format
+
+					Byte 0-15:   Requested Audit Log entry  (Each Audit log is 16 bytes)
+					Byte 16-127: Unused
+
+		audit_log_entry_count:
+					A read-only file that returns the number of existing audit log events available to be read.
+					Values are separated using comma (``,``)
+
+					[No of entries],[log entry size],[Max number of entries supported]
+
+					log entry size identifies audit log size for the current BIOS version.
+					The current size is 16 bytes but it can be to up to 128 bytes long
+					in future BIOS versions.
+
+
 What:		/sys/class/firmware-attributes/*/authentication/
 Date:		February 2021
 KernelVersion:	5.11
@@ -206,7 +250,7 @@ Description:
 		Drivers may emit a CHANGE uevent when a password is set or unset
 		userspace may check it again.
 
-		On Dell and Lenovo systems, if Admin password is set, then all BIOS attributes
+		On Dell, Lenovo and HP systems, if Admin password is set, then all BIOS attributes
 		require password validation.
 		On Lenovo systems if you change the Admin password the new password is not active until
 		the next boot.
@@ -296,6 +340,15 @@ Description:
 						echo "signature" > authentication/Admin/signature
 						echo "password" > authentication/Admin/certificate_to_password
 
+		HP specific class extensions
+		--------------------------------
+
+		On HP systems the following additional settings are available:
+
+		role: enhanced-bios-auth:
+					This role is specific to Secure Platform Management (SPM) attribute.
+					It requires configuring an endorsement (kek) and signing certificate (sk).
+
 
 What:		/sys/class/firmware-attributes/*/attributes/pending_reboot
 Date:		February 2021
@@ -364,3 +417,52 @@ Description:
 		use it to enable extra debug attributes or BIOS features for testing purposes.
 
 		Note that any changes to this attribute requires a reboot for changes to take effect.
+
+
+		HP specific class extensions - Secure Platform Manager (SPM)
+		--------------------------------
+
+What:		/sys/class/firmware-attributes/*/authentication/SPM/kek
+Date:		March 29
+KernelVersion:	5.18
+Contact:	"Jorge Lopez" <jorge.lopez2@hp.com>
+Description:	'kek' Key-Encryption-Key is a write-only file that can be used to configure the
+		RSA public key that will be used by the BIOS to verify
+		signatures when setting the signing key.  When written,
+		the bytes should correspond to the KEK certificate
+		(x509 .DER format containing an OU).  The size of the
+		certificate must be less than or equal to 4095 bytes.
+
+
+What:		/sys/class/firmware-attributes/*/authentication/SPM/sk
+Date:		March 29
+KernelVersion:	5.18
+Contact:	"Jorge Lopez" <jorge.lopez2@hp.com>
+Description:	'sk' Signature Key is a write-only file that can be used to configure the RSA
+		public key that will be used by the BIOS to verify signatures
+		when configuring BIOS settings and security features.  When
+		written, the bytes should correspond to the modulus of the
+		public key.  The exponent is assumed to be 0x10001.
+
+
+What:		/sys/class/firmware-attributes/*/authentication/SPM/status
+Date:		March 29
+KernelVersion:	5.18
+Contact:	"Jorge Lopez" <jorge.lopez2@hp.com>
+Description:	'status' is a read-only file that returns ASCII text reporting
+		the status information.
+
+		  State:  Not Provisioned / Provisioned / Provisioning in progress
+		  Version:  Major.   Minor
+		  Feature Bit Mask: <16-bit unsigned number display in hex>
+		  SPM Counter: <16-bit unsigned number display in base 10>
+		  Signing Key Public Key Modulus (base64): <256 bytes base64 in hex>
+		  KEK Public Key Modulus (base64): <256 bytes base64 in hex>
+
+
+What:		/sys/class/firmware-attributes/*/authentication/SPM/statusbin
+Date:		March 29
+KernelVersion:	5.18
+Contact:	"Jorge Lopez" <jorge.lopez2@hp.com>
+Description:	'statusbin' is a read-only file that returns identical status
+		information reported by 'status' file in binary format.
-- 
2.34.1

