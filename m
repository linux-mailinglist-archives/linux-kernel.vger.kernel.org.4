Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71DAA720C18
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 00:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236708AbjFBWzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 18:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236281AbjFBWzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 18:55:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1B719B;
        Fri,  2 Jun 2023 15:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=/J1w8AlUBOlWVDXlEbVWbpkNX5QXg3yqI58ktXI/6E0=; b=Hn9B4kJuIFbQFXW801N8KZvQiq
        bbFRRvX0tC6t2s8cR4b0UnWT2PuXf/os29Ur4znpUntMLSUcRwkNFXGbR5mcC6g0ONH8HUjUtdCaS
        2wqYxlFIKEgTxrqkcanwrNrh56sy83jYiy//o7PcA41GKB240Y4iEGpf9Q9nUQ6KXynpR5X7Kn9oo
        o1ioazccupI8/FVF2RVhhNpOUzQgDMmFnfjF348cEsV61qatP563jDmQw2V7C/Tkh5hKP3YNXEJgl
        Z2hxVsTvCpVh3pAPRjIysqydM0EpZDEwmz0rlUzG9csoNERItteG9dfkG36xgW2odnC0P2XSSG0eJ
        vdwvGC3A==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q5DgD-0086ns-0t;
        Fri, 02 Jun 2023 22:55:33 +0000
Message-ID: <39a19a0b-610d-52bf-5050-eb870ad2e619@infradead.org>
Date:   Fri, 2 Jun 2023 15:55:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v16 01/13] hp-bioscfg: Documentation
Content-Language: en-US
To:     Jorge Lopez <jorgealtxwork@gmail.com>, hdegoede@redhat.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas@t-8ch.de, ilpo.jarvinen@linux.intel.com
References: <20230602131044.3297-1-jorge.lopez2@hp.com>
 <20230602131044.3297-2-jorge.lopez2@hp.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230602131044.3297-2-jorge.lopez2@hp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/2/23 06:10, Jorge Lopez wrote:

> 
> Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>
> 
> ---
> Based on the latest platform-drivers-x86.git/for-next
> ---
>  .../testing/sysfs-class-firmware-attributes   | 101 +++++++++++++++++-
>  1 file changed, 99 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-firmware-attributes b/Documentation/ABI/testing/sysfs-class-firmware-attributes
> index 4cdba3477176..df9904b9f39c 100644
> --- a/Documentation/ABI/testing/sysfs-class-firmware-attributes
> +++ b/Documentation/ABI/testing/sysfs-class-firmware-attributes
> @@ -126,6 +131,21 @@ Description:
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
> +					semi-colon (``;``) and listed according to their priority.
> +					An element listed first has the highest priority. Writing
> +					the list in a different order to current_value alters
> +					the priority order for the particular attribute.
> +
>  What:		/sys/class/firmware-attributes/*/authentication/
>  Date:		February 2021
>  KernelVersion:	5.11

Why 5.11 and that date?

> @@ -364,3 +393,71 @@ Description:
>  		use it to enable extra debug attributes or BIOS features for testing purposes.
>  
>  		Note that any changes to this attribute requires a reboot for changes to take effect.
> +
> +
> +		HP specific class extensions - Secure Platform Manager (SPM)
> +		--------------------------------
> +
> +What:		/sys/class/firmware-attributes/*/authentication/SPM/kek
> +Date:		March 2023
> +KernelVersion:	5.18

Why 5.18 and that date?

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
> +Date:		March 2023
> +KernelVersion:	5.18

Why 5.18 and that date?

> +Contact:	"Jorge Lopez" <jorge.lopez2@hp.com>
> +Description:
> +		'sk' Signature Key is a write-only file that can be used to configure the RSA
> +		public key that will be used by the BIOS to verify signatures
> +		when configuring BIOS settings and security features.  When
> +		written, the bytes should correspond to the modulus of the
> +		public key.  The exponent is assumed to be 0x10001.
> +
> +What:		/sys/class/firmware-attributes/*/authentication/SPM/status
> +Date:		March 2023
> +KernelVersion:	5.18

Why 5.18 and that date?

> +Contact:	"Jorge Lopez" <jorge.lopez2@hp.com>
> +Description:
> +		'status' is a read-only file that returns ASCII text in JSON format reporting
> +		the status information.
> +
> +		  "State": "not provisioned | provisioned | provisioning in progress ",

Drop the space after "in progress" ?

> +		  "Version": " Major. Minor ",

So Major. should have a space before and after it? and Minor should have a space after it?

> +		  "Nonce": <16-bit unsigned number display in base 10>,
> +		  "FeaturesInUse": <16-bit unsigned number display in base 10>,
> +		  "EndorsementKeyMod": "<256 bytes in base64>",
> +		  "SigningKeyMod": "<256 bytes in base64>"
> +
> +What:		/sys/class/firmware-attributes/*/attributes/Sure_Start/audit_log_entries
> +Date:		March 2023
> +KernelVersion:	5.18

Why 5.18 and that date?

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
> +Date:		March 2023
> +KernelVersion:	5.18

Why 5.18 and that date?

> +Contact:	"Jorge Lopez" <jorge.lopez2@hp.com>
> +Description:
> +		'audit_log_entry_count' is a read-only file that returns the number of existing
> +		audit log events available to be read. Values are separated using comma (``,``)

End the sentence above with a '.' please.

> +
> +			[No of entries],[log entry size],[Max number of entries supported]
> +
> +		log entry size identifies audit log size for the current BIOS version.
> +		The current size is 16 bytes but it can be up to 128 bytes long in future BIOS
> +		versions.

Thanks.
-- 
~Randy
