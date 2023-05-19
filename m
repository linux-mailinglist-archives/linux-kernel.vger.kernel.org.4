Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD741709E48
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 19:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbjESRf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 13:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbjESRfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 13:35:23 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D026D9;
        Fri, 19 May 2023 10:35:00 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 502613200988;
        Fri, 19 May 2023 13:34:53 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute5.internal (MEProxy); Fri, 19 May 2023 13:34:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1684517692; x=1684604092; bh=U9oQamkHJrcyuz/MOMR1QD9VneiNszPBitF
        +kT9Km38=; b=HnbkpTPdEi9LxxXNXOA5wq15KxTqKMe/IzQHobqP9bmqvhroXqT
        lqKJMVu2V371PJAbSXszaurm3PWKCr2h3GC+wCTlJGr8cnyuUJxi2GJOnk3j5E2X
        e7oKwqjv40LiHl2DZgKVRCPI1OhFF5Cj3RFBXTMfQ2kZArEVPHOfc8YekGZ1EdvV
        uxRe2QCcHJCTIJb/YEKijEJED45qm7rYd7EtdpG8MaS+zNk24G25NohyPRZ09hat
        KPr5tiduDU0A6na7H21EO67Lee8Ce5Tz+xvS9mGDPZaE4COMA89ZK07B109wD907
        fF91mkMZCFMPTii4/ml5SgTouyNAN4pqN1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1684517692; x=
        1684604092; bh=U9oQamkHJrcyuz/MOMR1QD9VneiNszPBitF+kT9Km38=; b=F
        /aody3UPYqFTnyF54tw6bah6mC4LnHgSRd4P9YxLAOiMA4mXXJnBpaeMuGqJf9+H
        7HdtgX5Eo/5kbkaezVHEg2QtODXpSwBnM+XT/IES+S+Z0HoPyVZ6oUWeDdxDIv1G
        tqgIhZAtQLzqaWKrC3IFfo0JHXCy8QSXdNVDLvadoj+bZ22yBFMQvX4IXEcAHkMM
        bY3SDYcN2+SV308JAVC12z17Co+fc1sB2EfLIrJSXzxsgi9OUjnSlZ4HVweJaiKn
        wn25kHRowP2fDpArfbHKOCRWplKNQfiKG7yFa0wr2o869kjS4pcqhzUbAuSyR1wq
        neneTrQlucsPh/JA9hcLw==
X-ME-Sender: <xms:PLNnZByLp8lQfL5SX8Icx0gg9MXvhF7u-trFejs2UJwrILxddSzRhw>
    <xme:PLNnZBR_FzEIyl0uTKBHGJa1_TsSoXVPhVNBNusmQ0FDNHjDnbogi_nwTLqH5yFxJ
    6ZLjlYsMXDVb_wj2ZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeihedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepfdfo
    rghrkhcurfgvrghrshhonhdfuceomhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsg
    gsrdgtrgeqnecuggftrfgrthhtvghrnhepffeuveduudehgfduhedtveegfedtheeuhfel
    teejtedvveefhfevuefhheegueeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepmhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgt
    rg
X-ME-Proxy: <xmx:PLNnZLVr_Xgvrv8SKW3JZ8VwYQX5weBdxWrENRikx_PA_kb6PwRdSQ>
    <xmx:PLNnZDjmarj_nsnwS9Y-T5KkG616FNi1GTnQQj2lQyPOB6_OI8rv_g>
    <xmx:PLNnZDAaPpg-OuucyYtk5Bl5gWJobPCduQExFrNDFoAFK9M9RF7nWQ>
    <xmx:PLNnZKMehJ_AGLeZLdsY4YZbLTtPuWKp-tfl9M6V_sXehK5RZSgIVw>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4E654C60093; Fri, 19 May 2023 13:34:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-431-g1d6a3ebb56-fm-20230511.001-g1d6a3ebb
Mime-Version: 1.0
Message-Id: <0abdb306-1e24-4653-9a14-e5db8d508a82@app.fastmail.com>
In-Reply-To: <20230517155026.28535-2-jorge.lopez2@hp.com>
References: <20230517155026.28535-1-jorge.lopez2@hp.com>
 <20230517155026.28535-2-jorge.lopez2@hp.com>
Date:   Fri, 19 May 2023 13:34:32 -0400
From:   "Mark Pearson" <mpearson-lenovo@squebb.ca>
To:     "Jorge Lopez" <jorgealtxwork@gmail.com>,
        "Hans de Goede" <hdegoede@redhat.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
        ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCH v14 01/13] hp-bioscfg: Documentation
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jorge,

