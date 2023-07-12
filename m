Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D974874FEE6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 07:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbjGLFzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 01:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbjGLFzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 01:55:18 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491081980
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 22:55:15 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id BE1653200941;
        Wed, 12 Jul 2023 01:55:10 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute1.internal (MEProxy); Wed, 12 Jul 2023 01:55:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1689141310; x=1689227710; bh=g2
        CrOB7itySQdfb2/Ubwle1D99PlUqeUd79aKf+Qx8A=; b=R33SEyyHcV+cPwZPpM
        6Axf3tTUGzpH5YcdGsD//GG020fsIaNLuqNINxsJC7B9OEw6hY6dmjIc/BMzuekB
        V2Y5OeZZ0TFNiwi+ENjLRF6KEZEEdUv9ya+MQqHYXU5pBf03NylHlALGlqBl2txk
        0fGpmDyKLYH7fJm/qZvgT+yvIOXt1tUdjksTwf3+IhRRIqVNChLS5f0b9Z2DeA2r
        XU6Eyh+El6LxvW2qSMU32XlZ0I2ZuiBb+L52rqpW2zbZWmtfT8USQ/D4n5Ck2cuS
        IpfH0lUPX9jyjsJeea6dx/rQqCDHs6G4Ucc30meN0UQ++GiDRyfzcIoL1DrSfOtq
        KLxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1689141310; x=1689227710; bh=g2CrOB7itySQd
        fb2/Ubwle1D99PlUqeUd79aKf+Qx8A=; b=qGS+woU3vo/RKvuYmA4RN8uOwR/bU
        fsQIHCD/PYSLeytHrzioUvJvsiv6yxfbItrP0UZs/aw89VdGjZu85ZFwZF9I3yXn
        3zgZozPTWHTPchN1Lu3nPc/Qbwi4mEjAoNfw5D1g5oz+B+WZcU/vnx2fHm+vDC4i
        ubuixi+sxuZmR/BOemII83lBwR6ovczMYuyiwsIN9Jl9xcpbHjO/LL6tYtiPFJDc
        jwB/WmtL549D0iWNsBbLY6P2CfBEom8pg/FFJDNX5S+E7m8fBWuU4FyKVd0K16ls
        hcx5zqv2XclpCwLEa8O0wwoRWmJ2dkiqOuGM0zO5PJHDkE9jE+XdpuvLw==
X-ME-Sender: <xms:PUCuZPgpOqHcK5rMwp_rDcvpZUrfCQ4x3KaDXfyjuT6KxHtwmrqJTw>
    <xme:PUCuZMDKDvAz_-DWAV8VPViEXv1ZvQmfltzC2Tu5dDfNqCageccDv9lrRkrqTDgps
    RegowBmJJezXGVTGw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrfedugddutddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfufht
    vghfrghnucfqkdftvggrrhdfuceoshhorhgvrghrsehfrghsthhmrghilhdrtghomheqne
    cuggftrfgrthhtvghrnheptefhjeejteejfeehteeugeelveevieefudegveehleelueev
    teeludfhjeehleeinecuffhomhgrihhnpehrihhstghvrdhorhhgpdhinhhfrhgruggvrg
    gurdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepshhorhgvrghrsehfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:PUCuZPEr1eAUWiJq7_egbUpfgaB3vxBwx3F0sm14T77r0ps8A0FJSA>
    <xmx:PUCuZMSnTQVRykJxw7uTZ0bbkASODtXK1LSEefYc1E6dm5Z3GLj7zw>
    <xmx:PUCuZMxKvuPPXKiiwBgtcyqXr5SY3EFC6DKw_bkUuWTYj0ttvY2y6g>
    <xmx:PkCuZIgoC4TFwCiT-sfwBITbHCIKC_ah6ElFraDQZs5y2h7neNwKjw>
Feedback-ID: i84414492:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B59351700089; Wed, 12 Jul 2023 01:55:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-531-gfdfa13a06d-fm-20230703.001-gfdfa13a0
Mime-Version: 1.0
Message-Id: <7a8ea477-8f42-43dd-9748-556cfe645f5e@app.fastmail.com>
In-Reply-To: <ZKu6bCMPX0WKetVp@vermeer>
References: <20230627143747.1599218-1-sameo@rivosinc.com>
 <20230627143747.1599218-3-sameo@rivosinc.com>
 <348f624f-3be0-4df7-ab5d-4a912197d82b@app.fastmail.com>
 <ZJwFs2O85pvjCLXa@vermeer>
 <b208a2cb-bf68-4f4f-9c99-6a2e5853d26e@app.fastmail.com>
 <ZKu6bCMPX0WKetVp@vermeer>
