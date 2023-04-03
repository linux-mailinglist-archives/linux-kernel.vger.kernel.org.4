Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBCE6D533E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 23:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbjDCVQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 17:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233622AbjDCVQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 17:16:01 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7D03A88;
        Mon,  3 Apr 2023 14:15:50 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-17aa62d0a4aso32326296fac.4;
        Mon, 03 Apr 2023 14:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680556550;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=NpVKnNjZqPnaciRstpcfJEnJF/FSckE/C2uZWPWSoEM=;
        b=jt+dhlIWlRFDUG/sB05zs9S+A4hLrear512iIyueIA5WzOHD/WcIpj5LtPMnxzYicK
         enBlhySwrfnV4EcRSHlWIjBkD9ZzEOFUApa4oEP8NkNWi1TfcUcLCo8DPDCJ7cF2mjaw
         KM1+wKtQNNyV+vvtX0/hFFwQWzUBGjefiMOduhA/PNogRKS3T8mp1JrjXYApbtR2sAcQ
         04xaBkRw9raCq9mcfaLmJiZBYgGfboGGAcHhtXse+XWclSp+MwoS8TMhxkK3B9rkl17w
         lSwOD/DbWNgZ68eMciZPYG4foluk0xCrNAiUEouoWeRZYSHyDs4h+tZct0ei5aPdzDiJ
         BiMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680556550;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NpVKnNjZqPnaciRstpcfJEnJF/FSckE/C2uZWPWSoEM=;
        b=UU8Z7p7zmoenx09EsoaTPv6otFqlq1cpm0+EeRA4SyFmXt3G+5NlrCB8w7E9qkaHbk
         E9PV7wgFqGTfXJhDTDUJsDhuQJZDOF1RH+BNpRKqP+2sN2Cnd/yuLZktMG+faFks3l23
         fWF6+UnE6gKzjS4WFP3+xoqwDcrxFL7yIa0bfU1QMk/iv723qD5YSoCSNs9g+c/5TqJd
         u70SoWCoDs6AQMw42okbED3d1HhLhYvuZRRvBb8hYlFOMTmkJO+Ua1F8aDKFrIvCoAWr
         nBOWqNPo7FevjfuUXebavOrIpkXi6y8uDMM/23JruoE7HfwXeulC7kQ8TWRPyPicQFCZ
         nkag==
X-Gm-Message-State: AAQBX9cP7bKxgFB7ueMUhV7rlA64bzQFz6cLqIQOwTFvwC7xYZSqDCKp
        6ussX+kuLLz+zmlwLugldkg=
X-Google-Smtp-Source: AKy350a9eLu5sGGAIn6R83prpRXmQDZ+0DbulKo3DOLiMMqreCrF2ye73tMLJIzrgId1q/tPLMj4gg==
X-Received: by 2002:a05:6870:f148:b0:17a:c838:24d2 with SMTP id l8-20020a056870f14800b0017ac83824d2mr9125848oac.27.1680556549821;
        Mon, 03 Apr 2023 14:15:49 -0700 (PDT)
Received: from grumpy-VECTOR.hsd1.tx.comcast.net ([2601:2c3:480:7390:1f63:ea83:6124:16b4])
        by smtp.gmail.com with ESMTPSA id i21-20020a056871029500b00176209a6d6asm4000869oae.10.2023.04.03.14.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 14:15:49 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7] Introduction-of-HP-BIOSCFG-driver-documentation
Date:   Mon,  3 Apr 2023 16:15:48 -0500
Message-Id: <20230403211548.6253-1-jorge.lopez2@hp.com>
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
Start. Each section provides security feature description and identifies 
sysfs directories and files exposed by the driver.

Many HP Commercial notebooks include a feature called Secure Platform
Management (SPM), which replaces older password-based BIOS settings
management with public key cryptography. PC secure product management
begins when a target system is provisioned with cryptographic keys
that are used to ensure the integrity of communications between system
management utilities and the BIOS.

HP Commercial notebooks have several BIOS settings that control its 
behaviour and capabilities, many of which are related to security. 
To prevent unauthorized changes to these settings, the system can be 
configured to use a cryptographic signature-based authorization string 
that the BIOS will use to verify authorization to modify the setting.

Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>

---
Based on the latest platform-drivers-x86.git/for-next

History

