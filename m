Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570F174125B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 15:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbjF1N0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 09:26:39 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:53063 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232257AbjF1NZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 09:25:25 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id B37115C014B;
        Wed, 28 Jun 2023 09:25:24 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute1.internal (MEProxy); Wed, 28 Jun 2023 09:25:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1687958724; x=1688045124; bh=Ma
        9sKV2c1sBHTd8ZWu4cjjSX5qCMtc4deQUI84zF0rw=; b=EgSeqjPqu/mlA0Txh1
        cDKku1HIrgTw8FsBqWsO9JmXaoDFpHLmjimwdV7qLHTqla1im6GCl9QNWfMWBjyU
        QERoCQECPtbmeVjAIRJ+yrf3kfuJ4aK1Cfz85pWwvmUMnbckFDcZ8HU5VPX2FPVJ
        7YJe8kOauR8uAP+a3dyimroXhT4bCRW7OQJb8Djpox5yygerdlxlixPRfpDFzo+d
        UQdhzROXlWN6D8n/2wuOiwG01sOcwiiExueKvDFwM077pYFWuEbP3fowbbi1yadz
        SbaLiqtO0Lg7q2q6iUfTqRXys+NFx55fb5qyQnOTKmD3KhLYK9Df7Co0Ym9YBzhX
        UmGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1687958724; x=1688045124; bh=Ma9sKV2c1sBHT
        d8ZWu4cjjSX5qCMtc4deQUI84zF0rw=; b=bKBVjRIB9EVHqMblgUpXaGJXVQzdD
        bEYo2eb/bVgypEuoliRimzyNDwXq0j0GV+L+9JsLYhOOGFHeAmovEB7Ef56Kx/7r
        Duvn8iKfT+hA4nK+M+XadjVxkAUIZnrAwLnyJI3KnqjlEXhcGVJF0wHJw6IIvgHd
        K4+GXyZcsasZ2UzHaJuN8JJbTen0rfo97kJIDlSluzn9dK/A0kZyxkx4EcL9mwO4
        Tv2erzDbRqqr8NIDrA54P885H1LRPPOog9FipwVfM6kpRTOaT//NoJuGQKDXy4Ey
        nXkBFd8PUFuiKDzu3H2f4LWGp2nRlDTz9JPIIKzg+oD/2jfQFYtRXJYqQ==
X-ME-Sender: <xms:xDScZM5oldn2zviXB5XnOdSDqitz3AhnMBVuT5XovDDV6y4_yEFJGQ>
    <xme:xDScZN7PpGqOCpE8JJSeoGnAkCIcD6nlIJTJyik8yxmrRMD7G9oDH4Go4Y9d_4SnV
    O8-Marbyury8hv4Nw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrtddvgdeifecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfuthgv
    fhgrnhcuqfdktfgvrghrfdcuoehsohhrvggrrhesfhgrshhtmhgrihhlrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpeefudejvdejuddvjeejudekgfeikeevveevleeitddvtedujeeg
    jeejgfeugfeiudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsohhrvggrrhesfhgrshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:xDScZLdN9pZEphSbGgd_KMIZuE2dzizY_kLrzOhG0C7eybGsnqoPCw>
    <xmx:xDScZBLtSCyP2EnFTaBMOKqXAZmiiOG0LjjpWvP6UciTgOaL5e6LhQ>
    <xmx:xDScZALh5sQo_OWpU7IEfY99DYcrkTb3fGEX1L7_aPr45Qs-J4zIFg>
    <xmx:xDScZDYcrhzlVAO3RtNTCgCGhFum6ZZUtYqwB0P_V3djRvBucoDBHA>
Feedback-ID: i84414492:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E7D011700089; Wed, 28 Jun 2023 09:25:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-499-gf27bbf33e2-fm-20230619.001-gf27bbf33
Mime-Version: 1.0
Message-Id: <b208a2cb-bf68-4f4f-9c99-6a2e5853d26e@app.fastmail.com>
In-Reply-To: <ZJwFs2O85pvjCLXa@vermeer>
References: <20230627143747.1599218-1-sameo@rivosinc.com>
 <20230627143747.1599218-3-sameo@rivosinc.com>
 <348f624f-3be0-4df7-ab5d-4a912197d82b@app.fastmail.com>
 <ZJwFs2O85pvjCLXa@vermeer>
Date:   Wed, 28 Jun 2023 09:25:02 -0400
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
        "Guo Ren" <guoren@kernel.org>, "Atish Patra" <atishp@rivosinc.com>,
        =?UTF-8?Q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@rivosinc.com>,
        "Evan Green" <evan@rivosinc.com>
