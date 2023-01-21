Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513976763A1
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 05:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjAUEJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 23:09:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjAUEJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 23:09:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D016AC84
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 20:09:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87776B82B5A
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 04:09:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B270FC4339B;
        Sat, 21 Jan 2023 04:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674274165;
        bh=tvYJqwTiwOme8ZfT8GFLENH2sbblSc0bvECSy70qQF0=;
        h=In-Reply-To:References:Date:From:To:Subject:From;
        b=jazTvjo8BPhLDso/T7H2Txx+ZRczWU4XoLP6P+EKsjQLihQb32YCg4k9jqNg7AYZB
         QQNRIr7L1303C6/MjgZNJkWc29j7rdNODp+hGM5lr5nmOa3EAuq+91DhN4WRyA8ETZ
         C2K5ZBKRuMUQ9WOjOTFM6SckgJ7qIwMcyHUHRq5P1XhZrdd6Imv2CvFEamKi0eOjxU
         tNITVMutK5NMxBOAFdQH57uxXQpqDUlY1yO4Gx/yze48Y4jImDfAldZ+ltAg7EKFYJ
         JfQxLTODn9seoKeFUqZTtegnB76QxkJ+dQ2QPyrQ+JJvCECbdrwwsBBgZEqktI+NTC
         YdJZk6CJk7dTQ==
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 97BF027C0054;
        Fri, 20 Jan 2023 23:09:23 -0500 (EST)
Received: from imap48 ([10.202.2.98])
  by compute3.internal (MEProxy); Fri, 20 Jan 2023 23:09:23 -0500
X-ME-Sender: <xms:c2XLY83V5_No5uTj5xPvk50xLj9PQycG3siUjWaflAHwXmUL5AuT5A>
    <xme:c2XLY3FSvkoFmulEngjzSDJPRnuGy-1uTf_JpGkTBPITyaLtLL8NiRsjLkkb0djmU
    1lvuP-5QxZ_ydz0LiQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddufedgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpedftehn
    ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnhepvdelheejjeevhfdutdeggefftdejtdffgeevteehvdfgjeeiveei
    ueefveeuvdetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudeiudek
    heeifedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuh
    igrdhluhhtohdruhhs
X-ME-Proxy: <xmx:c2XLY074psYGEsEuBsY8fim7Ib4BluT97L84N9s5-9NpH9ikURtWxA>
    <xmx:c2XLY105-WjuZPdAGAPFca_OCrzTNm6xovIbIHMofAYyvtbbuNcZyw>
    <xmx:c2XLY_G-pl-83ypF-ZQJN_MyDdZ8yep2nxQ1muG2Y9XhnuANjEY1uQ>
    <xmx:c2XLYwP8PnQ9b01ln5oODAyip7tI3ijXiduvVQDWxOUqcZ-ZVjrhug>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0032131A0063; Fri, 20 Jan 2023 23:09:22 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <b2124803-edc2-44de-8980-11ed74dd883e@app.fastmail.com>
In-Reply-To: <20230110055204.3227669-5-yian.chen@intel.com>
References: <20230110055204.3227669-1-yian.chen@intel.com>
 <20230110055204.3227669-5-yian.chen@intel.com>
Date:   Fri, 20 Jan 2023 20:09:02 -0800
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Yian Chen" <yian.chen@intel.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Sohil Mehta" <sohil.mehta@intel.com>,
        "Paul Lai" <paul.c.lai@intel.com>
Subject: Re: [PATCH 4/7] x86/vsyscall: Setup vsyscall to compromise LASS protection
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, Jan 9, 2023, at 9:52 PM, Yian Chen wrote:
> Kernel enables LASS automatically at starting time in LASS
> capable platforms. Any access to kernel addresses
> or upper half addresses from user space triggers a #GP
> fault.
>
> Legacy vsyscall does not comply with LASS, because
> the vsyscall functions are mapped in the range
> 0xffffffffff600000-0xffffffffff601000.
>
> In theory, it would be possible to write a #GP fault handler
> to emulate the old vsyscall behavior, but vsyscall has been
> deprecated for some time, so this has not been done.

The ISE docs are really quite explicit that #GP will have RIP pointing a=
t the vDSO if LASS is on. Unless I=E2=80=99ve missed something, this sho=
uld be quite straightforward to handle without breaking userspace compat=
ibility.  Let=E2=80=99s please do this.

>
> Therefore, when kernel enforces LASS, vsyscall does not work
> and should be disabled. On the other hand, the user can relax
> the enforcement by clearing lass cpu id (clearcpuid=3Dlass/390)
> or enabling vsyscall (vsyscall=3Dxxx) from kernel command line.
> The user can also opt-out LASS in config file to build kernel
> binary.
>
> Signed-off-by: Yian Chen <yian.chen@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 12 ++++++++----
>  arch/x86/entry/vsyscall/vsyscall_64.c           | 14 ++++++++++++++
>  2 files changed, 22 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt=20
> b/Documentation/admin-guide/kernel-parameters.txt
> index 6cfa6e3996cf..3988e0c8c175 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6755,10 +6755,14 @@
>  			versions of glibc use these calls.  Because these
>  			functions are at fixed addresses, they make nice
>  			targets for exploits that can control RIP.
> -
> -			emulate     [default] Vsyscalls turn into traps and are
> -			            emulated reasonably safely.  The vsyscall
> -				    page is readable.
> +			In newer versions of Intel platforms that come with
> +			LASS(Linear Address Space separation) protection,
> +			vsyscall is disabled by default. Enabling vsyscall
> +			via the parameter overrides LASS protection.
> +
> +			emulate     [default if not LASS capable] Vsyscalls
> +				    turn into traps and are emulated reasonably
> +				    safely.  The vsyscall page is readable.
>=20
>  			xonly       Vsyscalls turn into traps and are
>  			            emulated reasonably safely.  The vsyscall
> diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c=20
> b/arch/x86/entry/vsyscall/vsyscall_64.c
> index 4af81df133ee..2691f26835d1 100644
> --- a/arch/x86/entry/vsyscall/vsyscall_64.c
> +++ b/arch/x86/entry/vsyscall/vsyscall_64.c
> @@ -63,6 +63,12 @@ static int __init vsyscall_setup(char *str)
>  		else
>  			return -EINVAL;
>=20
> +		if (cpu_feature_enabled(X86_FEATURE_LASS) &&
> +		    vsyscall_mode !=3D NONE) {
> +			setup_clear_cpu_cap(X86_FEATURE_LASS);
> +			pr_warn("LASS disabled by command line enabling vsyscall\n");
> +		}
> +
>  		return 0;
>  	}
>=20
> @@ -379,6 +385,14 @@ void __init map_vsyscall(void)
>  	extern char __vsyscall_page;
>  	unsigned long physaddr_vsyscall =3D __pa_symbol(&__vsyscall_page);
>=20
> +	/*
> +	 * When LASS is on, vsyscall triggers a #GP fault,
> +	 * so that force vsyscall_mode to NONE.
> +	 */
> +	if (cpu_feature_enabled(X86_FEATURE_LASS)) {
> +		vsyscall_mode =3D NONE;
> +		return;
> +	}
>  	/*
>  	 * For full emulation, the page needs to exist for real.  In
>  	 * execute-only mode, there is no PTE at all backing the vsyscall
> --=20
> 2.34.1
