Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA88A6C9073
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 20:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjCYTZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 15:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjCYTZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 15:25:32 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B715430C0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 12:25:31 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 401EC5C0054;
        Sat, 25 Mar 2023 15:25:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sat, 25 Mar 2023 15:25:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1679772329; x=
        1679858729; bh=F20hN5cmoUb7ZMiQCIUcAf557ZHjOrjpfezAUz/+nzY=; b=C
        Gmc+c3g2DEkoY4krwTCYYXVNEm+SGdPUafJ/YisY5tj9vOW/nG8lJeb8ujJmXhgt
        WaFn1p3ENyvGzc7a+Agl7amh4dxpKoh9fXmL9QgMxiwL0XdWlGh1PHZnInZVzYrV
        k7h6ZuY9q8KVdN+0aZUbUSGs7JacG1oqxuUDpoDaUcY5YmBovRT4GrWeaW+k3KJN
        Kys82rcorrTbJb4KWv2elly7uN4w/JQzuycfp3H4YfWJeBQnq63qXtVZbvNgAYmk
        mx16ervjNfDHp0Kv/Jzsyrm5WAEjPwd8iezXDVVbswidLnooTW2NiNa3QM0pg0cW
        q/ylnuCpIXoc0b2znYjRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679772329; x=1679858729; bh=F20hN5cmoUb7Z
        MiQCIUcAf557ZHjOrjpfezAUz/+nzY=; b=EeoXI1YzVWVTVkWRPBhlqMVKiYj1m
        OEO7NioGTasn/v6KcdceRJfqBWBs8iSQTYgCxKTfYDDn4FHh+HsENI/nqSBc0aqA
        kNMYWigMUqg//mXOHhOY4QcHMCbg36mNpw9yQFHRz696PZP5pTqqkFxg1JwCindz
        ohCO+8650NTj22LgHZCujr1+NT5Ua/HQPw/TpBVCtqQuwvEkP8O3W0nvNhLOb+Ib
        d8UVHgMLiq9wbAJ+pSiu8YdF9m3Mib9uyIioFqB+LDjHLiWzdUwoxto0MtP+jp1A
        Y0sZouOYrXSFNITmxhVdlQVeydyU0w9lN+8BnH0fQn7OhQxWLhCwVQD6w==
X-ME-Sender: <xms:qEofZFbj3ZwkojFP_FtkKRlkASPhBaZjbTNCCDyGrJDax7PtziRn8Q>
    <xme:qEofZMYr95OvaMveRgxrWiMVPiuJzPZK4df54sxZr1hnGl7I1DfTUZj872gvLHBUj
    _CRoJroVF80ZFfI_Dg>
X-ME-Received: <xmr:qEofZH_feRcMb5omIRCp7IS3Jpzc4r8J3dEtrLJWuRdHSCMDcbvxw6SzlWwWoe4kPDcNcA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegkedguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpedfmfhi
    rhhilhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrd
    hnrghmvgeqnecuggftrfgrthhtvghrnhepkedvvdejffehteegtddvgfeijeeivdegjeei
    teejheeiheevffeukeefheffvdevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:qEofZDqvp-0wO6OYQc43RDh8s_Jcxaj87GPSdKgh6GCNDkYZ26Q9Qg>
    <xmx:qEofZAp8j-mVWsJh15v_keUQ3eYUmOaKKJ2EpMeYo0lwB-2Kp5bdhw>
    <xmx:qEofZJRop-GA93lYkhH5yI5dzfDoqqlKyYq1GFUqt9-7xPgQpIFJnQ>
    <xmx:qUofZMel6wZsOl35SUCqFcc5Nqu553awLhZgPgpSeFtGFKmywS3uMQ>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 25 Mar 2023 15:25:27 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 3965210A607; Sat, 25 Mar 2023 22:25:24 +0300 (+03)
Date:   Sat, 25 Mar 2023 22:25:24 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: Disable kexec for TDX guests
Message-ID: <20230325192524.wetlbycbcsxc4plk@box>
References: <20230325160128.21857-1-kirill.shutemov@linux.intel.com>
 <ebead33b-0594-73df-56ae-f40473ac0ffc@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebead33b-0594-73df-56ae-f40473ac0ffc@intel.com>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 25, 2023 at 09:25:36AM -0700, Dave Hansen wrote:
> On 3/25/23 09:01, Kirill A. Shutemov wrote:
> > The last item is tricky. TDX guests use ACPI MADT MPWK to bring up
> > secondary CPUs. The mechanism doesn't allow to put a CPU back offline if
> > it has woken up.
> ...
> > +int arch_kexec_load(void)
> > +{
> > +	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
> > +		pr_warn_once("Disable kexec: not yet supported in TDX guest\n");
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	return 0;
> > +}
> 
> So, let's put all this together:
> 
> 1. TDX implementations use MADT for wakeup exclusively right now (but
>    are not necessarily _required_ to do so forever)
> 2. MADT doesn't support CPU offlining
> 3. kexec() requires offlining
> 
> Thus, current TDX implementations can't support TDX guests.  This
> *doesn't* say that TDX will always use the MADT for wakeups.
> 
> Yet, the check you have here is for TDX and *not* for the MADT.

As I described in the commit message there are more than MADT that is
required to get kexec in TDX guest.

> That seems wrong.
> 
> Let's say SEV or arm64 comes along and uses the MADT for their guests.
> They'll add another arch_kexec_load(), with a check for *their* feature.
> 
> This all seems like you should be disabling kexec() the moment the MADT
> CPU wakeup is used instead of making it based on TDX.

I guess we can go this path if you are fine with taking CR4.MCE and shared
memory reverting patches (they require some rework, but I can get them
into shape quickly). After that we can forbid kexec on machines with MADT
if nr_cpus > 1.

Sounds good?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