On Wed, May 17, 2023, at 11:50 AM, Jorge Lopez wrote:
> HP BIOS Configuration driver purpose is to provide a driver supporting
> the latest sysfs class firmware attributes framework allowing the user
> to change BIOS settings and security solutions on HP Inc.=E2=80=99s co=
mmercial
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
> Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>
>
> ---
> Based on the latest platform-drivers-x86.git/for-next
> ---
>  .../testing/sysfs-class-firmware-attributes   | 102 +++++++++++++++++-
>  1 file changed, 100 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-class-firmware-attributes=20
> b/Documentation/ABI/testing/sysfs-class-firmware-attributes
> index 4cdba3477176..f8d6c089228b 100644
> --- a/Documentation/ABI/testing/sysfs-class-firmware-attributes
> +++ b/Documentation/ABI/testing/sysfs-class-firmware-attributes
<snip>
> +
> +
> +		HP specific class extensions - Secure Platform Manager (SPM)
> +		--------------------------------
> +
> +What:		/sys/class/firmware-attributes/*/authentication/SPM/kek
> +Date:		March 29
> +KernelVersion:	5.18
> +Contact:	"Jorge Lopez" <jorge.lopez2@hp.com>
> +Description:
> +		'kek' Key-Encryption-Key is a write-only file that can be used to=20
> configure the
> +		RSA public key that will be used by the BIOS to verify
> +		signatures when setting the signing key.  When written,
> +		the bytes should correspond to the KEK certificate
> +		(x509 .DER format containing an OU).  The size of the
> +		certificate must be less than or equal to 4095 bytes.
> +
> +What:		/sys/class/firmware-attributes/*/authentication/SPM/sk
> +Date:		March 29
> +KernelVersion:	5.18
> +Contact:	"Jorge Lopez" <jorge.lopez2@hp.com>
> +Description:
> +		'sk' Signature Key is a write-only file that can be used to=20
> configure the RSA
> +		public key that will be used by the BIOS to verify signatures
> +		when configuring BIOS settings and security features.  When
> +		written, the bytes should correspond to the modulus of the
> +		public key.  The exponent is assumed to be 0x10001.
> +
> +What:		/sys/class/firmware-attributes/*/authentication/SPM/status
> +Date:		March 29
> +KernelVersion:	5.18
> +Contact:	"Jorge Lopez" <jorge.lopez2@hp.com>
> +Description:
> +		'status' is a read-only file that returns ASCII text in JSON format=20
> reporting
> +		the status information.
> +
> +		  "State": "not provisioned | provisioned | provisioning in progres=
s=20
> ",
> +		  "Version": " Major. Minor ",
> +		  "Nonce": <16-bit unsigned number display in base 10>,
> +		  "FeaturesInUse": <16-bit unsigned number display in base 10>,
> +		  "EndorsementKeyMod": "<256 bytes in base64>",
> +		  "SigningKeyMod": "<256 bytes in base64>"
> +
> +What:		/sys/class/firmware-attributes/*/attributes/Sure_Start/audit_l=
og_entries
> +Date:		March 29
> +KernelVersion:	5.18
> +Contact:	"Jorge Lopez" <jorge.lopez2@hp.com>
> +Description:
> +		'audit_log_entries' is a read-only file that returns the events in=20
> the log.
> +
> +			Audit log entry format
> +
> +			Byte 0-15:   Requested Audit Log entry  (Each Audit log is 16 byte=
s)
> +			Byte 16-127: Unused
> +
> +What:		/sys/class/firmware-attributes/*/attributes/Sure_Start/audit_l=
og_entry_count
> +Date:		March 29
> +KernelVersion:	5.18
> +Contact:	"Jorge Lopez" <jorge.lopez2@hp.com>
> +Description:
> +		'audit_log_entry_count' is a read-only file that returns the number=20
> of existing
> +		audit log events available to be read. Values are separated using=20
> comma (``,``)
> +
> +			[No of entries],[log entry size],[Max number of entries supported]
> +
> +		log entry size identifies audit log size for the current BIOS=20
> version.
> +		The current size is 16 bytes but it can be up to 128 bytes long in=20
> future BIOS
> +		versions.
> --=20
> 2.34.1

Firstly apologies as I've done a poor job of following the updates to th=
is series - so if this has already been discussed and agreed by more sea=
soned kernel contributors please feel free to disregard my comments :) I=
 was catching up on my inbox and had some thoughts.

For SPM - as this replaces password usage, is it done for all account ty=
pes? It seems a bit odd having it be a replacement for the passwords but=
 in it's own location and not in the same place as (for example) Admin/c=
urrent_password.
For the Lenovo implementation I put certificate, signature and save_sign=
ature in the authentication/Admin directory and I realise your implement=
ation is different with the keys but if the kek and sk are only used wit=
h the Admin account then shouldn't they also be in that directory? It wo=
uld be nice to have some commonality across vendors in my opinion.

For the Sure_Start I would propose de-branding this so it's generic and =
I don't think it fits under attributes as it doesn't support any of the =
other required attribute fields. I think your implementation of an audit=
 log seems neat but if another vendor was to do similar it would be bett=
er to be able to reuse the same attribute name and enable common tooling=
.=20
I propose having this as just log/audit_entries and log/audit_count and =
have the log folder in the top alongside authentication and attributes.
If someone wants to add other logs in the future it would be a good plac=
e to have them.

Thanks
Mark
