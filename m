Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 400C370768A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 01:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjEQXmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 19:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjEQXmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 19:42:42 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90ECE4C2C;
        Wed, 17 May 2023 16:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=HeC9GhelDZ8TP1zU3MAksg1EYB52P0PBzLR2mW/Seh8=; b=brOtu1Ns9mq+zk+8HxRe/+hGB2
        +AjzlTtK71SFTZ/T2T8m3chahk/92CMPg9FuSNsO1vpW0I6O8BPEVxkEf6FqL4CCDanWiXqduHX//
        yMQgvkEzjELiKAMNXeUFc30oqxfGbwJLZB1DIh7KNuG1RMgSLJ/7kAYS92N46cOR2/5GCzEwbRrl6
        30Aq0Upf7Q+pyspeR1Pv+6g2rRei9QzJCxHwwdS3A+1d+uQ4J9Sq+d+IF+EWnHlUGcNmgINZBsCKC
        mD1PqYIOteWK/CR614cxhcsj6Qa39DYBocJ//9zj3gzmi9/iaQke9INRBt91ftIE+7VMdpwCeTXmH
        bslbxBwQ==;
Received: from [2601:1c2:980:9ec0::bc8f]
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pzQmu-00DNGV-39;
        Wed, 17 May 2023 23:42:33 +0000
Message-ID: <7e5ee08c-e157-9f2c-3f87-ae88b503fc4d@infradead.org>
Date:   Wed, 17 May 2023 16:42:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v14 01/13] hp-bioscfg: Documentation
To:     Jorge Lopez <jorgealtxwork@gmail.com>, hdegoede@redhat.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas@t-8ch.de, ilpo.jarvinen@linux.intel.com
References: <20230517155026.28535-1-jorge.lopez2@hp.com>
 <20230517155026.28535-2-jorge.lopez2@hp.com>
Content-Language: en-US
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230517155026.28535-2-jorge.lopez2@hp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 5/17/23 08:50, Jorge Lopez wrote:
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
> documentation cover HP-specific firmware sysfs attributes such Secure
> Platform Management and Sure Start. Each section provides security
> feature description and identifies sysfs directories and files exposed
> by the driver.
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
> 
> Linux Security components are under development and not published yet.
> The only linux component is the driver (hp bioscfg) at this time.
> Other published security components are under Windows.
> 

IMO it doesn't help to have this blurb repeated in each patch.

The commit message should describe what this patch does and why.

> Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>
> 
> ---
> Based on the latest platform-drivers-x86.git/for-next
> ---
>   .../testing/sysfs-class-firmware-attributes   | 102 +++++++++++++++++-
>   1 file changed, 100 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-firmware-attributes b/Documentation/ABI/testing/sysfs-class-firmware-attributes
> index 4cdba3477176..f8d6c089228b 100644
> --- a/Documentation/ABI/testing/sysfs-class-firmware-attributes
> +++ b/Documentation/ABI/testing/sysfs-class-firmware-attributes
> @@ -22,6 +22,11 @@ Description:
>   			- integer: a range of numerical values
>   			- string
>   
> +		HP specific types
> +		-----------------
> +			- ordered-list - a set of ordered list valid values
> +
> +
>   		All attribute types support the following values:
>   
>   		current_value:
> @@ -126,6 +131,22 @@ Description:
>   					value will not be effective through sysfs until this rule is
>   					met.
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
> +					according to their priority.  An element listed first has the

I have trouble parsing "The order individual elements are list
according to their property."

> +					highest priority. Writing the list in a different order to
> +					current_value alters the priority order for the particular
> +					attribute.
> +
>   What:		/sys/class/firmware-attributes/*/authentication/
>   Date:		February 2021
>   KernelVersion:	5.11
> @@ -206,7 +227,7 @@ Description:
>   		Drivers may emit a CHANGE uevent when a password is set or unset
>   		userspace may check it again.
>   
> -		On Dell and Lenovo systems, if Admin password is set, then all BIOS attributes
> +		On Dell, Lenovo and HP systems, if Admin password is set, then all BIOS attributes
>   		require password validation.
>   		On Lenovo systems if you change the Admin password the new password is not active until
>   		the next boot.

> @@ -364,3 +394,71 @@ Description:
>   		use it to enable extra debug attributes or BIOS features for testing purposes.
>   
>   		Note that any changes to this attribute requires a reboot for changes to take effect.
> +
> +
> +		HP specific class extensions - Secure Platform Manager (SPM)
> +		--------------------------------
> +
> +What:		/sys/class/firmware-attributes/*/authentication/SPM/kek
> +Date:		March 29

Date: should be Month Year or Month Day Year according to other files 
(although it is apparently not specified as far as my quick searching 
found).

> +KernelVersion:	5.18
> +Contact:	"Jorge Lopez" <jorge.lopez2@hp.com>
> +Description:
> +		'kek' Key-Encryption-Key is a write-only file that can be used to configure the
> +		RSA public key that will be used by the BIOS to verify
> +		signatures when setting the signing key.  When written,
> +		the bytes should correspond to the KEK certificate
> +		(x509 .DER format containing an OU).  The size of the
> +		certificate must be less than or equal to 4095 bytes.
> +
> +What:		/sys/class/firmware-attributes/*/authentication/SPM/sk
> +Date:		March 29

Ditto.

> +KernelVersion:	5.18
> +Contact:	"Jorge Lopez" <jorge.lopez2@hp.com>
> +Description:
> +		'sk' Signature Key is a write-only file that can be used to configure the RSA
> +		public key that will be used by the BIOS to verify signatures
> +		when configuring BIOS settings and security features.  When
> +		written, the bytes should correspond to the modulus of the
> +		public key.  The exponent is assumed to be 0x10001.
> +
> +What:		/sys/class/firmware-attributes/*/authentication/SPM/status
> +Date:		March 29

Ditto.

> +KernelVersion:	5.18
> +Contact:	"Jorge Lopez" <jorge.lopez2@hp.com>
> +Description:
> +		'status' is a read-only file that returns ASCII text in JSON format reporting
> +		the status information.
> +
> +		  "State": "not provisioned | provisioned | provisioning in progress ",
> +		  "Version": " Major. Minor ",
> +		  "Nonce": <16-bit unsigned number display in base 10>,
> +		  "FeaturesInUse": <16-bit unsigned number display in base 10>,
> +		  "EndorsementKeyMod": "<256 bytes in base64>",
> +		  "SigningKeyMod": "<256 bytes in base64>"
> +
> +What:		/sys/class/firmware-attributes/*/attributes/Sure_Start/audit_log_entries
> +Date:		March 29

Ditto.

> +KernelVersion:	5.18
> +Contact:	"Jorge Lopez" <jorge.lopez2@hp.com>
> +Description:
> +		'audit_log_entries' is a read-only file that returns the events in the log.
> +
> +			Audit log entry format
> +
> +			Byte 0-15:   Requested Audit Log entry  (Each Audit log is 16 bytes)
> +			Byte 16-127: Unused
> +
> +What:		/sys/class/firmware-attributes/*/attributes/Sure_Start/audit_log_entry_count
> +Date:		March 29

Ditto.

> +KernelVersion:	5.18
> +Contact:	"Jorge Lopez" <jorge.lopez2@hp.com>
> +Description:
> +		'audit_log_entry_count' is a read-only file that returns the number of existing
> +		audit log events available to be read. Values are separated using comma (``,``)
> +
> +			[No of entries],[log entry size],[Max number of entries supported]
> +
> +		log entry size identifies audit log size for the current BIOS version.
> +		The current size is 16 bytes but it can be up to 128 bytes long in future BIOS
> +		versions.
