Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3266DEACF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 06:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjDLEy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 00:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjDLEyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 00:54:54 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2D6DA;
        Tue, 11 Apr 2023 21:54:50 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id o2-20020a17090a0a0200b00246da660bd2so3299188pjo.0;
        Tue, 11 Apr 2023 21:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681275290;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=isC/tggr1M1j4BvcUw13VcYJi8Ta2shT86tAqvJcmz4=;
        b=VIJu6C7V56AA2Is3/+dbl7nI4IXs55Ru1FeXvN6twXWYvW4hItNGi7o017uB5eoprA
         3VkO4rQJS5AVsN7PinHXP27ZlYoerTRsUwjGigvaVy3z3o5y2AEiTd6dDjo5XKBQ0cSI
         nuFUywotIB3JOs7/Z/JaWpY0MDkF8+8y6wN2bjAZ0RAB0ZmKvv14+0VwxamfHuzQvPcT
         8Og072xbLU+8eyEQhaNISr3pzWjuAQjqUMo54wASob6YEhLdnEblPbIHxmHL9c9CGohw
         L6b7skTSYJNPG63wP8H0E3I7kj1f3vrhPQ4XDPC2R/Gk2oOss+CCuo3uzegKs1BmLF2v
         63+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681275290;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=isC/tggr1M1j4BvcUw13VcYJi8Ta2shT86tAqvJcmz4=;
        b=ifk5S8eJNZyJeywpWuEUdiEhkkfCm9O1K4+Qc9nSYjdIiZnesRpnB7v6GD+T4k0uJe
         sIVXCBQ+z/QfEFKmUVO1ywiIylFgXD2oqkxb4zQc31j5PQmUnfrMZaQd4vkJNFlFHO/F
         6llUYWtVkFRxxFPYLJ4UrrNRQLx1qxQyjQVNHTjNhTjNLWIj8ffYlRv5v8p2bhj3OqeJ
         xq53brajxYsbAhFO9bDy+nQKF3fD7xGkHyJpQb3lW0PtrWxi0cwKg0Qd/CAtApN8defQ
         D56gTYz2VbL4Nt3Fgnne9fORWNORnKXxpLvWDpJtikjc+0OxtKepJWjCECamKzkhG0Y3
         C61A==
X-Gm-Message-State: AAQBX9fbMi5saHXuIy3awajtadlrWTtccm/XVglhKfg+kZ2+93MVEpSg
        KMTZP14bPGDjMK1wjan4EDI=
X-Google-Smtp-Source: AKy350bKN8KlxqOPBZiacWmIbbCWLW6MZya+0HZhJaF5N2DSvbKfEt+F7G3LKNQnYoMqc0SdAVAAQg==
X-Received: by 2002:a17:90b:1c86:b0:240:9bf7:8df2 with SMTP id oo6-20020a17090b1c8600b002409bf78df2mr19227745pjb.37.1681275289620;
        Tue, 11 Apr 2023 21:54:49 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-89.three.co.id. [180.214.233.89])
        by smtp.gmail.com with ESMTPSA id l14-20020a17090add8e00b00246cf1a8d3dsm499641pjv.17.2023.04.11.21.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 21:54:49 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id A34481068E2; Wed, 12 Apr 2023 11:54:46 +0700 (WIB)
