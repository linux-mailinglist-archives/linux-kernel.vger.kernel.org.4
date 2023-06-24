Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A6B73C689
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 05:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjFXDYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 23:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjFXDYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 23:24:15 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C854B1B9
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 20:24:13 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 6E5165C011D;
        Fri, 23 Jun 2023 23:24:10 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute1.internal (MEProxy); Fri, 23 Jun 2023 23:24:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1687577050; x=1687663450; bh=NbdyWgrnQuAJrNoZdsryau1ERtyp1m+gXJN
        ykYa1YxA=; b=aclqciry9m5HbcG/HJc5sV3Muf2uzQZuIE8Kf0t7MWfOFUMm9ZG
        44XKnZa1ch/yAHYgc4GanR9MG4Qf3ITHUToHKGiOxhKOyRcqc0U221PvtVdZUCnm
        Tgmf3aZjwRZVl3KsM0VarOYPOjSbDU+PwYdly7cKyRfkFt6KuDgqJr2ikmYKa2QL
        OTifyVr99i/3/l98CCpb+FuZbgSSbqo4zboRHTqh2//aXiFlc1EwIRSY6LsB+v4i
        qhkaGe/7mG95ZJpFHAlycqJldw+YV3rA4NLCSmWzokU7YRIg7UCtzdwwR7v06XtR
        JJ8dhRVihS4GbO0N5r17hDFdjstWjuebezQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1687577050; x=1687663450; bh=NbdyWgrnQuAJrNoZdsryau1ERtyp1m+gXJN
        ykYa1YxA=; b=d4PIRb+zNvInMZXg7uV18TR7u8P2aT5tk84+XExhpTh5ljIz2OZ
        m35wFQL92rhGx0fVwweFIxT6qXgsia+XGffYd6rAPTbBa3JiCdUIBKYsU2gGuw/A
        yY00txf7DV/BSJABn8ovoBPsuiGLN4OT+hv/ewJYy7cLo7QCZgWeJ31X9Iou0eaZ
        rIjBmEsundTHi4yW5HivwET0gmanqQo1Db2VhGqK0ueYXPsp1dgNA62EogH8dyeO
        vzja91pYhtXr5K1OinJ1IUlMeT47m0kmTpCb1Gm2bDrduJPS+DnLZD0953Xd6Y0f
        VPr4F7lVKPAnJlAmIePo66NWylam+qe4QRw==
X-ME-Sender: <xms:2WGWZDZ-zlWm-wRZUpQNB2tWCLs_8mYA2pYeaLdWVJattHGYvoIxBg>
    <xme:2WGWZCZdDoRMR_t-pOKuvs_UclNzmTLC85E_5d6-RdAMigffQuQ-mtl4VRMCNi5r4
    wJirSwvemXk_-YUPA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeegiedgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfu
    thgvfhgrnhcuqfdktfgvrghrfdcuoehsohhrvggrrhesfhgrshhtmhgrihhlrdgtohhmqe
    enucggtffrrghtthgvrhhnpeeffeelhfeivdeujeevudehgfduffevhedvkeefudetvdet
    teegveettdektdffheenucffohhmrghinhepshhsthgrthhushdrvhhsrdhithenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsohhrvggrrhes
    fhgrshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:2WGWZF8lNuyf7OX8HJOQm7ELhJ6nrpqww5girSNtpd9-Slp_8rK_yQ>
    <xmx:2WGWZJqvGFMMCGdNmFRxX47aYza3SQL8-7LiqVBfMdXByFGDTTR11w>
    <xmx:2WGWZOrkgjkJZ8uOi3F8zbOrhfJlk8iHKl05vB72hB6jqICvQl7HwA>
    <xmx:2mGWZLAtrgneWuEZDP1trMqnSjWhhyGe3i8cchhtgGLUaAWIWrWs_A>
Feedback-ID: i84414492:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9FAB61700096; Fri, 23 Jun 2023 23:24:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-499-gf27bbf33e2-fm-20230619.001-gf27bbf33
Mime-Version: 1.0
Message-Id: <8f1ba16d-42e3-4e45-9fac-a91b3b0556a8@app.fastmail.com>
In-Reply-To: <1788842.TLkxdtWsSY@diego>
References: <20230228215435.3366914-1-heiko@sntech.de>
 <c01ee919-9abb-4796-9ed4-9bb4565dc863@app.fastmail.com>
 <1961474.usQuhbGJ8B@diego> <1788842.TLkxdtWsSY@diego>
Date:   Fri, 23 Jun 2023 23:23:11 -0400
From:   "Stefan O'Rear" <sorear@fastmail.com>
To:     "Heiko Stuebner" <heiko@sntech.de>,
        "Palmer Dabbelt" <palmer@dabbelt.com>
