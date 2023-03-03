Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C556A8FE8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 04:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjCCDcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 22:32:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCCDct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 22:32:49 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D593E608
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 19:32:45 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id q23so710654pgt.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 19:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1677814365;
        h=to:references:message-id:cc:date:in-reply-to:from:subject
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lemNha6CdZ03DdpY+DGIXxDoAzjAR/JIIRXioSxiGsY=;
        b=nPmT3nZCj8Ifn2vQPaoKgqZzHSFQzBpt3Y0naZPvrxsnd4IFQkNEtxStcDwHXC/UKA
         VP2wySlPhbG0fTgOAM+EUnU7of9TZ6elMhaEpp5H9B/zkqYTR4Dxn859YjamZh8zTlLg
         HbBxm4GJW8xcBohqHiv5cj66bNfgyL6KgTbNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677814365;
        h=to:references:message-id:cc:date:in-reply-to:from:subject
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lemNha6CdZ03DdpY+DGIXxDoAzjAR/JIIRXioSxiGsY=;
        b=ibIOC+B5IPxbLHdgEd5BzjeaBqUBYFg+vv8JVMNY0pbuVJE9F2bYaP9Zj1yQa/SDkE
         tYb3PfO3Qju51D/4snkeN+TsbTD2RZ6YisrUWU3p0EnXDmKRWaMASvSLdkm17G1q2Nx/
         HnNS04V5wvYsOWur8bJWFuxp9fo9yj/npm5Y+q3I/bPHtjPe39ApAEh3488/ZAEMixck
         /YV489MVTHoXk2gARpM0ksr7Y0Uj+MzoavqYo85Rnm/45oknodJJ5XAoiZqTkGSQQSIN
         YvLM/Bs1xvI9ledZrqXZZp332iX01xo9R0xOvKypl4r8tKYWmUJx85ZrQSONWT6EqEJu
         XLsg==
X-Gm-Message-State: AO0yUKUdYx6zFztMk1hm8xeJA/4uX1+msfVQdfdG6+5dKWXkA+6WZQiS
        tr2nbXUpCf2gU0pVJH4/VeU9WA==
X-Google-Smtp-Source: AK7set/YExY2J9v1FwHxhkrx+vpSlKbYcmsaKdoSGDfyWSmgRomqp7Dmt2eZvX56Dfa+ysW+AOAu0g==
X-Received: by 2002:a62:6185:0:b0:5a9:d4fa:d3c7 with SMTP id v127-20020a626185000000b005a9d4fad3c7mr762211pfb.7.1677814364987;
        Thu, 02 Mar 2023 19:32:44 -0800 (PST)
Received: from smtpclient.apple ([2601:200:c001:9ec0:45cf:6564:e2d8:9372])
        by smtp.gmail.com with ESMTPSA id z23-20020aa785d7000000b005d6cb790c35sm421449pfn.119.2023.03.02.19.32.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Mar 2023 19:32:44 -0800 (PST)
Content-Type: multipart/signed;
        boundary="Apple-Mail=_2F6FE8AF-033C-4E1C-86E1-66A770DB9386";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.2\))
Subject: Re: [PATCH] x86: enable Data Operand Independent Timing Mode
From:   Roxana Bradescu <roxabee@chromium.org>
In-Reply-To: <fbf8d93e-2426-67f7-33c6-fe7d1a1a15b2@intel.com>
Date:   Thu, 2 Mar 2023 19:32:41 -0800
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Adam Langley <agl@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Pawan Kumar Gupta <pawan.kumar.gupta@intel.com>,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>
Message-Id: <29D41476-1617-4F6C-9046-82FBE70E01C9@chromium.org>
References: <20230125012801.362496-1-ebiggers@kernel.org>
 <fbf8d93e-2426-67f7-33c6-fe7d1a1a15b2@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
X-Mailer: Apple Mail (2.3696.120.41.1.2)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_2F6FE8AF-033C-4E1C-86E1-66A770DB9386
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On Feb 3, 2023, at 10:25 AM, Dave Hansen <dave.hansen@intel.com> =
wrote:
>=20
> BTW, I'm basically moving forward assuming that we're going to apply
> this patch in _some_ form.  I'm going to make some changes, but I'll
> discuss them in this thread to make sure we're all on the same page =
first.

Just checking in on the changes mentioned here.

> On 1/24/23 17:28, Eric Biggers wrote:
>> +Affected CPUs
>> +-------------
>> +
>> +This vulnerability affects Intel Core family processors based on the =
Ice Lake
>> +and later microarchitectures, and Intel Atom family processors based =
on the
>> +Gracemont and later microarchitectures.  For more information, see =
Intel's
>> +documentation [1]_.
>=20
> I had a hard time following the docs in this area.
>=20
> But I'm not sure this statement is correct.  The docs actually say:
>=20
> 	For Intel=C2=AE Core=E2=84=A2 family processors based on =
microarchitectures
> 	before Ice Lake and Intel Atom=C2=AE family processors based on
> 	microarchitectures before Gracemont that do not enumerate
> 	IA32_UARCH_MISC_CTL, developers may assume that the instructions
> 	listed here operate as if DOITM is enabled.