Date:   Wed, 12 Apr 2023 11:54:46 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Jorge Lopez <jorgealtxwork@gmail.com>, hdegoede@redhat.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linux Documentation <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v8] HP BIOSCFG driver - Documentation
Message-ID: <ZDY5lqv7lDVr7eIZ@debian.me>
References: <20230411184734.7011-1-jorge.lopez2@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230411184734.7011-1-jorge.lopez2@hp.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 01:47:34PM -0500, Jorge Lopez wrote:
> HP BIOS Configuration driver purpose is to provide a driver supporting
> the latest sysfs class firmware attributes framework allowing the user
> to change BIOS settings and security solutions on HP Inc.’s commercial
> notebooks.
> 
> Many features of HP Commercial notebooks can be managed using Windows
> Management Instrumentation (WMI). WMI is an implementation of Web-Based
> Enterprise Management (WBEM) that provides a standards-based interface
> for changing and monitoring system settings. HP BIOSCFG driver provides
> a native Linux solution and the exposed features facilitates the
> migration to Linux environments.
> 
> The Linux security features to be provided in hp-bioscfg driver enables
> managing the BIOS settings and security solutions via sysfs, a virtual
> filesystem that can be used by user-mode applications. The new
> documentation cover features such Secure Platform Management and Sure
> Start. Each section provides security feature description and
> identifies sysfs directories and files exposed by the driver.
> 
> Many HP Commercial notebooks include a feature called Secure Platform
> Management (SPM), which replaces older password-based BIOS settings
> management with public key cryptography. PC secure product management
> begins when a target system is provisioned with cryptographic keys
> that are used to ensure the integrity of communications between system
> management utilities and the BIOS.
> 
> HP Commercial notebooks have several BIOS settings that control its
> behaviour and capabilities, many of which are related to security.
> To prevent unauthorized changes to these settings, the system can
> be configured to use a cryptographic signature-based authorization
> string that the BIOS will use to verify authorization to modify the
> setting.

The patch description should also adds:

"Document HP-specific firmware sysfs attributes."

> diff --git a/Documentation/ABI/testing/sysfs-class-firmware-attributes b/Documentation/ABI/testing/sysfs-class-firmware-attributes
> index 4cdba3477176..574cdd8a6cc6 100644
> --- a/Documentation/ABI/testing/sysfs-class-firmware-attributes
> +++ b/Documentation/ABI/testing/sysfs-class-firmware-attributes
> @@ -22,6 +22,12 @@ Description:
>  			- integer: a range of numerical values
>  			- string
>  
> +		HP specific types
> +		-----------------
> +			- ordered-list - a set of ordered list valid values
> +			- sure-start - report audit logs read from BIOS
> +
> +
>  		All attribute types support the following values:
>  
>  		current_value:
> @@ -126,6 +132,44 @@ Description:
>  					value will not be effective through sysfs until this rule is
>  					met.
>  
> +		HP specific class extensions
> +		------------------------------
> +
> +		On HP systems the following additional attributes are available:
> +
> +		"ordered-list"-type specific properties:
> +
> +		elements:
> +					A file that can be read to obtain the possible
> +					list of values of the <attr>. Values are separated using
> +					semi-colon (``;``). The order individual elements are listed
> +					according to their priority.  An Element listed first has the
> +					highest priority. Writing the list in a different order to
> +					current_value alters the priority order for the particular
> +					attribute.
> +
> +		"sure-start"-type specific properties:
> +
> +		audit_log_entries:
> +					A read-only file that returns the events in the log.
> +					Values are separated using semi-colon (``;``)
> +
> +					Audit log entry format
> +
> +					Byte 0-15:   Requested Audit Log entry  (Each Audit log is 16 bytes)
> +					Byte 16-127: Unused
> +
> +		audit_log_entry_count:
> +					A read-only file that returns the number of existing audit log events available to be read.
> +					Values are separated using comma (``,``)
> +
> +					[No of entries],[log entry size],[Max number of entries supported]
> +
> +					log entry size identifies audit log size for the current BIOS version.
> +					The current size is 16 bytes but it can be to up to 128 bytes long
> +					in future BIOS versions.
> +
> +
>  What:		/sys/class/firmware-attributes/*/authentication/
>  Date:		February 2021
>  KernelVersion:	5.11
> @@ -206,7 +250,7 @@ Description:
>  		Drivers may emit a CHANGE uevent when a password is set or unset
>  		userspace may check it again.
>  
> -		On Dell and Lenovo systems, if Admin password is set, then all BIOS attributes
> +		On Dell, Lenovo and HP systems, if Admin password is set, then all BIOS attributes
>  		require password validation.
>  		On Lenovo systems if you change the Admin password the new password is not active until
>  		the next boot.
> @@ -296,6 +340,15 @@ Description:
>  						echo "signature" > authentication/Admin/signature
>  						echo "password" > authentication/Admin/certificate_to_password
>  
> +		HP specific class extensions
> +		--------------------------------
> +
> +		On HP systems the following additional settings are available:
> +
> +		role: enhanced-bios-auth:
> +					This role is specific to Secure Platform Management (SPM) attribute.
> +					It requires configuring an endorsement (kek) and signing certificate (sk).
> +
>  
>  What:		/sys/class/firmware-attributes/*/attributes/pending_reboot
>  Date:		February 2021
> @@ -364,3 +417,52 @@ Description:
>  		use it to enable extra debug attributes or BIOS features for testing purposes.
>  
>  		Note that any changes to this attribute requires a reboot for changes to take effect.
> +
> +
> +		HP specific class extensions - Secure Platform Manager (SPM)
> +		--------------------------------
> +
> +What:		/sys/class/firmware-attributes/*/authentication/SPM/kek
> +Date:		March 29
> +KernelVersion:	5.18
> +Contact:	"Jorge Lopez" <jorge.lopez2@hp.com>
> +Description:	'kek' Key-Encryption-Key is a write-only file that can be used to configure the
> +		RSA public key that will be used by the BIOS to verify
> +		signatures when setting the signing key.  When written,
> +		the bytes should correspond to the KEK certificate
> +		(x509 .DER format containing an OU).  The size of the
> +		certificate must be less than or equal to 4095 bytes.
> +
> +
> +What:		/sys/class/firmware-attributes/*/authentication/SPM/sk
> +Date:		March 29
> +KernelVersion:	5.18
> +Contact:	"Jorge Lopez" <jorge.lopez2@hp.com>
> +Description:	'sk' Signature Key is a write-only file that can be used to configure the RSA
> +		public key that will be used by the BIOS to verify signatures
> +		when configuring BIOS settings and security features.  When
> +		written, the bytes should correspond to the modulus of the
> +		public key.  The exponent is assumed to be 0x10001.
> +
> +
> +What:		/sys/class/firmware-attributes/*/authentication/SPM/status
> +Date:		March 29
> +KernelVersion:	5.18
> +Contact:	"Jorge Lopez" <jorge.lopez2@hp.com>
> +Description:	'status' is a read-only file that returns ASCII text reporting
> +		the status information.
> +
> +		  State:  Not Provisioned / Provisioned / Provisioning in progress
> +		  Version:  Major.   Minor
> +		  Feature Bit Mask: <16-bit unsigned number display in hex>
> +		  SPM Counter: <16-bit unsigned number display in base 10>
> +		  Signing Key Public Key Modulus (base64): <256 bytes base64 in hex>
> +		  KEK Public Key Modulus (base64): <256 bytes base64 in hex>
> +
> +
> +What:		/sys/class/firmware-attributes/*/authentication/SPM/statusbin
> +Date:		March 29
> +KernelVersion:	5.18
> +Contact:	"Jorge Lopez" <jorge.lopez2@hp.com>
> +Description:	'statusbin' is a read-only file that returns identical status
> +		information reported by 'status' file in binary format.