Cc:     linux-riscv@lists.infradead.org, samuel@sholland.org,
        guoren@kernel.org, christoph.muellner@vrull.eu,
        conor.dooley@microchip.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 2/2] RISC-V: add T-Head vector errata handling
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023, at 7:26 PM, Heiko St=C3=BCbner wrote:
> Am Freitag, 23. Juni 2023, 12:22:35 CEST schrieb Heiko St=C3=BCbner:
>> Am Freitag, 23. Juni 2023, 05:06:44 CEST schrieb Stefan O'Rear:
>> > On Thu, Jun 22, 2023, at 4:35 PM, Heiko St=C3=BCbner wrote:
>> > > Am Donnerstag, 22. Juni 2023, 20:58:37 CEST schrieb Stefan O'Rear:
>> > >> Are you aware of "3.7. Vector Fixed-Point Fields in fcsr" in
>> > >> riscv-v-spec-0.7.1.pdf?
>> > >
>> > > oh wow, thanks a lot for that pointer, now I understand your conc=
ern.
>> > >
>> > > So in vector-0.7.1 fcsr[10:9] mirrors vxrm and fcsr[8] mirrors vx=
sat.
>> > >
>> > >
>> > > On a positive note, the T-Head cores seem to not implement the fu=
ll
>> > > vector 0.7.1 specification after all, in the documentation I have=
 [0]
>> > > fcsr[31:8] are declared as "0" and uppermost bits are [7:5] for t=
he "frm"
>> > > field.
>> >=20
>> > Given that the pdf you linked does not mention any vector CSRs, I a=
m not
>> > confident that it provides a complete and accurate description of v=
ector
>> > functionality in other registers for the C906 with vector extension.
>> >=20
>> > Assuming that you have access to such a chip, I would be much happi=
er with
>> > the proposed "just a comment" approach if our understanding of the =
behavior
>> > were confirmed on hardware (specifically: csr_write(CSR_FCSR, 0x700=
) should
>> > not affect csr_read(CSR_VXRM) or csr_read(CSR_VXSAT)).
>>=20
>> For one, you're right that I should definitly try to confirm this on =
hardware :-) .
>
> ok, so now I know the documentation is wrong.
>
> 	before, vxrm 0x0, vxsat 0x0
> writing the 0x700 to fcsr
> 	after, vxrm 0x3, vxsat 0x1
>
> Essentially the link between the CSRs really is there - oh fun.
> So we're back at your original concern - sadly.
>
> I guess I need to figure out how to not have this stuff break
> because relying on the fpu parts to handle feels not correct
> at first glance.

I don't see a conceptual problem here.

There are a large number of vector instructions that access the floating=
 point
state (frm, fflags, f{0..31}).  These instructions require a valid float=
ing
point context, sstatus.FS>0, trap if sstatus.FS=3D0, and set sstatus.FS=3D=
3 if they
change anything.  vfadd, vfsub, vfmul, vfdiv, vfmv, etc, etc in both 0.7=
.1 and 1.0.

0.7.1 extends the floating point state to include vxrm and vxsat and add=
s vaaddu,
vnclip, vsmul, etc to the list of instructions which access both floatin=
g point and
vector state.  This breaks floating-point emulation (if a core provides =
integer
vectors in hardware, it provides a fcsr register with three writeable bi=
ts, which
means that accesses to fcsr won't trap and can't be emulated to provide =
access to
the software frm and fflags), which is probably why the behavior was cha=
nged in 1.0,
but is otherwise internally consistent.

You can continue to treat "fpu parts" and "vector parts" as independent =
as long as
you recognize vxrm and vxsat as _exclusively_ owned by the "fpu parts".

Access to vxrm and vxsat should be exclusively controlled by sstatus.FS =
since they
are aliases for fields in fcsr, while access to vstart/vtype/vlen should=
 be
exclusively controlled by sstatus.VS.  It would be good to test this, si=
nce it's not
actually in the spec (risc-v has a rather systematic underspecification =
problem),
and T-Head's idea of obviously correct behavior may differ from mine.

1.0 puts vxrm and vxsat into the vector state, controlled by sstatus.VS;=
 vsmul now
works on the vector state only, so as far as state management is concern=
ed it now
acts like vadd and not like vfadd.  This is also internally consistent, =
but vxcsr
must be owned by whoever manages sstatus.VS.

It's a little bit weird to say "vxrm and vxsat live in different parts o=
f the kernel
state depending on V extension version" but it might be less weird to sa=
y "fcsr and
all its parts lives somewhere, vxcsr and all its parts lives somewhere e=
lse,
vxcsr doesn't exist in 0.7.1".  Is this adequate?

-s

>
> Heiko
