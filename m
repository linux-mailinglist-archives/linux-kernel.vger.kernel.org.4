Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7FD36E7DD9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 17:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233575AbjDSPOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 11:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233475AbjDSPNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 11:13:45 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F125248;
        Wed, 19 Apr 2023 08:13:27 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6a606135408so811323a34.0;
        Wed, 19 Apr 2023 08:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681917206; x=1684509206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2uw6cJJOj4NpjhqsMBl9W9u80TyJYI2izxlDAFaHoDI=;
        b=K3hf2z/3wTqcJjR63j9tYjSNLNs7bCw2RM7cr9rGHJE5H9X3Dh0x9sEnWATYL2eww/
         uwjRLgzbWR2sIHDP+gXzBjEGmt/zSwk39NAHR3moZStJVY61dAnR1cXQKq7faeQN01zQ
         DVCB9jTqaxCQLxLILSOjozS9EBBk+ypAp0WhQRQKB7dFgBNkOYb8uV+9creFVmMoTyTo
         ysWRFqLl/pLytrB5xzR6SFAO3GOoZvtX1PVmAoSGOtV0BBtE5CX8L9DH4FJ5tHu3+sV/
         AlDkxWkI12HnScBFvT+VqnynxdXNsB4H65iHSfR2o0WxBWUV+rP0UAJFq/48jA/pNu4x
         FvRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681917206; x=1684509206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2uw6cJJOj4NpjhqsMBl9W9u80TyJYI2izxlDAFaHoDI=;
        b=UkkHIaIPOECwgSqeghfRRpoIwtWuqZiybOiOXgR1353issCAtm8jaVXA5hcj6WZcIo
         1NjMo+eYczm+LM+vI9nUEW0ux4FG3KcLnPvnmhDOIE7Z21kqY4ZEtsWipPQk8JdmyXWE
         wIDvpF2s1bR076VAQ6h1OXYlg6kgbgVQEt9fZmntOlDr64s4wL1X+LUyx6HCjVsQADOb
         LgLe18CJJekoP2CRkXixioYdyr+RYQ4FO1z+Y2/wX8/H3ThuusYBcgIp62DSrLfzQs8Y
         9wvcNuSmCoOQsUu1aLmf0IGb7MIBFr1gV4rYaplT4sdVcsO+I13Tn6YOqZA4QsBY2M+F
         /pEw==
X-Gm-Message-State: AAQBX9eYKDLsy0OTpLOObbB0domu4hLEELPRa49XiaAAYxwoWoA46PcD
        JnqtuX4W4PT26NdjPYx4MhToHzagc9Q=
X-Google-Smtp-Source: AKy350bAaJPXZHFKqVsQHi1Xj0d8KDm9tCtlXbnWA+Ro3VpvJRQzXh3ZnECNo0Hjq+A7nP95GXBsFw==
X-Received: by 2002:a9d:77d9:0:b0:6a6:1691:aec7 with SMTP id w25-20020a9d77d9000000b006a61691aec7mr23896otl.10.1681917206280;
        Wed, 19 Apr 2023 08:13:26 -0700 (PDT)
Received: from grumpy-VECTOR.hsd1.tx.comcast.net ([2601:2c3:480:7390:e175:6963:338:7453])
        by smtp.gmail.com with ESMTPSA id f17-20020a056830205100b00690e990e61asm4308842otp.14.2023.04.19.08.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 08:13:26 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v10 01/14] HP BIOSCFG driver - Documentation
Date:   Wed, 19 Apr 2023 10:13:08 -0500
Message-Id: <20230419151321.6167-2-jorge.lopez2@hp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230419151321.6167-1-jorge.lopez2@hp.com>
References: <20230419151321.6167-1-jorge.lopez2@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
documentation cover HP-specific firmware sysfs attributes such Secure
Platform Management and Sure Start. Each section provides security
feature description and identifies sysfs directories and files exposed
by the driver.

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

Linux Security components are under development and not published yet.
The only linux component is the driver (hp bioscfg) at this time.
Other published security components are under Windows.

Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>

---
Based on the latest platform-drivers-x86.git/for-next
---
 .../testing/sysfs-class-firmware-attributes   | 98 ++++++++++++++++++-
 1 file changed, 96 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-firmware-attributes b/Documentation/ABI/testing/sysfs-class-firmware-attributes
index 4cdba3477176..73d7b8fbc0b2 100644
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
@@ -311,7 +364,7 @@ Description:
 			==	=========================================
 			0	All BIOS attributes setting are current
 			1	A reboot is necessary to get pending BIOS
-			        attribute changes applied
+				attribute changes applied
 			==	=========================================
 
 		Note, userspace applications need to follow below steps for efficient
@@ -364,3 +417,44 @@ Description:
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
+Description:	'status' is a read-only file that returns ASCII text in JSON format reporting
+		the status information.
+
+		  "State": "not provisioned | provisioned | provisioning in progress ",
+		  "Version": " Major. Minor ",
+		  "Nonce": <16-bit unsigned number display in base 10>,
+		  "FeaturesInUse": <16-bit unsigned number display in base 10>,
+		  "EndorsementKeyMod": "<256 bytes in base64>",
+		  "SigningKeyMod": "<256 bytes in base64>"
-- 
2.34.1