Subject: Re: [PATCH 2/3] RISC-V: hwprobe: Expose Zbc and the scalar crypto extensions
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023, at 6:04 AM, Samuel Ortiz wrote:
> On Tue, Jun 27, 2023 at 08:34:20PM -0400, Stefan O'Rear wrote:
>> On Tue, Jun 27, 2023, at 10:37 AM, Samuel Ortiz wrote:
>> > Zbc was missing from a previous Bit-Manipulation extension hwprobe
>> > patch.
>> >
>> > Add all scalar crypto extensions bits, and define a macro for setting
>> > the hwprobe key/pair in a more readable way.
>> >
>> > Signed-off-by: Samuel Ortiz <sameo@rivosinc.com>
>> > ---
>> >  Documentation/riscv/hwprobe.rst       | 33 ++++++++++++++++++++++++
>> >  arch/riscv/include/uapi/asm/hwprobe.h | 11 ++++++++
>> >  arch/riscv/kernel/sys_riscv.c         | 36 ++++++++++++++++-----------
>> >  3 files changed, 66 insertions(+), 14 deletions(-)
>> >
>> > diff --git a/Documentation/riscv/hwprobe.rst b/Documentation/riscv/hwprobe.rst
>> > index 19165ebd82ba..3177550106e0 100644
>> > --- a/Documentation/riscv/hwprobe.rst
>> > +++ b/Documentation/riscv/hwprobe.rst
>> > @@ -72,11 +72,44 @@ The following keys are defined:
>> >         extensions.
>> > 
>> >    * :c:macro:`RISCV_HWPROBE_EXT_ZBB`: The Zbb extension is supported, 
>> > as defined
>> > +      in version 1.0 of the Bit-Manipulation ISA extensions.
>> > +
>> > +  * :c:macro:`RISCV_HWPROBE_EXT_ZBC`: The Zbc extension is supported, 
>> > as defined
>> >         in version 1.0 of the Bit-Manipulation ISA extensions.
>> > 
>> >    * :c:macro:`RISCV_HWPROBE_EXT_ZBS`: The Zbs extension is supported, 
>> > as defined
>> >         in version 1.0 of the Bit-Manipulation ISA extensions.
>> > 
>> > +  * :c:macro:`RISCV_HWPROBE_EXT_ZBKB`: The Zbkb extension is 
>> > supported, as defined
>> > +    in version 1.0 of the Scalar Cryptography ISA extensions.
>> > +
>> > +  * :c:macro:`RISCV_HWPROBE_EXT_ZBKC`: The Zbkc extension is 
>> > supported, as defined
>> > +    in version 1.0 of the Scalar Cryptography ISA extensions.
>> > +
>> > +  * :c:macro:`RISCV_HWPROBE_EXT_ZBKX`: The Zbkx extension is 
>> > supported, as defined
>> > +    in version 1.0 of the Scalar Cryptography ISA extensions.
>> > +
>> > +  * :c:macro:`RISCV_HWPROBE_EXT_ZKND`: The Zknd extension is 
>> > supported, as defined
>> > +    in version 1.0 of the Scalar Cryptography ISA extensions.
>> > +
>> > +  * :c:macro:`RISCV_HWPROBE_EXT_ZKNE`: The Zkne extension is 
>> > supported, as defined
>> > +    in version 1.0 of the Scalar Cryptography ISA extensions.
>> > +
>> > +  * :c:macro:`RISCV_HWPROBE_EXT_ZKNH`: The Zknh extension is 
>> > supported, as defined
>> > +    in version 1.0 of the Scalar Cryptography ISA extensions.
>> > +
>> > +  * :c:macro:`RISCV_HWPROBE_EXT_ZKR`: The Zkr extension is supported, 
>> > as defined
>> > +    in version 1.0 of the Scalar Cryptography ISA extensions.
>> > +
>> > +  * :c:macro:`RISCV_HWPROBE_EXT_ZKSED`: The Zksed extension is 
>> > supported, as defined
>> > +    in version 1.0 of the Scalar Cryptography ISA extensions.
>> > +
>> > +  * :c:macro:`RISCV_HWPROBE_EXT_ZKSH`: The Zksh extension is 
>> > supported, as defined
>> > +    in version 1.0 of the Scalar Cryptography ISA extensions.
>> > +
>> > +  * :c:macro:`RISCV_HWPROBE_EXT_ZKT`: The Zkt extension is supported, 
>> > as defined
>> > +    in version 1.0 of the Scalar Cryptography ISA extensions.
>> > +
>> >  * :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: A bitmask that contains 
>> > performance
>> >    information about the selected set of processors.
>> > 
>> > diff --git a/arch/riscv/include/uapi/asm/hwprobe.h 
>> > b/arch/riscv/include/uapi/asm/hwprobe.h
>> > index 006bfb48343d..8357052061b3 100644
>> > --- a/arch/riscv/include/uapi/asm/hwprobe.h
>> > +++ b/arch/riscv/include/uapi/asm/hwprobe.h
>> > @@ -29,6 +29,17 @@ struct riscv_hwprobe {
>> >  #define		RISCV_HWPROBE_EXT_ZBA		(1 << 3)
>> >  #define		RISCV_HWPROBE_EXT_ZBB		(1 << 4)
>> >  #define		RISCV_HWPROBE_EXT_ZBS		(1 << 5)
>> > +#define		RISCV_HWPROBE_EXT_ZBC		(1 << 6)
>> > +#define		RISCV_HWPROBE_EXT_ZBKB		(1 << 7)
>> > +#define		RISCV_HWPROBE_EXT_ZBKC		(1 << 8)
>> > +#define		RISCV_HWPROBE_EXT_ZBKX		(1 << 9)
>> > +#define		RISCV_HWPROBE_EXT_ZKND		(1 << 10)
>> > +#define		RISCV_HWPROBE_EXT_ZKNE		(1 << 11)
>> > +#define		RISCV_HWPROBE_EXT_ZKNH		(1 << 12)
>> > +#define		RISCV_HWPROBE_EXT_ZKR		(1 << 13)
>> > +#define		RISCV_HWPROBE_EXT_ZKSED		(1 << 14)
>> > +#define		RISCV_HWPROBE_EXT_ZKSH		(1 << 15)
>> > +#define		RISCV_HWPROBE_EXT_ZKT		(1 << 16)
>> >  #define RISCV_HWPROBE_KEY_CPUPERF_0	5
>> >  #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
>> >  #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
>> > diff --git a/arch/riscv/kernel/sys_riscv.c 
>> > b/arch/riscv/kernel/sys_riscv.c
>> > index 26ef5526bfb4..df15926196b6 100644
>> > --- a/arch/riscv/kernel/sys_riscv.c
>> > +++ b/arch/riscv/kernel/sys_riscv.c
>> > @@ -145,20 +145,28 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe 
>> > *pair,
>> >  	for_each_cpu(cpu, cpus) {
>> >  		struct riscv_isainfo *isainfo = &hart_isa[cpu];
>> > 
>> > -		if (riscv_isa_extension_available(isainfo->isa, ZBA))
>> > -			pair->value |= RISCV_HWPROBE_EXT_ZBA;
>> > -		else
>> > -			missing |= RISCV_HWPROBE_EXT_ZBA;
>> > -
>> > -		if (riscv_isa_extension_available(isainfo->isa, ZBB))
>> > -			pair->value |= RISCV_HWPROBE_EXT_ZBB;
>> > -		else
>> > -			missing |= RISCV_HWPROBE_EXT_ZBB;
>> > -
>> > -		if (riscv_isa_extension_available(isainfo->isa, ZBS))
>> > -			pair->value |= RISCV_HWPROBE_EXT_ZBS;
>> > -		else
>> > -			missing |= RISCV_HWPROBE_EXT_ZBS;
>> > +#define SET_HWPROBE_EXT_PAIR(ext)					\
>> > +		do {							\
>> > +			if (riscv_isa_extension_available(isainfo->isa, ext)) \
>> > +				pair->value |= RISCV_HWPROBE_EXT_## ext; \
>> > +			else						\
>> > +				missing |= RISCV_HWPROBE_EXT_## ext;	\
>> > +		} while (false)						\
>> > +
>> > +		SET_HWPROBE_EXT_PAIR(ZBA);
>> > +		SET_HWPROBE_EXT_PAIR(ZBB);
>> > +		SET_HWPROBE_EXT_PAIR(ZBC);
>> > +		SET_HWPROBE_EXT_PAIR(ZBS);
>> > +		SET_HWPROBE_EXT_PAIR(ZBKB);
>> > +		SET_HWPROBE_EXT_PAIR(ZBKC);
>> > +		SET_HWPROBE_EXT_PAIR(ZBKX);
>> > +		SET_HWPROBE_EXT_PAIR(ZKND);
>> > +		SET_HWPROBE_EXT_PAIR(ZKNE);
>> > +		SET_HWPROBE_EXT_PAIR(ZKNH);
>> > +		SET_HWPROBE_EXT_PAIR(ZKR);
>> 
>> Does the presence of a HWPROBE_EXT bit imply that userspace software can
>> actually directly use the described feature?  If so, we should probably
>> not set ZKR unless mseccfg.USEED=1.
>
> mseccfg is MRW, so only accessible from M-mode only afaiu. So I don't
> think we would be able to check that from Linux in S-mode.

Check directly, no, but your patch already makes the assumption that
mseccfg.SSEED=1 if zkr is present in the device tree.  Which is fine as long
as that contract is documented somewhere (presumably, the device tree
binding; some of the language in the RVA22U64 profile spec implies USEED=0,
but linux does not require profiles and they don't exist for rv32).

If we want U-mode behavior to be discoverable and/or predictable, we have
three good options:

Simplest: Document that we expect USEED=0 or USEED=1.  Set zkr appropriately
in hwprobe.

Most flexible: Work with the SBI people to add a SBI_EXT_FWFEATURE for USEED,
as well as defining the value on kernel entry.  Expose this via hwprobe and
a new prctl.

Most robust: Add an illegal instruction handler for CSR_SEED that grabs 16
bits from the kernel entropy pool.  Expose zkr in hwprobe unconditionally.

-s

> Cheers,
> Samuel.