Date:   Wed, 12 Jul 2023 01:54:39 -0400
From:   "Stefan O'Rear" <sorear@fastmail.com>
To:     "Samuel Ortiz" <sameo@rivosinc.com>
Cc:     "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Albert Ou" <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux@rivosinc.com,
        "Conor Dooley" <conor.dooley@microchip.com>,
        "Andrew Jones" <ajones@ventanamicro.com>,
        "Heiko Stuebner" <heiko.stuebner@vrull.eu>,
        "Anup Patel" <apatel@ventanamicro.com>,
        linux-kernel@vger.kernel.org,
        "Hongren (Zenithal) Zheng" <i@zenithal.me>,
        guoren <guoren@kernel.org>, "Atish Patra" <atishp@rivosinc.com>,
        =?UTF-8?Q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@rivosinc.com>,
        "Evan Green" <evan@rivosinc.com>
Subject: Re: [PATCH 2/3] RISC-V: hwprobe: Expose Zbc and the scalar crypto extensions
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023, at 3:59 AM, Samuel Ortiz wrote:
> On Wed, Jun 28, 2023 at 09:25:02AM -0400, Stefan O'Rear wrote:
>> On Wed, Jun 28, 2023, at 6:04 AM, Samuel Ortiz wrote:
>> > On Tue, Jun 27, 2023 at 08:34:20PM -0400, Stefan O'Rear wrote:
>> >> On Tue, Jun 27, 2023, at 10:37 AM, Samuel Ortiz wrote:
>> >> > Zbc was missing from a previous Bit-Manipulation extension hwprobe
>> >> > patch.
>> >> >
>> >> > Add all scalar crypto extensions bits, and define a macro for setting
>> >> > the hwprobe key/pair in a more readable way.
>> >> >
>> >> > Signed-off-by: Samuel Ortiz <sameo@rivosinc.com>
>> >> > ---
>> >> >  Documentation/riscv/hwprobe.rst       | 33 ++++++++++++++++++++++++
>> >> >  arch/riscv/include/uapi/asm/hwprobe.h | 11 ++++++++
>> >> >  arch/riscv/kernel/sys_riscv.c         | 36 ++++++++++++++++-----------
>> >> >  3 files changed, 66 insertions(+), 14 deletions(-)
>> >> >
>> >> > diff --git a/Documentation/riscv/hwprobe.rst b/Documentation/riscv/hwprobe.rst
>> >> > index 19165ebd82ba..3177550106e0 100644
>> >> > --- a/Documentation/riscv/hwprobe.rst
>> >> > +++ b/Documentation/riscv/hwprobe.rst
>> >> > @@ -72,11 +72,44 @@ The following keys are defined:
>> >> >         extensions.
>> >> > 
>> >> >    * :c:macro:`RISCV_HWPROBE_EXT_ZBB`: The Zbb extension is supported, 
>> >> > as defined
>> >> > +      in version 1.0 of the Bit-Manipulation ISA extensions.
>> >> > +
>> >> > +  * :c:macro:`RISCV_HWPROBE_EXT_ZBC`: The Zbc extension is supported, 
>> >> > as defined
>> >> >         in version 1.0 of the Bit-Manipulation ISA extensions.
>> >> > 
>> >> >    * :c:macro:`RISCV_HWPROBE_EXT_ZBS`: The Zbs extension is supported, 
>> >> > as defined
>> >> >         in version 1.0 of the Bit-Manipulation ISA extensions.
>> >> > 
>> >> > +  * :c:macro:`RISCV_HWPROBE_EXT_ZBKB`: The Zbkb extension is 
>> >> > supported, as defined
>> >> > +    in version 1.0 of the Scalar Cryptography ISA extensions.
>> >> > +
>> >> > +  * :c:macro:`RISCV_HWPROBE_EXT_ZBKC`: The Zbkc extension is 
>> >> > supported, as defined
>> >> > +    in version 1.0 of the Scalar Cryptography ISA extensions.
>> >> > +
>> >> > +  * :c:macro:`RISCV_HWPROBE_EXT_ZBKX`: The Zbkx extension is 
>> >> > supported, as defined
>> >> > +    in version 1.0 of the Scalar Cryptography ISA extensions.
>> >> > +
>> >> > +  * :c:macro:`RISCV_HWPROBE_EXT_ZKND`: The Zknd extension is 
>> >> > supported, as defined
>> >> > +    in version 1.0 of the Scalar Cryptography ISA extensions.
>> >> > +
>> >> > +  * :c:macro:`RISCV_HWPROBE_EXT_ZKNE`: The Zkne extension is 
>> >> > supported, as defined
>> >> > +    in version 1.0 of the Scalar Cryptography ISA extensions.
>> >> > +
>> >> > +  * :c:macro:`RISCV_HWPROBE_EXT_ZKNH`: The Zknh extension is 
>> >> > supported, as defined
>> >> > +    in version 1.0 of the Scalar Cryptography ISA extensions.
>> >> > +
>> >> > +  * :c:macro:`RISCV_HWPROBE_EXT_ZKR`: The Zkr extension is supported, 
>> >> > as defined
>> >> > +    in version 1.0 of the Scalar Cryptography ISA extensions.
>> >> > +
>> >> > +  * :c:macro:`RISCV_HWPROBE_EXT_ZKSED`: The Zksed extension is 
>> >> > supported, as defined
>> >> > +    in version 1.0 of the Scalar Cryptography ISA extensions.
>> >> > +
>> >> > +  * :c:macro:`RISCV_HWPROBE_EXT_ZKSH`: The Zksh extension is 
>> >> > supported, as defined
>> >> > +    in version 1.0 of the Scalar Cryptography ISA extensions.
>> >> > +
>> >> > +  * :c:macro:`RISCV_HWPROBE_EXT_ZKT`: The Zkt extension is supported, 
>> >> > as defined
>> >> > +    in version 1.0 of the Scalar Cryptography ISA extensions.
>> >> > +
>> >> >  * :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: A bitmask that contains 
>> >> > performance
>> >> >    information about the selected set of processors.
>> >> > 
>> >> > diff --git a/arch/riscv/include/uapi/asm/hwprobe.h 
>> >> > b/arch/riscv/include/uapi/asm/hwprobe.h
>> >> > index 006bfb48343d..8357052061b3 100644
>> >> > --- a/arch/riscv/include/uapi/asm/hwprobe.h
>> >> > +++ b/arch/riscv/include/uapi/asm/hwprobe.h
>> >> > @@ -29,6 +29,17 @@ struct riscv_hwprobe {
>> >> >  #define		RISCV_HWPROBE_EXT_ZBA		(1 << 3)
>> >> >  #define		RISCV_HWPROBE_EXT_ZBB		(1 << 4)
>> >> >  #define		RISCV_HWPROBE_EXT_ZBS		(1 << 5)
>> >> > +#define		RISCV_HWPROBE_EXT_ZBC		(1 << 6)
>> >> > +#define		RISCV_HWPROBE_EXT_ZBKB		(1 << 7)
>> >> > +#define		RISCV_HWPROBE_EXT_ZBKC		(1 << 8)
>> >> > +#define		RISCV_HWPROBE_EXT_ZBKX		(1 << 9)
>> >> > +#define		RISCV_HWPROBE_EXT_ZKND		(1 << 10)
>> >> > +#define		RISCV_HWPROBE_EXT_ZKNE		(1 << 11)
>> >> > +#define		RISCV_HWPROBE_EXT_ZKNH		(1 << 12)
>> >> > +#define		RISCV_HWPROBE_EXT_ZKR		(1 << 13)
>> >> > +#define		RISCV_HWPROBE_EXT_ZKSED		(1 << 14)
>> >> > +#define		RISCV_HWPROBE_EXT_ZKSH		(1 << 15)
>> >> > +#define		RISCV_HWPROBE_EXT_ZKT		(1 << 16)
>> >> >  #define RISCV_HWPROBE_KEY_CPUPERF_0	5
>> >> >  #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
>> >> >  #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
>> >> > diff --git a/arch/riscv/kernel/sys_riscv.c 
>> >> > b/arch/riscv/kernel/sys_riscv.c
>> >> > index 26ef5526bfb4..df15926196b6 100644
>> >> > --- a/arch/riscv/kernel/sys_riscv.c
>> >> > +++ b/arch/riscv/kernel/sys_riscv.c
>> >> > @@ -145,20 +145,28 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe 
>> >> > *pair,
>> >> >  	for_each_cpu(cpu, cpus) {
>> >> >  		struct riscv_isainfo *isainfo = &hart_isa[cpu];
>> >> > 
>> >> > -		if (riscv_isa_extension_available(isainfo->isa, ZBA))
>> >> > -			pair->value |= RISCV_HWPROBE_EXT_ZBA;
>> >> > -		else
>> >> > -			missing |= RISCV_HWPROBE_EXT_ZBA;
>> >> > -
>> >> > -		if (riscv_isa_extension_available(isainfo->isa, ZBB))
>> >> > -			pair->value |= RISCV_HWPROBE_EXT_ZBB;
>> >> > -		else
>> >> > -			missing |= RISCV_HWPROBE_EXT_ZBB;
>> >> > -
>> >> > -		if (riscv_isa_extension_available(isainfo->isa, ZBS))
>> >> > -			pair->value |= RISCV_HWPROBE_EXT_ZBS;
>> >> > -		else
>> >> > -			missing |= RISCV_HWPROBE_EXT_ZBS;
>> >> > +#define SET_HWPROBE_EXT_PAIR(ext)					\
>> >> > +		do {							\
>> >> > +			if (riscv_isa_extension_available(isainfo->isa, ext)) \
>> >> > +				pair->value |= RISCV_HWPROBE_EXT_## ext; \
>> >> > +			else						\
>> >> > +				missing |= RISCV_HWPROBE_EXT_## ext;	\
>> >> > +		} while (false)						\
>> >> > +
>> >> > +		SET_HWPROBE_EXT_PAIR(ZBA);
>> >> > +		SET_HWPROBE_EXT_PAIR(ZBB);
>> >> > +		SET_HWPROBE_EXT_PAIR(ZBC);
>> >> > +		SET_HWPROBE_EXT_PAIR(ZBS);
>> >> > +		SET_HWPROBE_EXT_PAIR(ZBKB);
>> >> > +		SET_HWPROBE_EXT_PAIR(ZBKC);
>> >> > +		SET_HWPROBE_EXT_PAIR(ZBKX);
>> >> > +		SET_HWPROBE_EXT_PAIR(ZKND);
>> >> > +		SET_HWPROBE_EXT_PAIR(ZKNE);
>> >> > +		SET_HWPROBE_EXT_PAIR(ZKNH);
>> >> > +		SET_HWPROBE_EXT_PAIR(ZKR);
>> >> 
>> >> Does the presence of a HWPROBE_EXT bit imply that userspace software can
>> >> actually directly use the described feature?  If so, we should probably
>> >> not set ZKR unless mseccfg.USEED=1.
>> >
>> > mseccfg is MRW, so only accessible from M-mode only afaiu. So I don't
>> > think we would be able to check that from Linux in S-mode.
>> 
>> Check directly, no, but your patch already makes the assumption that
>> mseccfg.SSEED=1 if zkr is present in the device tree.  Which is fine as long
>> as that contract is documented somewhere (presumably, the device tree
>> binding; some of the language in the RVA22U64 profile spec implies USEED=0,
>> but linux does not require profiles and they don't exist for rv32).
>> 
>> If we want U-mode behavior to be discoverable and/or predictable, we have
>> three good options:
>
> Thanks for the suggestions.
>
>> Simplest: Document that we expect USEED=0 or USEED=1.  Set zkr appropriately
>> in hwprobe.
>> 
>> Most flexible: Work with the SBI people to add a SBI_EXT_FWFEATURE for USEED,
>> as well as defining the value on kernel entry.  Expose this via hwprobe and
>> a new prctl.
>
> I'd like to go down that route, but this depends on [1] to get
> accepted/merged first.
>
> Would it make sense to go with only documenting the USEED expectation
> for now and then move to the more flexible FWFEATURE SBI approach?

Yes.

I would start with an assumption that SSEED=1 (so that we can use it at all),
USEED=0 (because many systems will want to prevent unprivileged access to raw
hardware randomness, so we don't want the uABI to guarantee accessibility of
seed until a mechanism has been defined to communicate USEED to userspace),
and there is no nonstandard extension on the FWFT extension ID or nonstandard
use of reserved feature space (so we can probe for the USEED feature to
become available; this can be tightened once a specific feature ID is
allocated for USEED).

I assumed earlier in the thread that we would communicate USEED to userspace
by conditionally setting the RISCV_HWPROBE_EXT_ZKR flag.  This was an error
on my part as I assumed hwprobe could return different values per process,
but it uses data from the vvar area which only exists once per time
namespace.  A new mechanism will need to be developed.

-s

> Cheers,
> Samuel.
>
> [1] https://lists.riscv.org/g/tech-prs/message/540
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