Have we been able to clarify if this assumption is guaranteed?

>=20
> A processor needs to be before "Ice Lake" and friends *AND* not
> enumerate IA32_UARCH_MISC_CTL to be unaffected.
>=20
> There's also another tweak that's needed because:
>=20
> 	Processors that do not enumerate IA32_ARCH_CAPABILITIES[DOITM]
> 	when the latest microcode is applied do not need to set
> 	IA32_UARCH_MISC_CTL [DOITM] in order to have the behavior
> 	described in this document...
>=20
> First, we need to mention the "latest microcode" thing in the kernel
> docs.  I also _think_ the whole "microarchitectures before" stuff is
> rather irrelevant and we can simplify this down to:
>=20
> 	This vulnerability affects all Intel processors that support
> 	MSR_IA32_ARCH_CAPABILITIES and set =
MSR_IA32_ARCH_CAPABILITIES[DOITM]
> 	when the latest microcode is applied.
>=20

Certainly a lot cleaner. Would be great if the Intel docs reflected =
this.

=E2=80=94
Regards, Roxana


> Which reminds me.  This:
>=20
>> +void update_doitm_msr(void)
>> +{
>> +	u64 msr;
>> +
>> +	if (doitm_off)
>> +		return;
>> +
>> +	rdmsrl(MSR_IA32_UARCH_MISC_CTL, msr);
>> +	wrmsrl(MSR_IA32_UARCH_MISC_CTL, msr | UARCH_MISC_DOITM);
>> +}
>=20
> should probably be:
>=20
> void update_doitm_msr(void)
> {
> 	u64 msr;
>=20
> 	/*
> 	 * All processors that enumerate support for DOIT
> 	 * are affected *and* have the mitigation available.
> 	 */
> 	if (!boot_cpu_has_bug(X86_BUG_DODT))
> 		return;
>=20
> 	rdmsrl(MSR_IA32_UARCH_MISC_CTL, msr);
> 	if (doitm_off)
> 		msr &=3D ~UARCH_MISC_DOITM;
> 	else
> 		msr |=3D UARCH_MISC_DOITM;
> 	wrmsrl(MSR_IA32_UARCH_MISC_CTL, msr);
> }
>=20
> in case the CPU isn't actually coming out of reset, like if kexec() =
left
> DOITM=3D1.
>=20


--Apple-Mail=_2F6FE8AF-033C-4E1C-86E1-66A770DB9386
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEgZzAKV63cJrecgABXEIiv89pXdUFAmQBalkACgkQXEIiv89p
XdVLvA//fTFy+1BHiMaqGNYoPma392WQGm3Y/qzx/bVE9r1fwhMrqk/yZ2GPw+L0
C8JprobKgy9/4xHx5AEaw9zASJVg7beTfsyqZ8bqpx5uA4Ct2G/nzljOl/NEWXFE
pGRCzeluyG17qBrARsQXM6/sXhHHSPeFTgl80DkW+CJgy9PjjPxvp2oURyOx8bLr
Y1bgyFMHJhHuMpXHNyneqSMnngSFybB084YcYkLhsLmL7YMT1IEOYdEkPWB+F/ta
9KYI7HMA1PKRsFtSDmGahujFLXT3QrQ8UpODp1+leUxEjwDe5F6crZmWbzTMu0xj
jqUgTbG2QHcD895trUSBU499PIeCOU4CUJoCBFoXe0O/5oa911teyfwjTHxRXAri
42KX1nlh6nwfDrKHVEuJXxn03MyzSXpxTQtzM7MKrejXcZTuH0HOjB0kCpo9sSR7
774y2nFhSRTxpl6eldK4Gq5wy7dszfsHe9PV0n1+AwqO3x8Azj1MO5tfAld0Y/y9
fpL7XHrS4sEc6rnR9USkYy2P5kaPx7v3WxtRuc57beGAo3xwqUOKmQ6SglOQI8u3
51TWfAhmzZBSVa4S7NiAeGCvKLSX0IoAuExNbWq5oOQCQ0EAkMSv+LendkwIFIaB
P/deUgANTrk5/kCM69USslq7H0HAxH+ltu3cyawgirILwS5NICk=
=8hd8
-----END PGP SIGNATURE-----

--Apple-Mail=_2F6FE8AF-033C-4E1C-86E1-66A770DB9386--