The wording and formatting can be improved:

---- >8 ----
diff --git a/Documentation/ABI/testing/sysfs-class-firmware-attributes b/Documentation/ABI/testing/sysfs-class-firmware-attributes
index 574cdd8a6cc694..2b2309c93c1c21 100644
--- a/Documentation/ABI/testing/sysfs-class-firmware-attributes
+++ b/Documentation/ABI/testing/sysfs-class-firmware-attributes
@@ -22,10 +22,10 @@ Description:
 			- integer: a range of numerical values
 			- string
 
-		HP specific types
+		HP-specific types
 		-----------------
-			- ordered-list - a set of ordered list valid values
-			- sure-start - report audit logs read from BIOS
+			- ordered-list: a set of ordered list valid values
+			- sure-start: report audit logs read from BIOS
 
 
 		All attribute types support the following values:
@@ -137,33 +137,32 @@ Description:
 
 		On HP systems the following additional attributes are available:
 
-		"ordered-list"-type specific properties:
+		* "ordered-list"-type specific properties:
 
-		elements:
-					A file that can be read to obtain the possible
-					list of values of the <attr>. Values are separated using
-					semi-colon (``;``). The order individual elements are listed
-					according to their priority.  An Element listed first has the
-					highest priority. Writing the list in a different order to
-					current_value alters the priority order for the particular
-					attribute.
+			elements:
+					(RW) A file that contains semicolon-separated list of possible
+					values of the <attr>, ordered by their priority. The first
+					listed element has the highest priority. Writing the list
+					in a different order to current_value alters the priority
+					order for the particular attribute.
 
