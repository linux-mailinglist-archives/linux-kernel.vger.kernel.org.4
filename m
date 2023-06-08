Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE52728504
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 18:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235439AbjFHQda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 12:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbjFHQd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 12:33:27 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8191BE8;
        Thu,  8 Jun 2023 09:33:22 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-39a50fcc719so517644b6e.2;
        Thu, 08 Jun 2023 09:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686242002; x=1688834002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cwh7YL4ODPqYxMTqOJYXnYVMfL0xitzm2JnJT14s+nM=;
        b=UErCwQ/681NBNSwOQ1MDdnebrFuo+VFlS7ajJDjgoHYPB8XaEsGebfDUkNNBTLb+UE
         6KiUaV02SkmCyYVDMLaq4wJG2utYOwXVO/gvAGQP3pA9mgv9O3J0DLaOS9sVfgAPEbqH
         ZaAd7uR+pSuluOlBD8+4nUHZ8tHIh2uDw1BknAwRqe3d2Xf36cwGAACo+DdGmBO8eqGa
         JvMEely0LNWElAn3BOjrxOOVLlIRIGPZgqcr0DWxSIiWbWz/ns4lUrh6kBeSHBP5uly4
         1yMeBU/73WbKoLSFITR65lWXQSx9ULI0uIl9tBdy5LHJg+jd04g+GXh+adbT1KxK9S4T
         pobw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686242002; x=1688834002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cwh7YL4ODPqYxMTqOJYXnYVMfL0xitzm2JnJT14s+nM=;
        b=fHwsUJn9BoPbNSE1e4gGV7FTduE4v2SQqLz8fKoKOHfpXe1CYKDezeXSzEvJCVprCs
         qXrKGfB+/dv//SbywtQzv3WorE7GnV2xE1DlcmHObCPngAuqNO/eutnM/ccslO8/txWX
         tQtznvwxPmMrUYG9SuEZSOjDObrAOQYdkPB5rIEU6xcJMIWeTPYFyb+i2O2gPGNLw85w
         DT8x50ke0bilOaJx2o1yd1BGU8dQqSTkruLeLZdnVNYn5kNA10Z5jq7he9YOqekzJ5uM
         r6TJfZSirteovIRwXcDH846agv13IHDnoHFTTMOBzV3xey+EfuxzG2Hd/Z1tCSMYtheA
         pQaw==
X-Gm-Message-State: AC+VfDxRUdA3nuLmc0KpSW3+D6rWsu+OYrbt5aQnd1bMLCGk4/mS7JZd
        H1uZfnaGH3czL+8HFeqFL2I=
X-Google-Smtp-Source: ACHHUZ4hZX4Z7Aiyk1P80CWlqvxjudvQg13Opfyx6ZXmFElrA54c30z7HANff7BBHo3IkCGNp6Kycg==
X-Received: by 2002:aca:1c14:0:b0:398:307:408d with SMTP id c20-20020aca1c14000000b003980307408dmr7829862oic.18.1686242001774;
        Thu, 08 Jun 2023 09:33:21 -0700 (PDT)
Received: from grumpy-VECTOR.hsd1.tx.comcast.net ([2601:2c3:480:7390:a60f:2d4d:e52b:2fca])
        by smtp.gmail.com with ESMTPSA id e10-20020acab50a000000b003942036439dsm577500oif.46.2023.06.08.09.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 09:33:21 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v17 01/13] hp-bioscfg: Documentation
Date:   Thu,  8 Jun 2023 11:33:07 -0500
Message-Id: <20230608163319.18934-2-jorge.lopez2@hp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230608163319.18934-1-jorge.lopez2@hp.com>
References: <20230608163319.18934-1-jorge.lopez2@hp.com>
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

Update sysfs-class-firmware-attributes with hp-bioscfg information

HP BIOS Configuration driver purpose is to provide a driver supporting
the latest sysfs class firmware attributes framework allowing the user
to change BIOS settings and security solutions on HP Inc.’s commercial
notebooks.

Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>

---
Based on the latest platform-drivers-x86.git/for-next
---
 .../testing/sysfs-class-firmware-attributes   | 101 +++++++++++++++++-
 1 file changed, 99 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-firmware-attributes b/Documentation/ABI/testing/sysfs-class-firmware-attributes
index 4cdba3477176..0a6c9c2ddc9d 100644
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
@@ -126,6 +131,21 @@ Description:
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
+					semi-colon (``;``) and listed according to their priority.
+					An element listed first has the highest priority. Writing
+					the list in a different order to current_value alters
+					the priority order for the particular attribute.
+
 What:		/sys/class/firmware-attributes/*/authentication/
 Date:		February 2021
 KernelVersion:	5.11
@@ -206,7 +226,7 @@ Description:
 		Drivers may emit a CHANGE uevent when a password is set or unset
 		userspace may check it again.
 
-		On Dell and Lenovo systems, if Admin password is set, then all BIOS attributes
+		On Dell, Lenovo and HP systems, if Admin password is set, then all BIOS attributes
 		require password validation.
 		On Lenovo systems if you change the Admin password the new password is not active until
 		the next boot.
@@ -296,6 +316,15 @@ Description:
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
@@ -311,7 +340,7 @@ Description:
 			==	=========================================
 			0	All BIOS attributes setting are current
 			1	A reboot is necessary to get pending BIOS
-			        attribute changes applied
+				attribute changes applied
 			==	=========================================
 
 		Note, userspace applications need to follow below steps for efficient
@@ -364,3 +393,71 @@ Description:
 		use it to enable extra debug attributes or BIOS features for testing purposes.
 
 		Note that any changes to this attribute requires a reboot for changes to take effect.
+
+
+		HP specific class extensions - Secure Platform Manager (SPM)
+		--------------------------------
+
+What:		/sys/class/firmware-attributes/*/authentication/SPM/kek
+Date:		March 2023
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
+Date:		March 2023
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
+Date:		March 2023
+KernelVersion:	5.18
+Contact:	"Jorge Lopez" <jorge.lopez2@hp.com>
+Description:
+		'status' is a read-only file that returns ASCII text in JSON format reporting
+		the status information.
+
+		  "State": "not provisioned | provisioned | provisioning in progress",
+		  "Version": "Major.Minor",
+		  "Nonce": <16-bit unsigned number display in base 10>,
+		  "FeaturesInUse": <16-bit unsigned number display in base 10>,
+		  "EndorsementKeyMod": "<256 bytes in base64>",
+		  "SigningKeyMod": "<256 bytes in base64>"
+
+What:		/sys/class/firmware-attributes/*/attributes/Sure_Start/audit_log_entries
+Date:		March 2023
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
+Date:		March 2023
+KernelVersion:	5.18
+Contact:	"Jorge Lopez" <jorge.lopez2@hp.com>
+Description:
+		'audit_log_entry_count' is a read-only file that returns the number of existing
+		audit log events available to be read. Values are separated using comma. (``,``)
+
+			[No of entries],[log entry size],[Max number of entries supported]
+
+		log entry size identifies audit log size for the current BIOS version.
+		The current size is 16 bytes but it can be up to 128 bytes long in future BIOS
+		versions.
-- 
2.34.1

