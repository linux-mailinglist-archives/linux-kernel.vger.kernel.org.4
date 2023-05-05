Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A036F8C10
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 00:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjEEWAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 18:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjEEWAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 18:00:48 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D99270C;
        Fri,  5 May 2023 15:00:47 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6a5f7341850so1591678a34.2;
        Fri, 05 May 2023 15:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683324046; x=1685916046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+iZ6JL4uG1SLbfPZr+EBWIfVhF0lccjWxezzblVL1m0=;
        b=cJRbH6YFXJt3ZUOCa3FS16RlApPI2FNpYZDLQB1Dx1u9T8tCY4tq0g2AETvlH57uhd
         GCLPRn/+mA8ZXuH+TfdDbCNF9FaOY7iXs7nnC1aiyWlM8WZMja9JcG0o1iFF6bqPj8aR
         yimboeUuzJjUs0KMkKSjJL9BA/afSA3eGnL1qv8lISePaU2LCFjNohg7b/WziDt96JU9
         cYqMQUdK2F0HvKqbF82gk9QXxqGTwWaaZDffTPCw/ZARWa6rEQs/xbUSuQWOQBbeBffF
         GyTh94Et11ftqRQqNyTD/x/7TWo1Uon3Ej2VJ9ezgMHMF58dHAGgLJVk8dhoNxmfFYEN
         ZzqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683324046; x=1685916046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+iZ6JL4uG1SLbfPZr+EBWIfVhF0lccjWxezzblVL1m0=;
        b=l48D+HHyP3koMBgjzSIVKbAftxLJ7blryoXi36I6VeL8184uflm5ouIfexlTa4qmjt
         sPhPEuLnxV5ZDnGQU6iaT5d4111931FiJvnD9A5ejjFmef+BMMbtPpP6o4btJ8AUeC7K
         +aYzi49xLPAz34WNdD5wRFLP0VlVh1yDikzBBpiqeOI3MrcRZZvYFex1+Hxs0+PAg3qQ
         egK6FFU6PIlTs025jOyh1UEorn4NPe34N8hpko4u1T/+7IaucWezCgYkfK0dbXuHql7B
         cAIBWxp1VqEUSmxl6/e31KwKxDxkRFg0G7JTeTW7DPtDaKUtPmm8PaWTKKf12m+Ia+GL
         YrTw==
X-Gm-Message-State: AC+VfDyZKjySWruDrXjn/sjD2i52N2CEdezqgjphCLOyImGbu3yutIIf
        Jvi+OtL5gdYD6Y5LulAkVxY=
X-Google-Smtp-Source: ACHHUZ7pv7xCjxFF3leBYWAAYwSuvfYYYheDgXSqtQ+cSgIGwuKkhxB04VF3kmm2QdLXlfhDTLB+3A==
X-Received: by 2002:a05:6830:12d0:b0:6a9:34c0:9e36 with SMTP id a16-20020a05683012d000b006a934c09e36mr1380199otq.23.1683324046195;
        Fri, 05 May 2023 15:00:46 -0700 (PDT)
Received: from grumpy-VECTOR.hsd1.tx.comcast.net ([2601:2c3:480:7390:90cc:2e0a:7522:8ecc])
        by smtp.gmail.com with ESMTPSA id w15-20020a056830060f00b006a61bef7968sm1359547oti.53.2023.05.05.15.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 15:00:45 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v12 01/13] HP BIOSCFG driver - Documentation
Date:   Fri,  5 May 2023 17:00:31 -0500
Message-Id: <20230505220043.39036-2-jorge.lopez2@hp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230505220043.39036-1-jorge.lopez2@hp.com>
References: <20230505220043.39036-1-jorge.lopez2@hp.com>
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
 .../testing/sysfs-class-firmware-attributes   | 117 +++++++++++++++++-
 1 file changed, 115 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-firmware-attributes b/Documentation/ABI/testing/sysfs-class-firmware-attributes
index 4cdba3477176..ad65102ef7cf 100644
--- a/Documentation/ABI/testing/sysfs-class-firmware-attributes
+++ b/Documentation/ABI/testing/sysfs-class-firmware-attributes
@@ -22,6 +22,11 @@ Description:
 			- integer: a range of numerical values
 			- string
 
+		HP specific types
+		-----------------
+			- ordered-list - a set of ordered list valid values
+
+
 		All attribute types support the following values:
 
 		current_value:
@@ -126,6 +131,22 @@ Description:
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
+					semi-colon (``,``). The order individual elements are listed
+					according to their priority.  An element listed first has the
+					highest priority. Writing the list in a different order to
+					current_value alters the priority order for the particular
+					attribute.
+
 What:		/sys/class/firmware-attributes/*/authentication/
 Date:		February 2021
 KernelVersion:	5.11
@@ -206,7 +227,7 @@ Description:
 		Drivers may emit a CHANGE uevent when a password is set or unset
 		userspace may check it again.
 
-		On Dell and Lenovo systems, if Admin password is set, then all BIOS attributes
+		On Dell, Lenovo and HP systems, if Admin password is set, then all BIOS attributes
 		require password validation.
 		On Lenovo systems if you change the Admin password the new password is not active until
 		the next boot.
@@ -296,6 +317,15 @@ Description:
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
@@ -311,7 +341,7 @@ Description:
 			==	=========================================
 			0	All BIOS attributes setting are current
 			1	A reboot is necessary to get pending BIOS
-			        attribute changes applied
+				attribute changes applied
 			==	=========================================
 
 		Note, userspace applications need to follow below steps for efficient
@@ -364,3 +394,86 @@ Description:
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
+Description:
+		'kek' Key-Encryption-Key is a write-only file that can be used to configure the
+		RSA public key that will be used by the BIOS to verify
+		signatures when setting the signing key.  When written,
+		the bytes should correspond to the KEK certificate
+		(x509 .DER format containing an OU).  The size of the
+		certificate must be less than or equal to 4095 bytes.
+
+What:		/sys/class/firmware-attributes/*/authentication/SPM/sk
+Date:		March 29
+KernelVersion:	5.18
+Contact:	"Jorge Lopez" <jorge.lopez2@hp.com>
+Description:
+		'sk' Signature Key is a write-only file that can be used to configure the RSA
+		public key that will be used by the BIOS to verify signatures
+		when configuring BIOS settings and security features.  When
+		written, the bytes should correspond to the modulus of the
+		public key.  The exponent is assumed to be 0x10001.
+
+What:		/sys/class/firmware-attributes/*/authentication/SPM/status
+Date:		March 29
+KernelVersion:	5.18
+Contact:	"Jorge Lopez" <jorge.lopez2@hp.com>
+Description:
+		'status' is a read-only file that returns ASCII text in JSON format reporting
+		the status information.
+
+		  "State": "not provisioned | provisioned | provisioning in progress ",
+		  "Version": " Major. Minor ",
+		  "Nonce": <16-bit unsigned number display in base 10>,
+		  "FeaturesInUse": <16-bit unsigned number display in base 10>,
+		  "EndorsementKeyMod": "<256 bytes in base64>",
+		  "SigningKeyMod": "<256 bytes in base64>"
+
+What:		/sys/class/firmware-attributes/*/authentication/SPM/status
+Date:		March 29
+KernelVersion:	5.18
+Contact:	"Jorge Lopez" <jorge.lopez2@hp.com>
+Description:
+		'status' is a read-only file that returns ASCII text in JSON format reporting
+		the status information.
+
+		  "State": "not provisioned | provisioned | provisioning in progress ",
+		  "Version": " Major. Minor ",
+		  "Nonce": <16-bit unsigned number display in base 10>,
+		  "FeaturesInUse": <16-bit unsigned number display in base 10>,
+		  "EndorsementKeyMod": "<256 bytes in base64>",
+		  "SigningKeyMod": "<256 bytes in base64>"
+
+What:		/sys/class/firmware-attributes/*/attributes/Sure_Start/audit_log_entries
+Date:		March 29
+KernelVersion:	5.18
+Contact:	"Jorge Lopez" <jorge.lopez2@hp.com>
+Description:
+		'audit_log_entries' is a read-only file that returns the events in the log.
+
+			Audit log entry format
+
+			Byte 0-15:   Requested Audit Log entry  (Each Audit log is 16 bytes)
+			Byte 16-127: Unused
+
+What:		/sys/class/firmware-attributes/*/attributes/Sure_Start/audit_log_entry_count
+Date:		March 29
+KernelVersion:	5.18
+Contact:	"Jorge Lopez" <jorge.lopez2@hp.com>
+Description:
+		'audit_log_entry_count' is a read-only file that returns the number of existing
+		audit log events available to be read. Values are separated using comma (``,``)
+
+			[No of entries],[log entry size],[Max number of entries supported]
+
+		log entry size identifies audit log size for the current BIOS version.
+		The current size is 16 bytes but it can be to up to 128 bytes long
+		in future BIOS versions.
-- 
2.34.1