-		"sure-start"-type specific properties:
+		* "sure-start"-type specific properties:
 
-		audit_log_entries:
-					A read-only file that returns the events in the log.
-					Values are separated using semi-colon (``;``)
+			audit_log_entries:
+					(RO) Returns the events in the log. Log entries are
+					semicolon-separated.
 
-					Audit log entry format
+					Audit log entry format:
 
-					Byte 0-15:   Requested Audit Log entry  (Each Audit log is 16 bytes)
-					Byte 16-127: Unused
+					* Byte 0-15:   Requested Audit Log entry  (Each Audit log is 16 bytes)
+					* Byte 16-127: Unused
 
-		audit_log_entry_count:
-					A read-only file that returns the number of existing audit log events available to be read.
-					Values are separated using comma (``,``)
+			audit_log_entry_count:
+					(RO) Returns the number of existing audit log events available to be read.
 
-					[No of entries],[log entry size],[Max number of entries supported]
+					The file format is::
+
+					    [No of entries],[log entry size],[Max number of entries supported]
 
 					log entry size identifies audit log size for the current BIOS version.
 					The current size is 16 bytes but it can be to up to 128 bytes long
@@ -426,19 +425,19 @@ What:		/sys/class/firmware-attributes/*/authentication/SPM/kek
 Date:		March 29
 KernelVersion:	5.18
 Contact:	"Jorge Lopez" <jorge.lopez2@hp.com>
-Description:	'kek' Key-Encryption-Key is a write-only file that can be used to configure the
+Description:	(WO) Key-Encryption-Key (KEK) file that can be used to configure the
 		RSA public key that will be used by the BIOS to verify
 		signatures when setting the signing key.  When written,
 		the bytes should correspond to the KEK certificate
-		(x509 .DER format containing an OU).  The size of the
-		certificate must be less than or equal to 4095 bytes.
+		(x509 .DER format containing an OU). The certificate size
+                must be less than or equal to 4095 bytes.
 
 
 What:		/sys/class/firmware-attributes/*/authentication/SPM/sk
 Date:		March 29
 KernelVersion:	5.18
 Contact:	"Jorge Lopez" <jorge.lopez2@hp.com>
-Description:	'sk' Signature Key is a write-only file that can be used to configure the RSA
+Description:	(WO) Signature Key (SK) file that can be used to configure the RSA
 		public key that will be used by the BIOS to verify signatures
 		when configuring BIOS settings and security features.  When
 		written, the bytes should correspond to the modulus of the
@@ -449,20 +448,21 @@ What:		/sys/class/firmware-attributes/*/authentication/SPM/status
 Date:		March 29
 KernelVersion:	5.18
 Contact:	"Jorge Lopez" <jorge.lopez2@hp.com>
-Description:	'status' is a read-only file that returns ASCII text reporting
-		the status information.
+Description:	(RO) Returns status information report in text format.
 
-		  State:  Not Provisioned / Provisioned / Provisioning in progress
-		  Version:  Major.   Minor
-		  Feature Bit Mask: <16-bit unsigned number display in hex>
-		  SPM Counter: <16-bit unsigned number display in base 10>
-		  Signing Key Public Key Modulus (base64): <256 bytes base64 in hex>
-		  KEK Public Key Modulus (base64): <256 bytes base64 in hex>
+		The fields are:
+
+		  * State:  Not Provisioned / Provisioned / Provisioning in progress
+		  * Version:  version number (<major>.<minor>)
+		  * Feature Bit Mask: 16-bit unsigned number display in hex
+		  * SPM Counter: 16-bit unsigned number display in base 10
+		  * Signing Key Public Key Modulus (base64): 256 bytes base64 in hex
+		  * KEK Public Key Modulus (base64): 256 bytes base64 in hex
 
 
 What:		/sys/class/firmware-attributes/*/authentication/SPM/statusbin
 Date:		March 29
 KernelVersion:	5.18
 Contact:	"Jorge Lopez" <jorge.lopez2@hp.com>
-Description:	'statusbin' is a read-only file that returns identical status
-		information reported by 'status' file in binary format.
+Description:	(RO) Return status information report in binary format. The fields
+		are same as returned by status sysfs above.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
