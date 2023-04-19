Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505916E7DC9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 17:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbjDSPND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 11:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232823AbjDSPM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 11:12:57 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16B740FE;
        Wed, 19 Apr 2023 08:12:55 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-38bcc5914ecso3023b6e.0;
        Wed, 19 Apr 2023 08:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681917175; x=1684509175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2uw6cJJOj4NpjhqsMBl9W9u80TyJYI2izxlDAFaHoDI=;
        b=i1kE4vzt2f/t9G9UipAYtp/r43L4X2m4RsNEPQ4ji5HTT8Zv/IXV7lcSiUxifcDFMO
         gfv0G0x4NCfU5k5G90/wt+EhepxsBwe/MGVeqxlIbCqJmZIcsSbSaBceggUCgudJyeWV
         L7iJjFngAc9ozec1ifhqFV3bCZUJZLncAa9PDc89wUB88du1X9OI6cfggy9YJgjAH7E5
         OswNxUvETYMq8IzxoHrpHHsNo4qKc6NrLny2I0CfIobInuUU7A2oqHDUHY154F85ktr6
         K3QA+Pi3EmPpWxEwKpCKDpzj+RZmgFdIMoM7QbCpKdyxxGsnXoznW7RkYQpEIM5+1hAe
         ubaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681917175; x=1684509175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2uw6cJJOj4NpjhqsMBl9W9u80TyJYI2izxlDAFaHoDI=;
        b=LIov0WGDVqmBAR5O9BzThkYOkUuLwTWFMgRBv9V4W14JlSv2uGYwDLhKMDVQ0zitEd
         VoujBb8GGLiHpFuTOWqkaUmaNjakgKxMPpuYvgyeF/Bgn6RiPpXKtiq/WF4DMmkQ7t0O
         Ma6ZM/sujwdHxMZVyJ8VJporHV4PQj2bjjnKPy0y61fTPMU5+OaMiS/HrT+fX0HBAF8a
         SL7qBsa/rCHvJNRc8nIEJOHmVVoSKj6TckUlipujgRhW1mnwlneki5CGILUcaKWW3jC3
         HxHJOSC4Ts1pFqX/mupGvMdhyC4vCfk+mMgDZGNPIW9gWcImpqzDgGea4ExfQlAAKOeo
         wqjw==
X-Gm-Message-State: AAQBX9cBh9GszOCSQZjm2Ohmipt/UONBA6Ng6AS82DZsxqVHHTNoCpJ1
        9kL09NOc6SuKQvntcrHaFuknjHOBe+w=
X-Google-Smtp-Source: AKy350aCvE6JBwLsGP05LGV69QuEFTx0apH2l++wlH1wejpzrorncbZtXH0kz6sHZLSIIK6nIbW1Hw==
X-Received: by 2002:a05:6808:9:b0:37f:aa3f:7218 with SMTP id u9-20020a056808000900b0037faa3f7218mr2849073oic.27.1681917175023;
        Wed, 19 Apr 2023 08:12:55 -0700 (PDT)
Received: from grumpy-VECTOR.hsd1.tx.comcast.net ([2601:2c3:480:7390:e175:6963:338:7453])
        by smtp.gmail.com with ESMTPSA id o10-20020acad70a000000b0038bae910f7bsm5766847oig.1.2023.04.19.08.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 08:12:54 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v10 01/14] HP BIOSCFG driver - Documentation
Date:   Wed, 19 Apr 2023 10:12:41 -0500
Message-Id: <20230419151249.6126-2-jorge.lopez2@hp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230419151249.6126-1-jorge.lopez2@hp.com>
References: <20230419151249.6126-1-jorge.lopez2@hp.com>
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