Version 7
	Includes only sysfs-class-firmware-attributes documentation

Version 6
	Breaks down the changes into 4 patches
	SureAdmin-attributes was removed

Version 5
	Remove version 4 patch 1
	Address review changes proposed in Version 4
	Reorganize all patches number and file order
---
 .../testing/sysfs-class-firmware-attributes   | 119 ++++++++++++++++--
 1 file changed, 107 insertions(+), 12 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-firmware-attributes b/Documentation/ABI/testing/sysfs-class-firmware-attributes
index 4cdba3477176..10afbb78baec 100644
--- a/Documentation/ABI/testing/sysfs-class-firmware-attributes
+++ b/Documentation/ABI/testing/sysfs-class-firmware-attributes
@@ -22,6 +22,12 @@ Description:
 			- integer: a range of numerical values
 			- string
 
+		HP specific types
+		-----------------
+			- ordered-list - a set of ordered list valid values
+			- sure-start
+
+
 		All attribute types support the following values:
 
 		current_value:
@@ -42,16 +48,16 @@ Description:
 				description of the at <attr>
 
 		display_name_language_code:
-						A file that can be read to obtain
-						the IETF language tag corresponding to the
-						"display_name" of the <attr>
+				A file that can be read to obtain
+				the IETF language tag corresponding to the
+				"display_name" of the <attr>
 
 		"enumeration"-type specific properties:
 
 		possible_values:
-					A file that can be read to obtain the possible
-					values of the <attr>. Values are separated using
-					semi-colon (``;``).
+				A file that can be read to obtain the possible
+				values of the <attr>. Values are separated using
+				semi-colon (``;``).
 
 		"integer"-type specific properties:
 
@@ -64,8 +70,8 @@ Description:
 				bound value of the <attr>
 
 		scalar_increment:
-					A file that can be read to obtain the scalar value used for
-					increments of current_value this attribute accepts.
+				A file that can be read to obtain the scalar value used for
+				increments of current_value this attribute accepts.
 
 		"string"-type specific properties:
 
@@ -126,6 +132,40 @@ Description:
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
+
 What:		/sys/class/firmware-attributes/*/authentication/
 Date:		February 2021
 KernelVersion:	5.11
@@ -139,8 +179,7 @@ Description:
 		For example a "BIOS Admin" password and "System" Password can be set,
 		reset or cleared using these attributes.
 
-		- An "Admin" password is used for preventing modification to the BIOS
-		  settings.
+		- An "Admin" password is used for preventing modification to the BIOS settings.
 		- A "System" password is required to boot a machine.
 
 		Change in any of these two authentication methods will also generate an
@@ -206,7 +245,7 @@ Description:
 		Drivers may emit a CHANGE uevent when a password is set or unset
 		userspace may check it again.
 
-		On Dell and Lenovo systems, if Admin password is set, then all BIOS attributes
+		On Dell, Lenovo and HP systems, if Admin password is set, then all BIOS attributes
 		require password validation.
 		On Lenovo systems if you change the Admin password the new password is not active until
 		the next boot.
@@ -296,6 +335,15 @@ Description:
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
@@ -311,7 +359,7 @@ Description:
 			==	=========================================
 			0	All BIOS attributes setting are current
 			1	A reboot is necessary to get pending BIOS
-			        attribute changes applied
+				attribute changes applied
 			==	=========================================
 
 		Note, userspace applications need to follow below steps for efficient
@@ -364,3 +412,50 @@ Description:
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
+		RSA public key that will be used by the BIOS to verify signatures when setting
+		the signing key.  When written, the bytes should correspond to the KEK
+		certificate (x509 .DER format containing an OU).  The size of the certificate
+		must be less than or equal to 4095 bytes.
+
+
+What:		/sys/class/firmware-attributes/*/authentication/SPM/sk
+Date:		March 29
+KernelVersion:	5.18
+Contact:	"Jorge Lopez" <jorge.lopez2@hp.com>
+Description:	'sk' Signature Key is a write-only file that can be used to configure the RSA
+		public key that will be used by the BIOS to verify signatures when configuring
+		BIOS settings and security features.  When written, the bytes should correspond
+		to the modulus of the public key.  The exponent is assumed to be 0x10001.
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
+		  Signing Key Public Key Modulus (base64):
+		  KEK Public Key Modulus (base64):
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

